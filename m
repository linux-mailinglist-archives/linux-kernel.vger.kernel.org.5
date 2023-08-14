Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FA677BE7A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbjHNQyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjHNQyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:54:16 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180EE173C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:54:01 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe4762173bso7373256e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692032039; x=1692636839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aU/jN/gUmDvHcV1DoQ8MQToLmzhYPjxk4jpbikZ/Pkk=;
        b=CGfIsimbyVCWZG2jNukC4mczFKrMqSB44wbyngtoXgDbQcf83iF/UYmtNwUMFirwmt
         KuGtLnK1p7XtRKmHRHxLvFqeXm2WL1qk/YJKGgrTuQFV50aXyGBAhZOf4Um5WUcqcXaX
         r+UNlj501NicsUuIqHPyi7sVLSQvJgPkngFB8cuVV7USqaJxUDcEETjlVXo9p4IZ++Go
         qY1maAcoNP8WdVW2YmC64ee/SrHnw1/DYF75ovQqT85Y+WLYnfsFaZO2a2nZMrmyld5T
         qMTdIRiMqhv8BUVCp08czDO2zemJGcIVL4DLRf0D539SMPxuEjFfvlZtoBrB+FkaPuIS
         XKGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032039; x=1692636839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aU/jN/gUmDvHcV1DoQ8MQToLmzhYPjxk4jpbikZ/Pkk=;
        b=hJ3jFthFUYAQID9d9EsSUS5zYz6uxTucKkh4mPg0zdACTTrAonkmjTNBwNU+CqUb6M
         JNzZjmW9T3UJEGzzlrugFIZomn8SD5KMCc2beTNgsPCvdoiSazW9BtBLVdC+42nLURr2
         Lg79ceumnWF+HpCyJRUypqE8r1ilRnYup12akELpvsb3wIS0BZ5vewB2AnFJVOG98iP/
         sAHHqSyk70Ls955tR8YvGbJWzL62OP5QcU3Z4vvDT1Vj4G5e9kTriHWV3zN79wowJIoA
         kgcE6Z7cbu3SVDqBJyhs46MRPNOHkBoTScClP2uPhvpESjhGKG86d2qgwWvL8yNuS7Fq
         EpkA==
X-Gm-Message-State: AOJu0Yx0Q6hYjksLnmfls8ZfXZ1sYxDGleDZ3vndBZgErE6yPkD9sK3h
        iIMsArCiT4gwTrm5iVdtCaZf7w==
X-Google-Smtp-Source: AGHT+IEq85C5cqCqSrnaReLk7P9qAZRG+x/miV1wj1JxlZh58Ilw6tjN0JaXxgc9mtMYjsSo/gLcTA==
X-Received: by 2002:a05:6512:2398:b0:4fe:8f66:28a3 with SMTP id c24-20020a056512239800b004fe8f6628a3mr7883595lfv.0.1692032039383;
        Mon, 14 Aug 2023 09:53:59 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:58 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 22/22] nvmem: core: Notify when a new layout is registered
Date:   Mon, 14 Aug 2023 17:52:52 +0100
Message-Id: <20230814165252.93422-23-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Tell listeners a new layout was introduced and is now available.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c           | 4 ++++
 include/linux/nvmem-consumer.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 12d05aea0b41..eaf6a3fe8ca6 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -771,12 +771,16 @@ int __nvmem_layout_register(struct nvmem_layout *layout, struct module *owner)
 	list_add(&layout->node, &nvmem_layouts);
 	spin_unlock(&nvmem_layout_lock);
 
+	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_LAYOUT_ADD, layout);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__nvmem_layout_register);
 
 void nvmem_layout_unregister(struct nvmem_layout *layout)
 {
+	blocking_notifier_call_chain(&nvmem_notifier, NVMEM_LAYOUT_REMOVE, layout);
+
 	spin_lock(&nvmem_layout_lock);
 	list_del(&layout->node);
 	spin_unlock(&nvmem_layout_lock);
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 27373024856d..4523e4e83319 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -43,6 +43,8 @@ enum {
 	NVMEM_REMOVE,
 	NVMEM_CELL_ADD,
 	NVMEM_CELL_REMOVE,
+	NVMEM_LAYOUT_ADD,
+	NVMEM_LAYOUT_REMOVE,
 };
 
 #if IS_ENABLED(CONFIG_NVMEM)
-- 
2.25.1

