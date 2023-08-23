Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C7B785957
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbjHWN3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbjHWN3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:29:05 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A677E71
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:45 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99cdb0fd093so766865766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692797295; x=1693402095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpG5xoR5nd9ii5gkHdTczwLX0qJ5SYNBKOgpUUODUYc=;
        b=l8TInbpprYKKjSmLPqztStTnQLaDOQ4WZAM/5u21lPDZ4rSEfnD6QWoOyrPPiSXrUw
         I8dx9qULFyBWLXhPRDcFUmJjEcPF8XLi3gU17LKL4zumHc2lAxnqzzq9ORrBzGDGpfvF
         O7Hmf8r1J6w1AqK2E7vMrUTbthz3a6pav4zQ56pTkadMsQg82W/q9X3t67ItdouPE0Bm
         sQkx3Ad7Pp09eqcHdFPNelr99Jr2QmFb4I6B0iqiJ0z5MYAJ5YzuqdyRBPSQtY7gSaJQ
         R8zacdkMS8xbCSd4aqfdJqV3EOZ1aCMnj3cxN3osqfjgE+VU6H/l+Kmfx1O6jvqof2AH
         nHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692797295; x=1693402095;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpG5xoR5nd9ii5gkHdTczwLX0qJ5SYNBKOgpUUODUYc=;
        b=JCWsJwjkXiGERHcwOJBGPgUCuI8rptZ3h6aWHlUM/b4UHzFpHhdHM+/79BuDxO+7Pl
         zrpuhd7z5Q5P7wYpm+9861sAgyLkU7iCOzjiwGS70hc9mOUmrRr2GJmJ6rlDYRglstTW
         flCve4MBQvRyGxfNHKGjyPWSnCYa9KW/7dZm6RjDGnlF9SovDm5hPxyg5qdKKVVX5RHC
         nODRyH/DKrCVPGpcwFkU2Mv+nvPKKLqQI4ATI/2tmhSzNH7xh85d9vJdQ24+bcByi+X9
         jaVorFcQIZak112yCvueFvY5LTAvQ2Quh5dJmK34TXk3oKnYpNU2L7pp3YoSRFbPC7IK
         ezFQ==
X-Gm-Message-State: AOJu0YyFFBEucvNhXCwL4FJ2QxrXVUyq40L0uydaOTCTcW+p49ilsQBz
        3SpTMwT3mXoca17yfkTcedHjpA==
X-Google-Smtp-Source: AGHT+IGe5tUYq2lGffSrcFEi+P/On/3LVJC5XCXymNMf71wiMG6lmBTM6pLm3qNarLKTE7YG/4iuMg==
X-Received: by 2002:a17:907:b13:b0:9a1:ab86:5f22 with SMTP id h19-20020a1709070b1300b009a1ab865f22mr4199856ejl.56.1692797295677;
        Wed, 23 Aug 2023 06:28:15 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709066b8900b009a168ab6ee2sm8918202ejr.164.2023.08.23.06.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:28:14 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Atul Raut <rauji.raut@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 18/22] nvmem: u-boot-env:: Replace zero-length array with DECLARE_FLEX_ARRAY() helper
Date:   Wed, 23 Aug 2023 14:27:40 +0100
Message-Id: <20230823132744.350618-19-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
References: <20230823132744.350618-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1096; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=mWBWe4rh+kPtTnqOe/blsRW6+/JjZTf7flOWsDLfoDc=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBk5glJn9eO3VdB4VQM31DoyOT3l+m/gLekd6yqQ vlEXd05urGJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZOYJSQAKCRB6of1ZxzRV N9siCACqqYOwlqkc0WutSw13xTi2s+Vs2kfSU7Ks9cpWl0qHA9GMKsjRa+U2YpgtaK7yJWoW/CV 8oHqr/BfMrynF6kVUsnkiPT8VJyeTg/YO0FbrtvY/XnKXUccDeqwem3LolcEI/v8cxoK/1h1uap t053KEkvIvMuEEwhhSkh/kOJ6nImRyquL/CqmtQpnKzZJRl4NW44wa+9DzZkFb+glND+YwoE46n +yTMA7bc4AzvRIzqxNFism7wAIssknV+LBrtkJZ0u3+AeXQWeLqyHB6QdJtfKnKbKXf4AA8gJeC MS2/QztT4gedOwvZPy8DfL3GZuoL3z65I2azQX5CMBj865g0
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atul Raut <rauji.raut@gmail.com>

We are moving toward replacing zero-length arrays with C99 flexible-array
members since they are deprecated. Therefore, the new DECLARE_FLEX_ARRAY()
helper macro should be used to replace the zero-length array declaration.

This fixes warnings such as:
./drivers/nvmem/u-boot-env.c:50:9-13: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: Atul Raut <rauji.raut@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/u-boot-env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 80c5382b361c..c4ae94af4af7 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -47,7 +47,7 @@ struct u_boot_env_image_broadcom {
 	__le32 magic;
 	__le32 len;
 	__le32 crc32;
-	uint8_t data[0];
+	DECLARE_FLEX_ARRAY(uint8_t, data);
 } __packed;
 
 static int u_boot_env_read(void *context, unsigned int offset, void *val,
-- 
2.25.1

