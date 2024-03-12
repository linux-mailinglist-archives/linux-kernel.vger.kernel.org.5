Return-Path: <linux-kernel+bounces-100402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B668796F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8379B1F2631A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3717C0BB;
	Tue, 12 Mar 2024 14:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UNS+aEge"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970353819
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255305; cv=none; b=WdwwuXoDepOwRfOuz0vpHJasO0yFXuXQkP9cR5wcgQvsRMz7qNaxT4fw9I/Q0eS0WD+9dKEH84SBKrqVhHdZejPiVjQB4u+kMPB5QGKz3gjLrn9mvlqK7pTk0ANHgLeZ5n2ZMeqJPgRG5YidGU6dKgrNM/q4ZZ8ztp14nY9c+yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255305; c=relaxed/simple;
	bh=DDfUIdnijAuJWftOaI8gQjBFRStMC4lg425/BJpM4sY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XaHzfUSGHcRl2P01cym+wgdKCqm+fQBHZPAZwy7S1fyruM4Qgztm4h4raSccqYgANL1cCFGN968iIJ5QC3D/nlZkVKQJrhVmMCpO+HZb+ztejTEQLW9gF7kE2WVAwyxr66KMb+K8KcYNFNmbIQoRxEb2YJjkBFTERzNzVzQs+k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UNS+aEge; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56840d872aeso4178188a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1710255299; x=1710860099; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5SYF1vLE9jS9lHa/Lxeh3cLzahFtVKKJvxnK0nnbLy0=;
        b=UNS+aEgeF5jP2h4cTbkswNHHLIhUoPmBv0yOmMYDY0Gq8z5/DuP5gdPKsosMqekdnu
         uAnYKSu6GAtzw0PjsFgxK0HgRVfAWlRJuF0sq3miNAR0RIhECJ0NNcLnjpdAJuRulPv4
         O8hZWFQqPCpEWj3HUH1eG4q9vA7LAu5gDXaibvEGpEWaCRJCrtVN0eR6K0Y22x2o7X1C
         Iq8IVRZg1L18RaKiXDh0UZgaiNqCgb+IDNm8r5dOSvJji3xK+2FcYRdnxadOss/brsgB
         6twnvmvZNcyJl7Spd4R368J8T3TfaDGbv+EgiOGlDxHbOUJXsSdMd+9yxm/WuO/oIUM7
         avyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710255299; x=1710860099;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5SYF1vLE9jS9lHa/Lxeh3cLzahFtVKKJvxnK0nnbLy0=;
        b=wzP0Z4pjhC0A/wsHIW2z/jYOp9YverVa6sBIQMn6UV1dvq/si205uL1xUVqK+Ljean
         K3z3yPqpMRSDc57EWaL5hixw8R7R/NDVMAQGGqRx5Ir7vgfaBbvcztUanAHYoqRj9OVS
         2PdJCNv7xbcdghcSWssqW2+9H3FXIKIeYnkPoXeAxE+5j1Md3MzShJh8DtbYFjBcB7SC
         5iVxha37SaOpKJGLqXfbJxR+vlfneZEVHUZA4sMGkYZUpUt6RUQ/FX3cgyCm0jasXndf
         e38wdepwCjEkiB3wgsgIPM5LqmpEjEjsrDlAAfL33rfVpm2e/B/uK9969ekSfT2yTAro
         l5rA==
X-Forwarded-Encrypted: i=1; AJvYcCWIlwFUXYdk3tmegncbWJ34AKud7nrG07SxQtIJBPrFzjc+zJrDAD1yrH5mA15XjmULBVFpzNWAuURqMYxtb/HFXY3Fheq+41ciZG7o
X-Gm-Message-State: AOJu0YzCvCUAH67E0MQmxunzOzFyvsM9r9HQRQmVgi4i9jN6FkWZQH/c
	hBnt2rdY/kriNiFUxdTLug1fpmc1vUJN0LIDLBk5NJXT++wXaupAnP9nKmKrGhI=
X-Google-Smtp-Source: AGHT+IHTCEd1KcEWXIxRvBMp2fHsUsFbWuiExy7uhV9mFw2+mgvnVuNnxQFW4a+S8SxpNhUQ3nrX4g==
X-Received: by 2002:a50:f681:0:b0:568:1444:af5f with SMTP id d1-20020a50f681000000b005681444af5fmr7321923edn.4.1710255298962;
        Tue, 12 Mar 2024 07:54:58 -0700 (PDT)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id ca8-20020aa7cd68000000b005671d898b32sm4138164edb.23.2024.03.12.07.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 07:54:58 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:54:57 +0100
From: Petr Mladek <pmladek@suse.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] printk for 6.9
Message-ID: <ZfBswbsqObB4H73_@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

please pull the latest printk changes from

  git://git.kernel.org/pub/scm/linux/kernel/git/printk/linux.git tags/printk-for-6.9

========================================

Printk changes for 6.9 improve the behavior during panic. The issues were
found when testing the ongoing changes introducing atomic consoles and
printk kthreads.

- pr_flush() has to wait for the last reserved record instead
  of the last finalized one. Note that records are finalized
  in random order when generated by more CPUs in parallel.

- Ignore non-finalized records during panic(). Messages printed
  on panic-CPU are always finalized. Messages printed by other
  CPUs might never be finalized when the CPUs get stopped.

- Block new printk() calls on non-panic CPUs completely. Backtraces
  are printed before entering the panic mode. Later messages
  would just mess information printed by the panic CPU.

- Do not take console_lock in console_flush_on_panic() at all.
  The original code did try_lock()/console_unlock(). The unlock part
  might cause a deadlock when panic() happened in a scheduler code.

- Fix conversion of 64-bit sequence number for 32-bit atomic
  operations.

----------------------------------------------------------------
John Ogness (12):
      printk: nbcon: Relocate 32bit seq macros
      printk: Use prb_first_seq() as base for 32bit seq macros
      printk: ringbuffer: Do not skip non-finalized records with prb_next_seq()
      printk: ringbuffer: Clarify special lpos values
      printk: For @suppress_panic_printk check for other CPU in panic
      printk: Add this_cpu_in_panic()
      printk: ringbuffer: Cleanup reader terminology
      printk: Wait for all reserved records with pr_flush()
      printk: ringbuffer: Skip non-finalized records in panic
      printk: Avoid non-panic CPUs writing to ringbuffer
      panic: Flush kernel log buffer at the end
      dump_stack: Do not get cpu_sync for panic CPU

Petr Mladek (1):
      printk: Disable passing console lock owner completely during panic()

Sebastian Andrzej Siewior (1):
      printk: Adjust mapping for 32bit seq macros

 include/linux/printk.h            |   2 +
 kernel/panic.c                    |   8 +
 kernel/printk/nbcon.c             |  41 +----
 kernel/printk/printk.c            | 101 +++++++-----
 kernel/printk/printk_ringbuffer.c | 337 ++++++++++++++++++++++++++++++++------
 kernel/printk/printk_ringbuffer.h |  54 +++++-
 lib/dump_stack.c                  |  16 +-
 7 files changed, 420 insertions(+), 139 deletions(-)

