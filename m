Return-Path: <linux-kernel+bounces-102782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDC787B737
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAED285D98
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 05:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F8E8F7A;
	Thu, 14 Mar 2024 05:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghxH8o7O"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F81F8BFB;
	Thu, 14 Mar 2024 05:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710393139; cv=none; b=YID0/Z3e4zeOczJnTyGAWBHb9FlCe3jzcD8fVlYjWo31irmTAytaOYCCpdp8VD3pz+9RPPDBCrRdepJ5zB5BrW+X/7iLmJo8wdqTbZycXFPqOf3Fb3KiA4ky3xxNIFc2qJoeLwZHD8n0xaQZ7mjT1T4IzmFsd/qbtJ0kxUI5pZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710393139; c=relaxed/simple;
	bh=adngAk0uF4YJ5FET3mlqWGHf+y+vfC6YEzzY2V92Qho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DnGHnKixgAm8tCz6DXB4jwPKDpgR0vLysk8i3tbBUzJxnuYwh0+0dO6iNzw+OWUw8FfouqA8OjV6XD/RTI4ZQ96ABxjpjJTumZjgvxP0KJuKRY7oTH0/Q424Xkvn5Go1nex1ZpxesY3VWDIHAYtjnNRsO0VPc4TaxdbLjMefHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghxH8o7O; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-788598094c4so31508285a.0;
        Wed, 13 Mar 2024 22:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710393136; x=1710997936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8vyqOgH9KcS2/PFY8s3eKz30QDXn0VMZYP+mSM+hGg=;
        b=ghxH8o7OD147/zxLG6lzNJbptjHbsOvPuFAWS/M5oTjvGxjVaDrIfxnCvt/LbTm/CW
         burmPlOP6pBN80YFyCNTAXCUdw9/Cj2YLIReztGUZgOxmVfnHA5ZhuD0qeN0awsfpgFY
         dJP9KSfravTEMTXLp0vDTNmwb3vIObkV2XysqOZnMVF65bCchzJQ9rOkBDoEz9WuGKE8
         gQZH4N54MTXoyCJSmgbSrj/3nDOpHLm50lTQQ6WVWm7YTcvW7FP6KgD6fqzCWPBd4aSk
         9LD0HzQ8Dpg6VFFgA5GesbkHLpK0b4WDyNyuVsZjRL3trtku694P4vi5xXgLCRRGuLGD
         rdWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710393136; x=1710997936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U8vyqOgH9KcS2/PFY8s3eKz30QDXn0VMZYP+mSM+hGg=;
        b=N6Zcq1ib240GIjwPRpCBJMSPPF39kJ73GggwveoWl5Sj7rXAK5jXytILVDrN8QNef0
         aXZt6gFh6lQ+uPGUW2sv2iYfJkeKgU2lJI/6ejwwLRo2CpMem3uUmcwFzbf+QcexlHii
         60lp7oqw+8isk45F6zKBRIp6e+8oYyc7LRvxCWlcjl/AUwyPwf8Fy3BRmHEm59fVBzDj
         Z70nRXqK/tY1L+yMGxG/mBl28WMmejLyOAjXVI/SfBgBTit68JsHWUEp+0ajenH/KYQK
         y3ktIggyaWYN6w10Uca/LMCj0ZdWDzQdt1UGHcu7bHeA9h2da1f/JTXmAcMH9yMbWwh+
         N+Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXMg22v/6A5W4O0OXvwI1k/CaUiasQ2/z+7L+ywAbD+sV0rKeHsKYJPvCo4+xA7ggpvG5ECNMytt3dR/ivEf+h7acudtNo/DBZ0NwdNgqHT/ZubdZdR8O2hVhzDds2bSzFT
X-Gm-Message-State: AOJu0YxCyTuWDxNnX5TX56cMggvoF8l0OuBAPgnY0CIjGNDta3tsaknn
	vILS5VlxyWizA+0bleHuZ2k/eWvNrKEbMFg1+idThzIp4u+v12X2
X-Google-Smtp-Source: AGHT+IEqPh9Z/zU0jwH2pks9FLVfEWLxKuv9WrV3Nm8aSIf+qgcZqWzbAyCgeFwYtLLXbaGBj9/zbw==
X-Received: by 2002:a05:620a:2a0a:b0:789:cd5c:75da with SMTP id o10-20020a05620a2a0a00b00789cd5c75damr936914qkp.6.1710393135956;
        Wed, 13 Mar 2024 22:12:15 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id v7-20020a05620a090700b007887583762csm350845qkv.94.2024.03.13.22.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 22:12:13 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 328AB1200043;
	Thu, 14 Mar 2024 01:12:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 14 Mar 2024 01:12:13 -0400
X-ME-Sender: <xms:LIfyZUmhIEF5tLm_D7nF_ThGRQ_mlM3xO0upBSvU37sdO7kN_3P_dA>
    <xme:LIfyZT1eDlG0g9iSziErKNzJS3SICiA_xOHl3AtHv5-zHsdHvr4FJdWOLKG7gUTqI
    DSk1REKp-_yxrzA6A>
X-ME-Received: <xmr:LIfyZSpGZSncHMW_9oCk5gKrB2pWmyVkWRamavgFuIUeCdqTzplniCghmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeigdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepffeljeelheevleetleetudfghfehvdekgfdvheefieffiefhiefgvddtuefh
    tdetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgv
X-ME-Proxy: <xmx:LIfyZQkIxPzI1K81BQpXp_ZmCHE1JarjqRU-gy4uYCHChCnlgQYuww>
    <xmx:LIfyZS1GPzEtBTYpSfi4vApxOofgt5hY99Z5Ol0YrSJ9YtDuZch3pw>
    <xmx:LIfyZXvrXwlZ5FiU7wDNwH13DHdAjuhvWWWUhJ-EWEMlSnrPlZSrEw>
    <xmx:LIfyZeVWaV335e3psCmeWjjbIYSR4PsA0uHxYEUAOW9c8fTp-P2iWg>
    <xmx:LYfyZV93qszp-kZZqNM_qOD0Hy1VowsjkR2G1a20NDAy0qT3HlqfFC9eqsI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 01:12:11 -0400 (EDT)
Date: Wed, 13 Mar 2024 22:12:10 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Joel Fernandes <joel@joelfernandes.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	paulmck@kernel.org, mingo@kernel.org, tglx@linutronix.de,
	rcu@vger.kernel.org, neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, bigeasy@linutronix.de,
	chenzhongjin@huawei.com, yangjihong1@huawei.com,
	rostedt@goodmis.org, Justin Chen <justin.chen@broadcom.com>
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for
 v6.9]
Message-ID: <ZfKHKtt4ar6HyRKu@Boquns-Mac-mini.home>
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
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>

On Wed, Mar 13, 2024 at 08:44:07PM -0700, Florian Fainelli wrote:
> 
> 
> On 3/13/2024 3:52 PM, Frederic Weisbecker wrote:
> > On Wed, Mar 13, 2024 at 03:04:26PM -0700, Florian Fainelli wrote:
> > > On 3/13/24 14:59, Russell King (Oracle) wrote:
> > > > On Wed, Mar 13, 2024 at 02:30:43PM -0700, Florian Fainelli wrote:
> > > > > I will try to provide multiple answers for the sake of everyone having the
> > > > > same context. Responding to Linus' specifically and his suggestion to use
> > > > > "initcall_debug", this is what it gave me:
> > > > > 
> > > > > [    6.970669] ata1: SATA link down (SStatus 0 SControl 300)
> > > > > [  166.136366] probe of unimac-mdio-0:01 returned 0 after 159216218 usecs
> > > > > [  166.142931] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
> > > > > [  166.148900] probe of unimac-mdio.0 returned 0 after 159243553 usecs
> > > > > [  166.155820] probe of f0480000.ethernet returned 0 after 159258794 usecs
> > > > > [  166.166427] ehci-brcm f0b00300.ehci_v2: EHCI Host Controller
> > > > > 
> > > > > Also got another occurrence happening resuming from suspend to DRAM with:
> > > > > 
> > > > > [   22.570667] brcmstb-dpfe 9932000.dpfe-cpu: PM: calling
> > > > > platform_pm_resume+0x0/0x54 @ 1574, parent: rdb
> > > > > [  181.643809] brcmstb-dpfe 9932000.dpfe-cpu: PM:
> > > > > platform_pm_resume+0x0/0x54 returned 0 after 159073134 usecs
> > > > > 
> > > > > and also with the PCIe root complex driver:
> > > > > 
> > > > > [   18.266279] brcm-pcie f0460000.pcie: PM: calling
> > > > > brcm_pcie_resume_noirq+0x0/0x164 @ 1597, parent: platform
> > > > > [  177.457219] brcm-pcie f0460000.pcie: clkreq-mode set to default
> > > > > [  177.457225] brcm-pcie f0460000.pcie: link up, 2.5 GT/s PCIe x1 (!SSC)
> > > > > [  177.457231] brcm-pcie f0460000.pcie: PM: brcm_pcie_resume_noirq+0x0/0x164
> > > > > returned 0 after 159190939 usecs
> > > > > [  177.457257] pcieport 0000:00:00.0: PM: calling
> > > > > pci_pm_resume_noirq+0x0/0x160 @ 33, parent: pci0000:00
> > > > > 
> > > > > Surprisingly those drivers are consistently reproducing the failures I am
> > > > > seeing so at least this gave me a clue as to where the problem is.
> > > > > 
> > > > > There were no changes to drivers/net/ethernet/broadcom/genet/, the two
> > > > > changes done to drivers/net/mdio/mdio-bcm-unimac.c are correct, especially
> > > > > the read_poll_timeout() conversion is correct, we properly break out of the
> > > > > loop. The initial delay looked like a good culprit for a little while, but
> > > > > it is not used on the affected platforms because instead we provide a
> > > > > callback and we have an interrupt to signal the completion of a MDIO
> > > > > operation, therefore unimac_mdio_poll() is not used at all. Finally
> > > > > drivers/memory/brcmstb_dpfe.c also received a single change which is not
> > > > > functional here (.remove function change do return void).
> > > > > 
> > > > > I went back to a manual bisection and this time I believe that I have a more
> > > > > plausible candidate with:
> > > > > 
> > > > > 7ee988770326fca440472200c3eb58935fe712f6 ("timers: Implement the
> > > > > hierarchical pull model")
> > > > 
> > > > I haven't understood the code there yet, and how it would interact with
> > > > arch code, but one thing that immediately jumps out to me is this:
> > > > 
> > > > "    As long as a CPU is busy it expires both local and global timers. When a
> > > >       CPU goes idle it arms for the first expiring local timer."
> > > > 
> > > > So are local timers "armed" when they are enqueued while the cpu is
> > > > "busy" during initialisation, and will they expire, and will that
> > > > expiry be delivered in a timely manner?
> > > > 
> > > > If not, this commit is basically broken, and would be the cause of the
> > > > issue you are seeing. For the mdio case, we're talking about 2ms
> > > > polling. For the dpfe case, it looks like we're talking about 1ms
> > > > sleeps. I'm guessing that these end up being local timers.
> > > > 
> > > > Looking at pcie-brcmstb, there's a 100ms msleep(), and then a polling
> > > > for link up every 5ms - if the link was down and we msleep(5) I wonder
> > > > if that's triggering the same issue.
> > > > 
> > > > Why that would manifest itself on 32-bit but not 64-bit Arm, I can't
> > > > say. I would imagine that the same hardware timer driver is being used
> > > > (may be worth checking DT.) The same should be true for the interrupt
> > > > driver as well. There's been no changes in that code.
> > > 
> > > I just had it happen with ARM64 I was plagued by:
> > > 
> > > https://lore.kernel.org/lkml/87wmqrjg8n.fsf@somnus/T/
> > > 
> > > and my earlier bisections somehow did not have ARM64 fail, so I thought it
> > > was immune but it fails with about the same failure rate as ARM 32-bit.
> > 
> > Can you please boot with:
> > 
> >      trace_event=timer_migration,timer_start,timer_expire_entry,timer_cancel
> > 
> > And add the following and give us the resulting output in dmesg?
> 
> Here are two logs from two different systems that exposed the problem on
> boot:
> 

I found a pattern here, maybe related.

> https://gist.github.com/ffainelli/f0834c52ef6320c9216d879ca29a4b81

	[  163.244130] kworker/-31        3D.... 44007us : timer_start: timer=b089b886 function=delayed_work_timer_fn expires=4294672340 [timeout=5000] bucket_expiry=4294672384 cpu =3 idx=192 flags=D|I

^^^ this timer was supposed to expired after around 5000 jiffies (i.e. 5
second, since HZ=1000), but it expired way late (160 seconds later).

	[  163.261034] kworker/-31        3d.... 44012us : timer_start: timer=394b309f function=delayed_work_timer_fn expires=4294787991 [timeout=120651] bucket_expiry=4294791168 c pu=3 idx=277 flags=I
	...
	[  221.630578]   <idle>-0         1..s.. 3287405us : timer_expire_entry: timer=7e541f87 function=process_timeout now=4294670584 baseclk=4294670584
	[  221.643475]   <idle>-0         0d.s.. 162361292us : timer_cancel: timer=95703ccd
	[  221.650896]   <idle>-0         0..s.. 162361292us : timer_expire_entry: timer=95703ccd function=process_timeout now=4294829657 baseclk=4294670587

baseclk and now has a huge delta.
	...
	[  222.394471]   <idle>-0         3dns.. 162499420us : timer_cancel: timer=b089b886
	[  222.401893] kworker/-47        1d.... 162499420us : timer_start: timer=11162242 function=delayed_work_timer_fn expires=4294830997 [timeout=1201] bucket_expiry=4294831040 cpu=1 idx=175 flags=D|P|I
	[  222.419317]   <idle>-0         3dns.. 162499421us : timer_expire_entry: timer=b089b886 function=delayed_work_timer_fn now=4294829796 baseclk=4294672384

and the same pattern for the following:

> https://gist.github.com/ffainelli/dc838883edb925a77d8eb34c0fe95be0

	[  162.855009] kworker/-31        3D.... 34849us : timer_start: timer=c48c9b47 function=delayed_work_timer_fn expires=4294672330 [timeout=5000] bucket_expiry=4294672384 cpu =3 idx=192 flags=D|I
	[  162.871903] kworker/-31        3d.... 34854us : timer_start: timer=c1ab7696 function=delayed_work_timer_fn expires=4294787991 [timeout=120661] bucket_expiry=4294791168 c pu=3 idx=277 flags=I
	...
	[  218.724285]   <idle>-0         2..s.. 2938198us : timer_expire_entry: timer=f3c19512 function=process_timeout now=4294670234 baseclk=4294670234
	[  218.737175]   <idle>-0         0d.s.. 162011087us : timer_cancel: timer=829432ce
	[  218.744589]   <idle>-0         0d.s.. 162011088us : timer_expire_entry: timer=829432ce function=delayed_work_timer_fn now=4294829306 baseclk=4294670400
	...
	[  219.171101]   <idle>-0         3dns.. 162025222us : timer_cancel: timer=c48c9b47
	[  219.178516]   <idle>-0         3dns.. 162025222us : timer_expire_entry: timer=c48c9b47 function=delayed_work_timer_fn now=4294829321 baseclk=4294672384

Regards,
Boqun

> 
> thanks!
> -- 
> Florian

