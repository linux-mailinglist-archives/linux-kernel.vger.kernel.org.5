Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B181F771EF6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 12:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjHGK4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 06:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjHGK4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 06:56:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CE910FA
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 03:56:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31781e15a0cso3434284f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 03:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691405803; x=1692010603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4gQSZNoRcqRFc5FMPIfwXmvbkRG/RFx8xDgh+e9RtnA=;
        b=VvN7Hv70GUM0Z3eZ4ZQCroTdSFvYYchfCsn1G7PyUWNnBuoH45XrWFHPZYT+h0rWgE
         6jj76javVWi8JHVBl1kNDBvSrtJZLeghGjNE1CQ1PX2qnx2mkFe2ZQukcb34hadhHAWq
         Y4vvFTaTO6DSFiaQHbWU1CcQBOn/DFxKEmDVdBYS2nG1qzVYSQ51MEzdABwdDklzx4gO
         UQXmNxk1wsU4ART6ad9QbkooeEVk0V/Meb5F1S93Sgxznc1aHS17sMNysZLIsLzI8xo7
         lHwLLIdtlVliQerh7mshfvGt6wJCUAKaOKvChta5RYjvMSY0hAB2K5dEpQ2e69SA5p9K
         XkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691405803; x=1692010603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4gQSZNoRcqRFc5FMPIfwXmvbkRG/RFx8xDgh+e9RtnA=;
        b=BGVqn/bAWldexCORKYjmARTVQFNZ3MDgSQutX48QngNPHj7oO+XCZMYghHTKW0RxvS
         4fb00w2BSm/UH9ZafzRQ2Es52ECPbDBh1NDVFTime/7kv2O+lsNW57URAZjyvhtPfhvd
         mn7WIy4uy+M7OqbGpAJGIGofN5q/okTl8pihADYG576EwzijnVeJKvxME6zEJr5VIBXT
         3iNgr5+RYtQaQo+NTAjuxB9VfyJ/OfwaRoRDBo632Ka7PRVDila3op2p1aAaSCOSXkRB
         ZtmxAcXqzvcjQzUlFjb0rX+nkyke+XdSQNNTDfTkZwAPVhJQiOQNaO4/Eq8FHfZwr7fP
         b+Ew==
X-Gm-Message-State: AOJu0YyniflBJ8CakHn1Hr6LGfkyFB7421wbeFWDDTLz9S0BynCaVhc1
        cZUGbS91r4keZXpo+3j5b1+zZ72Ng/V4VA==
X-Google-Smtp-Source: AGHT+IHtUGbgz+Xxf/xMBWxowOlmwVZhbHXqxZDbjGaUkM2FTQ5yNOB8UxlFUNMvDD8CXcOJrorvlg==
X-Received: by 2002:adf:de0f:0:b0:317:61d8:3c83 with SMTP id b15-20020adfde0f000000b0031761d83c83mr5486639wrm.3.1691405802652;
        Mon, 07 Aug 2023 03:56:42 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id o1-20020adfeac1000000b00317643a93f4sm10149763wrn.96.2023.08.07.03.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 03:56:42 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     p.zabel@pengutronix.de, benjaminfair@google.com, yuenn@google.com,
        venture@google.com, tali.perry1@gmail.com, tmaimon77@gmail.com,
        avifishman70@gmail.com, Andrei Coardos <aboutphysycs@gmail.com>,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: [PATCH] reset: npcm: remove unneeded call to platform_set_drvdata()
Date:   Mon,  7 Aug 2023 13:56:30 +0300
Message-Id: <20230807105630.11638-1-aboutphysycs@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
 drivers/reset/reset-npcm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/reset/reset-npcm.c b/drivers/reset/reset-npcm.c
index f2333506b0a6..f6c4f854f2be 100644
--- a/drivers/reset/reset-npcm.c
+++ b/drivers/reset/reset-npcm.c
@@ -394,8 +394,6 @@ static int npcm_rc_probe(struct platform_device *pdev)
 	rc->rcdev.of_reset_n_cells = 2;
 	rc->rcdev.of_xlate = npcm_reset_xlate;
 
-	platform_set_drvdata(pdev, rc);
-
 	ret = devm_reset_controller_register(&pdev->dev, &rc->rcdev);
 	if (ret) {
 		dev_err(&pdev->dev, "unable to register device\n");
-- 
2.34.1

