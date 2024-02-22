Return-Path: <linux-kernel+bounces-76340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E9285F5D2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C525E1C23CFD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88EE3F8E2;
	Thu, 22 Feb 2024 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LV1GeIOZ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9122B9BF;
	Thu, 22 Feb 2024 10:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597975; cv=none; b=Uu+7C9OOu5SrElmp/QN9hPk/dkLkyQUHaPL8tiVWBkwipq8OmPvYa+QJqPp6JueVilzi0km8jY98esRWGcw6QwtIisR//4NLMWuuxHZMUeU2iRojAEaQRYQfvNOSuYdxuDjU/djLIl4UgZvvpcXKo3VLbGFl8FLuoQ52hE8SoOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597975; c=relaxed/simple;
	bh=6L0afqIOsmwpEHFS9IsaO2CnmQyujeOKiZrRiHM4MPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhViI4a1naM3ioSKtXJQqg1RpeJoWgBp6QHTGxyPIsy/EQLqWN2RbLsMfhnBBKZOCQZALK0zPSul9fJiLtziof6/Yf0dGMxvTxdVPuklFZOCWEG7NTZISkuDGtkods05KHfk5CCfoWyCRuckjMM99cjYaXyZRwaZ7Y5TFsJ7Gbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LV1GeIOZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dbf1fe91fcso37516075ad.3;
        Thu, 22 Feb 2024 02:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708597973; x=1709202773; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=gvUtjoEiMbaMjjQsWm/PxDiJhcRxG9+5kSB7pyn9Zc8=;
        b=LV1GeIOZd7xJyRhUBhE7TvJkpWAauomLSG0LO+IR6NTSVPNhu5S3a4giexOPVQnQHV
         fu/aY/oFKmuTrkif0vk/B5Tkqf+EbfK3hm3KTWjxg9t1beTNPFrk6/aFd8r5FeOHzCIQ
         IlmL+hEc3tkXSJegg/Vcsw/2a4vQruEv8yCT3fxop2RknrlG1mMWxWTn3p+ZVPldEUBJ
         kGhaS69P5qYEPXxZa1erqyG3F3B/Lc3u9qo2G4tCtcD2NDagYHSYn2on7MdHbdFvgiAu
         jCt9dacaoqLR6XqW8gpwsx2HW4QeXk9y8i942ZKYfG2IQR7DqAmbBzdxF6EeJEAA0bbH
         +fNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708597973; x=1709202773;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvUtjoEiMbaMjjQsWm/PxDiJhcRxG9+5kSB7pyn9Zc8=;
        b=Cn4f9NI7JxJnNSPbOio7o7AyX5de64Z/BlAHl4tb2FJ8pnxKuZGRd3mT+a2QH2tRGJ
         hdzIhpltMn836dovCqnXR4zMNFt9lUv6hPTaNBWs5OSGunGVMnyByVzMvdmgr3wB11vC
         kBuq360K8veio/x9fp+y6Bt6CL/sMP5ePpHdvayv9UqAX5PH73u+vZy1UtmI6CSs+By7
         /zNXtVASNiIC1S3VImSzfMCTuf69I2wNMOUKqe4AZy+pGV8bQq+xmz/IZ9zQpiI5TdQi
         TbQK4/ob/EEHite5ihsrYX7CstZWuWwF/fnCqs5C7ISjOhjrVckUF1ZM3wnpn70R3kjM
         /2Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUrv12XVII5acmesYyChhx9AKQG97ocF0EJzyQ9MKxKF4oLyFsPcTQshdSppdiOimnW3a+KwUCJmGlFTKN6BgkHJ5sks0jLIDv/Xbyelcl7wdc9zKQkig5MtEMjPahjgEXNTz8bzAXPAlZ1yIckQ+v73liv3Fh32GNAC0ZMmCI+Bf780Ymb4dL/Yj2FJQgN
X-Gm-Message-State: AOJu0YyzK6BNtQahHW3hUAYYpGimhPwzMlOMn0xBB61acnKgH4sXb+7q
	Iidh+r8qagnaFGAvxZWH3/ayfiG8gf2paXlIFRSeZfKfqSu1+zp1
X-Google-Smtp-Source: AGHT+IFfzeiLNUj8xP10DdkfaSpfVphdprpMnrJr9Uks7lYKIkXF4DVORQBMa/Z4V2+0sKnP1Jn3jg==
X-Received: by 2002:a17:902:dac9:b0:1dc:1557:1359 with SMTP id q9-20020a170902dac900b001dc15571359mr9278576plx.55.1708597972817;
        Thu, 22 Feb 2024 02:32:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jg13-20020a17090326cd00b001c407fac227sm9600662plb.41.2024.02.22.02.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 02:32:52 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cb11ea75-089d-45df-b658-67f0769d7b1a@roeck-us.net>
Date: Thu, 22 Feb 2024 02:32:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add wmi driver support for Casper Excalibur laptops.
Content-Language: en-US
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 =?UTF-8?Q?Mustafa_Ek=C5=9Fi?= <mustafa.eskieksi@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
 jdelvare@suse.com, Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>
References: <20240221221549.640515-1-mustafa.eskieksi@gmail.com>
 <2716dc6e-d091-f61c-7f77-a87215adfe19@linux.intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2716dc6e-d091-f61c-7f77-a87215adfe19@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/22/24 01:48, Ilpo Järvinen wrote:
> Hi,
> 
> Added LED subsys people, please include them in future versions
> automatically.
> 

A MAINTAINERS entry such as

K:      (devm_)?led_(classdev|trigger)_(un)?register(|_ext|_simple)

might be useful if subsystem maintainers want to be informed
if the subsystem is used outside its normal locations.

Guenter


