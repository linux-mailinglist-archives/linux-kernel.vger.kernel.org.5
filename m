Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03758753C22
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbjGNNvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235548AbjGNNvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:51:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6B135A5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:51:35 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-992b66e5affso258342766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689342693; x=1691934693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHsTvrtvB0wpJ5anwtL0i/1V0CIzWke0nwnI3nLvsbc=;
        b=OarhMORPdTqodyKTz+n9Bmwx/YU5UO+bixsCXkwLRx6/X09260oSz5vM5r5kYUHojj
         gnlZCodUReICh2FtUvCnlzIY/MkT2401wyrAUOMuJ55pEdzrXpdMH2j9mo4K+GqTyhC8
         4K6mtRQGgavu0L7YxK+Ik19TquIi3MBSDzvitj9oaOzZZznoptRIdWveZVC+CiCEfNtO
         gVQESzTlv7ULoa0X4g14KHW4cjsWQYRJ7nN4JwOEOhO/CWMj7zEWBptvnEADtiCzZmgs
         zV553i8BvzjZ0lgUfr7Rn+VYBUajr8H24zjlyCYscAYtX5A4YbGMvO4jCXXE51Wk4Tsl
         3rYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342693; x=1691934693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHsTvrtvB0wpJ5anwtL0i/1V0CIzWke0nwnI3nLvsbc=;
        b=UnlMGOBEBnqYNWNMXGRvpX91hLQRmCldXiuvjvLKjahd0JljA9LGkSEwqvmY+HZ2zW
         wXFPjlm0ZSJfzR5/rb/aYodDDThXmVLFtxDhPQPoFjI4QE+0tWAZd+DCfSxVcAdqXo4P
         rGJMurH9V2YbDSdGzigWd5OqAmMmV33BVWGfljvEoFTpVBcfJD1MvJ+cNRPeRzJ8x4rf
         Dy1O2wK2g38KIH+JxFpOxhXWHbjunFloO21WDJlDRjM2OCY9XwNgFrGam098GcqHoSvq
         M60gpucmNLRxbRz7WnJQenwz/AscokcWdaWP+8p6Ze6mPGONv4c8WdoieQQlWId4BzXv
         f9hQ==
X-Gm-Message-State: ABy/qLbOAa4/G/d9U822Msoct3o5s2FtgVXSJsMLu4F9kixPZieoOy1y
        Eaz3NRR0kBXNLewNDtIsYnj/1cBFm6GR0olXVOQ/dQ==
X-Google-Smtp-Source: APBJJlHo4VBqo5Rpq2M+oWinQDm/nj7cC3EwMWbeei+MEmrFDvKeXdOuWQhrZjRgpYvdLonJal6ETA==
X-Received: by 2002:a17:906:748c:b0:993:ed3c:dee2 with SMTP id e12-20020a170906748c00b00993ed3cdee2mr4417056ejl.5.1689342693513;
        Fri, 14 Jul 2023 06:51:33 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906261500b0099236e3f270sm5405991ejc.58.2023.07.14.06.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:51:33 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v2 4/8] hwmon: (pmbus/mp2975) Simplify VOUT code
Date:   Fri, 14 Jul 2023 15:51:12 +0200
Message-ID: <20230714135124.2645339-4-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
References: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

In order to upstream MP2973/MP2971 simplify the code by removing support
for various VOUT formats. The MP2973 and MP2971 supports all PMBUS
supported formats for VOUT, while the MP2975 only support DIRECT and
VID for VOUT.

In DIRECT mode all chips report the voltage in 1mV/LSB.

Configure the chip to use DIRECT format for VOUT and drop the code
conversion code for other formats. The to be added chips MP2973/MP2971
will be configured to also report VOUT in DIRECT format.

The maximum voltage that can be reported in DIRECT format is 32768mV.
This is sufficient as the maximum output voltage for VR12/VR13 is
3040 mV.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
Changes in V2:
- Do i2c write back only if needed.
- Update comment to align with change.
---
 drivers/hwmon/pmbus/mp2975.c | 60 ++++++------------------------------
 1 file changed, 10 insertions(+), 50 deletions(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index 04778f2dcbdb..0dca4c24fe5a 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -70,7 +70,6 @@ struct mp2975_data {
 	int vref_off[MP2975_PAGE_NUM];
 	int vout_max[MP2975_PAGE_NUM];
 	int vout_ov_fixed[MP2975_PAGE_NUM];
-	int vout_format[MP2975_PAGE_NUM];
 	int curr_sense_gain[MP2975_PAGE_NUM];
 };
 
@@ -83,22 +82,6 @@ MODULE_DEVICE_TABLE(i2c, mp2975_id);
 
 #define to_mp2975_data(x)  container_of(x, struct mp2975_data, info)
 
-static int mp2975_read_byte_data(struct i2c_client *client, int page, int reg)
-{
-	switch (reg) {
-	case PMBUS_VOUT_MODE:
-		/*
-		 * Enforce VOUT direct format, since device allows to set the
-		 * different formats for the different rails. Conversion from
-		 * VID to direct provided by driver internally, in case it is
-		 * necessary.
-		 */
-		return PB_VOUT_MODE_DIRECT;
-	default:
-		return -ENODATA;
-	}
-}
-
 static int
 mp2975_read_word_helper(struct i2c_client *client, int page, int phase, u8 reg,
 			u16 mask)
@@ -273,24 +256,6 @@ static int mp2975_read_word_data(struct i2c_client *client, int page,
 		ret = DIV_ROUND_CLOSEST(data->vref[page] * 10 - 50 *
 					(ret + 1) * data->vout_scale, 10);
 		break;
-	case PMBUS_READ_VOUT:
-		ret = mp2975_read_word_helper(client, page, phase, reg,
-					      GENMASK(11, 0));
-		if (ret < 0)
-			return ret;
-
-		/*
-		 * READ_VOUT can be provided in VID or direct format. The
-		 * format type is specified by bit 15 of the register
-		 * MP2975_MFR_DC_LOOP_CTRL. The driver enforces VOUT direct
-		 * format, since device allows to set the different formats for
-		 * the different rails and also all VOUT limits registers are
-		 * provided in a direct format. In case format is VID - convert
-		 * to direct.
-		 */
-		if (data->vout_format[page] == vid)
-			ret = mp2975_vid2direct(info->vrm_version[page], ret);
-		break;
 	case PMBUS_VIRT_READ_POUT_MAX:
 		ret = mp2975_read_word_helper(client, page, phase,
 					      MP2975_MFR_READ_POUT_PK,
@@ -578,20 +543,20 @@ mp2975_vout_max_get(struct i2c_client *client, struct mp2975_data *data,
 }
 
 static int
-mp2975_identify_vout_format(struct i2c_client *client,
-			    struct mp2975_data *data, int page)
+mp2975_set_vout_format(struct i2c_client *client,
+		       struct mp2975_data *data, int page)
 {
 	int ret;
 
 	ret = i2c_smbus_read_word_data(client, MP2975_MFR_DC_LOOP_CTRL);
 	if (ret < 0)
 		return ret;
-
-	if (ret & MP2975_VOUT_FORMAT)
-		data->vout_format[page] = vid;
-	else
-		data->vout_format[page] = direct;
-	return 0;
+	/* Enable DIRECT VOUT format 1mV/LSB */
+	if (ret & MP2975_VOUT_FORMAT) {
+		ret &= ~MP2975_VOUT_FORMAT;
+		ret = i2c_smbus_write_word_data(client, MP2975_MFR_DC_LOOP_CTRL, ret);
+	}
+	return ret;
 }
 
 static int
@@ -649,12 +614,8 @@ mp2975_vout_per_rail_config_get(struct i2c_client *client,
 		if (ret < 0)
 			return ret;
 
-		/*
-		 * Get VOUT format for READ_VOUT command : VID or direct.
-		 * Pages on same device can be configured with different
-		 * formats.
-		 */
-		ret = mp2975_identify_vout_format(client, data, i);
+		/* Set VOUT format for READ_VOUT command : direct. */
+		ret = mp2975_set_vout_format(client, data, i);
 		if (ret < 0)
 			return ret;
 
@@ -689,7 +650,6 @@ static struct pmbus_driver_info mp2975_info = {
 		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
 		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
 		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT | PMBUS_PHASE_VIRTUAL,
-	.read_byte_data = mp2975_read_byte_data,
 	.read_word_data = mp2975_read_word_data,
 };
 
-- 
2.41.0

