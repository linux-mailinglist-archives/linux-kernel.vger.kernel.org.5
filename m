Return-Path: <linux-kernel+bounces-31946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 837D1835418
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 02:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FD7B1C21301
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 01:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E015341AB;
	Sun, 21 Jan 2024 01:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hGWZn3/e"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DC634180
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 01:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705801365; cv=none; b=RgbS9wdPOfeUqIvItyeU/unLbRfyy0b2/vJ7m0PirzOCui5O587EdAFnqLkuQ1wfEfZyJEoVE9VthuCEAEJj9KEbtkOZwe3NNWKcmKJE0hpUsF11zfrqW/O+PlrdsQrNnWxggo7HwvxqBKfxaRJ+UY2mP3O6o6om+z+BPZ/W1FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705801365; c=relaxed/simple;
	bh=MGQ/rETum61B9lts0fEejxTp9NeTxVY0+q52BTJjgB8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KWV7b3ZMOgKcJdvNG9/SKVMPpRe5qmE+mrCnku7QeI53/zdnKw6xBt+1UlDkWa7g257oqi/7VQSdsBwMvmtSMvD8/hi5ITpM8GF/aZDz2Pv0dE5dQ5V5BSe8dpF/EfHQGM+5HS7p8ivxcCU4Df0NrA9fCqJU1t1sSxF0KTHxayk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hGWZn3/e; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 20 Jan 2024 20:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705801360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=2PKBbGmwCGvzfky1SHIVRw2tXcfG1GUlvK5XCZhvIX0=;
	b=hGWZn3/ewDXNIMO4Qs0NI8I3Dv/rEu7qOM0i7HDlYC8bsbXvO4dHbqMxJQ6UUYfoJkexOE
	g0ZXBa8hl0/o/ovce2unEyQXYUpkWW6D+tBIsWahHtlo9Om6YZZY676DU9XMD8lVdFjOy4
	nuPQOki7bLcbhMOm7YUCLEg9JY9kOhI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] header cleanup fixups for 6.8-rc1
Message-ID: <ips7d5lbyq76awhnj5ttnsbbvaykkemhnwe56rzphetm4zhn2k@nciievifs2fj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

Hi Linus - just one small fixup for the RT build.

Cheers,
Kent

fatal: Not a valid revision: https://evilpiepirate.org/git/bcachefs.git
The following changes since commit 1e2f2d31997a9496f99e2b43255d6a48b06fbcc2:

  Kill sched.h dependency on rcupdate.h (2023-12-27 11:50:20 -0500)

are available in the Git repository at:

  https://evilpiepirate.org/git/bcachefs.git tags/header_cleanup-2024-01-20

for you to fetch changes up to 5f4c01f1e3c7b0c8d1e5dd6f080531de7aa5e47b:

  spinlock: Fix failing build for PREEMPT_RT (2024-01-15 15:52:12 -0500)

----------------------------------------------------------------
header cleanup fixup for 6.8-rc1

----------------------------------------------------------------
Leonardo Bras (1):
      spinlock: Fix failing build for PREEMPT_RT

 include/linux/spinlock.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

