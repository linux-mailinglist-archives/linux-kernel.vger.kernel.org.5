Return-Path: <linux-kernel+bounces-157524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0BB8B1257
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6121128EAD9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D57116EBF3;
	Wed, 24 Apr 2024 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvWR7gtv"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58FF16D9C6;
	Wed, 24 Apr 2024 18:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982919; cv=none; b=r5h1lzbrrBxNtlpYOd36wPGe3mlMQClH8pQoB6lvs2Ps9mDSychoGgYRCU/zxuQ5nU/vsGr/AdxvjH483ZD5IvsVqMnX3dBhKf06sLAt/WcyRdla7oi4ozl7BqnTN1mILl8IyXxEJM5AIYfy7AGRRGVvV4VL1QTBkYWd25at2iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982919; c=relaxed/simple;
	bh=45JT3U+A+pw6Rj84krkAOL411GLomhc9RS5vjzjNpJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUWqeSWbdKZJxgiCFXWcQ0yFbfsTGmT5EjHgkKbW3lMBeDRi6+FGHeN9mOisVaS61nymYQP3IH48OqufEfAdPj+Kxxvp4CKPkD7PA5Q9CL1xSerbLthhl5K8hzJ4Yp8Cnp06auEL+2V2jwwdlKI4EpQPf0cCODzpezY0Y8UgJT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XvWR7gtv; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed691fb83eso198476b3a.1;
        Wed, 24 Apr 2024 11:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713982917; x=1714587717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=s20tuiXq0ffHbA6P2JpkSIVq1dJybgJ8gllaRU/fQoc=;
        b=XvWR7gtvK00qf5d3hUI6VC/GUfx/gExBlbkBRfVkebgWlsQwfXxLDxujWgTzIWnL1x
         EqJct9nDHNc3RubcxoDisyBfUID1uV3X3GNfVdjgSdqEtfHx8aSEle2wf+81sVbg7wA4
         eeUowBUGtdGRELGhj2nvQ72jhdylo9nHGwXGh4eW6cOtIDHMwVXVXsZoDMePUwrM0LlU
         aoq4PqxfQPueM3YTLmCf7GDvl0VLjucYcL7ujQ5aG9bPTtU4+BnAIzUIqUWhRKKadlYj
         dYazuSlo9VLjg+BhbLAQLHlv6oJ1uEBZnJGf6YhN236lBJmkvUcOCG4HCL6iprKZxltW
         U67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713982917; x=1714587717;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s20tuiXq0ffHbA6P2JpkSIVq1dJybgJ8gllaRU/fQoc=;
        b=m+gUXxavWrCnWsrACrjhOd+oZ1o0e7KMBO37+IiY5WMPEc1ZjW/HQBhp0FxE7d/IRD
         zpIKyvynfTP2Ww0TEMG2hEQT872qYkfs1PhX+h0XfsT4WqVn+LPZ0cYk3MJVHpCmeuRN
         fY+Jo3AE+UMBRBIiRaLigPSJOAD86tWD/EpNJMqB9B1aYeUFMlTZ8tLlQzqHDmpiyd/l
         Y4fHXRR+8uCGX1XCwY93HcKvVt/UKtwiz94wspP0a8i8bLY9yS+U8t1Qjg/1yreRvTqu
         GZrQA57loMGSXLhKuVLvgOje8AtRBAVf6YxPBDf8o9UlTvxrXrUkQy3Xfz7CRlzfv6Xi
         lnCw==
X-Forwarded-Encrypted: i=1; AJvYcCWvrFQ+ZLdB1I5waTIhyGFLUqCpOOPyGbTG1+s7qRl/Hfle8s6jyZWlDuT8nJ8qksIKQQClzLqql1lMlBBTSTtsdsd2T/DrHBlbLbv+3dmIvtPCH6rAy5KTSGg/UjUO1EpbsA9XCpcw
X-Gm-Message-State: AOJu0Yyff0eerGoEcdcTplHXCYOuSAsByERctcKbgFS1uUveI2N3Tpr2
	C/G2soekRa0qQyr42CM+HAJb6oUORX3CjuYatkyQUXzU03y3vj+7
X-Google-Smtp-Source: AGHT+IHWh2Q7+E6mJiA2kEtaL3wyIe6+Ux81vkUhXTRgQ4zItsWeJMXkdxAkjdvZTnHyfiESkQJvpA==
X-Received: by 2002:a05:6a00:2442:b0:6ea:d794:ccee with SMTP id d2-20020a056a00244200b006ead794cceemr3970237pfj.17.1713982917078;
        Wed, 24 Apr 2024 11:21:57 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b8-20020a056a000cc800b006ed4c430acesm11717299pfv.40.2024.04.24.11.21.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 11:21:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <1f94db3e-2ebd-4659-9f88-8591172c3cf0@roeck-us.net>
Date: Wed, 24 Apr 2024 11:21:54 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: ohci: Prevent missed ohci interrupts
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240424170250.3738037-1-linux@roeck-us.net>
 <57511487-e622-476d-adb2-5dfc725032d4@rowland.harvard.edu>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <57511487-e622-476d-adb2-5dfc725032d4@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 11:15, Alan Stern wrote:
> On Wed, Apr 24, 2024 at 10:02:50AM -0700, Guenter Roeck wrote:
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
>> Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   drivers/usb/host/ohci-hcd.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
>> index 4f9982ecfb58..4d764eb6c1e5 100644
>> --- a/drivers/usb/host/ohci-hcd.c
>> +++ b/drivers/usb/host/ohci-hcd.c
>> @@ -888,6 +888,7 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>>   	/* Check for an all 1's result which is a typical consequence
>>   	 * of dead, unclocked, or unplugged (CardBus...) devices
>>   	 */
>> +again:
>>   	if (ints == ~(u32)0) {
>>   		ohci->rh_state = OHCI_RH_HALTED;
>>   		ohci_dbg (ohci, "device removed!\n");
>> @@ -982,6 +983,11 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>>   	}
>>   	spin_unlock(&ohci->lock);
>>   
>> +	/* repeat until all enabled interrupts are handled */
>> +	ints = ohci_readl(ohci, &regs->intrstatus);
>> +	if (ints & ohci_readl(ohci, &regs->intrenable))
>> +		goto again;
> 
> If we take the repeat, we don't want to return IRQ_NOTMINE by accident.  To
> prevent this, we should check that ohci->rh_state != OHCI_RH_HALTED before
> re-reading ints and jumping back.
> 
> (If rh_state _is_ OHCI_RH_HALTED, it means the device is supposedly stopped
> and disabled for generating further interrupt requests, so we shouldn't
> need to worry about any outstanding intrstatus bits still set.)
> 

Makes sense. I'll send v2.

Thanks,
Guenter


