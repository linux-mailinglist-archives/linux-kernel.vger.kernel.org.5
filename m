Return-Path: <linux-kernel+bounces-102881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C5087B7FA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B27C1F21F9D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C3C4A03;
	Thu, 14 Mar 2024 06:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfw6EsqJ"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8892107;
	Thu, 14 Mar 2024 06:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710397989; cv=none; b=YJxhw7f3vmePRmjckuUZvzV/XQU7Dw8xH08g1agdwJvQVFEWeFQ4Ta0Yv1b3okMp7MQRh/lMosFs6CPUG4XgqxPeHx9UPbFc8occ2/cpPwt//Ww3C7tn4NPT8/pExW1FUWiVQ1Kg/YvWCSsrOTLptwrJ0bBV+OcQtbWkcyZ7lk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710397989; c=relaxed/simple;
	bh=JREUaYIzmw23F3qZLagjrzXJ/nYk1/tWnql3BvD7gpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NI8dyu78gp0F1UxXZ+Kp4fn/JmvcB6la0CybZ2rF3uLpG7K42Jktjheu5QUD1z7GdrxsI3t2uiYGuQsRRNNE+cVS/zsVu+HaB5IWN+SDjCZT0NX92/VMKUWp8YHkjsKLkCOdRpkQju3SHe5wFtBmeqmnN1SAUiU4ozq3O0cIvu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cfw6EsqJ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c19e18470aso484141b6e.1;
        Wed, 13 Mar 2024 23:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710397986; x=1711002786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fzcZHh1jZiQwAFamoYOv8hYIGDtvvPG9onbC8+ulskc=;
        b=cfw6EsqJJxkCSNdsSFh5gy1tJQk3XnlF6P+V00MvKjozjAY1Kfl7y5Ttr8al5Z6T7V
         TQD14bGIAtZkg3nxyoAySG0l0IwsIeGEgFWx3H8XKZlFRKmeMStfadTyFzrUiaaK3ThY
         5JvuS4hJLca2Nao+TI0s9epr0oQWpNIyaAfUwE4iaR6bsnndUfYvraX37KkU0+AZSPUq
         mwwwDuu8aE7QRdEG9aO72PdNcde7cCVRjLp5w2M5J/rW+T2rJFofCqM/oh6Y8ePr4pyH
         vgZ9fpAX5bncM9966EIeaNshpgMH5WmeZMLW5hHwrln3PC3vQhxpMr+26bsRVnaAD1a5
         LKTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710397986; x=1711002786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fzcZHh1jZiQwAFamoYOv8hYIGDtvvPG9onbC8+ulskc=;
        b=o/OkOa6n5wiRhS5P8Oc9ztS8a+SsZJUNDCmBLvZgfEguGxaLPmE4uEOF36cSzjLTkt
         cN5mhn8NBkCrJnPL0ywWBGuA8+G+AdjL7kuytdLhnEgyUXivm1NsHRMVLCFuhmUmIJFB
         kYRyswGs/sofY9AtaTs75x/7f9AGIDhIMqJnrV56e+1xxkJu8AYeCDAZxBDdW3fS+rDV
         zJUTCNoAQ/PaOBeZdZyBADNYG/urPkJ3zWiFZ90iXQL+MHJd+6snwUzDD5BH9BVZAjAR
         QK9QAwaXgpB4SmEwKUL+gEftw27SrwJFhHX1o12kesW2lYE9VRUQbUSItm5RyzJOpNjr
         Vavg==
X-Forwarded-Encrypted: i=1; AJvYcCWtgxzNxnqJa6wRHySQrq3370nNUjehb1mDdpXdU1xGwTfJMwMs6UmwvhtoZIj5XcDasIWjXhR9Lg36su2hI6uF8lvyCNxXnRt6nBKLxNxecqi9AAVyyAy3ueF1NczX9do7
X-Gm-Message-State: AOJu0YwbUCBsZT2zTygVBAgTf+DRx4Vr7LEoajWirh06zuob5WwW0W6B
	MQvMGm3yNFdX9Ave33p2aqGQ5MpDZdoxxzY1rY//pL5AqO2a8S/c
X-Google-Smtp-Source: AGHT+IGaNi5G7jbXwbFxWPNrCEE7eb9S/Eipc2fV+otEZq8228DVHg19f4NIuWskG6beYVt6fNSfpA==
X-Received: by 2002:a05:6808:30e:b0:3c1:33c7:68bb with SMTP id i14-20020a056808030e00b003c133c768bbmr857680oie.31.1710397985341;
        Wed, 13 Mar 2024 23:33:05 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id l9-20020ae9f009000000b0078861edc3bdsm421097qkg.2.2024.03.13.23.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 23:33:04 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 0C1A61200043;
	Thu, 14 Mar 2024 02:33:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 14 Mar 2024 02:33:04 -0400
X-ME-Sender: <xms:H5ryZcEnHwgxCnvaNfZpsRdJaT8Ud9_PSWSsZcl8tN2KmmyXJybqbQ>
    <xme:H5ryZVVv3b6h9Thuc4hxdZLlxyYYEAp_e7vBhhbIKO2bdMcbKzOD-xiBhceplpiFj
    D6fjk1kerhZvGSepA>
X-ME-Received: <xmr:H5ryZWIdC4YdX_QchQZ5zInjj4oBkuu1EqW9oHOPR-Rnsbzd85uQXMGFqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeeigdeludcutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:H5ryZeH6XGb-KRY6dPgW9FlTHN6eDqbn8WuC2lPYBL1RR01asMopKA>
    <xmx:H5ryZSW8rMD-M76nSyzgjnNbCqRG4sARULEWy3yTTfqxytkbFimNuQ>
    <xmx:H5ryZRP2l0PqsozttAtoJ0Ncg-xOdq-h8StkpWNr7DK6_oBtjjV2sQ>
    <xmx:H5ryZZ1p6hSziTFwsCA1AfoX7kJYJwtSa_uL6jmDc6JA7dVWorlk7w>
    <xmx:IJryZbf41ezUKPekP3dq6YXlUa2fMqdtsB09OnQCX5oRR_FhoSwrZijuVDg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 02:33:03 -0400 (EDT)
Date: Wed, 13 Mar 2024 23:33:01 -0700
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
Message-ID: <ZfKaHQXdYCKrT3Yr@Boquns-Mac-mini.home>
References: <c5f9c640-4c06-495e-9c7e-0c208b914fa7@gmail.com>
 <CAHk-=wgP=9JxdOJ5oYtVO5yM6pFi5+3FPxfCQa4ezpagJuXq3g@mail.gmail.com>
 <ZfDptafiK0jns050@boqun-archlinux>
 <CAEXW_YRvz8xf-6hpwpYqS=YNa-xkn4CsuJzELJxOH_2FP+6ptQ@mail.gmail.com>
 <2fb110ed-ba04-4320-9ef0-8766c9df5578@gmail.com>
 <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
 <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
 <ZfIuRMo8oKbR08Af@lothringen>
 <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
 <ZfKHKtt4ar6HyRKu@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfKHKtt4ar6HyRKu@Boquns-Mac-mini.home>

On Wed, Mar 13, 2024 at 10:12:10PM -0700, Boqun Feng wrote:
> On Wed, Mar 13, 2024 at 08:44:07PM -0700, Florian Fainelli wrote:
> > 
> > 
> > On 3/13/2024 3:52 PM, Frederic Weisbecker wrote:
> > > On Wed, Mar 13, 2024 at 03:04:26PM -0700, Florian Fainelli wrote:
> > > > On 3/13/24 14:59, Russell King (Oracle) wrote:
> > > > > On Wed, Mar 13, 2024 at 02:30:43PM -0700, Florian Fainelli wrote:
> > > > > > I will try to provide multiple answers for the sake of everyone having the
> > > > > > same context. Responding to Linus' specifically and his suggestion to use
> > > > > > "initcall_debug", this is what it gave me:
> > > > > > 
> > > > > > [    6.970669] ata1: SATA link down (SStatus 0 SControl 300)
> > > > > > [  166.136366] probe of unimac-mdio-0:01 returned 0 after 159216218 usecs
> > > > > > [  166.142931] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
> > > > > > [  166.148900] probe of unimac-mdio.0 returned 0 after 159243553 usecs
> > > > > > [  166.155820] probe of f0480000.ethernet returned 0 after 159258794 usecs
> > > > > > [  166.166427] ehci-brcm f0b00300.ehci_v2: EHCI Host Controller
> > > > > > 
> > > > > > Also got another occurrence happening resuming from suspend to DRAM with:
> > > > > > 
> > > > > > [   22.570667] brcmstb-dpfe 9932000.dpfe-cpu: PM: calling
> > > > > > platform_pm_resume+0x0/0x54 @ 1574, parent: rdb
> > > > > > [  181.643809] brcmstb-dpfe 9932000.dpfe-cpu: PM:
> > > > > > platform_pm_resume+0x0/0x54 returned 0 after 159073134 usecs
> > > > > > 
> > > > > > and also with the PCIe root complex driver:
> > > > > > 
> > > > > > [   18.266279] brcm-pcie f0460000.pcie: PM: calling
> > > > > > brcm_pcie_resume_noirq+0x0/0x164 @ 1597, parent: platform
> > > > > > [  177.457219] brcm-pcie f0460000.pcie: clkreq-mode set to default
> > > > > > [  177.457225] brcm-pcie f0460000.pcie: link up, 2.5 GT/s PCIe x1 (!SSC)
> > > > > > [  177.457231] brcm-pcie f0460000.pcie: PM: brcm_pcie_resume_noirq+0x0/0x164
> > > > > > returned 0 after 159190939 usecs
> > > > > > [  177.457257] pcieport 0000:00:00.0: PM: calling
> > > > > > pci_pm_resume_noirq+0x0/0x160 @ 33, parent: pci0000:00
> > > > > > 
> > > > > > Surprisingly those drivers are consistently reproducing the failures I am
> > > > > > seeing so at least this gave me a clue as to where the problem is.
> > > > > > 
> > > > > > There were no changes to drivers/net/ethernet/broadcom/genet/, the two
> > > > > > changes done to drivers/net/mdio/mdio-bcm-unimac.c are correct, especially
> > > > > > the read_poll_timeout() conversion is correct, we properly break out of the
> > > > > > loop. The initial delay looked like a good culprit for a little while, but
> > > > > > it is not used on the affected platforms because instead we provide a
> > > > > > callback and we have an interrupt to signal the completion of a MDIO
> > > > > > operation, therefore unimac_mdio_poll() is not used at all. Finally
> > > > > > drivers/memory/brcmstb_dpfe.c also received a single change which is not
> > > > > > functional here (.remove function change do return void).
> > > > > > 
> > > > > > I went back to a manual bisection and this time I believe that I have a more
> > > > > > plausible candidate with:
> > > > > > 
> > > > > > 7ee988770326fca440472200c3eb58935fe712f6 ("timers: Implement the
> > > > > > hierarchical pull model")
> > > > > 
> > > > > I haven't understood the code there yet, and how it would interact with
> > > > > arch code, but one thing that immediately jumps out to me is this:
> > > > > 
> > > > > "    As long as a CPU is busy it expires both local and global timers. When a
> > > > >       CPU goes idle it arms for the first expiring local timer."
> > > > > 
> > > > > So are local timers "armed" when they are enqueued while the cpu is
> > > > > "busy" during initialisation, and will they expire, and will that
> > > > > expiry be delivered in a timely manner?
> > > > > 
> > > > > If not, this commit is basically broken, and would be the cause of the
> > > > > issue you are seeing. For the mdio case, we're talking about 2ms
> > > > > polling. For the dpfe case, it looks like we're talking about 1ms
> > > > > sleeps. I'm guessing that these end up being local timers.
> > > > > 
> > > > > Looking at pcie-brcmstb, there's a 100ms msleep(), and then a polling
> > > > > for link up every 5ms - if the link was down and we msleep(5) I wonder
> > > > > if that's triggering the same issue.
> > > > > 
> > > > > Why that would manifest itself on 32-bit but not 64-bit Arm, I can't
> > > > > say. I would imagine that the same hardware timer driver is being used
> > > > > (may be worth checking DT.) The same should be true for the interrupt
> > > > > driver as well. There's been no changes in that code.
> > > > 
> > > > I just had it happen with ARM64 I was plagued by:
> > > > 
> > > > https://lore.kernel.org/lkml/87wmqrjg8n.fsf@somnus/T/
> > > > 
> > > > and my earlier bisections somehow did not have ARM64 fail, so I thought it
> > > > was immune but it fails with about the same failure rate as ARM 32-bit.
> > > 
> > > Can you please boot with:
> > > 
> > >      trace_event=timer_migration,timer_start,timer_expire_entry,timer_cancel
> > > 
> > > And add the following and give us the resulting output in dmesg?
> > 
> > Here are two logs from two different systems that exposed the problem on
> > boot:
> > 
> 
> I found a pattern here, maybe related.
> 
> > https://gist.github.com/ffainelli/f0834c52ef6320c9216d879ca29a4b81
> 
> 	[  163.244130] kworker/-31        3D.... 44007us : timer_start: timer=b089b886 function=delayed_work_timer_fn expires=4294672340 [timeout=5000] bucket_expiry=4294672384 cpu =3 idx=192 flags=D|I
> 
> ^^^ this timer was supposed to expired after around 5000 jiffies (i.e. 5
> second, since HZ=1000), but it expired way late (160 seconds later).
> 

Hmm.. this is more a noise since it's a deferreable timer...

> 	[  163.261034] kworker/-31        3d.... 44012us : timer_start: timer=394b309f function=delayed_work_timer_fn expires=4294787991 [timeout=120651] bucket_expiry=4294791168 c pu=3 idx=277 flags=I
> 	...
> 	[  221.630578]   <idle>-0         1..s.. 3287405us : timer_expire_entry: timer=7e541f87 function=process_timeout now=4294670584 baseclk=4294670584
> 	[  221.643475]   <idle>-0         0d.s.. 162361292us : timer_cancel: timer=95703ccd
> 	[  221.650896]   <idle>-0         0..s.. 162361292us : timer_expire_entry: timer=95703ccd function=process_timeout now=4294829657 baseclk=4294670587
> 

but here:

	[  221.555265] kworker/-44        0d.... 3279414us : timer_start: timer=95703ccd function=process_timeout expires=4294670586 [timeout=10] bucket_expiry=4294670587 cpu=0 idx =59 flags=

this is a normal timer.

	[  221.571298] rcu_sche-15        3d.... 3279417us : timer_start: timer=7e541f87 function=process_timeout expires=4294670579 [timeout=3] bucket_expiry=4294670580 cpu=3 idx= 52 flags=
	[  221.587241]   <idle>-0         1d.s.. 3283405us : timer_cancel: timer=7e541f87
	[  221.594488]   <idle>-0         1..s.. 3283407us : timer_expire_entry: timer=7e541f87 function=process_timeout now=4294670580 baseclk=4294670580
	[  221.607388] rcu_sche-15        3d.... 3283416us : timer_start: timer=7e541f87 function=process_timeout expires=4294670583 [timeout=3] bucket_expiry=4294670584 cpu=3 idx= 56 flags=
	[  221.623331]   <idle>-0         1d.s.. 3287404us : timer_cancel: timer=7e541f87
	[  221.630578]   <idle>-0         1..s.. 3287405us : timer_expire_entry: timer=7e541f87 function=process_timeout now=4294670584 baseclk=4294670584
	[  221.643475]   <idle>-0         0d.s.. 162361292us : timer_cancel: timer=95703ccd
	[  221.650896]   <idle>-0         0..s.. 162361292us : timer_expire_entry: timer=95703ccd function=process_timeout now=4294829657 baseclk=4294670587

which got fired here.

	[  221.663967]   <idle>-0         0dns.. 162361296us : timer_cancel: timer=d03eaa1d
	[  221.671388]   <idle>-0         0.ns.. 162361297us : timer_expire_entry: timer=d03eaa1d function=process_timeout now=4294829657 baseclk=4294670856

And looks to me CPU 0 is the tick_do_timer_cpu CPU, since it's the first
one that got timers after a long wait and was doing a few catch-ups. Now
the problem is why CPU 0 didn't program its hardware timer to expire at
4294670587? I.e. the earliest timer.

Regards,
Boqun

[...]

