Return-Path: <linux-kernel+bounces-152170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939B18ABA35
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 10:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B1F0281898
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 08:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC9D14A83;
	Sat, 20 Apr 2024 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LL/DJwfF"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C97F9DF;
	Sat, 20 Apr 2024 08:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713600058; cv=none; b=SRPZK1w0Ahn4QrVfjNEJs1WHGS8lq3C0O5Hn/ihtDYf5pkowl3gk1cfNhzqqFX1dW6TOt7CUixjVmMzLAl0J88pOgwUzyGGPpD7bThg67calZ9n9DLT98RRFnHmHyMxsV7QvufjDi0TqE+dU7dbb87fhNhLaj10yDt/E6aGzw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713600058; c=relaxed/simple;
	bh=9W+5et6Duhaa8jDdVcnQR/bEQ3Ehiww5Gs44aP/8ks4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W/8ZWBiS/jzqJ/0hOXcVnxk8jSfXAOs4oOlQmRGXw9tYn0ey+GxOsGsuIGmTVCn5gAHBodJebTDYhpdGNEgBw2IuuArX17Zvb4fT8hr7DxhNdRa8fJUPa7QLkZ+IXbThtGZX3k4K2Asxx58BGion8VF8+QEDLG6lz5zQIWJeczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LL/DJwfF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-419d320b89aso4831735e9.1;
        Sat, 20 Apr 2024 01:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713600055; x=1714204855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3FJTuQLLrIcpyiLjSGB9NaK1B+t4LSbC2liEoLME8Wo=;
        b=LL/DJwfF7PYSDI5fI5NhWr/2PUvTxJqzZ3bo+ScC+Yr67AhjPNkwfryiL72U5vVM9n
         gTePPnIaZM+NWGZGHh7DTGF33onF3zLZ2uoejieg7fG+1tOH5ReLRc4R9dsVqmqoqeRH
         Uy8m8DmJACmNzQg31Br1DL0OOXJdyKeAcK1v/8jDet9m23dCa6NTS5zVkmkdpi3sCWnh
         63bQSAmHWSfzeQpSbmQcqHBTZFddjW8NyQ+MzMuA9AaTNVCn1kQnidnI5bmUc3kvp1k3
         JMtt2syvCFZc6gPBNLypkIfTFJ+pAuY2hgE7Ydvf0L/JPXHMoLajPUFcHA2cAw8ltycL
         gDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713600055; x=1714204855;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FJTuQLLrIcpyiLjSGB9NaK1B+t4LSbC2liEoLME8Wo=;
        b=kCiZEV8cgGz4Punf0TjF6Pwl0AojbLACbWAPPA0IAA6DMMvm6BvSJp6wiee35TULB2
         yKp1wTShPJ6lWnY+fj5TbDxC+xcF0aICmQG03oaH/UN/3qAQZmk1cUiquW33lYl1tHOS
         Do1TdLQK9jkbB2yVu64OksUqoLBzePXR4fA7aZrvwhVEaGwqZDn4l7XMg9r7XMhWUBea
         W4mqvHh8XRuPzIFjQ7RbsgfmEqUMuh9eJKZuwxuBb8+OsqrJPndU+jD2Tpj+kOiE4voV
         jyXGoDA2XU2HZHagwYBMbRlA5GGD2542Nn43AUShbAfW6JH9/O7kBuQbTV8BXuO4B1PY
         ICrA==
X-Forwarded-Encrypted: i=1; AJvYcCVOS8b9JImuzyjc6ZipuPQWyJSQr7XeqLWUqcYXKx8Bv8QnpeNCu8Jl0M/CXHbZ7G0WvjuUB2c6HLNHp6HrVyWrFKO7ZT68SZGuGCHX
X-Gm-Message-State: AOJu0Yz8LwyJG97IcSXsRyO3T5jibTeYy4Ju+LQee75t+2s8Fc5FeuLr
	exlSAkqVpwPlqbdZgjSu5qbZH45hG/OvSMrswp7mtN3r9sy/YscD
X-Google-Smtp-Source: AGHT+IHZPPWKIAQoMBIrcmjGXqx1s0z1HdgyOg4TQQqEIv1dx0DoZHdOuD/VNsg59eNGcHH6Mm9Gig==
X-Received: by 2002:a05:600c:3b94:b0:416:9f45:e639 with SMTP id n20-20020a05600c3b9400b004169f45e639mr2946507wms.20.1713600054732;
        Sat, 20 Apr 2024 01:00:54 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c16c:3b00:e5c2:ab7d:81e1:2621? (dynamic-2a01-0c23-c16c-3b00-e5c2-ab7d-81e1-2621.c23.pool.telefonica.de. [2a01:c23:c16c:3b00:e5c2:ab7d:81e1:2621])
        by smtp.googlemail.com with ESMTPSA id s9-20020a05600c45c900b004163703fd6asm11948336wmo.1.2024.04.20.01.00.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 01:00:54 -0700 (PDT)
Message-ID: <2e81babf-2a69-4b41-9b34-6e8ed742b2c1@gmail.com>
Date: Sat, 20 Apr 2024 10:00:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: phy: update fields of mii_ioctl_data for
 transferring C45 data.
To: renjun wang <renjunw0@foxmail.com>, andrew@lunn.ch, linux@armlinux.org.uk
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <tencent_78F3412B4E523FEC8F19FADAC32475318706@qq.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <tencent_78F3412B4E523FEC8F19FADAC32475318706@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.04.2024 02:41, renjun wang wrote:
> The phy_id is used as u32 type in function mdio_phy_id_is_c45()
> with the 30th bit for distinguishing C22 and C45. The reg_num is
> also used as u32 type in function mdiobus_c45_read() or someplace
> else. For more C45 information needed and data structure alignment
> consideration, change these two fields to __u32 type which can make

What do you mean with alignment consideration?

> user space program transferring clause 45 type information to kernel
> directly.
> 

With this change you break userspace. And in general: If you make
such a change, you should also use it.

> Signed-off-by: renjun wang <renjunw0@foxmail.com>
> ---
>  include/uapi/linux/mii.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/mii.h b/include/uapi/linux/mii.h
> index 39f7c44baf53..68c085b049de 100644
> --- a/include/uapi/linux/mii.h
> +++ b/include/uapi/linux/mii.h
> @@ -176,8 +176,8 @@
>  
>  /* This structure is used in all SIOCxMIIxxx ioctl calls */
>  struct mii_ioctl_data {
> -	__u16		phy_id;
> -	__u16		reg_num;
> +	__u32		phy_id;
> +	__u32		reg_num;
>  	__u16		val_in;
>  	__u16		val_out;
>  };


