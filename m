Return-Path: <linux-kernel+bounces-100789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5C3879D3D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:08:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FDA1F22DE9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB8B143724;
	Tue, 12 Mar 2024 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSuumzEy"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C5E14290A;
	Tue, 12 Mar 2024 21:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277683; cv=none; b=HeDlN/Ax3pnwXXwab6dajBrKb5Ba6MyUCVcnmjfkanFLNwFIiwDbLNLc1ZgdbsL3N5pViCy5g4Rx2j6wif6XF4pwCjMDQPwFVe3OqtSomY4NGm6vZkLBfyywXa6qLfyHrpzB4UVdZTgZ+MqW2zApQiTU6drocRll9q2rQlo1GAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277683; c=relaxed/simple;
	bh=jDDnRF2bY/5eqv27Q1U77QHqgiJOx52u8tdCMQ2RZ0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFLwjLAbZNTdV9UtRz035F/RU5/K7SdjA18wC/CiZji81uS6gTHZmfrXz6SfH4ka8vE1p1jA5jQiazMN84Boj2XlzcntBzpzNYsH/Ui8rXcXJC8qN3pqpzfklF54SwZEjGAU1Xjv9iEJ2okXULL5P0YuLstY7JMDCCE1vZ5aoEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSuumzEy; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-42ee7fa077bso1477011cf.3;
        Tue, 12 Mar 2024 14:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710277681; x=1710882481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyNcAZZUniyc0w1gofbGaeJW0aTRysYzXES4SgvGCh4=;
        b=dSuumzEyjR+IkswPbC2yzx/dpFfzx3bK09SDPbYFdAuTf7GiFi5fOY8TSNwysDRtEn
         bIv7prB65EOFYxPdsQVCQgeeUyQYcXiNc71cUn+w6EKg6ZvD+7AiDwoa+Qv+KLfnRMDb
         wdgFgOsIC/knYkAFBjAEZG89yXZS0bCtIeqodmZ4VbZvXxTsjrQ271P0EoFL2vbgPH8u
         df1UEwVRfrVWoc2UghneFoMEBkdWWvrCPEgOW9I7BddYZN2caLgQlT78z8zOLUlI9u34
         RZnwWdZh3cGPGrbEVg7354Ju7d6J8lWs+btR/aaEFOFuxv5W7Ef22xCIc2dTjEz9PvQz
         Dm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710277681; x=1710882481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pyNcAZZUniyc0w1gofbGaeJW0aTRysYzXES4SgvGCh4=;
        b=QTqYVAlDClTNe2nhADIoH+orxZWg3pq1p1P+UV1fjV87QoVe1AcEPVTNHUIwo5JZXp
         YWOjLBkG+7anZl2Nk1cIY/cjeDNIFn2TI59GBY7SAmK2S+21vC9ISLUS8Ko20DUBDst4
         o7n/46uYVBh/Mquq6UoNdgFdPo1lzCIwy70ohJl7DX4JEiTEeBp2i9I7O5LiAaBSMA5b
         op87xykqVZxdOxntVbxu7WDo1W9Ch0h/+p67En/4uhorzJsjQ7vxnBIQPVnJ2W2FrHGf
         zASUl7lCjFod/JK2lAE0dC8Y1K4Qrxkpq+XeAYcpYdj22h5IA+076JhetwsmTM+RectD
         oiVw==
X-Forwarded-Encrypted: i=1; AJvYcCUFkzIhPoL/oos5Tfdqqp424Vub4ZoCIQM3hYDVAsCIxlwm6KjyMWqL3JoCvaUrAqvJdLGi7oKZKgM7YpJ0mrxMUYwt6WrAmeqSx9xIp6WXzl831yDVjjfsO211BbGQfKZK
X-Gm-Message-State: AOJu0YzYR11OTNKBD3hXJMYLdOcCQRW9iryfto9PVWg0hRusyKXFt/7o
	0RouQFjBJTaZZmUqGX+/D0UX+Ru/1RXiqdA+nuTSxPeqIHSC0K1q
X-Google-Smtp-Source: AGHT+IHns0MTV3u8P/4nS6mjR+SAps/VTgRErWKnLfPKLt5tQulxsR+JdIq9R0vetXh9vy87NIOEfA==
X-Received: by 2002:a05:622a:151:b0:42e:6de7:35e2 with SMTP id v17-20020a05622a015100b0042e6de735e2mr1612814qtw.25.1710277680833;
        Tue, 12 Mar 2024 14:08:00 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id e15-20020ac845cf000000b0042f3882cd05sm3876062qto.42.2024.03.12.14.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:08:00 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id B3F671200068;
	Tue, 12 Mar 2024 17:07:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 12 Mar 2024 17:07:59 -0400
X-ME-Sender: <xms:L8TwZa2fKFNQVOE9ndVssDkdvYL47l0QwQ2_2pLw5GZZY3Y5v2nPKg>
    <xme:L8TwZdGGM2nFeAc-wuPTCORTA6wgjBR5rt7KGoENyiJjxuQJW9tDaHJeKJ4ppLFKb
    ExBy5qqViL_qPftzA>
X-ME-Received: <xmr:L8TwZS6FHJSHcEz_nT0X9dCKyj8fQWI_LYSGlDS0Ino4iKHR-B6qLbMeZvfSZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeefgddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedv
    vdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:L8TwZb10F5_rSpcsHOz5u5aqCQ3r_J_1X2FBG9JW_9Dr7jYxcGhnBA>
    <xmx:L8TwZdFGXpB7aXHgEMGGweIJ_tx_vNRty9cMZ1pAv7XcSnUJU03rmA>
    <xmx:L8TwZU-JVjNMdaVUAQH4L_pU7Dg2mACF_uBb3z1GQf1Yj0Chq7OYcA>
    <xmx:L8TwZSkCpyT7MQDejJwOrRZ-H9u6yBVgspy1VnJESR7S_mlF8lRsOA>
    <xmx:L8TwZRKqdoQaSUq7vS165mowZCkQXWGuNYe2Eb_1mvKHq3WILAXVM0tuVNI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Mar 2024 17:07:58 -0400 (EDT)
Date: Tue, 12 Mar 2024 14:07:46 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, paulmck@kernel.org, mingo@kernel.org,
	tglx@linutronix.de, rcu@vger.kernel.org, joel@joelfernandes.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, frederic@kernel.org,
	bigeasy@linutronix.de, anna-maria@linutronix.de,
	chenzhongjin@huawei.com, yangjihong1@huawei.com,
	rostedt@goodmis.org
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for
 v6.9]
Message-ID: <ZfDEIs63EBIYBJIC@boqun-archlinux>
References: <ZetHwrCb0KXE0xFI@tardis>
 <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4274be61-60bd-4e1e-9c16-26e6e5e06f65@gmail.com>

On Tue, Mar 12, 2024 at 01:32:03PM -0700, Florian Fainelli wrote:
> Hi Boqun,
> 
> On 3/8/24 09:15, Boqun Feng wrote:
> > Hi Linus,
> > 
> > Please pull this for the RCU changes of v6.9:
> > 
> > The following changes since commit 41bccc98fb7931d63d03f326a746ac4d429c1dd3:
> > 
> >    Linux 6.8-rc2 (2024-01-28 17:01:12 -0800)
> > 
> > are available in the Git repository at:
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git tags/rcu.next.v6.9
> > 
> > for you to fetch changes up to 3add00be5fe5810d7aa5ec3af8b6a245ef33144b:
> > 
> >    Merge branches 'rcu-doc.2024.02.14a', 'rcu-nocb.2024.02.14a', 'rcu-exp.2024.02.14a', 'rcu-tasks.2024.02.26a' and 'rcu-misc.2024.02.14a' into rcu.2024.02.26a (2024-02-26 17:37:25 -0800)
> > 
> > 
> > Two merge conflicts were detected by linux-next:
> > 
> > * https://lore.kernel.org/lkml/20240226135745.12ac854d@canb.auug.org.au/
> > * https://lore.kernel.org/lkml/20240227125522.2bdbe6be@canb.auug.org.au/
> > 
> > These conflict resolutions from linux-next look good to me, plus I made
> > my own resolutions at branch merge/rcu.2024.02.27a for your reference.
> > 
> > 
> > Some highlights of the changes:
> > 
> > * Eliminates deadlocks involving do_exit() and RCU tasks, by Paul:
> >    Instead of SRCU read side critical sections, now a percpu list is used
> >    in do_exit() for scaning yet-to-exit tasks.
> > 
> > * Fixes a deadlock due to the dependency between workqueue and RCU
> >    expedited grace period, reported by Anna-Maria Behnsen and Thomas
> >    Gleixner and fixed by Frederic: Now RCU expedited always uses its own
> >    kthread worker instead of a workqueue.
> 
> At least one device in my test farm (ARM 32-bit) has consistently shown a
> very long boot, and some others are intermittently affected. This
> consistently looks like this on most of my devices:
> 
> [    2.450351] bcmgenet f0480000.ethernet: GENET 5.0 EPHY: 0x0000
> [    2.547562] ata1: SATA link down (SStatus 0 SControl 300)
> [  162.107264] unimac-mdio unimac-mdio.0: Broadcom UniMAC MDIO bus
> 
> this gets flagged by my boot script as a boot failure since we exceeded the
> 30 seconds timeout given to boot a kernel to a prompt.
> 
> It has been somewhat difficult to get a reliable bisection going on, but
> what I am sure of is that e5a3878c947ceef7b6ab68fdc093f3848059842c~1 does
> not expose the problem for 10 consecutive boots, while I *might* see it at
> e5a3878c947ceef7b6ab68fdc093f3848059842c and beyond.
> 
> Any clues what is going on here?
> 

Could you share the config file and your kernel parameters? Also could
you share the whole log? Thanks!

Regards,
Boqun

> Thanks!
> -- 
> Florian
> 

