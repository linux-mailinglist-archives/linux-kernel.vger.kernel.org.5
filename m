Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF25753C24
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbjGNNv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbjGNNvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:51:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D74635B5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:51:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992ace062f3so262084566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1689342696; x=1691934696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+50uxE8haUmsaczpnhGTT37unUw2hxG3ZoV9roE+Xbo=;
        b=SahvmqaRey0p94ptY8lTmxbkRyHoxm4JVQT/RHCHvo8gjxqL02MlH2jvArJBM66FGV
         eppuEPOGv9OHQPcHe2TIzA1OFrcMSUijYDFUvIgHCS3HmnVj6o7RY1vGZUKcGrxvuQof
         VudsaFA3UN7QFYCViQQgCexGofK+9qifZmSUPg+BoEspwuG2bXZbJvqtRVhRHQg+FmX2
         MF7HlDdhJCGrDU4a2R4KvQIiWIW3ZCpVAX2YuAaHqP1DXwLfEnQ0kUYT+qE2GHaOZbNC
         VoF0N/OPdocGkFOUhljd23ji0IL7bCCezb+cs5uTzS7DUBfdmotWV2eIaRjwVb5ELrFu
         Q/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689342696; x=1691934696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+50uxE8haUmsaczpnhGTT37unUw2hxG3ZoV9roE+Xbo=;
        b=cvm0sLk+YdBvq898BhiVhLofDKkSRHcAWCUt7HxfWI2/e3r4VyTyq1QdvzRCiiRBjd
         Vc7qQyl9bHPBDSYm/F8EiJpPEdv0GEOBiQhTqFUvE/JpZ7arJIo/RWCD1BDoMuZnG4j3
         Fr/lWXL+Pu7GwfBw5Ai6Q4fA01vyWSX8PoijiUxKhJJMWDqOuFzump1kri4k5HsjLvE+
         0YrWFOo8ptWjBJ91H5rs+I1upx84x53c+6nK7xn7QWI8ytoRnpw3HmW6BDUDV1A0xC+7
         5Gsg/mv/u0k9DR5GBRlWfJL37G2LkE/IVPukRtjEYY8OgT+ce26Eb38qwMhpVHS39epe
         H7qQ==
X-Gm-Message-State: ABy/qLZogukm/hJLVX6tUQPriKEik3Eou3bS0+1uy7d3FAgxj9WRX6v3
        c7xW/ogc/R4xPN9CGdeZHS9VHw==
X-Google-Smtp-Source: APBJJlH2X+rs8noPkQXLsG1IwzfuUpCHIQvocxXWPVA97PX6uvTe7yRv8/6UiWNHXxAUQyEipT1+lg==
X-Received: by 2002:a17:906:5185:b0:96f:a891:36cb with SMTP id y5-20020a170906518500b0096fa89136cbmr4894759ejk.0.1689342696040;
        Fri, 14 Jul 2023 06:51:36 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906261500b0099236e3f270sm5405991ejc.58.2023.07.14.06.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:51:35 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v2 6/8] hwmon: (pmbus/mp2975) Add support for MP2971 and MP2973
Date:   Fri, 14 Jul 2023 15:51:14 +0200
Message-ID: <20230714135124.2645339-6-Naresh.Solanki@9elements.com>
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

Add support for MP2971 and MP2973, the successor of MP2975.

The major differences are:
 - On MP2973 and MP2971 the Vref cannot be read and thus most of
   the OVP/current calculations won't work.
 - MP2973 and MP2971 also support LINEAR format for VOUT
 - MP2973 and MP2971 do not support OVP2
 - On MP2973 and MP2971 most registers are in LINEAR format
 - The IMVP9_EN bit has a different position
 - Per phase current sense haven't been implemented.

As on MP2975 most of the FAULT_LIMIT and WARN_LIMIT registers
have been redefined and doesn't provide the functionality as
defined in PMBUS spec.

Tested on MP2973 and MP2971.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

---
Changes in V2:
- Remove cosmetic changes like continue to use mp2975 instead of
  changing it to mp297x.
- Do i2c write back only if needed.
---
 drivers/hwmon/pmbus/mp2975.c | 247 ++++++++++++++++++++++++++++++-----
 1 file changed, 214 insertions(+), 33 deletions(-)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index a4453b9284fa..4d72ed18cc8c 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -35,6 +35,8 @@
 #define MP2975_MFR_OVP_TH_SET		0xe5
 #define MP2975_MFR_UVP_SET		0xe6
 
+#define MP2973_MFR_RESO_SET		0xc7
+
 #define MP2975_VOUT_FORMAT		BIT(15)
 #define MP2975_VID_STEP_SEL_R1		BIT(4)
 #define MP2975_IMVP9_EN_R1		BIT(13)
@@ -49,8 +51,32 @@
 #define MP2975_SENSE_AMPL_HALF		2
 #define MP2975_VIN_UV_LIMIT_UNIT	8
 
+#define MP2973_VOUT_FORMAT_R1		GENMASK(7, 6)
+#define MP2973_VOUT_FORMAT_R2		GENMASK(4, 3)
+#define MP2973_VOUT_FORMAT_DIRECT_R1	BIT(7)
+#define MP2973_VOUT_FORMAT_LINEAR_R1	BIT(6)
+#define MP2973_VOUT_FORMAT_DIRECT_R2	BIT(4)
+#define MP2973_VOUT_FORMAT_LINEAR_R2	BIT(3)
+
+#define MP2973_MFR_VR_MULTI_CONFIG_R1	0x0d
+#define MP2973_MFR_VR_MULTI_CONFIG_R2	0x1d
+#define MP2973_VID_STEP_SEL_R1		BIT(4)
+#define MP2973_IMVP9_EN_R1		BIT(14)
+#define MP2973_VID_STEP_SEL_R2		BIT(3)
+#define MP2973_IMVP9_EN_R2		BIT(13)
+
+#define MP2973_MFR_READ_IOUT_PK		0x90
+#define MP2973_MFR_READ_POUT_PK		0x91
+
 #define MP2975_MAX_PHASE_RAIL1	8
 #define MP2975_MAX_PHASE_RAIL2	4
+
+#define MP2973_MAX_PHASE_RAIL1	14
+#define MP2973_MAX_PHASE_RAIL2	6
+
+#define MP2971_MAX_PHASE_RAIL1	8
+#define MP2971_MAX_PHASE_RAIL2	3
+
 #define MP2975_PAGE_NUM		2
 
 #define MP2975_RAIL2_FUNC	(PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT | \
@@ -58,11 +84,13 @@
 				 PMBUS_HAVE_POUT | PMBUS_PHASE_VIRTUAL)
 
 enum chips {
-	mp2975
+	mp2971, mp2973, mp2975
 };
 
 static const int mp2975_max_phases[][MP2975_PAGE_NUM] = {
 	[mp2975] = { MP2975_MAX_PHASE_RAIL1, MP2975_MAX_PHASE_RAIL2 },
+	[mp2973] = { MP2973_MAX_PHASE_RAIL1, MP2973_MAX_PHASE_RAIL2 },
+	[mp2971] = { MP2971_MAX_PHASE_RAIL1, MP2971_MAX_PHASE_RAIL2 },
 };
 
 struct mp2975_data {
@@ -79,6 +107,8 @@ struct mp2975_data {
 };
 
 static const struct i2c_device_id mp2975_id[] = {
+	{"mp2971", mp2971},
+	{"mp2973", mp2973},
 	{"mp2975", mp2975},
 	{}
 };
@@ -215,6 +245,76 @@ mp2975_read_phases(struct i2c_client *client, struct mp2975_data *data,
 	return ret;
 }
 
+static int mp2973_read_word_data(struct i2c_client *client, int page,
+				 int phase, int reg)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	struct mp2975_data *data = to_mp2975_data(info);
+	int ret;
+
+	switch (reg) {
+	case PMBUS_OT_FAULT_LIMIT:
+		ret = mp2975_read_word_helper(client, page, phase, reg,
+					      GENMASK(7, 0));
+		break;
+	case PMBUS_VIN_OV_FAULT_LIMIT:
+		ret = mp2975_read_word_helper(client, page, phase, reg,
+					      GENMASK(7, 0));
+		if (ret < 0)
+			return ret;
+
+		ret = DIV_ROUND_CLOSEST(ret, MP2975_VIN_UV_LIMIT_UNIT);
+		break;
+	case PMBUS_VOUT_OV_FAULT_LIMIT:
+		/*
+		 * MP2971 and mp2973 only supports tracking (ovp1) mode.
+		 */
+		ret = mp2975_read_word_helper(client, page, phase,
+					      MP2975_MFR_OVP_TH_SET,
+					      GENMASK(2, 0));
+		if (ret < 0)
+			return ret;
+
+		ret = data->vout_max[page] + 50 * (ret + 1);
+		break;
+	case PMBUS_VOUT_UV_FAULT_LIMIT:
+		ret = mp2975_read_word_helper(client, page, phase, reg,
+					      GENMASK(8, 0));
+		if (ret < 0)
+			return ret;
+		ret = mp2975_vid2direct(info->vrm_version[page], ret);
+		break;
+	case PMBUS_VIRT_READ_POUT_MAX:
+		ret = pmbus_read_word_data(client, page, phase,
+					   MP2973_MFR_READ_POUT_PK);
+		break;
+	case PMBUS_VIRT_READ_IOUT_MAX:
+		ret = pmbus_read_word_data(client, page, phase,
+					   MP2973_MFR_READ_IOUT_PK);
+		break;
+	case PMBUS_UT_WARN_LIMIT:
+	case PMBUS_UT_FAULT_LIMIT:
+	case PMBUS_VIN_UV_WARN_LIMIT:
+	case PMBUS_VIN_UV_FAULT_LIMIT:
+	case PMBUS_VOUT_UV_WARN_LIMIT:
+	case PMBUS_VOUT_OV_WARN_LIMIT:
+	case PMBUS_VIN_OV_WARN_LIMIT:
+	case PMBUS_IIN_OC_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_LV_FAULT_LIMIT:
+	case PMBUS_IOUT_OC_WARN_LIMIT:
+	case PMBUS_IOUT_OC_FAULT_LIMIT:
+	case PMBUS_IOUT_UC_FAULT_LIMIT:
+	case PMBUS_POUT_OP_FAULT_LIMIT:
+	case PMBUS_POUT_OP_WARN_LIMIT:
+	case PMBUS_PIN_OP_WARN_LIMIT:
+		return -ENXIO;
+	default:
+		return -ENODATA;
+	}
+
+	return ret;
+}
+
 static int mp2975_read_word_data(struct i2c_client *client, int page,
 				 int phase, int reg)
 {
@@ -434,6 +534,35 @@ mp2975_identify_rails_vid(struct i2c_client *client, struct mp2975_data *data,
 					  MP2975_MFR_VR_MULTI_CONFIG_R2, 1,
 					  MP2975_IMVP9_EN_R2,
 					  MP2975_VID_STEP_SEL_R2);
+
+	return ret;
+}
+
+static int
+mp2973_identify_rails_vid(struct i2c_client *client, struct mp2975_data *data,
+			  struct pmbus_driver_info *info)
+{
+	int ret;
+
+	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 2);
+	if (ret < 0)
+		return ret;
+
+	/* Identify VID mode for rail 1. */
+	ret = mp2975_identify_vid(client, data, info,
+				  MP2973_MFR_VR_MULTI_CONFIG_R1, 0,
+				  MP2973_IMVP9_EN_R1, MP2973_VID_STEP_SEL_R1);
+
+	if (ret < 0)
+		return ret;
+
+	/* Identify VID mode for rail 2, if connected. */
+	if (info->phases[1])
+		ret = mp2975_identify_vid(client, data, info,
+					  MP2973_MFR_VR_MULTI_CONFIG_R2, 1,
+					  MP2973_IMVP9_EN_R2,
+					  MP2973_VID_STEP_SEL_R2);
+
 	return ret;
 }
 
@@ -551,15 +680,32 @@ static int
 mp2975_set_vout_format(struct i2c_client *client,
 		       struct mp2975_data *data, int page)
 {
-	int ret;
+	int ret, i;
 
-	ret = i2c_smbus_read_word_data(client, MP2975_MFR_DC_LOOP_CTRL);
-	if (ret < 0)
-		return ret;
 	/* Enable DIRECT VOUT format 1mV/LSB */
-	if (ret & MP2975_VOUT_FORMAT) {
-		ret &= ~MP2975_VOUT_FORMAT;
-		ret = i2c_smbus_write_word_data(client, MP2975_MFR_DC_LOOP_CTRL, ret);
+	if (data->chip_id == mp2975) {
+		ret = i2c_smbus_read_word_data(client, MP2975_MFR_DC_LOOP_CTRL);
+		if (ret < 0)
+			return ret;
+		if (ret & MP2975_VOUT_FORMAT) {
+			ret &= ~MP2975_VOUT_FORMAT;
+			ret = i2c_smbus_write_word_data(client, MP2975_MFR_DC_LOOP_CTRL, ret);
+		}
+	} else {
+		ret = i2c_smbus_read_word_data(client, MP2973_MFR_RESO_SET);
+		if (ret < 0)
+			return ret;
+		i = ret;
+
+		if (page == 0) {
+			i &= ~MP2973_VOUT_FORMAT_R1;
+			i |= MP2973_VOUT_FORMAT_DIRECT_R1;
+		} else {
+			i &= ~MP2973_VOUT_FORMAT_R2;
+			i |= MP2973_VOUT_FORMAT_DIRECT_R2;
+		}
+		if (i != ret)
+			ret = i2c_smbus_write_word_data(client, MP2973_MFR_RESO_SET, i);
 	}
 	return ret;
 }
@@ -607,10 +753,10 @@ mp2975_vout_per_rail_config_get(struct i2c_client *client,
 	for (i = 0; i < data->info.pages; i++) {
 		ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, i);
 		if (ret < 0)
-			return ret;
+			continue;
 
-		/* Obtain voltage reference offsets. */
-		ret = mp2975_vref_offset_get(client, data, i);
+		/* Set VOUT format for READ_VOUT command : direct. */
+		ret = mp2975_set_vout_format(client, data, i);
 		if (ret < 0)
 			return ret;
 
@@ -619,8 +765,12 @@ mp2975_vout_per_rail_config_get(struct i2c_client *client,
 		if (ret < 0)
 			return ret;
 
-		/* Set VOUT format for READ_VOUT command : direct. */
-		ret = mp2975_set_vout_format(client, data, i);
+		/* Skip if reading Vref is unsupported */
+		if (data->chip_id != mp2975)
+			continue;
+
+		/* Obtain voltage reference offsets. */
+		ret = mp2975_vref_offset_get(client, data, i);
 		if (ret < 0)
 			return ret;
 
@@ -658,6 +808,23 @@ static struct pmbus_driver_info mp2975_info = {
 	.read_word_data = mp2975_read_word_data,
 };
 
+static struct pmbus_driver_info mp2973_info = {
+	.pages = 1,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = direct,
+	.format[PSC_TEMPERATURE] = linear,
+	.format[PSC_CURRENT_IN] = linear,
+	.format[PSC_CURRENT_OUT] = linear,
+	.format[PSC_POWER] = linear,
+	.m[PSC_VOLTAGE_OUT] = 1,
+	.R[PSC_VOLTAGE_OUT] = 3,
+	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+		PMBUS_HAVE_IIN | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
+		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT,
+	.read_word_data = mp2973_read_word_data,
+};
+
 static int mp2975_probe(struct i2c_client *client)
 {
 	struct pmbus_driver_info *info;
@@ -677,6 +844,11 @@ static int mp2975_probe(struct i2c_client *client)
 	memcpy(data->max_phases, mp2975_max_phases[data->chip_id],
 	       sizeof(data->max_phases));
 
+	if (data->chip_id == mp2975)
+		memcpy(&data->info, &mp2975_info, sizeof(*info));
+	else
+		memcpy(&data->info, &mp2973_info, sizeof(*info));
+
 	info = &data->info;
 
 	/* Identify multiphase configuration for rail 2. */
@@ -691,30 +863,37 @@ static int mp2975_probe(struct i2c_client *client)
 		data->info.func[1] = MP2975_RAIL2_FUNC;
 	}
 
-	/* Identify multiphase configuration. */
-	ret = mp2975_identify_multiphase(client, data, info);
-	if (ret)
-		return ret;
+	if (data->chip_id == mp2975) {
+		/* Identify multiphase configuration. */
+		ret = mp2975_identify_multiphase(client, data, info);
+		if (ret)
+			return ret;
 
-	/* Identify VID setting per rail. */
-	ret = mp2975_identify_rails_vid(client, data, info);
-	if (ret < 0)
-		return ret;
+		/* Identify VID setting per rail. */
+		ret = mp2975_identify_rails_vid(client, data, info);
+		if (ret < 0)
+			return ret;
 
-	/* Obtain current sense gain of power stage. */
-	ret = mp2975_current_sense_gain_get(client, data);
-	if (ret)
-		return ret;
+		/* Obtain current sense gain of power stage. */
+		ret = mp2975_current_sense_gain_get(client, data);
+		if (ret)
+			return ret;
 
-	/* Obtain voltage reference values. */
-	ret = mp2975_vref_get(client, data, info);
-	if (ret)
-		return ret;
+		/* Obtain voltage reference values. */
+		ret = mp2975_vref_get(client, data, info);
+		if (ret)
+			return ret;
 
-	/* Obtain vout over-voltage scales. */
-	ret = mp2975_vout_ov_scale_get(client, data, info);
-	if (ret < 0)
-		return ret;
+		/* Obtain vout over-voltage scales. */
+		ret = mp2975_vout_ov_scale_get(client, data, info);
+		if (ret < 0)
+			return ret;
+	} else {
+		/* Identify VID setting per rail. */
+		ret = mp2973_identify_rails_vid(client, data, info);
+		if (ret < 0)
+			return ret;
+	}
 
 	/* Obtain offsets, maximum and format for vout. */
 	ret = mp2975_vout_per_rail_config_get(client, data, info);
@@ -725,6 +904,8 @@ static int mp2975_probe(struct i2c_client *client)
 }
 
 static const struct of_device_id __maybe_unused mp2975_of_match[] = {
+	{.compatible = "mps,mp2971", .data = (void *)mp2971},
+	{.compatible = "mps,mp2973", .data = (void *)mp2973},
 	{.compatible = "mps,mp2975", .data = (void *)mp2975},
 	{}
 };
-- 
2.41.0

