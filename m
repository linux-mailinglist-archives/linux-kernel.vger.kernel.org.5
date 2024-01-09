Return-Path: <linux-kernel+bounces-20410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A38E8827E67
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 06:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9FF01C23540
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 05:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E741C06;
	Tue,  9 Jan 2024 05:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CquAayhZ"
Received: from out203-205-221-149.mail.qq.com (out203-205-221-149.mail.qq.com [203.205.221.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64046EB8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 05:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1704778850; bh=gJh5yin306KBoz/bFQCRnrcKDcw76xEERZMrtRO7bn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CquAayhZLmaY6iLYygVwYzObPrx6XM6t4xHyESDPR0wGyznXHwNhrSv+yfu4wEs1q
	 A3tehJgry9dKdAK9zZlH/whRrCZBGi4WzuoWi/i7PnfQKbgk6KlOeTbqCeN7b0q/Lf
	 hSFQRMPKChUP2fVMINidp8ERfXF8feXsR6VT8mIU=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 8AF96472; Tue, 09 Jan 2024 13:34:47 +0800
X-QQ-mid: xmsmtpt1704778487timnr9dol
Message-ID: <tencent_0A35775D67883DED3600968C369A4A207409@qq.com>
X-QQ-XMAILINFO: OZZSS56D9fAjvwR1Hog5YppyTRZuz+8R+CGNZSQR1PidRmQMGAvlgDs0Cb2H8d
	 /ljY7rwIym4oGgjpolJ70jbg3jf1VLHsGFEIm8yznJrUF+jjjmSQ0sv6JRnaaoYwLWhkcmM4MWW0
	 VvVn+YpNiwtITUU5Q52oEz+CL/3ed8LoNX+ZjnwhHlprACHXSMr5xbMJqcZNdhx96y4y5o0xc0hE
	 +JS5k1L2182lYdv+Y/u2HPWOQ8OT7Zvp6ZJyprdZXi/SOdOpS471NXvjLm28Och8GPahibEv0+nT
	 6qNaljuUeZgMDP/YyetxxpSxeFWtjMgyvRdKZuysRO+CEWAW83QJIN8RU1tgowYtRLP9xFksb4PJ
	 RNsMuTUO47Vy3VM+bZRn+hXBbT4FeqWv9GPQ+PH2vzCcGRwYtzslZCa0Qc7RV0vo5qwfWziEjgR2
	 RdFZMuEPz4iIHPBn1P2ZJDUADG8cT9PnuPPL/bnL8fj0BXF3DdsWTx+aRPdZpE40eIehqpiyxD+y
	 NXMC/cImLVXhV4qvBGrO3Z4sqYdVtyaGTkW6sluVk6zK37DfhOK/8ZV6QeaW5aPYnJnDXliTTzSi
	 Q97lWFu6NKIk2TX2ia7Zv3FHT6flHrNLXamYL5eitrjo1CGzXFO3A8YrSL4m0+kQhB81vyil27e4
	 I8ofV4FhTlaJwf/QInC5cj61znKwYqWKARC6mJAAhuuba1mIUhZ5qmIOAXSI25WBIOvIZam/Eb9a
	 fj9ANtFAUc1lIT0KXbrbLmkm9T8dtmPJkjnxQ42s2Tw1CbcxVAD8h3GVZJvyJwqklzJeDi9R+0ev
	 Pi/R1Bbi3nJVD0bDrRlbQtBe4APrCtbE3scWv62Hn8/LB9R8FySsLxd0J5m6Y8711DC1Rl5oj+8Z
	 MElsKa+QCKjiXFEbM8r6GQBs5HAjL3DM5lQv1fH7QsR8d5xDKbkeeA5OrMJPJVGw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f2977222e0e95cec15c8@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bpf?] [net?] WARNING in __sk_msg_free
Date: Tue,  9 Jan 2024 13:34:48 +0800
X-OQ-MSGID: <20240109053447.297284-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000aa2f41060e363b2b@google.com>
References: <000000000000aa2f41060e363b2b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test WARNING in __sk_msg_free

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index e37b4d2e2acd..68dbe821f61d 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1016,6 +1016,8 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 
 		msg_pl = &rec->msg_plaintext;
 		msg_en = &rec->msg_encrypted;
+		if (msg_pl->sg.end >= MAX_MSG_FRAGS)
+			return -EINVAL;
 
 		orig_size = msg_pl->sg.size;
 		full_record = false;


