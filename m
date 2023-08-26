Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C8278992E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 23:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjHZVH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 17:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjHZVHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 17:07:40 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD3DE1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:07:37 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76d93cf8e13so128976285a.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 14:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693084057; x=1693688857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D1cp+fyJaYel+OZ1knmXDOhGjnOwMl8kMcdgE1kpwYU=;
        b=HCmOC09D815V1tcwqb+w4bpZcBA1b94hJfGCLhMUPL+xDP8lrXvvcNLiiTny6vwo2H
         kS44rpgiUjwg3QQJati4v5gC4z+pXQ7jMlA1mLDicw+8uAX53X/hn3t4xO9cp4Kl0FHE
         OI4HHzjCJBCxmwMjwi7ZVUfwTD41ssl0dV+FZclJ70xPL6cSZk0gXx0S9E4rUe2CUsUH
         hK1V2glT60nQD+/CATM2Btf9EoIS40keflDYpv87EDTnSBbsqRJuvWDKmegsRvkXGNLN
         YS1V/aQbmJ+9MP1TwJs5ZEBl0COVjwpY3t8BZvODxDf5fLzTLa6QdPa4r2LKbTorPMMk
         OIxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693084057; x=1693688857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D1cp+fyJaYel+OZ1knmXDOhGjnOwMl8kMcdgE1kpwYU=;
        b=XYiwXMHGeXxuvMwyVYOoIj6uIroSFhJL3HcWAX6PXfTk/saYoI8c9g+XsR1ddxXfK2
         RvNL22Tj/fMr93srUEC36sxuGPz4CkLTd+poc7LwaduLN3eKZz6HqGdILWz8VLz6euqy
         33Fu41N0cta3Ca25PD+9fOe7UP/uRu1XlgAAChKUi/5V04PPOD4qOZkl7UpULA2fxnqt
         FrCfaYa0ESRbKEgpF3tuQnYAdh8j9HZb/CKmj4NpcJ12peNsyWZdchsfHC4x3sgZVrva
         dWexyqI8Fm+jj6N29lbOIFOfSPv0ZK2VhjfqHxEmL+iYl/Nwj6CdGvl3O8rR9bVsElN5
         tGCQ==
X-Gm-Message-State: AOJu0Yytz/JZ2gMbw1hom6osCdg5FRx/bShJF//PJpIBZD1JYPu7BaM/
        j8pPxBOyLwDTxwRy9sGi3DA=
X-Google-Smtp-Source: AGHT+IEihAsxISoI6EDC46JjVO+XeC9vekE/MKRlIyYzO3EV4hIi6JIWSXsW+MxaW2PqxvrZzv5taA==
X-Received: by 2002:a05:620a:bcc:b0:76c:a659:5ed8 with SMTP id s12-20020a05620a0bcc00b0076ca6595ed8mr26069932qki.10.1693084057017;
        Sat, 26 Aug 2023 14:07:37 -0700 (PDT)
Received: from alolivei-thinkpadt480s.gru.csb ([2804:14c:bf20:82ea:8c7c:b784:3f92:988a])
        by smtp.gmail.com with ESMTPSA id w3-20020a0c8e43000000b0064f50e2c551sm1488377qvb.1.2023.08.26.14.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 14:07:36 -0700 (PDT)
From:   Alexon Oliveira <alexondunkan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Alexon Oliveira <alexondunkan@gmail.com>
Subject: [PATCH 2/4] staging: vme_user: fix check lines not ending with '(' in vme_fake.c
Date:   Sat, 26 Aug 2023 18:05:16 -0300
Message-ID: <9f3e2facdc4d5e612dc00830c2da0fb19c20f2c5.1693082101.git.alexondunkan@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1693082101.git.alexondunkan@gmail.com>
References: <cover.1693082101.git.alexondunkan@gmail.com>
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

Fixed all CHECK: Lines should not end with a '('
as reported by checkpatch to adhere to the Linux kernel
coding-style guidelines.

Signed-off-by: Alexon Oliveira <alexondunkan@gmail.com>
---
 drivers/staging/vme_user/vme_fake.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index a88d2c8a785b..dbaf050f88e5 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -403,8 +403,7 @@ static void fake_lm_check(struct fake_driver *bridge, unsigned long long addr,
 				if (((lm_base + (8 * i)) <= addr) &&
 				    ((lm_base + (8 * i) + 8) > addr)) {
 					if (bridge->lm_callback[i])
-						bridge->lm_callback[i](
-							bridge->lm_data[i]);
+						bridge->lm_callback[i](bridge->lm_data[i]);
 				}
 			}
 		}
-- 
2.41.0

