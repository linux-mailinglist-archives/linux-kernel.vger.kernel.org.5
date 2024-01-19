Return-Path: <linux-kernel+bounces-30801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D565F832477
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:57:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BF641F21DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 05:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9D4D51D;
	Fri, 19 Jan 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pddgZsIH"
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E306FB8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 05:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705643811; cv=none; b=FGx76xO06QH2myqYefEr0sFaNftBRrxDsJupzX9uCHAcFDoEQ4mmqcYVzSdyLH7uBjAhBGNgXR4B6yZ/WLpO6FqGt4WABpZhzQeWEGNylRdzhkpaOBKefgX21w0z6I/HkBzhB2B9qN6SR8u2ssf/yCE43Mfyw9N/w+N4yMmHpO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705643811; c=relaxed/simple;
	bh=TtWZc7CQ2Ew+Rb+jFS85E6n8gecRO1MNLhd0axgfV5c=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dYjYfygiMNqY+iCBlBpjxRSCUEOEEVe4aFcT/61dq51Bfulegvc9sxTzzIRF1sUpvHDRm11CIQmNfrqCwZ5lq5FZYZOSAzc8mu1eK2zAkXdncHNylsB0w1XLziwDTqYcicyxh5kDhgDlfd0EM6sRQnvg+T5DH2T2s1Kv6onKj5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pddgZsIH; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1705643498; bh=UQR5IqDtYYU9OvM5YX8pU7QSr13D2cdTiJmIWG6eCnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pddgZsIHZnwKZmYtMohAwBGMEZ8ibN+mWfPPJjk4IduoRs+ev6D2z6qxr2LYwijpJ
	 r00E6BYWogEWA2GgdlQYGqpiGD96RHRyYN3EHwQI83CEhJ5r02ERyDUdNvdgkwfUqG
	 wkq9yxaa2zT82Ru8sABtkXwjuy141uyHvcoH4FD4=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id CE43BAA1; Fri, 19 Jan 2024 13:51:36 +0800
X-QQ-mid: xmsmtpt1705643496tigznyk37
Message-ID: <tencent_1B2ECE8078726E5C2D856C0497A0E80EED0A@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69+OV4WSENK3vpXadt+cQi1ic4ER0Uxy4MhXbVSqvmxAX8ttu6mV
	 ZaGw5GCasqmF64lU1UfpTZxKVJKZgLZ69FO51mGh/H6y04m4rpTC6Tk42gh4K4S6cjQDvw9SKkoH
	 q27gFtwE4Qbb+sWD9QoJrF+inMu1sO3gXm1R1Lnisb96kjNXdYx3Noa0nizINB4YRnq1CKcijBt2
	 nH6QiWCUn5Ib+9YGVAToKQSLl34r3t9VOOZsaQ45usNwEMoqaSyX+6hN79+vpgkKZYQ8kJ6yhP8p
	 BBPGgtUpTw3R0hncGamGgRKXfw4RXetoQaEXaqyxXJ+QTp3ewNS45OATl17rvC7dv8Xk+FLlN97a
	 rBBAl0cRbIudRtWgBuCoBkZocIbCLUNbkde8vnLf8N8aJg8c0dtWgbwhzmv+RL7aIHnxS7fK8qvk
	 0Mv9GZd+JYimn2lWaH3IpuBjAle0D44E9ZoR31lD5wdy9AgbTw+NhD0y5KMQiJFcLa/WD9AwPA21
	 tdPBFztjzdGLqIHNtitlfd0X50mQ16chgEzX3JGozoeKUhEvAn1UG0w2tUBLh8xCIxP8fJht7PFj
	 jIBCldvooH/HZqspnrYnPSnhPDXiyPaiKR3qG64LcotdgBja5SNXX80aA8MWD3N6jb0wV7Xw/xvv
	 aEvub/DQy2nkVjCNHR0ouN8XUhyiL3COJXOw0bRKK7lZ2T4r7BhAGXi6vX70PiIMtMdqdyisnDfq
	 hrVCkg4P+iEGiQDboHCf6GKupVfbcO9qspvyb+lVGZA20thiOM0sHgRYzLYC9KbuUiobSiO1wOEE
	 MPCha3zJpRO3b7iG9G99GsDGrMVtkPElObPxkiz8xC7dOmVzQ82bY41OzBGsUc4bCIbbnkTlAHrR
	 dFCoV/FbmLe5QQE9qA2RpgLMJ7M6MMc9QIWNwCFUoi1Wrm8XtjE5W7QQ1r4vng2w==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+fd404f6b03a58e8bc403@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] kernel BUG in iov_iter_revert
Date: Fri, 19 Jan 2024 13:51:37 +0800
X-OQ-MSGID: <20240119055136.271506-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000007728e060f127eaf@google.com>
References: <00000000000007728e060f127eaf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test kernel BUG in iov_iter_revert

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 052d534373b7

diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
index 522edcbb2ce4..af8870145f67 100644
--- a/fs/exfat/inode.c
+++ b/fs/exfat/inode.c
@@ -534,7 +534,8 @@ static ssize_t exfat_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 		size = pos + ret;
 
 	/* zero the unwritten part in the partially written block */
-	if (rw == READ && pos < ei->valid_size && ei->valid_size < size) {
+	if (ret == -EIOCBQUEUED && rw == READ && pos < ei->valid_size && 
+			ei->valid_size < size) {
 		iov_iter_revert(iter, size - ei->valid_size);
 		iov_iter_zero(size - ei->valid_size, iter);
 	}


