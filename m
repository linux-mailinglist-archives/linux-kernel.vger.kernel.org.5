Return-Path: <linux-kernel+bounces-66613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 929F3855F24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B95DB298DC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D305B69E12;
	Thu, 15 Feb 2024 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="COiRahy0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41A669951;
	Thu, 15 Feb 2024 10:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707992093; cv=none; b=RzNcUG8LAKDjzQ3jvrvVQE7AYRAa9Tric9sx2tAqYzZjpYSwPNyCq629p6b37Dwgyt049h68SG5NNJTXJMuQbK1qRp0sqehLoEEHvielxQMT8loXH/pLWuta3wm+9LDSD3jWZ8y02qy1TW6L/il10d9FV6cpaREdYKkjBz/9nm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707992093; c=relaxed/simple;
	bh=AAaf7HU4oAiDvmTgBeNmZT7365DHcQ1hHRUGYlcpDdI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iy91yJU12aofM2OOk7ATKKwpMWNxWADzN8Yt+LYDrPs+n74+Y9BFNh7lLNCdxukIjLop7RRpFqKxaVOMlejl3JruRBOCLA4zrf7n7mIMdpHINaDWcR9EzSycvfwEKi0Qp16saBrJ6UMXk6r2oWhXwTsEXyWwnnLcn+Bfb8pPYXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=COiRahy0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F79C433F1;
	Thu, 15 Feb 2024 10:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707992092;
	bh=AAaf7HU4oAiDvmTgBeNmZT7365DHcQ1hHRUGYlcpDdI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COiRahy0TvzZdiT9aOPJ0J+j0dBNhczRxoeHAqlqRQdsDiRj5Vv1Ui7GfAzEUfsTI
	 vipOGjHz2KSWF/2yniG06X/fnLlhxTEj8rTkRI/evDCxi3INQrOMrBoXK33E+BHrdl
	 zyoyhGXFS+G/Cun28IEdnCrF32OL3JGQoRgddKZw=
Date: Thu, 15 Feb 2024 11:14:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pairman Guo <pairmanxlr@gmail.com>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USBIP: Use fallthrough pseudo-keyword
Message-ID: <2024021516-chapter-willed-ccf3@gregkh>
References: <20240215092630.148917-1-pairmanxlr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215092630.148917-1-pairmanxlr@gmail.com>

On Thu, Feb 15, 2024 at 05:26:30PM +0800, Pairman Guo wrote:
> Hi maintainers,
> 
> There is a usage of ``/* FALLTHRU */`` in a switch statement in main()
> that have long been untouched. This patch replaced it with the
> better and proper pseudo-keyword ``fallthrough;``.
> 
> Please merge if it is the case. Thank you in advance.

This is not needed in a changelog text.

> Signed-off-by: Pairman Guo <pairmanxlr@gmail.com>
> ---
>  tools/usb/usbip/src/usbip.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/usb/usbip/src/usbip.c b/tools/usb/usbip/src/usbip.c
> index f7c7220d9..ddcafb5c7 100644
> --- a/tools/usb/usbip/src/usbip.c
> +++ b/tools/usb/usbip/src/usbip.c
> @@ -165,7 +165,7 @@ int main(int argc, char *argv[])
>  		case '?':
>  			printf("usbip: invalid option\n");
>  			/* Terminate after printing error */
> -			/* FALLTHRU */
> +			fallthrough;

Did you compile this?  This is userspace code, and as-such, I don't
think it has this keyword, does it?

thanks,

greg k-h

