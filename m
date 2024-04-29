Return-Path: <linux-kernel+bounces-162373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45E48B5A24
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CC5C1F222B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6687F70CCC;
	Mon, 29 Apr 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kap14cc+"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80356BB28;
	Mon, 29 Apr 2024 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397645; cv=none; b=CNv7C2FP95bkJ/ydJpN80UNKyxlk12MJWwRus6ere5hCFPk22jDbDFJqKVKfJEMs0oddqwkVo3KLv0WZRvPBtuJGrGM8qnG8bkW87ilBI3Tt+wJscvtnOBPezXWUzGzPahkLB8wadNP8Q1E9vHuSqj45R9aFcYTEpCDEMlGWWe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397645; c=relaxed/simple;
	bh=Rc6B3MamMkjyoHlP+wt/ai17Jy1UIxlbiEwOvmSPqV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kVqmWvPJbVCTUYxjlZwa4UACcpxt7QCx7ofcO3Y4qOJGMMiJsx3Zl9MPaQnQKMoOnRN92bm0f9FWNzLgZL6KvOFO0XseeyoFkk/BFZuasIVtBAWTAL9ETPQsa9+IUC9QEeLtQz2SLYh8H9uLNnkd7QSPp10Bw31xujnovAPEev4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kap14cc+; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6f3e3d789cdso2492365b3a.1;
        Mon, 29 Apr 2024 06:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714397643; x=1715002443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Od7rioCub18qrOw7/BFOsjSATLNjYiS/mKg/ogsd1xY=;
        b=kap14cc+1aWWPdh9aEsdZE2m6/Am98cN0hXx+cmRdW2tH7uzAUE9GLrNss8exk8tue
         YnMFqhFGhxenoet0FZYpfilF5bpfsBvx7WhH5+3PHoERvmIOkQ1Jg77LzitQqE3tIJQe
         OY95r40oTqPJMJXyHaMgjR87sBdvvQI5mADtCXHk+nDqY27P61egELgfz87cBDDGs3Pn
         u1ELMLXB0q41Rmk6XphOVpfduCaTUKDtEvbsM35V3E+G4OkqcbXjc22+vbevqvTz7lQs
         +Yc6uukDBYOmjl6TyzNYohgxY6gL6BHz4RZZJR3/GBsIJ7YZ+W7aZEBJxCP0hPljVOHO
         EKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397643; x=1715002443;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Od7rioCub18qrOw7/BFOsjSATLNjYiS/mKg/ogsd1xY=;
        b=bFmWVLyQYbQUUA1cio6sljpU5zF64/vSx81stcGM9ZBuA4M6w55RV0dlZHerGeSqs5
         cg9D9rmg1xgs5rGd90rodSTzFo9J49mHVCmZ0Ct2m/l3buDtKbxQtYTJHbcjJwwzzGpx
         8SD8z2eT2OqVOeKCVibD66iQWxSug+ADIamZoPvwCHsKYVibJPryH6Ws2mKT2RBS/svJ
         7qJy3kM+2FNN28nO1ONxVz2G3H10JEKC3V5Rg4Nvwi8jNAb6eBvNS1icgu71op6rzULq
         v3lWSeLkPMdT3rhZwbtpCyQCaDEC4Wo+0lUDmXQRuDI4T/FHZNx3yffnjU+GeiAcraIP
         ENNw==
X-Forwarded-Encrypted: i=1; AJvYcCVYIxertRqcDXGM7ioXH5O8yp/bKS6aSBXUI5oP+yz3VtckNX/X69yLSgCZY7hwje7csS7OUJmOkPd2YYDT533Tiq1GezNn2CND+CdIorwFBzFWLYQhYIOcew6+v7f7/dqkbYN4+Yu/
X-Gm-Message-State: AOJu0YzpCDMUCmcUeXu4bJw96Vkwk/SHioLY70TYLtSIw/JhLImXp4W5
	WZVXphH+mEVDLc5iCI7uukQt76NlXttr5C9jPAiE7/XK4/1NRgXf
X-Google-Smtp-Source: AGHT+IHsoOhKYMS2Qd0Zbp8LcFBVHmoskjGR642Ow1twoohlykMzt4bAeRiQ37EgH9QqrEyevbYUaA==
X-Received: by 2002:a05:6a20:4389:b0:1aa:8fe2:5adf with SMTP id i9-20020a056a20438900b001aa8fe25adfmr15474753pzl.15.1714397643227;
        Mon, 29 Apr 2024 06:34:03 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d6-20020a63d646000000b005dc8702f0a9sm19132054pgj.1.2024.04.29.06.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 06:34:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <eafc8fb6-cecc-48c8-a053-cd00f094e781@roeck-us.net>
Date: Mon, 29 Apr 2024 06:34:00 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: ohci: Prevent missed ohci interrupts
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Laight <David.Laight@aculab.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240424195951.3749388-1-linux@roeck-us.net>
 <a1b4bac14c6a4334969cc7d671f3a8eb@AcuMS.aculab.com>
 <d434c88a-6575-4d45-ab3e-e27ac7684b07@roeck-us.net>
 <ef23ykui3axiwfkr4wi24abbuklvejx5r5wqem5cr4lq36x7py@kkxvsi3ibtbi>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ef23ykui3axiwfkr4wi24abbuklvejx5r5wqem5cr4lq36x7py@kkxvsi3ibtbi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/24 23:49, Gerd Hoffmann wrote:
>    Hi,
> 
>>>> +	/* repeat until all enabled interrupts are handled */
>>>> +	if (ohci->rh_state != OHCI_RH_HALTED) {
>>>> +		ints = ohci_readl(ohci, &regs->intrstatus);
>>>> +		if (ints & ohci_readl(ohci, &regs->intrenable))
>>>
>>> Doesn't the driver know which interrupts are enabled?
>>> So it should be able to avoid doing two (likely) slow io reads?
>>> (PCIe reads are pretty much guaranteed to be high latency.)
>>
>> No, the driver does not cache intrenable.
> 
> Does the driver ever change intrenable after initialization?
> 

$ git grep -e intrenable -e intrdisable drivers/usb/host/*ohci*c | grep ohci_writel
drivers/usb/host/ohci-hcd.c:	ohci_writel(ohci, (u32) ~0, &ohci->regs->intrdisable);
drivers/usb/host/ohci-hcd.c:		ohci_writel (ohci, OHCI_INTR_OC, &ohci->regs->intrenable);
drivers/usb/host/ohci-hcd.c:	ohci_writel (ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
drivers/usb/host/ohci-hcd.c:	ohci_writel (ohci, mask, &ohci->regs->intrenable);
drivers/usb/host/ohci-hcd.c:			ohci_writel (ohci, OHCI_INTR_UE, &regs->intrdisable);
drivers/usb/host/ohci-hcd.c:		ohci_writel(ohci, OHCI_INTR_RHSC, &regs->intrdisable);
drivers/usb/host/ohci-hcd.c:		ohci_writel (ohci, OHCI_INTR_SF, &regs->intrdisable);
drivers/usb/host/ohci-hcd.c:		ohci_writel (ohci, OHCI_INTR_MIE, &regs->intrenable);
drivers/usb/host/ohci-hcd.c:	ohci_writel (ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
drivers/usb/host/ohci-hcd.c:	ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrdisable);
drivers/usb/host/ohci-hcd.c:		ohci_writel(ohci, OHCI_INTR_MIE, &ohci->regs->intrenable);
drivers/usb/host/ohci-hub.c:	ohci_writel(ohci, OHCI_INTR_SF, &ohci->regs->intrdisable);
drivers/usb/host/ohci-hub.c:	ohci_writel (ohci, OHCI_INTR_INIT, &ohci->regs->intrenable);
drivers/usb/host/ohci-hub.c:		ohci_writel (ohci, OHCI_INTR_SF, &ohci->regs->intrenable);
drivers/usb/host/ohci-hub.c:			ohci_writel(ohci, rhsc_enable, &ohci->regs->intrenable);
drivers/usb/host/ohci-hub.c:	ohci_writel(ohci, OHCI_INTR_RHSC, &ohci->regs->intrenable);
drivers/usb/host/ohci-q.c:	ohci_writel (ohci, OHCI_INTR_SF, &ohci->regs->intrenable);

> PCIe reads are expensive, especially in virtual machines where this
> goes vmexit to qemu, so doing that for a piece of information the
> driver should have (or is able to calculate) should indeed better
> be avoided.
> 

I would agree, but I really think that should be a separate patch
if implemented.

Guenter


