Return-Path: <linux-kernel+bounces-58368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D684E556
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1F261F21723
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331E912838C;
	Thu,  8 Feb 2024 16:43:12 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125237F488;
	Thu,  8 Feb 2024 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410591; cv=none; b=NBErqsuS/P9+pXUdfVrzGltzJ/sEip5IIBXfnc01uagfnpgL+RslrEp6dwyPWXhRCokpjvFZlJIu5+kdk7+upl2sXodIDXyxTfp3YMKnigeC1z+oeHNlNzhKbFuv3cXtFyc24SYZwI4JN2Dzj0IvhnKesxS76C7mTLHgJPeGnn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410591; c=relaxed/simple;
	bh=M22ZHDmZSNfVq42V0KKc3O9NiBww81GFILhYxzrgvdA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nQN6AgYYKvtMGB2DiDfDxsBqKM4tbLLgcmISEc4ze25WKSYXmTxA1ABLkvC00hYEvffuZX1/QQ1o9KPqy2HjK0u9xKgXVdzPXORYWy++K2sMcp0EZykOzOV+YWlGrp7P5k+PrsrqENWmPMqm8lJxTPEi14s2Q7QTZJUAKF+4ySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3566c0309fso248162666b.1;
        Thu, 08 Feb 2024 08:43:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707410588; x=1708015388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=thJ3B9UkQOs77FiMZVfUn7oLhfz0psP3bIZ7qX3TtM8=;
        b=UiscqErGX+QBadliLbbgQmZrICp1zU1U7BWlcX5iRyokJ5xsFxwp9oPmM1Q8ybGGNE
         wI73Q174oneRLeQ2QcvcYkdsmP5B/ssvTq5W6D9tyB+TVhNnisx2OY5hOQ+arsRdmsVc
         N4qZtjG/qr6Q60S3ZxvAqyB54Tao4Mg2I1ztOQQs9O4hqKUBNyKPNapb0Eckj0UzJIW6
         AYSKeCZlUr0MC2jTd76I0XAAVbL62Yvu3/z0LxvbkoLFp+whpUy/3EdIZ9vjgQrns8Eb
         zxk0QLIyZbiSy2/VdXyI771ZkAOcY7pcKkjH+9935LiWLkXBUKFy2zU4iqYnwK4oGTCn
         vrcQ==
X-Gm-Message-State: AOJu0YztYbJ+13uqvDs5kUz8lB78oJ2gFVt0kQM4lz/LTcuZo+62reiu
	z2ASfu+UnomccnNys2cioA2FXwMRyf8We3QRP0Zf63wR8IM8/JuO
X-Google-Smtp-Source: AGHT+IE/XS5P+gxYvQrOR+5RG98mxEKDGyiLIr0A7CYjIZqT7S5BLb+Vf2i5BIa2FaXnd6tDS8IVcg==
X-Received: by 2002:a17:907:75d4:b0:a37:b590:c15b with SMTP id jl20-20020a17090775d400b00a37b590c15bmr5676605ejc.65.1707410588208;
        Thu, 08 Feb 2024 08:43:08 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkQBizbKxBPcm8buF964sV0gY9Cb45wRronOSwVOo6/llJDesPnlc+jsPu6RT5iZ5/+oILeFtSX6pcLEvASuMc0RaOFm1uCgRDxVxFHd9RKt00loclJonl78YvUFxvHPKkfSgPR9TvDumgkIHNUG/JBPlj4XNA+agXvwHOR6N7ZEF1u/L4OYHjJ81NwDrkq2/S7eNleIGKwk49t5phQZbhHeeSJm0ERPGRvEGH+Qxxv0aZcA0KX53Qk1gHBX5LEduGKEtv3CkTlVHVVE3jFAnmo2ObnBhQwo0y5bfyVkToQmeQOf80vyNrD7h8rGBuYUIDXmaeZsksfizgEdpjugM=
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id gz8-20020a170906f2c800b00a385dd961bbsm216848ejb.192.2024.02.08.08.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:43:07 -0800 (PST)
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
	andrew@lunn.ch,
	f.fainelli@gmail.com
Subject: [PATCH net v3 7/9] net: fill in MODULE_DESCRIPTION()s for net/sched
Date: Thu,  8 Feb 2024 08:42:42 -0800
Message-Id: <20240208164244.3818498-8-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240208164244.3818498-1-leitao@debian.org>
References: <20240208164244.3818498-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

W=1 builds now warn if module is built without a MODULE_DESCRIPTION().
Add descriptions to the network schedulers.

Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
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
index 5ea84decec19..5337bc462755 100644
--- a/net/sched/em_canid.c
+++ b/net/sched/em_canid.c
@@ -222,6 +222,7 @@ static void __exit exit_em_canid(void)
 	tcf_em_unregister(&em_canid_ops);
 }
 
+MODULE_DESCRIPTION("ematch classifier to match CAN IDs embedded in skb CAN frames");
 MODULE_LICENSE("GPL");
 
 module_init(init_em_canid);
diff --git a/net/sched/em_cmp.c b/net/sched/em_cmp.c
index f17b049ea530..c90ad7ea26b4 100644
--- a/net/sched/em_cmp.c
+++ b/net/sched/em_cmp.c
@@ -87,6 +87,7 @@ static void __exit exit_em_cmp(void)
 	tcf_em_unregister(&em_cmp_ops);
 }
 
+MODULE_DESCRIPTION("ematch classifier for basic data types(8/16/32 bit) against skb data");
 MODULE_LICENSE("GPL");
 
 module_init(init_em_cmp);
diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
index 09d8afd04a2a..8996c73c9779 100644
--- a/net/sched/em_meta.c
+++ b/net/sched/em_meta.c
@@ -1006,6 +1006,7 @@ static void __exit exit_em_meta(void)
 	tcf_em_unregister(&em_meta_ops);
 }
 
+MODULE_DESCRIPTION("ematch classifier for various internal kernel metadata, skb metadata and sk metadata");
 MODULE_LICENSE("GPL");
 
 module_init(init_em_meta);
diff --git a/net/sched/em_nbyte.c b/net/sched/em_nbyte.c
index a83b237cbeb0..4f9f21a05d5e 100644
--- a/net/sched/em_nbyte.c
+++ b/net/sched/em_nbyte.c
@@ -68,6 +68,7 @@ static void __exit exit_em_nbyte(void)
 	tcf_em_unregister(&em_nbyte_ops);
 }
 
+MODULE_DESCRIPTION("ematch classifier for arbitrary skb multi-bytes");
 MODULE_LICENSE("GPL");
 
 module_init(init_em_nbyte);
diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index f176afb70559..420c66203b17 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -147,6 +147,7 @@ static void __exit exit_em_text(void)
 	tcf_em_unregister(&em_text_ops);
 }
 
+MODULE_DESCRIPTION("ematch classifier for embedded text in skbs");
 MODULE_LICENSE("GPL");
 
 module_init(init_em_text);
diff --git a/net/sched/em_u32.c b/net/sched/em_u32.c
index 71b070da0437..fdec4db5ec89 100644
--- a/net/sched/em_u32.c
+++ b/net/sched/em_u32.c
@@ -52,6 +52,7 @@ static void __exit exit_em_u32(void)
 	tcf_em_unregister(&em_u32_ops);
 }
 
+MODULE_DESCRIPTION("ematch skb classifier using 32 bit chunks of data");
 MODULE_LICENSE("GPL");
 
 module_init(init_em_u32);
-- 
2.39.3


