Return-Path: <linux-kernel+bounces-19345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2615826BB9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242AF1C2211D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BBA13FFB;
	Mon,  8 Jan 2024 10:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpPttL6U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A71713FE4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 10:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d6b4e2945so21568515e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 02:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704710643; x=1705315443; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BDh4LriLbpQxN+9AdmgvnY/GYm05U679SOANbjEPnSs=;
        b=WpPttL6Uc6AZurqCM3IOvApvV0HS6g329wzujueJ3TEdYR9VWXsRNqk1BvqieVwMhB
         HO6WyxM7gxbzhBnLw7iOiqfPBSjuEnwLvIUxQyQ0Dcrg3M8d1uQEsYqDGqjI2oS1b2aZ
         /4gMZdvBs7YHkWZ5k1wIPhrTs4wY62gXFaNvf0mSMKUYaqP2GkeTB2VMzG2hE++ua4+N
         F9XdIlto/72DinTP5ujMok59xC2tNyoUHbxsBkdFW9hlBA2qQ2nzxn5cjGA71JU4gDsF
         2JkyMpPtqCpCDKHufbywbMEG9GkxmTMpErtvi6uZCTPevcmMCjQCKdQ4vkRUHHma1YE9
         MG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704710643; x=1705315443;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDh4LriLbpQxN+9AdmgvnY/GYm05U679SOANbjEPnSs=;
        b=KHevw+ODxWpI+44XIIVOyK1plNWRZCM/cF7rdrjhuF71Lp9PREYGE8ylUMXHNl35kd
         4VjvIGPW+EZwZnRh+XgGB2/hRATu/mUfMEeugx8pSgFGo08XAJffJEWbUpWKEdMTb2Ab
         A4YD0rJRO3bvs1ODhbl/0FBeLQesNFbpkxIN3DEfNi4BA7RFArBjDiqfaYLtP4FMKMOG
         xju0QCSXRkng3HpKzIcKlLwkGNC8YbBB0CCgP06IAZVSt55n9AnCaMq01H5Dkvn9ZNSJ
         g8mQuiQz86CFhwqzRQiuSfUHbZ/6dwZWBNKhZb2ydTCcPEajQuD732xavHbF+diWTGwy
         CifA==
X-Gm-Message-State: AOJu0Yzgg94r+yvUxpbx8FoB3XuqYbuffIY2aMTUd6xfwyCWKsAa3N4I
	wzJG0oxpB6mtvpaAeeDYH8g=
X-Google-Smtp-Source: AGHT+IEtROOHGstl9ds3ARReWzfjFm2Y7G2laMND10imA2qLFomOQKwD7R2AM0m6qzJpVmTKEl5BwA==
X-Received: by 2002:a05:600c:a082:b0:40e:448d:2897 with SMTP id jh2-20020a05600ca08200b0040e448d2897mr681349wmb.13.1704710642692;
        Mon, 08 Jan 2024 02:44:02 -0800 (PST)
Received: from gmail.com (1F2EF3FE.nat.pool.telekom.hu. [31.46.243.254])
        by smtp.gmail.com with ESMTPSA id h11-20020a5d504b000000b0033739c1da1dsm7442350wrt.67.2024.01.08.02.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 02:44:02 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Jan 2024 11:44:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [GIT PULL] Timer subsystem changes for v6.8
Message-ID: <ZZvR8LSj0ea7XZ9+@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest timers/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2024-01-08

   # HEAD: da65f29dada7f7cbbf0d6375b88a0316f5f7d6f5 timers: Fix nextevt calculation when no timers are pending

Timer subsystem changes for v6.8:

 - Various preparatory cleanups & enhancements of the timer-wheel code,
   in preparation for the WIP 'pull timers at expiry' timer migration model
   series (which will replace the current 'push timers at enqueue' migration
   model), by Anna-Maria Behnsen:

      - Update comments and clean up confusing variable names

      - Add debug check to warn about time travel

      - Improve/expand timer-wheel tracepoints

      - Optimize away unnecessary IPIs for deferrable timers

      - Restructure & clean up next_expiry_recalc()

      - Clean up forward_timer_base()

      - Introduce __forward_timer_base() and use it to simplify
        and micro-optimize get_next_timer_interrupt()

 - Restructure the get_next_timer_interrupt()'s idle logic
   for better readability and to enable a minor optimization.

 - Fix the nextevt calculation when no timers are pending

 - Fix the sysfs_get_uname() prototype declaration

 Thanks,

	Ingo

------------------>
Anna-Maria Behnsen (11):
      tick-sched: Fix function names in comments
      tick/sched: Cleanup confusing variables
      tick-sched: Warn when next tick seems to be in the past
      tracing/timers: Enhance timer_start tracepoint
      tracing/timers: Add tracepoint for tracking timer base is_idle flag
      timers: Do not IPI for deferrable timers
      timers: Move store of next event into __next_timer_interrupt()
      timers: Clarify check in forward_timer_base()
      timers: Split out forward timer base functionality
      timers: Use already existing function for forwarding timer base
      timers: Fix nextevt calculation when no timers are pending

Arnd Bergmann (1):
      time: Make sysfs_get_uname() function visible in header

Thomas Gleixner (1):
      timers: Rework idle logic


 include/trace/events/timer.h |  40 +++++++++++----
 kernel/time/tick-internal.h  |   3 +-
 kernel/time/tick-sched.c     |  25 ++++++----
 kernel/time/timer.c          | 116 ++++++++++++++++++++++++-------------------
 4 files changed, 112 insertions(+), 72 deletions(-)

