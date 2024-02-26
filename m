Return-Path: <linux-kernel+bounces-82105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7B7867F57
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 898F5B269C5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E1C12E1C3;
	Mon, 26 Feb 2024 17:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNSE/XA4"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C5412CD89
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 17:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708969913; cv=none; b=MvfQC4Gp0TeiZ8JMpNGXDDKa2g52+/sm6IYGv7KO1uXRm9Bf6GUukEWglT98zQ4dMRdXe47UjNVZgEesqF8wUi9O+p44JJ2LhnDhG7wFDMr5tbq7fP1RqpX4YVcZvVVTD9Ia+VCWEGbvJVKS/BoXNqTIb8OsVtMCLifQLipBYe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708969913; c=relaxed/simple;
	bh=/EIExzwYIikvad/ZPr21MBVInz4GcJDT0iSZdYjOWO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIXH+ER0rhDM3++8APrGj2z1G78vSHwu7WgmdATgFdKjBEulQBJoIzpZnpNBBlPmODJOEM99KZzIV6b6yo7mOeER4DPy5ya4StiwjWD0F6dnRWHZAPoLNewZ3liY7X1kNCEJy4SlDf3Z9uler5R13hKj2eGqKt7jp6SVduvdMaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNSE/XA4; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d8b276979aso2611463a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708969911; x=1709574711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wETeoW2ejlL9Du6ELWHI1KiQfZikmnxR74a33KeoH64=;
        b=KNSE/XA47kLnVEvXPFgeq+874XxTcLLaTtswdxmCAek5JS25duQcYNwGE5KuxcJvR4
         zP4r2kDsbYX0eddC2DFsUtkaJ9NPt6KgqlD1MAFxKz/hvkqazFNrDvT5NXhi14Lu8fHd
         MiAbYCDzYToBhJOQ1kqWTXxeRMG4MUCxu0pslzKI9GF/kyWf5CwS3EITYQkc9+6zzWMT
         XnTeepkwUWZohZk67wVEyufP8ZlGsVsFgq08jhra2Jk1+EuYmwhVvz4Z6X23kc989GMd
         jy4ryBfUIAucGSt02kjTWgGm6Dx3EV/5xwJiuTSlL/lk80ZoUC15zpQ/2q2x9Ga1hWLA
         Rjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708969911; x=1709574711;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wETeoW2ejlL9Du6ELWHI1KiQfZikmnxR74a33KeoH64=;
        b=k0rFrpIlwM8ScKqaHjW5rhUQVKedLJyR2V7HEh0iGr/eLbDhmhnnyFDK03apTtqmqK
         Vg0jnQ1jZu6HgY4Oyu2Ru7cepsYOGcKpVLkZZljYBPvO63/0sjAy+HKiL/kiqW8XMDJ3
         101LBqATIDG5Mhg4CXjaMh8x17tTFOcJ5qpLfydNfGPHA6yWhKX6myT0ve3eAFteWytu
         q1Ebq7gT/eOgCIJEeVh9qbU+bFKTJdNJku0yiy5XbKpePsej6rqjyKHTCZ97a5Vdwv54
         cMskhdpMdafZX6LKedJmGPuHvWagDzq98tRMlSMlRO0Rcp2kWx9NGhn6gsY+sBQLzV6f
         KX6w==
X-Gm-Message-State: AOJu0YyFNOzRemvU2COQIbIEh6K3xVyxeGJXvcPJNeKlgzeRU99/2RGV
	9MEOxet4xT4SCJrLALhLZBKSMUYmqyhw4N+gGhJVaNx2ohuY6b0YCzwVezz1
X-Google-Smtp-Source: AGHT+IGT+P7p30xrX8/rODLkEEWlMCxC0crrI5z5pzukTmusoRYq7Ms1D6LPuDfNNiUn+LxqCTeHEA==
X-Received: by 2002:a17:90a:8c0b:b0:29a:be15:9c90 with SMTP id a11-20020a17090a8c0b00b0029abe159c90mr3110538pjo.34.1708969910759;
        Mon, 26 Feb 2024 09:51:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id sx7-20020a17090b2cc700b00299404af11csm6712490pjb.36.2024.02.26.09.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 09:51:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 26 Feb 2024 09:51:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.8-rc6
Message-ID: <6bb3f88b-bf57-442a-8b46-cb4784dd4cab@roeck-us.net>
References: <CAHk-=whZ=iA6DhijePcW-pJjZ8YD4T5qLpLKVSUT+4gWNm_0sA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whZ=iA6DhijePcW-pJjZ8YD4T5qLpLKVSUT+4gWNm_0sA@mail.gmail.com>

On Sun, Feb 25, 2024 at 03:57:21PM -0800, Linus Torvalds wrote:
> Another week, another rc. Nothing here really stands out.
> 
> Last week I said that I was hoping things would calm down a bit.
> Technically things did calm down a bit, and rc6 is smaller than rc5
> was. But not by a huge amount, and honestly, while there's nothing
> really alarming here, there's more here than I would really like at
> this point in the release.
> 
> So this may end up being one of those releases that get an rc8. We'll
> see. The fact that we have a bit more commits than I would really wish
> for might not be a huge issue when a noticeable portion of said
> commits end up being about self-tests etc.
> 

Good to get those unit test failures to pass, though.

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 549 pass: 548 fail: 1
Unit test results:
	pass: 170476 fail: 620

Details below.

Guenter

============

Runtime crashes
===============

an385:mps2_defconfig:mps2-an385:initrd
--------------------------------------

an385 does not support unaligned accesses, but test_ip_fast_csum
expects it.

Fix:
https://lore.kernel.org/lkml/20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com/

See additional information below about checksum unit test failures.

Warning backtraces
==================

WARNING: inconsistent lock state
6.8.0-rc4 #1 Tainted: G                 N
--------------------------------
inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
kworker/0:2/39 [HC1[1]:SC0[2]:HE0:SE0] takes:
ef792074 (&syncp->seq#2){?...}-{0:0}, at: sun8i_dwmac_dma_interrupt+0x9c/0x28c
{HARDIRQ-ON-W} state was registered at: 
  lock_acquire+0x11c/0x368
  __u64_stats_update_begin+0x104/0x1ac
  stmmac_xmit+0x4d0/0xc58
  dev_hard_start_xmit+0xc4/0x2a0
  sch_direct_xmit+0xf8/0x30c
  __dev_queue_xmit+0x400/0xcc4
  ip6_finish_output2+0x254/0xafc
  mld_sendpack+0x260/0x5b0
  mld_ifc_work+0x274/0x588
  process_one_work+0x230/0x604
  worker_thread+0x1dc/0x494
  kthread+0x100/0x120
  ret_from_fork+0x14/0x28

Caused by commit 38cc3c6dcc09 ("net: stmmac: protect updates of 64-bit
statistics counters.")

Report:
https://lore.kernel.org/lkml/ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net/

No activity or even agreement if this is a false positive or a real problem.
I added it to the regression tracker (or at least tried to) since the problem
has now proliferated into stable branches, and the patch causing the backtrace
may even be marked as CVE according to:
https://git.kernel.org/pub/scm/linux/security/vulns.git/tree/cve/review/proposed/v6.7.6-greg

Interesting question is if the fix for this presumed CVE is causing another
security issue.


Unit test failures
==================

checksum
--------

Various checksum tests fail on several machines, with different reasons.
Too many to list in detail.

Reports:

https://lore.kernel.org/lkml/ec44bf32-8b66-40c4-bc62-4deed3702f99@roeck-us.net/
https://lore.kernel.org/lkml/9b004c45-45f8-4abb-a24e-bb47b369b1a5@roeck-us.net/
https://lore.kernel.org/lkml/65ed7c95-712c-410b-84f3-58496b0c9649@roeck-us.net/

Suggested fixes:

https://lore.kernel.org/lkml/20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com/
https://lore.kernel.org/lkml/20240210175526.3710522-1-linux@roeck-us.net/
https://lore.kernel.org/lkml/20240211160837.2436375-1-linux@roeck-us.net/
https://lore.kernel.org/lkml/20240210191556.3761064-1-linux@roeck-us.net/

Most fixes are queued in -next. There is still an open question if the
tested functions are supposed to work on unaligned addresses.

stackinit
---------

Seen with m68k:q800 emulation.

    # test_char_array_zero: ASSERTION FAILED at lib/stackinit_kunit.c:333
    Expected stackinit_range_contains(fill_start, fill_size, target_start, target_size) to be true, but is false
stack fill missed target!? (fill 16 wide, target offset by -12)

    # test_char_array_none: ASSERTION FAILED at lib/stackinit_kunit.c:343
    Expected stackinit_range_contains(fill_start, fill_size, target_start, target_size) to be true, but is false
stack fill missed target!? (fill 16 wide, target offset by -12)

Report:
https://lore.kernel.org/lkml/a0d10d50-2720-4ecd-a2c6-c2c5e5aeee65@roeck-us.net/

I suspect this may be caused by the test assuming that stack growth is
downward, but I don't really understand the test well enough to be sure.
I'll disable this set of tests for m68k going forward, so I am not going
to report the problem again in the future.

mean and variance tests
-----------------------

This is bcachefs related.

test cases 2 and 4 fail on all architectures/branches, and I don't see how
those tests can pass. The functionality was promoted into lib/math/
in -next, and the test now always fails there even if bcachefs is not
enabled.

Not added to regression tracker since I am not sure if unit test problems
caused by bad test cases should count as regressions.

Report:
https://lore.kernel.org/lkml/065b94eb-6a24-4248-b7d7-d3212efb4787@roeck-us.net/

Suggested fix:
https://lore.kernel.org/lkml/20240225162925.1708462-1-linux@roeck-us.net/

