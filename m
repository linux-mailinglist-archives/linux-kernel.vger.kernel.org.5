Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB38782830
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233572AbjHULsK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232840AbjHULsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:48:09 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B597C8F;
        Mon, 21 Aug 2023 04:47:54 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-99df11828c6so905628866b.1;
        Mon, 21 Aug 2023 04:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692618473; x=1693223273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MsrwkYf7K0lgiDG3iCSfg0x/ZmatG8FqzDLTncHznkU=;
        b=D31ByfL0BNpgDBk/TL7P2MbplAb6XwGFOnEYjHvhajiMsbxh1DZoSp45Rlp8En86Fb
         qgJRsmM7Ib3r0Z1mIa+b5ZLtwUq/ifUqoAEsBKlh4/5O4ixEaoZMOdoF0MUZkNHGX23/
         knqCEME6n1GMugR1jRsMwPbSXGZHJb5Fp1pkJWk2dxBa53mHTia8MHIJU7m0Mgifi36u
         xJ4bVEklm3fTR6S3fpScxVqb1AsgvaI51Bqotjx7xz/TOeaIy+IqdCYZvyG4BfgW5BQZ
         fe2Lw9lA93MTGMWhfOJc/d8124QRrtTI2g/1xT66m8KdVZhpmJvwklo8kSnd+RFKUhEN
         VUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692618473; x=1693223273;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsrwkYf7K0lgiDG3iCSfg0x/ZmatG8FqzDLTncHznkU=;
        b=U+FSxOdc/SmC7DI6QUdvmNlWs86Ak9sImhF+JEa3ZYKc8pzUHC4J8P/ismKIMAFrLX
         RfSJxOjNzZB7HW9LqkNaidirsWoiydbnwLC+J1uzRjXbNUXXa96kdpAiUfUY55W//4v3
         kueMIMg9b7t65JuzvyYyzwgcvd/3qYkR+1quuUcPivZMUi6SdjVluJ5dfRuHN1DyAon4
         Go9OeJ0CgXCU7g7J9WXpN1Gie7wItH5qOWz9xRtrOSKdhLEmfOJr8VHTLX75VAE8R8k3
         9/glMhVbxcaoZZDWcP3+3VPZNctA/gjPRPdoC79clA/huFWin8X1de0BuHJeEoz2OrRP
         VlFA==
X-Gm-Message-State: AOJu0YzxhXOQ0mzGSZqmKGjTFzzemh7l9EOlRNkpgqGe1bvK9AW0haUv
        cpq3wJwX/nJqbS53rFOoIMA=
X-Google-Smtp-Source: AGHT+IHs37M9ktg0UVe2eMKGao+aWkyU6IK8wcjvq5VMUkCbPpdd0zw9QMUUWIuhccdNjDrD4L+g2A==
X-Received: by 2002:a17:907:a04a:b0:994:5407:9ac9 with SMTP id gz10-20020a170907a04a00b0099454079ac9mr6213305ejc.5.1692618472851;
        Mon, 21 Aug 2023 04:47:52 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f1e5c0018f3132f38fbfb3b.dip0.t-ipconnect.de. [2003:cf:9f1e:5c00:18f3:132f:38fb:fb3b])
        by smtp.googlemail.com with ESMTPSA id e16-20020a170906045000b0098dfec235ccsm6354983eja.47.2023.08.21.04.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 04:47:52 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Carns <mike@carns.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (asus-ec-sensosrs) fix mutex path for X670E Hero
Date:   Mon, 21 Aug 2023 13:47:24 +0200
Message-ID: <20230821114736.25229-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.41.0
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

A user reported that they observe race condition warning [1] and after
looking once again into the DSDT source it was found that wrong mutex
was used.

Fixes: 790dec13c012 ("hwmon: (asus-ec-sensors) add ROG Crosshair X670E Hero.")
Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>
---
 drivers/hwmon/asus-ec-sensors.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
index f52a539eb33e..51f9c2db403e 100644
--- a/drivers/hwmon/asus-ec-sensors.c
+++ b/drivers/hwmon/asus-ec-sensors.c
@@ -340,7 +340,7 @@ static const struct ec_board_info board_info_crosshair_x670e_hero = {
 	.sensors = SENSOR_TEMP_CPU | SENSOR_TEMP_CPU_PACKAGE |
 		SENSOR_TEMP_MB | SENSOR_TEMP_VRM |
 		SENSOR_SET_TEMP_WATER,
-	.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
+	.mutex_path = ACPI_GLOBAL_LOCK_PSEUDO_PATH,
 	.family = family_amd_600_series,
 };
 
-- 
2.41.0

