Return-Path: <linux-kernel+bounces-112657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2646B887CA1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 973BBB20E7F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D375017BB4;
	Sun, 24 Mar 2024 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9l23Wcw"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C258179A8;
	Sun, 24 Mar 2024 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711281971; cv=none; b=cVe+07gbwqV6e7QqoBbTpd4kvw3oXiQafSxlkezrRIeeNpS8jpOomUKHdGZxgMwHuc/amzkhBvN8ldKHWrUtX1JgHqKgTM1qigKs6XwRtIT5ybV37eg6cDpemwGC7KIEvdp6yKy+FLCDqlQ2JyMqmaBmWDa0An3iD5MMkJ+up0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711281971; c=relaxed/simple;
	bh=mtf1RDgfBz1CQuj0fSdA/b+qA44E+AI5WneOq3D0Xb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gRiz0iOKc8Milp1q3lo/xIshJfJXqfJ10AWVwaIO2r2wzrWScM21QKLefmURtw5yGtue0t3cFtKJ/ioFtt/7NQMDoi6kRLU7rLcG2ohzbKQYK+PVrpWC1Y4W15+0vAU2ptWc5KXxnFVSx2mibvux421spoGscknLsD+fV3zrLf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9l23Wcw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33ed6097ca0so613302f8f.1;
        Sun, 24 Mar 2024 05:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711281968; x=1711886768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CtYyUSACFde+IBYskgVCX0Wr+Na6g8D8ZvFebNcAS00=;
        b=D9l23Wcwf9mNcOLuswuVDvQu8mIGH08o8exWomqZbeto9ExRLOukfC0X+pXfb2Ewra
         mSk4sE5dOFYFapuyMgSFvFqKb/RDUePi25IUV+QLHuyFmVhj3VPPVBD3Vu0NUocB6sgP
         xyppMgXzb4Qm/xGDCOI3q5UQfqK1/JRPyrjRAVxYV8HsbBthDFWTtW+0ZqEFO/EIsckp
         EwW8Yd3qO9Jri2GlTIB/ZROw4lbcBDFLy5Bi2/ZgtJcOhqbSPvm3cZ2CskX/3z5fLGQ/
         CbudkBCcyJMCzSAqJjBKxeFQvu97SE+Vz+qK61LIyR2TLZvBslU+jF80jKQFO0BYG318
         UjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711281968; x=1711886768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CtYyUSACFde+IBYskgVCX0Wr+Na6g8D8ZvFebNcAS00=;
        b=W5jUuCif/+PL9hZmC6y9hmYrbTPkbOpG/EwvIp/71IwhtBUVLitwihX3jFh6GpznUW
         OHZO0wrJJPOINJBgA3XqQajF5xcpNPWOc9JE2I3bajtU2jmE9CfBI+H+YlOK9qon95pf
         ePLLZWwBlw8rLSPN3siFMTVm966sgxo7hIAGcTVqZkVnostuGgD1QDyIeqbZIGeDIvG/
         4P/QXzPGGAW006mbfJdckanXdxzYE8D6XpOb122Y4FFCNwwMTms4eXlV7WYF2NxCBsUL
         CqF73x+bREEB/iPfhtPBxpfCO0k9qXpSrehnfh86pqZz7EkQycJODuTMohkT/h2i6nXk
         W8QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjcpXXtmABhbxDDbjrfPDNRfuFbQku6Db7rxfAxnIo2jvvzG4BmRzjDEa72u9/gUWLMNCQUs56k1q1mArT4cOmAWPnBVkrFcex7/Ra/rF/bGEPytWebU+Yz6XnGthKva1bVOhwo6RN2H8=
X-Gm-Message-State: AOJu0YypkiaY7FgGrgtdVK1+TI4KXeKDP5sJ5TNe0wfaA+/ww6/ml90e
	bVe7DG0D0G/FOyf9dhuwjIOXkpCnbICN5Nq/qiD6g67NcAE18NH7X7milD6L
X-Google-Smtp-Source: AGHT+IHlXOirsRDZKiAzC3seE+GNVUGaePkht437g4QV4Vul6/RMlMk9xDwrGSXhYmPu2WGx30Ns+w==
X-Received: by 2002:a5d:6708:0:b0:33b:48ed:be63 with SMTP id o8-20020a5d6708000000b0033b48edbe63mr2536678wru.7.1711281967667;
        Sun, 24 Mar 2024 05:06:07 -0700 (PDT)
Received: from [192.168.0.104] (p54a07fa0.dip0.t-ipconnect.de. [84.160.127.160])
        by smtp.gmail.com with ESMTPSA id a1-20020a5d5081000000b0033e91509224sm6666868wrt.22.2024.03.24.05.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Mar 2024 05:06:07 -0700 (PDT)
Message-ID: <11e6d108-e5d9-4c50-8404-766403eb5a5a@gmail.com>
Date: Sun, 24 Mar 2024 13:06:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] staging: media: remove duplicates
Content-Language: en-US
To: coolrrsh@gmail.com, slongerbeam@gmail.com, p.zabel@pengutronix.de,
 mchehab@kernel.org, gregkh@linuxfoundation.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 linux-imx@nxp.com, linux-media@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org
References: <20240324092917.19177-1-coolrrsh@gmail.com>
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240324092917.19177-1-coolrrsh@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/24/24 10:29, coolrrsh@gmail.com wrote:
Hi Rajeshwar,

Please make your "Subject" line more unique. Consider that we may end up
with having dozen of commits like yours, all of them referring to
different removals and all without the necessary information to tell 
what they differ in (except the driver/subsystem). So it would help if 
you add the changed file to make it more unique.

Typically we omit the v1 on the first patch in the subject

> From: Rajeshwar R Shinde <coolrrsh@gmail.com>
This line does not belong here. Please remove it.

> 
> In Kconfig, the kernel configuration VIDEO_DEV is defined twice.
> To prevent doing repeated checks, the redundant code was replaced.
replaced?

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

> Signed-off-by: Rajeshwar R Shinde <coolrrsh@gmail.com>
> 
> ---
>   drivers/staging/media/imx/Kconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/media/imx/Kconfig b/drivers/staging/media/imx/Kconfig
> index 21fd79515042..772f49b1fe52 100644
> --- a/drivers/staging/media/imx/Kconfig
> +++ b/drivers/staging/media/imx/Kconfig
> @@ -4,7 +4,6 @@ config VIDEO_IMX_MEDIA
>   	depends on ARCH_MXC || COMPILE_TEST
>   	depends on HAS_DMA
>   	depends on VIDEO_DEV
> -	depends on VIDEO_DEV
>   	select MEDIA_CONTROLLER
>   	select V4L2_FWNODE
>   	select V4L2_MEM2MEM_DEV


