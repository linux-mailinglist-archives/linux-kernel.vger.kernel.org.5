Return-Path: <linux-kernel+bounces-162701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961388B5F43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8A5F1C215E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FEF85C69;
	Mon, 29 Apr 2024 16:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JbmaZFUJ"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDF385924;
	Mon, 29 Apr 2024 16:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714408843; cv=none; b=hZjdqWzcBqY0IQefFmcqidNSK+iQ8/kXLlH4HkGTG0sskTEs7dxOy4i/vc5G69hMHK1XVSB5e8l1B+izUDOPjCCuYIMoyYEUij+WF+msYjeLmKI8e577uUkuLFN0EtJGq/hjBXBHvQezISqi1DEXS7LKZy0zdej7hqRZoKsr8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714408843; c=relaxed/simple;
	bh=y/JoRti5C/zhiWY4j/apSF+4M4QIGCm1Y/dnb2ZI8zI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghPEBJDnnGyLr6+TDQ7tTxKsF2RWRmXvWC1P1zWShQkDSeiSieh4U8U67E0tO6mnNsSDcsMcI57wcM+kyi5rx6ADJMJOy7KCUXzID6w8XOmpdSJ33X+Oqu/W2CAYkwm5XC91kpximGP6Lwz1yuJt/OA+HWhPv01VlQ4NKAh9E9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JbmaZFUJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f30f69a958so4057035b3a.1;
        Mon, 29 Apr 2024 09:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714408841; x=1715013641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4hAwPIk/J0mbp1JgX2t87eFy3QhJBjBJL9p7CarC7ho=;
        b=JbmaZFUJSYNCeXieOIvaohvoV3tTNas17EdHAYz1rwbujRC72pvdGTsZfZSG0hC/HP
         PDzm5eSbPNoiMX8Ebp6v+0j7ISI9ybgU5vSia+kwMH4qop6R9b1i/YOpSJDrGqIPnnJ7
         MoCzS/U7IpdbKn3Y6E2ciytpkcTP5Z45pjlYRUmOgwE7iLMqiY5TddOFiDFvti3+Q3li
         YY+2Y8iXiMqkDPyqNr8G8dlC0NojwYdOE2AEnWmQicebi5p/oqgXBRNTCGNSCeHaPJ67
         VWOA1/pg9CNUZzJwqPCUY0onOd1l/TyGpE5ZBPU/VUkSkn6QnBXFNrbJjc8CSNEjbjrT
         ciig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714408841; x=1715013641;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hAwPIk/J0mbp1JgX2t87eFy3QhJBjBJL9p7CarC7ho=;
        b=PVe/mUuglgx0ayaovCh3HfN+Z4n1gyB6X2bduCqv07uswyIxr4nN05PD14knjcNuMY
         T7ErXMmlDOxuLp322E4Iq/VXjJOBa+KsuaWb4aAYE7Uvf668043p4lL11WRVU11U8LkC
         AKP5gxkR51RQ1baQd6d8p1arbAtPrULHyp/eKTGOLU1Q2NV6x13mgKUqZjhS8LUdXIPH
         fBcbbA+yZ39fb9e50zLBzu87TWbEgrsXYhyv4/kbdFRAzX5CYVFmg67EwLL9pohjr8Ox
         v6v8yQKRZs49PfyPZ1MVTTL8CwNtV566KByl0pyySgAi5gg1lfIYzO0mhhgOPk3Lk+lg
         D3IA==
X-Forwarded-Encrypted: i=1; AJvYcCUpnyskMWwj9cigLNFUCnqf1FkXY5+P0sTXcukwiq73Ad9HpsNaDyeIohwqLBo43gq5PLKmUa/TqGRYg9HPBX4UGHBCZNae5mEFlEbXeaGwGgjUbTtKWlZxY27cFjOlHJxR7qY4AcZO
X-Gm-Message-State: AOJu0Yy4MTuSL8FS0Hz4DXOTqnHeUc/3IN1cy8r1yGWhfVuR/igolMh1
	8zkFvj7ebOtEO8AjvezgXZH88h/RbyqMEPF4Ffb+0IVvxu97XdvJHTuJeQ==
X-Google-Smtp-Source: AGHT+IFaLePabmDe56sSTqDUTsP0E+y7eUB7rbf8Ei5jEy+kdC65LXelOImCDPIe2HCcKFtb37uSgg==
X-Received: by 2002:a05:6a20:551a:b0:1ad:8109:48f2 with SMTP id ko26-20020a056a20551a00b001ad810948f2mr98505pzb.36.1714408841503;
        Mon, 29 Apr 2024 09:40:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n13-20020a17090ac68d00b002ab68ce865asm20718787pjt.9.2024.04.29.09.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 09:40:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <aff51500-0970-4513-af36-3c4edf38cd31@roeck-us.net>
Date: Mon, 29 Apr 2024 09:40:38 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usb: ohci: Prevent missed ohci interrupts
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Laight <David.Laight@aculab.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <20240429154010.1507366-1-linux@roeck-us.net>
 <2c2ba8df-cdce-4666-8da3-252d4b707239@rowland.harvard.edu>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2c2ba8df-cdce-4666-8da3-252d4b707239@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 09:05, Alan Stern wrote:
> On Mon, Apr 29, 2024 at 08:40:10AM -0700, Guenter Roeck wrote:
>> Testing ohci functionality with qemu's pci-ohci emulation often results
>> in ohci interface stalls, resulting in hung task timeouts.
>>
>> The problem is caused by lost interrupts between the emulation and the
>> Linux kernel code. Additional interrupts raised while the ohci interrupt
>> handler in Linux is running and before the handler clears the interrupt
>> status are not handled. The fix for a similar problem in ehci suggests
>> that the problem is likely caused by edge-triggered MSI interrupts. See
>> commit 0b60557230ad ("usb: ehci: Prevent missed ehci interrupts with
>> edge-triggered MSI") for details.
>>
>> Ensure that the ohci interrupt code handles all pending interrupts before
>> returning to solve the problem.
>>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: David Laight <David.Laight@aculab.com>
>> Cc: stable@vger.kernel.org
>> Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>> v3: Check if any interrupts are pending before reading intrenable
>>      Add 'Cc: stable@vger.kernel.org'
>> v2: Only repeat if the interface is still active
>>
>> Note that I did not apply Alan's Reviewed-by: tag since I was not sure
>> if that was appropriate after the code change.
> 
> I'm not too confident that the guess about all interrupt bits normally
> being off is correct, but in any case the extra test won't hurt.
> 

OHCI_INTR_RHSC and OHCI_INTR_SF are often set but disabled while the system
starts, but afterwards it is mostly 0 during normal operation, i.e., while
there are no interface state changes.

> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Guenter, if you want to work on a patch to cache the interrupt-enable
> value in the driver, feel free to do it.  I have too much other stuff
> going on to spend any significant time on ohci-hcd.
> 

Unfortunately I am in the same situation. Also, I am not sure if doing that
would really be worth the trouble.

Guenter


