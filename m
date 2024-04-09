Return-Path: <linux-kernel+bounces-136972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED9A89DA7F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28B7A1F227EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037D612F598;
	Tue,  9 Apr 2024 13:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="mKlvC05K"
Received: from out203-205-251-88.mail.qq.com (out203-205-251-88.mail.qq.com [203.205.251.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE612F383;
	Tue,  9 Apr 2024 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.251.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669814; cv=none; b=P0aiCHV0tBs7u5EV8wbnvR4ztrM1EHTkj0dHwVF8uJofgvNNj/IfMevU9e5IGfRjYd+bHGBjObG3IY5HkcHdG+ycQpIcpP8rccHNumRkS9vzi2QQExpOObkotHe3Wn+ohluKojjnIKaoCV+bTRwbKMVvj3sK3rIO9PeDfsxYzgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669814; c=relaxed/simple;
	bh=xJnioWsnUb2aJTq/9yqZdhEhzZty26qDdXETzGekYrY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=r7ru1kmIOefPUtWpqTULqeflrAiSBy18QTsJKoeAak/08bktfqoNYpbPpNcduOs/VW4raC6GEt020PPGwp8FD617BMBiJ+O8jbGN5laQHUXDEfn85Qv5b97IxVpkJKixX5svdvNmAUMOLBi/AqkfouMh6/xtarC3pdZiRUIRTiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=mKlvC05K; arc=none smtp.client-ip=203.205.251.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712669808; bh=VpUFihplFUwAUwLRsR0jXNd3XDjzqAhsX1brG70mO/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mKlvC05K77QtgMBGZNmyIQFiwnqnbu2A1MkS4KWIbtn7msyVLk3RKjS0hpd+nb0pB
	 m/LQ03R8k+MrlCzVmNcXIwFzQitzRWIs65XaPFoZVZKNGyQji5xhghFa2jVmFMJStC
	 4poVsqFqkHY8SeQurjnFOpjBfTSot4MiHtcokO9w=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 92D9A04D; Tue, 09 Apr 2024 21:36:45 +0800
X-QQ-mid: xmsmtpt1712669805tn87rf616
Message-ID: <tencent_FE3C6F369E968237444B7E74BD7625670A09@qq.com>
X-QQ-XMAILINFO: NQp/UN4soYLT8h9g3LLmVERlb75kiJjq5zKBQzx4wEEUXZIv2lpvRXGLtohU65
	 QsiswKKgoKcMHIfPl4ZmGMH1lQVp1SSAmVitMUbNXLNZMGE7LD7nHGczWEH/J8cr/3cwoe0T+5se
	 JHWvZ/tIvdAFAgBTTqwIEpmbjiL6hV/UqOn4wXaw+JX+9+7ToU2zwKniMAO4iXz5wf91c6qXU9Ug
	 faxQ7r9BUvonlryz+eBtHhqkwdF2LcjM1Rr+eYIAkCTH37Sb1hDjM+9tAD6l7bc8aKTQDb+V4DtN
	 EPHYysALzbv8ZS1Hx/JbtUOdL9AzwdGKvJ/7+kC5DcY6Qh4m45nYPMtgxtDzNt61TMvV4i6nYrpn
	 e0jlWfblDyhLIohMH8A3JktpHF932beg3fIAh7yoocyaX/iW18LPFem9m6ODJ1EB7iPj3sj7IzfA
	 b14vcqwA5jaA3AvD8VtRRsp/V7E87LsIRHRsy5KdHiwTjPS5pw3vmw2s5PtSDCkJmFLykkwRlTja
	 N1CnuUOGhx++kSkWtFRuaEKFn4JPJfWm+tDXsSDkmHPfNC2iMMLZKYn4i12G3CBl0N4jMAyu5xHX
	 tfh1DYks4aSGX3h8CniFzUtB+zNV5PI0DPc1jeRQTow/G/CQSkSugNi7+oxEyzlCfoJJ59MS1Eva
	 Ht7Ke3YMk8t/nhyyQGiWR6PBLWJAV7HyNThrykanLv9Bzo4kXPSY+YtbyMeURrKU/BqPd0paFExx
	 zo6OKm1WYWVsMLDCALSc0yVPCvLltjjYM1ECcXlasQCcUQLa8ID0dRQ4p+PerTqrajWF23zEySrt
	 LaLcG1Qrwg4PgtJDwur/WU2ZGGNPm+kxaJG81gfKlr/AjWQB+elvLYB5O8//SviBHcsGLnlZumjR
	 PmA0/diXodXMXbiqUjlZRmapTbgpWnoQFEAn1Nxq9zdUPoQPrE4vrfzOD7q4pmrxv1hKP6fPxKY5
	 zP1BYgqnQAUNoLk1FrYi2Y/px+6bWX6kPyGUfERhFq/St3ItJpA45d4mVK+aOHE24C+poc2T8Pcz
	 hiTd5fWjNtS4LrUycj
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: eric.dumazet@gmail.com
Cc: eadavis@qq.com,
	edumazet@google.com,
	johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	luiz.dentz@gmail.com,
	marcel@holtmann.org,
	netdev@vger.kernel.org,
	pmenzel@molgen.mpg.de,
	syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] Bluetooth: fix oob in rfcomm_sock_setsockopt
Date: Tue,  9 Apr 2024 21:36:41 +0800
X-OQ-MSGID: <20240409133640.4190312-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <7cf0848b-f44c-42ad-848a-369a249bff77@gmail.com>
References: <7cf0848b-f44c-42ad-848a-369a249bff77@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If optlen < sizeof(u32) it will trigger oob, so take the min of them.

Reported-by: syzbot+d4ecae01a53fd9b42e7d@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/bluetooth/rfcomm/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index b54e8a530f55..42c55c756b51 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -629,7 +629,7 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
 
 	switch (optname) {
 	case RFCOMM_LM:
-		if (copy_from_sockptr(&opt, optval, sizeof(u32))) {
+		if (copy_from_sockptr(&opt, optval, min_t(int, sizeof(u32), optlen))) {
 			err = -EFAULT;
 			break;
 		}
-- 
2.43.0


