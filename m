Return-Path: <linux-kernel+bounces-86729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E6886C9C5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFE91F224A4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66F382860;
	Thu, 29 Feb 2024 13:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WkNcE7F6"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA017E561
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212038; cv=none; b=NOQxb7BCvDmhKpsJny2OqWWDaX9y6f2BTIKXe39iT/yk2HHninCUpfr1U0v6H0rhAAPSfgyQ3zvHFHt3k50MuvZThX8cMYnGKnmNxWPjXVgc5Ai8uKYL2Hu8IWjhi5AFtSHTMhzC3Xn31muwUgytoGJ9HCFCjJ44kp3H/fttjBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212038; c=relaxed/simple;
	bh=t7JWKvorJKpCBAS06JzHB/6hZJNkPjNsbGQugGO0kcQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tjhHsa06QI2ylX50Q913xvBiWjBjrA2IyCsMhKirPv5dq5b+uLP59db9n0slekyGqUYRAB4vmh/QeM03jQYoV891v0fK+IuUB/3qkoAlMxOYUUCLBjnPN0WY+vwntNuFl+7e7LFt4S6MBspN2Ym8lVZt3hSHytQT8Go+Qugd5P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WkNcE7F6; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d24a727f78so9989521fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 05:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709212034; x=1709816834; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKmGfxd/NVrK3oICkt9QzVVMEnc4HPhnKzXpPWZI9wc=;
        b=WkNcE7F6O+10TIQO4e+ipA5VYvwycn6nfNCcY09I9PFeVoyi9+OhhRpdAhKkwIYIxv
         qJlCMIiyCNrC9LLz/NW8q7d/Bikv+sH9ojpLB5D7IYOVhuIKnKhFUBxUMOHdgZXBx+Mm
         G5qZF25t2Vj/AevsuzZQXOLWt1dimVii1g7fOvY+fMYLDdSb2t6T/SZX+geqA2uYsxeo
         KUSCgc1AVYD43VefBPEJi4fIVlB0nl73Cblns/SFMFs81UZUJ9ePkstcYSN+aSyTnv+U
         Kx+MC2XKgq+rsHSYpNDXa10lztVRIKoYcV+5vGIhmx0qyqdjFGLmUCIhNIXgaHqY2OFP
         B2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709212034; x=1709816834;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NKmGfxd/NVrK3oICkt9QzVVMEnc4HPhnKzXpPWZI9wc=;
        b=wDo5y4an33JHwf2QUgCxeb7kiHL5gvxfjimeRXVBtAtkkgWwF6yqU9PNCwRCz/voKF
         Q5BKy83M+AsBsXVq3u+VXeV/OaiMuMQlYsZQNcUI6lfzcT0GSsSei7au7ZZvZl5wGCrt
         +tDMyxKTVmrdyv05ZXAFG/C0W8XPCTJEnqmNjpBFa2VBCit9BJt/lwF2QB2alOLcIni2
         3h9DhHqDe6OVTQtwvRwsMppMYurjW2UVMjPolwMizkIv7/Dk6Lqa27FgU39rMHjXImfp
         0sqzHzunTjwxYruIr4PmHGxzjEAy8eQqdKsIPbgHf8YMN+GuVOpZ39veNABCiWeW8ArR
         j9oQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5hs3hwbl9NRpKQMOQ3C3Jbzub7En0TkYrjFCJi3bW4KDGjv77O0nqIwUByTVBH2tus5mKxbC+dR+aSBQJt3+l/rrtcIsYEFkm+2Zs
X-Gm-Message-State: AOJu0YxTxUT5X0A37nBAYO+OjCRv0bI59cPzaIJbH6QheqRGgp7p1kh4
	/nLzcicAlrKUNM3xFVeqIIiwF13Ux4LUOI7BhqvIahx9VcM4kRzejyPZ+9FGMPA=
X-Google-Smtp-Source: AGHT+IGR24vSDb8RIrJOJ8Dth9NKC6WKDL2EdYZtE+ndU6zKZmHhEng+l5nObyZHyGbpbWXbNcYbHw==
X-Received: by 2002:a2e:9bcf:0:b0:2d2:b17a:1724 with SMTP id w15-20020a2e9bcf000000b002d2b17a1724mr1553831ljj.19.1709212034383;
        Thu, 29 Feb 2024 05:07:14 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id t7-20020a05600c198700b00412a38e732csm2071473wmq.35.2024.02.29.05.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 05:07:14 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 29 Feb 2024 14:07:04 +0100
Subject: [PATCH RFT 4/7] phy: qcom: qmp-combo: register a typec mux to
 change the QPHY_MODE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-4-07e24a231840@linaro.org>
References: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
In-Reply-To: <20240229-topic-sm8x50-upstream-phy-combo-typec-mux-v1-0-07e24a231840@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=5554;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=t7JWKvorJKpCBAS06JzHB/6hZJNkPjNsbGQugGO0kcQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBl4IF8rwodAWtg5N0fR68RXcppecYMYPGcfqo3cu0l
 Q0LGw62JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZeCBfAAKCRB33NvayMhJ0eFBD/
 9wQivhDbwoLkYitiSMy6wkHuR0+EGcXTgcHDVgPvdv9z6VEKGktJY/dH1Ryd8SlLDDrp3TYkjyo57a
 b9I0M/mDpIy/fjO2heYWODYTWZCnxBaImG6OwLesXmugWh11+EDeBgB93yJpOfKN9wpoDf+hWLnwzV
 hQaMRUEIBG/EsrTuH0CMWsEnHeI2VEAD4vSPV86dTGGXZ7OI2avQ3LLHJpliV5iZRFUr/kT/673DxR
 kTrab6/Inm6uh8eu5CTmiI5jDx/LlVoS3GFUR8O+hgns4ExFvJdCe6UIk90kJrkYD6PQUAUaBbIwg+
 KqhmQ5UY5nbxUekM/qd1QzEVyO9rU13L/Ao9Bl9pjcCo5g93WPvX+00d1GIo6Adz3Ug2ofcYd9Ahsp
 e1vAC8ySW+doSYkvyQO9c4PU5DHkD9O6VKaMh3iYUpz2X+TAWElcp2YC8YG1wQCvob4CNj2CGQlOXx
 fW2ZtXkDxbOiUDBozkL67xrJAKZW59nJJCPCfMXltJE1O8O5gj5xbtEKynNNzEwqJJzW7fwKv5stSe
 irfYC4vQYCeTHTvckJtFVhuNBdkWfAdZuRZgwoyCwcIqdMaQm+qO9E4fjgNWhKZbwEZUSa7vpifzVV
 6sn4S9WE7Kpq7dxnZNao6KAqQAACYwo8qKEGwfN8HQ1LqrBoHPZoyFUDx3/w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Register a typec mux in order to change the PHY mode on the Type-C
mux events depending on the mode and the svid when in Altmode setup.

The DisplayPort phy should be left enabled if is still powered on
by the DRM DisplayPort controller, so bail out until the DisplayPort
PHY is not powered off.

The Type-C Mode/SVID only changes on plug/unplug, and USB SAFE states
will be set in between of USB-Only, Combo and DisplayPort Only so
this will leave enough time to the DRM DisplayPort controller to
turn of the DisplayPort PHY.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 122 ++++++++++++++++++++++++++++--
 1 file changed, 117 insertions(+), 5 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
index ac5d528fd7a1..b5fb6cbcf867 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
@@ -19,6 +19,7 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/usb/typec.h>
+#include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
 
 #include <drm/bridge/aux-bridge.h>
@@ -1515,6 +1516,10 @@ struct qmp_combo {
 
 	struct typec_switch_dev *sw;
 	enum typec_orientation orientation;
+
+	struct typec_mux_dev *mux;
+	unsigned long mux_mode;
+	unsigned int svid;
 };
 
 static void qmp_v3_dp_aux_init(struct qmp_combo *qmp);
@@ -3295,17 +3300,111 @@ static int qmp_combo_typec_switch_set(struct typec_switch_dev *sw,
 	return 0;
 }
 
-static void qmp_combo_typec_unregister(void *data)
+static int qmp_combo_typec_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *state)
+{
+	struct qmp_combo *qmp = typec_mux_get_drvdata(mux);
+	const struct qmp_phy_cfg *cfg = qmp->cfg;
+	enum qphy_mode new_mode;
+	unsigned int svid;
+
+	if (state->mode == qmp->mode)
+		return 0;
+
+	mutex_lock(&qmp->phy_mutex);
+
+	if (state->alt)
+		svid = state->alt->svid;
+	else
+		svid = 0; // No SVID
+
+	if (svid) {
+		switch (state->mode) {
+			/* DP Only */
+			case TYPEC_DP_STATE_C:
+			case TYPEC_DP_STATE_E:
+				new_mode = QPHY_MODE_DP_ONLY;
+				break;
+
+				/* DP + USB */
+			case TYPEC_DP_STATE_D:
+			case TYPEC_DP_STATE_F:
+				/* Safe fallback...*/
+			default:
+				new_mode = QPHY_MODE_COMBO;
+				break;
+		}
+	} else {
+		/* Only switch to USB_ONLY when we know we only have USB3 */
+		if (qmp->mux_mode == TYPEC_MODE_USB3)
+			new_mode = QPHY_MODE_USB_ONLY;
+		else
+			new_mode = QPHY_MODE_COMBO;
+	}
+
+	if (new_mode == qmp->init_mode) {
+		dev_dbg(qmp->dev, "typec_mux_set: same phy mode, bail out\n");
+		qmp->mode = state->mode;
+		goto out;
+	}
+
+	if (qmp->init_mode != QPHY_MODE_USB_ONLY && qmp->dp_powered_on) {
+		dev_dbg(qmp->dev, "typec_mux_set: DP is still powered on, delaying switch\n");
+		goto out;
+	}
+
+	dev_dbg(qmp->dev, "typec_mux_set: switching from phy mode %d to %d\n",
+		qmp->init_mode, new_mode);
+
+	qmp->mux_mode = state->mode;
+	qmp->init_mode = new_mode;
+
+	if (qmp->init_count) {
+		if (qmp->usb_init_count)
+			qmp_combo_usb_power_off(qmp->usb_phy);
+		if (qmp->dp_init_count)
+			writel(DP_PHY_PD_CTL_PSR_PWRDN, qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
+		qmp_combo_com_exit(qmp, true);
+
+		/* Now everything's powered down, power up the right PHYs */
+
+		qmp_combo_com_init(qmp, true);
+		if (qmp->init_mode == QPHY_MODE_DP_ONLY && qmp->usb_init_count) {
+			qmp->usb_init_count--;
+		} else if (qmp->init_mode != QPHY_MODE_DP_ONLY) {
+			qmp_combo_usb_power_on(qmp->usb_phy);
+			if (!qmp->usb_init_count)
+				qmp->usb_init_count++;
+		}
+		if (qmp->init_mode != QPHY_MODE_USB_ONLY && qmp->dp_init_count)
+			cfg->dp_aux_init(qmp);
+	}
+
+out:
+	mutex_unlock(&qmp->phy_mutex);
+
+	return 0;
+}
+
+static void qmp_combo_typec_switch_unregister(void *data)
 {
 	struct qmp_combo *qmp = data;
 
 	typec_switch_unregister(qmp->sw);
 }
 
-static int qmp_combo_typec_switch_register(struct qmp_combo *qmp)
+static void qmp_combo_typec_mux_unregister(void *data)
+{
+	struct qmp_combo *qmp = data;
+
+	typec_mux_unregister(qmp->mux);
+}
+
+static int qmp_combo_typec_register(struct qmp_combo *qmp)
 {
 	struct typec_switch_desc sw_desc = {};
+	struct typec_mux_desc mux_desc = { };
 	struct device *dev = qmp->dev;
+	int ret;
 
 	sw_desc.drvdata = qmp;
 	sw_desc.fwnode = dev->fwnode;
@@ -3316,10 +3415,23 @@ static int qmp_combo_typec_switch_register(struct qmp_combo *qmp)
 		return PTR_ERR(qmp->sw);
 	}
 
-	return devm_add_action_or_reset(dev, qmp_combo_typec_unregister, qmp);
+	ret = devm_add_action_or_reset(dev, qmp_combo_typec_switch_unregister, qmp);
+	if (ret)
+		return ret;
+
+	mux_desc.drvdata = qmp;
+	mux_desc.fwnode = dev->fwnode;
+	mux_desc.set = qmp_combo_typec_mux_set;
+	qmp->mux = typec_mux_register(dev, &mux_desc);
+	if (IS_ERR(qmp->mux)) {
+		dev_err(dev, "Unable to register typec mux: %pe\n", qmp->mux);
+		return PTR_ERR(qmp->mux);
+	}
+
+	return devm_add_action_or_reset(dev, qmp_combo_typec_mux_unregister, qmp);
 }
 #else
-static int qmp_combo_typec_switch_register(struct qmp_combo *qmp)
+static int qmp_combo_typec_register(struct qmp_combo *qmp)
 {
 	return 0;
 }
@@ -3532,7 +3644,7 @@ static int qmp_combo_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = qmp_combo_typec_switch_register(qmp);
+	ret = qmp_combo_typec_register(qmp);
 	if (ret)
 		return ret;
 

-- 
2.34.1


