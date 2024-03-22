Return-Path: <linux-kernel+bounces-111981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8169C8873A6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F281C227F8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469D578267;
	Fri, 22 Mar 2024 19:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="O0L9lAhB";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="O0L9lAhB"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827EC77F3F;
	Fri, 22 Mar 2024 19:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134751; cv=none; b=kfQ7BEso/S0OMqDhPi5Ovvckcr00f44oSYneKk4zdZQ2Ff+LR8Rz7atjzEO9aZAXUDAJKon0G62eMpnmIUn5jXROJy5rCQ+hxoyabvRkWoaXjVF2A3VazLwwSbhPf/fL0J4SE79uqlWLUcK+lecdqczzdAAEjaaFqO0dkhXdieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134751; c=relaxed/simple;
	bh=GYXmziAXDE6PNiPiU905R/Kg8dz4JwQFMBnJb0PLEgM=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=oGJzCmNHQqef/QHa2tIwBywSJ7bxJArmUV8Fk9ETa7iRTqdZnfZLhg5ScAmFah2Q1cO0eVJ7ti+J9+zyS5QGin4hNfFqNIqlSiFs1Z2vcXqLhynfxclqktOOyQkO+a7MhsRZXOzP/eotKBLvBshnDaOUYy47eoHFLuGROAvKSSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=O0L9lAhB; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=O0L9lAhB; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1711134748;
	bh=GYXmziAXDE6PNiPiU905R/Kg8dz4JwQFMBnJb0PLEgM=;
	h=Message-ID:Subject:From:To:Date:From;
	b=O0L9lAhBDjCK/m/hdS5phBsaiBU4aYGdjOgILK9vqv5Y8UjZuz05LYrU2g6J+BXif
	 1u6MwUxryz8rz1ClQJyxSQ9M315Vez/rMTV6ueVtvxvjGd5aYONfi3kQdj1t5cFssU
	 bXoi9b63yyvSrLf22aJynX5fGAyygYJcJ5+5Thtc=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id C0596128676F;
	Fri, 22 Mar 2024 15:12:28 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id FohgbQh1_qix; Fri, 22 Mar 2024 15:12:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1711134748;
	bh=GYXmziAXDE6PNiPiU905R/Kg8dz4JwQFMBnJb0PLEgM=;
	h=Message-ID:Subject:From:To:Date:From;
	b=O0L9lAhBDjCK/m/hdS5phBsaiBU4aYGdjOgILK9vqv5Y8UjZuz05LYrU2g6J+BXif
	 1u6MwUxryz8rz1ClQJyxSQ9M315Vez/rMTV6ueVtvxvjGd5aYONfi3kQdj1t5cFssU
	 bXoi9b63yyvSrLf22aJynX5fGAyygYJcJ5+5Thtc=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits))
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 21CC0128672B;
	Fri, 22 Mar 2024 15:12:28 -0400 (EDT)
Message-ID: <3b789eacddd6265921be9da6e15257908f29b186.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI postmerge updates for the 6.8+ merge window
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Fri, 22 Mar 2024 15:12:27 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Eleven patches that are based on the rw_hint branch of the vfs tree
which contained the base block and fs changes needed to support this. 
8 patches are in the debug driver and 3 in the core.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Bart Van Assche (11):
      scsi: scsi_debug: Maintain write statistics per group number
      scsi: scsi_debug: Implement GET STREAM STATUS
      scsi: scsi_debug: Implement the IO Advice Hints Grouping mode page
      scsi: scsi_debug: Allocate the MODE SENSE response from the heap
      scsi: scsi_debug: Rework subpage code error handling
      scsi: scsi_debug: Rework page code error handling
      scsi: scsi_debug: Support the block limits extension VPD page
      scsi: scsi_debug: Reduce code duplication
      scsi: sd: Translate data lifetime information
      scsi: scsi_proto: Add structures and constants related to I/O groups and streams
      scsi: core: Query the Block Limits Extension VPD page

And the diffstat:

 drivers/scsi/Kconfig           |   5 +
 drivers/scsi/Makefile          |   2 +
 drivers/scsi/scsi.c            |   2 +
 drivers/scsi/scsi_debug.c      | 293 +++++++++++++++++++++++++++++++----------
 drivers/scsi/scsi_proto_test.c |  56 ++++++++
 drivers/scsi/scsi_sysfs.c      |  10 ++
 drivers/scsi/sd.c              | 111 +++++++++++++++-
 drivers/scsi/sd.h              |   3 +
 include/scsi/scsi_device.h     |   1 +
 include/scsi/scsi_proto.h      |  78 +++++++++++
 10 files changed, 490 insertions(+), 71 deletions(-)
 create mode 100644 drivers/scsi/scsi_proto_test.c

James


