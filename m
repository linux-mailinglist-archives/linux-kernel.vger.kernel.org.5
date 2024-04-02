Return-Path: <linux-kernel+bounces-128239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAFB89582A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FF2B234A3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1965F131720;
	Tue,  2 Apr 2024 15:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="hJdsK2Kr"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A70185262;
	Tue,  2 Apr 2024 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071734; cv=none; b=NkDZQXJgBfYJF3sgdqcjWue4lYHLeKXdmlZMD51Orv7GdlRWcrymtFPHSkuGewL8Lr3D39WxCVhGmv8FuL1xJLp7FiUzcfz8DpvKkzuHqSBOm9Ec6TL4WsO+bHMJU4KTbLuFN3Ir9XUYr7vIrWIOayIMfrEWgEBqCs/QihSTFfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071734; c=relaxed/simple;
	bh=7NDnkfIZ/ENxEybqLTj4oHT4nmKl5yX7hZHDQtYiweM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RVoT92YtYIlAXDp5UzBaZ2H+Ct+66hhS3QApOO4iR9epTOO9d/qW81aOhrZCHTb883YMlBvvKnenKVTHP4Kmk9OeRA/rkr6P1WB5eALpdMtCk9XGHbtd2ZTjcc9Uhh4a04OwOYNwO1w7YZnlfE7fDS4rSrjyrPV1RN79RZp3cLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=hJdsK2Kr; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 31D3447C34
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1712071732; bh=tsXnsiLJzqqLV0fjDegCwG4Sc9b/2WIwZUvbMTaIfQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hJdsK2KrGOU+DlAN2MQPcoHi4yaob9QGznzvGVLPfF4H64kiF+KlgH1PIQmrx8D8t
	 fhn47IsaBnD0D5eYnuVtU+VZLHE1np62+eI3nMYBessPfMXMOBHx0pGuKE7+pPc00L
	 cy63ZUslMcjM9D42effuc0HoZ9RfMSx/YaHW38VoymphIuOw2ekj500Qf61VAXMfuV
	 BeLpbxj5jDnuLCcWkfLwm4a0BPtFZZDSUZ048liRbAjlOHlNLVs8/uvXts6mTErZsj
	 AeA3cvYVVN8N5S7giSpeK3tNFhVSFyW73ovZOqgPEag9iDkkAXCElHOdRmaaxxiTC9
	 nUP3yL0w6wZeA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 31D3447C34;
	Tue,  2 Apr 2024 15:28:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Li Hua <lihua@email.com>, mchehab@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Li Hua
 <lihua@email.com>
Subject: Re: [PATCH]  scripts/sphinx-pre-install: fix Arch xelatex dependency
In-Reply-To: <20240326104515.40346-1-lihua@email.com>
References: <20240326104515.40346-1-lihua@email.com>
Date: Tue, 02 Apr 2024 09:28:51 -0600
Message-ID: <87y19vwzpo.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li Hua <lihua@email.com> writes:

> On Arch Linux, xelatex is installed in the texlive-xetex package.
>
> Signed-off-by: Li Hua <lihua@email.com>
> ---
>  scripts/sphinx-pre-install | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
> index 4c781617f..c559e43b2 100755
> --- a/scripts/sphinx-pre-install
> +++ b/scripts/sphinx-pre-install
> @@ -560,7 +560,7 @@ sub give_arch_linux_hints()
>  		"virtualenv"		=> "python-virtualenv",
>  		"dot"			=> "graphviz",
>  		"convert"		=> "imagemagick",
> -		"xelatex"		=> "texlive-bin",
> +		"xelatex"		=> "texlive-xetex",
>  		"latexmk"		=> "texlive-core",
>  		"rsvg-convert"		=> "extra/librsvg",
>  	);

This email shows as having been copied to the mailing lists, but does
not appear to have actually arrived there.  It's trivial, so I'll apply
it anyway, but you will want to get a handle on what is keeping your
emails off the lists.

Thanks,

jon

