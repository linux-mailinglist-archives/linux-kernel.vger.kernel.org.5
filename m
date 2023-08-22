Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69492784920
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjHVSCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjHVSCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:02:48 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C40E65;
        Tue, 22 Aug 2023 11:02:45 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-68a3c55532fso1927710b3a.3;
        Tue, 22 Aug 2023 11:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692727365; x=1693332165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GuYmHdMlJJm2W9mV95yYZgg2mXFJPDcfJ3tRYlFlHrM=;
        b=gqFsS4g898zloSUsvUOxRyxm13ck+hm8PgrmGdFF5H3jcXSedee1lUl2lXxL1gcu2v
         RWXKkTldqfGm0XNCOOoSTf6/T3iV/OCF9hcOHhM5RF9anNmQKwL+EzX1otqxzjW93w3T
         iL+SFbFFpmBvIv2bKl31eb0+TPhU4dM96amBC67LQWNQ3EFxjkt/GUkm3I8AR0d2SS1h
         GRcw4uMgshDoDI6JBqCAV6owJnFssXoOk+9szBIP6tO568OCvqg7uYbcIbEGEfqlnTSG
         j6FlH4hBlV+qLudlrqHiTPvE0YwWfd2cM7CACjfG7mcSTsJyYRp36SuV3CxyEmmpMC6g
         RDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692727365; x=1693332165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GuYmHdMlJJm2W9mV95yYZgg2mXFJPDcfJ3tRYlFlHrM=;
        b=a7CG2JcJq8nylKu0LkanW66b83g9l66SOnfXdkIdJbOIZBTUDJOQMmb0FIjoImNHQz
         vpPxdrkTkmfKCfcEph5rL7ZOIPR30/8nWWNXVemgGJSTIoOIT8+7nXpVpF7g42MrDhkt
         e/ltx6WzdplphgXpKLTtjHUrUw/rvRmtaZYk8VRk2h/y9Dfra5/M0jDrTo/4RS9N51f6
         L8D8cGzJiwYXaj2s7RpW1hPbYa2AKN75kEc9RFhdi2Ai859Dt5Viu4Vtt94vVY8HIve9
         vXa4uMI/8fThfJp0Ybr79Jg/S9ntjqniL/HvvoKoZ3X83jKiRwE8fTAR760UDYukpDdE
         6ujg==
X-Gm-Message-State: AOJu0YwEAS5aBojQjGoinDEjeaGrWr+Lc5MOxFaXl/aV22gdhYT9lY2x
        V5yEwPxkXeZXdbCs6y6s4kw=
X-Google-Smtp-Source: AGHT+IEGI5zSTja+ppqkBQ3KGECxtd60QD4ZBadZiwQVZDV8aMFXhaN30CDm1Y076HbxUUkkvQ9D7A==
X-Received: by 2002:a05:6a00:cd0:b0:66d:263f:d923 with SMTP id b16-20020a056a000cd000b0066d263fd923mr9211500pfv.20.1692727365270;
        Tue, 22 Aug 2023 11:02:45 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id k5-20020aa792c5000000b0068a0922b1f0sm6226293pfa.137.2023.08.22.11.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 11:02:44 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org (open list:INTERCONNECT API),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 07/11] interconnect: Teach lockdep about icc_bw_lock order
Date:   Tue, 22 Aug 2023 11:01:54 -0700
Message-ID: <20230822180208.95556-8-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822180208.95556-1-robdclark@gmail.com>
References: <20230822180208.95556-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

