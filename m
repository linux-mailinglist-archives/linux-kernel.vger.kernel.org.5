Return-Path: <linux-kernel+bounces-161199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F29048B48D3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 00:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 761871F214B2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 22:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE5C1487D9;
	Sat, 27 Apr 2024 22:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCJeSHYp"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00F33B7A8;
	Sat, 27 Apr 2024 22:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714256316; cv=none; b=ZXUbbrksQnE+/QMxruFEC6Wf1+5YkQyKuETyJvqyMlo5MRitHTQx2iAF8vGIt8NDeccEJPboMru1h+97yomRwid4u71WExW+FWewtqQ8S3CdZXeSiruMJCdXgU6UwUNicOX1JIe6oofRK9sux6JxXzuC/fyKCwhmDVi/BrRPRgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714256316; c=relaxed/simple;
	bh=+pApdBxcNPQesd2fjTKnHDMjVKA5ZKUL/n2W+oHqS+E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j69+Iw2hMyKQ9k9NCDnnoUejby4E0BWPDQ9k4kmpH+dXIJHUWYFr+2eQGik+F0hLryvFgoCXGkxrFp4T3BDK0ZvlR2FhtCZ7903yMmb+3bBgwrFKl4gpnHgLZRm5BRwjRoXkv8mQyasnJK53XTt+SGXoAkNRN4fTo6x5gZe6IgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCJeSHYp; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5dca1efad59so2333381a12.2;
        Sat, 27 Apr 2024 15:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714256314; x=1714861114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=jbsSBglmscTfODMDILXQbvYXGuw5C6ZoYMDHpVKIqs4=;
        b=dCJeSHYp21AU91TQuP1mfk5y7uCJSN1CdYE/MR6XU+YHEei+ErANpP2G+OLjZxMyk7
         PBqxFeUTP531okVMYawnm9WfoIV9wFuQRjTIzIudLwAWPoulJAm1hFtDiF6YsHmwWDwb
         FDVOb8hn8f76J46QNpYTAimu97XB1nowUzNezISN5hJ5FOadQPkT7TAjDQ0mEFArpJG2
         gbmhfNiCR7NP7GGMjK14iCm5on3gaiIz2/xZVOzHqSxb6f1eTrUdKt5ZKpwm+jj7Z7WN
         qpYlbisjTyfvSS8DxYu9GusRyhxg0FRAXKiAjyCU7PMwWvSf4UZ66LHznEllnUaiHc/9
         oxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714256314; x=1714861114;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbsSBglmscTfODMDILXQbvYXGuw5C6ZoYMDHpVKIqs4=;
        b=jrauGB7Rz2qiDBMuJ6+m7R2KUJDCCOZDHCyx3ppR4swA34ml5NxUXWERkm8EO+ZvLl
         rONe9x6sYQEkEaXBO0AwHf2MNT/mPD57D7+IafYWD1HqZi6/E6+F4HVtlXyf3qBK9Kh7
         I3voKb7a7nVvUnpVwvC0Pjibct65IVq1ts0Dx9V8GWIzSDrCx4OmDKgvD7VD8zp3Fwh0
         8tgauj/L2AMVreeugVd/8kRwIySj8VfXUdzbvTktdNZMEjOzuBC0XCSI+M2fGt0awvsy
         ZdPI4L5BnQpwoqHSH6vDBOnlUM/8P4PXpWZir7+gmGnXhidCs7Az6EYdqNJFkWRu/bSC
         yW6A==
X-Forwarded-Encrypted: i=1; AJvYcCW+DcElwOZg37dYkBSKMytn6waNdQ65oFUaUuhZ9FvaQEptHFDZuyrcpxZFR6CGFTeJcY7IBU6L3AJr34YMLqo4PY+YK/Ytuo6YjDmSD0tee1n3JVT9nSNaU5NVjxWAcVmc9J5oSGmR
X-Gm-Message-State: AOJu0YxjMEiNqKjO1A1qbKFvuVNsFRg98OBxVzTumePoNLu+HFcUIR3L
	sO14spaYCX22/bAgF8QVAgZbVKVAsWs6pVlwF65Cg7onc+fu02iIgU5Z2Q==
X-Google-Smtp-Source: AGHT+IFQItQjSbREhhk7srgv9U9KKmzMZG0C6d+K19WxQCOauE+0s4V4DAx7slAj9KnCIqeTl8oXig==
X-Received: by 2002:a17:902:8498:b0:1e2:577:f694 with SMTP id c24-20020a170902849800b001e20577f694mr5623736plo.61.1714256314004;
        Sat, 27 Apr 2024 15:18:34 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b1-20020a170902d30100b001e451abffebsm17585122plc.86.2024.04.27.15.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Apr 2024 15:18:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <d434c88a-6575-4d45-ab3e-e27ac7684b07@roeck-us.net>
Date: Sat, 27 Apr 2024 15:18:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: ohci: Prevent missed ohci interrupts
To: David Laight <David.Laight@ACULAB.COM>,
 Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20240424195951.3749388-1-linux@roeck-us.net>
 <a1b4bac14c6a4334969cc7d671f3a8eb@AcuMS.aculab.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <a1b4bac14c6a4334969cc7d671f3a8eb@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/27/24 14:00, David Laight wrote:
> From: Guenter Roeck
>> Sent: 24 April 2024 21:00
>>
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
>> v2: Only repeat if the interface is still active
>>
>>   drivers/usb/host/ohci-hcd.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
>> index 4f9982ecfb58..bb6b50b4a356 100644
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
>> @@ -982,6 +983,13 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>>   	}
>>   	spin_unlock(&ohci->lock);
>>
>> +	/* repeat until all enabled interrupts are handled */
>> +	if (ohci->rh_state != OHCI_RH_HALTED) {
>> +		ints = ohci_readl(ohci, &regs->intrstatus);
>> +		if (ints & ohci_readl(ohci, &regs->intrenable))
> 
> Doesn't the driver know which interrupts are enabled?
> So it should be able to avoid doing two (likely) slow io reads?
> (PCIe reads are pretty much guaranteed to be high latency.)
> 

No, the driver does not cache intrenable.

Guenter


