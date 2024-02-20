Return-Path: <linux-kernel+bounces-73567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A8D85C44B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E922B23129
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7784B12FF62;
	Tue, 20 Feb 2024 19:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhwwU0XA"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57244C94
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456144; cv=none; b=rNEnQL3BpG+Tw2HHpbT0WO5q9FKhb7ihCBN7Q87hJ1NQDDOMViGFMDVY/r73Rio178/tYoZkVRsxb8fLK6cpVrs2qDXb5yXNGnIG/bLLG+OA1NVO/NQW6X4s9JVYSvZaCtj1h9gKbwk+kw+ZamEq4atAJ8IkdHRDRkhgbRCT2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456144; c=relaxed/simple;
	bh=bPL1XMchumIIbU4j9mLwAP41msMdoR87kbsGP6FrVqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uk+vXEQhQFR2XdC5XGXE7FAarcfZzufp3eYZ0Agklyl9qqHLd5wQvcgc4WJQhrVuIDTRxUagy6RsHFPh5cgrdXpFYBChdvpoU4EZWMn4n9aXLkv+tNc+JHRhP3EIB2TPPUlyWYQc4k12iHS7NKH7JJw3+WF1AIUeeXer4OnU0Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhwwU0XA; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d94323d547so42524685ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708456142; x=1709060942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wF2cBvmyMdxW3hOl2LnFtLgJ30tx1EI0yBvTouvIPms=;
        b=NhwwU0XA2NrzpTBOcfXzVXS8kia0GRSWsLGlGlquRSv18eZEsN1BBFkuXVTFnGOYlR
         zh/C9D/8U3nZl+SAsxrU3CXqCOMPAsHjlBp6tOjrxroMPpo0FLGn38dIEFf1FWHcqWOK
         Xr4mGwgHxsISEFcedU+aoKvFulUDGkw3hMZWlLzSGIiTtaD4phm3v/bofiiiijgIKd6M
         Ya0mzq3X9ciuGE4N7tWrl31iSUHJb7Jdj1YJVWCd2a7yR2XBQSnAR98TMmEWbO1h72hu
         6RoUckMLII2AjYC3ZdSI5OaTnnmx2y1CDIhT5XsZFWTQVJLCe6C8KUEBMccwaF0rvvC5
         LyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456142; x=1709060942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wF2cBvmyMdxW3hOl2LnFtLgJ30tx1EI0yBvTouvIPms=;
        b=tLW98tdRfsnRoDYriiucX2doz9903Vs+A5pAVyIKYPr1GpmbnOUzos1eybTALoFGLx
         RUVRQP6ynabDipU6j8Oa1s3aKACi0oLKNRdg0GmbgImaIvfO2modkXyxZLYn+UW9IWPT
         VL4Qyo7b3rJ4YINl2Khirt6EpIXriEWkrBqQuGNTj6CfBke1O/U0MEa3yycJrT7tp7qg
         mZ1c1l/rKve2l5cMSs+UtQZuD3QwYsRcPyCeDzf0JEDtsx9pC9RUXF28c27r2MJ9M+5z
         a5I8YRkRUK6mi0s/CEj4pZq0xCgiQbcSHOkODGWwH9mksm5WwL7pN8nHWhLktzOGS6Nr
         6QJw==
X-Gm-Message-State: AOJu0YwKdO/ebHx+0lN0P88zui62pVbRt9cZ57Wo/xDdWpDG6Gc/1ZfZ
	pJbJTNaBQIiWT6DJLVBeu6FZ0uH2mL5aIETEVX65HBFCJTjBSr/7RygPiSU9
X-Google-Smtp-Source: AGHT+IElGo65q9YyNObkCAsN5uquRgB3AKYzOH0j8rQ9cLF5uuR7KCGE/bmgjzCk3U/OwffSoNsWfA==
X-Received: by 2002:a17:902:a38b:b0:1dc:2ba2:d86e with SMTP id x11-20020a170902a38b00b001dc2ba2d86emr157222pla.13.1708456141994;
        Tue, 20 Feb 2024 11:09:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p11-20020a1709026b8b00b001d78a08e8e7sm6477820plk.250.2024.02.20.11.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 11:09:00 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 20 Feb 2024 11:08:59 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.8-rc5
Message-ID: <538327ff-8d34-41d5-a9ae-1a334744f5ae@roeck-us.net>
References: <CAHk-=wi8vZD7EXZfob-yhfDERyfzWxzMOzG9FsOuaKU-v6+PHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi8vZD7EXZfob-yhfDERyfzWxzMOzG9FsOuaKU-v6+PHA@mail.gmail.com>

On Sun, Feb 18, 2024 at 01:13:34PM -0800, Linus Torvalds wrote:
[ ... ]
> 
> Please commence testing,
> 

Build results:
	total: 155 pass: 151 fail: 4
Failed builds:
	csky:allmodconfig
	openrisc:allmodconfig
	parisc:allmodconfig
	xtensa:allmodconfig
Qemu test results:
	total: 549 pass: 547 fail: 2
Unit test results:
	pass: 161596 fail: 740

============
Build errors

Building csky:allmodconfig ... failed
Building openrisc:allmodconfig ... failed
Building parisc:allmodconfig ... failed
Building xtensa:allmodconfig ... failed

--------------
Error log:
ERROR: modpost: "__umoddi3" [drivers/gpu/drm/tests/drm_buddy_test.ko] undefined!
ERROR: modpost: "__moddi3" [drivers/gpu/drm/tests/drm_buddy_test.ko] undefined!

Commit a64056bb5a32 ("drm/tests/drm_buddy: add alloc_contiguous test"):

+       u64 mm_size, ps = SZ_4K, i, n_pages, total;
..
+       n_pages = mm_size / ps;

This patch breaks the build on all 32-bit systems since it introduces an
unhandled direct 64-bit divide operation.


Runtime crashes
===============

Nothing new, so shortened.

an385:mps2_defconfig:mps2-an385:initrd
xtensa:de212:kc705-nommu:nommu_kc705_defconfig

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

Previously reported:

checksum (various architectures)
cpumask (parisc only)
stackinit (m68k only)

New (that is, newly enabled)

mean and variance tests (all architectures)
-------------------------------------------

This is bcachefs related.

test cases 2 and 4 fail on all architectures/branches, and I don't see how
those tests can pass. See report for details.

Report:
https://lore.kernel.org/lkml/065b94eb-6a24-4248-b7d7-d3212efb4787@roeck-us.net/

drm kunit tests (all architecstures, with qemu)
-----------------------------------------------

Failures all over the place when running in qemu, followed by list corruptions
and a crash. Anyone interested is invited to enable CONFIG_DRM_KUNIT_TEST,
CONFIG_DRM_TTM_KUNIT_TEST, CONFIG_DRM_XE_KUNIT_TEST, CONFIG_DRM_VC4_KUNIT_TEST
together with lockdep and list debugging, run the resulting images in qemu,
and look at the results.

Note: This is a one-time report; there are two many issues to list here.
I reported a recently introduced problem at
https://lore.kernel.org/lkml/a45b796d-5e04-4eac-b5ba-ea6bb3b6131b@roeck-us.net/
and tried to analyze further, but there are just too many issues and I gave up.

