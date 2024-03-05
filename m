Return-Path: <linux-kernel+bounces-92482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FF887210B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250551C22361
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE3C8613C;
	Tue,  5 Mar 2024 14:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KXtXq0yf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A84A5676A;
	Tue,  5 Mar 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647294; cv=none; b=FgKrXV04Xz9QZz6HB+rTm/+zpP94HKrqgkgPVJDVu/RvMn4aNnuahptAgybvLPQNaWGjBPcji2uv1oJAC5bgWY2i4XQ3OjxdwXsZ00u25pSNeXR0fz0g/LgW+cIHTt/6O4SdqcY8V1bOmmFw72zoqENucfSwFhy767L50t5QBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647294; c=relaxed/simple;
	bh=G0s0y1SdsCAYDnqWsyUbsq+7oziJf8TlqbEiXNgXEcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zhb04QafDtSLYSS8Kt6g+Jx+WmpoR7UhLafp5uhybN68fcGaL0K+Gmf/F1SAjkUFMgyj+jzUyZiHAGEEUNjmqGne4fHDhIaiOTVTpR5TQmKpz1sQPBxvxxIJX/+bHf3cd9HcqGg/xbvkaVHD29LvIOq3fY4bRDiy8mEb9QQf//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KXtXq0yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78DEEC433F1;
	Tue,  5 Mar 2024 14:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709647293;
	bh=G0s0y1SdsCAYDnqWsyUbsq+7oziJf8TlqbEiXNgXEcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KXtXq0yfaadh3yFy5kaqdejawJS3GojDztfP7Se1+pxs6wewALVkIV+T915MpPnTi
	 LO6U7dO2HpldWhDK6XORciKbqO/8yB40LRETyI3iBJpikCmFgfaS3Q8LacWBfDPrGQ
	 CZO6xxQf/NMvRE5soZyOJVvxmxpb3THEijQWdJgM=
Date: Tue, 5 Mar 2024 14:01:31 +0000
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Samuel Kayode <samkay014@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: rename function deGetTransparency()
Message-ID: <2024030505-luxurious-stung-4905@gregkh>
References: <ZdiyhAwNTPmbS3E0@Wayne>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdiyhAwNTPmbS3E0@Wayne>

On Fri, Feb 23, 2024 at 10:58:12AM -0400, Samuel Kayode wrote:
> Rename function deGetTransparency to de_get_transparency to fix
> checkpatch warning Avoid CamelCase.
> 
> Signed-off-by: Samuel Kayode <samkay014@gmail.com>
> ---
>  drivers/staging/sm750fb/sm750_accel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
> index 44b9e3fe3a41..ad9d8bd34e5a 100644
> --- a/drivers/staging/sm750fb/sm750_accel.c
> +++ b/drivers/staging/sm750fb/sm750_accel.c
> @@ -284,7 +284,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
>  	return 0;
>  }
>  
> -static unsigned int deGetTransparency(struct lynx_accel *accel)
> +static unsigned int de_get_transparency(struct lynx_accel *accel)

What does "de_" here mean?  Why did you keep it?

thanks,

greg k-h

