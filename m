Return-Path: <linux-kernel+bounces-7750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 637B481AC9B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3243B2394E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D385D23D9;
	Thu, 21 Dec 2023 02:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAuycK6U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2571843;
	Thu, 21 Dec 2023 02:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-28b99bca6easo66007a91.1;
        Wed, 20 Dec 2023 18:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703125585; x=1703730385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MJpfC3kc2UL6o363XO7Gt4DaAH8UXw1+4tDspztGViQ=;
        b=eAuycK6Uktob4M92iES8O1fUzJTm7+Mc7W1i7nDV04cS4aSFVbxP/GBecqpROod5QL
         zljk4XtXlJDtqndSQN1rHiIscW1sGrN9etkWMuQGKqQqA9sMFlJXUayul+jd/juMrhiZ
         wIdN6JP/Z8zvHEiTLTaCD4Onku2loFBuKcR2W14aats19AUw9wvjnD3jnbwm9sPuY+pK
         0yR+sIDav27ciraCej5EPSypykfP69Tx5EDuVloqOv3EDesCjh5UKh1q8hLlMXzIa0Ti
         xxg3zqjCbbz9EsZd5V29YJlBcymfUCJjofBike/SEwWc2ecFdU/iNkrWrb9iTeULRMWS
         JdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703125585; x=1703730385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MJpfC3kc2UL6o363XO7Gt4DaAH8UXw1+4tDspztGViQ=;
        b=SKsQu/LTk8cepFovJuZ72wAuM65oDq6grhKMHiJQ3loiEBfqfeD3hxWzFS+wbYLF+c
         bHb7vwZ39GlK799VfvONspNzOgkGrut/c2eVkMT72YwnJ0XvTrBWhGiOwz1NPXcuWf7R
         XfuFZv+aemijnS7/cDZW6MLZjYeB7rQDu8u/T+7DuHbaioCAB0AOSkTczVIHokZQYMFh
         EeNNPCYnOrThZ43gcmEXXAEYNelCBO+jbCoTKF9dtHKxcIckcwtAVaDKyledU0ZyS+cO
         AdBrT+scvSSNzh5y27O3S6WdOGGAToVjMPatPqEtKw1zt9xWza2ZGy0+YxuA2tXWOdj+
         1c0A==
X-Gm-Message-State: AOJu0Yy+up59mhopQ/bpF0Dws/4RoQuihDwr8TLXJOepJZWOWHUNxid/
	fxEXiQGSzoj0PUikDu7tUoCZgPAHqfNAbVe+
X-Google-Smtp-Source: AGHT+IHkBuUQpGqS3DVr2KGUl3jagO1YFuspC5zC5APjTftv6Oj5rVsVVEeqXf9QueneaHe8XuBBQw==
X-Received: by 2002:a17:90a:fd85:b0:28b:c22f:b1c1 with SMTP id cx5-20020a17090afd8500b0028bc22fb1c1mr5322596pjb.1.1703125585307;
        Wed, 20 Dec 2023 18:26:25 -0800 (PST)
Received: from hbh25y.mshome.net (061239074230.ctinets.com. [61.239.74.230])
        by smtp.gmail.com with ESMTPSA id 17-20020a17090a195100b0028b1fce7c01sm4691716pjh.37.2023.12.20.18.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 18:26:24 -0800 (PST)
From: Hangyu Hua <hbh25y@gmail.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	tgraf@suug.ch
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH v2] net: sched: em_text: fix possible memory leak in em_text_destroy()
Date: Thu, 21 Dec 2023 10:25:31 +0800
Message-Id: <20231221022531.9772-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

m->data needs to be freed when em_text_destroy is called.

Fixes: d675c989ed2d ("[PKT_SCHED]: Packet classification based on textsearch (ematch)")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
	
	v2: fix a type usage error

 net/sched/em_text.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index 6f3c1fb2fb44..f176afb70559 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -97,8 +97,10 @@ static int em_text_change(struct net *net, void *data, int len,
 
 static void em_text_destroy(struct tcf_ematch *m)
 {
-	if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config)
+	if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config) {
 		textsearch_destroy(EM_TEXT_PRIV(m)->config);
+		kfree(EM_TEXT_PRIV(m));
+	}
 }
 
 static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
-- 
2.34.1


