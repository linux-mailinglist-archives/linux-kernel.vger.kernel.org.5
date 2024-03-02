Return-Path: <linux-kernel+bounces-89308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7DC86EE16
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 03:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BA2286654
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 02:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E638C04;
	Sat,  2 Mar 2024 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="l3FLu5C3"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A945963AE;
	Sat,  2 Mar 2024 02:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709345605; cv=none; b=DKv6kJKEDW7E+RJfCszEmbbc7w4bgDFhT4D936pFMdY5huCt5gk1824elzraIvPuCmrQy3LeCc4eaKJr5/W6cPc7BBILt/L9Yz3QqvlQLPYLwrq5JsdGz9+VA7kGP4m0ObLteCMzRFzwk+DDKiswtIdoA1jcDK+977aK1hOJyF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709345605; c=relaxed/simple;
	bh=ypnpNuK5U8spfWm1zPCpA2bMMUH6x+EuFKD46vnbfk0=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=U6VQhC6yW8k294dQIWlZWK0N4yTxQ9x+v+u2KC/QNPXs/g/P4lIbnaa7NObyGBsERiPeAwDTfD1qwMEjy3d55Cayru67VJKzH24dNHm4113uhyeSLPB+omwafw+rivde4lQuQ7b9FTyAlJ1e8V6jST5uHYRzaWt+fTKCYykm7GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=l3FLu5C3; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709345291; bh=0aswDH86I9wagW7/7Q0JXkWwKqH263XZZbniRb/t2yQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l3FLu5C3XyS+9UaEvWvhv0VxGaeGt3gAa9HonoopH9exEULXkb9cmZCJHumi5+xGr
	 rzwxWYcf2nHkFimDgRIemP0OsdpHJihl135+v+o2C309RpmilLTVHojKkL/yt2WDdR
	 Osn2iNcKpQ5l2Rw2eVXWOxwNZY+8PBvUSA876+HY=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 2031FAC0; Sat, 02 Mar 2024 10:08:03 +0800
X-QQ-mid: xmsmtpt1709345283t23zykfnc
Message-ID: <tencent_9DB5A7EFC6D152E3065489A46EDF6EE24C06@qq.com>
X-QQ-XMAILINFO: M/NR0wiIuy70cja9QE9nCnfOWrA2FZnAhHTZYnKXNAV0RdJY6uByilpN9MMhfW
	 UVpb8vWL80Xw/3jE6G0SB1uIfRPTfY/zORFiZK2H56o6c5ayykji0SCX1ZNf4owXRYkaG2QR5Rnc
	 xmwcSBoGB531zjnAd6MUAfywjNuwrAQCgu+Dok+ZlvbMTNHsHa0RUQ0CkYrnf0mtDfms18tMRcsP
	 YkRNvkErTfH0jD53Jz4jLgf/5uFQ8Uodibc3JK+N91eYir8LhLI7VfEedDVx8kI1WW343dcADQv2
	 oJ6PNAhUuc0OqJFaB7ynvQg9wyfesSjtIdkNmUI3gXbtJhhMZL2X0A2v1xNJe56fiJZt3uvs7Wwt
	 EJXj3o4Q7bIB1JQWrwN8sx7BbpHPo1ovp897pqaPe+HfE+weBR006JFMuhLbi2qEDhPLt/eHazA9
	 EKQkKQvqBc3Euop65y/agXpUXMfgEVadmcEdI5KiQkb2BCeOWKZ/f9b7cYo+PlZlKHh3Dc2qAaz3
	 qpplDnHz6PTLjm0+Xez3YUce8yhhudP5QVDyzfJOI/4zCeaqR+hMfJfKUO8REGusj38kU55Mvx/4
	 Zir66OOUAtfVujwvASeYCl+OCc0a6cx9LTXGYq0BYUk3irbTEVEN5ZoCDXB508HEjVZCF8vcTm6+
	 EwHcEFDnkqaM6+Eu7GaYW9bY+Nl16NjF7QISEFpHgva1EGP2aaGGVwTXFSDfD9FBcQFSIoyABnxw
	 DFVtR189FbS+UR/2OcxHxufiXdRTsbhD3hMUCyh5DysKNj8S0yb/gqtSwhbsynYQ2nN27BrJEQnQ
	 8UWWzD7U0otb7zHfeNJkYj48QMz++RGHaUuNOS2cZaUqGdIy03YgA9CD9NQFhtwogW5cT8WKS0Pa
	 eoxdOvAlRYHONpgQAdF/pdYWxnoM1Fw7Hc2gW6xWHpxemaz+0b3cNr/IpIqot9KyJPFQFG0podUT
	 Kp3Egbq8s=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: Edward Adam Davis <eadavis@qq.com>
To: greg@kroah.com
Cc: eadavis@qq.com,
	isely@pobox.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mchehab@kernel.org,
	pvrusb2-owner@isely.net,
	pvrusb2@isely.net,
	syzbot+ce750e124675d4599449@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH usb V2] media/pvrusb2: fix uaf in pvr2_context_set_notify
Date: Sat,  2 Mar 2024 10:08:03 +0800
X-OQ-MSGID: <20240302020802.2858149-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024021716-accent-islamist-6a87@gregkh>
References: <2024021716-accent-islamist-6a87@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syzbot reported]
BUG: KASAN: slab-use-after-free in pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
Read of size 4 at addr ffff888113aeb0d8 by task kworker/1:1/26

CPU: 1 PID: 26 Comm: kworker/1:1 Not tainted 6.8.0-rc1-syzkaller-00046-gf1a27f081c1f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0xc4/0x620 mm/kasan/report.c:488
 kasan_report+0xda/0x110 mm/kasan/report.c:601
 pvr2_context_set_notify+0x2c4/0x310 drivers/media/usb/pvrusb2/pvrusb2-context.c:35
 pvr2_context_notify drivers/media/usb/pvrusb2/pvrusb2-context.c:95 [inline]
 pvr2_context_disconnect+0x94/0xb0 drivers/media/usb/pvrusb2/pvrusb2-context.c:272

Freed by task 906:
kasan_save_stack+0x33/0x50 mm/kasan/common.c:47
kasan_save_track+0x14/0x30 mm/kasan/common.c:68
kasan_save_free_info+0x3f/0x60 mm/kasan/generic.c:640
poison_slab_object mm/kasan/common.c:241 [inline]
__kasan_slab_free+0x106/0x1b0 mm/kasan/common.c:257
kasan_slab_free include/linux/kasan.h:184 [inline]
slab_free_hook mm/slub.c:2121 [inline]
slab_free mm/slub.c:4299 [inline]
kfree+0x105/0x340 mm/slub.c:4409
pvr2_context_check drivers/media/usb/pvrusb2/pvrusb2-context.c:137 [inline]
pvr2_context_thread_func+0x69d/0x960 drivers/media/usb/pvrusb2/pvrusb2-context.c:158

[Analyze]
Task A set disconnect_flag = !0, which resulted in Task B's condition being met
and releasing mp, leading to this issue.

[Fix]
Place the disconnect_flag assignment operation after all code in pvr2_context_disconnect()
to avoid this issue.

Reported-and-tested-by: syzbot+ce750e124675d4599449@syzkaller.appspotmail.com
Fixes: e5be15c63804 ("V4L/DVB (7711): pvrusb2: Fix race on module unload")
cc: stable@vger.kernel.org
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 drivers/media/usb/pvrusb2/pvrusb2-context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
index 1764674de98b..e93bca93ce4c 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -267,9 +267,9 @@ static void pvr2_context_exit(struct pvr2_context *mp)
 void pvr2_context_disconnect(struct pvr2_context *mp)
 {
 	pvr2_hdw_disconnect(mp->hdw);
-	mp->disconnect_flag = !0;
 	if (!pvr2_context_shutok())
 		pvr2_context_notify(mp);
+	mp->disconnect_flag = !0;
 }
 
 
-- 
2.43.0


