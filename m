Return-Path: <linux-kernel+bounces-137052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F1A89DBA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 502BAB2777B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA41113540E;
	Tue,  9 Apr 2024 14:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="F5aKfgb+"
Received: from out203-205-251-88.mail.qq.com (out203-205-251-88.mail.qq.com [203.205.251.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD3C1350FA;
	Tue,  9 Apr 2024 14:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671301; cv=none; b=SmIPWp4dVnZAAiSX9L/rRQ99gAso2fyUXCPlFuKUkFmCHnxcdDS4sR12aOWYMI5EsSUx3D48UbTtJLvQPiMpz1eR6rHumNkciVeaZGiiqdvjscwu20uNwG6S8K3cg31gc7pkwQCfhi7ebHNRvOOyd2k7pVhnFx9nirGbpZghaVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671301; c=relaxed/simple;
	bh=vrPska5K1zP2GJf7AnCX/vaoifBTE5wptR6Hd3S+vX8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=S7QvPXXWPg1HFbY/Q0Ph4Yfvna5kaul9NhzxpIdg2vXItz+urdWhE/QRCGnr7fUdXKcurl/dwEM7Y1QYXUIgrHm06V8yfQC+o/wowqkJsuXK126n9FpNOdyW+Ffy/yzuACaxzNaVt0REau8esD1X+gym2d7AWTwQZCfP+BpkF80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=F5aKfgb+; arc=none smtp.client-ip=203.205.251.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712671296; bh=q+HKk82SsH0dAyp9pLgDNzM195MPqqeIgw9zov7U/8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F5aKfgb+C2UpLtDMyD6a6zNe7MmweGL9g13U67uQeS+zxtPuRAW7mY7Pc2OCRnPzg
	 f+uwNnObyI80vPhCunoO7v9qcgHk/uVJGr/F4HFdu6xd13L6CTvDVoKwlLVkW3A/AE
	 iPOEbnp6eeoVFKzS1VZkLTU1yy68+j/Z/2sNQm1M=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
	id C4C2C4BA; Tue, 09 Apr 2024 21:49:12 +0800
X-QQ-mid: xmsmtpt1712670552t9yjlm8rr
Message-ID: <tencent_D423A78448F764177A26CAB3716365096705@qq.com>
X-QQ-XMAILINFO: Nxcyh1H/Itmf8neWbaeeTpSXGHnSLvykyApNx66BdgHQr9/eu4JXvR/FePuH9h
	 GG66zyVWVw26sa5gRPr0mQfntrf/FaFiFPECMdJQfBV8LuTDipXZ5t4GOXSdpl9b4sZ3nNhReBuu
	 9soy1LxE7sEBNVQfYK/xS6AAOItwJEd0cblXxSvceeXNpa1/o29PY+YcHbXXovbe/kUY1G5uUgZ7
	 cFXMUdaTFSNnIl3LFk+5KPWn00VHNAot2kXLNDYoSujPD8nA0k244yeRI2HsoY/DY9GCj+x862e+
	 Q1B5GcSJpADiIUxcdp+jKwnRQS5aYgQHKQF5MhuzxCN2WRDk4r9YZSi3YKX0EcsRzU0CYYuUTG0T
	 klOyZS4ulGJls8keabk/8v25JOfH86TCo5GOixTtN218t0XJ2s/Vb2Ldl/3fCFFZZbdqEkL3kz+o
	 WkPXe/XYQzHZ9IMMYFi3I71sFPSFwpUFG4HuT0Zj+VU350zSMujMieslt/5k4oFbtdWn+7NqNA3/
	 i6iKJI3QQ4BAcC3JmIQ1s/AR2E8jsXpZg2u63juOjbmhrp3RDous/xtT9Pnex995E9nrJ6+zY7LW
	 HTbjchhSyViT1OoIPHBSIc1kq4OSWb+pJ2bejmaR2sv3ZyQkChQv3vM3/FSOTNzurutYrHaIthEP
	 zrlA0pqprVjWCFGB4dmUsBD97ZJoy1CldjHy6MTc7ISkxDeqTo8I/if+c87PDOHnTy0NoR8ES7Nu
	 DgVaN+wTUJbWdb7X+cn3+dEcjSuEtiyPbn3BfLCCdUjK7s81LgNZ/FtMwXacJBG5dASmUYy9xmGL
	 Es6cySL0qonoP+rNQyNAPFz7ouZTwe/XdI6hmoWHtovClCeaD1K7tj/JgjrDLr0NEZ+NTJokZIxJ
	 7kpV2qewswUwHrY+PNbvCxspAv5ijeWM1AUNPOb5YmDScfaPJqPL5PhS+F2dcM+j9qW7a3AXMFyd
	 yzOcxtVSZ2ySYnon0MnGu3kPpaCkli
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] Bluetooth: fix oob in sco_sock_setsockopt
Date: Tue,  9 Apr 2024 21:49:12 +0800
X-OQ-MSGID: <20240409134911.12995-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000b0848f061553f0d5@google.com>
References: <000000000000b0848f061553f0d5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If optlen < sizeof(u32) it will trigger oob, so take the min of them.

Reported-by: syzbot+b71011ec0a23f4d15625@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bluetooth/sco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 43daf965a01e..815646d9e72b 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -890,7 +890,7 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname,
 		break;
 
 	case BT_PKT_STATUS:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
+		if (copy_from_sockptr(&opt, optval, min_t(int, sizeof(u32), optlen))) {
 			err = -EFAULT;
 			break;
 		}
-- 
2.43.0


