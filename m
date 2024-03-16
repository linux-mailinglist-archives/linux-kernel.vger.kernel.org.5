Return-Path: <linux-kernel+bounces-105070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF6187D8B4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 04:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B4A282A45
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 03:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EE04C61;
	Sat, 16 Mar 2024 03:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CFEMzqj2"
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8728F5
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 03:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710560977; cv=none; b=T0uxQmmXnRb0Jy8O9C6zHCSeWfY8SbghJw5l5S0nAahTAMW+FVDk3j2H7OvumymvqjEZ/o8BIaB6yqwGX7PJ2/nI5s/T3dDzdEIY4yA+r8aB5u3UVvyCjBj84d5wNsXdtOl29ANZrVqYSefIhALves3qX4VB82v6UEXUoX9kPLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710560977; c=relaxed/simple;
	bh=t2oYv+oCgSwacmV5AWUE4JhutkB8uzyh3I3aHs10y2Y=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=H1FQ5WIgrpXnkGs9n3U1un0f+iykETW7zEKik6sKojC9MBT0qL30t2UVsyOCrjPZigq05EKjee7cJ2Cpt6Y8iQoNmdz5/7h+W1rYSvYpJAusIljO3hRrQ01/Z/Qh1n6ubzTd6zjbkCzmcv0/FAph7nF359KLXjqgcKhhHf9wgIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CFEMzqj2; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1710560964; bh=CQqx1wQOCzwZ9sY1873cLSDFPdJh8bQU3tuOq3O8IpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CFEMzqj2KaM4Gjz7KudF8snxLtm0yZIjwSMOVCs70KRMbqcq4Wp/X4c3GsSWYxMtX
	 32U7M0rLhI49KNIbolXgL/TmiDc2aMBSZtMN/xlifS1Z4FUmeY8R2ofLgnqRjadSes
	 wMAo6FtOFs7RI1ZMIEaxFhSzXctnFgpjnk5PNTYo=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id C0AA54C6; Sat, 16 Mar 2024 11:48:10 +0800
X-QQ-mid: xmsmtpt1710560890tcok4o5js
Message-ID: <tencent_4DA6D5F366037E896283B2044DD771B76005@qq.com>
X-QQ-XMAILINFO: NZzGjqyvvdMfnz+W66/DnI0HgOndyIHZC4WUAqJaO4b6wgR9rr87S/Xt1tjtuu
	 HUYYDSa3k01hg40Qqrke+9Zle11VZuW4KlgYQHZmdx9PKcGiKnakhlTdjS4fDE0qAQFOaR4zsreR
	 5OdQZehb3q4aKm/8jO5duAVM0R5nUuFfnT70vMlUg6t+bqtTYFhYI6NZY13pp8PHFmlh8EN/c1I3
	 /zuG2gUmKk+s4NfsT46EtHpEsviQFNt/lv21Z/BH2JYRvc0wQ6iC6qmAWPacDxE2U/mnYfJZhMmt
	 Js/eH5BzCGpBkpx+nfI9vXqHUlNmRNebUwMxX/yXDtXMEJWphpcNPPD0bbOFMuLK7K2osswO9TLu
	 pWwhjEgScI93M8PMJTavw5L7MLFAS2aqVIfJ0C0Qy26rSf0v/O5u5rjOSJ0LlLkDoBT7MmKwp1P1
	 h+IuIuhuHlRihttqb6UYZB44Bq86QyDsn5WsUKcTVaZB3+MmKUxFzU77gry5zfAqZ6t89qXC12FE
	 sTJLLvznLT13ZIW5Jn6CiJlES1npEmqJDkHDcSOkNBRsJFtrV1Fbvz49Cckoeec+iMJ77Sgt2fC8
	 c95hPKEXdnoArc4DNRSXByBt8bfbgtfEgc8Ickusf6Qh7347eRKknsuAMKOukVy7qXx95b8Jk81J
	 FRWoPUzht/dAimRFfO/bovBnlSFByztiZrxxYczNO6BD48pjSEu5ULvGaBYg8gq8OufrIWSGXcDp
	 KLOVnvLxjUUN2NPjaD2QjFaITZxVMoU8FLzy9u9UCorsQSZnjfh4Z9qBJub07VZ0LyYQSTqj1ahb
	 Bf40iBSeJOnZJxr1XhN+7Yp47aLs+0xLf2poMLC6TBn6PIaeB1hyFR0dhHa6jv5Cxwj+z21YcQl+
	 3V7SfHUC4yjLcSX5m5nVBM+HMJCmR23BUm9rIvnV0063FTWYoHfuTZFzMCArirnx40PX1yFGQi
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_sendrecv_fail
Date: Sat, 16 Mar 2024 11:48:11 +0800
X-OQ-MSGID: <20240316034810.1179521-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000024b0820613ba8647@google.com>
References: <00000000000024b0820613ba8647@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uv in io_sendrecv_fail

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index cd9a137ad6ce..3db59fd6f676 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -1066,6 +1066,7 @@ static void io_preinit_req(struct io_kiocb *req, struct io_ring_ctx *ctx)
 	/* not necessary, but safer to zero */
 	memset(&req->cqe, 0, sizeof(req->cqe));
 	memset(&req->big_cqe, 0, sizeof(req->big_cqe));
+	memset(&req->cmd, 0, sizeof(req->cmd));
 }
 
 static void io_flush_cached_locked_reqs(struct io_ring_ctx *ctx,


