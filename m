Return-Path: <linux-kernel+bounces-61101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880AE850D46
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F150E1F25E82
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 04:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD3D6FBF;
	Mon, 12 Feb 2024 04:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZBUpXjY"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8198E6FA7
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707713554; cv=none; b=srbTT8C2AiniK4ED07b36mUlqgzSMER/YC/LaH9Q1wBnEm6kc7LVnud4bq989aWmW+hQVjODpeSZsl5UwhBIFOz5z0IjsJ1V4jWjnVkffSUn8FZfHgVjCDaVBsaRwqbx8sHcFxaECVcYeJrXKvAujbuWFaTHDiQDNtz49Rm3a0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707713554; c=relaxed/simple;
	bh=3azz1M9ulZmRqHPlpbmfo8wZIFZL+JYpkzBM25GgJfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NViGj5qOiOsmbjvGGvpcZYUfnd+hoS+zeSAtXgWA7r0/GYvv5V3oKUzOhNSB70nIefqJSFh47GRyyyLNE2fBP8KLR1BiJj8Qv3sb2Twgyr3GSgI5SNKlQTykp3zailY1T7lLM2QmBcvtm1r51h/EAn9Ub+G95fNVZ00rXT8OLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZBUpXjY; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so2340487a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 20:52:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707713552; x=1708318352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1evrDlaQclp/DrCuFqkMquvRkDV/fOqtOpgkKsW9H7w=;
        b=fZBUpXjY5yymmfbVRk30aoEOl2CCybKw7GD5VRrFpk1HV5le3nxAk4t7623qI5/WfS
         qvu7v7COKR3sGnPnxREPeuAJCTqVdAwRPdJhKobvDUvBDt3qSY30wJyx5pRBKjCp1IDP
         l6ICfYTkyc2RS2Tv5CwL8RCaCqBPq3AqR/DZt3v98SgdPmD70XmGygXVNnv0cf+BOkBq
         3G/P1j50oZOI22RFRC1ZHe5RVqupjmJQ6EshSHMoWxK7V1FU6zloNu/M+vpJll1nFRo7
         0GurSr96MB3+r1RHAfNVp4RctEqVRhul6SeE3deVVm8tT0RJELmq0b+4TIkrBzeYqox7
         cHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707713552; x=1708318352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1evrDlaQclp/DrCuFqkMquvRkDV/fOqtOpgkKsW9H7w=;
        b=l8J4rpwaqTy1SXcGaPo1St5fIufhThPLeuyW1yLJeAdQlaCuA6X8aBheZFRNwBK0Zb
         uWH1IxdG4qw695FI1zO8TMk+Zk+1//tpSoel7aCGruUVQ8pVriSw8iW8JG/e1UcMemTn
         hnRMuzqv3fujHWlULSzbbTFFOzd8MA4Eqd8w2544DQ3kCaEGnDcikF2Cw4g61K0f+QvR
         3kyG0ts1DfYvmY5ZIg0TihoJvPP0zjFT+yfw96ih/BsRJuK4EgV2y11/Ze2LRx+VY5cB
         ZbfBTUYQC0h7qWgHsI79xEqG5K06kFem/PVfNW1Jqf+/SoA4HJ1UbSrljU8Fb7yi+Igv
         +rsg==
X-Gm-Message-State: AOJu0YzZ+pCuAKoLeCNawOdxnrGg56oukpRs3QPqX0lfU3e1cVx6ozlN
	dWHQHC88whLP72CrUoT/XRz1teUJKM30I03xWjXq/Ie3+1gPtgBVaCM7ks+w
X-Google-Smtp-Source: AGHT+IGn8YX6hGMbrI1Glof9d02H5dSYOlPGsKCRvcdhQnD5Blo+9ouZlZSDPCo/2G8uNQF5MHoDcQ==
X-Received: by 2002:a05:6a20:c68e:b0:19e:bff0:c8fc with SMTP id gq14-20020a056a20c68e00b0019ebff0c8fcmr8516710pzb.56.1707713551632;
        Sun, 11 Feb 2024 20:52:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ev9-20020a17090aeac900b0029685873233sm5908916pjb.45.2024.02.11.20.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 20:52:30 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 11 Feb 2024 20:52:29 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.8-rc4
Message-ID: <d56f35c3-ce83-4356-bf78-66ed5f99d19f@roeck-us.net>
References: <CAHk-=wg1c4Q1Ve6BG71DikHu-AEoKUUQoj1QbVdjwGQyTExqCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg1c4Q1Ve6BG71DikHu-AEoKUUQoj1QbVdjwGQyTExqCw@mail.gmail.com>

On Sun, Feb 11, 2024 at 12:36:02PM -0800, Linus Torvalds wrote:
> Commit counts and contents look normal for this phase of the release,
> nothing here really stands out.
> 
> Sure, we've got a ntfs3 fix dump, which shows up a bit in the stats,
> but the bulk is all the usual suspects: drivers (particularly gpu and
> networking) and core networking.
> 
> The rest is the usual random collection of fixes all over: other
> drivers, some architecture fixes (mainly x86 and RISC-V), and some
> core vm and tracing noise. And selftests.
> 
> Please continue testing,
> 

Build results:
	total: 155 pass: 155 fail: 0
Qemu test results:
	total: 549 pass: 547 fail: 2
Unit test results:
	pass: 161894 fail: 968

Unit test failures look like a lot, but it is mostly the same set
of tests failing in several or even all test runs. Some of the tests
fail due to a problem with the test, but there are also several bugs
in the tested code. Note that some of the unit test failures are old;
I only recently updated my scripts to check unit test results.

Almost all problems are fixed in the 'testing' branch at
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git

Guenter

======

Runtime crashes
===============

an385:mps2_defconfig:mps2-an385:initrd
--------------------------------------

an385 does not support unaligned accesses, but test_ip_fast_csum
expects it.

Fix:
https://lore.kernel.org/lkml/20240207-fix_sparse_errors_checksum_tests-v6-0-4caa9629705b@rivosinc.com/

See additional information below about checksum unit test failures.

xtensa:de212:kc705-nommu:nommu_kc705_defconfig
----------------------------------------------

Crash in kunit_iov_iter unit test if CONFIG_TEST_IOV_ITER is enabled.

    BUG: failure at mm/nommu.c:318/vmap()!
    Kernel panic - not syncing: BUG!

The test code calls vmap() directly, but vmap() is not supported on nommu systems.

Suggested fix:
https://lore.kernel.org/lkml/20240208153010.1439753-1-linux@roeck-us.net/

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

Handshake API
-------------

  # req_destroy works: EXPECTATION FAILED at net/handshake/handshake-test.c:477
  Expected handshake_req_destroy_test == req, but
      handshake_req_destroy_test == 00000000
      req == c4aef640
  not ok 11 req_destroy works

Observed in v6.1.y and later. The maintainer wasn't happy with my suggested
fix (see discussion and patch in my 'testing' branch). I am not aware of a
pending patch.

Discussion:
https://lore.kernel.org/all/20240202164705.6813edf2@kernel.org/T/

regmap
------

Reports:
https://lore.kernel.org/lkml/fc1d865d-3e2e-48bc-8cd1-389ec6b15909@roeck-us.net/
https://lore.kernel.org/lkml/dc5e573d-0979-4d7e-ab4a-de18a4711385@roeck-us.net/T/#u

Pending fixes:
https://lore.kernel.org/lkml/20240206151004.1636761-2-ben.wolsieffer@hefring.com/
https://lore.kernel.org/lkml/20240211-regmap-kunit-random-change-v3-1-e387a9ea4468@kernel.org/

cpumask
-------

Report:
https://lore.kernel.org/lkml/e6f0ab85-5bbe-41c1-8976-5ba00044998c@roeck-us.net/raw

Also see
https://lore.kernel.org/lkml/Zb0mbHlIud_bqftx@slm.duckdns.org/t/

Caused by commit 0921244f6f4f ("parisc: Only list existing CPUs in cpu_possible_mask")
which will need to be reverted. Observed in v6.1.y and later.

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


