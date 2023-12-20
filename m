Return-Path: <linux-kernel+bounces-6314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9225819714
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADD5B284F67
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 03:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35AB8F59;
	Wed, 20 Dec 2023 03:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzvkOINN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70BB8BEB;
	Wed, 20 Dec 2023 03:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-28bbe484bc0so192561a91.1;
        Tue, 19 Dec 2023 19:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703041746; x=1703646546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZtBB6M87gvRrIc/FBudpHQB5vn9BvBcHQdNsv4PFeg=;
        b=bzvkOINNxO7kzLVAzm2ra+oEzbFq9+UVOLAYzFVoRm6BH+8WiNLXN2VGrUrU55LnSu
         5sN7QtJOcCpRnDwMCyDKvZpiTDKInriHxpTMSZWRNVu1upn6uEqFXAGboFJQ+1fv9Kjv
         oPYLVwVV6ccGYw8RdWL59I+REPFTtnF+LxQYA7AJdiPZZgNkgwxMcW3A/7quRobKNWbD
         uF3+KAjgVhxUPPi/hJgqd1vZFPgb7ekK7D6OKrAviloEhQoBJyBuJjk+dgaQ3xA/pMXQ
         V9t8fr8nWsGEL9q/D7g0DGF+rX1AXPJH04U88JDrIDEsU1XVCBOAa05NtZNiYNljqSkk
         acXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703041746; x=1703646546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZtBB6M87gvRrIc/FBudpHQB5vn9BvBcHQdNsv4PFeg=;
        b=FSqG0hsRgi0uTZeiig8SmxWNfHEw5ri++BGcmLhtgnOYVNtoaMKoqq5jmWintkwMks
         /xS0WSMbhDbaZORrmH1Pb0c1+uOYWbIKScQ/I00dQUxIlcgjhWRu92EK+T29qm/u6BKi
         XaimDGjNgYu47JIYSWMIBbQ+wZoPK4EbfK9FFsRK7PD3sVPwQDFI+WeGvLDnCHBm0/AV
         23jkSRPpINOrNz50CWv++9y8IlaWKBAnbjEdraU+q5ZDZTL2DYs7Cwd/j/1jynXBtSix
         k0wcLn4uWY4X7oy2KqbMpxn/3MqowOod26ylboi8ckP2oYW4yMBJIStE9Noh4N0IT3nF
         R4dw==
X-Gm-Message-State: AOJu0Yy9gNOlTzQzFqg8uLZ21Gyd0JnR4HVWLGUpWodNDiDzvqjvQvnH
	shiEBa+ekMsIXbDoWyG66MU=
X-Google-Smtp-Source: AGHT+IEDEk4HrLePpiSqeSpBoWJDyO7SvSFRv7G8D6+Cg+8jDGlCqOxwhrxbStVbMX6OQzxzPY/3NQ==
X-Received: by 2002:a05:6a00:1b49:b0:6d9:4ac6:155d with SMTP id o9-20020a056a001b4900b006d94ac6155dmr718122pfv.0.1703041746074;
        Tue, 19 Dec 2023 19:09:06 -0800 (PST)
Received: from hbh25y.mshome.net (061239074230.ctinets.com. [61.239.74.230])
        by smtp.gmail.com with ESMTPSA id y75-20020a62ce4e000000b006d9389f0e61sm2015250pfg.156.2023.12.19.19.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 19:09:05 -0800 (PST)
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
Subject: [PATCH] net: sched: em_text: fix possible memory leak in em_text_destroy()
Date: Wed, 20 Dec 2023 11:08:38 +0800
Message-Id: <20231220030838.11751-1-hbh25y@gmail.com>
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
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 net/sched/em_text.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index 6f3c1fb2fb44..b9d5d4dca2c9 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -97,8 +97,10 @@ static int em_text_change(struct net *net, void *data, int len,
 
 static void em_text_destroy(struct tcf_ematch *m)
 {
-	if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config)
+	if (EM_TEXT_PRIV(m) && EM_TEXT_PRIV(m)->config) {
 		textsearch_destroy(EM_TEXT_PRIV(m)->config);
+		kfree(m->data);
+	}
 }
 
 static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
-- 
2.34.1


