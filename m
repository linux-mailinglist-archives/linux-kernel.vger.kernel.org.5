Return-Path: <linux-kernel+bounces-17872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AA8825466
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB64284BFC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42B02D629;
	Fri,  5 Jan 2024 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wG4H+KTw"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CD728DD1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704460833; bh=MYY9stIYqlycYBITbBDp8hgnPLSnqcWc70hs+qeH1q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wG4H+KTwtTgWf+fuIJwsjdFGj+X2TXw0V4sCtg2UNqak/2oqWMXcfqzYIYn+jMGp4
	 kEECMhEaKNbKRej8MSGlVokwtl4EYaPlNxlW6Q4tLa3xeuPN0WCFkvuLjihk+Umil0
	 sU28+Y8G+wjzaB8W9uM4/izlf4w4gfY39apORq1w=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 39719AEB; Fri, 05 Jan 2024 21:14:23 +0800
X-QQ-mid: xmsmtpt1704460463tqr5ni1r6
Message-ID: <tencent_684C75F177D366163C3136DE97A436404A09@qq.com>
X-QQ-XMAILINFO: MQ+wLuVvI2LQe/ZWzugQ8nDB1qPxlZ7xl8XdkJBdsqmWDPftHSFWoX9L6JEu3I
	 EIStlxHkloUAMsHWvYKJDpdVqKSrprpXpdDnKwV5BoZEvK6490tzodXj0bNZ32WUKwWh+GRVE5ci
	 WAM2u04n5wRgsL4Ks5744sVCeic5AEW7v7wkiLMhWKs/Tev/K7sv+4rfGCAtsmFLafzeQMYteEE3
	 KJY/LBPtZAAHTJ0SJy2je8GRjsdJaDf7gJ/ySQVf6YNNSNwJy8ikD4OPFtnTFkcgyxOwHdMmdI0J
	 aECP9lzlBhWXoEW6ZITa9ugtUM8HYaE4k0y+WMS0kSEG8akavoRWYq7eBF2FmhPclGUNZZgvuBU4
	 9StzrM9Sxxxb9VhJVJQt8TxgCvgEyadGrMtEEVgSYMLIUUQrincjMn6QmXpCo8rT22N0PS9ehqTK
	 lcePEAQhkvRtAb+fPj3Dg4LOOLnFlH0jHeoSg5BC9gkn4M9tfXGvyEARCSoyvBMfkU109cgsMNkK
	 7/SBXVLismeEVr5T6PC8aujlKdW1DOTQxgprd/Lj3bcp3hdXcdUla0KWouneVM8X0ROw6reew35a
	 SQQ2lByt26MolY+4Qlc/pyqJDRgklRGCy0nyAX153KQ6p+d3rke9s3agh1L6JvrX1xuoNitWjVoG
	 KOW5n034tbzyuDLOrzWJS1F672z2eil4jcfkBrD/c/KnYFidqpy/nGC28df+/WVbs+wdto/4JQpn
	 uBJCXOkNl5ZYL75isfO4rsVhxKxKU2WUv/XiwTXWfDEaXtT7hD0xl0z0jR8rRp/RobV10/n4YBC3
	 1Z1ViCbVD6zKyLwHgmJDcOUdeAIom4KpmmbDQNue8gRXUQNmYbNWok1BH/+qlaoZPbqyfbqLG4ya
	 YmT5lGZ8kWahfc79doqqT5ovba1Ix6eo6+u/o9rnsZjzSXDdJirzIUHwNhhMLpOP0hkU2vBLWOcD
	 bRIoHNUVk=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+63cebbb27f598a7f901b@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [reiserfs?] general protection fault in __fget_files (2)
Date: Fri,  5 Jan 2024 21:14:23 +0800
X-OQ-MSGID: <20240105131422.664067-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000caa956060ddf5db1@google.com>
References: <000000000000caa956060ddf5db1@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test general protection fault in __fget_files

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f5837722ffec

diff --git a/fs/file.c b/fs/file.c
index 5fb0b146e79e..724f60e6cc4f 100644
--- a/fs/file.c
+++ b/fs/file.c
@@ -1134,6 +1134,8 @@ static unsigned long __fget_light(unsigned int fd, fmode_t mask)
 			return 0;
 		return (unsigned long)file;
 	} else {
+		if (!atomic_read_acquire(&files->count))
+			return 0;
 		file = __fget(fd, mask);
 		if (!file)
 			return 0;


