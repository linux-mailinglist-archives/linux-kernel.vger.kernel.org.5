Return-Path: <linux-kernel+bounces-56305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDBA84C880
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9EA1F2179E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C343C481;
	Wed,  7 Feb 2024 10:19:58 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D273BB5F;
	Wed,  7 Feb 2024 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707301197; cv=none; b=trsM10C0tw43XybT2ldzOb/vT8JNUGU3PE+k+8WcIWNUeSrGOERdjy1m6Y1eRO1+vjRT8zDaXjwvNwXfR5n/z7Cm9gXkC9RpIwDSzA7IOhi2mnggb/FTqGZAKpTS83OpW7T7k41ebF55/M0fM3KujAie4QPU2cpoTX+rIyw21ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707301197; c=relaxed/simple;
	bh=pyhHwuGV4a4jHzmBlR4WMUaIsHHf9SiAx4QOzN/KfSo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qu3uI9r8EndEuTdLDKxoAzRn9jYEsQb9MMk954rEXWYMa+zMjQck5Jg6uR/AzR7si6HGfZKDHO+hqIIc9ooVU6Mv8csC1Vny/Cdc+SG2EcWF7Bdk8zGHkMdfI5UVCoCO4WG9RMVPEQqdEpLd14Z13QGptVmsnYDXl5DET5wZ794=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-511612e0c57so812377e87.2;
        Wed, 07 Feb 2024 02:19:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707301194; x=1707905994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERt8CAj2aHxrr9ilindgG3aRIzx8Pbl75eLnGCCnEzI=;
        b=LvTiUbSteIqu9hmtAvYgWxuJpbSBfy+sJkxP3m4KuzSchXcHx4WJ330zu3g5TKbBaA
         Ewh6ELCmZT5Y0IFjuq7hs6CrVsqK9GJOtJtXXSHn+0JBTy+76barsVJYK7HoL2oboZxJ
         NNayIYCSZbRn12EC+LjjOaWudlZLSOghmRc57l4RiYiZ+3rvOTFUuB2kNhdCVf6kGcHL
         wDikbvJ9ycTKt7w1wrfo9J8e/FSQ0ObNrZkeDrsodBYGithAOESMCGUlRDMIJyqH3Bcx
         3gFbX9FkX/4l8MiWcthfZzD+o4ctwq20DH7MpXGH+VDo2WX4sUCEF4nFm8MwGcucj5Ka
         fCcg==
X-Gm-Message-State: AOJu0YzPplH5dY9OGKQZSRWjfsKJAJiqBIAkZ9CMpz3nKyc4ISa368KB
	VWVNy3MW49IQmJvyMJmRVUA7r0e3Ep9fCuN1XxW93UkXKUhcX4qL
X-Google-Smtp-Source: AGHT+IE6CYjSeAwZCj3roLFW2+GvX7gM2Z9ASrZqAIDnq9M/I1ABvVt4IsGeCPjtQtxYWup858SvlA==
X-Received: by 2002:a05:6512:480e:b0:511:3a70:b954 with SMTP id eo14-20020a056512480e00b005113a70b954mr3224177lfb.18.1707301193915;
        Wed, 07 Feb 2024 02:19:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyTxb9e5XIcLwpBx0vs4KznvZ235uKtBaykUGsKOUO+KHEk4cNnjC6XndnP/11neCtyD/kUSxaVSCnPM/M5RNqzAR72tTN4DWaFAzbxL4YG4auEHbtT8S+kV2c6pHZysGipYnpFEtTBwRJREE4Ct1u+kWgKP9FhQDXtQRCYciJ4klioM4026O+OAiZGFqTP78JtmIIepNXJ7LkwZnLtYzzi1aJw6i2FLXPmzmSIJSK8mA3urPBVeifZE/RymilLrlwZ47WPQNNT3fhCh2d+enboLPFiHgN8T9Qhl6euJ20bT//MrYUYFLV8w==
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id jx19-20020a170907761300b00a356c0fdd2csm592727ejc.26.2024.02.07.02.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 02:19:53 -0800 (PST)
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
Subject: [PATCH net v2 7/9] net: fill in MODULE_DESCRIPTION()s for net/sched
Date: Wed,  7 Feb 2024 02:19:26 -0800
Message-Id: <20240207101929.484681-8-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240207101929.484681-1-leitao@debian.org>
References: <20240207101929.484681-1-leitao@debian.org>
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


