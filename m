Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAEF78284B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbjHULyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjHULyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:54:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EF7B4;
        Mon, 21 Aug 2023 04:54:33 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso32295915e9.0;
        Mon, 21 Aug 2023 04:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692618872; x=1693223672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfo3UfcHq3qTP7xq69y2LHXVdBJZiALzOur1Qe3EZWs=;
        b=ite4L3075LUlwoSK5AcOoalNM78E5yOfOaQyHG8MLmnRh0QZxJlDHHZ3RBIVku0yyI
         MIs3YVK6XFWs+VYTTCKSNJgcKUZADgXrstvP4FjAPuarMibmgxNNmDf+IeXXIOsOi7DN
         SURkZcvD+MIWCEGDCl6zg43UrkHq1WoPZJFihcCaq0w0wwHJT9eb8FYD/nY+EJpST+DM
         9invXp8Scp5UO1qJIAg4XO5FRASVb2BfYNR1/7TFP17lk5d1Xc2WiMm8MU0S4EphD5A0
         odzip3a2/iHqdoEheNx6pWDg7Db2kvEZdSXTYrQMgQYsuRUaTWT/nIHMUiP5d/Pcjicm
         1pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692618872; x=1693223672;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vfo3UfcHq3qTP7xq69y2LHXVdBJZiALzOur1Qe3EZWs=;
        b=iv/Rtl9kPneFT7u7/W4/z+Rb/RJUQic81d60tnVq1D3SvlIiBFLjDVaWjwZ4/pjcwm
         8f9pJ97IfPIxMvVRQpKdA+glsmtqBSy1y/tomGwkpjKohsxDWZqMZ9fFwAaOmM49QYlG
         N3GdyDeqCCIjhEJk6PMTvj5eA2DWXiLwC2pZsbJGccYOHNacxuuwbb+1Yc9GwNDM7JUf
         wzC23Es95Ml0j9/ErJTJ01ogtk9h12+Ma6+B72E1bV+/CaFXVYeYuc1302v5kRxI7xKa
         j21DgttzAfA3BN7H+qGM4gF2VKN2Jf/q/w8fx5bbt5wn9EgpKswTUj3O79npLfPrrosb
         +JeQ==
X-Gm-Message-State: AOJu0YwdRPbn7jyitjN0sE6h3biISIED/P2AkMaAfiUOXkrYbNJMSKOm
        p6pGKV8vPcTZ0K9m4qOyohBgQyln6weJMQ==
X-Google-Smtp-Source: AGHT+IECqc8E3xfu3L0n3UoU9QVvP6Ck/Iu6AMAOmYMP2UfNF+5gUwvJbhOPhDNm8RenOMiCt9EUag==
X-Received: by 2002:a7b:cbc8:0:b0:3fe:e1e:5041 with SMTP id n8-20020a7bcbc8000000b003fe0e1e5041mr5045789wmi.32.1692618872378;
        Mon, 21 Aug 2023 04:54:32 -0700 (PDT)
Received: from caracal.museclub.art (p200300cf9f1e5c0018f3132f38fbfb3b.dip0.t-ipconnect.de. [2003:cf:9f1e:5c00:18f3:132f:38fb:fb3b])
        by smtp.googlemail.com with ESMTPSA id w3-20020a05600c014300b003fe0a0e03fcsm15954649wmm.12.2023.08.21.04.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 04:54:31 -0700 (PDT)
From:   Eugene Shalygin <eugene.shalygin@gmail.com>
To:     eugene.shalygin@gmail.com
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Michael Carns <mike@carns.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] hwmon: (asus-ec-sensosrs) fix mutex path for X670E Hero
Date:   Mon, 21 Aug 2023 13:52:35 +0200
Message-ID: <20230821115418.25733-2-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821115418.25733-1-eugene.shalygin@gmail.com>
References: <20230821115418.25733-1-eugene.shalygin@gmail.com>
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

[1] https://github.com/zeule/asus-ec-sensors/issues/43

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

