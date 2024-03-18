Return-Path: <linux-kernel+bounces-105887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFBC87E5E9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:37:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2762DB21EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6DF2C1BA;
	Mon, 18 Mar 2024 09:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="s6zNGzY2"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6558B24205;
	Mon, 18 Mar 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710754632; cv=none; b=h/2Mf1tPfUr9icp1AxTvx+ggUUzwZABCPsHvhFk73dU2HrU8/XybQu2ZrcL3GSzDPGqTuzvejA5zEuvvwMWgrqV8lFGufuF4oJ8h9v9Wh/caQa0en1rnmAUIj5OXzcqdS+6fLQSQ7AgRVGtvP/1Acwj7fmpqISXgC4nywiXYO6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710754632; c=relaxed/simple;
	bh=ZiieLfjYSYEVm2dvZu9e4m9zYigPwEaH2Ww5bP+SqRQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=axENVe5RKFWx0C66GLjXbhABmoj/7PQC2G6OhvKlvzQ1f+VCUvzW2T+yoel5LAThhBwfcKPRUOcIjN46h4clUrOMqeu8I6syzp+nBOFNHX2NXbBOBgviEuUi11mejT96zqeE2J9GdDy7R9vvaieMU02hRG03fkvwhYnlAsfJhyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=s6zNGzY2; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D3EBF418C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1710754623; bh=C4zj77Qsk4cokiSq3CfqNF304HPfOGZcezCsgkRVykY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=s6zNGzY2USbfyv+1ttqPUnXammo+pFXdSCKV1BsNVCLMHA+rZB/yejPwhiNJ40eRs
	 WehbTNZTmlBkrcBiOWbXHKmh0xrNIBOmI4A9I1MmOL4AdOGQreTPe7Bnm4iVqwNW/6
	 N0vn+lWpoXFhmxLOBygO/az+JrdoM5j8SDEXu8pQFhe6E8qmTL2oUGfx5FPuBCwXXB
	 1tQkBVV0dUk7eFCV2sZHUffdbvhV+MTUfvzALCxRXqm9b41o+jZsTetEMM5Z4+n0WW
	 kMyOz4+NiMY50uC9QH0l5RbDHjYfEzyFvFM7HfcVPEk9b3klfI96x+dNLyvnSpttza
	 5Io+QkbpGXMvg==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D3EBF418C4;
	Mon, 18 Mar 2024 09:37:02 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Maki Hatano <maki.y.hatano@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Maki Hatano
 <Maki.Y.Hatano@gmail.com>
Subject: Re: [PATCH] README: Fix spelling
In-Reply-To: <20240313100136.20424-1-Maki.Y.Hatano@gmail.com>
References: <20240313100136.20424-1-Maki.Y.Hatano@gmail.com>
Date: Mon, 18 Mar 2024 03:36:59 -0600
Message-ID: <87msqvank4.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maki Hatano <maki.y.hatano@gmail.com> writes:

> - ReStructured Text should be exactly reStructuredText
> - "reStructuredText" is ONE word, not two! according to https://docutils.sourceforge.io/rst.html
>
> Signed-off-by: Maki Hatano <Maki.Y.Hatano@gmail.com>
> ---
>  README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/README b/README
> index 026eff0b8e06..fd903645e6de 100644
> --- a/README
> +++ b/README
> @@ -11,7 +11,7 @@ In order to build the documentation, use ``make htmldocs`` or
>      https://www.kernel.org/doc/html/latest/
>  
>  There are various text files in the Documentation/ subdirectory,
> -several of them using the ReStructured Text markup notation.
> +several of them using the reStructuredText markup notation.
>  

Applied, thanks.

jon

