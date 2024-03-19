Return-Path: <linux-kernel+bounces-107330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB71E87FB23
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797922816A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288DA7D3F3;
	Tue, 19 Mar 2024 09:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/JjYDRv"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654367D091;
	Tue, 19 Mar 2024 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841990; cv=none; b=bUyNsGnSUlRP5KRLAonACx5ECr5Cy9TwiIPPtzKuOvQf2/KttCkUEF04aFUfRBomoAZwNRls4FqoaBW9EL4cGq2n5HMcXazahkpkW1XUPkF245OtaXMlug2BsxhoGSVu7gWsHkepRjpGjYWP9UP4qD2SJAHjv7a26oclYROkUlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841990; c=relaxed/simple;
	bh=y+AjS58tO08rvNNHdkZptEDhEi3dtLOcTLMORN4uUw0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4+3HJAEds4FxHv0nj4k2nsyqarDuCdcQyQHEM1kYP6xOMCjs+Ugrgf0oQ0RHto4qhc7KT3/bN3aQVRtUAfwRadO0d6GbUMVvQYFKMc9N6KBUeR6RADFFnHHorS8GgOyFTNyd2R57SNvQ6eTJwkKO+9zPclZi+SeMzKLzEx4trY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T/JjYDRv; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512ed314881so3718315e87.2;
        Tue, 19 Mar 2024 02:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710841986; x=1711446786; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P4jMbLwyrF7LyJaOBfqzY+J7LoRNyOTt8719SE/17jI=;
        b=T/JjYDRveBwbnKE+QfA0FSvGcMDU63S/G5h7yqZ7qm3GNFOE/WxApTan/8I2wXePew
         1ddvfDoeEHKS7Ujm7Xh+pyhLIApGM1Eh6VhbBlh4O+NCrlY6J50MRS7vDOcL9RZAvWO7
         5wfSsaPFyc/9GZLqFyw64Iaqdck+xjix0Prf2pyW4TZGVWyyX1wqA4R+XlWa4cC8Z/x1
         wiHO7QoYvVUqoM4z/cPNrYgN4eODypt8Tst6WZCM0TtzEjb2EkNApTSc1napoj63UwRZ
         hwh1DddtUaGB7hI12BF5pKb7tMNs5xPTcz11gHkorvzmhWoyZw/KMurjjcRGcUvqfCoX
         ftlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841986; x=1711446786;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4jMbLwyrF7LyJaOBfqzY+J7LoRNyOTt8719SE/17jI=;
        b=OPtpzj8b9Qm401O9qYY4NPoHrgn97zAvJlZnm2KmXjZ5vdlQmye1nc8Hpu9Z/2f/E8
         8iQMhzaK7I+fqdok0Vg6+z40LIzILEwjpVLUX/ZaafDdzZF618VXhBvTTgpf4eso8spT
         AvKev7M1tOV48DeCmwzjtR2RtmtJPswCyVaw/hWiwKqndZLiuceBLnLzypII/Ch4Ku2j
         Ld+1Pgu15IMwcAHySfEKafHhMY09QW/fDQ7WiwTZOHU9xtvf8BttbKM9Lqq4ukyOc3wS
         qm/2i7QWhlwEXM7ekZoobkI3ATedX+toa/IZUA//q+s51WTaBgRjEjgB8KADHrIUPh1m
         6+/g==
X-Forwarded-Encrypted: i=1; AJvYcCURC8SmGhnGoW9dhZLS6Iz6i49GKHRuyn93XMYcudlUjwVWR7XaBvUw0S78xe50iPRXAKvk40oI3ydgWp/oRzxIn6APDntPvnFtAWP5Gg2ChPdGOiH+n4U/8tp7XyNK2++X
X-Gm-Message-State: AOJu0YzmTwrm500sGlqPWN63eGBPRnDZ0czOd0Mb/kq7yaxt97K96di8
	6zwhbmWjQKtLthdqydzqbRZTKue1+VdMNqbETSGRHKFsFHqNtTzukhQznYHOXWc=
X-Google-Smtp-Source: AGHT+IEBC60yaWLIQW7rrY/C5j4QaIqm2DxgEYLxaVQ5i3+5s+O5z8Ef5r2vVYjYSMVRM5/8UToj0g==
X-Received: by 2002:a19:3854:0:b0:513:c632:24bc with SMTP id d20-20020a193854000000b00513c63224bcmr1304981lfj.35.1710841986197;
        Tue, 19 Mar 2024 02:53:06 -0700 (PDT)
Received: from pc636 (host-90-235-3-101.mobileonline.telia.com. [90.235.3.101])
        by smtp.gmail.com with ESMTPSA id cf31-20020a056512281f00b00513af58dfefsm1879157lfb.51.2024.03.19.02.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 02:53:05 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 19 Mar 2024 10:53:02 +0100
To: Joel Fernandes <joel@joelfernandes.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, linux-kernel@vger.kernel.org,
	frederic@kernel.org, boqun.feng@gmail.com, neeraj.iitr10@gmail.com,
	rcu@vger.kernel.org, rostedt@goodmis.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v2 rcu/dev 1/2] rcu/tree: Reduce wake up for
 synchronize_rcu() common case
Message-ID: <ZflgfrjZSZdqrLLw@pc636>
References: <ZfiOwtPfnxXW4JX3@pc636>
 <404E28F5-B018-4CE7-BE57-D0362B0C9969@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <404E28F5-B018-4CE7-BE57-D0362B0C9969@joelfernandes.org>

On Mon, Mar 18, 2024 at 05:05:31PM -0400, Joel Fernandes wrote:
> 
> 
> > On Mar 18, 2024, at 2:58 PM, Uladzislau Rezki <urezki@gmail.com> wrote:
> > 
> > ﻿Hello, Joel!
> > 
> > Sorry for late checking, see below few comments:
> > 
> >> In the synchronize_rcu() common case, we will have less than
> >> SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> >> is pointless just to free the last injected wait head since at that point,
> >> all the users have already been awakened.
> >> 
> >> Introduce a new counter to track this and prevent the wakeup in the
> >> common case.
> >> 
> >> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >> ---
> >> Rebased on paul/dev of today.
> >> 
> >> kernel/rcu/tree.c | 36 +++++++++++++++++++++++++++++++-----
> >> kernel/rcu/tree.h |  1 +
> >> 2 files changed, 32 insertions(+), 5 deletions(-)
> >> 
> >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> index 9fbb5ab57c84..bd29fe3c76bf 100644
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -96,6 +96,7 @@ static struct rcu_state rcu_state = {
> >>    .ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
> >>    .srs_cleanup_work = __WORK_INITIALIZER(rcu_state.srs_cleanup_work,
> >>        rcu_sr_normal_gp_cleanup_work),
> >> +    .srs_cleanups_pending = ATOMIC_INIT(0),
> >> };
> >> 
> >> /* Dump rcu_node combining tree at boot to verify correct setup. */
> >> @@ -1642,8 +1643,11 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> >>     * the done tail list manipulations are protected here.
> >>     */
> >>    done = smp_load_acquire(&rcu_state.srs_done_tail);
> >> -    if (!done)
> >> +    if (!done) {
> >> +        /* See comments below. */
> >> +        atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> >>        return;
> >> +    }
> >> 
> >>    WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
> >>    head = done->next;
> >> @@ -1666,6 +1670,9 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> >> 
> >>        rcu_sr_put_wait_head(rcu);
> >>    }
> >> +
> >> +    /* Order list manipulations with atomic access. */
> >> +    atomic_dec_return_release(&rcu_state.srs_cleanups_pending);
> >> }
> >> 
> >> /*
> >> @@ -1673,7 +1680,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> >>  */
> >> static void rcu_sr_normal_gp_cleanup(void)
> >> {
> >> -    struct llist_node *wait_tail, *next, *rcu;
> >> +    struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
> >>    int done = 0;
> >> 
> >>    wait_tail = rcu_state.srs_wait_tail;
> >> @@ -1699,16 +1706,35 @@ static void rcu_sr_normal_gp_cleanup(void)
> >>            break;
> >>    }
> >> 
> >> -    // concurrent sr_normal_gp_cleanup work might observe this update.
> >> -    smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >> +    /*
> >> +     * Fast path, no more users to process. Remove the last wait head
> >> +     * if no inflight-workers. If there are in-flight workers, let them
> >> +     * remove the last wait head.
> >> +     */
> >> +    WARN_ON_ONCE(!rcu);
> >> 
> > This assumption is not correct. An "rcu" can be NULL in fact.
> 
> Hmm I could never trigger that. Are you saying that is true after Neeraj recent patch or something else?
> Note, after Neeraj patch to handle the lack of heads availability, it could be true so I requested
> him to rebase his patch on top of this one.
> 
> However I will revisit my patch and look for if it could occur but please let me know if you knew of a sequence of events to make it NULL.
> > 
I think we should agree on your patch first otherwise it becomes a bit
messy or go with a Neeraj as first step and then work on youth. So, i
reviewed this patch based on latest Paul's dev branch. I see that Neeraj
needs further work.

So this is true without Neeraj patch. Consider the following case:

3     2     1     0
wh -> cb -> cb -> cb -> NULL

we start to process from 2 and handle all clients, in the end,
an "rcu" points to NULL and trigger the WARN_ON_ONCE. I see the
splat during the boot:

<snip>
[    0.927699][   T16] ------------[ cut here ]------------
[    0.930867][   T16] WARNING: CPU: 0 PID: 16 at kernel/rcu/tree.c:1721 rcu_gp_cleanup+0x37b/0x4a0
[    0.930490][    T1] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.931401][   T16] Modules linked in:
[    0.932400][    T1] PCI: Using configuration type 1 for base access
[    0.932771][   T16]
[    0.932773][   T16] CPU: 0 PID: 16 Comm: rcu_sched Not tainted 6.8.0-rc2-00089-g65ae0a6b86f0-dirty #1156
[    0.937780][   T16] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    0.939402][   T16] RIP: 0010:rcu_gp_cleanup+0x37b/0x4a0
[    0.940636][   T16] Code: b0 4b bd 72 09 48 81 ff e8 b0 4b bd 76 1e 4c 8b 27 48 83 c7 10 e8 a5 8e fb ff 4c 89 23 83 ed 01 74 0a 4c 89 e7 48 85 ff 75 d2 <0f> 0b 48 8b 35 14 d0 fd 02 48 89 1d 8d 64 d0 01 48 83 c4 08 48 c7
[    0.942402][   T16] RSP: 0018:ffff9b4a8008fe88 EFLAGS: 00010246
[    0.943648][   T16] RAX: 0000000000000000 RBX: ffffffffbd4bb0a8 RCX: 6c9b26c9b26c9b27
[    0.944751][   T16] RDX: 0000000000000000 RSI: 00000000374b92b6 RDI: 0000000000000000
[    0.945757][   T16] RBP: 0000000000000004 R08: fffffffffff54ea1 R09: 0000000000000000
[    0.946753][   T16] R10: ffff89070098c278 R11: 0000000000000001 R12: 0000000000000000
[    0.947752][   T16] R13: fffffffffffffcbc R14: 0000000000000000 R15: ffffffffbd3f1300
[    0.948764][   T16] FS:  0000000000000000(0000) GS:ffff8915efe00000(0000) knlGS:0000000000000000
[    0.950403][   T16] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.951656][   T16] CR2: ffff89163ffff000 CR3: 00000002eae26000 CR4: 00000000000006f0
[    0.952755][   T16] Call Trace:
[    0.953597][   T16]  <TASK>
[    0.955404][   T16]  ? __warn+0x80/0x140
[    0.956608][   T16]  ? rcu_gp_cleanup+0x37b/0x4a0
[    0.957621][   T16]  ? report_bug+0x15d/0x180
[    0.959403][   T16]  ? handle_bug+0x3c/0x70
[    0.960616][   T16]  ? exc_invalid_op+0x17/0x70
[    0.961620][   T16]  ? asm_exc_invalid_op+0x1a/0x20
[    0.962627][   T16]  ? rcu_gp_cleanup+0x37b/0x4a0
[    0.963622][   T16]  ? rcu_gp_cleanup+0x36b/0x4a0
[    0.965403][   T16]  ? __pfx_rcu_gp_kthread+0x10/0x10
[    0.967402][   T16]  rcu_gp_kthread+0xf7/0x180
[    0.968619][   T16]  kthread+0xd3/0x100
[    0.969602][   T16]  ? __pfx_kthread+0x10/0x10
[    0.971402][   T16]  ret_from_fork+0x34/0x50
[    0.972613][   T16]  ? __pfx_kthread+0x10/0x10
[    0.973615][   T16]  ret_from_fork_asm+0x1b/0x30
[    0.974624][   T16]  </TASK>
[    0.975587][   T16] ---[ end trace 0000000000000000 ]---
<snip>

--
Uladzislau Rezki

