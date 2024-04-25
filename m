Return-Path: <linux-kernel+bounces-158078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805DC8B1B26
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2BF81C2113B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B557D5A11D;
	Thu, 25 Apr 2024 06:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="a4+367cX"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CFB241757;
	Thu, 25 Apr 2024 06:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027079; cv=none; b=kyt+FmDjEfS6L9/nX/B+gSAdfa2MyzLoqJG0j78XuzthLpwJV3xApeDdjMnIMcskvEip/EuvdA++iJlQBlkQDoDhK2KmLuN1a6KGKeCVmghWb3YCf/zFHz+n8kSe0uJsu6qKquc0u0sF9yIKZdudHNSCL+q/bnm8DixK0zhhQr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027079; c=relaxed/simple;
	bh=v5UhDezQrgaGxA0azv+XR1T5U+isFYlYg3qnj+sRLIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J65kbYsBFK6JppCNv6z0oHwE2OB17YoVwTwiS+nzmGj54dkcGLZmTOXr/ZxOhRh2NOLmib2Rxk1cI6nNaf2KyJmbjV6z2BW9NZzYcJW/CNmXK068Af1EbLHxy3FU3PhqGLGLyopd+qrkHWsX3Uyl7khYaTMiyr0Rye7vViUNRqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=a4+367cX; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.106] (unknown [103.86.18.137])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3C2F5674;
	Thu, 25 Apr 2024 08:37:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1714027022;
	bh=v5UhDezQrgaGxA0azv+XR1T5U+isFYlYg3qnj+sRLIg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a4+367cXIUj7G5UbHNKAqmBQPJvdLaZTBgNhBDt2Ec9G3MZ5QN4QbA2z6+zhpFOSS
	 h423/e88mmhRpn2FYNn3SN+moslUy4VtdtgkWbdSoTpo/g86BzViGGUoYYiHfNYgw+
	 pMvDL5oP883DpO4CHKc3XqnsYw1XYt3tiLDU3jto=
Message-ID: <9cd4919c-657e-4533-8f11-521d31e60123@ideasonboard.com>
Date: Thu, 25 Apr 2024 12:07:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vc04_services: Delete unnecessary NULL check
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stefan Wahren <wahrenst@gmx.net>, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <526ec2ff-6277-4d5d-b2d9-63b087a97c7c@moroto.mountain>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <526ec2ff-6277-4d5d-b2d9-63b087a97c7c@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

HI Dan,

Thank you for the patch

On 24/04/24 5:13 pm, Dan Carpenter wrote:
> The "state" pointer points to an offset in the middle of the "mgmt"
> struct so it can't possibly be NULL.  And also we dereferenced it on the
> line before.  So this NULL check is pointless.  Delete it.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>   .../staging/vc04_services/interface/vchiq_arm/vchiq_dev.c    | 5 -----
>   1 file changed, 5 deletions(-)
>
> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> index 9fe35864936c..3c63347d2d08 100644
> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_dev.c
> @@ -1170,11 +1170,6 @@ static int vchiq_open(struct inode *inode, struct file *file)
>   
>   	dev_dbg(state->dev, "arm: vchiq open\n");
>   
> -	if (!state) {
> -		dev_err(state->dev, "arm: vchiq has no connection to VideoCore\n");
> -		return -ENOTCONN;
> -	}
> -
>   	instance = kzalloc(sizeof(*instance), GFP_KERNEL);
>   	if (!instance)
>   		return -ENOMEM;


