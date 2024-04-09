Return-Path: <linux-kernel+bounces-137019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 709E689DB2F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A591F21AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A6512FF60;
	Tue,  9 Apr 2024 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Td6C2W+p"
Received: from out162-62-63-194.mail.qq.com (out162-62-63-194.mail.qq.com [162.62.63.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9751812F378;
	Tue,  9 Apr 2024 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.63.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670268; cv=none; b=Y/Jm2Ryd/ojaqsciFzqOAYTNa5X5BR3vXlCK+7jLoCcDntIIADPOGsKeHZXn97/rUp6fsnVd3E6aICH/kjIk/NeWrb8J/oVaPc0VxCfHScIRC3eCUMnp/f3CZMvmRYkAsFWQkU5FhSBscd+4BwhcHy2D5UpYOyWSrgmmO+XMmg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670268; c=relaxed/simple;
	bh=/kxZXr+rwuZWsLpAl0SSYwp1srPD3nqS4ULZVWAuf8k=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=dIt76et7EEqLBftYxYnbsX7KnKajy5nB1wWjnE45bCGk/AJTdjvCoQ1hSfV5hhfYq/TbJnSMeeC5yK7BvlsLTWPkFbIMgJlSFZTo8G49G8vJNe+4d6WaSTAPAyzXqh6IfGEuKlTAlVO2RA2szjHC/GVlbEoNUQRDOhkj6SZ0SIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Td6C2W+p; arc=none smtp.client-ip=162.62.63.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712670258; bh=mV+2uXEU0mxyaFTSC+dqJ7oImfFIcAAupTtNJvfgJYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Td6C2W+pebgIe4I12hp+cKrXcRfD/tNrb6/WJ0wRlrtl5RwOT+TsnPky8kEafErPQ
	 fCzNkZ47jO19lUSEqk+vJE9MswA68HnGSzY6w0rLmO0PfSPrCoZYM5J9SOYNZyDuwG
	 //j0JlKmq406vNRMAgosdznENIhY5hIAOH7X7leU=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id AB23389E; Tue, 09 Apr 2024 21:42:50 +0800
X-QQ-mid: xmsmtpt1712670170tkjmb0sae
Message-ID: <tencent_EDCC88A7DB46D3D2F7C64449976EC56EE006@qq.com>
X-QQ-XMAILINFO: OCYbvBDBNb9rerlANBwTUHLlLdyj8SmQAzuXuPK9Ob3UVeMTOUlb2KXNa0+x5z
	 CriuoSgInpV8P2aXGt1YyYfx154hu2f1Yvlydw6FtioPyI9zqjDX7GfWc6eCcYz88908p6Sn5al2
	 bsnAegt/UzKNcGgnYJyiHzszdulrN2bIfan6CEK2brvGFI8AKYGffxhlLLgSvljvPbogo3HdKE2g
	 bkCeVoeGCF5wnTK9NkLVUhPnLOAy8hAnbzMQC5imHkST880ZuwsqCFT86XnKRYpuLdvbl65piPrA
	 iH4I/80v3ALIHlCI/zdisN+cTQyyKOLt4axc2v7GevNjzluOjamKO8gxjC/tYO1qKUOHA7jYAm3J
	 t8heAypBDIdCLKlrBy8yqajqfkZQjIlsv98Rqx1WQGcRfF5j9NqPuxIXsHre22hnTX6zArERnmi4
	 o4hrfC3j2daxLqTgwNR/3NmpuqI95ICUa8rc3uqj5FyQwfhOYHklKbxxBje3dv+dEzRh5PD7uwiD
	 pAKRsXDHlTl69FssNHh9xQrPHoR3MaTUtkhxWqDVl151sK1HH7lRqjvzxj+Yza5KhoHCOJS4fmP0
	 KuemLKhoi6X6Hede9Pag0GlEsZxbSZtVIcL6oXth27WyXTU8Thncq9K4u620biye4mOADV3Rffok
	 OZOGhmLz14NEY9+hEQVGluKVONp1KhMmQDEfUJCzUij2osiB/WLsqpxO3qawDOexVgFquXeDGYYV
	 hpXuLwstk2JAOUV+HIzBHHRkhiHdUWyrc0gJYDFLMpQ/GY8e2q56iJJtPZxQ3uxAp676Tfjyr3V/
	 v/0wDr1qScqyah7gCUeAgHoewwDNc2PDGd/SRQ0imyaFqSltV+7cqIiZtR351mZFMbEXQOqgETk/
	 v4bYcMGTWKm5GvB7jOkjejHb0zKtG8XX/ZOnlDnJL/pVU+a8C330cIGs0NinTbNqoFuuV8PcYh4A
	 bQPfsAuc6VSjSSivdBuZlPSuP5BSZm0C+sdLhmCp5SDxs5GYdJZM3RKvodBZLS
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	syzkaller-bugs@googlegroups.com,
	netdev@vger.kernel.org
Subject: [PATCH] Bluetooth: fix oob in hci_sock_setsockopt
Date: Tue,  9 Apr 2024 21:42:51 +0800
X-OQ-MSGID: <20240409134250.1414-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000007558ae061553f41b@google.com>
References: <0000000000007558ae061553f41b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If len < sizeof(opt) it will trigger oob, so take the min of them.

Reported-by: syzbot+837ba09d9db969068367@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bluetooth/hci_sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 4ee1b976678b..cee7ec1adbd2 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1946,7 +1946,7 @@ static int hci_sock_setsockopt_old(struct socket *sock, int level, int optname,
 
 	switch (optname) {
 	case HCI_DATA_DIR:
-		if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
+		if (copy_from_sockptr(&opt, optval, min_t(int, sizeof(opt), len))) {
 			err = -EFAULT;
 			break;
 		}
-- 
2.43.0


