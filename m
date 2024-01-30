Return-Path: <linux-kernel+bounces-45309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC90842E56
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC62B2867AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30D0762C4;
	Tue, 30 Jan 2024 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="V63GSi/z"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E828762C9;
	Tue, 30 Jan 2024 21:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648625; cv=none; b=YcrY8ACCRtLbKGKe9wJfO7ThRftg7ZvNHixJHV6Rhizh3O+ttq+afGF0ZH2kvwI9Xtq+12JcRUZe9TvY03AMHQMPpjHmWyp9gpi86mXDdqPhJfP3XetUJLj3GS6qBM+XCNVhsv5TWNecbCd7Bu+3QlVik62m23MpZsgdlri6BKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648625; c=relaxed/simple;
	bh=JRAZHf0aez7fHgKMmEwrAb4y3zuYwdw10+sZLpzx0eo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cbh/ILFPPxsDlrNcaThGgVHLKj2SHEip0A7PyTM0CLgyYiXl2ImYMX/XeUV9m14O3Oh7/LHH0HII1WE8DOIkv8e63RLUfNw50tQZDe6j1/Mx90VcBnqXeVqIVRY7iIpd8+xIofaDX1a1Ni39A0iysFh8J+uXber5OsRJ0fafPbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=V63GSi/z; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CFFF447AAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1706648623; bh=jlbymONYyYcCqv/YNvmte1jsEk92RWydj8O4kkJ1L60=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V63GSi/zUCbaaY4V3APaNDSDy1eCx8IOIvTE2hpCtyXMgDBu65pJqO8ecxQHXLjxi
	 orQbignj4mCITcaLAktMvfMp058YbLAkbUOPPpitsBoLQOGNt02oNV4KEuz74chbvz
	 vdl0F41LdA0izvLAptSOEBmk9y34NX1X7rP1MuifCVqg7K+4wlM+4cnFMqn7EJAgsf
	 UKOOFwBBHosqkOr0oSEUEuFC8VEB0op+SdxtE9nM0ArdYOB7gCwi1yPrKJySfzD1kq
	 T+iMR7o+or38/FMcOSIlQL+sxQy4FG27ap1w3ILVrvr+F6hKvQEVfsY31vVsG3M3mZ
	 Yf2RNRO5NRwqA==
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CFFF447AAB;
	Tue, 30 Jan 2024 21:03:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
 gregkh@linuxfoundation.org
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org
Subject: Re: [PATCH] coding-style: Add guidance to prefer dev_dbg
In-Reply-To: <20240125165311.1.I8d9c88e747e233917e527c7dad1feb8a18f070e2@changeid>
References: <20240125165311.1.I8d9c88e747e233917e527c7dad1feb8a18f070e2@changeid>
Date: Tue, 30 Jan 2024 14:03:42 -0700
Message-ID: <87fryea5zl.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abhishek Pandit-Subedi <abhishekpandit@chromium.org> writes:

> During review, it was suggested that drivers only emit messages when
> something is wrong or it is a debug message. Document this as a formal
> recommendation.
>
> https://lore.kernel.org/linux-usb/2024012525-alienate-frown-916b@gregkh/
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> I'm sending up the change to documentation while this is still fresh.
> Will send an update to checkpatch.pl afterwards.
>
>  Documentation/process/coding-style.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index c48382c6b477..f8ec23fa89bc 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -899,7 +899,8 @@ which you should use to make sure messages are matched to the right device
>  and driver, and are tagged with the right level:  dev_err(), dev_warn(),
>  dev_info(), and so forth.  For messages that aren't associated with a
>  particular device, <linux/printk.h> defines pr_notice(), pr_info(),
> -pr_warn(), pr_err(), etc.
> +pr_warn(), pr_err(), etc. When drivers are working properly they are quiet,
> +so prefer to use dev_dbg/pr_debug unless something is wrong.
>  

Applied, thanks.

jon

