Return-Path: <linux-kernel+bounces-162015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A068B54B4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E12D1F22350
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A542D2C6B9;
	Mon, 29 Apr 2024 10:04:45 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9702029421;
	Mon, 29 Apr 2024 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385085; cv=none; b=JQ7NNWQpYGdnw2PY3VoNjMoIpTm8z4T0wdQf8PriPvt/CaJnbzMXP2c+Oebs8sRmp63vhl9uRBNIPGEZZNJwdDKhzask+VZY/Igb27yEBFH+CguCyZHFVvmD7a12QnD9tyMTbCjIl5SOYjD/WniIXYIPrgm8P7q1sUpdHUQRAQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385085; c=relaxed/simple;
	bh=iv0of1SDuLM2j+lS8i9Lv/zFTg7B6r5cfF5tUfHgGdQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EAuv0iKYstykdOCmZyX7q2YeIsKWcRSkfxpAJ1RXiqxwnrjMl7UxTDfP9Fzx/C4boLQVoon4yk1afZ0VU4cRhihVyY9mxFJBROCKv20tTwgY26YJgCanTfNuyvFY2sqVVBm9LEa6JOun85uJn41wwKNAMI3oTTP3040l5sJv5Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a55b93f5540so565496866b.1;
        Mon, 29 Apr 2024 03:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714385082; x=1714989882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u871SX269932WaLaHJ9AhtcP7Cj5iBk3lhKgV6jUuqM=;
        b=fjfYm4am06ul0JfcU8kGDnRTV5v0ZtcmqmI4SVXjGkmHA/HUAMcgk3A+2RZ+PYs2Qe
         QtOKKtkdbTY/fNAxkMFfvk/leRRJJa1vMAEr/XlbWpjVaQx23ooOBgv6eod0hI+FZRYJ
         RWMx9o3wnjbFuyiNSk3qhu/8N5ZBaJxObaq/ZVMDemlbQwh/QzL9EZ8FvUkhJMaBRhBs
         NSZ8jwAKjaCsh0p3pHkAWYZelmWnOB+rZ2FEz9Vxg5QXZsVtPQaFpitgdZqsbadl5Au8
         1zsf/MziGpIh7I5x7F4yH/opZIOTah/xVU21OE524pGKTYenhy+pp2148AAxYJsNFbpJ
         g8+A==
X-Forwarded-Encrypted: i=1; AJvYcCWqzjnPBjCLk8yYCQ6PX1bEAU1Gf5HrS9CeZtNI+wLJtM9DMLZIGW7QVHxxF88rt5ox2SAfJoj0D+RP9TjIw/b78m4QA5pS2zOGfWw1QQHnwWOgbbSz17fAWOV6aSfhLTWgepvL
X-Gm-Message-State: AOJu0YzAgdmouwxi7wTYDJxVQkpNEz0zf4gh3QeRRDYWwEbYOtm0u72J
	r4CkBZ2GAcqKoglbZXxY5kPjgrU1NcTQWpsCgMkrxS52sSVF05ky
X-Google-Smtp-Source: AGHT+IFH+kBOBRma4QXn972uVsjWjU+aUIe0TKAfOhLbRNkOSO3ysqiqh8e22s8Omp0bk6BGAzSMww==
X-Received: by 2002:a17:906:7185:b0:a58:73f0:4d1a with SMTP id h5-20020a170906718500b00a5873f04d1amr6449916ejk.70.1714385081700;
        Mon, 29 Apr 2024 03:04:41 -0700 (PDT)
Received: from localhost (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id z13-20020a170906434d00b00a51e5813f4fsm13924963ejm.19.2024.04.29.03.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 03:04:41 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: leit@meta.com,
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] netpoll: Fix race condition in netpoll_owner_active
Date: Mon, 29 Apr 2024 03:04:33 -0700
Message-ID: <20240429100437.3487432-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCSAN detected a race condition in netpoll:

	BUG: KCSAN: data-race in net_rx_action / netpoll_send_skb
	write (marked) to 0xffff8881164168b0 of 4 bytes by interrupt on cpu 10:
	net_rx_action (./include/linux/netpoll.h:90 net/core/dev.c:6712 net/core/dev.c:6822)
<snip>
	read to 0xffff8881164168b0 of 4 bytes by task 1 on cpu 2:
	netpoll_send_skb (net/core/netpoll.c:319 net/core/netpoll.c:345 net/core/netpoll.c:393)
	netpoll_send_udp (net/core/netpoll.c:?)
<snip>
	value changed: 0x0000000a -> 0xffffffff

This happens because netpoll_owner_active() needs to check if the
current CPU is the owner of the lock, touching napi->poll_owner
non atomically. The ->poll_owner field contains the current CPU holding
the lock.

Use an atomic read to check if the poll owner is the current CPU.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/core/netpoll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 543007f159f9..55bcacf67df3 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -316,7 +316,7 @@ static int netpoll_owner_active(struct net_device *dev)
 	struct napi_struct *napi;
 
 	list_for_each_entry_rcu(napi, &dev->napi_list, dev_list) {
-		if (napi->poll_owner == smp_processor_id())
+		if (READ_ONCE(napi->poll_owner) == smp_processor_id())
 			return 1;
 	}
 	return 0;
-- 
2.43.0


