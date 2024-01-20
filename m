Return-Path: <linux-kernel+bounces-31831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27384833540
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 16:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E72283DE3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 15:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A904010A03;
	Sat, 20 Jan 2024 15:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZI0Mll+b";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ZI0Mll+b"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540E101E6;
	Sat, 20 Jan 2024 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705764371; cv=none; b=rSEc4EB6YbN227pUG/0UdSTclgv9M9EqZpzo7nH9aREdriiPwk/ItG0SWxS2LwP2vS8A+iJgWpTl/Kmm9xDPdn5OEJkP/SHRjb9avVyiX/fjAGb/HcKfHx3SKOL5XNrl5hkvkPItjy0ALYFRZbbsRCHDNVGNUSl/BPUYcZodmeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705764371; c=relaxed/simple;
	bh=a72aMC2x+tlqDGYT+muG6VnM7nK1dGuLlZ5Xnk3fvjs=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=rMxiGyW4aYpk4310fxmnWWWXZ2VLDbKuH5va/wijsTgd3JEAA7H8xp0Y18UfNrw0HA7mY0q8Xl2s2e1kUPaiIi6ysZyoqn9aF2iR6zvnpYELqFeQ7JgTvA9RCIHVWJH1P2PhJZbQ3kZ76QvStQ0et4wwpZSC44h21qo8Nhn0ypw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZI0Mll+b; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=ZI0Mll+b; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705764365;
	bh=a72aMC2x+tlqDGYT+muG6VnM7nK1dGuLlZ5Xnk3fvjs=;
	h=Message-ID:Subject:From:To:Date:From;
	b=ZI0Mll+bcHhH+2Hc/hOiZUlR7pcdoQkzZa8WmsuPybQpTO0gAhkcK/mrINcSClht/
	 WhD2UyRao86dazLrzo8INAWu1Q8HyRh18P6QXnB26Ba4TWY1kziqfgd9uPfeDXsd1j
	 USz2E+SU0zGPTsour/77dsKJRzpg21BW177fh9cE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 5BB741286814;
	Sat, 20 Jan 2024 10:26:05 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id 60Y5q7ZL7Ovs; Sat, 20 Jan 2024 10:26:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1705764365;
	bh=a72aMC2x+tlqDGYT+muG6VnM7nK1dGuLlZ5Xnk3fvjs=;
	h=Message-ID:Subject:From:To:Date:From;
	b=ZI0Mll+bcHhH+2Hc/hOiZUlR7pcdoQkzZa8WmsuPybQpTO0gAhkcK/mrINcSClht/
	 WhD2UyRao86dazLrzo8INAWu1Q8HyRh18P6QXnB26Ba4TWY1kziqfgd9uPfeDXsd1j
	 USz2E+SU0zGPTsour/77dsKJRzpg21BW177fh9cE=
Received: from [172.20.7.151] (adfb31ae.cst.lightpath.net [173.251.49.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id BE6091286813;
	Sat, 20 Jan 2024 10:26:04 -0500 (EST)
Message-ID: <d2ce7bc75cadd3d39858c02f7f6f0b4286e6319b.camel@HansenPartnership.com>
Subject: [GIT PULL] final round of SCSI updates for the 6.7+ merge window
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds
	 <torvalds@linux-foundation.org>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, linux-kernel
	 <linux-kernel@vger.kernel.org>
Date: Sat, 20 Jan 2024 10:26:03 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Final round of fixes that came in too late to send in the first
request.  It's 9 bug fixes and one version update (because of a bug
fix) and one set of PCI ID additions.  There's one bug fix in the core
which is really a one liner (except that an additional sdev pointer was
added for convenience) and the rest are in drivers.

If you're still on a no power trip, these can also wait until -rc1.

As requested, I did a longer extension of my gpg keys, so my key needs
refreshing, before you pull, to fix the expiry date.  You can get my
updates via DANE using:

gpg --auto-key-locate dane --recv D5606E73C8B46271BEAD9ADF814AE47C214854D6

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-misc

The short changelog is:

Bart Van Assche (2):
      scsi: ufs: core: Remove the ufshcd_hba_exit() call from ufshcd_async_scan()
      scsi: ufs: core: Simplify power management during async scan

ChanWoo Lee (1):
      scsi: ufs: qcom: Remove unnecessary goto statement from ufs_qcom_config_esi()

Dan Carpenter (1):
      scsi: fnic: unlock on error path in fnic_queuecommand()

David Strahan (1):
      scsi: smartpqi: Add new controller PCI IDs

Dmitry Bogdanov (1):
      scsi: target: core: Add TMF to tmr_list handling

Don Brace (1):
      scsi: smartpqi: Bump driver version to 2.1.26-030

Harshit Mogalapalli (1):
      scsi: fcoe: Fix unsigned comparison with zero in store_ctlr_mode()

Mahesh Rajashekhara (1):
      scsi: smartpqi: Fix logical volume rescan race condition

Niklas Cassel (1):
      scsi: core: Kick the requeue list after inserting when flushing

Randy Dunlap (1):
      scsi: mpi3mr: Fix mpi3mr_fw.c kernel-doc warnings


And the diffstat

 drivers/scsi/fcoe/fcoe_sysfs.c         |  6 ++-
 drivers/scsi/fnic/fnic_scsi.c          |  1 +
 drivers/scsi/mpi3mr/mpi3mr_fw.c        |  6 +--
 drivers/scsi/scsi_error.c              |  9 ++--
 drivers/scsi/smartpqi/smartpqi.h       |  1 -
 drivers/scsi/smartpqi/smartpqi_init.c  | 89 ++++++++++++++++++++++++++++++----
 drivers/target/target_core_device.c    |  5 --
 drivers/target/target_core_transport.c |  4 ++
 drivers/ufs/core/ufshcd.c              | 14 ++----
 drivers/ufs/host/ufs-qcom.c            |  7 +--
 10 files changed, 103 insertions(+), 39 deletions(-)

James


