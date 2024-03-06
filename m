Return-Path: <linux-kernel+bounces-93361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22695872E84
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 06:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E193B21E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678891BDCD;
	Wed,  6 Mar 2024 05:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFpiS2x7"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68546101D5;
	Wed,  6 Mar 2024 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709704553; cv=none; b=ffNL7qqMSb2Th8nvLrgYLhRVT/FKgk9czR6K3dx//C+L/xnAjIvrKzTjj9J1I9/552qEA0m67J4Bz3ljH3Hql28gE3QdG1rBP9B59zj9UtHIU6Vb+oPyZ5VhompT7MC6CoCw4Nze0HslfCG4sg7vvPZ/kqmte55GEIIMnWLfp7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709704553; c=relaxed/simple;
	bh=1nKrABTRoU+MKWORhnYwDWjWdyawn4OhcckXxBxBUcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=We7L0teiMUaJlgl0k8yyGkarY+rCbKMFxJwxcVJ5b7SzSLdso1bxGtCwpPRHEREl5313rfkhFNTpmwAKP3X24ZOpZHU4AnxhGeOyQ+7WftEa94G+1JUTKf+sw3QpjrFYaat860Sek5ogXg8aKlA+Na9CzmZyfmv2fN90b/NVYGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFpiS2x7; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e125818649so3410166a34.1;
        Tue, 05 Mar 2024 21:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709704550; x=1710309350; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dx1jE1gaqZrgJzBrRAP1E24RTs8aEqcnfR+g0RoWRwQ=;
        b=JFpiS2x7CFnEEk9wZSZJ6dGehGCLxLZYws3rThpMZyXla9jWI8OwzmQMPdUoUaoRvd
         HtadeY/tXTIFkFqsjkWiA3wner/ivVo5SyyjxKuNcuXD/oJal2v2LD1bZGODVhjE0Ez1
         rM2H+i03OumWcSn2aW5PsbZkCXYSNjxQ/jrO6Lnh8IdeHDV7A2ySIvs6ETaQuzE7yL39
         bvP5PUS0KJ27lrTBHO8mzR+U4mVr7xqX7nHB/AbMb/z0jC3u4c+X2FUqjThK063ZiPtR
         OjHdKFfbAYKK14GhHvnLnG/ykkDCJB1D06No3XBILStHtFA6mjuv/n0IAgQqAkj9eghs
         ViMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709704550; x=1710309350;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dx1jE1gaqZrgJzBrRAP1E24RTs8aEqcnfR+g0RoWRwQ=;
        b=HgmwJOMKKoU1s/u8M+sFbxLbSwtpy/tt6mYXTBpaQrx+vCnhLHV6+Nii9K+oq4rDUs
         EBiZ1uuoiIKFkDYse0wbXs1mRCOL5PNGbWQXxFmu//rNRx6d74XzMo6wnAnyDc9eNLEo
         WJvXLL3HpMdcqlLNOD8YPJF9d/oFgfGCW5NpdVCKNvVwm2TANXssAy+lzXAqsLzO8rjU
         hMyu7+AggjrHJPtPO33GjzTAbAswS4jM0mt/9y1TP+aik2hq048o2/NTcVBomOqOZG0J
         AgBy3y1RwYdtavT9jpLNk6CI8bWUIXaTeAH6cV+cHNawarouNhpWtnREHFvpIXYEoewQ
         07oA==
X-Forwarded-Encrypted: i=1; AJvYcCUuF2chC8GIsNqD9W8127uSpDsMrBrTd7NmLj695/+gkTYragyPc4eA39WOvgLlc5AnoyqEbHjCFRtrtHuYf++/uuZhnwqfDVEGsaiV
X-Gm-Message-State: AOJu0YxdN34rDgeezreqIRKchuiZ/NS0g2s2gskV4glb99VEusgixxkW
	OVpiC/FhDswGrtWzCx+JCCIyYyhHc6q55DDgqS048jRCoxRjygEu
X-Google-Smtp-Source: AGHT+IFSaVN2/1ciLMSQCYUjGaESgrGDtNem6gVF7TELzHzq6kNF8Oq+uQl5YtGMcNOOgDYvwlVIow==
X-Received: by 2002:a9d:68d0:0:b0:6e4:d97e:a786 with SMTP id i16-20020a9d68d0000000b006e4d97ea786mr4506354oto.7.1709704550378;
        Tue, 05 Mar 2024 21:55:50 -0800 (PST)
Received: from [192.168.1.7] ([61.7.133.192])
        by smtp.googlemail.com with ESMTPSA id r21-20020a63d915000000b005d8b89bbf20sm9825379pgg.63.2024.03.05.21.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 21:55:50 -0800 (PST)
Message-ID: <1e63a63e-471c-47fd-80c5-ab6b02540b33@gmail.com>
Date: Wed, 6 Mar 2024 12:55:42 +0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] USB: serial: option: add Fibocom FM135-GL variants
Content-Language: en-US
To: bolan wang <bolan.wang@fibocom.com>, johan@kernel.org,
 gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240306021333.1128448-1-bolan.wang@fibocom.com>
From: Lars Melin <larsm17@gmail.com>
In-Reply-To: <20240306021333.1128448-1-bolan.wang@fibocom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-06 09:13, bolan wang wrote:
> Update the USB serial option driver support for the Fibocom
> FM135-GL
> LTE modules as there are actually several different variants.
> - VID:PID 2cb7:01a1, FM135-GL are laptop M.2 cards (with
> MBIM interfaces for /Linux/Chrome OS)
> - VID:PID 2cb7:0115, FM135-GL for laptop debug M.2 cards(with adb
> interface for /Linux/Chrome OS)
> 
> 0x01a1: mbim
> 0x0115: mbim, diag, at, pipe, adb
> 
> Signed-off-by: bolan wang <bolan.wang@fibocom.com>
> ---
>   drivers/usb/serial/option.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 2ae124c49d44..0981b8d8020c 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -2267,7 +2267,9 @@ static const struct usb_device_id option_ids[] = {
>   	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0xff, 0x30) },	/* Fibocom FG150 Diag */
>   	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x010b, 0xff, 0, 0) },		/* Fibocom FG150 AT */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0111, 0xff) },			/* Fibocom FM160 (MBIM mode) */
> +	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0115, 0xff) },			/* Fibocom FM135 (laptop MBIM) */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a0, 0xff) },			/* Fibocom NL668-AM/NL652-EU (laptop MBIM) */
> +	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a1, 0xff) },			/* Fibocom FM135-GL (MBIM mode) */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a2, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a3, 0xff) },			/* Fibocom FM101-GL (laptop MBIM) */
>   	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x01a4, 0xff),			/* Fibocom FM101-GL (laptop MBIM) */

If the device with pid 0x01a1 only has an mbim interface as you have 
indicated then why do you add it to the option serial driver?

thanks
Lars

