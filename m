Return-Path: <linux-kernel+bounces-101242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E6287A48A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2260D1C21C19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEB41BC3B;
	Wed, 13 Mar 2024 09:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8gPwY9q"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216941B59B;
	Wed, 13 Mar 2024 09:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320659; cv=none; b=mJdIxn7j2owmeo1AI61OvYGfuHgitzLO1X+9ovXt8/2u0eWl2saAGuXoefCFBJ0MDrvuvxxdy4U+kFAcPtJs/3IkSbr/ZV+p5amK3Mz0th5LLtrpt8NJW9D3qs1jMPcS1g4K50pHtUZbwJwBQuuQKWTbAPeH/qriCmwcqBIkyFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320659; c=relaxed/simple;
	bh=OY7dmVLts/l8qSevFTkHGMcjHfepEVJnm07/K15atac=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PuxMv9zRTWkbYWQM8XZT3LEnt2GcN9Brt3zXkTrJ/ZoaDOcmUXcSTfoYXj0kEpspPx00qoPA5FhCUNcU+Uh1NIFMZlmkvhdV3qkOs8QqcgHlWkb4n/mToQ0+uLi2F4secidtWQzF+dPXtkkrCANSGom0ndniA9UaFRk217LIXww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8gPwY9q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4132f37e170so15165835e9.2;
        Wed, 13 Mar 2024 02:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710320655; x=1710925455; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QjqI0UtI7NlkaSgyzcRJ5GhIlnZWE1jspTguoc6XJII=;
        b=S8gPwY9qhaZVR6Bb09+d5LLt9+hBoDdNWpgKUAGzap7aZPiQNNOOD/AAFwP7esWLPV
         IQa2U/BbnVOcANfyAPU490C85yL8mMSCBFPln4QggI7Mc4tJiEsLqITWt/UaRfDF5va9
         KWkhMDsZhVpfzfVrCR9lTlbkB+Hwkitiv0Lb/wbf5pZdtFNi5qO58GdjpwagXyr+SlaR
         wiSfBzpROgA4Mp7xGynIqDjy/3A6HP2rYIpSBCheH+22aISUP/yyhI1oGTNN7qNNE5qx
         185XxU07u8s6z3ofN1w67HMRJDUamdm/8q4QkD+RY3dxyQ3na1Htzfv0j+NWow6dgJlc
         AZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710320655; x=1710925455;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QjqI0UtI7NlkaSgyzcRJ5GhIlnZWE1jspTguoc6XJII=;
        b=Z2piCzEA74RQw+qmY5lQ7sEzSSAqAL0qYXJoyIXTc637TYp/nIyNga9xvhk+R1SxG3
         wTQQdXAfjkIpa1ecN23g1X/q6rqv7/fMsC40ThhAXmHNcmH8eWTRoz/evGXftR2zGzwx
         nqJtjQdd/43swGBQEmTbD1nKuSZL6792ojZZEqMNC5JJeQo4CkGCKCzPSmgLfgLSCqL3
         Bgtgd5Ht399Hb3gA0vDUprRjEGMywfKRDS0MY2kwzxHXsEjawV3bLepqhydg8uxpi0AR
         VviXMd8PFFOMZ1NbH2UsU5mf8YI2DHuersIZm77ZTkGnTCeZJBef0RTdoMd7QcDqqzFH
         O0MA==
X-Forwarded-Encrypted: i=1; AJvYcCUU9vP/dCQWlNvkivUgva7ZI8bBljfW/cASVIbjhA4he5jtbuLJBZtWNMC/HAivNHKK1tfAoeJvqWTB6FZfFUHUCGy/XMizhUS7NWtLO53c60L5tMIgN8q4L+bhBtrIQhGohYMK37if67bsW/ai5tKMfUyS6MzdIWgB
X-Gm-Message-State: AOJu0YwlvGbmgLq/KwMqQCVG69fq/ERxoaTL9vaWO+vhiBchSf3EaSAB
	w+HYAeLMmKluCy4CKtXjVTpTojozT0XooCm8j/bxBn0kZK3f6lfG
X-Google-Smtp-Source: AGHT+IH3UHABTxaiQniABaOfSvf4/sZ4Ay97aD9Qzeat6erm1yzjN60nJJ7df8qTsrC+qywcrJ+eMQ==
X-Received: by 2002:a05:600c:524c:b0:412:eb6e:1fdb with SMTP id fc12-20020a05600c524c00b00412eb6e1fdbmr1520565wmb.40.1710320654430;
        Wed, 13 Mar 2024 02:04:14 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id n2-20020adfe782000000b0033e7715bafasm11155874wrm.59.2024.03.13.02.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 02:04:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 13 Mar 2024 10:04:11 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	syzbot <syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com>,
	andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
	daniel@iogearbox.net, haoluo@google.com, john.fastabend@gmail.com,
	kpsingh@kernel.org, linux-kernel@vger.kernel.org,
	martin.lau@linux.dev, netdev@vger.kernel.org, sdf@google.com,
	song@kernel.org, syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] possible deadlock in __bpf_ringbuf_reserve
Message-ID: <ZfFsC6zyrUCtTxK-@krava>
References: <0000000000004aa700061379547e@google.com>
 <ZfDC45Kc1VEvBMuW@krava>
 <ZfDGmoOcUqrHPSkq@krava>
 <CAEf4Bza8iH4_JY_sN-6GYeSfn6iuUsLMzxd=xRkCC7q-3_StNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza8iH4_JY_sN-6GYeSfn6iuUsLMzxd=xRkCC7q-3_StNQ@mail.gmail.com>

On Tue, Mar 12, 2024 at 03:37:16PM -0700, Andrii Nakryiko wrote:
> On Tue, Mar 12, 2024 at 2:18 PM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Tue, Mar 12, 2024 at 10:02:27PM +0100, Jiri Olsa wrote:
> > > On Tue, Mar 12, 2024 at 09:41:26AM -0700, syzbot wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    df4793505abd Merge tag 'net-6.8-rc8' of git://git.kernel.o..
> > > > git tree:       bpf
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=11fd0092180000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=c11c5c676adb61f0
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=850aaf14624dc0c6d366
> > > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1509c4ae180000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10babc01180000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/d2e80ee1112b/disk-df479350.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/b35ea54cd190/vmlinux-df479350.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/59f69d999ad2/bzImage-df479350.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+850aaf14624dc0c6d366@syzkaller.appspotmail.com
> > > >
> > > > ============================================
> > > > WARNING: possible recursive locking detected
> > > > 6.8.0-rc7-syzkaller-gdf4793505abd #0 Not tainted
> > > > --------------------------------------------
> > > > strace-static-x/5063 is trying to acquire lock:
> > > > ffffc900096f10d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> > > >
> > > > but task is already holding lock:
> > > > ffffc900098410d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> > > >
> > > > other info that might help us debug this:
> > > >  Possible unsafe locking scenario:
> > > >
> > > >        CPU0
> > > >        ----
> > > >   lock(&rb->spinlock);
> > > >   lock(&rb->spinlock);
> > > >
> > > >  *** DEADLOCK ***
> > > >
> > > >  May be due to missing lock nesting notation
> > > >
> > > > 4 locks held by strace-static-x/5063:
> > > >  #0: ffff88807857e068 (&pipe->mutex/1){+.+.}-{3:3}, at: __pipe_lock fs/pipe.c:103 [inline]
> > > >  #0: ffff88807857e068 (&pipe->mutex/1){+.+.}-{3:3}, at: pipe_write+0x1cc/0x1a40 fs/pipe.c:465
> > > >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
> > > >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
> > > >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
> > > >  #1: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420
> > > >  #2: ffffc900098410d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> > > >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
> > > >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
> > > >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
> > > >  #3: ffffffff8e130be0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x114/0x420 kernel/trace/bpf_trace.c:2420
> > > >
> > > > stack backtrace:
> > > > CPU: 0 PID: 5063 Comm: strace-static-x Not tainted 6.8.0-rc7-syzkaller-gdf4793505abd #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:88 [inline]
> > > >  dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
> > > >  check_deadlock kernel/locking/lockdep.c:3062 [inline]
> > > >  validate_chain+0x15c0/0x58e0 kernel/locking/lockdep.c:3856
> > > >  __lock_acquire+0x1345/0x1fd0 kernel/locking/lockdep.c:5137
> > > >  lock_acquire+0x1e3/0x530 kernel/locking/lockdep.c:5754
> > > >  __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
> > > >  _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
> > > >  __bpf_ringbuf_reserve+0x211/0x4f0 kernel/bpf/ringbuf.c:424
> > > >  ____bpf_ringbuf_reserve kernel/bpf/ringbuf.c:459 [inline]
> > > >  bpf_ringbuf_reserve+0x5c/0x70 kernel/bpf/ringbuf.c:451
> > > >  bpf_prog_9efe54833449f08e+0x2d/0x47
> > > >  bpf_dispatcher_nop_func include/linux/bpf.h:1231 [inline]
> > > >  __bpf_prog_run include/linux/filter.h:651 [inline]
> > > >  bpf_prog_run include/linux/filter.h:658 [inline]
> > > >  __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
> > >
> > > hum, scratching my head how this could passed through the prog->active check,
> >
> > nah could be 2 instances of the same program, got confused by the tag
> >
> > trace_contention_end
> >   __bpf_trace_run(prog1)
> >     bpf_prog_9efe54833449f08e
> >       bpf_ringbuf_reserve
> >         trace_contention_end
> >           __bpf_trace_run(prog1)  prog1->active check fails
> >           __bpf_trace_run(prog2)
> >             bpf_prog_9efe54833449f08e
> >               bpf_ringbuf_reserve
> >                 lockup
> >
> > we had similar issue in [1] and we replaced the lock with extra buffers,
> > not sure that's possible in bpf_ringbuf_reserve
> >
> 
> Having trace_contention_begin and trace_contention_end in such
> low-level parts of ringbuf (and I'm sure anything in BPF that's using
> spinlock) is unfortunate. I'm not sure what's the best solution, but
> it would be great if we had ability to disable these tracepoints when
> taking lock in low-level BPF infrastructure. Given BPF programs can
> attach to these tracepoints, it's best to avoid this arbitrary nesting
> of BPF ringbuf calls. Also note, no per-program protection will help,
> because it can be independent BPF programs using the same map.

one of the initial attempts for the previous problem was to deny
the attach of programs calling printk to printk tracepoint:
  https://lore.kernel.org/bpf/20221121213123.1373229-1-jolsa@kernel.org/

how about we overload the bpf contention tracepoints callbacks and
make it conditional like outlined below.. but not sure it'd be
feasible on the lock/unlock calling sides to use this

jirka


---
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0a5c4efc73c3..c17b7eaab440 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2347,13 +2347,42 @@ int perf_event_query_prog_array(struct perf_event *event, void __user *info)
 extern struct bpf_raw_event_map __start__bpf_raw_tp[];
 extern struct bpf_raw_event_map __stop__bpf_raw_tp[];
 
+extern struct tracepoint __tracepoint_contention_begin;
+
+#define __CAST_TO_U64(x) ({ \
+	typeof(x) __src = (x); \
+	UINTTYPE(sizeof(x)) __dst; \
+	memcpy(&__dst, &__src, sizeof(__dst)); \
+	(u64)__dst; })
+
+int contention_tps_disable;
+
+static notrace void
+__bpf_trace_contention_begin_overload(void *__data, void *lock, unsigned int flags)
+{
+	struct bpf_prog *prog = __data;
+
+	if (contention_tps_disable)
+		return;
+
+	bpf_trace_run2(prog, __CAST_TO_U64(lock), __CAST_TO_U64(flags));
+}
+
+static struct bpf_raw_event_map* fixup(struct bpf_raw_event_map *btp)
+{
+	if (btp->tp == &__tracepoint_contention_begin)
+		btp->bpf_func = __bpf_trace_contention_begin_overload;
+
+	return btp;
+}
+
 struct bpf_raw_event_map *bpf_get_raw_tracepoint(const char *name)
 {
 	struct bpf_raw_event_map *btp = __start__bpf_raw_tp;
 
 	for (; btp < __stop__bpf_raw_tp; btp++) {
 		if (!strcmp(btp->tp->name, name))
-			return btp;
+			return fixup(btp);
 	}
 
 	return bpf_get_raw_tracepoint_module(name);

