Return-Path: <linux-kernel+bounces-102757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C5287B6EF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 997CF1C20E88
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4583F947B;
	Thu, 14 Mar 2024 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qe0g8Z+o"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F0D8F5B;
	Thu, 14 Mar 2024 03:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710387854; cv=none; b=qu57xWZ6dOLEHkp9nRU+d/RX8q1ZzS05PiZb3T5SLbVevr9XW8y6Ou7KIQbPWTQEVlX4801AN3KDg1NhAGZ3nAhsQ29FWfItCgySCwSi/g4y8d7ZC6DEON8FfaxkpPEzKvD6wEyFfw3BSxLzYA8ceEsqczmLXAp5ZqxRFLaEADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710387854; c=relaxed/simple;
	bh=XkUhEBBXByTRjClPGLvc/LMxHGLjYuPwzv3F8uZf3EM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmOmTs2kI7dRFewrAQgBlZnil1Z2N4DhcARjbqdNf+OtctZnPb7M9Zi+9BtBmpKLCe1rwn//KZd38+sKKktYQsP4YhbOaF/2xlXins8iO1UGLjO/GcHmU+p7xhQtRkW9E02OS3XkTyLtwVUXF9K4Chn3p6rhIPetevu0I+/tHtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qe0g8Z+o; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-42f3d88bc20so2193111cf.1;
        Wed, 13 Mar 2024 20:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710387851; x=1710992651; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FxcCCcyJb5hckDgXHUgjpmd8n+vqjZwLDESuUfS2lhQ=;
        b=Qe0g8Z+o71/ttI4YttW6Bbr25Lh6b7vzwrHZFxHUEjbPX1VpFwKf0jXjPfoXjYehaU
         HCnk6OqbyXNAIepuwa88HpXP0fkOTQVrmlecij/d563cFNxm4HHxAeYNP/Zwor4khiv3
         FMDifIELiBxqwCkTJIz1Bw1f94zGFDXqAr7QuBURQjGMirP5FsgjZkGS1TRZrs2emshe
         2wZZWLlyL0i3I66kP7HKFQ820eXkwycoZMeLM0CEZrNB/hFKgyOXB68cmz3odjpqs2Gz
         TxL9GxfVSrA1NgS69Ee1I5kYhP+9uikov3hg0ilZ+ulZ0JaAf3M8+S22e/eEmWWOJgV0
         8RAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710387851; x=1710992651;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxcCCcyJb5hckDgXHUgjpmd8n+vqjZwLDESuUfS2lhQ=;
        b=t1sdvnfhgJWkDlvE52OxqhEaSs6/DNM9vMTJtzG+q4ssafKZY+8t/aj56TPUA1t2kd
         /GF6P7BCWgh5aBNeaW8SHGhrZ+pq7wX8PHJqlg4MSlv87aoUhLdSpzsdHDIr2uCtiZ0F
         ZEBUj+CX1iqaxEYt71gSSa3YC+aPxc2293496r+CK5Nua1AQHOg7eQm0TQq+5yvLWZG9
         vlKWQCeUfp8Spu1G42c0FzPPJf3qsF1n7liAWRziGsJell8GR0wVNyJUVszmxa2pp1hU
         +ifrJvxGh+Dk/zq+4eI/NUe917uo4QlU7428B9/Gc2WATERQfk2I+fHo/QG0Hg3x2ujx
         +fnA==
X-Forwarded-Encrypted: i=1; AJvYcCWBHxdYVcoJ/bc4irBZAsjRZRUMcpzwiopgm+NB+7hEOWofH2vE4Nwm+g8rBB6u5pYb2USnXqnAMnGT+qpMA4JWuLYMsgYumg3CyiMDnZ1SPz9Uw7yNm26IWZZqjCkCtUxN
X-Gm-Message-State: AOJu0YxW9bEEce5TB5rBOPEnqc2cEOuHESu4ox9i88lPI8staT8PswEK
	l6pZKOHk/8btgAVDM7+dh82KZ17JFaaiIqwF1FF2/eRZbjYO4BQg
X-Google-Smtp-Source: AGHT+IGPDnDM29i5VG4Czn2ouF40dCxI5bsvS8gEKq3s367+LidGGxdDmlHXTzW7BTH9VYnAytTM+A==
X-Received: by 2002:a05:620a:c93:b0:787:a83a:cfed with SMTP id q19-20020a05620a0c9300b00787a83acfedmr603309qki.70.1710387851414;
        Wed, 13 Mar 2024 20:44:11 -0700 (PDT)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id dc33-20020a05620a522100b007885cd1c058sm287988qkb.103.2024.03.13.20.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 20:44:10 -0700 (PDT)
Message-ID: <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
Date: Wed, 13 Mar 2024 20:44:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for
 v6.9]
Content-Language: en-US
To: Frederic Weisbecker <frederic@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Joel Fernandes <joel@joelfernandes.org>, Boqun Feng <boqun.feng@gmail.com>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org,
 mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org,
 neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com,
 bigeasy@linutronix.de, chenzhongjin@huawei.com, yangjihong1@huawei.com,
 rostedt@goodmis.org, Justin Chen <justin.chen@broadcom.com>
References: <ZetHwrCb0KXE0xFI@tardis>
 <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDEIs63EBIYBJIC@boqun-archlinux>
 <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
 <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux>
 <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
 <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com>
 <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
 <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
 <ZfIuRMo8oKbR08Af@lothringen>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <ZfIuRMo8oKbR08Af@lothringen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/13/2024 3:52 PM, Frederic Weisbecker wrote:
> On Wed, Mar 13, 2024 at 03:04:26PM -0700, Florian Fainelli wrote:
>> On 3/13/24 14:59, Russell King (Oracle) wrote:
>>> On Wed, Mar 13, 2024 at 02:30:43PM -0700, Florian Fainelli wrote:
>>>> I will try to provide multiple answers for the sake of everyone having the
>>>> same context. Responding to Linus' specifically and his suggestion to use
>>>> "initcall_debug", this is what it gave me:
>>>>
>>>> [    6.970669] ata1: SATA link down (SStatus 0 SControl 300)
>>>> [  166.136366] probe of unimac-mdio-0:01 returned 0 after 159216218 usecs
>>>> [  166.142931] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
>>>> [  166.148900] probe of unimac-mdio.0 returned 0 after 159243553 usecs
>>>> [  166.155820] probe of f0480000.ethernet returned 0 after 159258794 usecs
>>>> [  166.166427] ehci-brcm f0b00300.ehci_v2: EHCI Host Controller
>>>>
>>>> Also got another occurrence happening resuming from suspend to DRAM with:
>>>>
>>>> [   22.570667] brcmstb-dpfe 9932000.dpfe-cpu: PM: calling
>>>> platform_pm_resume+0x0/0x54 @ 1574, parent: rdb
>>>> [  181.643809] brcmstb-dpfe 9932000.dpfe-cpu: PM:
>>>> platform_pm_resume+0x0/0x54 returned 0 after 159073134 usecs
>>>>
>>>> and also with the PCIe root complex driver:
>>>>
>>>> [   18.266279] brcm-pcie f0460000.pcie: PM: calling
>>>> brcm_pcie_resume_noirq+0x0/0x164 @ 1597, parent: platform
>>>> [  177.457219] brcm-pcie f0460000.pcie: clkreq-mode set to default
>>>> [  177.457225] brcm-pcie f0460000.pcie: link up, 2.5 GT/s PCIe x1 (!SSC)
>>>> [  177.457231] brcm-pcie f0460000.pcie: PM: brcm_pcie_resume_noirq+0x0/0x164
>>>> returned 0 after 159190939 usecs
>>>> [  177.457257] pcieport 0000:00:00.0: PM: calling
>>>> pci_pm_resume_noirq+0x0/0x160 @ 33, parent: pci0000:00
>>>>
>>>> Surprisingly those drivers are consistently reproducing the failures I am
>>>> seeing so at least this gave me a clue as to where the problem is.
>>>>
>>>> There were no changes to drivers/net/ethernet/broadcom/genet/, the two
>>>> changes done to drivers/net/mdio/mdio-bcm-unimac.c are correct, especially
>>>> the read_poll_timeout() conversion is correct, we properly break out of the
>>>> loop. The initial delay looked like a good culprit for a little while, but
>>>> it is not used on the affected platforms because instead we provide a
>>>> callback and we have an interrupt to signal the completion of a MDIO
>>>> operation, therefore unimac_mdio_poll() is not used at all. Finally
>>>> drivers/memory/brcmstb_dpfe.c also received a single change which is not
>>>> functional here (.remove function change do return void).
>>>>
>>>> I went back to a manual bisection and this time I believe that I have a more
>>>> plausible candidate with:
>>>>
>>>> 7ee988770326fca440472200c3eb58935fe712f6 ("timers: Implement the
>>>> hierarchical pull model")
>>>
>>> I haven't understood the code there yet, and how it would interact with
>>> arch code, but one thing that immediately jumps out to me is this:
>>>
>>> "    As long as a CPU is busy it expires both local and global timers. When a
>>>       CPU goes idle it arms for the first expiring local timer."
>>>
>>> So are local timers "armed" when they are enqueued while the cpu is
>>> "busy" during initialisation, and will they expire, and will that
>>> expiry be delivered in a timely manner?
>>>
>>> If not, this commit is basically broken, and would be the cause of the
>>> issue you are seeing. For the mdio case, we're talking about 2ms
>>> polling. For the dpfe case, it looks like we're talking about 1ms
>>> sleeps. I'm guessing that these end up being local timers.
>>>
>>> Looking at pcie-brcmstb, there's a 100ms msleep(), and then a polling
>>> for link up every 5ms - if the link was down and we msleep(5) I wonder
>>> if that's triggering the same issue.
>>>
>>> Why that would manifest itself on 32-bit but not 64-bit Arm, I can't
>>> say. I would imagine that the same hardware timer driver is being used
>>> (may be worth checking DT.) The same should be true for the interrupt
>>> driver as well. There's been no changes in that code.
>>
>> I just had it happen with ARM64 I was plagued by:
>>
>> https://lore.kernel.org/lkml/87wmqrjg8n.fsf@somnus/T/
>>
>> and my earlier bisections somehow did not have ARM64 fail, so I thought it
>> was immune but it fails with about the same failure rate as ARM 32-bit.
> 
> Can you please boot with:
> 
>      trace_event=timer_migration,timer_start,timer_expire_entry,timer_cancel
> 
> And add the following and give us the resulting output in dmesg?

Here are two logs from two different systems that exposed the problem on 
boot:

https://gist.github.com/ffainelli/f0834c52ef6320c9216d879ca29a4b81
https://gist.github.com/ffainelli/dc838883edb925a77d8eb34c0fe95be0

thanks!
-- 
Florian

