Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741E6771EB4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjHGKrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjHGKrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:47:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C3E1BD8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 03:47:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so3819083f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 03:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691405165; x=1692009965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sCx9YJZnsVfzC3MwgVAa6Vuv6aGhMRIxY/5pPdiDPwE=;
        b=FQpZwsxQ3yNVRMCMo7Mf6/QqTYVkYvcMLfg52+hj0L9V5AWtDyihsqa45B8aBPVPio
         h55uCiay3sQcVG4lOG4ACxOT1TsnOfx3rkSzI4ZnY6srhr7112J71ERBBa1kCK68HCI5
         EDQ3OE2pWiFLkagT+wGzfJaT3MQNI9jxWkSSLhWbrNEwt9UdW2eAjDEZeslFTI1sYLkb
         kp9XUu5K2hRsTLmMAx7DWFz1xwisaODls3Il1FJfOGqnHWJVeUOUqzjueoHe3rpIowit
         7i4zhM/5skEQaUmAIrMpXp0xCYGWatfRumME2C/5MjIaGI1+esObvznyR4HctHgGe7dO
         eSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691405165; x=1692009965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sCx9YJZnsVfzC3MwgVAa6Vuv6aGhMRIxY/5pPdiDPwE=;
        b=cLuhe0a6t91eZCTFfYhtLCWqQCyRIodw66QWl13txFwA706WZuPYvptdqyVJZq/d56
         GJpnG2w4SjakuOV7AEjDfTvRS36KMBinqwJ59qa2tdcG2Bkn4kFflpitZSgpdPbHLjNq
         zisqneeOWhNTP5jxqdlhTCLlaEmx0VpmDVJUNB+XHxoTbTHpmVWzDxEjdXGxr2YY8HW3
         i3v3H5lNxa8c2OIBYyb6ga0NvMMQYaXMqW+H6+m8L32ahVL4e+wPTUoTKn8aNjHkc9A+
         LiNNgtQCgFvH4Zz+Yauaco/AQzSEzf8BYaiwNgGAO+g7qRj7gQSPMqO/Pss/GkCyPW4k
         b4ew==
X-Gm-Message-State: AOJu0YzDKAHZJsFLfD4QJ2CRzt6aSau7htbB5o8f1fRfOtPkx6hrq1tw
        /mIpZMk1Et0sPvVNOxNMczrfHXVDIuVAsw==
X-Google-Smtp-Source: AGHT+IGgPqgXgVEp2wKzN0EK/+LdBYoy2IHBLtb5WVt0zzg4uJNxA7n1WBatSOj2FGOFfPBma6ABBg==
X-Received: by 2002:adf:f5cd:0:b0:315:8a80:329e with SMTP id k13-20020adff5cd000000b003158a80329emr6718709wrp.40.1691405165446;
        Mon, 07 Aug 2023 03:46:05 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id k2-20020adfe8c2000000b00317ddccb0d1sm6186279wrn.24.2023.08.07.03.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 03:46:05 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     vz@mleia.com, p.zabel@pengutronix.de,
        Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] reset: lpc18xx: remove unneeded call to platform_set_drvdata()
Date:   Mon,  7 Aug 2023 13:45:49 +0300
Message-Id: <20230807104549.11225-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
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

This function call was found to be unnecessary as there is no equivalent
platform_get_drvdata() call to access the private data of the driver. Also,
the private data is defined in this driver, so there is no risk of it being
accessed outside of this driver file.

Reviewed-by: Alexandru Ardelean <alex@shruggie.ro>
Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/reset/reset-lpc18xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/reset/reset-lpc18xx.c b/drivers/reset/reset-lpc18xx.c
index 36ec95518905..28fb85772b3e 100644
--- a/drivers/reset/reset-lpc18xx.c
+++ b/drivers/reset/reset-lpc18xx.c
@@ -188,8 +188,6 @@ static int lpc18xx_rgu_probe(struct platform_device *pdev)
 	rc->rcdev.ops = &lpc18xx_rgu_ops;
 	rc->rcdev.of_node = pdev->dev.of_node;
 
-	platform_set_drvdata(pdev, rc);
-
 	ret = reset_controller_register(&rc->rcdev);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to register device\n");
-- 
2.34.1

