Return-Path: <linux-kernel+bounces-52398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9454184978D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 503A328CCAA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D414B199B0;
	Mon,  5 Feb 2024 10:14:28 +0000 (UTC)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB22218EAF;
	Mon,  5 Feb 2024 10:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707128068; cv=none; b=KK0HbdwJg5Y4miIQfk79bWDVwVvYsORRQocZF406VJcTjnB5SMBJmyDcjpYkU78HjOd2E9uwEumrAKMFAEYUCGJp60H5gtSnrZ9wmq+uGezMcuBhrKE7hoYosmIw8ak/fItNUdgEodWULFDeNxV1m1Qs19d0NV+fX3b7poVANsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707128068; c=relaxed/simple;
	bh=pyhHwuGV4a4jHzmBlR4WMUaIsHHf9SiAx4QOzN/KfSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lrc3qc59Rsj+rAOXh5T0JwAGRDroy6woBcHPiZdYkYOfoDrCl5lAwsP68Sq3s0M0nMMAMqtvlQyB1Mst3BTcoxsAj1AH0S1+/T6rFEbJJh/yplcrG4ldVLziYIje0dfaLY4xxWKXEulpUEAppgdjq86qQv+iobp1Xo2GI3jxxrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511531f03f6so436581e87.0;
        Mon, 05 Feb 2024 02:14:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707128065; x=1707732865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERt8CAj2aHxrr9ilindgG3aRIzx8Pbl75eLnGCCnEzI=;
        b=fklOLCi3LCL3Vo4iSzBAYKvErFKFS8Jed3sAinl65AY/t5UHm7zGztM7EkfU6Kr07P
         9Yeeckj0d63Mk4cijORMX+JCCSztH57x3UIG2GoHWr+bKklG6F+R/mUYOwRr+vSoH74H
         wSIg8Gsy8KTTHoSCksuKVUwYuV3bwP/We7YQ2pxV3bPPNBm8az0G+B/TeA3QavEo4EnE
         arPfyNOzqkkZL3fxxUvY0hwWG+vjtF0GK80FRI/xI0bejA2ZYcnnmWU55msTh2kgWtUv
         0vzgLtB/4rppQxYEEA04hMGUSTwYBLuyUt5vilr/8IzhFBnjDcSYrgu3Hd64LaC5qGFA
         Q3Nw==
X-Gm-Message-State: AOJu0YxvPN2IRXMPYgAQzyseoFveDxsViFp8uDJkXZWVs/TF0HK9E6xL
	n7dWYJDdg5e2PBe9KuLKAiIUH04/OGBu4kQmTFCCwcQ+BAGfJuX7
X-Google-Smtp-Source: AGHT+IGggYo7euWRlNpZgQvfxjq2DPzuhrwjnTnZbW+9naawGbCO8pPugBmb7T3+f8GCr9/qXLkYbg==
X-Received: by 2002:ac2:5101:0:b0:510:1b65:dd97 with SMTP id q1-20020ac25101000000b005101b65dd97mr7719914lfb.17.1707128064620;
        Mon, 05 Feb 2024 02:14:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWrG/4XSW35Te7GnwQmE6STz+wnwnpkI9P0xsRk26R2w5qoUpww2+iRAnWqwNpHF82/OXFsr34TLngSWtWKGobEb4AUUtJ2WlwYfAHX70F7d+Dq61btvbxeU9D1Idu/1f6apMThzCEOrPN8TbBR/4fkwbY0ZxfX/fV6Q9O2p2616595eJhflP/nbJ3C3bJMHUP+H+qMEcDfbUHuQLfJA96A8bIDLHOlEVqJHV/aQ6qjIBigtZ4qBuaWDrqK7tsAkg/xucDtBRZDkGSal8bnQp1GxrNBuU6ZZbEo52RZCqNI9Zj/2nRYzN7A0Q==
Received: from localhost (fwdproxy-lla-119.fbsv.net. [2a03:2880:30ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id kf17-20020a17090776d100b00a360ba43173sm4160841ejc.99.2024.02.05.02.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 02:14:24 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	andrew@lunn.ch
Subject: [PATCH net 07/10] net: fill in MODULE_DESCRIPTION()s for net/sched
Date: Mon,  5 Feb 2024 02:13:56 -0800
Message-Id: <20240205101400.1480521-8-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240205101400.1480521-1-leitao@debian.org>
References: <20240205101400.1480521-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the network schedulers.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/sched/em_canid.c | 1 +
 net/sched/em_cmp.c   | 1 +
 net/sched/em_meta.c  | 1 +
 net/sched/em_nbyte.c | 1 +
 net/sched/em_text.c  | 1 +
 net/sched/em_u32.c   | 1 +
 6 files changed, 6 insertions(+)

diff --git a/net/sched/em_canid.c b/net/sched/em_canid.c
index 5ea84decec19..c1852d79c00a 100644
--- a/net/sched/em_canid.c
+++ b/net/sched/em_canid.c
@@ -222,6 +222,7 @@ static void __exit exit_em_canid(void)
 	tcf_em_unregister(&em_canid_ops);
 }
 
+MODULE_DESCRIPTION("CAN Identifier comparison network helpers");
 MODULE_LICENSE("GPL");
 
 module_init(init_em_canid);
diff --git a/net/sched/em_cmp.c b/net/sched/em_cmp.c
index f17b049ea530..285b36c32c16 100644
--- a/net/sched/em_cmp.c
+++ b/net/sched/em_cmp.c
@@ -87,6 +87,7 @@ static void __exit exit_em_cmp(void)
 	tcf_em_unregister(&em_cmp_ops);
 }
 
+MODULE_DESCRIPTION("Simple packet data comparison network helpers");
 MODULE_LICENSE("GPL");
 
 module_init(init_em_cmp);
diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
index 09d8afd04a2a..cab43356824a 100644
--- a/net/sched/em_meta.c
+++ b/net/sched/em_meta.c
@@ -1006,6 +1006,7 @@ static void __exit exit_em_meta(void)
 	tcf_em_unregister(&em_meta_ops);
 }
 
+MODULE_DESCRIPTION("Metadata comparison network helpers");
 MODULE_LICENSE("GPL");
 
 module_init(init_em_meta);
diff --git a/net/sched/em_nbyte.c b/net/sched/em_nbyte.c
index a83b237cbeb0..34c6e8c8b695 100644
--- a/net/sched/em_nbyte.c
+++ b/net/sched/em_nbyte.c
@@ -68,6 +68,7 @@ static void __exit exit_em_nbyte(void)
 	tcf_em_unregister(&em_nbyte_ops);
 }
 
+MODULE_DESCRIPTION("Multi byte comparison network helpers");
 MODULE_LICENSE("GPL");
 
 module_init(init_em_nbyte);
diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index f176afb70559..7a89db8e5409 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -147,6 +147,7 @@ static void __exit exit_em_text(void)
 	tcf_em_unregister(&em_text_ops);
 }
 
+MODULE_DESCRIPTION("Textsearch comparison network helpers");
 MODULE_LICENSE("GPL");
 
 module_init(init_em_text);
diff --git a/net/sched/em_u32.c b/net/sched/em_u32.c
index 71b070da0437..ea32e4e12a99 100644
--- a/net/sched/em_u32.c
+++ b/net/sched/em_u32.c
@@ -52,6 +52,7 @@ static void __exit exit_em_u32(void)
 	tcf_em_unregister(&em_u32_ops);
 }
 
+MODULE_DESCRIPTION("U32 Key comparison network helpers");
 MODULE_LICENSE("GPL");
 
 module_init(init_em_u32);
-- 
2.39.3


