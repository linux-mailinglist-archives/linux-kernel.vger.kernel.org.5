Return-Path: <linux-kernel+bounces-157817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFDD8B16AE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788B2B26705
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 22:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A249F16EC11;
	Wed, 24 Apr 2024 22:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FufFf1N1"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D733157465;
	Wed, 24 Apr 2024 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713999580; cv=none; b=Uh/kYo1I5jNe5p8la93pujZN3PQ6Uf1UwWFw7neK7GpUBkvgftHXqR0mPxd+k94i8NiqvKvsVFvYlsZlXyMUZjr6WHhdvqYc5szYQojqAVzG4d9atteFsaOGfhz9Qh2W94HfiiArbVOixrULlMf6HTLXQseZYvx7SZaxU30Uve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713999580; c=relaxed/simple;
	bh=TUPqPpdBn1SWgpFfIfffbMTiilIpsXJXS3hXQQIU+2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJcQBmFO4CympGuiiTwOgl8463D6pVFsZToug2CZ2HfhYd/1TuQFmpIt9qsurHS1uvaP2iC5bUu7qsfogNsJA7A7cIKE9RLfxv2/LrcKMGQ196FOoGurSIR1+LO3SxlMpeUtFB6LOUgwhhE+/LGjNe2YdVYA4dR03ViGwXJHIXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FufFf1N1; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5dcc4076c13so331972a12.0;
        Wed, 24 Apr 2024 15:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713999579; x=1714604379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=qrHIvTMhZKru6VMpwqyvF3yCr/0CzPX1v0J6Prvp98A=;
        b=FufFf1N11R0mZyq2tdcR2u8+xiHtvJpQ1df1c3X1+WSKhzKPg1w1BmCLVFKLSIzMAz
         oFFUloG8Lfwb5YRciGfvRDIdwBCFNH0PygCeiPtLST+ThHxxf5cbYbQWGH4hcKmZIdVh
         hntTtb88lVG4izzKrTN0Uo2qmg8/MueTyCORWdTNDePyhSFXhky6brEGY6feHXDR4o8T
         JPO5pViB92xPa06u8uyWevdL7ArP364a0F/Cd9jvZ+e7zXKkrZBA9g7wyII/EusNykvL
         ekPwlAZWL2JKsNL7wW/Fnm64zh0eabmx0RnpyPdGa725vY2KCwvBsvspziB8RWIEXeLp
         JMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713999579; x=1714604379;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qrHIvTMhZKru6VMpwqyvF3yCr/0CzPX1v0J6Prvp98A=;
        b=A/he1L3QdJMnXuOpxCJfUg9/QZu/zKdbdT42zCGSIvAs1vFwtLNJsubzYaNCZpgsIg
         SikEnV+/kNtteTc1/4EV/5oCYzqkKANAkdl8Nj2+04hv6mbNw5MZnM6n7Sz96lYBUlaP
         NviIBp/nPRimtd4xAsl+0uSeKVv4PdLnvjzSocYCzTfl2c7FiE5suvhEkbOLnalF68At
         FEIn7X0CAaVq8TVhAf83qQDapXi4LIQkmZGQr8m+6PehccI8YkaYh4KGPrTzT1xnOUM1
         MVq3BbJ3pHGkRKNOY+6EgVuQEgjb1DSoca3sKsRzghvTk4BX263aEMyzEh23FCbQqsSa
         ZCag==
X-Forwarded-Encrypted: i=1; AJvYcCU4Gsy5DWrFHxHmUyGHPhniRntmPcf8a+OdIm8goyJ9V/haiWG8p2/iqDpsoeGBzlWme0xByw3O2YDBxOWNEOZI9rMhAaPV8EhEOwpU
X-Gm-Message-State: AOJu0YxEPectHk/Gg/sJuZWT8gTCa2Ygmt4cjlc17UQi761gwPoeoZTl
	3WwQEQL72p3oIWVCKx9hWV2QuTXPCpaoOJ8zH20P4BLxaD0l1jTK
X-Google-Smtp-Source: AGHT+IFApEN8tGpNqafqjSqQ9bQEWpsZtZexin+ASeOW4YlI40lGn98RmLXOSxraCtHZKsKuLZoDzg==
X-Received: by 2002:a05:6a20:d48f:b0:1a7:48de:b2a4 with SMTP id im15-20020a056a20d48f00b001a748deb2a4mr1935336pzb.6.1713999578699;
        Wed, 24 Apr 2024 15:59:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h6-20020a056a00170600b006e6b180d87asm11948597pfc.35.2024.04.24.15.59.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 15:59:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9b9599c8-2689-48be-a569-660e5f51b329@roeck-us.net>
Date: Wed, 24 Apr 2024 15:59:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: ohci: Prevent missed ohci interrupts
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240424195951.3749388-1-linux@roeck-us.net>
 <0a29cc85-a79e-476d-aae6-0a054aad2e90@rowland.harvard.edu>
 <2024042441-salutary-finishing-f54d@gregkh>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2024042441-salutary-finishing-f54d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 15:49, Greg Kroah-Hartman wrote:
> On Wed, Apr 24, 2024 at 06:30:06PM -0400, Alan Stern wrote:
>> On Wed, Apr 24, 2024 at 12:59:51PM -0700, Guenter Roeck wrote:
>>> Testing ohci functionality with qemu's pci-ohci emulation often results
>>> in ohci interface stalls, resulting in hung task timeouts.
>>>
>>> The problem is caused by lost interrupts between the emulation and the
>>> Linux kernel code. Additional interrupts raised while the ohci interrupt
>>> handler in Linux is running and before the handler clears the interrupt
>>> status are not handled. The fix for a similar problem in ehci suggests
>>> that the problem is likely caused by edge-triggered MSI interrupts. See
>>> commit 0b60557230ad ("usb: ehci: Prevent missed ehci interrupts with
>>> edge-triggered MSI") for details.
>>>
>>> Ensure that the ohci interrupt code handles all pending interrupts before
>>> returning to solve the problem.
>>>
>>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>>> Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>> ---
>>> v2: Only repeat if the interface is still active
>>
>> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
>>
>> Greg might insist that the patch be CC'ed to stable@vger.kernel.org since
>> it contains a Fixes: tag.
> 
> I'll add that by hand, no worries.

Thanks!

Guenter


