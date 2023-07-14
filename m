Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0271E753C28
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbjGNNwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235909AbjGNNvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:51:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6093A87
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:51:40 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98de21518fbso262577066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689342698; x=1691934698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fdgHEMDPNwZTClo7TJkF0JFchHkoo0pFMs1tP6LyZ7c=;
        b=ESj93/DcEtn8N12L37as3AsAa/dMoBEb28eGurPie63+8CX7MkNPa9tikHUMtv3bZw
         cj4egn825D41nTObupSy8dkAk0iKnbzS1Pnj4wpXqKkXG1hfSVR0hYLjfx3ZJwmJxiKj
         t4Xky/3tbecEinUr5OALSDfE5KL188zJUarlmcsg/lMybvZwzfX44N+3Mh6YdtuxsQMg
         bwK2ympV4UFxbpYNbfV8npkoVO/Yvsl9YWbz5HDUG1p2xmKZPHV7NVn6BJ3t7zjOzyEX
         xRUUy+Lh/xwy+k7M1p211kQaeMEAi6JRmHhJt2IcyQgm8aXBWx7bxFD/QKCfQYOMHUvm
         7TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342698; x=1691934698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fdgHEMDPNwZTClo7TJkF0JFchHkoo0pFMs1tP6LyZ7c=;
        b=GoVlvXDIyL3G4W3moJQL8C4Lic3RRZZymjUghZHEyutAqzldPCgC8t5HRmS7eXicNn
         T6dMPjWZFveZcdvhY0CsVTnPRdNxCVDydC2oHB5+O1QpgGOVOm7cF+L29bTgPJH5JJW1
         cBTrqgO9FaLERgvGgLmgndkYmoBACZs8fNJQlPSb/hIiJQmbu9pqB+ZISAlsFY6h8B/g
         dvRAa2nyIWr45Z+z9DkVrHhpHnlazQH4MSfR2VXOpfFs1HkErhJlYMsT9y507lRLMmBS
         Aw1jjocpLKutwCf2ztbzwjhcD3xzm8gnh8KKchSnbX6DuGBWZhQmBrxUrDVvrMS/ifbo
         3APA==
X-Gm-Message-State: ABy/qLY4SCs1oGpCyLj5oT8cKP/B8qRimDVy/bdiYmYB7flghGe2RvE/
        DKceEbWkQy9ixtL8z+vtcbrrxA==
X-Google-Smtp-Source: APBJJlHNtkaVoV4y9yoqqAHFVEBrADZm+aYjlN08Z943Y1F/j6BnTWJFbAEAyeDm2B8HoZII2m95kA==
X-Received: by 2002:a17:907:9726:b0:989:450:e56a with SMTP id jg38-20020a170907972600b009890450e56amr5452450ejc.76.1689342698583;
        Fri, 14 Jul 2023 06:51:38 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906261500b0099236e3f270sm5405991ejc.58.2023.07.14.06.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:51:38 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v2 8/8] hwmon: (pmbus/mp2975) Add OCP limit
Date:   Fri, 14 Jul 2023 15:51:16 +0200
Message-ID: <20230714135124.2645339-8-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
References: <20230714135124.2645339-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add support for PMBUS_IOUT_OC_FAULT_LIMIT.
Add a helper function to convert the limit to LINEAR11 format
and read data->info.phases[0] on MP2971 and MP2973 as well.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/mp2975.c | 76 ++++++++++++++++++++++++++++++------
 1 file changed, 65 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index 7684f8667657..0b1983d5998b 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -65,6 +65,10 @@
 #define MP2973_VID_STEP_SEL_R2		BIT(3)
 #define MP2973_IMVP9_EN_R2		BIT(13)
 
+#define MP2973_MFR_OCP_TOTAL_SET	0x5f
+#define MP2973_OCP_TOTAL_CUR_MASK	GENMASK(6, 0)
+#define MP2973_MFR_OCP_LEVEL_RES	BIT(15)
+
 #define MP2973_MFR_READ_IOUT_PK		0x90
 #define MP2973_MFR_READ_POUT_PK		0x91
 
@@ -153,6 +157,41 @@ mp2975_vid2direct(int vrf, int val)
 	return 0;
 }
 
+#define MAX_LIN_MANTISSA	(1023 * 1000)
+#define MIN_LIN_MANTISSA	(511 * 1000)
+
+/* Converts a milli-unit DIRECT value to LINEAR11 format */
+static u16 mp2975_data2reg_linear11(s64 val)
+{
+	s16 exponent = 0, mantissa;
+	bool negative = false;
+
+	/* simple case */
+	if (val == 0)
+		return 0;
+
+	/* Reduce large mantissa until it fits into 10 bit */
+	while (val >= MAX_LIN_MANTISSA && exponent < 15) {
+		exponent++;
+		val >>= 1;
+	}
+	/* Increase small mantissa to improve precision */
+	while (val < MIN_LIN_MANTISSA && exponent > -15) {
+		exponent--;
+		val <<= 1;
+	}
+
+	/* Convert mantissa from milli-units to units */
+	mantissa = clamp_val(DIV_ROUND_CLOSEST_ULL(val, 1000), 0, 0x3ff);
+
+	/* restore sign */
+	if (negative)
+		mantissa = -mantissa;
+
+	/* Convert to 5 bit exponent, 11 bit mantissa */
+	return (mantissa & 0x7ff) | ((exponent << 11) & 0xf800);
+}
+
 static int
 mp2975_read_phase(struct i2c_client *client, struct mp2975_data *data,
 		  int page, int phase, u8 reg)
@@ -297,6 +336,20 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
 		ret = pmbus_read_word_data(client, page, phase,
 					   MP2973_MFR_READ_IOUT_PK);
 		break;
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+		ret = mp2975_read_word_helper(client, page, phase,
+					      MP2973_MFR_OCP_TOTAL_SET,
+					      GENMASK(15, 0));
+		if (ret < 0)
+			return ret;
+
+		if (ret & MP2973_MFR_OCP_LEVEL_RES)
+			ret = 2 * (ret & MP2973_OCP_TOTAL_CUR_MASK);
+		else
+			ret = ret & MP2973_OCP_TOTAL_CUR_MASK;
+
+		ret = mp2975_data2reg_linear11(ret * info->phases[page] * 1000);
+		break;
 	case PMBUS_UT_WARN_LIMIT:
 	case PMBUS_UT_FAULT_LIMIT:
 	case PMBUS_VIN_UV_WARN_LIMIT:
@@ -307,7 +360,6 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
 	case PMBUS_IIN_OC_FAULT_LIMIT:
 	case PMBUS_IOUT_OC_LV_FAULT_LIMIT:
 	case PMBUS_IOUT_OC_WARN_LIMIT:
-	case PMBUS_IOUT_OC_FAULT_LIMIT:
 	case PMBUS_IOUT_UC_FAULT_LIMIT:
 	case PMBUS_POUT_OP_FAULT_LIMIT:
 	case PMBUS_POUT_OP_WARN_LIMIT:
@@ -481,11 +533,13 @@ mp2975_identify_multiphase(struct i2c_client *client, struct mp2975_data *data,
 	if (info->phases[0] > data->max_phases[0])
 		return -EINVAL;
 
-	mp2975_set_phase_rail1(info);
-	num_phases2 = min(data->max_phases[0] - info->phases[0],
-			  data->max_phases[1]);
-	if (info->phases[1] && info->phases[1] <= num_phases2)
-		mp2975_set_phase_rail2(info, num_phases2);
+	if (data->chip_id == mp2975) {
+		mp2975_set_phase_rail1(info);
+		num_phases2 = min(data->max_phases[0] - info->phases[0],
+				  data->max_phases[1]);
+		if (info->phases[1] && info->phases[1] <= num_phases2)
+			mp2975_set_phase_rail2(info, num_phases2);
+	}
 
 	return 0;
 }
@@ -878,12 +932,12 @@ static int mp2975_probe(struct i2c_client *client)
 			data->info.num_regulators = MP2975_PAGE_NUM;
 	}
 
-	if (data->chip_id == mp2975) {
-		/* Identify multiphase configuration. */
-		ret = mp2975_identify_multiphase(client, data, info);
-		if (ret)
-			return ret;
+	/* Identify multiphase configuration. */
+	ret = mp2975_identify_multiphase(client, data, info);
+	if (ret)
+		return ret;
 
+	if (data->chip_id == mp2975) {
 		/* Identify VID setting per rail. */
 		ret = mp2975_identify_rails_vid(client, data, info);
 		if (ret < 0)
-- 
2.41.0

