Return-Path: <linux-kernel+bounces-68175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B269E8576D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4A6C1C21351
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 07:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0E117584;
	Fri, 16 Feb 2024 07:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="JglQ2D7x"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7D214F64;
	Fri, 16 Feb 2024 07:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708068657; cv=none; b=CDTuQdPqOg+NheLfQjHPMfqZmUSRYol5muUkS3cQM5e2f9yyRad7OVmHbacVRtUhlihFMUY7Vl7Guox/Q/Q0a39YkUic75cxfgzb015vQz2TMU+iWuf9Nv/46hvJtH1rqX9whhM7oPBQ4u9HqUEB9XB0CinR3Bod903nJHEclis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708068657; c=relaxed/simple;
	bh=il5N1vnmpl55nKiBSWodnniLgzwmVnkncxtusVGJsMM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=IzLIKSgk7gNWc3E5WFkTf5e21tHsO0noEwGOI1jvh+AvMcHGDBQs/DZ7LL+ZMeuMP8HSANvdQBarrYUQy/C0cLqARmiJ8Bbz3c3Rjbp2XCnBIqp8OP7JXk8TTPGuayluUVMUKWhMBgY5Y9+TrzZj/SW/JpIo9EbofMxdwtTBJwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=JglQ2D7x; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708068650; bh=LI7+HfgPn91X8B3ek8ngduF8UyNONzqL8p0IqpzD8OY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JglQ2D7xWlF+jVeRZBQCYSfWeujkI2+Z/N52xLrrRIYJRtiaXcmZMSI85Z2z+Spfq
	 yxzgLQgRU7QNGUw1WUuhVYR6C5azLNuDjlM8u9h8Qjgz+Hn8EHh1zuTUJ4MrGr+P/r
	 lCWZgGxJ6eOzoWDXOSk0p3T2OBrOzjkZqhA8DwkM=
Received: from pek-lxu-l1.wrs.com ([36.129.58.158])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id 7AF038ED; Fri, 16 Feb 2024 15:30:47 +0800
X-QQ-mid: xmsmtpt1708068647tzqympn6w
Message-ID: <tencent_19D16EF24CA0E7F686C252C8C66D49A2AE06@qq.com>
X-QQ-XMAILINFO: NhpLzBn2I3XwYSLVf/8Xh+7+MIRs05BE/7Vh5PSJieJn3W2fTye9GkDn6FJ70g
	 xXdV/4O6/JYaFIHCw6UHV38RuHI6rhuZrjL7IrUuX+hakjaXZYY94m+sgAU7CGy+x2MOaZZONIaC
	 iF2+NjBGCJ3/5GzpORsuxFio8wpZNqVi/0dxECcIZXwx91R+RUv26/quIc8i4es2kVO17wdWwBor
	 J2uXIsmhmHnP6fmx8GOUn7ejfFbYq2D0f2kxw1+U9AySXwP4g6jQqAvmldae34dmYO/mHFWfPjeb
	 WxmUkNfxFPrah53xVNXuLZFp7eyQNLjjpq/uPuyXCiJON6RSwRSZuJDDz1eFWn0MN66RPyETjhxT
	 5JJXIqdHXza3DnHQTgkuKywCBnWkaRfAE4hdZc7N7Vh109XsKXODV1XzWL2UedzjzrMbs4cWEYVt
	 K/H0qpc31pDDXUC/5ptxnmjYQMwxPg2yxwp75t7IysYYrSdvn28UTeEH41NITDWSYkCuSHkLZo0s
	 K0LTIKYRmZtoDIxydWPLZwIHb9d1Nw1qtxRwyU3SE/026t5DtjKOl3WkpcaHJsC7t0dbwnRjkviT
	 NXF+s60ZYCt4wHVXUcEMfe1yGfHt5pn4wcjKTyyaL0mHOMmfABqoZyM3T6brzpgcAsBV90CXO6eM
	 6s4c1Yl/k/yx0A+v8qTkQmwB8NNa5931sYTkHyMQ+ZqYGILq3GBbg6ARu18BCnfvWnnOeRi8mPjN
	 Ns8BoPHHBC90b5rq+DFEQbHFfUWWbyWEqfnQt4P6NxppxdnozrMhnqcbSYZ77G7lAwEszTfuSpXB
	 UmwmaIljwPOVlz5izt9B+cmf6Y+F1TF+krGYOKhJ0ku1JW/GCOk+ULtadcCVfiHSiLIEApVxIYXp
	 IiB7XnEprRNUuffUXA74Wnhlsgt9PwW/xO/6XtffWJ4Zmf4USrKpRCu8OSANW4qA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ce750e124675d4599449@syzkaller.appspotmail.com
Cc: isely@pobox.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mchehab@kernel.org,
	pvrusb2-owner@isely.net,
	pvrusb2@isely.net,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH usb] media/pvrusb2: fix uaf in pvr2_context_set_notify
Date: Fri, 16 Feb 2024 15:30:47 +0800
X-OQ-MSGID: <20240216073046.1137237-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000028b68806103b4266@google.com>
References: <00000000000028b68806103b4266@google.com>
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


