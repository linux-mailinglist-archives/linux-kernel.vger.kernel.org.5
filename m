Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17627D667E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbjJYJQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233880AbjJYJP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:15:57 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFEF138;
        Wed, 25 Oct 2023 02:15:55 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so847644266b.3;
        Wed, 25 Oct 2023 02:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698225354; x=1698830154; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sA3KLuKCI9H+7Y8UJbCOZUdVsc0t74/8ar37Z4W1LJA=;
        b=heeWbtRKQYAeHE6jWukhEJhuRNIoHMLldJLnXLPmcBJ/ATIwAjeyjFDVhJWT4CTaMQ
         ghn4ETGXeUrtNSWzQaxr5RFTZ28igFa5CYZfQ8KOZ27lQnj38HBSlLE4ltQKk0E4ASG0
         oo20b7wjzKVP0BwL5v4qcVpPE5TDfQzml9Z69KviQEng9pCnOivA0mQy6wd6jJ/9GxEP
         iwJ/sFSuHzXladx9YUl97NMnLy50Tc1PEzj0eanHd0sjHsmZ0FMOGhgvE1wzAIPCR5i9
         12ozVxfEqTtxx8gHDwO7vKcuGsqMV2dHwnrFqpqX1uoNmspYWxvFXr7Or0YigdpDldsa
         i99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698225354; x=1698830154;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sA3KLuKCI9H+7Y8UJbCOZUdVsc0t74/8ar37Z4W1LJA=;
        b=uyLBNAk2p2as7/56CzT3r0dmT4eFCnZoczYMme9iRjbiZAEt5MeCYF++592qFu7b6t
         RAKsj7C8+BonYDTz0ESgEq5jzj5Gyf13luY75PXZqSfA3tv+jo8IplYSa0QMZEoIHY2W
         qgcYTpprrfz1/t/FJJq0maWR31buo9E2H+DFcR/VD5y/56hkIuce3anfvhCe8Zx7JcIf
         XRHhCwY0uxXqQYmPAmTQ8WgwawORdSx7hdrTj6jiDZKZ6QQKfMUqSL8YASB3g+1lP9Oq
         eKrxCtGFpomF6sNtm6Nauds43Ged9hCyw2MTMLvd4JLItmYirXmh5MWsXe7X/dUIgkTX
         YcVw==
X-Gm-Message-State: AOJu0Yzw1wAVQxkBCVSOTGcHj9c3r1oWJHAD2a7KZ3II3l+E7GpC0bZ6
        xNSht2+EEpTSkxjkpJEdz3M=
X-Google-Smtp-Source: AGHT+IE0Mv6Iod3FRLXOFtaujOuioouSP5SZ3DRcTBOCmppK4r5+q19s0X13iI5wN/hT3yxSyw69Pw==
X-Received: by 2002:a17:906:7311:b0:9bd:9507:ed1c with SMTP id di17-20020a170906731100b009bd9507ed1cmr12678504ejc.18.1698225353936;
        Wed, 25 Oct 2023 02:15:53 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:2cbd:f9ec:f035:ebea])
        by smtp.gmail.com with ESMTPSA id cw23-20020a170906c79700b0099cce6f7d50sm9546446ejb.64.2023.10.25.02.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 02:15:53 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jagath Jog J <jagathjog1996@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: correct file entry in BOSCH SENSORTEC BMI323 IMU IIO DRIVER
Date:   Wed, 25 Oct 2023 11:15:50 +0200
Message-Id: <20231025091550.21052-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b512c767e7bc ("iio: imu: Add driver for BMI323 IMU") adds the
MAINTAINERS section BOSCH SENSORTEC BMI323 IMU IIO DRIVER and refers to a
non-existing device-tree file.

Probably, this mistake was introduced by copying from the BOSCH SENSORTEC
BMA400 ACCELEROMETER IIO DRIVER section and missing to adjust the file
entry properly. This is however easily caught, as the script
./scripts/get_maintainer.pl --self-test=patterns complains about a broken
reference.

The related commit 77583938740e ("dt-bindings: iio: imu: Add Bosch BMI323")
adds bosch,bmi323.yaml, so refer to that intended file instead.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a493d96ffd85..82ba3695f614 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3642,7 +3642,7 @@ BOSCH SENSORTEC BMI323 IMU IIO DRIVER
 M:	Jagath Jog J <jagathjog1996@gmail.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/iio/imu/bosch,bma400.yaml
+F:	Documentation/devicetree/bindings/iio/imu/bosch,bmi323.yaml
 F:	drivers/iio/imu/bmi323/
 
 BPF JIT for ARM
-- 
2.17.1

