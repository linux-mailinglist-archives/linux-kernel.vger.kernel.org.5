Return-Path: <linux-kernel+bounces-45200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8C8842CE5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E077028BDAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE93B762C6;
	Tue, 30 Jan 2024 19:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5bNKNr+"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86FB7B3FB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643193; cv=none; b=jerYtYZ5dkZPhK621uaCE/p1Oshbi86eCJJixvjiGv+023NZOG2ENB/GryH6VUZmwkoVnDyDn5fYoep9JWiMHy3kIo50+q00P2/ZZk6/Q9HuXHz5m+ZPF5Mh6FfOAkHb3KIGtg/FFmHlU+A1qAFW5GvgLYI4hNfdyf7OYOhRY8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643193; c=relaxed/simple;
	bh=hk/DedP2L3/VRqEh7fWqwlAKhIB27bemjG1QWZ1Alpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PZYB9wnLatKSwdcfXu4hRZoIDvktgo0N3fN0uIxtG/Cdc6BG8s7QKwZO6sUPB+eL+S6sv0rwYdOX1Cl+Ix9d0RCsGZXchL7Rixuo79rrjpqs8cFs7WV87ilF95HcRtxBkOlqlhrovMJ+nsYEw1ua0P7AYE4ydyRcL+sWp1chKwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S5bNKNr+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso5423857e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706643190; x=1707247990; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2zZsZyr5R7AbO85vAky05ZUAjMGqm8uMb7I7shDT42o=;
        b=S5bNKNr+LsX0LAG5YGdYgj0IShdmD2tV+4NeJr/HsBUWHH/VhIHNnCEioS3R4iuoC8
         EKPN/10qB6yLPNk00BNoN2CGMetOPbRup3I+4852oJIpkkH1KdWgikM+4gHSjdUcP/l+
         Es+JuTmz6FaAEqJnXfCR1SYGowBIc1SLaZZ3MF4xR/TelhpTGVbQSl1JBcneA3zwLOeA
         FWuSaxIVWJnrDi35Nut/q1bjfGzfTZA0y4v8hdVZWWHijK7w81jwKAS8zPPOy4VrP9DC
         d7pmpSP73hiToBhpasBt+Aw/3TzYzwdh9u2l19B2hIavXmER5NVapv/Ye3LPql9rHIJw
         s7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706643190; x=1707247990;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zZsZyr5R7AbO85vAky05ZUAjMGqm8uMb7I7shDT42o=;
        b=EJAJXMsVcJvNmajn3AcCFqHKOj3LorUBYakAgT4REDNQ6ogTFT03PQBu60xKnnIeVE
         TCr7rYS9x5jZu5qLlVsNFmOoFAxhPwlPYczInrDUwa+w1LgujQsrzPOpGpbpR+qfnv9s
         vVZI+GKZt7xWvaQbvR7JfzHvORZl6V54UgSaca/qHWFZJpNyxBY7hEJcME79TPEfmbsN
         +NIQkSNjzP7B3EFw3i0LpnKd38zsFi1SLulOR5/3KsqBtN+v49ttMo7FV5dU3E55DaTH
         JxqoEOMq44zXE8z2ai7FZxhgOljtAx5BlDD3dHUaJ3S1poOB2yxTf7EB7acQ/WQBhmHK
         aowQ==
X-Gm-Message-State: AOJu0YxwiRP9epqX3gWcRCbz4ymM/d4WTlRFqtIqnmm7oPitBkjPRLld
	iSYZNg+hJd9PBxHyqxrl+GwOU+caOEB2lidNGrX54k0/UMwvxIHFT3k7aWteGfY=
X-Google-Smtp-Source: AGHT+IG0/MxmtJtMdwnQazfMj2OisztZXVcCkfTINEAOrRTh5sDxBn1CY82/fhFQnH+nRKi2TAwVhA==
X-Received: by 2002:a05:6512:78b:b0:511:2264:7581 with SMTP id x11-20020a056512078b00b0051122647581mr199733lfr.6.1706643190007;
        Tue, 30 Jan 2024 11:33:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXR8RlSNsOiI/tMTkFjLFG/u7zEXAPK0m6I1V9pbpDlax8LhQR6luABVR0QM1n45j/Yj/8Q3/Md6K0Fe//FrEwrH026KeMTPmv7/swwFHnPYdoA/2IXySbj6w5MXFiL1K8E8iNaRGC43nxqfoqWJEzYh4nxTZPHOY8YZ6xDzaQXdtzBDtJpG9I8Iw7enOqva48a5gUeLijb6jJdpl2IcVk0rYQCv9FMo4LWURHcFWX3k7mXyoEcoC0Q9uCLJnHVJJeyEvj1lDWEeWDSfgY/xr+B5kEZeLXYVjX//co9hS0jhesFdNd+LfKVPMEtaqO1h6EWjTWK/kzjc8wNX30ysgMtQBnwP69AxOHcquvl/JKut3jdbhG3MQVVeRZCeG6Cp4vQoD+5ifsutBQLVHNh9g80z7mRmmOE7m21iWO9XpcEztCscr0oFgF9h1rT1z0IpHjlVnml0o2UsodJlOnAsqT8qhxL47aT9w6eLrUVRRhkwZLFJhPFQEduJPzVSNbexDFaTCrh42feZcfMM+k+PqEqX/vLX1PKxsuNduK0NiePn8a1eepUYiGc4lbtvsIU1kJDQyffXQcMDfN2N6PmlL02U03XiHv/93gQxmTcP3DO
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id u25-20020a05651220d900b0051119371e7csm366525lfr.120.2024.01.30.11.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 11:33:09 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Jan 2024 21:32:56 +0200
Subject: [PATCH v3 3/6] usb: typec: qcom-pmic-typec: add support for PMI632
 PMIC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-pmi632-typec-v3-3-b05fe44f0a51@linaro.org>
References: <20240130-pmi632-typec-v3-0-b05fe44f0a51@linaro.org>
In-Reply-To: <20240130-pmi632-typec-v3-0-b05fe44f0a51@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-usb@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=6422;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=hk/DedP2L3/VRqEh7fWqwlAKhIB27bemjG1QWZ1Alpo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBluU7xuEc9dLon/I03dZLVJ8AH0OTFCikdfL54q
 UV0cyPdoeWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZblO8QAKCRCLPIo+Aiko
 1ZVhCACqOM6ckk97TlttaXG+ggr8pErSJ2IOOfEZ1sirLFYkY/eGai3LAVi4+rm52zg0oD2lkJ6
 rBNWCkWDxkLgdJAioMibo2sJaXiscgoCW8CuFENN6vT9CkqeCeaqSG35JYwh+UXjB6VhFVHgDc8
 TLoehsz3hBZjGJOi+z/ONTV2rGB/GR0MxyCDA91xZQV8S5IZu3f6hDLQg2oQGGQ45+ol1RSsJTE
 H5dtV692CnzO0P+7QX4PrSbYESFGHSO0ylU+0Gu6/eGraFVrApAl01XdJ1InaExq+p9T7J11ybk
 Y1BwVQ9RgPzjS5CPoLcOUxtX/WLQDo9Mfyl2O+LbLGTSV2Lz
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The PMI632 PMIC support Type-C port handling, but lacks USB
PowerDelivery support. The TCPM requires all callbacks to be provided
by the implementation. Implement a special, 'stub' Qcom PD PHY
implementation to enable the PMI632 support.

Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp3
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/tcpm/qcom/Makefile               |  3 +-
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c      | 30 ++++++--
 .../usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.h    |  2 +
 .../typec/tcpm/qcom/qcom_pmic_typec_pdphy_stub.c   | 80 ++++++++++++++++++++++
 4 files changed, 107 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/typec/tcpm/qcom/Makefile b/drivers/usb/typec/tcpm/qcom/Makefile
index dc1e8832e197..cc23042b9487 100644
--- a/drivers/usb/typec/tcpm/qcom/Makefile
+++ b/drivers/usb/typec/tcpm/qcom/Makefile
@@ -3,4 +3,5 @@
 obj-$(CONFIG_TYPEC_QCOM_PMIC)		+= qcom_pmic_tcpm.o
 qcom_pmic_tcpm-y			+= qcom_pmic_typec.o \
 					   qcom_pmic_typec_port.o \
-					   qcom_pmic_typec_pdphy.o
+					   qcom_pmic_typec_pdphy.o \
+					   qcom_pmic_typec_pdphy_stub.o \
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index 82e3f59ea471..e48412cdcb0f 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -42,7 +42,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	const struct pmic_typec_resources *res;
 	struct regmap *regmap;
 	struct device *bridge_dev;
-	u32 base[2];
+	u32 base;
 	int ret;
 
 	res = of_device_get_match_data(dev);
@@ -62,19 +62,29 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	ret = of_property_read_u32_array(np, "reg", base, 2);
+	ret = of_property_read_u32_index(np, "reg", 0, &base);
 	if (ret)
 		return ret;
 
 	ret = qcom_pmic_typec_port_probe(pdev, tcpm,
-					 res->port_res, regmap, base[0]);
+					 res->port_res, regmap, base);
 	if (ret)
 		return ret;
 
-	ret = qcom_pmic_typec_pdphy_probe(pdev, tcpm,
-					  res->pdphy_res, regmap, base[1]);
-	if (ret)
-		return ret;
+	if (res->pdphy_res) {
+		ret = of_property_read_u32_index(np, "reg", 1, &base);
+		if (ret)
+			return ret;
+
+		ret = qcom_pmic_typec_pdphy_probe(pdev, tcpm,
+						  res->pdphy_res, regmap, base);
+		if (ret)
+			return ret;
+	} else {
+		ret = qcom_pmic_typec_pdphy_stub_probe(pdev, tcpm);
+		if (ret)
+			return ret;
+	}
 
 	platform_set_drvdata(pdev, tcpm);
 
@@ -123,8 +133,14 @@ static const struct pmic_typec_resources pm8150b_typec_res = {
 	.port_res = &pm8150b_port_res,
 };
 
+static const struct pmic_typec_resources pmi632_typec_res = {
+	/* PD PHY not present */
+	.port_res = &pm8150b_port_res,
+};
+
 static const struct of_device_id qcom_pmic_typec_table[] = {
 	{ .compatible = "qcom,pm8150b-typec", .data = &pm8150b_typec_res },
+	{ .compatible = "qcom,pmi632-typec", .data = &pmi632_typec_res },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, qcom_pmic_typec_table);
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.h b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.h
index 5f428e67ccfe..04dee20293cf 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.h
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.h
@@ -31,5 +31,7 @@ int qcom_pmic_typec_pdphy_probe(struct platform_device *pdev,
 				const struct pmic_typec_pdphy_resources *res,
 				struct regmap *regmap,
 				u32 base);
+int qcom_pmic_typec_pdphy_stub_probe(struct platform_device *pdev,
+				     struct pmic_typec *tcpm);
 
 #endif /* __QCOM_PMIC_TYPEC_PDPHY_H__ */
diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy_stub.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy_stub.c
new file mode 100644
index 000000000000..df79059cda67
--- /dev/null
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy_stub.c
@@ -0,0 +1,80 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2024, Linaro Ltd. All rights reserved.
+ */
+
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/usb/pd.h>
+#include <linux/usb/tcpm.h>
+#include "qcom_pmic_typec.h"
+#include "qcom_pmic_typec_pdphy.h"
+
+static int qcom_pmic_typec_pdphy_stub_pd_transmit(struct tcpc_dev *tcpc,
+						  enum tcpm_transmit_type type,
+						  const struct pd_message *msg,
+						  unsigned int negotiated_rev)
+{
+	struct pmic_typec *tcpm = tcpc_to_tcpm(tcpc);
+	struct device *dev = tcpm->dev;
+
+	dev_dbg(dev, "pdphy_transmit: type=%d\n", type);
+
+	tcpm_pd_transmit_complete(tcpm->tcpm_port,
+				  TCPC_TX_SUCCESS);
+
+	return 0;
+}
+
+static int qcom_pmic_typec_pdphy_stub_set_pd_rx(struct tcpc_dev *tcpc, bool on)
+{
+	struct pmic_typec *tcpm = tcpc_to_tcpm(tcpc);
+	struct device *dev = tcpm->dev;
+
+	dev_dbg(dev, "set_pd_rx: %s\n", on ? "on" : "off");
+
+	return 0;
+}
+
+static int qcom_pmic_typec_pdphy_stub_set_roles(struct tcpc_dev *tcpc, bool attached,
+						enum typec_role power_role,
+						enum typec_data_role data_role)
+{
+	struct pmic_typec *tcpm = tcpc_to_tcpm(tcpc);
+	struct device *dev = tcpm->dev;
+
+	dev_dbg(dev, "pdphy_set_roles: data_role_host=%d power_role_src=%d\n",
+		data_role, power_role);
+
+	return 0;
+}
+
+static int qcom_pmic_typec_pdphy_stub_start(struct pmic_typec *tcpm,
+					    struct tcpm_port *tcpm_port)
+{
+	return 0;
+}
+
+static void qcom_pmic_typec_pdphy_stub_stop(struct pmic_typec *tcpm)
+{
+}
+
+int qcom_pmic_typec_pdphy_stub_probe(struct platform_device *pdev,
+				     struct pmic_typec *tcpm)
+{
+	tcpm->tcpc.set_pd_rx = qcom_pmic_typec_pdphy_stub_set_pd_rx;
+	tcpm->tcpc.set_roles = qcom_pmic_typec_pdphy_stub_set_roles;
+	tcpm->tcpc.pd_transmit = qcom_pmic_typec_pdphy_stub_pd_transmit;
+
+	tcpm->pdphy_start = qcom_pmic_typec_pdphy_stub_start;
+	tcpm->pdphy_stop = qcom_pmic_typec_pdphy_stub_stop;
+
+	return 0;
+}

-- 
2.39.2


