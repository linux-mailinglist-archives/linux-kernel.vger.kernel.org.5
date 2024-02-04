Return-Path: <linux-kernel+bounces-51598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CB5848D0B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06281C218D4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE3A21A06;
	Sun,  4 Feb 2024 11:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mGyHB6ih"
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DF921A04
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707044975; cv=none; b=kfhsT2sLZcSAOPZwLNtSdDqp2NU0k9QO/GcJR9EJV5JnlUBM2vp47/WtMrWFSJ4q/NfVS4PDJHFe0VF6lqIKQg2/bfmCzb/duMSb98IHtdI2xCv22Odw+5CROP1XOQp1lWnTICHJ4vqLQU307EwHQtWeEnIv2JRz3YMaeSkDf9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707044975; c=relaxed/simple;
	bh=OuI+f2g1HAhI7/CycEEL1OFf0vqxAsY7uhLISZzlp2s=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=IwzsWrzS6TLH9pF3HdsIxi3R0Sps14ny4izMTjVwFgDbGra6rqkB4dSWmjwYfX4ic/pERO3IxiTIweFQWW2JVKlAVemFAqbRD31TBlusgXWzxqRKEoC/9l4Pa9WICUO32PDoElSsTAURduf4PaS79o5QPiRsqdIoYVaVHxvGkNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mGyHB6ih; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1707044664; bh=N6WZ19DLzwi4ytGmsyRu6Xuc7M6aw0MTr2uGPA1tKUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mGyHB6ihhZVxoBR05MUiH2kMT3EchgF6A2sD2+z5j98dpaxK/kFp5/ENhVSQyWddL
	 UK+y04D4luQ+/Me+0nhwmKybPkt/RF7frVbOYG7tP9FIY5pFr3PNBUNRk/GVJvugc2
	 QuuK9u2s0wyj2EJbkycFs3ej/CsbDoQmA8Gvic7k=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 1163E66E; Sun, 04 Feb 2024 19:04:22 +0800
X-QQ-mid: xmsmtpt1707044662t2ho40bmp
Message-ID: <tencent_562545BA71BB31330B9E161B694BE61B5308@qq.com>
X-QQ-XMAILINFO: MmuCfgcSBfHxErVBn823H0lrJqVNBSmCvgLfDDUTAvuPjgWmpq5g1BxBmGDDFa
	 MTUakaR39owCnflfYVYv6Wkjo+WXmyGkAZqU5w8O/pb2U86XHwm+HfQLFvJ4lckJ4uImiFi1aM6i
	 3wXxXdtKl41raYvKerqX89sJWc5EjqWIsIUXSClGxZgvRrMW0leyz2zwxT4QL0Pz1hhdV7YLmr67
	 TsuzkHukOWYhBszygAxXrOGclkYLcPgLrZyuJfbCgWOZB4uPjWRBUErvSQ+aunbUV+/Rvpal85Ir
	 /yS6Ql4SQ2aYRQDTwv8KkazQFLpL1ppou+c9tHFok5Pwci8kMw7smf+fQ8rAQXyNiL/Wo4aNrQNC
	 s7zuS0vo9HR4HXH66eCNbYoyYRRhMNKYu/CS7qMslYSgB7/pyVxNvawGNBaZSQpouVplJuEIrJk0
	 1Z/yGP9y/hCv7xP4oorHG6/ne6ttHN4QKE7euE+sInf85SHNfJ/VEAExUfTWEin2OgdOqYIPEDTR
	 FqkK8SHRq518rDyYjXO9IOkQ6lRSbnloHnE1tpVxFe41I/69Hx97ormCMEBLEJOvhhlzLsrAKTVf
	 EohqrwAQx+xLEACigskLqpgej0abRj2MWp8DxqLduKVXWN/3j9zOYgl+U73QSUv63Pw9MyJ60/Pm
	 PAkvmGdvqtfLR2OyAal/DSEcXQyQSnM1SfcWbR5nK+RBg8RlF2rIi1tq4+S5VZ3rIVP8ZsnO2Awc
	 vdbyUcODLP0d91/8xWH3w/VyF8IlfN7BhkzmNgu1HtX0fxlONtji9L6NBLhUNyZYN4LSoCPnplZ9
	 YbvlPsHGA+r8sNbjVDMEwJSHmP4pO2QhLJME6bGrGzPLdyyOb3ex06AztaUEVaOYxkOQUk9bf9hL
	 +vw2zkJLpMHI5TOpRXHU3a/XFbMtyRJxf7ioWxGImWplGvzY8ml+edGMHduYIMhBJkybNcX6w0
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+57028366b9825d8e8ad0@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [hfs?] KASAN: slab-out-of-bounds Write in hfsplus_bnode_read_key
Date: Sun,  4 Feb 2024 19:04:23 +0800
X-OQ-MSGID: <20240204110422.1862489-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000c37a740610762e55@google.com>
References: <000000000000c37a740610762e55@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test oob in hfsplus_bnode_read_key

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master 

diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index 1918544a7871..9e0e0c1f15a5 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -138,7 +138,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, int entry_len)
 	 * at the start of the node and it is not the new node
 	 */
 	if (!rec && new_node != node) {
-		hfs_bnode_read_key(node, fd->search_key, data_off + size);
+		hfs_bnode_read_key(node, fd->search_key, data_off + 
+				(idx_rec_off == data_rec_off ? 0 : size));
 		hfs_brec_update_parent(fd);
 	}
 
-- 
2.43.0


