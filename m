Return-Path: <linux-kernel+bounces-136294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD6289D253
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4885D1F21AA4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBA8757EE;
	Tue,  9 Apr 2024 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="mBd5Jynk"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B66A8D2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643881; cv=none; b=DOcyHOwDrXLBX/dbKAB0LEK2cIgoK7urL1ugSoIwjPaLi27QhH9G3FQ5GVH6odQENp/yEnl0ZYrJupTZ8xzVf4RDDZrh25V+ksPM4yIIoEzMkz5qD9JThZFh65anmNNnjnZzcjfgTy4kdFcd+P18/H9V/It6GCMlhnIo8BWzzoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643881; c=relaxed/simple;
	bh=hVKnFrLXVZo8p+orNJL7U1TZAHHwpoF0x03Pjb20TCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmpCzUv97jHKCnxhLGzpKgI3FwggdR1TZ3hVgTI+TFPsPR0pCbOAcJb5IpFJjjrgywqo0+5AKf/RANOabNsV0Xkq0EyqKh0tZ8kyD1t1nd5iJQ+XIppV8memNMThscBp+6QrJzWRcLRs5ThZ5Q18Hn0PoFCZZ/2jl3nVnF9P7JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=mBd5Jynk; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2a55a3d0b8eso682352a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712643878; x=1713248678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g6D3U2MYkd4kdAs30T5VMng1DzF96mHXquQn1nVv4ZA=;
        b=mBd5Jynks25yreFEZQWRSRjY4Yem2lFqSfqIGYy0OCXwL893b8UT4dUwOPCIfeVDyV
         UWk5epMxi0vV2t+xVtC1BzqzcFg77xGdCC9+kqSld+KHqeZMzaO8JWMrvzVJHUECm/jV
         saTwn0xvhSemn3RlvwF+Bc31JQstmHm8HaXk0wUwU3MaIBWE4QgrmbuWvu71BfWsRisd
         FX/vUhWWB5aPtWiM/2AU77RdLsDr4pE2qW/skyBzyTnsIqiEsYWSeHONrSYbjn2l5rgU
         0UYkewDzMuYF4COYfEmLr2pDjkMMauRLeJEw/QFGwR3B7G0joa2BLHn/G8eg6Z7K0n8z
         bF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643878; x=1713248678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6D3U2MYkd4kdAs30T5VMng1DzF96mHXquQn1nVv4ZA=;
        b=BNFHwtuIlp68OLCvYjpm9j81ods38sTxzCmgHd4Mg3VocFKuUNK1pn64HTF7dW0rEM
         xlKVPDv58yZcOzFTk5z9BiDRE9PUlL+aKgupHz89Fpol04mvhxqHGT46et2D78r4z81a
         +VhlE9k9Fp6F1nr83AasWNrd6O62i1JEgcoLm+b6ihi+tFMdPquXyDAH2sOi0xE/frMR
         ErhyeTS+didjZexWUzOhuupiEGcGrCV9YUOozpZl/LxxViplRWn7iEdXiE9HjqlpwFMz
         kQW/jWyVPREFzBnmeimEMwcF3pF/9dtvbXyKTtFrW/Fmdi3P/KzVZHVtHBmPYGNkdSEW
         sz9g==
X-Forwarded-Encrypted: i=1; AJvYcCXe5pMKHszDirYX7AvGMq3Sf5wsyZuEjX6/SQzF6AzQCJCae2vUcpfwelMzZUQngQl8fBjC/Ult3Cbhqc0P9fiBGNU5lG3xYSimu+LW
X-Gm-Message-State: AOJu0Ywl6hRhQX2frCAWwWscygzhakClejMeuo0bYsvo0VnmUXz6t6zC
	BgG378qnTf1Y2ZjisYA+RriYOtzutEY06RipjrC/Y08ZgmRp3FFdGspcoUccSp0=
X-Google-Smtp-Source: AGHT+IHk8SNceULlelSKpjfik0Ixk4C2Iug/nD5xWOoL0/StFu5CRaSBKWkAto4Tbf41CVCY5kkl2w==
X-Received: by 2002:a17:90a:fa92:b0:2a5:3c66:25a8 with SMTP id cu18-20020a17090afa9200b002a53c6625a8mr2754090pjb.15.1712643877210;
        Mon, 08 Apr 2024 23:24:37 -0700 (PDT)
Received: from localhost.localdomain ([8.210.91.195])
        by smtp.googlemail.com with ESMTPSA id h21-20020a63c015000000b005b458aa0541sm7372906pgg.15.2024.04.08.23.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:24:36 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lei Chen <lei.chen@smartx.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] net:tun: limit printing rate when illegal packet received by tun dev
Date: Tue,  9 Apr 2024 02:24:05 -0400
Message-ID: <20240409062407.1952728-1-lei.chen@smartx.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_worker will call tun call backs to receive packets. If too many
illegal packets arrives, tun_do_read will keep dumping packet contents.
When console is enabled, it will costs much more cpu time to dump
packet and soft lockup will be detected.

Rate limit mechanism can be used to limit the dumping rate.

PID: 33036    TASK: ffff949da6f20000  CPU: 23   COMMAND: "vhost-32980"
 #0 [fffffe00003fce50] crash_nmi_callback at ffffffff89249253
 #1 [fffffe00003fce58] nmi_handle at ffffffff89225fa3
 #2 [fffffe00003fceb0] default_do_nmi at ffffffff8922642e
 #3 [fffffe00003fced0] do_nmi at ffffffff8922660d
 #4 [fffffe00003fcef0] end_repeat_nmi at ffffffff89c01663
    [exception RIP: io_serial_in+20]
    RIP: ffffffff89792594  RSP: ffffa655314979e8  RFLAGS: 00000002
    RAX: ffffffff89792500  RBX: ffffffff8af428a0  RCX: 0000000000000000
    RDX: 00000000000003fd  RSI: 0000000000000005  RDI: ffffffff8af428a0
    RBP: 0000000000002710   R8: 0000000000000004   R9: 000000000000000f
    R10: 0000000000000000  R11: ffffffff8acbf64f  R12: 0000000000000020
    R13: ffffffff8acbf698  R14: 0000000000000058  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
--- <NMI exception stack> ---
 #5 [ffffa655314979e8] io_serial_in at ffffffff89792594
 #6 [ffffa655314979e8] wait_for_xmitr at ffffffff89793470
 #7 [ffffa65531497a08] serial8250_console_putchar at ffffffff897934f6
 #8 [ffffa65531497a20] uart_console_write at ffffffff8978b605
 #9 [ffffa65531497a48] serial8250_console_write at ffffffff89796558

Signed-off-by: Lei Chen <lei.chen@smartx.com>
---
 drivers/net/tun.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 0b3f21cba552..34c6b043764d 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2087,6 +2087,7 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 			    struct sk_buff *skb,
 			    struct iov_iter *iter)
 {
+	static DEFINE_RATELIMIT_STATE(ratelimit, 60 * HZ, 5);
 	struct tun_pi pi = { 0, skb->protocol };
 	ssize_t total;
 	int vlan_offset = 0;
@@ -2125,14 +2126,16 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 					    tun_is_little_endian(tun), true,
 					    vlan_hlen)) {
 			struct skb_shared_info *sinfo = skb_shinfo(skb);
-			pr_err("unexpected GSO type: "
-			       "0x%x, gso_size %d, hdr_len %d\n",
-			       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
-			       tun16_to_cpu(tun, gso.hdr_len));
-			print_hex_dump(KERN_ERR, "tun: ",
-				       DUMP_PREFIX_NONE,
-				       16, 1, skb->head,
-				       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
+
+			if (__ratelimit(&ratelimit)) {
+				pr_err("unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
+				       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
+				       tun16_to_cpu(tun, gso.hdr_len));
+				print_hex_dump(KERN_ERR, "tun: ",
+					       DUMP_PREFIX_NONE,
+					       16, 1, skb->head,
+					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
+			}
 			WARN_ON_ONCE(1);
 			return -EINVAL;
 		}
-- 
2.44.0


