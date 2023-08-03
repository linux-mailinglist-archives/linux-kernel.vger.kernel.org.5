Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642F876F56E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 00:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjHCWDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 18:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbjHCWCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 18:02:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8612846B3;
        Thu,  3 Aug 2023 15:02:34 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26824c32cfbso1004755a91.1;
        Thu, 03 Aug 2023 15:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691100153; x=1691704953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuYmHdMlJJm2W9mV95yYZgg2mXFJPDcfJ3tRYlFlHrM=;
        b=K12ls+5nEVl36ytG8cbp2yL75TIL1947X1Gv+ztaa5Hs1nzv+rsT75oXjLTWThiuvm
         NMIvk4kaDD61ZhpuSH4+0g7aEkyWAZ/NEZTx3b93Z5VyIeAHAGSJ8qqNK0CegT54Y9Np
         UDlfQNqA52YALXkFjv+uRLcBVhMD+GzpiiYGUdLFL45VVymD2Aw5Q1JMBgkcfV7HYERO
         s/Bua6mD4cUkMEn8l8w1lpFEQczncgzXSTSGm7o+2SfFS4f7l+hEasQgu9bzjwDbRl8n
         jgWdy9tyjFvrcQnH6g/FvYmmDOjY/JYPESrbt2yArlBGFnSp7h1A14npTAFYtwyvKfBb
         t2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691100153; x=1691704953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuYmHdMlJJm2W9mV95yYZgg2mXFJPDcfJ3tRYlFlHrM=;
        b=PoOhhJ3cH334R39y8wmUaQ86De0eKENqsTpr3ykapaKdBJtWf/nbTSkwbretKuuLcQ
         FnFO5VqqReltpt/vTpmZNXlyRNouMBdjo4sUeiEO2rrd89Y2EvbGsBzFqxu7lXcf/4Px
         k5nvJFbuHGvRBt4JNltWttYgtMVhNG5MhCO4nIdZLlcLVh35fKVbDgsk1dP73bvWROHP
         +JVvUxMEwa0mahnsRPYPJj83SKxdxkpZnBYcbC5WtQs7Ucq+CA13kOLraKCKUAcPc0oF
         iodza9G3ryTDfyLN/Zwt9V05dsTBxc/UviCuQ65UUvnio13stAgJ5Fqt1sjEaFNYJSga
         PbjQ==
X-Gm-Message-State: AOJu0Yxzr0+0R4F/w2TNuTedBsSIRc6GFhMMDlvrQe4RoseGNyLF3iCX
        g7fl5tY/Dd6Z0f0X/u2G4Zo=
X-Google-Smtp-Source: AGHT+IG3YFvsDLwStkO1uqHxjVFxeObDGmEDiHO59o2QB19zWFMW8tsvoWzHpEa0C01KLQGzwYn+Hg==
X-Received: by 2002:a17:90a:6f23:b0:268:f2e:b480 with SMTP id d32-20020a17090a6f2300b002680f2eb480mr27686pjk.11.1691100152708;
        Thu, 03 Aug 2023 15:02:32 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id f3-20020a17090a654300b002641a9faa01sm2946592pjs.52.2023.08.03.15.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 15:02:32 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org (open list:INTERCONNECT API),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 7/9] interconnect: Teach lockdep about icc_bw_lock order
Date:   Thu,  3 Aug 2023 15:01:55 -0700
Message-ID: <20230803220202.78036-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230803220202.78036-1-robdclark@gmail.com>
References: <20230803220202.78036-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Teach lockdep that icc_bw_lock is needed in code paths that could
deadlock if they trigger reclaim.

Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/interconnect/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
index e15a92a79df1..1afbc4f7c6e7 100644
--- a/drivers/interconnect/core.c
+++ b/drivers/interconnect/core.c
@@ -1041,13 +1041,21 @@ void icc_sync_state(struct device *dev)
 			}
 		}
 	}
+	mutex_unlock(&icc_bw_lock);
 	mutex_unlock(&icc_lock);
 }
 EXPORT_SYMBOL_GPL(icc_sync_state);
 
 static int __init icc_init(void)
 {
-	struct device_node *root = of_find_node_by_path("/");
+	struct device_node *root;
+
+	/* Teach lockdep about lock ordering wrt. shrinker: */
+	fs_reclaim_acquire(GFP_KERNEL);
+	might_lock(&icc_bw_lock);
+	fs_reclaim_release(GFP_KERNEL);
+
+	root = of_find_node_by_path("/");
 
 	providers_count = of_count_icc_providers(root);
 	of_node_put(root);
-- 
2.41.0

