Return-Path: <linux-kernel+bounces-42743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C198405ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F44E1F21F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262D8627EB;
	Mon, 29 Jan 2024 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QD3koDHy"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0316460EFD
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706533424; cv=none; b=CqFHJHWVEmm0rDlwdo968SuQPEDiXfVkuGKwyEzdPtRImTlovuPXnucNBlV4nYrz6fA8VbNUfNLQPLF4ROPHPktSuYjy/bbk58Ms6Z5nudObikuFBl7FrjE/FFfRujtaQrd+xoLViaitx25mKXPwwcerC/4LWT3wL0VMIRJHwFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706533424; c=relaxed/simple;
	bh=f4CkzfiG4I3FrpFXAkgEvQKaNqmSEe/+rslHPQcwWeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZYfQxKvg0cEFFe62V0Gz+/UINlj3pMZd8GlZKK+E/lwVHPtdfgi4XnjwvEekIUX9LAI9uN2kI5dOUFJxFGOc5xMIbasSbiS+D1cfVpd+wAuNFpDDgVgB+AEOu0/NtREvUSgfewIPu3KIGNWiOZpxwymsPV1/i51qJNDr+Z7rbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QD3koDHy; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-55817a12ad8so2537364a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706533420; x=1707138220; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8r023diyzmX0/qUHReOrNetNmJ26S3h2W1HRl4d6fy8=;
        b=QD3koDHySN80dVn9h0wpyg8KEXNdgP5+9nhcnRJHrCWKJn553FUkemDoHWgAIWbAC2
         7prG/0OvZoKjgeiGIbYAFFXiULOeViFrMmWVSFETtbJbhOX8076AKO/0ciItcni+eSUu
         jR0QHo4woLOdaTxZBRTjuDrFcK849s4aB9f7eCpbQb0OOrk7iBk4kgIGjc3x5UI30Ccm
         E4xcb/ME7AIm3m34GhuP6pOIm2sruWAnlU9liOmCQBUx3qbOzRTDw8P0/psc6nXXy+cE
         G8VsV5QyBTxIMKajFV0hovj1/+vstr5F45CKbkSwP77J2Y8WQc/cBCb+Ego6oSk7AE+Z
         kTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706533420; x=1707138220;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8r023diyzmX0/qUHReOrNetNmJ26S3h2W1HRl4d6fy8=;
        b=N1BG3ogdpToCNy72Kqrr2ddtZ2INhwChULPI84aHMRxd4CGzV40HyhRFIuLHiyFpaq
         7fIqLoKKB8DpqIwXmBkB5ffdB4Co1yhTtWj6h8TrrH8b9QuLNiYq9RKT06x21QjBUrL/
         Zm/w+gLpXKvDpKDPVL0p6T5sL/WzjQqt39NGwHsEgifN/wPVtfdngLYmZg++ScNTjKB5
         k8EkWlyspfxwBllp/iZIMfni6lLB61AL4uVGBosyGQJlKN4Krzk43NMsrtX8P8AWmCra
         qwdxwp2vVgkxWHRdBnmIQ5KIf73UTcgrRw7U1wLDu3Ghfo0qM2KRGvwIvVdhTac1s/EY
         LsmA==
X-Gm-Message-State: AOJu0Yyx3ffNmzyRvZXf11Z0RoH2ie+gi+j0RRuCYck+YPi8TLj9l5Jv
	aSG++W1eng+4ZFEdkR2ipYfVpSDeKDrGOkL/WnAS2veZB9jRRdW178FB+HesTi0=
X-Google-Smtp-Source: AGHT+IHsMw6jcPIgsA4nKZ/dNkKVHw9d8O9QohsDemIwIPIRLSA2IVECJtaLZo2EEgNxX4lMFgr9GA==
X-Received: by 2002:a17:906:d7b1:b0:a35:c371:8b27 with SMTP id pk17-20020a170906d7b100b00a35c3718b27mr1445715ejb.30.1706533419955;
        Mon, 29 Jan 2024 05:03:39 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id vs3-20020a170907a58300b00a3550c56127sm2554867ejc.9.2024.01.29.05.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 05:03:39 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 29 Jan 2024 15:03:24 +0200
Subject: [PATCH v3] phy: qualcomm: eusb2-repeater: Rework init to drop
 redundant zero-out loop
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240129-phy-qcom-eusb2-repeater-fixes-v3-1-9a61ef3490de@linaro.org>
X-B4-Tracking: v=1; b=H4sIABuit2UC/43NQQ6CMBCF4auQrh0zbcGCK+9hXNAyQhOl2GIjI
 dzdwkpXuvzfJN/MLJC3FNgxm5mnaIN1fQq5y5jp6r4lsE1qJlDkyDGHoZvgYdwd6Bm0AE8D1SN
 5uNoXBTCVQM65RCkMS8bgaTsk4nxJ3dkwOj9t7yJf13/lyAEBc6WVPuhSSnm62b72bu98y1Y6i
 k+u+MWJxClVNFVJqrli8cUty/IG9ZsuGxoBAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Elliot Berman <quic_eberman@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=10431; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=f4CkzfiG4I3FrpFXAkgEvQKaNqmSEe/+rslHPQcwWeY=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlt6IlZUMsZ5mjG5Uk/xk6pkIoLRxjEBEHkcGKR
 r0zzACSg62JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZbeiJQAKCRAbX0TJAJUV
 VtdVD/9jsM55qrgd0jpDHoxs3MILVTpag3HxOxt1IuJuQ/ziVDxDUOcy1kRpUto4BRRXkT+WYwR
 r5fc+FjaPHo5CHwZ8KpLfv3GA52pJFzkDI4NB037bcxtnX+FC3DyLSFCYa5RAqHiH/J3kRtPVty
 0b7fsQ+z8938vzpQGUR6CVK+XEKYGtJxSBDAT+UiF2h/JtfqCvI4ueXc6jZxycrvtPfKbNBz9cs
 w8AOXVZzxRfkeEYGcPXuO7yeKpv9s8jVMK62oeugOWJ+HSh7pE9I98VQiE5G6IDE6OEyqgmYzFU
 Z5jDerqiHlXOgHHSaC80dQzVY5TCPO89FbE+prenxcXnV1E3m93XOrcrIH17FOUT97jo80rrksf
 jBEEe5P58bmdZEGqtuWHdhrZYJgZE4isG0NNkltXJDw5I4h6K9rn7MN4Y2qV84KHF5Fd6PfX1Ve
 kxw4kZi/lkeJ+9lYdIuRc4NwvGSStD2duQxciClvUFwbEXidzl8ueP4drpgEp/Ojmsck3ijcP80
 eDLwVBvpPFeBlg2RfnPxInoow4vbtifFFc/i5QecbSCLUz5qRNGd4VZZzd5lWR13oXF2IsfFzJ4
 Wxlh1XMQMjNUbw1MKAtBdLwKKOExLOmbhILu1gDAlI+Klq3t6xawoURFAPeG636lviP3nLUAL3I
 U16GX7eJ+fqPWrA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The device match config init table already has zero values, so rework
the container struct to hold a copy of the init table that can be
override be the DT specified values. By doing this, only the number of
vregs remain in the device match config that will be later needed, so
instead of holding the cfg after probe, store the number of vregs in the
container struct.

Fixes: 99a517a582fc ("phy: qualcomm: phy-qcom-eusb2-repeater: Zero out untouched tuning regs")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v3:
- Reworked so that it uses base + reg-index.
- Link to v2: https://lore.kernel.org/r/20240105-phy-qcom-eusb2-repeater-fixes-v2-0-775d98e7df05@linaro.org

Changes in v2:
- The regfields is being dropped from the repeater init, but it's done
  in the second patch in order to not break bisectability, as it is
  still needed by the zero-out loop.
- Added Konrad's R-b tag to the first patch. Did not add Elliot's T-b
  tag as the second patch has been reworked massively.
- The zero-out loop is dropped now by holding a copy of the init_tlb in
  the container struct. This led to dropping the cfg from the container
  struct (see second patch commit message for more details).
- Link to v1: https://lore.kernel.org/r/20240104-phy-qcom-eusb2-repeater-fixes-v1-0-047b7b6b8333@linaro.org
---
 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c | 166 +++++++++----------------
 1 file changed, 62 insertions(+), 104 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
index a623f092b11f..a43e20abb10d 100644
--- a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -37,56 +37,28 @@
 #define EUSB2_TUNE_EUSB_EQU		0x5A
 #define EUSB2_TUNE_EUSB_HS_COMP_CUR	0x5B
 
-#define QCOM_EUSB2_REPEATER_INIT_CFG(r, v)	\
-	{					\
-		.reg = r,			\
-		.val = v,			\
-	}
-
-enum reg_fields {
-	F_TUNE_EUSB_HS_COMP_CUR,
-	F_TUNE_EUSB_EQU,
-	F_TUNE_EUSB_SLEW,
-	F_TUNE_USB2_HS_COMP_CUR,
-	F_TUNE_USB2_PREEM,
-	F_TUNE_USB2_EQU,
-	F_TUNE_USB2_SLEW,
-	F_TUNE_SQUELCH_U,
-	F_TUNE_HSDISC,
-	F_TUNE_RES_FSDIF,
-	F_TUNE_IUSB2,
-	F_TUNE_USB2_CROSSOVER,
-	F_NUM_TUNE_FIELDS,
-
-	F_FORCE_VAL_5 = F_NUM_TUNE_FIELDS,
-	F_FORCE_EN_5,
-
-	F_EN_CTL1,
-
-	F_RPTR_STATUS,
-	F_NUM_FIELDS,
-};
-
-static struct reg_field eusb2_repeater_tune_reg_fields[F_NUM_FIELDS] = {
-	[F_TUNE_EUSB_HS_COMP_CUR] = REG_FIELD(EUSB2_TUNE_EUSB_HS_COMP_CUR, 0, 1),
-	[F_TUNE_EUSB_EQU] = REG_FIELD(EUSB2_TUNE_EUSB_EQU, 0, 1),
-	[F_TUNE_EUSB_SLEW] = REG_FIELD(EUSB2_TUNE_EUSB_SLEW, 0, 1),
-	[F_TUNE_USB2_HS_COMP_CUR] = REG_FIELD(EUSB2_TUNE_USB2_HS_COMP_CUR, 0, 1),
-	[F_TUNE_USB2_PREEM] = REG_FIELD(EUSB2_TUNE_USB2_PREEM, 0, 2),
-	[F_TUNE_USB2_EQU] = REG_FIELD(EUSB2_TUNE_USB2_EQU, 0, 1),
-	[F_TUNE_USB2_SLEW] = REG_FIELD(EUSB2_TUNE_USB2_SLEW, 0, 1),
-	[F_TUNE_SQUELCH_U] = REG_FIELD(EUSB2_TUNE_SQUELCH_U, 0, 2),
-	[F_TUNE_HSDISC] = REG_FIELD(EUSB2_TUNE_HSDISC, 0, 2),
-	[F_TUNE_RES_FSDIF] = REG_FIELD(EUSB2_TUNE_RES_FSDIF, 0, 2),
-	[F_TUNE_IUSB2] = REG_FIELD(EUSB2_TUNE_IUSB2, 0, 3),
-	[F_TUNE_USB2_CROSSOVER] = REG_FIELD(EUSB2_TUNE_USB2_CROSSOVER, 0, 2),
-
-	[F_FORCE_VAL_5] = REG_FIELD(EUSB2_FORCE_VAL_5, 0, 7),
-	[F_FORCE_EN_5] = REG_FIELD(EUSB2_FORCE_EN_5, 0, 7),
-
-	[F_EN_CTL1] = REG_FIELD(EUSB2_EN_CTL1, 0, 7),
-
-	[F_RPTR_STATUS] = REG_FIELD(EUSB2_RPTR_STATUS, 0, 7),
+enum eusb2_reg_layout {
+	TUNE_EUSB_HS_COMP_CUR,
+	TUNE_EUSB_EQU,
+	TUNE_EUSB_SLEW,
+	TUNE_USB2_HS_COMP_CUR,
+	TUNE_USB2_PREEM,
+	TUNE_USB2_EQU,
+	TUNE_USB2_SLEW,
+	TUNE_SQUELCH_U,
+	TUNE_HSDISC,
+	TUNE_RES_FSDIF,
+	TUNE_IUSB2,
+	TUNE_USB2_CROSSOVER,
+	NUM_TUNE_FIELDS,
+
+	FORCE_VAL_5 = NUM_TUNE_FIELDS,
+	FORCE_EN_5,
+
+	EN_CTL1,
+
+	RPTR_STATUS,
+	LAYOUT_SIZE,
 };
 
 struct eusb2_repeater_cfg {
@@ -98,10 +70,11 @@ struct eusb2_repeater_cfg {
 
 struct eusb2_repeater {
 	struct device *dev;
-	struct regmap_field *regs[F_NUM_FIELDS];
+	struct regmap *regmap;
 	struct phy *phy;
 	struct regulator_bulk_data *vregs;
 	const struct eusb2_repeater_cfg *cfg;
+	u32 base;
 	enum phy_mode mode;
 };
 
@@ -109,10 +82,10 @@ static const char * const pm8550b_vreg_l[] = {
 	"vdd18", "vdd3",
 };
 
-static const u32 pm8550b_init_tbl[F_NUM_TUNE_FIELDS] = {
-	[F_TUNE_IUSB2] = 0x8,
-	[F_TUNE_SQUELCH_U] = 0x3,
-	[F_TUNE_USB2_PREEM] = 0x5,
+static const u32 pm8550b_init_tbl[NUM_TUNE_FIELDS] = {
+	[TUNE_IUSB2] = 0x8,
+	[TUNE_SQUELCH_U] = 0x3,
+	[TUNE_USB2_PREEM] = 0x5,
 };
 
 static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
@@ -140,47 +113,42 @@ static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr)
 
 static int eusb2_repeater_init(struct phy *phy)
 {
-	struct reg_field *regfields = eusb2_repeater_tune_reg_fields;
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
 	struct device_node *np = rptr->dev->of_node;
-	u32 init_tbl[F_NUM_TUNE_FIELDS] = { 0 };
-	u8 override;
+	struct regmap *regmap = rptr->regmap;
+	const u32 *init_tbl = rptr->cfg->init_tbl;
+	u8 tune_usb2_preem = init_tbl[TUNE_USB2_PREEM];
+	u8 tune_hsdisc = init_tbl[TUNE_HSDISC];
+	u8 tune_iusb2 = init_tbl[TUNE_IUSB2];
+	u32 base = rptr->base;
 	u32 val;
 	int ret;
-	int i;
+
+	of_property_read_u8(np, "qcom,tune-usb2-amplitude", &tune_iusb2);
+	of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &tune_hsdisc);
+	of_property_read_u8(np, "qcom,tune-usb2-preem", &tune_usb2_preem);
 
 	ret = regulator_bulk_enable(rptr->cfg->num_vregs, rptr->vregs);
 	if (ret)
 		return ret;
 
-	regmap_field_update_bits(rptr->regs[F_EN_CTL1], EUSB2_RPTR_EN, EUSB2_RPTR_EN);
+	regmap_write(regmap, base + EUSB2_EN_CTL1, EUSB2_RPTR_EN);
 
-	for (i = 0; i < F_NUM_TUNE_FIELDS; i++) {
-		if (init_tbl[i]) {
-			regmap_field_update_bits(rptr->regs[i], init_tbl[i], init_tbl[i]);
-		} else {
-			/* Write 0 if there's no value set */
-			u32 mask = GENMASK(regfields[i].msb, regfields[i].lsb);
-
-			regmap_field_update_bits(rptr->regs[i], mask, 0);
-		}
-	}
-	memcpy(init_tbl, rptr->cfg->init_tbl, sizeof(init_tbl));
+	regmap_write(regmap, base + EUSB2_TUNE_EUSB_HS_COMP_CUR, init_tbl[TUNE_EUSB_HS_COMP_CUR]);
+	regmap_write(regmap, base + EUSB2_TUNE_EUSB_EQU, init_tbl[TUNE_EUSB_EQU]);
+	regmap_write(regmap, base + EUSB2_TUNE_EUSB_SLEW, init_tbl[TUNE_EUSB_SLEW]);
+	regmap_write(regmap, base + EUSB2_TUNE_USB2_HS_COMP_CUR, init_tbl[TUNE_USB2_HS_COMP_CUR]);
+	regmap_write(regmap, base + EUSB2_TUNE_USB2_EQU, init_tbl[TUNE_USB2_EQU]);
+	regmap_write(regmap, base + EUSB2_TUNE_USB2_SLEW, init_tbl[TUNE_USB2_SLEW]);
+	regmap_write(regmap, base + EUSB2_TUNE_SQUELCH_U, init_tbl[TUNE_SQUELCH_U]);
+	regmap_write(regmap, base + EUSB2_TUNE_RES_FSDIF, init_tbl[TUNE_RES_FSDIF]);
+	regmap_write(regmap, base + EUSB2_TUNE_USB2_CROSSOVER, init_tbl[TUNE_USB2_CROSSOVER]);
 
-	if (!of_property_read_u8(np, "qcom,tune-usb2-amplitude", &override))
-		init_tbl[F_TUNE_IUSB2] = override;
+	regmap_write(regmap, base + EUSB2_TUNE_USB2_PREEM, tune_usb2_preem);
+	regmap_write(regmap, base + EUSB2_TUNE_HSDISC, tune_hsdisc);
+	regmap_write(regmap, base + EUSB2_TUNE_IUSB2, tune_iusb2);
 
-	if (!of_property_read_u8(np, "qcom,tune-usb2-disc-thres", &override))
-		init_tbl[F_TUNE_HSDISC] = override;
-
-	if (!of_property_read_u8(np, "qcom,tune-usb2-preem", &override))
-		init_tbl[F_TUNE_USB2_PREEM] = override;
-
-	for (i = 0; i < F_NUM_TUNE_FIELDS; i++)
-		regmap_field_update_bits(rptr->regs[i], init_tbl[i], init_tbl[i]);
-
-	ret = regmap_field_read_poll_timeout(rptr->regs[F_RPTR_STATUS],
-					     val, val & RPTR_OK, 10, 5);
+	ret = regmap_read_poll_timeout(regmap, base + EUSB2_RPTR_STATUS, val, val & RPTR_OK, 10, 5);
 	if (ret)
 		dev_err(rptr->dev, "initialization timed-out\n");
 
@@ -191,6 +159,8 @@ static int eusb2_repeater_set_mode(struct phy *phy,
 				   enum phy_mode mode, int submode)
 {
 	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
+	struct regmap *regmap = rptr->regmap;
+	u32 base = rptr->base;
 
 	switch (mode) {
 	case PHY_MODE_USB_HOST:
@@ -199,10 +169,8 @@ static int eusb2_repeater_set_mode(struct phy *phy,
 		 * per eUSB 1.2 Spec. Below implement software workaround until
 		 * PHY and controller is fixing seen observation.
 		 */
-		regmap_field_update_bits(rptr->regs[F_FORCE_EN_5],
-					 F_CLK_19P2M_EN, F_CLK_19P2M_EN);
-		regmap_field_update_bits(rptr->regs[F_FORCE_VAL_5],
-					 V_CLK_19P2M_EN, V_CLK_19P2M_EN);
+		regmap_write(regmap, base + EUSB2_FORCE_EN_5, F_CLK_19P2M_EN);
+		regmap_write(regmap, base + EUSB2_FORCE_VAL_5, V_CLK_19P2M_EN);
 		break;
 	case PHY_MODE_USB_DEVICE:
 		/*
@@ -211,10 +179,8 @@ static int eusb2_repeater_set_mode(struct phy *phy,
 		 * repeater doesn't clear previous value due to shared
 		 * regulators (say host <-> device mode switch).
 		 */
-		regmap_field_update_bits(rptr->regs[F_FORCE_EN_5],
-					 F_CLK_19P2M_EN, 0);
-		regmap_field_update_bits(rptr->regs[F_FORCE_VAL_5],
-					 V_CLK_19P2M_EN, 0);
+		regmap_write(regmap, base + EUSB2_FORCE_EN_5, 0);
+		regmap_write(regmap, base + EUSB2_FORCE_VAL_5, 0);
 		break;
 	default:
 		return -EINVAL;
@@ -243,9 +209,8 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
 	struct device_node *np = dev->of_node;
-	struct regmap *regmap;
-	int i, ret;
 	u32 res;
+	int ret;
 
 	rptr = devm_kzalloc(dev, sizeof(*rptr), GFP_KERNEL);
 	if (!rptr)
@@ -258,22 +223,15 @@ static int eusb2_repeater_probe(struct platform_device *pdev)
 	if (!rptr->cfg)
 		return -EINVAL;
 
-	regmap = dev_get_regmap(dev->parent, NULL);
-	if (!regmap)
+	rptr->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!rptr->regmap)
 		return -ENODEV;
 
 	ret = of_property_read_u32(np, "reg", &res);
 	if (ret < 0)
 		return ret;
 
-	for (i = 0; i < F_NUM_FIELDS; i++)
-		eusb2_repeater_tune_reg_fields[i].reg += res;
-
-	ret = devm_regmap_field_bulk_alloc(dev, regmap, rptr->regs,
-					   eusb2_repeater_tune_reg_fields,
-					   F_NUM_FIELDS);
-	if (ret)
-		return ret;
+	rptr->base = res;
 
 	ret = eusb2_repeater_init_vregs(rptr);
 	if (ret < 0) {

---
base-commit: 01af33cc9894b4489fb68fa35c40e9fe85df63dc
change-id: 20240104-phy-qcom-eusb2-repeater-fixes-c9201113032c

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


