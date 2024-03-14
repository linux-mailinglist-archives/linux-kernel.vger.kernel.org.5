Return-Path: <linux-kernel+bounces-103694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A3F87C311
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EBB2282237
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB3D74E23;
	Thu, 14 Mar 2024 18:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IU6CQVt9"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9416271750;
	Thu, 14 Mar 2024 18:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442305; cv=none; b=bv+FX92bYHzB0ybIedkTll2IUwNCmNbo/7ulHtrhB/NsIhi7owni5mPjiOLWi1DgFm2Ew2VHFWJHnKmbjZ/96dzzNdLs8SqzxuKW3irTNj/AYnyFFQRZy16k3mubOj4ylwkEZ959cHk+u5cjaw/C1zCihqfbgZ4iBzSIcwmsCEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442305; c=relaxed/simple;
	bh=8pgJmR+NuPGKwTI96hNmu9LNA5hPtV2MSHVAXlE93+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQUzQ+L5ZsI3D1Xt5XYbl/CjaO4ik1U7P0W1VAhwpwXbfjso3EI4LfxfyA2hCiqARtXNfXQ5U65PEuSRI3wCsoitFdSFEpRmYUIM0bmDcvuCVVKPiVB3/E0V426sLIiMtbU5bC1nEhBGvyq/M5YtnIlaZ2AMBEFvTSK2Tckl54E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IU6CQVt9; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-47310400a8dso327237137.1;
        Thu, 14 Mar 2024 11:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710442302; x=1711047102; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=toODvDUC/+WhYeLF1bUl1RzXkO/tMdgdcuyp40H3v8c=;
        b=IU6CQVt93U53BEmJvxn2Rk/ptq/Q+fNQh5a1L2+JipTEgVXWkBY3CwN7P8jSEFBp5h
         zgjinp+Dj7jS3SAldjrQIjXIhH9Cjqt+DNhqf1ebgtUHgXeMzpxSL16PyvFz7aPwWXDL
         lU7Ufsw8blvysLMC5XxbiYJes3vPRL5oVCT0VmSvWUmkEjqU1NrQh2wPPdLct1sej4lN
         sT/n4aG4so1uXWzDZBDfyLm6wn5nu3oiWZB+ka1fOEPO4v185AMN2zKeNRQPJ3vLbQ/o
         Jt30TWhtqcTLxvwTBTKdYSuWUxhU0frw4GBwvr3AEB575/8X0PuftqjEWdfZ6o7vsjyE
         fIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710442302; x=1711047102;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=toODvDUC/+WhYeLF1bUl1RzXkO/tMdgdcuyp40H3v8c=;
        b=c8cxnkJ066MdUcgf/A/C0xozFJAzjQCUMib2KVCvLYn7fb6eXXsj6g+BWVmB4tmYol
         ulg1eRFLqfgskibyXDs6BBCO5mFN+LWUNRzP3tQjQV+XWZeAPLvaNnl/EtQ2gqTiI6CL
         UnTuOThoidOrWOnLP9Kzg5DPMxxSKPtWJ336wJt/48hYjMvildmyt5nrSG1f93+smFPg
         huxF90SKvikhVSadc63IuvoUdxM0+xqK1Gp4uKQf/3ZszDfTo2pIQhG2LE6s2o71+JWp
         ShYIshU0OGpa+vTH80S6RUa+oR/rsDg92cKyjz5x0s+L0mQwS9ne2n/7BgUawajFnlJz
         1RhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV9YtazCQw1YGxx6bpS89llv65TdAXruHr1jVowms8p2zkWaCOhROY5mfBoApxfPrR9EUb1HFmkPDajB7qVSMeLUxSDlcpH62jjiYox1abSe4r3nKdzJkQsSfBEC9UTYGG
X-Gm-Message-State: AOJu0YybHZ4cOD9LsCZMC/FKhvd+ADmk5eWHHDbwFkPd5KNTC70obymZ
	H6t2iN2qITQ9g6uYQ4Sa7gk6UXNi0KcWx7Wfhzdt1cVqrl477hB7YW2A82Pe
X-Google-Smtp-Source: AGHT+IEGH8J46Zs9d09rqB0kuNHXqOxdpjJJPl0a7yk/kPrhlWuyrsughFEBeaEI2vACYx95D15rTw==
X-Received: by 2002:a05:6102:32c6:b0:474:c54c:67b1 with SMTP id o6-20020a05610232c600b00474c54c67b1mr1434964vss.0.1710442302207;
        Thu, 14 Mar 2024 11:51:42 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id a9-20020a0562140c2900b0068f0ff36defsm803841qvd.47.2024.03.14.11.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 11:51:41 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailauth.nyi.internal (Postfix) with ESMTP id 2BF0527C0060;
	Thu, 14 Mar 2024 14:51:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 14 Mar 2024 14:51:41 -0400
X-ME-Sender: <xms:PEfzZSs7p2Pn5XpUvhis_tPqjuPb4R9RTTFGbeBMv3HubE6WK-fXfg>
    <xme:PEfzZXfv9soBo2icH2vMI_aspbZrJtgoNN34okVkzi5nNO50YQDopQGzFRTE33XMf
    -XRdY5_1n4YY331WA>
X-ME-Received: <xmr:PEfzZdw3XTHXkJRB6cIYDrQXohTg3OWjUyCh-4hhCQjshEqjH331eR-G6oXqRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeejgdduudehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeffleejleehveelteeltedugffhhedvkefgvdehfeeiffeihfeigfdvtdeu
    hfdtteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvg
X-ME-Proxy: <xmx:PEfzZdPck1DZQLQQeq5X95hA5dPYxv8Q8bfFblfLy_0KuttKsZ4L9A>
    <xmx:PEfzZS9cIvCkY8wJjkPE19ACv2dqq7bSaNS2RiUkTN2dL37AaktNpw>
    <xmx:PEfzZVUWrltozavrkPo0Ze57VpFUCDrCe0Vir9EFV1MQJj5C9yclmA>
    <xmx:PEfzZbdxKTBAQlZ9FYlQHsM5KeJxkBWnZFsAn7oFlEXmK1lxL4UOKw>
    <xmx:PUfzZYlQOvQWPa3qNGW4H8_NvicdkaEOxdYRpn4b8t7WbNM5EBXWOw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 14:51:39 -0400 (EDT)
Date: Thu, 14 Mar 2024 11:51:34 -0700
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
Message-ID: <ZfNHNvzpqf8DOZd8@boqun-archlinux>
References: <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux>
 <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
 <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com>
 <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
 <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
 <ZfIuRMo8oKbR08Af@lothringen>
 <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
 <ZfLUU+XuQC7W79tf@lothringen>
 <d6c8e4fe-17bf-443d-a6f5-54470390e1fd@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6c8e4fe-17bf-443d-a6f5-54470390e1fd@gmail.com>

On Thu, Mar 14, 2024 at 11:35:23AM -0700, Florian Fainelli wrote:
> On 3/14/24 03:41, Frederic Weisbecker wrote:
> > On Wed, Mar 13, 2024 at 08:44:07PM -0700, Florian Fainelli wrote:
> > > 
> > > 
> > > On 3/13/2024 3:52 PM, Frederic Weisbecker wrote:
> > > > On Wed, Mar 13, 2024 at 03:04:26PM -0700, Florian Fainelli wrote:
> > > > > On 3/13/24 14:59, Russell King (Oracle) wrote:
> > > > > > On Wed, Mar 13, 2024 at 02:30:43PM -0700, Florian Fainelli wrote:
> > > > > > > I will try to provide multiple answers for the sake of everyone having the
> > > > > > > same context. Responding to Linus' specifically and his suggestion to use
> > > > > > > "initcall_debug", this is what it gave me:
> > > > > > > 
> > > > > > > [    6.970669] ata1: SATA link down (SStatus 0 SControl 300)
> > > > > > > [  166.136366] probe of unimac-mdio-0:01 returned 0 after 159216218 usecs
> > > > > > > [  166.142931] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
> > > > > > > [  166.148900] probe of unimac-mdio.0 returned 0 after 159243553 usecs
> > > > > > > [  166.155820] probe of f0480000.ethernet returned 0 after 159258794 usecs
> > > > > > > [  166.166427] ehci-brcm f0b00300.ehci_v2: EHCI Host Controller
> > > > > > > 
> > > > > > > Also got another occurrence happening resuming from suspend to DRAM with:
> > > > > > > 
> > > > > > > [   22.570667] brcmstb-dpfe 9932000.dpfe-cpu: PM: calling
> > > > > > > platform_pm_resume+0x0/0x54 @ 1574, parent: rdb
> > > > > > > [  181.643809] brcmstb-dpfe 9932000.dpfe-cpu: PM:
> > > > > > > platform_pm_resume+0x0/0x54 returned 0 after 159073134 usecs
> > > > > > > 
> > > > > > > and also with the PCIe root complex driver:
> > > > > > > 
> > > > > > > [   18.266279] brcm-pcie f0460000.pcie: PM: calling
> > > > > > > brcm_pcie_resume_noirq+0x0/0x164 @ 1597, parent: platform
> > > > > > > [  177.457219] brcm-pcie f0460000.pcie: clkreq-mode set to default
> > > > > > > [  177.457225] brcm-pcie f0460000.pcie: link up, 2.5 GT/s PCIe x1 (!SSC)
> > > > > > > [  177.457231] brcm-pcie f0460000.pcie: PM: brcm_pcie_resume_noirq+0x0/0x164
> > > > > > > returned 0 after 159190939 usecs
> > > > > > > [  177.457257] pcieport 0000:00:00.0: PM: calling
> > > > > > > pci_pm_resume_noirq+0x0/0x160 @ 33, parent: pci0000:00
> > > > > > > 
> > > > > > > Surprisingly those drivers are consistently reproducing the failures I am
> > > > > > > seeing so at least this gave me a clue as to where the problem is.
> > > > > > > 
> > > > > > > There were no changes to drivers/net/ethernet/broadcom/genet/, the two
> > > > > > > changes done to drivers/net/mdio/mdio-bcm-unimac.c are correct, especially
> > > > > > > the read_poll_timeout() conversion is correct, we properly break out of the
> > > > > > > loop. The initial delay looked like a good culprit for a little while, but
> > > > > > > it is not used on the affected platforms because instead we provide a
> > > > > > > callback and we have an interrupt to signal the completion of a MDIO
> > > > > > > operation, therefore unimac_mdio_poll() is not used at all. Finally
> > > > > > > drivers/memory/brcmstb_dpfe.c also received a single change which is not
> > > > > > > functional here (.remove function change do return void).
> > > > > > > 
> > > > > > > I went back to a manual bisection and this time I believe that I have a more
> > > > > > > plausible candidate with:
> > > > > > > 
> > > > > > > 7ee988770326fca440472200c3eb58935fe712f6 ("timers: Implement the
> > > > > > > hierarchical pull model")
> > > > > > 
> > > > > > I haven't understood the code there yet, and how it would interact with
> > > > > > arch code, but one thing that immediately jumps out to me is this:
> > > > > > 
> > > > > > "    As long as a CPU is busy it expires both local and global timers. When a
> > > > > >        CPU goes idle it arms for the first expiring local timer."
> > > > > > 
> > > > > > So are local timers "armed" when they are enqueued while the cpu is
> > > > > > "busy" during initialisation, and will they expire, and will that
> > > > > > expiry be delivered in a timely manner?
> > > > > > 
> > > > > > If not, this commit is basically broken, and would be the cause of the
> > > > > > issue you are seeing. For the mdio case, we're talking about 2ms
> > > > > > polling. For the dpfe case, it looks like we're talking about 1ms
> > > > > > sleeps. I'm guessing that these end up being local timers.
> > > > > > 
> > > > > > Looking at pcie-brcmstb, there's a 100ms msleep(), and then a polling
> > > > > > for link up every 5ms - if the link was down and we msleep(5) I wonder
> > > > > > if that's triggering the same issue.
> > > > > > 
> > > > > > Why that would manifest itself on 32-bit but not 64-bit Arm, I can't
> > > > > > say. I would imagine that the same hardware timer driver is being used
> > > > > > (may be worth checking DT.) The same should be true for the interrupt
> > > > > > driver as well. There's been no changes in that code.
> > > > > 
> > > > > I just had it happen with ARM64 I was plagued by:
> > > > > 
> > > > > https://lore.kernel.org/lkml/87wmqrjg8n.fsf@somnus/T/
> > > > > 
> > > > > and my earlier bisections somehow did not have ARM64 fail, so I thought it
> > > > > was immune but it fails with about the same failure rate as ARM 32-bit.
> > > > 
> > > > Can you please boot with:
> > > > 
> > > >       trace_event=timer_migration,timer_start,timer_expire_entry,timer_cancel
> > > > 
> > > > And add the following and give us the resulting output in dmesg?
> > > 
> > > Here are two logs from two different systems that exposed the problem on
> > > boot:
> > > 
> > > https://gist.github.com/ffainelli/f0834c52ef6320c9216d879ca29a4b81
> > > https://gist.github.com/ffainelli/dc838883edb925a77d8eb34c0fe95be0
> > 
> > Thanks! Unfortunately like Thomas pointed out, I'm missing the timer_migration
> > events. My fault, can you retry with this syntax?
> > 
> > 	trace_event=timer_migration:*,timer_start,timer_expire_entry,timer_cancel
> > 
> > Though it's fairly possible that timer migration is not enabled at this point
> > as it's a late initcall. But we better not miss its traces otherwise.
> 
> Here is another log with timer_migration:
> 
> https://gist.github.com/ffainelli/237a5f9928850d6d8900d1f36da45aee

FWIW, the trace point is still not enabled:

[    0.000000] Failed to enable trace event: timer_migration:*

you need this commit in master:

	36e40df35d2c "timer_migration: Add tracepoints"

, which is one commit later than 7ee988770326 AFAICT

Regards,
Boqun

> -- 
> Florian
> 

