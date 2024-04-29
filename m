Return-Path: <linux-kernel+bounces-162570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9775D8B5DE0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CBCDB2CDDB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9364183CC6;
	Mon, 29 Apr 2024 15:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDCBA2FL"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4382D8E;
	Mon, 29 Apr 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714404233; cv=none; b=C/Vq9FiXZSnuZBn15sptfrBIuMFbHhV7j1mUW2ryM7eVDJ13g2b+HQhcRq/LYGMkWcqWlXSY2oiar6mjlqP7AbGHnwdLta/futd/nuV8Cf0HvTutzxwd7TvHwXatmXbUDKxlFkNkPxCcbD1i6PucYDdmLIF4+mKeyuNvOEATSso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714404233; c=relaxed/simple;
	bh=UoOiVi6NxaqejEwIzDKtIZ5vgKiX5KkoRm7zE3CAe6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9Q6+EZQZVA67p5oqTrZt9E19NqGt+G8tCFetlKNmIk6S+A7o2hVRKZzlBBVl4gELvmQQw4s29RHvG3NRHGw5498ll92RmMzV5PZEW8vO7rCMI+YBO1Cct5DiNEmVTHgQPS+PwnlQIMNcjgqUbtj9yR+5VOZSZ2pLmD0jS+FoY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDCBA2FL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e834159f40so36442245ad.2;
        Mon, 29 Apr 2024 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714404231; x=1715009031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=3jBawfFhlA0UFRcAmeMLqv9bLy/zzapCJCHTZnIdO/k=;
        b=gDCBA2FL3PIt+vvkwrkWZhGRsfpU2c2oZF1HAKqLrHOabu6/qgS5yu07G59pVqwQDl
         SFzipIyxSnqJblhHrrcoEcnvJIr/D4mS7WF4kWCxMUg1FKLV8EiU9DoHoQ05nDJig11x
         ldIGVyzETzhLVbX7Fh5aDvxiI3dGYFVwGZkvGebf6dEbq1GgqEFcoBGHdJoP1nVRndE/
         ccgSCfoOKhVwwLtExKCiJhmrvujRfy7x0NBJwPz0BFevDu3CHw+7Rlfs8WZ6ZRtHHdPX
         wrsyXpum9GrsEryzehX6TZS5LdQD4aCUGsidCvNwnCfXXkoa4jByEJBHCEw+nDonUGLc
         Kvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714404231; x=1715009031;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jBawfFhlA0UFRcAmeMLqv9bLy/zzapCJCHTZnIdO/k=;
        b=WecselXdrGBayVE5MJ1JCSF0LrzRoY/Jj1dZi+hEkItdiSx4/sGjdsv3JHPAGR+Yhu
         wYj2CFnTxi4+jKzGu+rl/SiaA6z/6kk2Dt3epwV0sXDJ6x1HlgEPueamC20ehqL6ljCA
         1VXjwNXwnlC2wGT3dwtEBIN7Jvbg+jJ9XbW39RknMK0PrcEZlsrbS3/4YbDUXUFXnRag
         iDUGziO4+G9m8w3Ip/ktSL4An5QTrikliXCPp0SOTYhMpygBlf62p3HLGx67GnAZ3nmd
         matn3ruUK9G8aAbqB34AwHAFXhv6uNN6QrAObQu//TXdcQdFEL78PfzSYh+B9D/Vhyqc
         ZUTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJK8lnRmyCGQUH55TmErJkE+zTFuw3dt5oe6an0HZBdb384BAgrh0stlj9tp6BgXWveDPJc4s9KOBZyttokXHWmmIvwyIRh2dFyfckv1wUK1uCaRKwikZQ1Z7v/qBiPgdddHUhnjba
X-Gm-Message-State: AOJu0Yy1pfE/d0DZUr0AZM/gaLEQ3Ab8vEJFyg4R4s5db9VeE3KsjJuc
	p6eTaofOt/VVH3d+gued2gL+MB/sYnVKe14umKawqb1pfwQJnDTM
X-Google-Smtp-Source: AGHT+IG4M8a/5rwKelhbmpwTd0G8NkgLdEqlScPeP9urTIwVya3bVOOLSQLcRTcGzyfYiwAIzPnFhA==
X-Received: by 2002:a17:902:ec8a:b0:1e4:203d:ab80 with SMTP id x10-20020a170902ec8a00b001e4203dab80mr11995464plg.57.1714404231247;
        Mon, 29 Apr 2024 08:23:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jz15-20020a170903430f00b001e4e8278847sm20440680plb.56.2024.04.29.08.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 08:23:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dd351be7-4ab4-436d-bfad-7f72aadfc1d1@roeck-us.net>
Date: Mon, 29 Apr 2024 08:23:48 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: ohci: Prevent missed ohci interrupts
To: David Laight <David.Laight@ACULAB.COM>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240424195951.3749388-1-linux@roeck-us.net>
 <a1b4bac14c6a4334969cc7d671f3a8eb@AcuMS.aculab.com>
 <d434c88a-6575-4d45-ab3e-e27ac7684b07@roeck-us.net>
 <ef23ykui3axiwfkr4wi24abbuklvejx5r5wqem5cr4lq36x7py@kkxvsi3ibtbi>
 <eafc8fb6-cecc-48c8-a053-cd00f094e781@roeck-us.net>
 <2adc91aebb3a433997e13bd479d4b4b3@AcuMS.aculab.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2adc91aebb3a433997e13bd479d4b4b3@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/29/24 07:01, David Laight wrote:
> From: Guenter Roeck
>> Sent: 29 April 2024 14:34
>>
>> On 4/28/24 23:49, Gerd Hoffmann wrote:
>>>     Hi,
>>>
>>>>>> +	/* repeat until all enabled interrupts are handled */
>>>>>> +	if (ohci->rh_state != OHCI_RH_HALTED) {
>>>>>> +		ints = ohci_readl(ohci, &regs->intrstatus);
>>>>>> +		if (ints & ohci_readl(ohci, &regs->intrenable))
>>>>>
>>>>> Doesn't the driver know which interrupts are enabled?
>>>>> So it should be able to avoid doing two (likely) slow io reads?
>>>>> (PCIe reads are pretty much guaranteed to be high latency.)
>>>>
>>>> No, the driver does not cache intrenable.
>>>
>>> Does the driver ever change intrenable after initialization?
>>>
>>
>> $ git grep -e intrenable -e intrdisable drivers/usb/host/*ohci*c | grep ohci_writel
>> drivers/usb/host/ohci-hcd.c:	ohci_writel(ohci, (u32) ~0, &ohci->regs->intrdisable);
>> drivers/usb/host/ohci-hcd.c:		ohci_writel (ohci, OHCI_INTR_OC, &ohci->regs->intrenable);
>> drivers/usb/host/ohci-hcd.c:	ohci_writel (ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
>> drivers/usb/host/ohci-hcd.c:	ohci_writel (ohci, mask, &ohci->regs->intrenable);
>> drivers/usb/host/ohci-hcd.c:			ohci_writel (ohci, OHCI_INTR_UE, &regs->intrdisable);
>> drivers/usb/host/ohci-hcd.c:		ohci_writel(ohci, OHCI_INTR_RHSC, &regs->intrdisable);
>> drivers/usb/host/ohci-hcd.c:		ohci_writel (ohci, OHCI_INTR_SF, &regs->intrdisable);
>> drivers/usb/host/ohci-hcd.c:		ohci_writel (ohci, OHCI_INTR_MIE, &regs->intrenable);
>> drivers/usb/host/ohci-hcd.c:	ohci_writel (ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
>> drivers/usb/host/ohci-hcd.c:	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
>> drivers/usb/host/ohci-hcd.c:		ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrenable);
>> drivers/usb/host/ohci-hub.c:	ohci_writel(ohci, OHCI_INTR_SF, &ohci->regs->intrdisable);
>> drivers/usb/host/ohci-hub.c:	ohci_writel (ohci, OHCI_INTR_INIT, &ohci->regs->intrenable);
>> drivers/usb/host/ohci-hub.c:		ohci_writel (ohci, OHCI_INTR_SF, &ohci->regs->intrenable);
>> drivers/usb/host/ohci-hub.c:			ohci_writel(ohci, rhsc_enable, &ohci->regs->intrenable);
>> drivers/usb/host/ohci-hub.c:	ohci_writel(ohci, OHCI_INTR_RHSC, &ohci->regs->intrenable);
>> drivers/usb/host/ohci-q.c:	ohci_writel (ohci, OHCI_INTR_SF, &ohci->regs->intrenable);
> 
> At least the hardware has separate enable/disable registers
> so the driver isn't doing RMW cycles.
> 
> I'd guess that the normal condition is that no interrupts are pending.
> So it can be held to one (slow) read by checking:
> 	if (ints && (ints & ohci_readl(ohci, &regs->intrenable)))

Guess that can't hurt. I'll send v3.

Thanks,
Guenter


