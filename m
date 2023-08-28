Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A678A8BD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjH1JUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjH1JT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:19:59 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BF810C;
        Mon, 28 Aug 2023 02:19:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c0c6d4d650so23361145ad.0;
        Mon, 28 Aug 2023 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693214397; x=1693819197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czUvoB2YphHxinmpy35aY7rZVy/pXgKwXq7ZvtF0H2o=;
        b=KtfxJlLq2da8xTFKGL07onU+phdbVJYfopLOIgC1oCiWeIMNZc/srqIeIF/c5KnnWN
         rBeynEHATH1W1+jov/WZcLbDfWNMqKsW4T7qMdMk+bfaj4AszqCRb+dCaAb0BA2uMHDb
         iHAzt3vtP3NDbKZl5QZ9evKvcpgDdUwh1pQGSdWWbGtEzWOFn38yaOI7ka77eoxN1J95
         cXYXH1iSkKhwrdQkT5lifIcsKQt3zh6CVxU0ITRVQJJsXaXczIn+eR/FUTNsqq2QXcGO
         8sAyFaFrUvfnXIFMg0xCYKIXoJRPj2WqO7KRYTIX6+kiE4nijtBxBkVQZted0xKL++el
         b5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693214397; x=1693819197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czUvoB2YphHxinmpy35aY7rZVy/pXgKwXq7ZvtF0H2o=;
        b=Mj/pFcboRU5Gc6NHNhVCgGe8BCbD/HiL8l3TaNqwDEvUHTMIBgt0gaiXju5lmBnFgd
         O9UATcdiJWwJwEk1TpG508lQWMA2zM47ulTw/s7nKIgpH2x1lmGtmG519fHG8KK3lSY9
         1Sdta3ykpsxa4HfEHCpiuXxJRiauajsM3gPJXgaexhkcj2kzPI5Ai3RFTcDWpYhemycB
         XKUKq5zHLHZgOpmWJnIg8nShh0W9nFTn+xrbqGhfqXJ0csNwbWXS69xEtcMZhgzKUj32
         W1swU1EVl6WBbcDukuPlbqrz4kOEDEl598XDf24bG6alO817yH3w3KFM/dOu2zuUvAj6
         AH8w==
X-Gm-Message-State: AOJu0YxnC6bJVXLllZf5hEQbAkgHVbgX/sRd83+6Bg1mvYcGNUzr3V9N
        zB4F+l6gJUghk3vUt8vmUAqw6olYkLyk8Q==
X-Google-Smtp-Source: AGHT+IHY36XFt0VstHzp1KS4I2+sBZqCcWlOjpWKoh/gOkIqxF3dcxCclfcnddEDA8S8+CBpzqDr6Q==
X-Received: by 2002:a17:902:8f97:b0:1b8:400a:48f2 with SMTP id z23-20020a1709028f9700b001b8400a48f2mr26168545plo.62.1693214396894;
        Mon, 28 Aug 2023 02:19:56 -0700 (PDT)
Received: from hcdev-d520mt2.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id t9-20020a170902e84900b001bf8779e051sm6749403plg.289.2023.08.28.02.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 02:19:56 -0700 (PDT)
From:   Marvin Lin <milkfafa@gmail.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        andrzej.p@collabora.com
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        kwliu@nuvoton.com, kflin@nuvoton.com,
        Marvin Lin <milkfafa@gmail.com>
Subject: [PATCH v14 5/7] media: v4l2-ctrls: Add user control base for Nuvoton NPCM controls
Date:   Mon, 28 Aug 2023 17:18:57 +0800
Message-Id: <20230828091859.3889817-6-milkfafa@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230828091859.3889817-1-milkfafa@gmail.com>
References: <20230828091859.3889817-1-milkfafa@gmail.com>
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

Add a control base for Nuvoton NPCM driver controls, and reserve 16
controls.

Signed-off-by: Marvin Lin <milkfafa@gmail.com>
---
 include/uapi/linux/v4l2-controls.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index c3604a0a3e30..68db66d4aae8 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -203,6 +203,12 @@ enum v4l2_colorfx {
  */
 #define V4L2_CID_USER_ASPEED_BASE		(V4L2_CID_USER_BASE + 0x11a0)
 
+/*
+ * The base for Nuvoton NPCM driver controls.
+ * We reserve 16 controls for this driver.
+ */
+#define V4L2_CID_USER_NPCM_BASE			(V4L2_CID_USER_BASE + 0x11b0)
+
 /* MPEG-class control IDs */
 /* The MPEG controls are applicable to all codec controls
  * and the 'MPEG' part of the define is historical */
-- 
2.34.1

