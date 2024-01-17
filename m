Return-Path: <linux-kernel+bounces-28582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4769A83004B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC8E1B249F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7783D8F47;
	Wed, 17 Jan 2024 06:56:38 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F13E4687
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 06:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705474598; cv=none; b=uOenoSk3THhn4J01HvseG4b0xkCLmiypXWX1a0AGvPNAxBjwDE+6wYKe8mYXRB7E6WVRZn0nqZbjR38wtdFIkAOvwoTVDRCVLXYQ/J/4OJzEAOIb7TKORA+DPh1wmX24RY04V/iMwmqYmF/f5SZ6IriVrJOTo7o8tbpqUbw6Rhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705474598; c=relaxed/simple;
	bh=4gLXLQ2IUbn664c7mSoZhG8SYyENSexnOQJPs3uwiuk=;
	h=X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-UUID:X-User:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	b=b/RHAZamwBsQBfAkbcvsA6i9ItL07vENcnffkm9UVyih1M5nHoMtkDhaVE2+4GeEX0Bo7Kamtv0rktJfUpUAeI7Aklaw1dhS1hd6n0wYEsAUl1eHGC7eBZHdjvo8MUdTw45zVsLm/GULs29iCGP3lgEBlOYI0TkG8cpMAPEIEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b0b7b37ef2d4489598c09ef941f3e055-20240117
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.35,REQID:c789928d-2a0b-4da7-8aad-28eb354417c7,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-5
X-CID-INFO: VERSION:1.1.35,REQID:c789928d-2a0b-4da7-8aad-28eb354417c7,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:-15,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:5d391d7,CLOUDID:cf5e578e-e2c0-40b0-a8fe-7c7e47299109,B
	ulkID:2401171451061ZY63EQJ,BulkQuantity:0,Recheck:0,SF:17|19|44|66|38|24|1
	02,TC:nil,Content:0,EDM:-3,IP:-2,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
	L:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI
X-UUID: b0b7b37ef2d4489598c09ef941f3e055-20240117
X-User: mengfanhui@kylinos.cn
Received: from localhost.localdomain [(39.156.73.13)] by mailgw
	(envelope-from <mengfanhui@kylinos.cn>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
	with ESMTP id 617716359; Wed, 17 Jan 2024 14:51:05 +0800
From: mengfanhui <mengfanhui@kylinos.cn>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de
Cc: linux-kernel@vger.kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	mengfanhui@kylinos.cn
Subject: [PATCH] nvme-multipath: fix bogus request queue reference put
Date: Wed, 17 Jan 2024 14:50:43 +0800
Message-Id: <20240117065043.79192-1-mengfanhui@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sagi Grimberg <sagi@grimberg.me>

The mpath disk node takes a reference on the request mpath
request queue when adding live path to the mpath gendisk.
However if we connected to an inaccessible path device_add_disk
is not called, so if we disconnect and remove the mpath gendisk
we endup putting an reference on the request queue that was
never taken [1].

Fix that to check if we ever added a live path (using
NVME_NS_HEAD_HAS_DISK flag) and if not, clear the disk->queue
reference.

[1]:
------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 1372 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
CPU: 1 PID: 1372 Comm: nvme Tainted: G           O      5.7.0-rc2+ #3
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1 04/01/2014
RIP: 0010:refcount_warn_saturate+0xa6/0xf0
RSP: 0018:ffffb29e8053bdc0 EFLAGS: 00010282
RAX: 0000000000000000 RBX: ffff8b7a2f4fc060 RCX: 0000000000000007
RDX: 0000000000000007 RSI: 0000000000000092 RDI: ffff8b7a3ec99980
RBP: ffff8b7a2f4fc000 R08: 00000000000002e1 R09: 0000000000000004
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: fffffffffffffff2 R14: ffffb29e8053bf08 R15: ffff8b7a320e2da0
FS:  00007f135d4ca800(0000) GS:ffff8b7a3ec80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005651178c0c30 CR3: 000000003b650005 CR4: 0000000000360ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 disk_release+0xa2/0xc0
 device_release+0x28/0x80
 kobject_put+0xa5/0x1b0
 nvme_put_ns_head+0x26/0x70 [nvme_core]
 nvme_put_ns+0x30/0x60 [nvme_core]
 nvme_remove_namespaces+0x9b/0xe0 [nvme_core]
 nvme_do_delete_ctrl+0x43/0x5c [nvme_core]
 nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
 kernfs_fop_write+0xc1/0x1a0
 vfs_write+0xb6/0x1a0
 ksys_write+0x5f/0xe0
 do_syscall_64+0x52/0x1a0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: mengfanhui <mengfanhui@kylinos.cn>
---
 drivers/nvme/host/multipath.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2dd4137a08b2..3e579e49579c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -895,6 +895,14 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
 	flush_work(&head->requeue_work);
+	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
+		/*
+		* if device_add_disk wasn't called, prevent
+                * disk release to put a bogus reference on the
+                * request queue
+                */
+		head->disk->queue = NULL;
+	}
 	put_disk(head->disk);
 }
 
-- 
2.25.1


