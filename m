Return-Path: <linux-kernel+bounces-89076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED43486EA3C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A672882FE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2DB3C68E;
	Fri,  1 Mar 2024 20:22:03 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31843D0A8;
	Fri,  1 Mar 2024 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324522; cv=none; b=QJLDvLRD1TYcfvsqutS9na/rdEjeGeMtds6WQJoHan7n+lsl+l9U878HWRfP4st+NXmoevZGogzAfpHro/ufTkZMyS2H/6YdaVmI/T5QNhClcjneYuaW4f0wL9QlL3ZvhETpb5wcPNt+Ycu0dehHoFKQ7FS2XrtWOzLxmYp5UE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324522; c=relaxed/simple;
	bh=Z33H0J29XM+sDsExMXo5L5rpTDt++ne/uG8zlLX7Nw0=;
	h=From:Subject:Date:Message-ID:To; b=eT629cJKo1WJPCLlt3M6b0N/fP9EQo875Wm3JPgQYfUz0XSEuPZjqhOkrxfGVUbSj/p3V7iYldVuRUH5/xLyWzyGZBmYiGwqDnAX34IwjPgQqTqcBmZ4D02EKbT/kK7CNRdSoI28GNUZhizltuum99MvdeGqWwG4kCHENjm1qRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E813C433F1;
	Fri,  1 Mar 2024 20:22:02 +0000 (UTC)
From: Clark Williams <williams@redhat.com>
Subject: [ANNOUNCE] 6.6.19-rt24
Date: Fri, 01 Mar 2024 20:18:41 -0000
Message-ID: <170932432173.801463.1363216075556834116@demetrius>
To: LKML <linux-kernel@vger.kernel.org>,linux-rt-users <linux-rt-users@vger.kernel.org>,Steven Rostedt <rostedt@goodmis.org>,Thomas Gleixner <tglx@linutronix.de>,Carsten Emde <C.Emde@osadl.org>,John Kacur <jkacur@redhat.com>,Sebastian Andrzej Siewior <bigeasy@linutronix.de>,Daniel Wagner <daniel.wagner@suse.com>,Tom Zanussi <tom.zanussi@linux.intel.com>,Clark Williams <williams@redhat.com>,Pavel Machek <pavel@denx.de>,Joseph Salisbury <joseph.salisbury@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello RT-list!

I'm pleased to announce the 6.6.19-rt24 stable release. Note that in addition to
merging Greg's 6.6.19 changes, this release contains two commits backported from
the linux-rt-devel tree (6.8-rc4-rt4):

    b07c1d0e8114 printk: nbcon: move locked_port flag to struct uart_port
    96ad50c80b41 arm: Disable FAST_GUP on PREEMPT_RT if HIGHPTE is also enabled.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v6.6-rt
  Head SHA1: 631d3af7e20c0a91ec26e332f85e436ec8a7fc05

Or to build 6.6.19-rt24 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.tar.xz

  https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.6.19.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/6.6/patch-6.6.19-rt24.patch.xz


Enjoy!
Clark

