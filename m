Return-Path: <linux-kernel+bounces-41493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC9883F2C4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 02:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E21CB21D17
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 01:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ED91391;
	Sun, 28 Jan 2024 01:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="EDSQMY+3"
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A908B1362
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 01:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706405854; cv=none; b=VYNgylcr503K4emEHRKZD45MhSkS9A4un3fAbiFOGghO0iI7lF9VfLVfYaRpxPDTVXpW86EBkYwjD0IQ6qr6neK4EFUQvM8S0Ys1SXbdSYwGF4db6d9/eC+V2a0hfQwAq5Kar/Df82QTimrkQYV5q/gn2nv0erpZekmwxeWvNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706405854; c=relaxed/simple;
	bh=2kBtsAHcGo+dDFxY/4vpzOc76itTKsnN1c9OC8Pm3Tc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=d3QgnIRy1lkzA/4h+SBHOJJ84xpTSJGiejbt+xXfa6dwCEdncQQAeGCMwtyGjXuUwlOWheqFwKRh7pPRPAQn9d/r7ADUcIOPaQ6RJ7aJObyO4U7M4SR0Doo5lvZPDnho+oL9w1VjBg5ZE+RdOHHwwF2yRgXuA2PUYGjpahIPESc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=EDSQMY+3; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1706405841; bh=YtVIlhnqmy9Ds4w0FxnXRk+65dMQl/7vIBvEPPlF+d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EDSQMY+3G5dVAQRh54/mSeJag5K7HLA4cviNkqz75U9h6DXKyInK6Wy4sE+VE87zK
	 gMBmtDAT3o3mhvE9NeAlwIP0B3wY1CzccdhbDpG95F0N/SQc9Xcrah83rvwn4gw708
	 I3y2DNuFghxHJbZmRadkyW/ygV0Acu/i1qx/ME1k=
Received: from pek-lxu-l1.wrs.com ([111.198.225.215])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 7D2020FF; Sun, 28 Jan 2024 09:31:18 +0800
X-QQ-mid: xmsmtpt1706405478to78l5bav
Message-ID: <tencent_4A66EF6ACD6878526F542C2D6D109794E80A@qq.com>
X-QQ-XMAILINFO: NafziRg7Bx69+OV4WSENK3tmOcVjUGeMDta9wO2lFamB5ZcPFY097ckFwhMXQQ
	 nvmsJmfNWnojYUyqCGZYHZTsq/wLHkowEIUzRXJhXmx58U8f+oX1co0Z10j0EyxZqlN2AcgHCwGb
	 tmL4x1r5XSd7cajWpBjZWVKdY1LmRj3rqsnewOhyMGidchuWgKLVbSt8XQYqlqnVfJ3JLSNgV5sM
	 94zEi6M5c23tgnlhL07AvHn87QcYEkZS7YOLqkb4A1nH7e4WMrGYuw4T8a3aDkHfK8mXftQxMZc3
	 QeuNZYNcOkYWIHAOfpbspRtrtGAjfkUFmyaChdk9AuLQFKiZ8CDdfIFfpYSUnb6iDtItZ0AHfZso
	 JoL6W/mO8zu5E/42BgwI64bz9MJah1fnfyGR1L/eiVH9OgdQvVD323BF9fJMYz6ylEpKxRsXPcLG
	 1m+30/6W8XeGrDMAn/8PEZvIlZxzW6NipIwww+uYTH//wXnmOI0Dq6+FWqvboyWlGpC3vB7TbZcf
	 9gpVUMBD5q4ZCxnnGqT31F5Fq2qRWz8KXXOr8SSStElEcfgKjknwyJPwxCFgtVF59bnOPGOdWOQE
	 2Th4ktcVG8E3sISuEqo5RXhyKiLmuLNN6iQyXPH7UefEMNB3AeNo9mFPjlArqY4yxsUqbkra2zoz
	 wJ9yjvCwh0onc3n9YGsd2HREg2HS0ykwFVKVMSf+ecWYfItYdT2tfA/bfck57N1l59IpWE5pUyyW
	 iF6UGs4q0mMDQgbskLnXRBmnJqDEQGukqbOYaUx8AJwYMzyS0LFeMQMSyps4S49nADhx5DzrtMUq
	 BU64AoFoYHn2atOYW/hKyCrUWtoGO72tt2unlE38w0GrNOTAw9BVpY8of1BpKDWuOiCOOKxvsjT+
	 fu2QFU/OG+7Ef9xP4w/69c+Z41p6RcLdNB6Ah5BcbL+yqHIWmxj5nVbloyE0zkkHaRAbNh1akI
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
Date: Sun, 28 Jan 2024 09:31:18 +0800
X-OQ-MSGID: <20240128013117.1103304-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000ba736b060ff5da23@google.com>
References: <000000000000ba736b060ff5da23@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test task hung in hci_conn_failed

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a6fc8a2a5c67..2cc194ad37ba 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5338,7 +5338,7 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 
 	/* Check if the connection has been cleaned up concurrently */
 	c = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!c || c != conn) {
+	if (!c || c != conn || conn->state == BT_CLOSED) {
 		err = 0;
 		goto unlock;
 	}


