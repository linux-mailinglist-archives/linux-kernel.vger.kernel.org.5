Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE2BC77BE7B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbjHNQym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjHNQyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:54:15 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5353170B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:59 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so6116371a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692032038; x=1692636838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wIvDC1RQQDdB76emFuds/bRYMDd6MDnA3Z/g/2DlsAI=;
        b=JmSqvmCKWvittCs/IjCbgu+3xqMi7OkUVwBC3dXea5j8Kv+WlsIT5F68uLkHbljWBO
         dLk6Dh0jeSdwo8b9lmw2wLfFDBPsAcFgkiwYEWNylb4c74K4O0TPoNx3kuoLQ6qGJFy5
         uGpI8LRJZISYnq312Fi++Jmq0QIjOpzy0t0UJd+uuckQgircJfAOIrWwrwB/gpCFEdkL
         Meq1czYOYWlBG1QRwV0Trld6WhBKgOTRLedGAZygAIMojPemO6hUfmRFfIxEbXPyC7Wl
         dQYSq7leXT2yTm7QHS8REiz7gCsLVe8dPDG8iGPif03pVe0oogjHLp0dVC8oit3f712Y
         ErFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692032038; x=1692636838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIvDC1RQQDdB76emFuds/bRYMDd6MDnA3Z/g/2DlsAI=;
        b=UDVr5oESD5mxigbwPQ3oduNAmwJpKsTXezxdEKHQ97JyrYIPcaApdiFAVnEQ+X0rJp
         wy4HliXDx5ITkiaMHCoyId2Gt+mY0A8+z+Y/K8WlQ/2muwFQf+4jjoY3YV1BcTkhGiQc
         8sHrj/MV7RiV4HmCiw+2BRHltRy4csFrEsnIBe7+BaFOU1LSmneZYUwwU6Rqo560rIsD
         9EGm9Py3Y5tm4j3hi2aly+eBH7BmwFJb99rHtcR6SrdBFVhQ63dMnclI8EAvYi0fJKKE
         BOcbzKu9iH0KH9zjcHVRi4EewYIQEmJtUbTyTSXbdOoZNsclf7eMhQRO4mdzTpWdSVuO
         npOg==
X-Gm-Message-State: AOJu0YyQjndVAy27P5N2vxEx/lRkwMGp67IyjwEaOXStpdUEACfwZRY7
        Fbx4OnuMnj3EbCWEk4qe3ynyIQ==
X-Google-Smtp-Source: AGHT+IHLdyE35bvcdYVbXstp+m4op8UGRxSCgS75e/lWN7eaTfSbyoKjz1y9vVHLpRB//vnopbNlwQ==
X-Received: by 2002:aa7:da06:0:b0:525:69ec:e1c8 with SMTP id r6-20020aa7da06000000b0052569ece1c8mr1696256eds.40.1692032038481;
        Mon, 14 Aug 2023 09:53:58 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id n5-20020aa7c785000000b0052338f5b2a4sm5811267eds.86.2023.08.14.09.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 09:53:57 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 21/22] nvmem: core: Do not open-code existing functions
Date:   Mon, 14 Aug 2023 17:52:51 +0100
Message-Id: <20230814165252.93422-22-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
References: <20230814165252.93422-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miquel Raynal <miquel.raynal@bootlin.com>

Use of_nvmem_layout_get_container() instead of hardcoding it.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index bc7ea001a446..12d05aea0b41 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -785,10 +785,10 @@ EXPORT_SYMBOL_GPL(nvmem_layout_unregister);
 
 static struct nvmem_layout *nvmem_layout_get(struct nvmem_device *nvmem)
 {
-	struct device_node *layout_np, *np = nvmem->dev.of_node;
+	struct device_node *layout_np;
 	struct nvmem_layout *l, *layout = ERR_PTR(-EPROBE_DEFER);
 
-	layout_np = of_get_child_by_name(np, "nvmem-layout");
+	layout_np = of_nvmem_layout_get_container(nvmem);
 	if (!layout_np)
 		return NULL;
 
-- 
2.25.1

