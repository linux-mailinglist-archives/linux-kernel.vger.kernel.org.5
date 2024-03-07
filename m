Return-Path: <linux-kernel+bounces-95489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 244BE874E3E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3869282DD8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03AA12C52E;
	Thu,  7 Mar 2024 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="kxpcfwwc"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6A81292F3;
	Thu,  7 Mar 2024 11:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709812099; cv=none; b=LwCgzMd8NjG/KqllJX5hBR/BespSuPRmjnxLJWsBVxcAiHhbUwZz4DcWAEwtHh6FYsaV/LImnM6jSGNkxn+DVIrxoRo/pGrCcDAsJSFfEGJ2OxeOEWD7ASMBGdOw8zDc0NVz7WVFMvsXAC8XfuiuvJTYlLUbRoPJigTU0uALizU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709812099; c=relaxed/simple;
	bh=+NFhUoHsm1k3teppr6MH5QMBv/O4fijuunYR0JJDBeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ODBxksG+GVElrncZvE4wN7uHCGRaeFRTt+o8VD5Ho4TsI+Egl1JwoObSsy0fekObJH3RMnAkWL5eRDY1X6GB56Xd8z1wLp1fz4n1Vcqnk4EjtD71DgYCP3ZQ70ggzP/2FmOeoWtnzX9Pd2SoVbH61/X6FnM3nGUgv8VquUI28nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=kxpcfwwc; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 94974419F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1709811617; bh=FmaCOdSpzTDO+fx/nlS5kQLhsJEKyzgeV8XwYx9O5Fc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=kxpcfwwcWbrdGd+gN6hesYJ00BzxZIN9Ni6iL33tmTfDRi7nforCr+yM4PmygA/Z0
	 8FppJ530gOgPnBZQN9X57tbfuJVWRLdbDHy6QzGHjzy3FkiKz24s9WgZHug6pgubOW
	 ncUK9BvvNvoNHp5fE3/fQOMNcqP574GqGuEdj7cYrk7gYtzr8njPrEhdylyVGdgFZy
	 6rd1AbtBpIzveaq+uNRyVqo4j3FuI9qk+NV5zgKdnU79ru/Rlc2koCDagbJep8kzM+
	 HFASYKWAjDBgsy5GVu2bK3Rv+tidIEaRL1ZY6ezccAYAyqa9H7gOAM393IEOtyXGdn
	 bINub1o2LTQ7w==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 94974419F6;
	Thu,  7 Mar 2024 11:40:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: regressions@lists.linux.dev, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>, Petr
 =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Subject: Re: [PATCH v1] docs: verify/bisect: fixes, finetuning, and support
 for Arch
In-Reply-To: <6592c9ef4244faa484b4113f088dbc1beca61015.1709716794.git.linux@leemhuis.info>
References: <6592c9ef4244faa484b4113f088dbc1beca61015.1709716794.git.linux@leemhuis.info>
Date: Thu, 07 Mar 2024 04:40:12 -0700
Message-ID: <87o7bqjmn7.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Assorted changes for the recently added document.
>
> Improvements:
>
> * Add instructions for installing required software on Arch Linux.
>
> Fixes:
>
> * Move a 'git remote add -t master stable [...]' from a totally wrong
>   to the right place.
>
> * Fix two anchors.
>
> * Add two required packages to the openSUSE install instructions.
>
> Fine tuning:
>
> * Improve the reference section about downloading Linux mainline sources
>   to make it more obvious that those are alternatives.
>
> * Include the full instructions for git bundles to ensure the remote
>   gets the right name; that way the text also works stand alone.
>
> * Install ncurses and qt headers for use of menuconfig and xconfig by
>   default, but tell users that they are free to omit them.
>
> * Mention ahead of time which version number are meant as example in
>   commands used during the step-by-step guide.
>
> * Mention that 'kernel-install remove' might do a incomplete job.
>
> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>
> Lo! A quick note reg "mention ahead of time which version numbers are
> meant as example in commands used during the step-by-step guide". I did
> that, as I've seen someone following the guide without replacing the
> version numbers, so pointing this out with a few words seemed wise. But
> I'm not sure if the way I did it was the best; if someone has a better
> idea how to do that, please let me know. Ciao, Thorsten
> ---
>  .../verify-bugs-and-bisect-regressions.rst    | 135 +++++++++++-------
>  1 file changed, 84 insertions(+), 51 deletions(-)

No better ideas...I've applied this, thanks.

jon

