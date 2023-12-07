Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1890D8087B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379231AbjLGM24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjLGM2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:28:55 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8446084;
        Thu,  7 Dec 2023 04:29:01 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6ceba6c4b8dso199554b3a.1;
        Thu, 07 Dec 2023 04:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701952141; x=1702556941; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lid62c13OA13UOuK4ZHFWJw8LQvMIM6OUlJkAmjS2aw=;
        b=R3pTQ2P71oWwOEsR3F+FIkrEDfQ3pb2aQ792ZWI3Bis/nQHdoXAHTnYxBDSAqoTupG
         YJEpF2z0uPtVSQAK7dqwfaMgfCqkJ39aUXN59pv19zGa9YTjmkjRYlJNGzbjxnKHaJ+7
         NzsjEj/BYnw9GZzIzu8n3rIaQCZ8WEw646oZNGC+3+iN8iVgGm1KG21yjJNwBji4Hy1y
         VPkhsqd3AI+i0H4GxIxqd4UvbA/zVwQDExM9JtkCWDoAE0/1i+X+QIUsK7xdAup5qnih
         sGIzPaF4ZPHHDypCncitpbEmAjDGigG6M4Vabge6p3wFPyHPmc0Wps7RjoxNoayMvuak
         yZKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701952141; x=1702556941;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lid62c13OA13UOuK4ZHFWJw8LQvMIM6OUlJkAmjS2aw=;
        b=WijmHhYdGuDRUjuZHs8lAmj1b9T1YI+VIXqPYnMemH7KzvszBA7vVG9EKr7O4XHOdc
         vwui3hrDEchhn695g077pI/xbkz44/R6CK7XK3Yh9i9YxGMLZSWU/eaOCg1WL1ceeTjg
         V0PBT1dbtkXDPbw1R46Jd2p9HuguBwb7F+JeGnhjYE7WBJAku78FUq5g/OsM4U8PRYZM
         7qF2QFLbcFzjwz1t7OUnJwSJis+302WWdJgShDzd2Xji2t/24TpSqSP73NcC0a6+Rc5C
         VVj5DtrWcmBEFz3VbOAp82eg5DddJEWTlXxbV2osmyovDv/xTT9hcvK8BnDZWl8/wFE3
         b7cw==
X-Gm-Message-State: AOJu0YwJ/GynaHtpkAUjZVmfinmPCM24NnYjbXPERMQOcxxxC5s4vZGg
        nEhklZD108jTzuqlqSJrldo=
X-Google-Smtp-Source: AGHT+IGr5lKAfJ7n2y2wAOLF3nW2W2xMuYwvmOjmc39ExVmCK+JKLpfStp3stmFBqfVmX7pG1JBUcQ==
X-Received: by 2002:a05:6a20:9381:b0:18d:b43:78ea with SMTP id x1-20020a056a20938100b0018d0b4378eamr2911595pzh.43.1701952140676;
        Thu, 07 Dec 2023 04:29:00 -0800 (PST)
Received: from 377044c6c369.cse.ust.hk (191host097.mobilenet.cse.ust.hk. [143.89.191.97])
        by smtp.gmail.com with ESMTPSA id x20-20020a056a00189400b006ce5066282bsm1164715pfh.34.2023.12.07.04.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:29:00 -0800 (PST)
From:   Chengfeng Ye <dg573847474@gmail.com>
To:     3chas3@gmail.com, davem@davemloft.net, horms@kernel.org,
        kuba@kernel.org
Cc:     linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chengfeng Ye <dg573847474@gmail.com>
Subject: [PATCH v3 1/2] atm: solos-pci: Fix potential deadlock on &cli_queue_lock
Date:   Thu,  7 Dec 2023 12:28:49 +0000
Message-Id: <20231207122849.41798-1-dg573847474@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As &card->cli_queue_lock is acquired under softirq context along the
following call chain from solos_bh(), other acquisition of the same
lock inside process context should disable at least bh to avoid double
lock.

<deadlock #1>
console_show()
--> spin_lock(&card->cli_queue_lock)
<interrupt>
   --> solos_bh()
   --> spin_lock(&card->cli_queue_lock)

This flaw was found by an experimental static analysis tool I am
developing for irq-related deadlock.

To prevent the potential deadlock, the patch uses spin_lock_bh()
on the card->cli_queue_lock under process context code consistently
to prevent the possible deadlock scenario.

Signed-off-by: Chengfeng Ye <dg573847474@gmail.com>
---
 drivers/atm/solos-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 94fbc3abe60e..95f768b28a5e 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -449,9 +449,9 @@ static ssize_t console_show(struct device *dev, struct device_attribute *attr,
 	struct sk_buff *skb;
 	unsigned int len;
 
-	spin_lock(&card->cli_queue_lock);
+	spin_lock_bh(&card->cli_queue_lock);
 	skb = skb_dequeue(&card->cli_queue[SOLOS_CHAN(atmdev)]);
-	spin_unlock(&card->cli_queue_lock);
+	spin_unlock_bh(&card->cli_queue_lock);
 	if(skb == NULL)
 		return sprintf(buf, "No data.\n");
 
-- 
2.17.1

