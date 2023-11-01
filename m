Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048677DE3C9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233066AbjKAPRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjKAPRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:17:12 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30909D44;
        Wed,  1 Nov 2023 08:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=3dj/SzQCMYEV8JiersO7itjHD8Hx/T7dliSNS/XF7wk=; b=TIHizCpGG2gOLXLj/PnjAHXPyW
        U7v+2Y9R+GHnNY0cjHv0XcnG1k9IeR3pQNrc1yzxBFWOPsLF9oLoSx7Tn+wVr6ys58NPgvTqnpOw8
        FhLmufIhaT+PpWDXiw38qB2k38DVuJbnrfUnGF5LtW6l/Hq0xZy3yMiIkpp7IXGIhi+hxO4a4qEJn
        sG3qL13z2H8L2g5pWPwgOTS0gYY6clcu7RiwLX03jdEKyE3ntoUXKvZgNmmLHNfeZFrdv0Luck41l
        xZIvUEyIfJsSxibIMdTBOA6m2zP/H6bxiaJJDLV9pAdwEACwMPW0SyRSTfP61qm/vXm7FeLveewdL
        WdDreyIg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1qyCxQ-000EdY-HH; Wed, 01 Nov 2023 16:16:36 +0100
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1qyCxQ-000WPw-5b; Wed, 01 Nov 2023 16:16:36 +0100
From:   Sean Nyekjaer <sean@geanix.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] iio: accel: st_accel: silent spi_device_id warnings
Date:   Wed,  1 Nov 2023 16:16:12 +0100
Message-ID: <20231101151612.4159362-1-sean@geanix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27079/Wed Nov  1 08:41:09 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add and correct spi_device_id entries to silent following warnings:
 SPI driver st-accel-spi has no spi_device_id for st,lis302dl-spi
 SPI driver st-accel-spi has no spi_device_id for st,lis3lv02dl-accel
 SPI driver st-accel-spi has no spi_device_id for st,lis3dh-accel
 SPI driver st-accel-spi has no spi_device_id for st,lsm330d-accel
 SPI driver st-accel-spi has no spi_device_id for st,lsm330dl-accel
 SPI driver st-accel-spi has no spi_device_id for st,lsm330dlc-accel
 SPI driver st-accel-spi has no spi_device_id for st,lis331dlh-accel
 SPI driver st-accel-spi has no spi_device_id for st,lsm330-accel
 SPI driver st-accel-spi has no spi_device_id for st,lsm303agr-accel
 SPI driver st-accel-spi has no spi_device_id for st,lis2dh12-accel
 SPI driver st-accel-spi has no spi_device_id for st,lng2dm-accel
 SPI driver st-accel-spi has no spi_device_id for st,h3lis331dl-accel
 SPI driver st-accel-spi has no spi_device_id for st,lis331dl-accel
 SPI driver st-accel-spi has no spi_device_id for st,lsm303c-accel

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Is the names with underscore from ACPI or?
Is it fine to do this?

 drivers/iio/accel/st_accel.h     | 35 ++++++++++++++++----------------
 drivers/iio/accel/st_accel_spi.c |  1 +
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index e7525615712b..817ccd0423d5 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -14,30 +14,31 @@
 #include <linux/types.h>
 #include <linux/iio/common/st_sensors.h>
 
-#define H3LIS331DL_ACCEL_DEV_NAME	"h3lis331dl_accel"
-#define LIS3LV02DL_ACCEL_DEV_NAME	"lis3lv02dl_accel"
-#define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc_accel"
-#define LIS3DH_ACCEL_DEV_NAME		"lis3dh"
-#define LSM330D_ACCEL_DEV_NAME		"lsm330d_accel"
-#define LSM330DL_ACCEL_DEV_NAME		"lsm330dl_accel"
-#define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc_accel"
-#define LIS331DL_ACCEL_DEV_NAME		"lis331dl_accel"
-#define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh"
-#define LSM303DL_ACCEL_DEV_NAME		"lsm303dl_accel"
-#define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh_accel"
-#define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm_accel"
-#define LSM330_ACCEL_DEV_NAME		"lsm330_accel"
-#define LSM303AGR_ACCEL_DEV_NAME	"lsm303agr_accel"
-#define LIS2DH12_ACCEL_DEV_NAME		"lis2dh12_accel"
+#define H3LIS331DL_ACCEL_DEV_NAME	"h3lis331dl-accel"
+#define LIS3LV02DL_ACCEL_DEV_NAME	"lis3lv02dl-accel"
+#define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc-accel"
+#define LIS3DH_ACCEL_DEV_NAME		"lis3dh-accel"
+#define LSM330D_ACCEL_DEV_NAME		"lsm330d-accel"
+#define LSM330DL_ACCEL_DEV_NAME		"lsm330dl-accel"
+#define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc-accel"
+#define LIS331DL_ACCEL_DEV_NAME		"lis331dl-accel"
+#define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh-accel"
+#define LSM303DL_ACCEL_DEV_NAME		"lsm303dl-accel"
+#define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh-accel"
+#define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm-accel"
+#define LSM330_ACCEL_DEV_NAME		"lsm330-accel"
+#define LSM303AGR_ACCEL_DEV_NAME	"lsm303agr-accel"
+#define LIS2DH12_ACCEL_DEV_NAME		"lis2dh12-accel"
 #define LIS3L02DQ_ACCEL_DEV_NAME	"lis3l02dq"
-#define LNG2DM_ACCEL_DEV_NAME		"lng2dm"
+#define LNG2DM_ACCEL_DEV_NAME		"lng2dm-accel"
 #define LIS2DW12_ACCEL_DEV_NAME		"lis2dw12"
 #define LIS3DHH_ACCEL_DEV_NAME		"lis3dhh"
 #define LIS3DE_ACCEL_DEV_NAME		"lis3de"
 #define LIS2DE12_ACCEL_DEV_NAME		"lis2de12"
 #define LIS2HH12_ACCEL_DEV_NAME		"lis2hh12"
 #define LIS302DL_ACCEL_DEV_NAME		"lis302dl"
-#define LSM303C_ACCEL_DEV_NAME		"lsm303c_accel"
+#define LIS302DL_SPI_ACCEL_DEV_NAME	"lis302dl-spi"
+#define LSM303C_ACCEL_DEV_NAME		"lsm303c-accel"
 #define SC7A20_ACCEL_DEV_NAME		"sc7a20"
 #define IIS328DQ_ACCEL_DEV_NAME		"iis328dq"
 
diff --git a/drivers/iio/accel/st_accel_spi.c b/drivers/iio/accel/st_accel_spi.c
index f72a24f45322..749d770d2350 100644
--- a/drivers/iio/accel/st_accel_spi.c
+++ b/drivers/iio/accel/st_accel_spi.c
@@ -160,6 +160,7 @@ static const struct spi_device_id st_accel_id_table[] = {
 	{ LIS3DHH_ACCEL_DEV_NAME },
 	{ LIS3DE_ACCEL_DEV_NAME },
 	{ LIS302DL_ACCEL_DEV_NAME },
+	{ LIS302DL_SPI_ACCEL_DEV_NAME },
 	{ LSM303C_ACCEL_DEV_NAME },
 	{ IIS328DQ_ACCEL_DEV_NAME },
 	{},
-- 
2.42.0

