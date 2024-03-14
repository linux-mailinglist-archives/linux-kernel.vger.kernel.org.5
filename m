Return-Path: <linux-kernel+bounces-103823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E67EF87C4F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EF0F283002
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371DB768F6;
	Thu, 14 Mar 2024 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+QEoTMq"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C485B74BE8;
	Thu, 14 Mar 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710453965; cv=none; b=plwbk18qFQ1bQfTDaQ5ulhMvC7CCftm9r6dpe5x7JAR++kgR75DKqhm7mEA8T5YbtyHvOSnRyYXfqFFfuwugK3zEA0kC+YABT0uFsIx877u1vXvlPLJ3thSXbCUXwo9DLaHd2MrFyVYsbZmjwA/lpMrnpn2oMZxeMp/gd3YAuBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710453965; c=relaxed/simple;
	bh=4ZRIE5FJRimKlsJb/xC2JmvT2j6RzX+plSbhnmqaJLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3RKHVWPzPABdHVCsfircUt0xWI4gRZzY8suOpu2/K3nJ6hwlVKSbSGl3MPnwaAAfapEUU+1UGwznpuPxF/U4uREcDlKVrAjWL2n54f6UjC+/+nR6oBzDfbjVBF2mzs9bdBnkjkzgA57fz38CVkR9UmFYkMNgIg7fUOb2gatJs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+QEoTMq; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-789ddcd57f4so51858185a.2;
        Thu, 14 Mar 2024 15:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710453962; x=1711058762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxBegbp65VoxmdJchaOKK867ELuE8/4w/6ms8j3UImE=;
        b=d+QEoTMq1k7JNXXKLZO/bynPeh65oV7XL8j6fn+sTq2qM2le9UoHB5Xla7YcGUMzNv
         Tfa8Y3nSq8gaTxQH+i9N9gRIwoaz4JnQUg9gaT2YOMNdxWfBajVsGTaCgDknIlB3ng3M
         cwdVevpNe1x46BzygceWPugNnNrLFTKSpH2VhhFsE8szDeYjr+h1tratCCGAlcJazsRJ
         45xqB7ja1mIW7u1qf/T96aPSbVYZz/7Grgd/nTAgSNbFWOOoOUVXiBXAni+sbHVfH/hJ
         ixNA+EtFpAaGrEaAxfCFun15h+bBYNyNRSjtWNV213vGgTkbTsYDjbhQF/O/6IKAWxS/
         eOKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710453962; x=1711058762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxBegbp65VoxmdJchaOKK867ELuE8/4w/6ms8j3UImE=;
        b=EHw6Ocalz1AnuKfdaMS59NTFPUWA5Ex5BrwFGsvzSIpRkpstIl7U7YsdEG6PvZ278H
         hpNHMSsqWPlnMidqOUCo/xtrh4XSuUz1b4VqUvYnDNmUwez3M5fZRwQA4BvhvzUHnN+K
         jxM/mK2+yaDSR3nYK1an2all2BAurHi6SWUqzMRI4PA0L9ub9pqyBo219k7yZrmsuVXR
         PeVcnOL31RO2HKyWZzjUKStz0vgfWdi5DecYApWW/8Vpk4/S9LQqegk2D2JQw99yCMQ2
         hS5/Y5f+oBSLP75zFUj330Z06TMBB0qd9y4Zn/fCEzjEBRvnxzn+ML6d/AV+D7ynrHsE
         AFrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWglI8C1w57efNXCFT+qA7oDmGNyfihaeeV/wZ1XAtnjQ8SeOIjJRnuRVS9mA/IwSTr1IDH4XvusJXeDxB0rmvkB0qt+dW1rngQqvOlGYIJIzRPunxSetxwsrF62+O58JhG
X-Gm-Message-State: AOJu0YywQASUNB2PtvrbFL1L3LNPh0r/BCRg52QCfTACmzANTTp1AcmM
	Qk3DZ7U7eiQCTr6fDK+jOFRXawhm1PldtBDvPkd6Zbehw87tdY1L
X-Google-Smtp-Source: AGHT+IExYCtsOXnnvxVyoRLOWo1Tmw+uieBz33fwgpebJPikFDxVIA0xelkvCmIZX/4fcqN0scpngg==
X-Received: by 2002:a05:620a:370d:b0:789:c716:b5da with SMTP id de13-20020a05620a370d00b00789c716b5damr4052517qkb.56.1710453962483;
        Thu, 14 Mar 2024 15:06:02 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id b15-20020a05620a126f00b0078870b3ad29sm1296839qkl.126.2024.03.14.15.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 15:06:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 616571200043;
	Thu, 14 Mar 2024 18:06:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 14 Mar 2024 18:06:01 -0400
X-ME-Sender: <xms:yHTzZVGOidw7_LYqLnArTwp14uHWkjcOzR3nLTIij2RmtySWm82lXQ>
    <xme:yHTzZaV6EDW5PDzPh7ZkwBMTgyTp0U8mA-Mp5eVdroVy_SLMT3dzfsc21VVD-jFPv
    Fc3_PTylCfsCMdNGA>
X-ME-Received: <xmr:yHTzZXLOsINPqmuL9erCAMUqQU_fIzACt8i8pYGS7B8VvUguui8W2vCgR31eNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeejgdduheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeejuefhhffgudfgfeeggfeftdei
    geehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:yHTzZbG-vV3whK-_t1ifa_t8MKntIQRpzU4qrNtA9EWg8DF8uT662g>
    <xmx:yHTzZbX7jOglmCtD_jueMwXEBVhqKqpQA0CONVTG-P_pul6jbJJmjA>
    <xmx:yHTzZWNm7i_FxLA-iepburKH4tUXr164kTyxtCHeb-TMQCtFxP3N5A>
    <xmx:yHTzZa0bYEhvBjZ2t-tIUZo4A2uTYaW6UIO-zzx_-75glFoIJrjBlw>
    <xmx:yXTzZYfHyKUmFhg_XN2gzDZxbgkGKzqWnfBY2PisHUIGlUCF8n-FVoFEfV4>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 18:05:59 -0400 (EDT)
Date: Thu, 14 Mar 2024 15:05:53 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Joel Fernandes <joel@joelfernandes.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	paulmck@kernel.org, mingo@kernel.org, rcu@vger.kernel.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, bigeasy@linutronix.de,
	chenzhongjin@huawei.com, yangjihong1@huawei.com,
	rostedt@goodmis.org, Justin Chen <justin.chen@broadcom.com>
Subject: Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU changes for
 v6.9]
Message-ID: <ZfN0wY41pU5UjP8T@boqun-archlinux>
References: <ZfIh33YAYkLaDeAS@shell.armlinux.org.uk>
 <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
 <ZfIuRMo8oKbR08Af@lothringen>
 <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
 <ZfLUU+XuQC7W79tf@lothringen>
 <d6c8e4fe-17bf-443d-a6f5-54470390e1fd@gmail.com>
 <ZfNHNvzpqf8DOZd8@boqun-archlinux>
 <de038bee-cecd-4e76-b0f4-5822b68e439d@gmail.com>
 <87v85olez3.ffs@tglx>
 <87sf0sldbi.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf0sldbi.ffs@tglx>

On Thu, Mar 14, 2024 at 10:21:21PM +0100, Thomas Gleixner wrote:
> On Thu, Mar 14 2024 at 21:45, Thomas Gleixner wrote:
> > On Thu, Mar 14 2024 at 12:09, Florian Fainelli wrote:
> >> https://gist.github.com/ffainelli/cb562c1a60ef8e0e69e7d42143c48e8f
> >>
> >> this one is does include the tmigr events. Thanks!
> >
> > You need 8ca1836769d758e4fbf5851bb81e181c52193f5d too.
> 
> So from the above trace it's clear where it goes south:
> 
> [  236.318158]   <idle>-0         3..s.. 2928466us : tmigr_handle_remote: group=aecb05cb lvl=0
> [  236.326526]   <idle>-0         3d.s.. 2928467us : tmigr_handle_remote_cpu: cpu=0 parent=aecb05cb wakeup=9223372036854775807
> [  236.357809]   <idle>-0         3d.s.. 2928469us : tmigr_update_events: child=00000000 group=aecb05cb group_lvl=0 child_active=0 group_active=8 nextevt=3103000000 next_expiry=2934000000 child_evt_expiry=0 child_evtcpu=0
> 
> [  236.377222]   <idle>-0         0dn... 2928471us : tmigr_cpu_active: cpu=0 parent=aecb05cb wakeup=9223372036854775807
> [  236.387765]   <idle>-0         0dn... 2928471us : tmigr_group_set_cpu_active: group=aecb05cb lvl=0 numa=0 active=9 migrator=8 parent=00000000 childmask=1
> 
> [  236.401526]   <idle>-0         0d.... 2928477us : tmigr_update_events: child=00000000 group=aecb05cb group_lvl=0 child_active=0 group_active=8 nextevt=3103000000 next_expiry=2934000000 child_evt_expiry=0 child_evtcpu=0
> [  236.420940]   <idle>-0         0d.... 2928478us : tmigr_group_set_cpu_inactive: group=aecb05cb lvl=0 numa=0 active=8 migrator=8 parent=00000000 childmask=1
> [  236.434874]   <idle>-0         0d.... 2928478us : tmigr_cpu_idle: cpu=0 parent=aecb05cb nextevt=3103000000 wakeup=9223372036854775807
> 
> [  236.446896]   <idle>-0         3d.... 2929469us : tmigr_group_set_cpu_inactive: group=aecb05cb lvl=0 numa=0 active=0 migrator=ff parent=00000000 childmask=8
> [  236.460916]   <idle>-0         3d.... 2929470us : tmigr_cpu_idle: cpu=3 parent=aecb05cb nextevt=9223372036854775807 wakeup=9223372036854775807
> [  236.473721]   <idle>-0         3d.... 2934471us : tmigr_cpu_new_timer_idle: cpu=3 parent=aecb05cb nextevt=9223372036854775807 wakeup=9223372036854775807
> 
> CPU3 is the last active CPU and goes idle. So it should take care of the
> pending events, but it does not.
> 

I notice CPU3 didn't have its own non-deferrable timer queued (local or
global), so could the following happen?

	timer_base_try_to_set_idle():
	  __get_next_timer_interrupt():
	    fetch_next_timer_interrupt():
	      // nextevt_local == nextevt_global == basej + NEXT_TIMER_MAX_DELTA
	      // tevt->local == tevt->gloabl = KTIME_MAX
	    timer_use_tmigr():
	      tmigr_cpu_deactivate():
	        __tmigr_cpu_deactivate():
		  // tmc->cpuevt.ignore untouched still == true
		  walk_groups(&tmigr_inactive_up, ...):
		    tmigr_inactive_up():
		      data->remote = true;
		      tmigr_update_events():
		        if (child) { // child is NULL
			  ...
			} else {
			  first_childevt = evt = data->evt;

			  if (evt->ignore && !remote)
			    return true; // no remote tick is picked.
			  ...
			}

Regards,
Boqun

> This is the next trace entry where CPU0 magically comes back to life.
> 
> [  236.487393]   <idle>-0         0d.s.. 162001359us : timer_cancel: timer=8c725d84
> 
> 8ca1836769d758e4fbf5851bb81e181c52193f5d is related, but dos not fully
> explain the fail. I haven't yet spotted where this goes into lala land.

