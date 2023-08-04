Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74A07709B3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjHDUbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjHDUbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:31:39 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737044C2D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:31:37 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3a5ad4477a7so1880619b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 13:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691181097; x=1691785897;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P2sRXegefcAEl333biQwB8H/OIszvfSG+NNQtF6Df6w=;
        b=sJxIClGpPyW2HMO2BQEMygYCD21+kw9MK5mfE9Jl0bGSq/VBa+BVWlZgjp4vfpCM73
         /itVh0mFRBTgD4yixQPHc5rzFzYUi9vH5ip3cSDi5ob+JbpJpA7B2wqzw23fFCr43Jfh
         K4sJnIIKjz9VqutdxqdXF3ZQRwpbRkVwe8mmNaKz3bZjS7Hg4DWd2sP5Le3PtrcKOATt
         cSBmau63g/oFdMg+agGgsDep9RcCgwjrZ4Z1PSAuBCsQS6FLKVO/KMAfQZ8mXo+7PaNM
         qSW3+wKvxkzd/FL0DxSr7mrtqvYRyX8W96NPAfdnJBn8cF++oNNSSv+qjGJ6QbRFHtXX
         DSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691181097; x=1691785897;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2sRXegefcAEl333biQwB8H/OIszvfSG+NNQtF6Df6w=;
        b=IElFrVZ8eCvELGsoj+tyH1dHiFTQrE4kYvexeNfgyNb1rKaoBHiMejFFEx7G3l0Z++
         6T+u6LZFNa32pwlZebpXDht3Qr/PeVcK0pd7L68P2zAbdCVhUzku9/HdXaaZQs/R8g70
         VWEwPIYLt5mwetJ5rSXbXy21HfjSmbY4iODxLo4/RPYQpPWK6dqLuylEiloHCD/eubWx
         KpKfA88SUs6gxmpnl/udBBgg8eoRqce6NRqtXkV/L7PUWqWdijEldQ3ILqHdQbBpwmzA
         d4bqvFmitU3LOryaLPwgsSbIWHYFsXAKu7xFephhevkOnvsn7DTkyAWRRk2sMKhtDUBV
         DJPA==
X-Gm-Message-State: AOJu0Yx65eyplX3NYPYf3/WhjWG3V49IrIw5EQur95XxF3SY7Jk5SiG2
        lidk/5wNG9BxknSSZuM7MZ4=
X-Google-Smtp-Source: AGHT+IFSGKqv/EpwBMvrQ1Kag1VNKCAJJWEtIYcN330189QrIWtiqx2lwCILiFCLfVr3YgfuDwm90w==
X-Received: by 2002:a54:4e02:0:b0:3a4:57a7:b30e with SMTP id a2-20020a544e02000000b003a457a7b30emr2404804oiy.26.1691181096638;
        Fri, 04 Aug 2023 13:31:36 -0700 (PDT)
Received: from madhu-kernel (99-145-207-128.lightspeed.austtx.sbcglobal.net. [99.145.207.128])
        by smtp.gmail.com with ESMTPSA id e22-20020a05680809b600b003a75b6cbd38sm1467104oig.45.2023.08.04.13.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 13:31:36 -0700 (PDT)
Date:   Fri, 4 Aug 2023 15:31:34 -0500
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
        elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     skhan@linuxfoundation.org, ivan.orlov0322@gmail.com
Subject: [PATCH] staging: greybus: Refactor gb_audio_gb_get_topology() into
 separate calls
Message-ID: <20230804203134.GA618419@madhu-kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor gb_audio_gb_get_topology() into separate calls for better modularity.

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 drivers/staging/greybus/audio_gb.c | 67 +++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/greybus/audio_gb.c b/drivers/staging/greybus/audio_gb.c
index 9d8994fdb41a..a48ddadd6f1e 100644
--- a/drivers/staging/greybus/audio_gb.c
+++ b/drivers/staging/greybus/audio_gb.c
@@ -8,39 +8,56 @@
 #include <linux/greybus.h>
 #include "audio_codec.h"
 
-/* TODO: Split into separate calls */
-int gb_audio_gb_get_topology(struct gb_connection *connection,
-			     struct gb_audio_topology **topology)
+int gb_audio_gb_get_topology_size(struct gb_connection *connection, u16 *size)
 {
-	struct gb_audio_get_topology_size_response size_resp;
-	struct gb_audio_topology *topo;
-	u16 size;
-	int ret;
+    struct gb_audio_get_topology_size_response size_resp;
+    int ret;
 
-	ret = gb_operation_sync(connection, GB_AUDIO_TYPE_GET_TOPOLOGY_SIZE,
-				NULL, 0, &size_resp, sizeof(size_resp));
-	if (ret)
-		return ret;
+    ret = gb_operation_sync(connection, GB_AUDIO_TYPE_GET_TOPOLOGY_SIZE,
+                            NULL, 0, &size_resp, sizeof(size_resp));
+    if (ret)
+        return ret;
 
-	size = le16_to_cpu(size_resp.size);
-	if (size < sizeof(*topo))
-		return -ENODATA;
+    *size = le16_to_cpu(size_resp.size);
+    return 0;
+}
 
-	topo = kzalloc(size, GFP_KERNEL);
-	if (!topo)
-		return -ENOMEM;
+struct gb_audio_topology *gb_audio_gb_alloc_topology(u16 size)
+{
+    struct gb_audio_topology *topo;
 
-	ret = gb_operation_sync(connection, GB_AUDIO_TYPE_GET_TOPOLOGY, NULL, 0,
-				topo, size);
-	if (ret) {
-		kfree(topo);
-		return ret;
-	}
+    if (size < sizeof(struct gb_audio_topology))
+        return NULL;
 
-	*topology = topo;
+    topo = kzalloc(size, GFP_KERNEL);
+    return topo;
+}
 
-	return 0;
+int gb_audio_gb_get_topology(struct gb_connection *connection,
+                             struct gb_audio_topology **topology)
+{
+    u16 size;
+    int ret;
+
+    ret = gb_audio_gb_get_topology_size(connection, &size);
+    if (ret)
+        return ret;
+
+    *topology = gb_audio_gb_alloc_topology(size);
+    if (!*topology)
+        return -ENOMEM;
+
+    ret = gb_operation_sync(connection, GB_AUDIO_TYPE_GET_TOPOLOGY,
+                            NULL, 0, *topology, size);
+    if (ret) {
+        kfree(*topology);
+        *topology = NULL;
+        return ret;
+    }
+
+    return 0;
 }
+
 EXPORT_SYMBOL_GPL(gb_audio_gb_get_topology);
 
 int gb_audio_gb_get_control(struct gb_connection *connection,
-- 
2.25.1

