Return-Path: <linux-kernel+bounces-103674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2365987C2D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:35:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8052863B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3F674C19;
	Thu, 14 Mar 2024 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVAuS0dh"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A07B74BF6;
	Thu, 14 Mar 2024 18:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441327; cv=none; b=Am99eDT/nTMSunjifbtQ/k2D0LJX+Tw8GghpuKc0jYj3PVpURMml6bUVMIvIKlg9t6RzQO4CwGyZ3o2uj1laF84NZppToV7UXwtsoUlYBlk8+3m+vwIEJl3DrhzDPl8FmBJmL9yKmT4Kv2HryZp1cjxJT2ihXFWXBfPEi1/iVLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441327; c=relaxed/simple;
	bh=BZGLXb11/LNpk0fcg3oHiiE/njTiaKJLGdfDNc3pWJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQe98kMzU6L8VmRFmwPJhwrZMMxXYV1mQQukm/rm659zFFWVq2difLVBb4dMuJHuHPZ/Xi7Ln7rX1d524Td7nBCQN+eJmRQnKfyfb9gnFH5dvIQ4FCa/Hv0OXFdh52vri3WKN9wslfVesV0rqGZHJfNOiaCJzHdjZsiw514kZHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVAuS0dh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dddad37712so12442925ad.3;
        Thu, 14 Mar 2024 11:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710441325; x=1711046125; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E7lSi385TiW3btX0NxkRwlF/HfafCFFm3tcK0+Lcqmg=;
        b=VVAuS0dh4gEjvATIHxCgeWpfv7I0/rKFnMDGNu28OHO1WSHH0DVaeOqGGhU6tFsg7R
         j8lGA+SKfH5jrQxa5QmPK9p83IR9ZJw41xwc/cJUKdN1mP9y8bIAW0TDQn9GaMGbVy5v
         phZlIG44Bd+I4pz8j+6fNfE+LQ4D+rDhj6A7Qvn9mtWT2DBAPEanHZ7UtNzZfgN3xm7W
         Lh4uvOf5aU+I6wyh/MgVrbLNMLA7U3D7DjR5Cowcvm75qSytmwgdtX9AUNEHiIhjcgmK
         cObtCsrS9W9UXOdCV26F1sQklTliq2xyeR+cdnqwOLBbzXVzfMvpqzpLSpyq4/8K6jVk
         bK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710441325; x=1711046125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E7lSi385TiW3btX0NxkRwlF/HfafCFFm3tcK0+Lcqmg=;
        b=KieFkUI4l1h5Y7c795AB2K7hWno53gufTYD4WmJASBLyQlS6zVuGjRrbKn29nwK+UX
         /zJvfoJLT4U1wNZ1OeoGUTk9smH7bMjePguk6xEPeggbrRpbipY2n612d9SkePZq8UGa
         EVn0EtWi5c5Y3D9HqSzff0GgoGDLTUo+4qKxEOaTnMYi8A1E0I0ypA6qML8F5NS4JPi9
         /Z8LNLumrrUNYtgX6ux+K9Biaj0pon/pXn1RDWEyn5DQ2Tji1hlUyk92qPpcDoflE1eI
         IZBghVkvWDFvBp/LCc8o0BIhO0fUOrWoDXaoyqzCAl27XqQHw8164sPpKIvRIGQzCkN+
         TuPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE51ljenLjpNMCXLOn9wNxgfEUf0OaVZam1GLJN2mGbvxrpPYLdSpfDz7yhAxQSVP4/pmvbhd7UTIRGHc1paj3ugiHQzpZ+NRZQFoDJ2zOxanQYEQ1KXEZ3YsL4T9BYSc0
X-Gm-Message-State: AOJu0Yxr0CZ8UT9N0cq/h9RoU0QMpGVDk7MQARDXrER8jQF+VGaf/G67
	IoAeDVcUNj6iVRO/vfNETzBWON63isFt3R5/xoqB7TnSOlCYhQJy
X-Google-Smtp-Source: AGHT+IHl475JFfJ/lVUviqTQ7+/WB02VTvwNd+8sBNs9Knb8Th1gwgrNJeF2WdwuQ2pEsGnGf3qi8w==
X-Received: by 2002:a17:902:d58d:b0:1de:e5aa:518a with SMTP id k13-20020a170902d58d00b001dee5aa518amr2150949plh.32.1710441325238;
        Thu, 14 Mar 2024 11:35:25 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id p15-20020a170902780f00b001dcc8c26393sm2084702pll.225.2024.03.14.11.35.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 11:35:24 -0700 (PDT)
Message-ID: <d6c8e4fe-17bf-443d-a6f5-54470390e1fd@gmail.com>
Date: Thu, 14 Mar 2024 11:35:23 -0700
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
References: <ZfDEIs63EBIYBJIC@boqun-archlinux>
 <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
 <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux>
 <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
 <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com>
 <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
 <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
 <ZfIuRMo8oKbR08Af@lothringen>
 <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
 <ZfLUU+XuQC7W79tf@lothringen>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ZfLUU+XuQC7W79tf@lothringen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 03:41, Frederic Weisbecker wrote:
> On Wed, Mar 13, 2024 at 08:44:07PM -0700, Florian Fainelli wrote:
>>
>>
>> On 3/13/2024 3:52 PM, Frederic Weisbecker wrote:
>>> On Wed, Mar 13, 2024 at 03:04:26PM -0700, Florian Fainelli wrote:
>>>> On 3/13/24 14:59, Russell King (Oracle) wrote:
>>>>> On Wed, Mar 13, 2024 at 02:30:43PM -0700, Florian Fainelli wrote:
>>>>>> I will try to provide multiple answers for the sake of everyone having the
>>>>>> same context. Responding to Linus' specifically and his suggestion to use
>>>>>> "initcall_debug", this is what it gave me:
>>>>>>
>>>>>> [    6.970669] ata1: SATA link down (SStatus 0 SControl 300)
>>>>>> [  166.136366] probe of unimac-mdio-0:01 returned 0 after 159216218 usecs
>>>>>> [  166.142931] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
>>>>>> [  166.148900] probe of unimac-mdio.0 returned 0 after 159243553 usecs
>>>>>> [  166.155820] probe of f0480000.ethernet returned 0 after 159258794 usecs
>>>>>> [  166.166427] ehci-brcm f0b00300.ehci_v2: EHCI Host Controller
>>>>>>
>>>>>> Also got another occurrence happening resuming from suspend to DRAM with:
>>>>>>
>>>>>> [   22.570667] brcmstb-dpfe 9932000.dpfe-cpu: PM: calling
>>>>>> platform_pm_resume+0x0/0x54 @ 1574, parent: rdb
>>>>>> [  181.643809] brcmstb-dpfe 9932000.dpfe-cpu: PM:
>>>>>> platform_pm_resume+0x0/0x54 returned 0 after 159073134 usecs
>>>>>>
>>>>>> and also with the PCIe root complex driver:
>>>>>>
>>>>>> [   18.266279] brcm-pcie f0460000.pcie: PM: calling
>>>>>> brcm_pcie_resume_noirq+0x0/0x164 @ 1597, parent: platform
>>>>>> [  177.457219] brcm-pcie f0460000.pcie: clkreq-mode set to default
>>>>>> [  177.457225] brcm-pcie f0460000.pcie: link up, 2.5 GT/s PCIe x1 (!SSC)
>>>>>> [  177.457231] brcm-pcie f0460000.pcie: PM: brcm_pcie_resume_noirq+0x0/0x164
>>>>>> returned 0 after 159190939 usecs
>>>>>> [  177.457257] pcieport 0000:00:00.0: PM: calling
>>>>>> pci_pm_resume_noirq+0x0/0x160 @ 33, parent: pci0000:00
>>>>>>
>>>>>> Surprisingly those drivers are consistently reproducing the failures I am
>>>>>> seeing so at least this gave me a clue as to where the problem is.
>>>>>>
>>>>>> There were no changes to drivers/net/ethernet/broadcom/genet/, the two
>>>>>> changes done to drivers/net/mdio/mdio-bcm-unimac.c are correct, especially
>>>>>> the read_poll_timeout() conversion is correct, we properly break out of the
>>>>>> loop. The initial delay looked like a good culprit for a little while, but
>>>>>> it is not used on the affected platforms because instead we provide a
>>>>>> callback and we have an interrupt to signal the completion of a MDIO
>>>>>> operation, therefore unimac_mdio_poll() is not used at all. Finally
>>>>>> drivers/memory/brcmstb_dpfe.c also received a single change which is not
>>>>>> functional here (.remove function change do return void).
>>>>>>
>>>>>> I went back to a manual bisection and this time I believe that I have a more
>>>>>> plausible candidate with:
>>>>>>
>>>>>> 7ee988770326fca440472200c3eb58935fe712f6 ("timers: Implement the
>>>>>> hierarchical pull model")
>>>>>
>>>>> I haven't understood the code there yet, and how it would interact with
>>>>> arch code, but one thing that immediately jumps out to me is this:
>>>>>
>>>>> "    As long as a CPU is busy it expires both local and global timers. When a
>>>>>        CPU goes idle it arms for the first expiring local timer."
>>>>>
>>>>> So are local timers "armed" when they are enqueued while the cpu is
>>>>> "busy" during initialisation, and will they expire, and will that
>>>>> expiry be delivered in a timely manner?
>>>>>
>>>>> If not, this commit is basically broken, and would be the cause of the
>>>>> issue you are seeing. For the mdio case, we're talking about 2ms
>>>>> polling. For the dpfe case, it looks like we're talking about 1ms
>>>>> sleeps. I'm guessing that these end up being local timers.
>>>>>
>>>>> Looking at pcie-brcmstb, there's a 100ms msleep(), and then a polling
>>>>> for link up every 5ms - if the link was down and we msleep(5) I wonder
>>>>> if that's triggering the same issue.
>>>>>
>>>>> Why that would manifest itself on 32-bit but not 64-bit Arm, I can't
>>>>> say. I would imagine that the same hardware timer driver is being used
>>>>> (may be worth checking DT.) The same should be true for the interrupt
>>>>> driver as well. There's been no changes in that code.
>>>>
>>>> I just had it happen with ARM64 I was plagued by:
>>>>
>>>> https://lore.kernel.org/lkml/87wmqrjg8n.fsf@somnus/T/
>>>>
>>>> and my earlier bisections somehow did not have ARM64 fail, so I thought it
>>>> was immune but it fails with about the same failure rate as ARM 32-bit.
>>>
>>> Can you please boot with:
>>>
>>>       trace_event=timer_migration,timer_start,timer_expire_entry,timer_cancel
>>>
>>> And add the following and give us the resulting output in dmesg?
>>
>> Here are two logs from two different systems that exposed the problem on
>> boot:
>>
>> https://gist.github.com/ffainelli/f0834c52ef6320c9216d879ca29a4b81
>> https://gist.github.com/ffainelli/dc838883edb925a77d8eb34c0fe95be0
> 
> Thanks! Unfortunately like Thomas pointed out, I'm missing the timer_migration
> events. My fault, can you retry with this syntax?
> 
> 	trace_event=timer_migration:*,timer_start,timer_expire_entry,timer_cancel
> 
> Though it's fairly possible that timer migration is not enabled at this point
> as it's a late initcall. But we better not miss its traces otherwise.

Here is another log with timer_migration:

https://gist.github.com/ffainelli/237a5f9928850d6d8900d1f36da45aee
-- 
Florian


