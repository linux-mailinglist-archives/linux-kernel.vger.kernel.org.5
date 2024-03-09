Return-Path: <linux-kernel+bounces-97908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE2E87716C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 14:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 264DF1F21746
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 13:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7225F3C467;
	Sat,  9 Mar 2024 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="AITJw5sn"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023501BDF4;
	Sat,  9 Mar 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709991334; cv=none; b=nPmU6VE+XGbCSt3gbV7GORH5FgKJEaLOS/1kBqc+PUtaxBFifNKZYVUN+HZLx5cR6Pu/2RnwKdiIzY64KuUVajjAbZ+OfaAkMd7vpYMKzuz8SV9ENZdnlOKBj671AbtGAhH8VLavWsMP7cSYo8mKbQFFKGUc7pS58gkzytQDpDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709991334; c=relaxed/simple;
	bh=i4kQuAnoQeqypHuwMZ5OqixyBUFX6jZIIa7F8n2+mkU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=oRUBI+EmY1k3wV3/LlCTYAK1CcT6rLp99UL1d6Wdh/LDSW/HMioMISnW/kWp/DtL+sB0Z6fCwxZCT5HWMsSH3JP9C9EXLO9MBje+/06ObgdRr/LZHSiuyp1EKDCaMc7LJBZAsy/lf6wn4rcABxbHztYf6ZY6K4fqBQ7fwlw27Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=AITJw5sn; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709991319; bh=JMJZZGhWptagNBPaY3ce0VzBpB5bhSnhY8q1A69wfqY=;
	h=From:To:Cc:Subject:Date;
	b=AITJw5snACaYV5znEiAektOXX8O4Da0g2VuVbaVAfnc0fKDRrNH8pjqupHsR7jcn8
	 Y4laKQM+MFE3acqtFwlOmv+m+YsKVAvrWcmu6+i7qcZaLfmWEzNlZoGp5ntcp5driS
	 /tAZaXNTMEkcyoZdo4DFMelSp44xpnQfWkFCTM+I=
Received: from localhost.localdomain ([58.213.8.163])
	by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
	id 8CF87847; Sat, 09 Mar 2024 21:35:15 +0800
X-QQ-mid: xmsmtpt1709991315t3dwksqcz
Message-ID: <tencent_DC4901C65DB41D86CD613F3ACC41EA143808@qq.com>
X-QQ-XMAILINFO: NvH2zBBgt3uT+kfoe/499o2G21ybEH6CIxd21cVVkXPbT/F/r+w8/YH+9VZgrL
	 MqsAtBLT0sFgV0dUTf8JJ932HwN45u0yIjh1k0VPIduK4hFIZaukEFYWuRd8FxzOUJZOhDUMbkgJ
	 qhZ/TGPRrryANjn9fIUIgq9ucdOL1pLT7QwM5w1UZE6TUiXucuX9JWK/giiHD2oU3DKXlFsLN/tI
	 5Nn5Yc91wl/mStke/F3i5QDaD1SJ/UK6vT7hRY8gUUdCBAkbA5TajnTi6FSRJRG2DqYznfja7hqY
	 ZXY/aEWlxzBjUbKiqDOFXxSd8v0zoTKcaVU2D83y0HDxWVO/nKVkWaJMTENfpiUKF/6c8VdaP1zP
	 A8ix2sqYYy3oTzUK4c49e8uo7A0xTfx/AL7K/JHSB2hFiE/cfqeGk3R9ALd+4mHmevCfjQrbzNCX
	 DZttcjGb8kI//vx8XqIAOldipwg2VMMfcbIbwrw5i5FfiHEFcE5q1LMxLtZq3mERSkoSqE5JiWwt
	 0MJJLj89XfHq/4TonNctw+XXJCqQ7F8z8J3D3hxPueK5gas8gaXeSQQ2mJojRwN7YjHnTXqDbpCq
	 wCTyoxNHaaDRRuNS7VRfrLeRbAZ2KUM17CieqwXftpHYeAHIZdVAZoGNuSMKRpds4vKsrPvEGv36
	 rFniflqNSXzUcFwqQB0cPm+01FTetN4UEJuCqaT2yVO4nfSmVhUPLmd2vKrD5w4pwYwbM1bmTJyB
	 PNpwlDvvwX2VJTII4v50D0Nrf303ZUkwBpdv9Xpds4yyTe/x+mQzxxqixzGJMxtEoH1VSMdKX//6
	 eTYU+g9NVVmPZ0UukOVZNkqSJZt7jbrL66Es3ukLpu2SJH3gmpxLtBiyTTD2RtscBPsCidYN/cY0
	 tLdAIt2HtMkFPQhINIBOg0FgyNhRh8wRdDqDloYcNx8HGJ4gX3QTjWduSE+PmKwIHnepCZyZy5dl
	 hb21oXZeZOUQMeQrM5d6PECYjQjQbtI+aJsxjOnYiaBFo6PUESJ8m2vWrYDsSoy1X2ogTerg4QLj
	 8u+31VZrkEdOLcSgkwkrRUCUA2K+d5t00v2byNtKDYAS/jl0ZdITFH0M/3Img=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: linke li <lilinke99@qq.com>
To: 
Cc: lilinke99@qq.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	David Howells <dhowells@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: mark racy access on sk->sk_rcvbuf
Date: Sat,  9 Mar 2024 21:34:40 +0800
X-OQ-MSGID: <20240309133444.56863-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sk->sk_rcvbuf can be changed by other threads. Mark this as benign using
READ_ONCE. 

This patch is aimed at reducing the number of benign races reported by
KCSAN in order to focus future debugging effort on harmful races.

Signed-off-by: linke li <lilinke99@qq.com>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 5e78798456fd..4c5524e70534 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -551,7 +551,7 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 
 	skb->dev = NULL;
 
-	if (sk_rcvqueues_full(sk, sk->sk_rcvbuf)) {
+	if (sk_rcvqueues_full(sk, READ_ONCE(sk->sk_rcvbuf))) {
 		atomic_inc(&sk->sk_drops);
 		goto discard_and_relse;
 	}
-- 
2.39.3 (Apple Git-146)


