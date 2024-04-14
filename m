Return-Path: <linux-kernel+bounces-144055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 626138A4153
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BADD1B20E39
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0AB225D4;
	Sun, 14 Apr 2024 08:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkfhZn0q"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F99224EF
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713084128; cv=none; b=XV29KI+DDG1YQka3wKApedikp5A/JTcYBiVSz4GgYvqeFzTUi+9zvgY2EeWOmXwAqBzL6uMozI5gDiM+eCx9QUKjPju7n/FY7Pg2JLBMHCtb3foqt6YAgsFv0+EIwnA02k+E5oVu69Gt64aU3gVELMSOS2Mne8fWbc9XU2C785k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713084128; c=relaxed/simple;
	bh=sO3U3qtie8Bad7drbNBDRmBcpBVjy/7lI3/AWvFGjRg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=P+KNORz4+g9dC8ogkzDRWhFIRT7iswtUBWn3Zf3HKS/rmIzOuk9d+Zks+NQEpJ2TsbAdoXA1VJVUhWY6UISvuDP26eghXPs/ALzIPZNJX5yCn4DhpDlQhjrQ4cQhALxvXNO2ikgN4D5QSdxcB9en+gc/KFa2T08f6wzmoUzWrCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BkfhZn0q; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d0c004b1so2929039e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 01:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713084125; x=1713688925; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OeA8chOiwmpEnDJzWTX7NWyQLr6P5oI7vxMfhT/G1VY=;
        b=BkfhZn0qvrr2ibufgHLyU616s7Fz7KnNEAH1WT9KVYpWiCLPXvpTWjbCu6541TqAYt
         uDy3MfU2+rgIiy4AQ7t/MdvTpmEbrJ/75TqlPDc+lQZ3qKErBnFq77lfjFYyDqYhy88P
         mv4xkAz+I42shJOUTDrz95Bbs52sIDDWN7QVvxcFyeOoc1y5cl6aNKJHidjWkexil7lC
         tadGbEZgsMqiSEBlvXRHJV7nzJBP+KAmi9H8qWJ7oyxwErRIqmgLCa0wtZ81xy3M4dJG
         wMlryvv88vHsFBIYyzLhAjyCA0gtnrXRCXabli+zXJm7Q+ON06jaE6c+svRlbVzhMhyO
         mYQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713084125; x=1713688925;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OeA8chOiwmpEnDJzWTX7NWyQLr6P5oI7vxMfhT/G1VY=;
        b=hDl2JesqJDnVtmiENltfnCYBESLXJaP9chzGiGNyEDrYl7zC+t/jhO99+NPH2iLCqs
         WlcVVuaINNfwflAewfr/4VHOT9ORoXXGIZROuLhjTnekVfhuyjcJoaA5ejtslo5ID8ax
         l3/OZSCuJvPZm4sKc3RfsNWgzU9IFavml3jFplHNmr88rJG9Sbm3g1d+hFj+lwF+WbJk
         l6/3DwT/mfNz4KOGbWq17gxEW48V/q/Kxk5PgelcaFRPBdOGGJWYDGVLn6eTFiLIzv6V
         zvUg0EaRJDHfbLwAdbcqkVo8VaNXs6qFgWW81pt3DtApCdfW3jZ19YYr5I2/yqhwWV6I
         MGww==
X-Gm-Message-State: AOJu0YyhmutkYYOKTA3j7aJ6P9nKl52fnTKBlzqN1RsQ8Twa6IZapfNb
	i9Mq1isI8N+Er/2YqxJsCzG2Un4aLmmwGLFraQzKmpWuz3rB85cHY7E6e+rP
X-Google-Smtp-Source: AGHT+IFDibH0jjS4wpBvlhOPnHvkMI0RJG5bM/wcuDqcjpTyG74O8NIVz0+AvvkNd/kNQ0jkVUTriA==
X-Received: by 2002:a05:6512:3caa:b0:518:ccc3:3e3 with SMTP id h42-20020a0565123caa00b00518ccc303e3mr1339892lfv.69.1713084124750;
        Sun, 14 Apr 2024 01:42:04 -0700 (PDT)
Received: from gmail.com (2A00111001332BCD9129005EE765889E.mobile.pool.telekom.hu. [2a00:1110:133:2bcd:9129:5e:e765:889e])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b004171f151a5csm11338926wmo.16.2024.04.14.01.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 01:42:04 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Sun, 14 Apr 2024 10:42:01 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [GIT PULL] timer fixes
Message-ID: <ZhuW2WdSHa8kdd1q@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest timers/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-2024-04-14

   # HEAD: 16767502aa990cca2cb7d1372b31d328c4c85b40 selftests: kselftest: Fix build failure with NOLIBC

Misc timer fixes:

 - Address a (valid) W=1 build warning

 - Fix timer self-tests

 - Annotate a KCSAN warning wrt. accesses to the
   tick_do_timer_cpu global variable.

 - Address a !CONFIG_BUG build warning

Heads up for the !CONFIG_BUG warning patch, which we
addressed with:

   5284984a4fba bug: Fix no-return-statement warning with !CONFIG_BUG

Not everyone agreed though, see:

  https://lore.kernel.org/all/20240410153212.127477-1-adrian.hunter@intel.com

Thanks,

	Ingo

------------------>
Adrian Hunter (1):
      bug: Fix no-return-statement warning with !CONFIG_BUG

Arnd Bergmann (1):
      irqflags: Explicitly ignore lockdep_hrtimer_exit() argument

John Stultz (3):
      selftests: timers: Fix valid-adjtimex signed left-shift undefined behavior
      selftests: timers: Fix posix_timers ksft_print_msg() warning
      selftests: timers: Fix abs() warning in posix_timers test

Nathan Chancellor (1):
      selftests: kselftest: Mark functions that unconditionally call exit() as __noreturn

Oleg Nesterov (2):
      selftests/timers/posix_timers: Reimplement check_timer_distribution()
      selftests: kselftest: Fix build failure with NOLIBC

Thomas Gleixner (1):
      timekeeping: Use READ/WRITE_ONCE() for tick_do_timer_cpu


 include/asm-generic/bug.h                       |   5 +-
 include/linux/irqflags.h                        |   2 +-
 kernel/time/tick-common.c                       |  17 ++--
 kernel/time/tick-sched.c                        |  36 ++++----
 tools/testing/selftests/kselftest.h             |  33 ++++++--
 tools/testing/selftests/timers/posix_timers.c   | 105 +++++++++++-------------
 tools/testing/selftests/timers/valid-adjtimex.c |  73 ++++++++--------
 7 files changed, 147 insertions(+), 124 deletions(-)

