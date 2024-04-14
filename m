Return-Path: <linux-kernel+bounces-143926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0E68A3FBC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 02:07:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEC4D1C20F80
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 00:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101DD1859;
	Sun, 14 Apr 2024 00:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqQnH0Aq"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B27136D;
	Sun, 14 Apr 2024 00:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713053238; cv=none; b=fg+hEWYfpHyrus56lAZrmIIYD58WphyxTCLkbv8Fi3UHj/dwvVCUhhDbLnD1drngraYfQQgDBbeIuEVntpCZX2mbs+nnWLKdBbFmFaXiPVK9sE7vYhjqbMvLy2QXaWAzkEHZ0YMN8anPkxjOPMJXGqg4oOfWCRRbKBNeTTVJtOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713053238; c=relaxed/simple;
	bh=r2dOedoyB6oSK+NEaVmvFPgqzxvMfnnEoAN/d2FOYCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nojJF/aaXhfxiBokhVkcPcqHnIuUymfGUDj3O3G6wScfQu3o/19/J6yiEluKaO1gVFvdh1rATdZEqIgSS2xREYgcWypeyjXNX+AsZXtP5Lep2UvPmfDPMsiKHtnBnEyP94mRemJWfftznkRM2S3LxjlRyJxjk+07a1vTHOgkIu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqQnH0Aq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e3e56c9d2cso18374655ad.1;
        Sat, 13 Apr 2024 17:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713053235; x=1713658035; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Eh9TsfV8QUTIOV3TJA8DNUVXpmcwcvOIlKu862XChG4=;
        b=jqQnH0AqkmfMrrMBJ1hFEeXvswaSb1g16Ogow70EIrm6IzNqUO/UVy8STDEiqHmcby
         TQOvAPKzhIaGsd9cutWQSOKhzlkZu7HH5PQnvkNfRD5XJLI9z/ACTUzDVazI8hPcbQQE
         /qmcV3cjQeEicgxxZSbZtBANal28Ml67oKin0OIAy0zPBBa4OOFgIDtLZJT3mM1IWIyx
         6c0oxhdwk2UwCDGaXe3DesLYczVLhlbuc7W1VJ0syTMRGCXu8SfOpzJK3HclIz0ikjRT
         Jn77Ly56up+ft2Lhza0Euys86Rzo9x0RsbXm8y17pb+EWY/gx/T0MSMte3pHddtkoOaG
         1nRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713053235; x=1713658035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eh9TsfV8QUTIOV3TJA8DNUVXpmcwcvOIlKu862XChG4=;
        b=FItsaLOO1d+47jq+rFS94KyJxnj0Jpk85bzBYyGrFLooHqXwOG2upTPzawf0DD7U2W
         vKFZNHZtGJDh0Xl9wWcpuj90kKOPAp9/ll/wJ5oQ5P//FX3bwYPAP7NzWVSHuHAXqiwX
         WtnIFVMt2KPKtYPQYXFWIGzJt69tKBzAe8AoJ8r3Qt1tQTe4OewIq6fnUjzg3aZyQNZm
         Ub17E2L5baOFdTyUHXHNi+fl9NWq0uH/lGS33JQCpcy3DL03EleEWIZl0FUu4cd6hoWU
         UlOeBlexK7DiPxMnOa82hBX3UF8ZfbMpI45JS1DME19nDhqSsUkCUKA103KylwsR2IsJ
         hweA==
X-Forwarded-Encrypted: i=1; AJvYcCVJxJaTchB5Owbw6Oz/BQwYYUPYA56+fwXGE+PKYsuKeeNS6wGtHJxivqWc4V3W7sVutdX1z7t0vLAX7K6Kv4QCbCmY07/iSBhyLrh/LTIhfvwvPkeZqDwtekdQemrZ2o1TYzvZH6c=
X-Gm-Message-State: AOJu0YyMSx1dECmWdiYX7LlXzbP4mgk+Ad9awyWOhfDirgAOTlfdDyDs
	+MUVeCy91QLfvjgMdsMc5YR9aOB6/5UgXjZLw58HPjNvgsVcJPSapdM+nQ==
X-Google-Smtp-Source: AGHT+IHHVVW2DkJpusdvyxWwGnL4uS7ulabdsqHSS4M8/lHps5i6BVhX4VUdfFboAKUPSyOOj0SeLw==
X-Received: by 2002:a17:903:950:b0:1e5:d021:cf58 with SMTP id ma16-20020a170903095000b001e5d021cf58mr6865098plb.36.1713053234892;
        Sat, 13 Apr 2024 17:07:14 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id v13-20020a170902f0cd00b001e46939b250sm5154827pla.119.2024.04.13.17.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 17:07:14 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9140C18462BA4; Sun, 14 Apr 2024 07:07:10 +0700 (WIB)
Date: Sun, 14 Apr 2024 07:07:10 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Kenneth Crudup <kenny@panix.com>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	Linux Regressions <regressions@lists.linux.dev>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: Youngmin Nam <youngmin.nam@samsung.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Kernels 6.8+ no longer resume fully after a hibernate
Message-ID: <ZhseLvmpEyP23BRi@archie.me>
References: <b702c59f-7a5b-48f5-a726-a4840ce05c3f@panix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CAJphcl6COmIsNLl"
Content-Disposition: inline
In-Reply-To: <b702c59f-7a5b-48f5-a726-a4840ce05c3f@panix.com>


--CAJphcl6COmIsNLl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 10:20:49AM -0700, Kenneth Crudup wrote:
>=20
> I can't resume my system (Dell XPS 9320) after a hibernate in any 6.8 ker=
nel
> (incl. the recently-released 6.8.6); the resume apparently succeeds, but
> things are non-responsive and I suspect it's the disk I/O system.
>=20
> I use a swapfile, if it matters.
>=20
> I've been trying to bisect this failure for a while with no success, but =
in
> the process I'd determined the 6.7 series fails in the same way and was
> fixed sometime between v6.7.2 and v6.7.3.
>=20
> I had to reverse "good" and "bad" in the v6.7 bisection due to the "not
> ancestor of" issue (so I may not have done it properly, but I've attached
> the bisection log) but was able to allegedly track it to commit 9bd3dce27=
b0
> ("PM: sleep: Fix possible deadlocks in core system-wide PM code"), but
> trying the kernel committed immediately before (and after) that didn't se=
em
> to make a difference.
>=20
> I did a SysRq-Crash to force a dump to pstore, which I've also attached.
>=20
> If there's anything else you'll need, let me know.
>=20
> -Kenny
>=20
> --=20
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange Coun=
ty
> CA

> Panic#1 Part3
> <4>[   88.593926][    C0]  #6: <        pK-error>, timerfd_tmrproc
> <4>[   88.593928][    C0] , S:01
> <4>[   88.593928][    C0]=20
> <4>[   88.593928][    C0]  # expires at 9223372036854775807-9223372036854=
775807 nsecs [in 7510344925955549779 to 7510344925955549779 nsecs]
> <4>[   88.593929][    C0]  clock 2:
> <4>[   88.593929][    C0]   .base:               pK-error
> <4>[   88.593930][    C0]   .index:      2
> <4>[   88.593930][    C0]   .resolution: 1 nsecs
> <4>[   88.593930][    C0]   .get_time:   ktime_get_boottime
> <4>[   88.593931][    C0]   .offset:     43530917696 nsecs
> <4>[   88.593932][    C0] active timers:
> <4>[   88.593932][    C0]  clock 3:
> <4>[   88.593932][    C0]   .base:               pK-error
> <4>[   88.593933][    C0]   .index:      3
> <4>[   88.593933][    C0]   .resolution: 1 nsecs
> <4>[   88.593933][    C0]   .get_time:   ktime_get_clocktai
> <4>[   88.593935][    C0]   .offset:     1713027022323372591 nsecs
> <4>[   88.593935][    C0] active timers:
> <4>[   88.593935][    C0]  clock 4:
> <4>[   88.593936][    C0]   .base:               pK-error
> <4>[   88.593936][    C0]   .index:      4
> <4>[   88.593936][    C0]   .resolution: 1 nsecs
> <4>[   88.593937][    C0]   .get_time:   ktime_get
> <4>[   88.593938][    C0]   .offset:     0 nsecs
> <4>[   88.593938][    C0] active timers:
> <4>[   88.593939][    C0]  clock 5:
> <4>[   88.593939][    C0]   .base:               pK-error
> <4>[   88.593939][    C0]   .index:      5
> <4>[   88.593939][    C0]   .resolution: 1 nsecs
> <4>[   88.593940][    C0]   .get_time:   ktime_get_real
> <4>[   88.593941][    C0]   .offset:     1713027022323372591 nsecs
> Panic#1 Part2
> <4>[   88.593941][    C0] active timers:
> <4>[   88.593941][    C0]  clock 6:
> <4>[   88.593942][    C0]   .base:               pK-error
> <4>[   88.593942][    C0]   .index:      6
> <4>[   88.593942][    C0]   .resolution: 1 nsecs
> <4>[   88.593943][    C0]   .get_time:   ktime_get_boottime
> <4>[   88.593944][    C0]   .offset:     43530917696 nsecs
> <4>[   88.593944][    C0] active timers:
> <4>[   88.593944][    C0]  clock 7:
> <4>[   88.593945][    C0]   .base:               pK-error
> <4>[   88.593945][    C0]   .index:      7
> <4>[   88.593945][    C0]   .resolution: 1 nsecs
> <4>[   88.593946][    C0]   .get_time:   ktime_get_clocktai
> <4>[   88.593947][    C0]   .offset:     1713027022323372591 nsecs
> <4>[   88.593947][    C0] active timers:
> <4>[   88.593947][    C0]   .expires_next   : 89320114349 nsecs
> <4>[   88.593948][    C0]   .hres_active    : 1
> <4>[   88.593949][    C0]   .nr_events      : 8987
> <4>[   88.593949][    C0]   .nr_retries     : 5
> <4>[   88.593949][    C0]   .nr_hangs       : 0
> <4>[   88.593950][    C0]   .max_hang_time  : 0
> <4>[   88.593950][    C0]   .nohz_mode      : 2
> <4>[   88.593951][    C0]   .last_tick      : 85809000000 nsecs
> <4>[   88.593951][    C0]   .tick_stopped   : 1
> <4>[   88.593951][    C0]   .idle_jiffies   : 4294752997
> <4>[   88.593952][    C0]   .idle_calls     : 18572
> <4>[   88.593952][    C0]   .idle_sleeps    : 18226
> <4>[   88.593953][    C0]   .idle_entrytime : 88552463842 nsecs
> <4>[   88.593953][    C0]   .idle_waketime  : 88552463842 nsecs
> <4>[   88.593954][    C0]   .idle_exittime  : 85808440225 nsecs
> <4>[   88.593954][    C0]   .idle_sleeptime : 83693079684 nsecs
> Panic#1 Part1
> <4>[   88.593954][    C0]   .iowait_sleeptime: 98668015 nsecs
> <4>[   88.593955][    C0]   .last_jiffies   : 4294752997
> <4>[   88.593955][    C0]   .next_timer     : 91211000000
> <4>[   88.593956][    C0]   .idle_expires   : 91211000000 nsecs
> <4>[   88.593956][    C0] jiffies: 4294755742
> <4>[   88.593957][    C0]=20
> <4>[   88.593957][    C0] Tick Device: mode:     1
> <4>[   88.593957][    C0] Broadcast device
> <4>[   88.593958][    C0] Clock Event Device:=20
> <4>[   88.593958][    C0] <NULL>
> <4>[   88.593958][    C0] tick_broadcast_mask: 00000
> <4>[   88.593959][    C0] tick_broadcast_oneshot_mask: 00000
> <4>[   88.593960][    C0]=20
> <4>[   88.593960][    C0] Tick Device: mode:     1
> <4>[   88.593961][    C0] Per CPU device: 0
> <4>[   88.593961][    C0] Clock Event Device:=20
> <4>[   88.593961][    C0] lapic-deadline
> <4>[   88.593962][    C0]  max_delta_ns:   1101273695516
> <4>[   88.593963][    C0]  min_delta_ns:   1000
> <4>[   88.593963][    C0]  mult:           16750372
> <4>[   88.593963][    C0]  shift:          26
> <4>[   88.593964][    C0]  mode:           3
> <4>[   88.593964][    C0]  next_event:     89320114349 nsecs
> <4>[   88.593964][    C0]  set_next_event: lapic_next_deadline
> <4>[   88.593967][    C0]  shutdown:       lapic_timer_shutdown
> <4>[   88.593968][    C0]  periodic:       lapic_timer_set_periodic
> <4>[   88.593970][    C0]  oneshot:        lapic_timer_set_oneshot
> <4>[   88.593971][    C0]  oneshot stopped: lapic_timer_shutdown
> <4>[   88.593973][    C0]  event_handler:  hrtimer_interrupt
> <4>[   88.593974][    C0]=20
> <4>[   88.593974][    C0]  retries:        40
> <4>[   88.593974][    C0] Wakeup Device: <NULL>
> <4>[   88.593975][    C0]=20
> Panic#1 Part23
> <6>[   88.593216][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593218][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593219][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593221][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593222][    C0]  </TASK>
> <6>[   88.593223][    C0] task:kworker/u40:81  state:I stack:0     pid:23=
37  tgid:2337  ppid:2      flags:0x00004000
> <6>[   88.593225][    C0] Workqueue:  0x0 (events_unbound)
> <6>[   88.593225][    C0] Call Trace:
> <6>[   88.593226][    C0]  <TASK>
> <6>[   88.593227][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593228][    C0]  schedule+0x34/0xb0
> <6>[   88.593229][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593230][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593232][    C0]  kthread+0xf3/0x120
> <6>[   88.593234][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593235][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593237][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593238][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593240][    C0]  </TASK>
> <6>[   88.593241][    C0] task:kworker/u40:82  state:I stack:0     pid:23=
38  tgid:2338  ppid:2      flags:0x00004000
> <6>[   88.593242][    C0] Workqueue:  0x0 (events_power_efficient)
> <6>[   88.593243][    C0] Call Trace:
> <6>[   88.593244][    C0]  <TASK>
> <6>[   88.593244][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593245][    C0]  ? __queue_delayed_work+0x57/0x90
> <6>[   88.593247][    C0]  ? fb_flashcursor+0x120/0x160
> <6>[   88.593249][    C0]  schedule+0x34/0xb0
> <6>[   88.593250][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593252][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593253][    C0]  kthread+0xf3/0x120
> Panic#1 Part22
> <6>[   88.593255][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593256][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593258][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593259][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593261][    C0]  </TASK>
> <6>[   88.593262][    C0] task:kworker/u40:83  state:I stack:0     pid:23=
39  tgid:2339  ppid:2      flags:0x00004000
> <6>[   88.593263][    C0] Workqueue:  0x0 (events_unbound)
> <6>[   88.593264][    C0] Call Trace:
> <6>[   88.593265][    C0]  <TASK>
> <6>[   88.593265][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593266][    C0]  schedule+0x34/0xb0
> <6>[   88.593267][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593269][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593271][    C0]  kthread+0xf3/0x120
> <6>[   88.593272][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593274][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593275][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593277][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593278][    C0]  </TASK>
> <6>[   88.593280][    C0] task:kworker/u40:84  state:I stack:0     pid:23=
40  tgid:2340  ppid:2      flags:0x00004000
> <6>[   88.593281][    C0] Workqueue:  0x0 (events_unbound)
> <6>[   88.593281][    C0] Call Trace:
> <6>[   88.593282][    C0]  <TASK>
> <6>[   88.593282][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593284][    C0]  schedule+0x34/0xb0
> <6>[   88.593285][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593286][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593288][    C0]  kthread+0xf3/0x120
> <6>[   88.593290][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593291][    C0]  ret_from_fork+0x34/0x50
> Panic#1 Part21
> <6>[   88.593293][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593294][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593296][    C0]  </TASK>
> <6>[   88.593297][    C0] task:kworker/u40:85  state:I stack:0     pid:23=
41  tgid:2341  ppid:2      flags:0x00004000
> <6>[   88.593298][    C0] Workqueue:  0x0 (events_unbound)
> <6>[   88.593299][    C0] Call Trace:
> <6>[   88.593300][    C0]  <TASK>
> <6>[   88.593300][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593301][    C0]  schedule+0x34/0xb0
> <6>[   88.593302][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593304][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593306][    C0]  kthread+0xf3/0x120
> <6>[   88.593307][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593309][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593310][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593312][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593313][    C0]  </TASK>
> <6>[   88.593315][    C0] task:kworker/u40:86  state:I stack:0     pid:23=
42  tgid:2342  ppid:2      flags:0x00004000
> <6>[   88.593316][    C0] Workqueue:  0x0 (events_unbound)
> <6>[   88.593317][    C0] Call Trace:
> <6>[   88.593317][    C0]  <TASK>
> <6>[   88.593318][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593319][    C0]  schedule+0x34/0xb0
> <6>[   88.593320][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593322][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593323][    C0]  kthread+0xf3/0x120
> <6>[   88.593325][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593326][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593328][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593330][    C0]  ret_from_fork_asm+0x11/0x20
> Panic#1 Part20
> <6>[   88.593331][    C0]  </TASK>
> <6>[   88.593332][    C0] task:kworker/u40:87  state:I stack:0     pid:23=
43  tgid:2343  ppid:2      flags:0x00004000
> <6>[   88.593333][    C0] Workqueue:  0x0 (kec)
> <6>[   88.593334][    C0] Call Trace:
> <6>[   88.593335][    C0]  <TASK>
> <6>[   88.593335][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593336][    C0]  ? acpi_ec_close_event+0x29/0x50
> <6>[   88.593338][    C0]  ? acpi_ec_event_handler+0x97/0x110
> <6>[   88.593340][    C0]  schedule+0x34/0xb0
> <6>[   88.593340][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593342][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593344][    C0]  kthread+0xf3/0x120
> <6>[   88.593346][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593347][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593349][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593350][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593352][    C0]  </TASK>
> <6>[   88.593353][    C0] task:kworker/u40:88  state:D stack:0     pid:23=
44  tgid:2344  ppid:2      flags:0x00004000
> <6>[   88.593354][    C0] Workqueue: events_unbound async_run_entry_fn
> <6>[   88.593355][    C0] Call Trace:
> <6>[   88.593356][    C0]  <TASK>
> <6>[   88.593356][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593357][    C0]  ? select_idle_core.constprop.0+0x81/0x110
> <6>[   88.593359][    C0]  schedule+0x34/0xb0
> <6>[   88.593360][    C0]  schedule_timeout+0xe2/0xf0
> <6>[   88.593361][    C0]  ? asm_sysvec_reschedule_ipi+0x1f/0x30
> <6>[   88.593363][    C0]  wait_for_completion+0x7e/0x130
> <6>[   88.593365][    C0]  dpm_wait_for_superior+0x128/0x150
> <6>[   88.593366][    C0]  device_resume+0x58/0x2c0
> <6>[   88.593368][    C0]  async_resume+0x1d/0x30
> Panic#1 Part19
> <6>[   88.593369][    C0]  async_run_entry_fn+0x2c/0x110
> <6>[   88.593371][    C0]  process_one_work+0x169/0x280
> <6>[   88.593372][    C0]  worker_thread+0x2f5/0x410
> <6>[   88.593374][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593376][    C0]  kthread+0xf3/0x120
> <6>[   88.593378][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593379][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593381][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593382][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593384][    C0]  </TASK>
> <6>[   88.593385][    C0] task:kworker/u40:89  state:D stack:0     pid:23=
45  tgid:2345  ppid:2      flags:0x00004000
> <6>[   88.593386][    C0] Workqueue: events_unbound async_run_entry_fn
> <6>[   88.593387][    C0] Call Trace:
> <6>[   88.593388][    C0]  <TASK>
> <6>[   88.593388][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593389][    C0]  ? select_idle_core.constprop.0+0x81/0x110
> <6>[   88.593391][    C0]  schedule+0x34/0xb0
> <6>[   88.593392][    C0]  schedule_timeout+0xe2/0xf0
> <6>[   88.593393][    C0]  wait_for_completion+0x7e/0x130
> <6>[   88.593394][    C0]  dpm_wait_for_superior+0x128/0x150
> <6>[   88.593396][    C0]  device_resume+0x58/0x2c0
> <6>[   88.593398][    C0]  async_resume+0x1d/0x30
> <6>[   88.593399][    C0]  async_run_entry_fn+0x2c/0x110
> <6>[   88.593400][    C0]  process_one_work+0x169/0x280
> <6>[   88.593402][    C0]  worker_thread+0x2f5/0x410
> <6>[   88.593404][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593406][    C0]  kthread+0xf3/0x120
> <6>[   88.593407][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593409][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593411][    C0]  ? kthread_complete_and_exit+0x20/0x20
> Panic#1 Part18
> <6>[   88.593412][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593414][    C0]  </TASK>
> <6>[   88.593415][    C0] task:kworker/u40:90  state:I stack:0     pid:23=
46  tgid:2346  ppid:2      flags:0x00004000
> <6>[   88.593416][    C0] Workqueue:  0x0 (events_unbound)
> <6>[   88.593417][    C0] Call Trace:
> <6>[   88.593417][    C0]  <TASK>
> <6>[   88.593418][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593419][    C0]  schedule+0x34/0xb0
> <6>[   88.593420][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593422][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593424][    C0]  kthread+0xf3/0x120
> <6>[   88.593425][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593427][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593428][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593430][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593431][    C0]  </TASK>
> <6>[   88.593433][    C0] task:kworker/u40:91  state:I stack:0     pid:23=
47  tgid:2347  ppid:2      flags:0x00004000
> <6>[   88.593434][    C0] Workqueue:  0x0 (events_unbound)
> <6>[   88.593435][    C0] Call Trace:
> <6>[   88.593435][    C0]  <TASK>
> <6>[   88.593436][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593437][    C0]  schedule+0x34/0xb0
> <6>[   88.593438][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593440][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593441][    C0]  kthread+0xf3/0x120
> <6>[   88.593443][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593445][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593446][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593448][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593449][    C0]  </TASK>
> Panic#1 Part17
> <6>[   88.593450][    C0] task:kworker/u40:92  state:I stack:0     pid:23=
48  tgid:2348  ppid:2      flags:0x00004000
> <6>[   88.593452][    C0] Workqueue:  0x0 (events_unbound)
> <6>[   88.593453][    C0] Call Trace:
> <6>[   88.593453][    C0]  <TASK>
> <6>[   88.593454][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593455][    C0]  schedule+0x34/0xb0
> <6>[   88.593456][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593457][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593459][    C0]  kthread+0xf3/0x120
> <6>[   88.593461][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593462][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593464][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593465][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593467][    C0]  </TASK>
> <6>[   88.593468][    C0] task:kworker/u40:93  state:I stack:0     pid:23=
49  tgid:2349  ppid:2      flags:0x00004000
> <6>[   88.593469][    C0] Workqueue:  0x0 (events_unbound)
> <6>[   88.593470][    C0] Call Trace:
> <6>[   88.593471][    C0]  <TASK>
> <6>[   88.593471][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593472][    C0]  schedule+0x34/0xb0
> <6>[   88.593473][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593475][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593477][    C0]  kthread+0xf3/0x120
> <6>[   88.593478][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593480][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593481][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593483][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593484][    C0]  </TASK>
> <6>[   88.593485][    C0] task:kworker/u40:94  state:I stack:0     pid:23=
50  tgid:2350  ppid:2      flags:0x00004000
> Panic#1 Part16
> <6>[   88.593486][    C0] Workqueue:  0x0 (events_unbound)
> <6>[   88.593487][    C0] Call Trace:
> <6>[   88.593488][    C0]  <TASK>
> <6>[   88.593488][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593489][    C0]  schedule+0x34/0xb0
> <6>[   88.593490][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593492][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593494][    C0]  kthread+0xf3/0x120
> <6>[   88.593495][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593497][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593498][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593500][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593502][    C0]  </TASK>
> <6>[   88.593503][    C0] task:kworker/u40:95  state:I stack:0     pid:23=
51  tgid:2351  ppid:2      flags:0x00004000
> <6>[   88.593504][    C0] Workqueue:  0x0 (events_unbound)
> <6>[   88.593505][    C0] Call Trace:
> <6>[   88.593506][    C0]  <TASK>
> <6>[   88.593506][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593507][    C0]  schedule+0x34/0xb0
> <6>[   88.593508][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593510][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593512][    C0]  kthread+0xf3/0x120
> <6>[   88.593513][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593515][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593516][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593518][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593519][    C0]  </TASK>
> <6>[   88.593520][    C0] task:kworker/u40:96  state:I stack:0     pid:23=
52  tgid:2352  ppid:2      flags:0x00004000
> <6>[   88.593522][    C0] Workqueue:  0x0 (events_unbound)
> Panic#1 Part15
> <6>[   88.593523][    C0] Call Trace:
> <6>[   88.593523][    C0]  <TASK>
> <6>[   88.593523][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593525][    C0]  schedule+0x34/0xb0
> <6>[   88.593525][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593527][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593529][    C0]  kthread+0xf3/0x120
> <6>[   88.593531][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593532][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593534][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593535][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593537][    C0]  </TASK>
> <6>[   88.593538][    C0] task:kworker/u40:97  state:I stack:0     pid:23=
53  tgid:2353  ppid:2      flags:0x00004000
> <6>[   88.593539][    C0] Workqueue:  0x0 (events_unbound)
> <6>[   88.593540][    C0] Call Trace:
> <6>[   88.593540][    C0]  <TASK>
> <6>[   88.593541][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593542][    C0]  schedule+0x34/0xb0
> <6>[   88.593543][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593545][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593547][    C0]  kthread+0xf3/0x120
> <6>[   88.593548][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593550][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593552][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593553][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593555][    C0]  </TASK>
> <6>[   88.593556][    C0] task:kworker/u40:98  state:I stack:0     pid:23=
54  tgid:2354  ppid:2      flags:0x00004000
> <6>[   88.593557][    C0] Workqueue:  0x0 (kec)
> <6>[   88.593557][    C0] Call Trace:
> <6>[   88.593558][    C0]  <TASK>
> <6>[   88.593559][    C0]  __schedule+0x2d2/0x1160
> Panic#1 Part14
> <6>[   88.593560][    C0]  ? acpi_ec_close_event+0x29/0x50
> <6>[   88.593561][    C0]  ? acpi_ec_event_handler+0x97/0x110
> <6>[   88.593563][    C0]  schedule+0x34/0xb0
> <6>[   88.593564][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593566][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593568][    C0]  kthread+0xf3/0x120
> <6>[   88.593569][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593571][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593572][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593574][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593575][    C0]  </TASK>
> <6>[   88.593576][    C0] task:kworker/u40:99  state:D stack:0     pid:23=
55  tgid:2355  ppid:2      flags:0x00004000
> <6>[   88.593578][    C0] Workqueue: events_unbound async_run_entry_fn
> <6>[   88.593579][    C0] Call Trace:
> <6>[   88.593580][    C0]  <TASK>
> <6>[   88.593580][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593581][    C0]  schedule+0x34/0xb0
> <6>[   88.593582][    C0]  schedule_timeout+0xe2/0xf0
> <6>[   88.593584][    C0]  wait_for_completion+0x7e/0x130
> <6>[   88.593585][    C0]  dpm_wait_for_superior+0x128/0x150
> <6>[   88.593586][    C0]  device_resume+0x58/0x2c0
> <6>[   88.593588][    C0]  async_resume+0x1d/0x30
> <6>[   88.593589][    C0]  async_run_entry_fn+0x2c/0x110
> <6>[   88.593591][    C0]  process_one_work+0x169/0x280
> <6>[   88.593593][    C0]  worker_thread+0x2f5/0x410
> <6>[   88.593594][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593596][    C0]  kthread+0xf3/0x120
> <6>[   88.593598][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593599][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593601][    C0]  ? kthread_complete_and_exit+0x20/0x20
> Panic#1 Part13
> <6>[   88.593602][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593604][    C0]  </TASK>
> <6>[   88.593605][    C0] task:kworker/u40:100 state:D stack:0     pid:23=
56  tgid:2356  ppid:2      flags:0x00004000
> <6>[   88.593607][    C0] Workqueue: events_unbound async_run_entry_fn
> <6>[   88.593608][    C0] Call Trace:
> <6>[   88.593609][    C0]  <TASK>
> <6>[   88.593609][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593610][    C0]  schedule+0x34/0xb0
> <6>[   88.593611][    C0]  schedule_timeout+0xe2/0xf0
> <6>[   88.593613][    C0]  wait_for_completion+0x7e/0x130
> <6>[   88.593614][    C0]  dpm_wait_for_superior+0x128/0x150
> <6>[   88.593615][    C0]  device_resume+0x58/0x2c0
> <6>[   88.593617][    C0]  async_resume+0x1d/0x30
> <6>[   88.593618][    C0]  async_run_entry_fn+0x2c/0x110
> <6>[   88.593620][    C0]  process_one_work+0x169/0x280
> <6>[   88.593622][    C0]  worker_thread+0x2f5/0x410
> <6>[   88.593623][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593625][    C0]  kthread+0xf3/0x120
> <6>[   88.593627][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593628][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593630][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593631][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593633][    C0]  </TASK>
> <6>[   88.593634][    C0] task:kworker/u40:101 state:D stack:0     pid:23=
57  tgid:2357  ppid:2      flags:0x00004000
> <6>[   88.593635][    C0] Workqueue: events_unbound async_run_entry_fn
> <6>[   88.593636][    C0] Call Trace:
> <6>[   88.593637][    C0]  <TASK>
> <6>[   88.593637][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593639][    C0]  schedule+0x34/0xb0
> <6>[   88.593639][    C0]  schedule_timeout+0xe2/0xf0
> Panic#1 Part12
> <6>[   88.593641][    C0]  wait_for_completion+0x7e/0x130
> <6>[   88.593642][    C0]  dpm_wait_for_superior+0x128/0x150
> <6>[   88.593644][    C0]  device_resume+0x58/0x2c0
> <6>[   88.593645][    C0]  async_resume+0x1d/0x30
> <6>[   88.593647][    C0]  async_run_entry_fn+0x2c/0x110
> <6>[   88.593648][    C0]  process_one_work+0x169/0x280
> <6>[   88.593650][    C0]  worker_thread+0x2f5/0x410
> <6>[   88.593652][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593653][    C0]  kthread+0xf3/0x120
> <6>[   88.593655][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593657][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593658][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593660][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593661][    C0]  </TASK>
> <6>[   88.593662][    C0] task:kworker/u40:102 state:D stack:0     pid:23=
58  tgid:2358  ppid:2      flags:0x00004000
> <6>[   88.593664][    C0] Workqueue: events_unbound async_run_entry_fn
> <6>[   88.593665][    C0] Call Trace:
> <6>[   88.593665][    C0]  <TASK>
> <6>[   88.593666][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593667][    C0]  schedule+0x34/0xb0
> <6>[   88.593668][    C0]  schedule_timeout+0xe2/0xf0
> <6>[   88.593669][    C0]  wait_for_completion+0x7e/0x130
> <6>[   88.593670][    C0]  dpm_wait_for_superior+0x128/0x150
> <6>[   88.593672][    C0]  device_resume+0x58/0x2c0
> <6>[   88.593674][    C0]  async_resume+0x1d/0x30
> <6>[   88.593675][    C0]  async_run_entry_fn+0x2c/0x110
> <6>[   88.593676][    C0]  process_one_work+0x169/0x280
> <6>[   88.593678][    C0]  worker_thread+0x2f5/0x410
> <6>[   88.593680][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593682][    C0]  kthread+0xf3/0x120
> Panic#1 Part11
> <6>[   88.593683][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593685][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593686][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593688][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593689][    C0]  </TASK>
> <6>[   88.593691][    C0] task:kworker/u40:103 state:D stack:0     pid:23=
59  tgid:2359  ppid:2      flags:0x00004000
> <6>[   88.593692][    C0] Workqueue: events_unbound async_run_entry_fn
> <6>[   88.593693][    C0] Call Trace:
> <6>[   88.593694][    C0]  <TASK>
> <6>[   88.593694][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593696][    C0]  schedule+0x34/0xb0
> <6>[   88.593696][    C0]  schedule_timeout+0xe2/0xf0
> <6>[   88.593698][    C0]  wait_for_completion+0x7e/0x130
> <6>[   88.593699][    C0]  dpm_wait_for_superior+0x128/0x150
> <6>[   88.593701][    C0]  device_resume+0x58/0x2c0
> <6>[   88.593702][    C0]  async_resume+0x1d/0x30
> <6>[   88.593704][    C0]  async_run_entry_fn+0x2c/0x110
> <6>[   88.593705][    C0]  process_one_work+0x169/0x280
> <6>[   88.593707][    C0]  worker_thread+0x2f5/0x410
> <6>[   88.593709][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593711][    C0]  kthread+0xf3/0x120
> <6>[   88.593712][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593714][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593715][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593717][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593718][    C0]  </TASK>
> <6>[   88.593720][    C0] task:kworker/u40:104 state:I stack:0     pid:23=
60  tgid:2360  ppid:2      flags:0x00004000
> <6>[   88.593721][    C0] Workqueue:  0x0 (nvme-reset-wq)
> <6>[   88.593722][    C0] Call Trace:
> Panic#1 Part10
> <6>[   88.593722][    C0]  <TASK>
> <6>[   88.593723][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593724][    C0]  schedule+0x34/0xb0
> <6>[   88.593725][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593727][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593728][    C0]  kthread+0xf3/0x120
> <6>[   88.593730][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593731][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593733][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593734][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593736][    C0]  </TASK>
> <6>[   88.593737][    C0] task:kworker/u40:105 state:I stack:0     pid:23=
61  tgid:2361  ppid:2      flags:0x00004000
> <6>[   88.593739][    C0] Workqueue:  0x0 (events_unbound)
> <6>[   88.593740][    C0] Call Trace:
> <6>[   88.593740][    C0]  <TASK>
> <6>[   88.593741][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593742][    C0]  ? flush_to_ldisc+0x67/0x1c0
> <6>[   88.593744][    C0]  schedule+0x34/0xb0
> <6>[   88.593745][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593747][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593749][    C0]  kthread+0xf3/0x120
> <6>[   88.593750][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593752][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593753][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593755][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593756][    C0]  </TASK>
> <6>[   88.593757][    C0] task:kworker/u40:106 state:I stack:0     pid:23=
62  tgid:2362  ppid:2      flags:0x00004000
> <6>[   88.593759][    C0] Call Trace:
> <6>[   88.593759][    C0]  <TASK>
> <6>[   88.593760][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593760][    C0]  ? finish_task_switch.isra.0+0x7d/0x230
> Panic#1 Part9
> <6>[   88.593762][    C0]  ? __schedule+0x2da/0x1160
> <6>[   88.593763][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593765][    C0]  schedule+0x34/0xb0
> <6>[   88.593766][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593768][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593770][    C0]  kthread+0xf3/0x120
> <6>[   88.593771][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593773][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593774][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593776][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593777][    C0]  </TASK>
> <6>[   88.593778][    C0] task:cec-DP-3        state:S stack:0     pid:23=
63  tgid:2363  ppid:2      flags:0x00004000
> <6>[   88.593779][    C0] Call Trace:
> <6>[   88.593780][    C0]  <TASK>
> <6>[   88.593780][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593781][    C0]  ? raw_spin_rq_unlock+0xf/0x30
> <6>[   88.593784][    C0]  ? cec_s_conn_info+0xf0/0xf0 [cec]
> <6>[   88.593788][    C0]  schedule+0x34/0xb0
> <6>[   88.593789][    C0]  cec_thread_func+0x150/0x440 [cec]
> <6>[   88.593793][    C0]  ? destroy_sched_domains_rcu+0x30/0x30
> <6>[   88.593795][    C0]  ? cec_s_conn_info+0xf0/0xf0 [cec]
> <6>[   88.593798][    C0]  kthread+0xf3/0x120
> <6>[   88.593800][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593801][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593803][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593804][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593806][    C0]  </TASK>
> <6>[   88.593807][    C0] task:kworker/1:3     state:I stack:0     pid:23=
64  tgid:2364  ppid:2      flags:0x00004000
> <6>[   88.593808][    C0] Call Trace:
> Panic#1 Part8
> <6>[   88.593809][    C0]  <TASK>
> <6>[   88.593809][    C0]  __schedule+0x2d2/0x1160
> <6>[   88.593810][    C0]  ? finish_task_switch.isra.0+0x7d/0x230
> <6>[   88.593812][    C0]  ? __schedule+0x2da/0x1160
> <6>[   88.593813][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593815][    C0]  schedule+0x34/0xb0
> <6>[   88.593816][    C0]  worker_thread+0x1dc/0x410
> <6>[   88.593818][    C0]  ? rescuer_thread+0x410/0x410
> <6>[   88.593819][    C0]  kthread+0xf3/0x120
> <6>[   88.593821][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593823][    C0]  ret_from_fork+0x34/0x50
> <6>[   88.593824][    C0]  ? kthread_complete_and_exit+0x20/0x20
> <6>[   88.593826][    C0]  ret_from_fork_asm+0x11/0x20
> <6>[   88.593827][    C0]  </TASK>
> <4>[   88.593828][    C0] Mem-Info:
> <4>[   88.593830][    C0] active_anon:697 inactive_anon:52543 isolated_an=
on:0
> <4>[   88.593830][    C0]  active_file:487 inactive_file:663 isolated_fil=
e:0
> <4>[   88.593830][    C0]  unevictable:2634 dirty:0 writeback:0
> <4>[   88.593830][    C0]  slab_reclaimable:7266 slab_unreclaimable:22623
> <4>[   88.593830][    C0]  mapped:783 shmem:3149 pagetables:2953
> <4>[   88.593830][    C0]  sec_pagetables:0 bounce:0
> <4>[   88.593830][    C0]  kernel_misc_reclaimable:0
> <4>[   88.593830][    C0]  free:7986878 free_pcp:2259 free_cma:0
> <4>[   88.593833][    C0] Node 0 active_anon:2788kB inactive_anon:210172k=
B active_file:1948kB inactive_file:2652kB unevictable:10536kB isolated(anon=
):0kB isolated(file):0kB mapped:3132kB dirty:0kB writeback:0kB shmem:12596k=
B shmem_thp:8192kB shmem_pmdmapped:0kB anon_thp:0kB writeback_tmp:0kB kerne=
l_stack:11072kB pagetables:11812kB sec_pagetables:0kB all_unreclaimable? no
> Panic#1 Part7
> <4>[   88.593836][    C0] Node 0 DMA free:15360kB boost:0kB min:32kB low:=
44kB high:56kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB ac=
tive_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15=
992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB fre=
e_cma:0kB
> <4>[   88.593840][    C0] lowmem_reserve[]: 0 1261 31611 31611
> <4>[   88.593842][    C0] Node 0 DMA32 free:1356064kB boost:0kB min:2696k=
B low:3988kB high:5280kB reserved_highatomic:0KB active_anon:0kB inactive_a=
non:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB =
present:1422044kB managed:1356076kB mlocked:0kB bounce:0kB free_pcp:0kB loc=
al_pcp:0kB free_cma:0kB
> <4>[   88.593844][    C0] lowmem_reserve[]: 0 0 30349 30349
> <4>[   88.593846][    C0] Node 0 Normal free:30576088kB boost:0kB min:648=
52kB low:95928kB high:127004kB reserved_highatomic:0KB active_anon:2788kB i=
nactive_anon:210172kB active_file:1948kB inactive_file:2652kB unevictable:1=
0536kB writepending:0kB present:31711232kB managed:31079872kB mlocked:0kB b=
ounce:0kB free_pcp:9036kB local_pcp:9036kB free_cma:0kB
> <4>[   88.593849][    C0] lowmem_reserve[]: 0 0 0 0
> <4>[   88.593851][    C0] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*=
128kB 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) =3D 15360kB
> <4>[   88.593856][    C0] Node 0 DMA32: 8*4kB (UM) 8*8kB (UM) 6*16kB (UM)=
 7*32kB (UM) 4*64kB (UM) 7*128kB (UM) 7*256kB (UM) 6*512kB (UM) 4*1024kB (U=
M) 3*2048kB (UM) 327*4096kB (UM) =3D 1356064kB
> Panic#1 Part6
> <4>[   88.593864][    C0] Node 0 Normal: 7758*4kB (UME) 6244*8kB (UME) 41=
36*16kB (UME) 2970*32kB (UME) 1929*64kB (UME) 1075*128kB (UME) 516*256kB (U=
ME) 218*512kB (UME) 136*1024kB (UME) 59*2048kB (UM) 7219*4096kB (U) =3D 305=
76088kB
> <4>[   88.593872][    C0] Node 0 hugepages_total=3D0 hugepages_free=3D0 h=
ugepages_surp=3D0 hugepages_size=3D1048576kB
> <4>[   88.593873][    C0] Node 0 hugepages_total=3D0 hugepages_free=3D0 h=
ugepages_surp=3D0 hugepages_size=3D2048kB
> <4>[   88.593874][    C0] 20259 total pagecache pages
> <4>[   88.593875][    C0] 15960 pages in swap cache
> <4>[   88.593875][    C0] Free swap  =3D 33261448kB
> <4>[   88.593876][    C0] Total swap =3D 33554428kB
> <4>[   88.593876][    C0] 8287317 pages RAM
> <4>[   88.593876][    C0] 0 pages HighMem/MovableOnly
> <4>[   88.593877][    C0] 174490 pages reserved
> <4>[   88.593877][    C0] 0 pages hwpoisoned
> <4>[   88.593878][    C0] Timer List Version: v0.9
> <4>[   88.593878][    C0] HRTIMER_MAX_CLOCK_BASES: 8
> <4>[   88.593879][    C0] now at 88575853437 nsecs
> <4>[   88.593879][    C0]=20
> <4>[   88.593880][    C0] cpu: 0
> <4>[   88.593880][    C0]  clock 0:
> <4>[   88.593880][    C0]   .base:               pK-error
> <4>[   88.593881][    C0]   .index:      0
> <4>[   88.593882][    C0]   .resolution: 1 nsecs
> <4>[   88.593882][    C0]   .get_time:   ktime_get
> <4>[   88.593884][    C0]   .offset:     0 nsecs
> <4>[   88.593884][    C0] active timers:
> <4>[   88.593885][    C0]  #0: <        pK-error>, watchdog_timer_fn
> <4>[   88.593886][    C0] , S:01
> <4>[   88.593886][    C0]=20
> <4>[   88.593887][    C0]  # expires at 89320114349-89320114349 nsecs [in=
 744260912 to 744260912 nsecs]
> Panic#1 Part5
> <4>[   88.593888][    C0]  #1: <        pK-error>, tick_nohz_highres_hand=
ler
> <4>[   88.593890][    C0] , S:01
> <4>[   88.593891][    C0]=20
> <4>[   88.593891][    C0]  # expires at 91211000000-91211000000 nsecs [in=
 2635146563 to 2635146563 nsecs]
> <4>[   88.593892][    C0]  #2: <        pK-error>, timerfd_tmrproc
> <4>[   88.593893][    C0] , S:01
> <4>[   88.593894][    C0]=20
> <4>[   88.593894][    C0]  # expires at 111644928000-111644928000 nsecs [=
in 23069074563 to 23069074563 nsecs]
> <4>[   88.593895][    C0]  #3: <        pK-error>, timerfd_tmrproc
> <4>[   88.593897][    C0] , S:01
> <4>[   88.593897][    C0]=20
> <4>[   88.593897][    C0]  # expires at 111644928000-111644928000 nsecs [=
in 23069074563 to 23069074563 nsecs]
> <4>[   88.593898][    C0]  #4: <        pK-error>, timerfd_tmrproc
> <4>[   88.593899][    C0] , S:01
> <4>[   88.593899][    C0]=20
> <4>[   88.593900][    C0]  # expires at 111644928000-111644928000 nsecs [=
in 23069074563 to 23069074563 nsecs]
> <4>[   88.593901][    C0]  #5: <        pK-error>, timerfd_tmrproc
> <4>[   88.593902][    C0] , S:01
> <4>[   88.593902][    C0]=20
> <4>[   88.593902][    C0]  # expires at 111644928000-111644928000 nsecs [=
in 23069074563 to 23069074563 nsecs]
> <4>[   88.593903][    C0]  #6: <        pK-error>, hrtimer_wakeup
> <4>[   88.593904][    C0] , S:01
> <4>[   88.593905][    C0]=20
> <4>[   88.593905][    C0]  # expires at 1810465859021-1810465909021 nsecs=
 [in 1721890005584 to 1721890055584 nsecs]
> <4>[   88.593906][    C0]  clock 1:
> <4>[   88.593906][    C0]   .base:               pK-error
> <4>[   88.593907][    C0]   .index:      1
> <4>[   88.593907][    C0]   .resolution: 1 nsecs
> <4>[   88.593907][    C0]   .get_time:   ktime_get_real
> Panic#1 Part4
> <4>[   88.593908][    C0]   .offset:     1713027022323372591 nsecs
> <4>[   88.593909][    C0] active timers:
> <4>[   88.593909][    C0]  #0: <        pK-error>, sync_timer_callback
> <4>[   88.593911][    C0] , S:01
> <4>[   88.593911][    C0]=20
> <4>[   88.593911][    C0]  # expires at 1713027679500000000-1713027679500=
000000 nsecs [in 568600773972 to 568600773972 nsecs]
> <4>[   88.593913][    C0]  #1: <        pK-error>, timerfd_tmrproc
> <4>[   88.593914][    C0] , S:01
> <4>[   88.593914][    C0]=20
> <4>[   88.593914][    C0]  # expires at 1713029451644928000-1713029451644=
928000 nsecs [in 2340745701972 to 2340745701972 nsecs]
> <4>[   88.593915][    C0]  #2: <        pK-error>, timerfd_tmrproc
> <4>[   88.593917][    C0] , S:01
> <4>[   88.593917][    C0]=20
> <4>[   88.593917][    C0]  # expires at 9223372036854775807-9223372036854=
775807 nsecs [in 7510344925955549779 to 7510344925955549779 nsecs]
> <4>[   88.593918][    C0]  #3: <        pK-error>, timerfd_tmrproc
> <4>[   88.593920][    C0] , S:01
> <4>[   88.593920][    C0]=20
> <4>[   88.593920][    C0]  # expires at 9223372036854775807-9223372036854=
775807 nsecs [in 7510344925955549779 to 7510344925955549779 nsecs]
> <4>[   88.593921][    C0]  #4: <        pK-error>, timerfd_tmrproc
> <4>[   88.593922][    C0] , S:01
> <4>[   88.593922][    C0]=20
> <4>[   88.593923][    C0]  # expires at 9223372036854775807-9223372036854=
775807 nsecs [in 7510344925955549779 to 7510344925955549779 nsecs]
> <4>[   88.593924][    C0]  #5: <        pK-error>, timerfd_tmrproc
> <4>[   88.593925][    C0] , S:01
> <4>[   88.593925][    C0]=20
> <4>[   88.593925][    C0]  # expires at 9223372036854775807-9223372036854=
775807 nsecs [in 7510344925955549779 to 7510344925955549779 nsecs]

> # bad: [01e08e5d7656e660c8a4852191e1e133cbdb0a66] Linux 6.7.3
> # good: [7bbf3b67cb49d0f8a20e64b7473923041b758211] Linux 6.7.2
> git bisect start 'v6.7.3' 'v6.7.2'
> # bad: [056fc740be000d39a7dba700a935f3bbfbc664e6] rxrpc, afs: Allow afs t=
o pin rxrpc_peer objects
> git bisect bad 056fc740be000d39a7dba700a935f3bbfbc664e6
> # bad: [d1020ab1199e197c6504daf3a415d4f7465016ef] arm64: dts: qcom: sm815=
0: fix USB SS wakeup
> git bisect bad d1020ab1199e197c6504daf3a415d4f7465016ef
> # bad: [b0028f333420a65a53a63978522db680b37379dd] nbd: always initialize =
struct msghdr completely
> git bisect bad b0028f333420a65a53a63978522db680b37379dd
> # bad: [eaef4650fa2050147ca25fd7ee43bc0082e03c87] PM / devfreq: Fix buffe=
r overflow in trans_stat_show
> git bisect bad eaef4650fa2050147ca25fd7ee43bc0082e03c87
> # bad: [9bd3dce27b01c51295b60e1433e1dadfb16649f7] PM: sleep: Fix possible=
 deadlocks in core system-wide PM code
> git bisect bad 9bd3dce27b01c51295b60e1433e1dadfb16649f7
> # good: [6fb70694f8d1ac34e45246b0ac988f025e1e5b55] pipe: wakeup wr_wait a=
fter setting max_usage
> git bisect good 6fb70694f8d1ac34e45246b0ac988f025e1e5b55
> # good: [73986e8d2808c24b88c7b36a081fb351d2bf6a30] ext4: allow for the la=
st group to be marked as trimmed
> git bisect good 73986e8d2808c24b88c7b36a081fb351d2bf6a30
> # good: [22f7c9cb05cd5153100c859099da64982e9c1d1f] async: Introduce async=
_schedule_dev_nocall()
> git bisect good 22f7c9cb05cd5153100c859099da64982e9c1d1f
> # first bad commit: [9bd3dce27b01c51295b60e1433e1dadfb16649f7] PM: sleep:=
 Fix possible deadlocks in core system-wide PM code

Also Cc: people in the culprit's signed-off chain and regressions mailing
list.

--=20
An old man doll... just what I always wanted! - Clara

--CAJphcl6COmIsNLl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZhseLgAKCRD2uYlJVVFO
o75KAQC2E7NOXd2R/VfO11uBt7wzKBauT5h2QojIbBYn6+o7OgD/YtFz1MH1vpyd
gSuQ+S19fbKi5Y8f/Gpl6A7Qa7JICwU=
=sM4K
-----END PGP SIGNATURE-----

--CAJphcl6COmIsNLl--

