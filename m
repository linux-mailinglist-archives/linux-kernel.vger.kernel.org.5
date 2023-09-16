Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C257A2C41
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 02:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238758AbjIPAdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 20:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbjIPAcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 20:32:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A3D1724
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:32:05 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50079d148aeso4516733e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 17:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694824323; x=1695429123; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eFejzb7aN7MekbjpnaQzLFApoAUU++VrN/USYsgbcQw=;
        b=rlFnGVmC5xdzXveC2Dfu9JWethVf4ut4rEGvzKVeRY4XzlcJjOR2Qforbf6ZWyjtOS
         OmxZRD2nb55wOOUPNtgFNT475BHRZnCanyzqsz1DFoO0pMVVRayhHE2lhykS9suAf3Hb
         sz/uCBRCwvmkBNnqDx4PQyCkaMv3lKMb7Y0ofFgxpVeIKVIHDcytdnzFQuLAlIPnjgix
         qmQUC/9DVw507A4otzbjrtmEJ/xfKI4iZ4IF1jnRVYBCGDsBY/SrpU4u+7sOnSJPeb47
         Qdq07r9T69XQ0I5NZoAUti3UGQozrE6oWI0bxopMD233Ek+fSZodw20J8Hry4qAfdVqO
         Q1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694824323; x=1695429123;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFejzb7aN7MekbjpnaQzLFApoAUU++VrN/USYsgbcQw=;
        b=FIB25EG2xxeypG5xA5ECUa9jKD3Gvq/aTK9EFSMp3VpxUz7muIQ1Xz/whJbepkFIt8
         7x9Vkz/jVsKgYIHXZhsrcjDjdSVuLUGVJoZRS2CqIX23WmHdCfvD7lAj8l8dGzJ46bVo
         z7veWT7ZMInqce5AzZD3D15tkiXzvJGWIYRGn9N9mwj+ePkCHGIQJ3i1bjDpUCPMYnn5
         /J2KaJyczTVUDxnT/2Pb/UDRHmxlK76rRtlhfI15drTGavFIAlqU6wXOm9hupyJnF/cN
         ML6ZPX3nskJd8yh2vd0rVh0J7DG0QkJVmrYee4cY2nsshXRDSj8Scuup5L5gnXiTigHi
         33DA==
X-Gm-Message-State: AOJu0YwPxIhqfwwVYDyFGUJBxVKLW33Vm5eGxArpIz/W9VnqiY58gDsV
        VN3J0GTNyNVsnx40pwTlvJLLTwS2Qx8OkT64owrq0g==
X-Google-Smtp-Source: AGHT+IFKywQ0QSSHnMIVPF9QpyEA4OIklMp5NJfilO47p2pVro3VF9gq5S41Ly7S1t2cKgDKHbr5eQ==
X-Received: by 2002:a05:6512:3053:b0:502:fe0a:af23 with SMTP id b19-20020a056512305300b00502fe0aaf23mr871303lfb.56.1694824322909;
        Fri, 15 Sep 2023 17:32:02 -0700 (PDT)
Received: from [10.167.154.1] (178235177186.dynamic-4-waw-k-1-1-0.vectranet.pl. [178.235.177.186])
        by smtp.gmail.com with ESMTPSA id lw28-20020a170906bcdc00b00992f309cfe8sm3083735ejb.178.2023.09.15.17.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 17:32:02 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Sat, 16 Sep 2023 02:31:59 +0200
Subject: [PATCH] psy: mm8013: Add more properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-topic-mm8013_2-v1-1-02495e07fca0@linaro.org>
X-B4-Tracking: v=1; b=H4sIAH73BGUC/x2NWwqDMBAAryL77UIe2EavIiJJutYFjZK0Ioh37
 9LPGRjmgkKZqUBXXZDp4MJbEtB1BXH26U3IL2EwyljV6gd+tp0jrqtT2o4Gmxgs6eDUc3IgUfC
 FMGSf4ixZ+i6LyD3TxOf/0g/3/QOxFKx3dQAAAA==
To:     Konrad Dybcio <konradybcio@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694824321; l=4622;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=JOfv0hbEyN+O/H2UYL7rdGfPUfoOoGKiXPXc/AHKu+Q=;
 b=FZlrDfsne6K8LYmo2iIsa7Un63cjDU+SbJlN3HemBbk73ocqTfmv0BP/h5oW7KxAQ/Wq1Bm2t
 kjoAH/mKJ61CjkWdckHOgZCe5QWrbwZMitGXi46MFCjnc3PV8jCjbCW
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While scanning the internet for MM8013 PDFs, I found one for a different
IC from Mitsumi, MM8118 at [1]. It turned out however, that when you
search through the PDF, the MM8118 text has an invsible text layer
containing "MM8013" underneath..

With some elbow grease, I was able to confirm that most of the registers
match between the two ICs. Based on that finding, introduce live battery
voltage readout, hw-decided charge behavior readout and max current
readout. Also, expand the existing POWER_SUPPLY_HEALTH reporting.

[1] https://product.minebeamitsumi.com/en/product/category/ics/battery/fuel_gauge/parts/download/__icsFiles/afieldfile/2023/07/12/1_download_01_12.pdf

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
foobar
uevent reports from the new props:

POWER_SUPPLY_CHARGE_BEHAVIOUR=auto
POWER_SUPPLY_CHARGE_NOW=7302000
POWER_SUPPLY_CURRENT_MAX=1898000
---
 drivers/power/supply/mm8013.c | 45 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
index bd8d54d6597f..ddac40ef9ae5 100644
--- a/drivers/power/supply/mm8013.c
+++ b/drivers/power/supply/mm8013.c
@@ -17,13 +17,21 @@
  #define MM8013_FLAG_OTC		BIT(15)
  #define MM8013_FLAG_OTD		BIT(14)
  #define MM8013_FLAG_BATHI		BIT(13)
+ #define MM8013_FLAG_BATLOW		BIT(12)
+ #define MM8013_FLAG_CHG_INH		BIT(11)
  #define MM8013_FLAG_FC			BIT(9)
  #define MM8013_FLAG_CHG		BIT(8)
+ #define MM8013_FLAG_OCC		BIT(6)
+ #define MM8013_FLAG_ODC		BIT(5)
+ #define MM8013_FLAG_OT			BIT(4)
+ #define MM8013_FLAG_UT			BIT(3)
  #define MM8013_FLAG_DSG		BIT(0)
 #define REG_FULL_CHARGE_CAPACITY	0x0e
+#define REG_NOMINAL_CHARGE_CAPACITY	0x0c
 #define REG_AVERAGE_CURRENT		0x14
 #define REG_AVERAGE_TIME_TO_EMPTY	0x16
 #define REG_AVERAGE_TIME_TO_FULL	0x18
+#define REG_MAX_LOAD_CURRENT		0x1e
 #define REG_CYCLE_COUNT			0x2a
 #define REG_STATE_OF_CHARGE		0x2c
 #define REG_DESIGN_CAPACITY		0x3c
@@ -63,8 +71,11 @@ static int mm8013_checkdevice(struct mm8013_chip *chip)
 
 static enum power_supply_property mm8013_battery_props[] = {
 	POWER_SUPPLY_PROP_CAPACITY,
+	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
 	POWER_SUPPLY_PROP_CHARGE_FULL,
 	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
+	POWER_SUPPLY_PROP_CHARGE_NOW,
+	POWER_SUPPLY_PROP_CURRENT_MAX,
 	POWER_SUPPLY_PROP_CURRENT_NOW,
 	POWER_SUPPLY_PROP_CYCLE_COUNT,
 	POWER_SUPPLY_PROP_HEALTH,
@@ -92,6 +103,16 @@ static int mm8013_get_property(struct power_supply *psy,
 
 		val->intval = regval;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR:
+		ret = regmap_read(chip->regmap, REG_FLAGS, &regval);
+		if (ret < 0)
+			return ret;
+
+		if (regval & MM8013_FLAG_CHG_INH)
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE;
+		else
+			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
+		break;
 	case POWER_SUPPLY_PROP_CHARGE_FULL:
 		ret = regmap_read(chip->regmap, REG_FULL_CHARGE_CAPACITY, &regval);
 		if (ret < 0)
@@ -106,6 +127,20 @@ static int mm8013_get_property(struct power_supply *psy,
 
 		val->intval = 1000 * regval;
 		break;
+	case POWER_SUPPLY_PROP_CHARGE_NOW:
+		ret = regmap_read(chip->regmap, REG_NOMINAL_CHARGE_CAPACITY, &regval);
+		if (ret < 0)
+			return ret;
+
+		val->intval = 1000 * regval;
+		break;
+	case POWER_SUPPLY_PROP_CURRENT_MAX:
+		ret = regmap_read(chip->regmap, REG_MAX_LOAD_CURRENT, &regval);
+		if (ret < 0)
+			return ret;
+
+		val->intval = -1000 * (s16)regval;
+		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
 		ret = regmap_read(chip->regmap, REG_AVERAGE_CURRENT, &regval);
 		if (ret < 0)
@@ -125,9 +160,15 @@ static int mm8013_get_property(struct power_supply *psy,
 		if (ret < 0)
 			return ret;
 
-		if (regval & MM8013_FLAG_BATHI)
+		if (regval & MM8013_FLAG_UT)
+			val->intval = POWER_SUPPLY_HEALTH_COLD;
+		else if (regval & (MM8013_FLAG_ODC | MM8013_FLAG_OCC))
+			val->intval = POWER_SUPPLY_HEALTH_OVERCURRENT;
+		else if (regval & (MM8013_FLAG_BATLOW))
+			val->intval = POWER_SUPPLY_HEALTH_UNSPEC_FAILURE;
+		else if (regval & MM8013_FLAG_BATHI)
 			val->intval = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
-		else if (regval & (MM8013_FLAG_OTD | MM8013_FLAG_OTC))
+		else if (regval & (MM8013_FLAG_OT | MM8013_FLAG_OTD | MM8013_FLAG_OTC))
 			val->intval = POWER_SUPPLY_HEALTH_OVERHEAT;
 		else
 			val->intval = POWER_SUPPLY_HEALTH_GOOD;

---
base-commit: 566750b17f1ee43350ba2c85a3bb2d9e28ba9c04
change-id: 20230916-topic-mm8013_2-5cb3e1b807f8

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

