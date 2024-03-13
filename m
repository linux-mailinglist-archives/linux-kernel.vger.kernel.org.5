Return-Path: <linux-kernel+bounces-102534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3109A87B379
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 22:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98756B21759
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 21:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9EB53E16;
	Wed, 13 Mar 2024 21:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaDDWVTb"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF3A53815;
	Wed, 13 Mar 2024 21:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710365448; cv=none; b=HKb29xLIMxs4+dKSbbmtOMpuI8N8E7mb0m5Ul5M4mDrewrZx+Uo1cts06KYrCYaA87ZvFBSiywyJoWWxxo0kc0Ca6caUMkFEvZ4UVqVrU+7Gb+7BhK21d6rnAfU4w9i6HMvKDxTGBeBm+6ZhNjSiy8us5TKIvvhvPiUDSdSWlv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710365448; c=relaxed/simple;
	bh=zUzHP1+9uiZ3MhKtCadYAQhvnadfHIr6/GXhNi0GaxE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D2BKqziHutEmn4F87pmbQh9MY9/vRsWtKDO3khJwXnp0u2aSnNz0FM3Wt6Uy1aGPkxUCuuSJHFvovn7nLaFdEWdorjVkchC5o+4ChHd26dftV38vSf/2MpVdEEiF7o8fS1jfj6S8vb5a30KH0eic7cXb9NrUqa6zbddIjnupLKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PaDDWVTb; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso216228a12.3;
        Wed, 13 Mar 2024 14:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710365446; x=1710970246; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UnOoTkOZ5+huY8h66gL4Eil2OE1eAIyzEoJ1lw3EPyg=;
        b=PaDDWVTbOy+jJrNl0/10gwIXcL88GZ3mp3f1Z47rhn5mbcMz8f4p5PKsf3675QC/51
         vD7AN7K5crivXkCYb2guo0/A/OZbgew+aEr2CfxOxD/llu3MUMMqCTyjRdZVvV5N/vmM
         ZVW+qZuBb6sMz2Ek5I6CoaTBapDSow+YRm12JEOHK93aZXFuG3Gko3M3G835hncbE+lK
         v6Cftr+6xVataIjVKXAiXRO4TKoYgdWqz8z871DdYe36ALU1UgNgWZtHHSGpZc2z9zaI
         CJP1jqu5SIKAEQbrXBn+2VYJZhQjVQn6trVBK5/zqF7YFDkofA0rYn5ez3ZwOAWVA9ec
         SyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710365446; x=1710970246;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnOoTkOZ5+huY8h66gL4Eil2OE1eAIyzEoJ1lw3EPyg=;
        b=iYfLpMZ2sMWA4ym4ecLH/7jIbi7dXSEqckktagtoGhYP7o2KJw9wILFNq9ATKk9GVd
         /rcalZYif+l76Fp5OLbuccWwffeACmCMZtnt7bJA8OCSUkNhy3FpZZarsojUQ3GLEhoW
         ipIGQmUdPKsvO99FCQdTk23rw0PxTIbcPFDHCU/jbHa/V5lD+nAFEYKLouHbMqTTNWwp
         yvznUq8RwWaFHwqxkM34yPp7Od07i/mAJuox63tBK+m6ce3ydmO0mSJhRfGOK+CVcHm0
         nPQg9+/1F+SbUJ//Qkow8ATKHyhylfgPbhN6tXfLwUcI68YQecSMb1NrkUFyzDx3cPRx
         8jVg==
X-Forwarded-Encrypted: i=1; AJvYcCX57bYACaGz9ktPVoZ84FXJdCkBj8bx1UDyLCspgSTyI0qxyIdMMoP49PodeV4R46IPuPPvoCGXNalzdHBQpUINIf5L6cMnueZASq1/bHY+Bdt60Mb6bg8bDyajaZkmYKS4
X-Gm-Message-State: AOJu0YxAhhE4dnpYrCaXsEAyQ5ojudyT+ZVVn0Gaf+W7h7XD16LlIOF0
	G8HGkPYXfDXwRGGO8h/A+KRqk3dYZ5hlxsCUjH84kh2CnDBU2zJW
X-Google-Smtp-Source: AGHT+IExiJ6nSuE23iCLP+jOoJCC+tmjqrzXNpIwrn7F74VU6VEwNTk7Wehps5OSwg4vsonxu0ID0g==
X-Received: by 2002:a17:90b:4d85:b0:29b:82ee:13f with SMTP id oj5-20020a17090b4d8500b0029b82ee013fmr7603326pjb.11.1710365446448;
        Wed, 13 Mar 2024 14:30:46 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ne4-20020a17090b374400b0029c5ee381dfsm101201pjb.26.2024.03.13.14.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 14:30:45 -0700 (PDT)
Message-ID: <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com>
Date: Wed, 13 Mar 2024 14:30:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for
 v6.9]
To: Joel Fernandes <joel@joelfernandes.org>, Boqun Feng
 <boqun.feng@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org,
 mingo@kernel.org, tglx@linutronix.de, rcu@vger.kernel.org,
 neeraj.upadhyay@amd.com, urezki@gmail.com, qiang.zhang1211@gmail.com,
 frederic@kernel.org, bigeasy@linutronix.de, anna-maria@linutronix.de,
 chenzhongjin@huawei.com, yangjihong1@huawei.com, rostedt@goodmis.org,
 Justin Chen <justin.chen@broadcom.com>
References: <ZetHwrCb0KXE0xFI@tardis>
 <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
 <ZfDEIs63EBIYBJIC@boqun-archlinux>
 <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
 <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux>
 <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Adding Anna-Maria and Russell,

On 3/13/24 09:01, Joel Fernandes wrote:
> Hello Florian,
> 
> On Tue, Mar 12, 2024 at 7:48 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>>
>> On Tue, Mar 12, 2024 at 02:44:14PM -0700, Linus Torvalds wrote:
>>> On Tue, 12 Mar 2024 at 14:34, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>>>
>>>> and here is a log where this fails:
>>>>
>>>> https://gist.github.com/ffainelli/ed08a2b3e853f59343786ebd20364fc8
>>>
>>> You could try the 'initcall_debug' kernel command line.
>>>
>>
>> Right, that'll be helpful.
>>
>> Besides I took a look at the config Florian shared, no TASKS_RCU,
>> RCU_LAZY or RCU nocb is enabled. So probably the only left changes in
>> the PR are around RCU expedited. Florian, could you see if you can build
>> and test with CONFIG_PROVE_RCU=y (you need to select
>> CONFIG_PROVE_LOCKING for that)? That'll call synchronize_rcu() +
>> synchronize_rcu_expedited() before and after we switch
>> rcu_scheduler_active, and it may provide more information. Thanks!
> 
> Adding to everyone's suggestions, could you also try booting with
> "rcupdate.rcu_normal=1" ? This will disable expedited RCU and help us
> further confirm that it is indeed expedited RCU (and then we can look
> into fixing that).

Booting with "rcupdate.rcu_normal=1" did not make any difference here, 
this is looking less and less RCU related, but somewhere else, see below.

> 
> Also there are 2 additional users of expedited RCU in this release I noticed:
> 
> 78c3253f27e5 ("net: use synchronize_rcu_expedited in cleanup_net()")
> 1ebb85f9c03d ("netfilter: conntrack: expedite rcu in
> nf_conntrack_cleanup_net_list")
> 
> Could you also try reverting those patches as well, and see if the
> issue goes away
Sorry had been chasing another regression, with one down, I could 
finally get back to this one.

I will try to provide multiple answers for the sake of everyone having 
the same context. Responding to Linus' specifically and his suggestion 
to use "initcall_debug", this is what it gave me:

[    6.970669] ata1: SATA link down (SStatus 0 SControl 300)
[  166.136366] probe of unimac-mdio-0:01 returned 0 after 159216218 usecs
[  166.142931] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
[  166.148900] probe of unimac-mdio.0 returned 0 after 159243553 usecs
[  166.155820] probe of f0480000.ethernet returned 0 after 159258794 usecs
[  166.166427] ehci-brcm f0b00300.ehci_v2: EHCI Host Controller

Also got another occurrence happening resuming from suspend to DRAM with:

[   22.570667] brcmstb-dpfe 9932000.dpfe-cpu: PM: calling 
platform_pm_resume+0x0/0x54 @ 1574, parent: rdb
[  181.643809] brcmstb-dpfe 9932000.dpfe-cpu: PM: 
platform_pm_resume+0x0/0x54 returned 0 after 159073134 usecs

and also with the PCIe root complex driver:

[   18.266279] brcm-pcie f0460000.pcie: PM: calling 
brcm_pcie_resume_noirq+0x0/0x164 @ 1597, parent: platform
[  177.457219] brcm-pcie f0460000.pcie: clkreq-mode set to default
[  177.457225] brcm-pcie f0460000.pcie: link up, 2.5 GT/s PCIe x1 (!SSC)
[  177.457231] brcm-pcie f0460000.pcie: PM: 
brcm_pcie_resume_noirq+0x0/0x164 returned 0 after 159190939 usecs
[  177.457257] pcieport 0000:00:00.0: PM: calling 
pci_pm_resume_noirq+0x0/0x160 @ 33, parent: pci0000:00

Surprisingly those drivers are consistently reproducing the failures I 
am seeing so at least this gave me a clue as to where the problem is.

There were no changes to drivers/net/ethernet/broadcom/genet/, the two 
changes done to drivers/net/mdio/mdio-bcm-unimac.c are correct, 
especially the read_poll_timeout() conversion is correct, we properly 
break out of the loop. The initial delay looked like a good culprit for 
a little while, but it is not used on the affected platforms because 
instead we provide a callback and we have an interrupt to signal the 
completion of a MDIO operation, therefore unimac_mdio_poll() is not used 
at all. Finally drivers/memory/brcmstb_dpfe.c also received a single 
change which is not functional here (.remove function change do return 
void).

I went back to a manual bisection and this time I believe that I have a 
more plausible candidate with:

7ee988770326fca440472200c3eb58935fe712f6 ("timers: Implement the 
hierarchical pull model")

7ee988770326fca440472200c3eb58935fe712f6~1 is stable, and 
7ee988770326fca440472200c3eb58935fe712f6 consistently reproduces this 
long boot delay on multiple platforms, so we finally have something here.

This seems to be very specific to the ARM 32-bit architecture, and 
booting the same system with an ARM64 kernel does not expose the 
problem, even though the timer hardware is the same (ARM v7/v8 
architected timer).

Let me know if there is any debugging that you want me to add.

Thanks to everyone for your help so far, this is much appreciated!
--
Florian


