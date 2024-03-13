Return-Path: <linux-kernel+bounces-102639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5039987B52D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 00:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCC61C218BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 23:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E155D732;
	Wed, 13 Mar 2024 23:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IzrPVfBr"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6405C8EC;
	Wed, 13 Mar 2024 23:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710372595; cv=none; b=ZzLk0o4c1yfEHMFLdvvPD/84E1b+t4bugaxgcEz/QU/Ir8are0s/1yeOAzOIMMnXqxdrit0KJJLAJGMpsj1dMGkgbptHdEd3EnCq5v32hX0ke+rBYsMiXZ9rP+kUEh0G4GbI2G01DJ25+vB/DANp9oDIgY/reGKGXU8Rlw7lpSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710372595; c=relaxed/simple;
	bh=RdwgIxDsgZQ5fACP821DCEPFqEkv88cjTwagE4llUIw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpsN8NWRmYO85RyWltjvHNXNWQAw6aH5jfSGB5fTskMtPj6c0valojDqH+wfrsw5vsinEtzFnfsBe2mJ/Of17s7pgNQ41kq3x8mUSHVRjoqAM9Ao4WJtqDU23kb9WyKaMNlfvWWJba+gge+x1AU8POkTY7QLXQ9LCn39U8dWnGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IzrPVfBr; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60cbcd04de9so4352737b3.2;
        Wed, 13 Mar 2024 16:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710372592; x=1710977392; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/PsnHM06LDrqbWXqebDpl2QTYgZ8szPR9LryET6yzec=;
        b=IzrPVfBrWA8Tef9Fz9p9SiBte/PKhUjuRFPCpGG9WT3QMo9N8KcwnjevSNyK/xVw/w
         Np0ltFxbA8zV1XqyV+QaH1FwuE9LHsqyVHgYBt0dcjCSR1Vt3SxXlRd4hXPEYv8JdEre
         NISQwmr09vxyvI1qPaOkjVR/YovlHnk44ZstEwkOaBJ+P5lmdTZwDeMYRoTtIvYLt0Rp
         28UfyBaSeBwCqI9n/m/7XR9M56u2ZzLPsQ/GjT/VNjmyAwfhImIkudIz8bFOSPxJHVzE
         zPxC3+Kfo/vhDb/Fwmgqs0jgIWuPVOD9XShrE71a0TV83rr2QgJ39PJFS6XKIzZo4AFD
         BQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710372592; x=1710977392;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/PsnHM06LDrqbWXqebDpl2QTYgZ8szPR9LryET6yzec=;
        b=blyLGk74PDjCn0xLQub9znpc//9lw8j9B94+QFPiF4UsiULq9RBgK+qdTUJ+1Cr2Ex
         deA0WBmDv3zgIfc5cq2IjxN4fNi+eukbNLdZirlp284Q9SZw5YTNtjL8t693H503WanT
         FExSir54pstMfL5/kLQJYxyB5CL8ehSUAaDYoDUKKWnmEEoAERTuSKrrttmSU7IoEN7L
         EicdD1+NY7ET3LZKma6NbDsKh/l0120PKQruVLOSmcCoUxIrH8RqGRHbrlkHRacnxFTi
         DQMD+FUnFWAoPDPdcGeaHfmel5WvRJ9AgWjsGuY52ya8Nttsq5cgRRJifXKlIKxB5uOM
         Yu7w==
X-Forwarded-Encrypted: i=1; AJvYcCVxxUDJPwbCf5qkpUjTRd2VGOiuG4AhRhod6xZMLFQB4RyKi2qn6sKsUCX2lUm6lZqp1YLrY8jIxEhfd+eJioeCfaQ1x4Js9dFIhHucmyckyXoZAT6V1bO/qw1kS0vKO9/S
X-Gm-Message-State: AOJu0YxweBa9z98bSsre9a/rZrlnQU+E2hLRtQf28edyKHNnRPvDlv0H
	fTqNmMydr/EehDBm7zFA4O79eAAH5cSeIsKU+YmKW/6rEq8yqXal
X-Google-Smtp-Source: AGHT+IHC6YjXjCJXBBy9SRO0QiHib+w1HZMkCTnMRJycbsea2hGVd5YaUKIXnq42wATgEjz2bLYvWQ==
X-Received: by 2002:a81:a150:0:b0:609:f24d:d88a with SMTP id y77-20020a81a150000000b00609f24dd88amr127026ywg.8.1710372592555;
        Wed, 13 Mar 2024 16:29:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g4-20020ac842c4000000b0042f36f6f9edsm97930qtm.9.2024.03.13.16.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 16:29:51 -0700 (PDT)
Message-ID: <337ad5f0-bd1b-4dbf-a94b-681a21f0df45@gmail.com>
Date: Wed, 13 Mar 2024 16:29:48 -0700
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
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Joel Fernandes <joel@joelfernandes.org>, Boqun Feng
 <boqun.feng@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org,
 mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org,
 neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com,
 frederic@kernel.org, bigeasy@linutronix.de, chenzhongjin@huawei.com,
 yangjihong1@huawei.com, rostedt@goodmis.org,
 Justin Chen <justin.chen@broadcom.com>
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
 <ZfItZs756Bps2pFa@shell.armlinux.org.uk>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ZfItZs756Bps2pFa@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/13/24 15:49, Russell King (Oracle) wrote:
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
> Okay, so if that's two architectures failing, it's probably not an
> architecture specific issue. It could still be a timer/interrupt driver
> issue though. It would be nice to have a reproducer on x86 which would
> confirm it.
> 
> Do you know the frequency that the failure happens?

On this specific commit 7ee988770326fca440472200c3eb58935fe712f6, there 
is a 100% failure for at least 3 devices out of the 16 that are running 
the test.
-- 
Florian


