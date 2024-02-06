Return-Path: <linux-kernel+bounces-54334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F4A84ADC8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9381C228A5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF6078B41;
	Tue,  6 Feb 2024 05:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wuk8tsHK"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFBE7C091;
	Tue,  6 Feb 2024 05:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196144; cv=none; b=LxTIuh7zvrEp4TpBcVJ5Rr9elYxHkkgFgTtbPar0aDhwQHFij5BfTHf+t1qzb8b/wG3L57YMphqQaCrQcXZy8PZGZx2HZq42DfQ1Ek9aCRCE0ZA86xINncC1M9TTdx3CMJNNwub7AF7Ht4X61nIVbHpA7+4vD//0sTAGOpPAI3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196144; c=relaxed/simple;
	bh=ZTT5m/IX3TNbZOaxSQ+tLxdE8fI1k0j4w+WcQjlHf2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/GuijQOEmLYfx0dw5rKCfVJpkBnAxUHmduOzHcziHlzKlXiPk60mogz5V57eeIbMpA8w1wsc2D1s0toy6T0ZQnAU6gTs69oIysqE5gADHNZpNNC7+mnWxLThr9CbFG3zYhJzySVgyPrT1t3aS8lLyMgPYTiP9iUG3KNR1GOhQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wuk8tsHK; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-296c58a11d0so358385a91.3;
        Mon, 05 Feb 2024 21:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196141; x=1707800941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BuUyVlhbTFHxTO6HW8puQbBLaQR24GM9REYAp5aa2Eo=;
        b=Wuk8tsHKxw9XoHg0cigJMu7i1hFY8DbV1dHV6jvKy3H9CKIG+LP0QwhJCE6fiRNmh4
         A037gaQQsgj4itcpySRgjgIvLqz5bxKvHvvDW62CjXUrB1jc1l+vJGIChqOHEBanZOnL
         kGQrwBAU+FFT18H8SN80aMQMjP2S6U07gM+0WiBa//DIUon3i5o47DLqUIW1aTJS713Y
         LdNSBTBPAXHst/BIS9CzRMz+DVa/fl6BKHX849ZveoZ/YFwALoFxaDAjG96WGTzVj8tB
         tNsZCCL3cpngfoDZc4T5B85zD/XcOWCRsjK/s6iUAt054cx4Tw3KJmG3TxoCJM2Zrb0o
         rQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196142; x=1707800942;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BuUyVlhbTFHxTO6HW8puQbBLaQR24GM9REYAp5aa2Eo=;
        b=qby+i/s/vcZ8h4ZaEva1YWzi9D6WOdsYxiZMmdMA5d0+9opXXrT2T4g7N5QYRg6nRX
         0NvcLNZwqXyYQNG/heHbWOaMNyzHW8fmL8Q6G6kpvCDBVEgefLpnZebrxIne98i+2Fxz
         xPeTQQL1Y1FibPEuD9oHVagbAdIY2Tiwxx9stbGCjmC4hAsI5eMAK4IHyhoJMQMyhGqj
         Krk/xmIDdJpNxuhv03reXO3LoSnNQvD5/vOXURNqxb5SYwVMGhde+6L5gnhp2X6dUkix
         wKEc9dqb1bLkXg6w4rzFjhr4Lf/hNLQvfP+o6EFvzt7/TSGUMsl0v6QbkBfZQTURVLG6
         Pt4A==
X-Gm-Message-State: AOJu0YyoVjXZKVBSyk6YMEIYI37R+yNZ+u43yIJBaV0loGemVebeDjuE
	RdAJO/bUk2RbinvTlzUKz0yfxedhoDchlDNJvYYRuOE2OFv8ytTa
X-Google-Smtp-Source: AGHT+IEFGg/WBad1bpM9KSiaeLqhsLZxafZH/XxyBel3KUNMY1m4GdbiZf/eu9e21OqkD0PYBpTHqg==
X-Received: by 2002:a05:6a20:2c91:b0:19c:a696:32c8 with SMTP id g17-20020a056a202c9100b0019ca69632c8mr360860pzj.41.1707196141634;
        Mon, 05 Feb 2024 21:09:01 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXmGTTqpcnu8NICbLtMoSDt8orL7iH6xeIaLPFiN1/lpO3pznHqyYIvZ5ODGuXvlXBKdHvCSWb4htm/YwQZV7TmiXS6qRU+NnzNV0qVCwB32H+rm+r+gSZjVpnhTz88O4PZLDlK9cfoSZ4yhsdchqhO94R1C6b10NJnFjj4L9M3TA571U2dA44rfhpT2ksp3DMgSjEp0I3pD6JwMbmFig+e9wbGpiZG9uNsiBkhJD7RDDSNxepc00f/9Kx6qA==
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ji9-20020a170903324900b001d5b93560c3sm806775plb.167.2024.02.05.21.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 21:09:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <44a3a06e-646e-4f76-b4a4-73906e22595b@roeck-us.net>
Date: Mon, 5 Feb 2024 21:08:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Feb 5 [drivers/hwmon/surface_fan.ko]
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-hwmon@vger.kernel.org, Maximilian Luz <luzmaximilian@gmail.com>,
 Ivor Wanders <ivor@iwanders.net>, Jean Delvare <jdelvare@suse.com>
References: <20240205162653.32ca0d08@canb.auug.org.au>
 <15794bc3-7c6c-45f7-95da-a18f3d45834b@infradead.org>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <15794bc3-7c6c-45f7-95da-a18f3d45834b@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/5/24 20:11, Randy Dunlap wrote:
> 
> 
> On 2/4/24 21:26, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20240202:
>>
> 
> on i386:
> 
> ERROR: modpost: "__ssam_device_driver_register" [drivers/hwmon/surface_fan.ko] undefined!
> ERROR: modpost: "ssam_device_driver_unregister" [drivers/hwmon/surface_fan.ko] undefined!
> 
> 
> Full randconfig file is attached.
> 

Should (hopefully) be fixed in next-20240206. Sorry, the dependencies are
a bit more complicated than I expected.

Guenter


