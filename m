Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 316CE7797E4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 21:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjHKTkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 15:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235584AbjHKTko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 15:40:44 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D5B30E6;
        Fri, 11 Aug 2023 12:40:43 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76cd8dab98fso172346885a.3;
        Fri, 11 Aug 2023 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691782842; x=1692387642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K8XAdlCauzuqTqX7DL7uCr2jVWlrna5hii1a8kj15JE=;
        b=i6oD9bghJDTu1zIQIV4UtUAx1+dPDP6CDrtzU9vghK3CiuknavQ6GqZJhbsOQVSMI2
         OV8W/NB2Z2SY+Jkf8lUEOxUjQIqmbxHu6jquYhiyp/0M2+yG8f/qDgaq2CbO2dLVp1dq
         +7/kqN0uTWYkwyjAuNnr6AuOtZG/vR6lP0L427ToteS19YuwsytmuMdebanfvGRNNOx5
         3p6DSoODvzu+GeZZd+si7+4RKOumeXVfqkLQLG8yaIArCBk+UWiLylcKWRB56HRCX/vX
         82k9L25AmzIFT5jInmSyANwga3Ke6p4QgJraLbfmT7IY/+7D/ca0rZ788xZWoQBtKi2z
         bVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691782842; x=1692387642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8XAdlCauzuqTqX7DL7uCr2jVWlrna5hii1a8kj15JE=;
        b=Wrvpk0Y/j23ESVsqJn6MHvNY3GDYEebQTAl2LHSGbThaxtVDMn1nOFlPX5w1EktesT
         Vwo0akzYrblHAkPb86MpPpq08/JQuOOIR6Dsk5hisH98otgxt6IwL8TPKndWNktLqVgs
         Jg6JInolMI/+bZ8ByqxtAkGhdfgdfARlCMxXp1E0PzermtKdJFjDEH3BKFiH/2DS1cyZ
         FVxpJ0xVbgSkBv/+dhW6mJECn8pnAGLNRMHx3QKn19a+1WZoHbgYudzww5a2G3M/tAR+
         eZIZUgydD7ShWj6sy/H88exH/6vW+2SuCvEICC1XJJ2RymDNwfelYm/TjHwGn6DAXMxe
         6tZg==
X-Gm-Message-State: AOJu0Yzu9vMp00iJbvY+ZVG/xrPsu1n+VSVse+/BjYSRj2utnswQVPbg
        pSq/DIB/iI2+njvgHZTnmqbOuiZLPRx0rg==
X-Google-Smtp-Source: AGHT+IEd6FKDf2LUftPdhsoDiwuk7hY3RyxprWEjQIOiy+tECLHywU9E044swelPCq0F+bD0scVt7w==
X-Received: by 2002:a05:620a:24c:b0:767:4016:29f3 with SMTP id q12-20020a05620a024c00b00767401629f3mr2941226qkn.58.1691782842614;
        Fri, 11 Aug 2023 12:40:42 -0700 (PDT)
Received: from localhost.localdomain ([92.85.190.61])
        by smtp.gmail.com with ESMTPSA id j1-20020ac84f81000000b003ef2db16e72sm1375329qtw.94.2023.08.11.12.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 12:40:42 -0700 (PDT)
From:   Andrei Coardos <aboutphysycs@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     samuel@sholland.org, jernej.skrabec@gmail.com, wens@csie.org,
        rui.zhang@intel.com, amitk@kernel.org, daniel.lezcano@linaro.org,
        rafael@kernel.org, tiny.windzz@gmail.com, anarsoul@gmail.com,
        alex@shruggie.ro, Andrei Coardos <aboutphysycs@gmail.com>
Subject: [PATCH] thermal: sun8i_thermal: remove unneeded call to platform_set_drvdata()
Date:   Fri, 11 Aug 2023 22:40:32 +0300
Message-Id: <20230811194032.4240-1-aboutphysycs@gmail.com>
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

Signed-off-by: Andrei Coardos <aboutphysycs@gmail.com>
---
 drivers/thermal/sun8i_thermal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 195f3c5d0b38..61a2f287ac90 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -489,8 +489,6 @@ static int sun8i_ths_probe(struct platform_device *pdev)
 	if (!tmdev->chip)
 		return -EINVAL;
 
-	platform_set_drvdata(pdev, tmdev);
-
 	ret = sun8i_ths_resource_init(tmdev);
 	if (ret)
 		return ret;
-- 
2.34.1

