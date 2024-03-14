Return-Path: <linux-kernel+bounces-103827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E3987C501
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1593A1C20A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9102B768F7;
	Thu, 14 Mar 2024 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hma04Grk"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200EB76414;
	Thu, 14 Mar 2024 22:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710454252; cv=none; b=l9aGX+vgFlU/ncVReqlSHoHUx5BYMBAhan6l958EKs665USPadpbfE0lA1tRIsNKUJ4JbJgNA6dcZsJxppdnvQa3DIscUq/1zW2OztwjsXFkL4c8UsA5DiTXxEvyDENKzT1qbDxBbeeEKKSnPwrpQhVXW+tqVVazQt/SEcj3RxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710454252; c=relaxed/simple;
	bh=OkWcBnsiYG75IDHlAI5T+Gku1wq896+L4GdKgwLV3Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWM3qTKDPLs/fGoT8UKoIhP7vbnYiAqW0PIRC5BaDfSSq5/bcCf0p5Kgx/Md1yL7Qw06guv2SBg8gPunTBX62ved4Wh2YlMeijMKLffrbwOON3ackvtcqeLQDm/BaZ9bmpk0mj5XmE8UI9U0GCVGiNU2SBP6GMmKxpd2/GTjCm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hma04Grk; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42a029c8e62so9846201cf.1;
        Thu, 14 Mar 2024 15:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710454250; x=1711059050; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCh3dqJRCdjU6eonAORaNe6PS7ViDsSNXUXdZHK162c=;
        b=hma04Grk/aHg2NQgGryrLC7jmZvxOwTKtwApQZxuSZYiYC8EQ+cFz1n3do3n3F+KIK
         9jEFHuDrp5p7rgCJl/6bozS1CAEbekwHA6+QjCP0RUEKszkJDFzlqwD0s8mmh5xtF4rJ
         RSf4ex1E7VYoW6RPcczVS4KsxQ/ztkO1Q1u4ywkNZeUpwNI14twA04FfOJr0+1BfWsvt
         YUoW+EQGtPXJBMuUt2HNeBqvVF7a52KTuY91mzljqqn3YRd702RQyylcdWbX3uokttWz
         n30anQBIi6VsCQj3i0h+d7X6ZSosFANV6MY6s9pJhcKJ5kAozX2AEeSheG/Ab9UNk82W
         tWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710454250; x=1711059050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCh3dqJRCdjU6eonAORaNe6PS7ViDsSNXUXdZHK162c=;
        b=r7rpJN40bvUqCqUMMapFUGmTHj2M8LWa3smv15fqRyoPpjcqiZNbsxL/f2397x25UZ
         ep0C0Ek0ix2iYstKqShHzjUF/KHhG8r9ALuqARby0BBvMG5oZIhHVsAmXvIEF2wkDLCM
         X1xbNghg6pCrd6uc/S0Ql9AvLOI7Lr/qhEHl4YIWbeihr04zVfQ4/XTAGqOJ5iRwltDJ
         gFdHuv5xmSdV0WdOxmT3gsCOLNadnge3jxhyQJx0zbf18JecFW5nwOMTi1UjPEixvV1S
         VSElZxEedAn+fgrdv3k/wW59vHkJfRPLsgnI8Utj3s0xPIhPZaals7OZsKBWfNjudsT5
         sjyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqEsXdx1NxK2Rm4evKbEpaGaY32g+OTJPwzR5+4XwsF6WiEfnw4tZVgYiJ7HW3+ekFcYFv1KirT5OJhaXmiWKGdjX57jDLgLwSbC3I+knMQ8qjjtgc4OyWFy09Wp6YrNUT
X-Gm-Message-State: AOJu0YwOX3W1NcKzL3e7QJXZZ3KmPk/GY8+/IlpIxHkDSiZ8i75Tzxyp
	IxtrpiWHFWebWCbicwQYd8USOSl+f5TEGWlC4B+h2f2VK/yK2RO2
X-Google-Smtp-Source: AGHT+IE0CbsFgYOBEfoVLEWYHMhDQvabiv4+OsU1OtIjElzhfjT3erU5yfwzKsrSDVb6SifHrw683Q==
X-Received: by 2002:a05:622a:5807:b0:430:a089:a13d with SMTP id fg7-20020a05622a580700b00430a089a13dmr2619640qtb.2.1710454250038;
        Thu, 14 Mar 2024 15:10:50 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id s15-20020a05622a178f00b00430a07fb03asm931440qtk.0.2024.03.14.15.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 15:10:49 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailauth.nyi.internal (Postfix) with ESMTP id 0F3BD27C005B;
	Thu, 14 Mar 2024 18:10:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 14 Mar 2024 18:10:49 -0400
X-ME-Sender: <xms:6HXzZZkPcGQmgSCYsLvFHe0FkX4engivAvZCdvEj-Z4RnJ2fxMBvGQ>
    <xme:6HXzZU02vMjD1VrEF3NygDuuqwuvIJAfEkw9KHlZVOoMVEdT9d2KxO4k113_d3usr
    jPWEE1leRglhWnxlA>
X-ME-Received: <xmr:6HXzZfqkSF3RQV_Xdre0RptylM2lNaMD1wXrxNVSeCt7wHHmPiUoS7ef86PUUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeejgdduheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefftdeihfeigedtvdeuueffieetvedtgeejuefhhffgudfgfeeggfeftdei
    geehvdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:6HXzZZlGgiMyv2mWdOXLhDJe9f_XC6W6-qcZqZ18UQosrnG6h9VhYQ>
    <xmx:6HXzZX1JNSkrhckv7yW2F_Tq86x6M4v9kpav3E36SWaKobl1u86wCQ>
    <xmx:6HXzZYs02RFHLAAXhk4hGOalQKTD3XhGKokykkG71XydqoxOVDCA3w>
    <xmx:6HXzZbXScSv_kQi99E7mkUfmBnC0fvnhZGk_5yRpTtONLJG0dqkWxg>
    <xmx:6XXzZe_0Wrw2kuk17cZjIPi18E4w4AAMr0jznbruP_JZTYzinujKFg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Mar 2024 18:10:47 -0400 (EDT)
Date: Thu, 14 Mar 2024 15:10:41 -0700
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
Message-ID: <ZfN14cRsXp0CS7KC@boqun-archlinux>
References: <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
 <ZfIuRMo8oKbR08Af@lothringen>
 <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
 <ZfLUU+XuQC7W79tf@lothringen>
 <d6c8e4fe-17bf-443d-a6f5-54470390e1fd@gmail.com>
 <ZfNHNvzpqf8DOZd8@boqun-archlinux>
 <de038bee-cecd-4e76-b0f4-5822b68e439d@gmail.com>
 <87v85olez3.ffs@tglx>
 <87sf0sldbi.ffs@tglx>
 <ZfN0wY41pU5UjP8T@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfN0wY41pU5UjP8T@boqun-archlinux>

On Thu, Mar 14, 2024 at 03:05:53PM -0700, Boqun Feng wrote:
> On Thu, Mar 14, 2024 at 10:21:21PM +0100, Thomas Gleixner wrote:
> > On Thu, Mar 14 2024 at 21:45, Thomas Gleixner wrote:
> > > On Thu, Mar 14 2024 at 12:09, Florian Fainelli wrote:
> > >> https://gist.github.com/ffainelli/cb562c1a60ef8e0e69e7d42143c48e8f
> > >>
> > >> this one is does include the tmigr events. Thanks!
> > >
> > > You need 8ca1836769d758e4fbf5851bb81e181c52193f5d too.
> > 
> > So from the above trace it's clear where it goes south:
> > 
> > [  236.318158]   <idle>-0         3..s.. 2928466us : tmigr_handle_remote: group=aecb05cb lvl=0
> > [  236.326526]   <idle>-0         3d.s.. 2928467us : tmigr_handle_remote_cpu: cpu=0 parent=aecb05cb wakeup=9223372036854775807
> > [  236.357809]   <idle>-0         3d.s.. 2928469us : tmigr_update_events: child=00000000 group=aecb05cb group_lvl=0 child_active=0 group_active=8 nextevt=3103000000 next_expiry=2934000000 child_evt_expiry=0 child_evtcpu=0
> > 
> > [  236.377222]   <idle>-0         0dn... 2928471us : tmigr_cpu_active: cpu=0 parent=aecb05cb wakeup=9223372036854775807
> > [  236.387765]   <idle>-0         0dn... 2928471us : tmigr_group_set_cpu_active: group=aecb05cb lvl=0 numa=0 active=9 migrator=8 parent=00000000 childmask=1
> > 
> > [  236.401526]   <idle>-0         0d.... 2928477us : tmigr_update_events: child=00000000 group=aecb05cb group_lvl=0 child_active=0 group_active=8 nextevt=3103000000 next_expiry=2934000000 child_evt_expiry=0 child_evtcpu=0
> > [  236.420940]   <idle>-0         0d.... 2928478us : tmigr_group_set_cpu_inactive: group=aecb05cb lvl=0 numa=0 active=8 migrator=8 parent=00000000 childmask=1
> > [  236.434874]   <idle>-0         0d.... 2928478us : tmigr_cpu_idle: cpu=0 parent=aecb05cb nextevt=3103000000 wakeup=9223372036854775807
> > 
> > [  236.446896]   <idle>-0         3d.... 2929469us : tmigr_group_set_cpu_inactive: group=aecb05cb lvl=0 numa=0 active=0 migrator=ff parent=00000000 childmask=8
> > [  236.460916]   <idle>-0         3d.... 2929470us : tmigr_cpu_idle: cpu=3 parent=aecb05cb nextevt=9223372036854775807 wakeup=9223372036854775807
> > [  236.473721]   <idle>-0         3d.... 2934471us : tmigr_cpu_new_timer_idle: cpu=3 parent=aecb05cb nextevt=9223372036854775807 wakeup=9223372036854775807
> > 
> > CPU3 is the last active CPU and goes idle. So it should take care of the
> > pending events, but it does not.
> > 
> 
> I notice CPU3 didn't have its own non-deferrable timer queued (local or
> global), so could the following happen?
> 
> 	timer_base_try_to_set_idle():
> 	  __get_next_timer_interrupt():
> 	    fetch_next_timer_interrupt():
> 	      // nextevt_local == nextevt_global == basej + NEXT_TIMER_MAX_DELTA
> 	      // tevt->local == tevt->gloabl = KTIME_MAX
> 	    timer_use_tmigr():
> 	      tmigr_cpu_deactivate():
> 	        __tmigr_cpu_deactivate():
> 		  // tmc->cpuevt.ignore untouched still == true
> 		  walk_groups(&tmigr_inactive_up, ...):
> 		    tmigr_inactive_up():
> 		      data->remote = true;

this line is 

		data->remote = false;
	
in the real code.

> 		      tmigr_update_events():
> 		        if (child) { // child is NULL
> 			  ...
> 			} else {
> 			  first_childevt = evt = data->evt;
> 
> 			  if (evt->ignore && !remote)
> 			    return true; // no remote tick is picked.
> 			  ...
> 			}
> 
> Regards,
> Boqun
> 
> > This is the next trace entry where CPU0 magically comes back to life.
> > 
> > [  236.487393]   <idle>-0         0d.s.. 162001359us : timer_cancel: timer=8c725d84
> > 
> > 8ca1836769d758e4fbf5851bb81e181c52193f5d is related, but dos not fully
> > explain the fail. I haven't yet spotted where this goes into lala land.

