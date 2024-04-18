Return-Path: <linux-kernel+bounces-150606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F56B8AA1B2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E19CEB20D27
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196E81779BA;
	Thu, 18 Apr 2024 17:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bwu8kxmI"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F15E16ABE3;
	Thu, 18 Apr 2024 17:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713463159; cv=none; b=Fxz2veJ60RblGS3Jg5T5XeC/3cZPKOM0vKhciYamUFW6zHAQn6NRtzIqGow7ls9BXWDCnKocSNY5voLVn2bmjLpHHj1bW/eo+MSCe9og5fEksCVMM7djHyC+xNwZcToOpwoOOWMg/Vf03yCfaGc1bKW0vA3wLlRzx00Oc1jXH/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713463159; c=relaxed/simple;
	bh=h/nW+kruTWdp4SWOP6RcI1nNPO74h4z/FStukqK1vkI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cEk0PcYUnzTeZC/SR87h7y7Fpd0DC1Q3vi/oChHy7P4p94q27MrbqtONhsq+J1inwrfT2PdS0UX5TxKbaU/0xuJHIm/5bYL7ttwx2ZGdZxLwtsenLdKivWJLVZaLnyBzLztpe3Upq3HFdr/KLhWrxnYDlrFcBVK9e1kycUkLlhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bwu8kxmI; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so1198210b3a.0;
        Thu, 18 Apr 2024 10:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713463157; x=1714067957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OdF5x7vF8xwnkw2w5Ox3+BgtHbr4Ax47Y2qoa3FahQg=;
        b=bwu8kxmIpGMSExgbsTxJUcxmSyu2qDSeL5UuWrQDTVN8JqXu2FuYmIShBkTmBReENb
         gpqVWJUrbgZgfX3xgLF8R8VzRbeFg/HcbJsyVC3VtZ+tolrZ6gA+QCB0YFvMoN0+Zm0j
         LwXCT/fE537XzpbhgNP9h9zndNbuv7ZIeurL1ZbA7Ipb90F7GhF3b11jginyGvqoobuB
         UQg0tzL2pX/ZG0TcTiErtSFDOK4Coyiucj5No60cmTencGda6gh5tDj1LmZLvUQbtHg9
         orXPfXDjTRSNH1coyAnM6eZB3MGq+q3R9nhaiJyWL6Zb1fEAz6KsxFS9k79gsMzDufA5
         AZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713463157; x=1714067957;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdF5x7vF8xwnkw2w5Ox3+BgtHbr4Ax47Y2qoa3FahQg=;
        b=CfwJcPtYJfRpBf2w/UQjsk7hVvXQSszGCP9Y96jqtSFSiuPkjq+TPNalEKdKVAMuMk
         Sv0DfqM1kbGRe5vUmRoxRQG3w1+Jzf1NbaW0UkXNyhrklKfD8vuegf9j+wFxUd7tiCYq
         QTv2kkruEFSHH59xIPS01c9BukukweoH3EdnEIpgddy7LtcXzKopufeuSSQyNVO9nOqJ
         Bl20RnL0B1i0PMLTkBkzmfs87jFzvarJIvvk3D0cQ3tL7BO1V8KAlkmxkv2jBc5fLQg+
         EGVkSkxpxkbYptO8/XsKNPJk3SiHVqegPFCzx5FZU8DcOtME5PaGgwiHOhaPW7vClG2C
         O4UA==
X-Forwarded-Encrypted: i=1; AJvYcCW36ml/whMS43G7nhcw7UWVwmAVAt2q03qRqfBejXEAu0YAIsU4RceXwHlpl+fwMMVNH4Tmt+zC28yv8mNtGxgLauRYDRup0fPu9YH+cb9iMVppRB5zdl9p9fNEzQi1MsncdGif8nDEZyZD7poEahCHHz7DyGJnadXAzn8nr9+s
X-Gm-Message-State: AOJu0Yzwkj0m3gM3/Ylj62swR/nedoyzmf1YyDEslXb2xHBHTGiPeXpp
	w4HvMuK37WC4/xi3puhPE9pp5VhIkC3rWRQ5S/aSTRZ/0tRmc+1C
X-Google-Smtp-Source: AGHT+IFqH+guHGlcfs13QIIC4MHTvQXBK2yUOp2fQZAETdpd0omktYoWkPOoaUq/hjldeBnYsl53jw==
X-Received: by 2002:a05:6a20:da84:b0:1a9:9cbc:4daf with SMTP id iy4-20020a056a20da8400b001a99cbc4dafmr4484441pzb.27.1713463157437;
        Thu, 18 Apr 2024 10:59:17 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id c18-20020a63d512000000b005dc49afed53sm1735229pgg.55.2024.04.18.10.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 10:59:17 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: davem@davemloft.net
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-ppp@vger.kernel.org,
	netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+393d0ef63475d9bb1f16@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] ppp: Fix deadlock caused by unsafe-irq lock in ap_get()
Date: Fri, 19 Apr 2024 02:59:10 +0900
Message-Id: <20240418175910.7641-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


read_lock() present in ap_get() is interrupt-vulnerable, so the function needs to be modified.


Reported-by: syzbot+393d0ef63475d9bb1f16@syzkaller.appspotmail.com
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/ppp/ppp_async.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index c33c3db3cc08..dc1d4633428a 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -133,12 +133,13 @@ static DEFINE_RWLOCK(disc_data_lock);
 static struct asyncppp *ap_get(struct tty_struct *tty)
 {
 	struct asyncppp *ap;
+	unsigned long flags;
 
-	read_lock(&disc_data_lock);
+	flags = read_lock_irqsave(&disc_data_lock);
 	ap = tty->disc_data;
 	if (ap != NULL)
 		refcount_inc(&ap->refcnt);
-	read_unlock(&disc_data_lock);
+	read_unlock_irqrestore(&disc_data_lock, flags);
 	return ap;
 }
 
-- 
2.34.1

