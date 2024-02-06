Return-Path: <linux-kernel+bounces-55730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E5984C0F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C371C2492E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05221C694;
	Tue,  6 Feb 2024 23:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E+6qXcTL"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46B1CD1B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 23:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262439; cv=none; b=G5X45wiixQkPEz9MtH4r0HpQjtD8VHNcDKpLsw/UrUJdrCulzbuKkoEbWwYsSiHA/2ZZTNPJzvqtUZ3ciqknXw5uT0/MpmI+7Y1Y8lQWkcAQP+uetEazZ56ZZtkGiOG1DGvjA9fazQLALyPy3ZHWnrGAnOqutVnuEH7tj9p6ZfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262439; c=relaxed/simple;
	bh=ZJ1b8KghLleqJ8T+rAkzn1+HdBws+EtGs+BFf25yaNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GzsV6DgkDjQZEkddJ8K3R/Hi1BsNq7wb++JTTbh04yEm7OYz5g/JdbdKCFIATJwIiBb/bwkD3GLcMTeTmVuKmbjGpN1YGo1/pplgm+BpRlh/VyS97JyxPiTqia4b+LQEgxEAVZt2PDNQHRmvkdlui3vhMEYpWIw6SN6A1I6s4gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E+6qXcTL; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a385259f0a5so99800866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 15:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707262433; x=1707867233; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MGYOUF8uM1GQoN69Xx2a7IClOY1nWEoUB3pl/we5xUQ=;
        b=E+6qXcTLUBy5El9uVCY4TbLDgx/rKQbVR4SrtIqCyiWqmBYpNSi72izpeIy/Ib6jq2
         v6VJPfgYpS5eg8BQ3qM4DYTdZMHtdNkvDJDUYIAGu+Zkn8WZLKlg/dR5dD5SJYrVuEw5
         nNGjw3aK2JDxMwXiV5taeMf11XTnrB/fQb4exU/4dVDnfbz1uP7Tk3RaViiTNsofDobY
         YDjp7usTJf5M+FY1/9fE34UIwFCSATXPFdusUC2FbVRYOYilJogJgC7o38ws7cr2xKYz
         M6gRlK4w2BD8M9nyGTglCnKMfsAw6MgZ4pfZk4VJkZFkA93zj+ga8EYDhNPwmZFAfrUc
         wtrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707262433; x=1707867233;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MGYOUF8uM1GQoN69Xx2a7IClOY1nWEoUB3pl/we5xUQ=;
        b=tF7txiDE2c7nuG0jpgls3lGUjYyENiKqQEy0MXlx8+19EL/BlII1wNMRlBXY7JGi1m
         4yPM2LxZYk3qKdpqdKvc4Fp7m1i9AkuUFO1f0/9FjB9gYmFC6op0N9bpXU1cLw+dBe8L
         /J7PfFlfvHMMcWPUjuE0hymAPFYk7IAT3UFyfGv4XxlfmsXyQ81YVFAAR0Ydow2hvfZj
         KLjfyRanhcAG7lwkawt9yu30SZgo++hXzc75KJqnRvz+2iiMrk3AoWZ2ebczOT3CPwrj
         uGSbdR08ADWPFdKfslftGPYfSnVKgtbROFOAsxvj79YWJshHlN8QY9IsJNfOcMi5+XHG
         csSg==
X-Gm-Message-State: AOJu0Yya2gpMRjH2udfQV+kfl6yxb6cmorxd1koKZlUqvThoqXYklc98
	tnMZ0wzTvXxrcagn/iiK5yNt0M/Zj6IVb3ZlPrnw7QpnjPtVzacBZ3PisLHvaks=
X-Google-Smtp-Source: AGHT+IGVz7HuWzYNsl2sPusAdsnXMlWxF9DRATNu3wMO7Hr5UU3S7SHGY0MsgOvTxZD41f9z4f1nDw==
X-Received: by 2002:a17:906:af91:b0:a37:9b07:fffc with SMTP id mj17-20020a170906af9100b00a379b07fffcmr4344594ejb.12.1707262433271;
        Tue, 06 Feb 2024 15:33:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIVDhXl2w9Mr2g8ySKb7VwzoyBxI31Ha1CcTGlEpVjAtkdSLrYcDyVo6gHqF6bS379agbqqeS37t8DsG4he15eRWwHzvbxX8tqVdNki6Shof5gUGyro36ItgnQrOLW+MNVxjna7csiPp3KfZgHT3rYY+CB7cbemUQYCXxIr+KGTv56JFFMNqJ9nSbDUJuEquUj09WwdwBTZuUWIks14szumAaAstSOx1mM6wnKAXrVZGb2ALMrMd4n7ywjHo1RHvuxyNDgKAs/XdZEiaX7MpN2dvIona8B6tBjZTS7GO2A6nAO/zsvQioTNTCULyYHw1pDNFUsc5Iiv3QQmkLFu5/bBO0aRR67YIIQQ2xUKKAmwAGIRutQ1MH7jZzBMNzw
Received: from [127.0.1.1] ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id un9-20020a170907cb8900b00a36ed37683fsm72404ejc.215.2024.02.06.15.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 15:33:52 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 07 Feb 2024 01:33:42 +0200
Subject: [PATCH RFC 1/2] spmi: Add support for multi-master
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-spmi-multi-master-support-v1-1-ce57f301c7fd@linaro.org>
References: <20240207-spmi-multi-master-support-v1-0-ce57f301c7fd@linaro.org>
In-Reply-To: <20240207-spmi-multi-master-support-v1-0-ce57f301c7fd@linaro.org>
To: Stephen Boyd <sboyd@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=13789; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=ZJ1b8KghLleqJ8T+rAkzn1+HdBws+EtGs+BFf25yaNE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlwsHc6sOSTWPG1JjumHLk8DdAa3QRC74YuxX6J
 B8N0YXjVT2JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZcLB3AAKCRAbX0TJAJUV
 Vnf9EAC7fRIYjVxEGfFIbqFPqBUek4oQzqBoNxiRiBiUN1Pd8gpSd2ZjgmsFW4zb69IJ1bAUyXo
 ubmPGiJSiz5EhLZw5CWd0yqn9ZXmf93slTdkPQD69Kz9+D17DULg4NIuLm5LiuTygKRSpCCyIxS
 vG3EVABcqw3fLmDF8WqwKyOw/vuCxjr44R3dEbP53c883HkbKK6vpFp58mquo5BIKEBFnbifv+k
 +R31USU7/pGmYICdqVVrp6aLOxYVmwALebRXZ0oIMRng/2AVJuVfM2yp1DFZXgXPtE2f//4Vif7
 yZgWGMRIojLHpDUM0nDBSNm7QwxATd0wUsidtYTstDMaNJzuulAX9iS6BBPHk+Q7OiS3T8hTsn7
 gEQa9jdge/ziJ9BrVqCfmpAppCX9rhgpPN4/EJsm/dPrKCn9kN/tPmyWXXq17/x1+ZTVMjL4wDR
 4O7I7AS6+P/t6/xUboOQ/FAizKbKWNu4uK8Oisl9ewtR/vGWFvk+V4Jnq3fIkNLMPVk7W2xDvUT
 L1OeEoHwE1J/wuLdLU82QeVJThhesmK03DvQ49xnFE5r+CA/EjXx13eHhWhZ8UoHI9mQRBrziQS
 0QtXM/k36uDuHwo1etVBiOz3VW2WxAlxEre60XC/hI/sMomorz8v6RQiih3frbSGSKbUFT+9XdJ
 R0y5oA6nNPtSVcQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Some newer SPMI controllers support multiple bus masters.
Such a master can control multiple slave devices. The generic
framework needs to be able to pass on the master id to the
controller-specific driver. So do that. The framework will
check if the devicetree child nodes are actually bus masters
and will register the devices for each master. The legacy
approach will still be supported for backwards compatibility.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/spmi/spmi-mtk-pmif.c |  6 ++--
 drivers/spmi/spmi-pmic-arb.c | 10 +++---
 drivers/spmi/spmi.c          | 76 ++++++++++++++++++++++++++++++--------------
 include/linux/spmi.h         | 10 +++---
 4 files changed, 67 insertions(+), 35 deletions(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index 5079442f8ea1..b19bb0351ff1 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -286,7 +286,7 @@ static bool pmif_is_fsm_vldclr(struct pmif *arb)
 	return GET_SWINF(reg_rdata) == SWINF_WFVLDCLR;
 }
 
-static int pmif_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid)
+static int pmif_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 master_id, u8 sid)
 {
 	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
 	u32 rdata, cmd;
@@ -308,7 +308,7 @@ static int pmif_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid)
 	return ret;
 }
 
-static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
+static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 master_id, u8 sid,
 			      u16 addr, u8 *buf, size_t len)
 {
 	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
@@ -375,7 +375,7 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	return 0;
 }
 
-static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
+static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 master_id, u8 sid,
 			       u16 addr, const u8 *buf, size_t len)
 {
 	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 9ed1180fe31f..597207720146 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -341,7 +341,7 @@ pmic_arb_non_data_cmd_v2(struct spmi_controller *ctrl, u8 opc, u8 sid)
 }
 
 /* Non-data command */
-static int pmic_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid)
+static int pmic_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 master_id, u8 sid)
 {
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
 
@@ -410,7 +410,7 @@ static int pmic_arb_read_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
 	return 0;
 }
 
-static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
+static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 master_id, u8 sid,
 			     u16 addr, u8 *buf, size_t len)
 {
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
@@ -486,7 +486,7 @@ static int pmic_arb_write_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
 				      PMIC_ARB_CHANNEL_RW);
 }
 
-static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
+static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 master_id, u8 sid,
 			      u16 addr, const u8 *buf, size_t len)
 {
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
@@ -568,7 +568,7 @@ static void qpnpint_spmi_write(struct irq_data *d, u8 reg, void *buf,
 	u8 sid = hwirq_to_sid(d->hwirq);
 	u8 per = hwirq_to_per(d->hwirq);
 
-	if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, sid,
+	if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, 0, sid,
 			       (per << 8) + reg, buf, len))
 		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed irqchip transaction on %x\n",
 				    d->irq);
@@ -580,7 +580,7 @@ static void qpnpint_spmi_read(struct irq_data *d, u8 reg, void *buf, size_t len)
 	u8 sid = hwirq_to_sid(d->hwirq);
 	u8 per = hwirq_to_per(d->hwirq);
 
-	if (pmic_arb_read_cmd(pmic_arb->spmic, SPMI_CMD_EXT_READL, sid,
+	if (pmic_arb_read_cmd(pmic_arb->spmic, SPMI_CMD_EXT_READL, 0, sid,
 			      (per << 8) + reg, buf, len))
 		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed irqchip transaction on %x\n",
 				    d->irq);
diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index 3a60fd2e09e1..7dc778db7242 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -64,7 +64,7 @@ int spmi_device_add(struct spmi_device *sdev)
 	struct spmi_controller *ctrl = sdev->ctrl;
 	int err;
 
-	dev_set_name(&sdev->dev, "%d-%02x", ctrl->nr, sdev->usid);
+	dev_set_name(&sdev->dev, "%d-%02x-%02x", ctrl->nr, sdev->mid, sdev->usid);
 
 	err = device_add(&sdev->dev);
 	if (err < 0) {
@@ -91,19 +91,19 @@ void spmi_device_remove(struct spmi_device *sdev)
 EXPORT_SYMBOL_GPL(spmi_device_remove);
 
 static inline int
-spmi_cmd(struct spmi_controller *ctrl, u8 opcode, u8 sid)
+spmi_cmd(struct spmi_controller *ctrl, u8 opcode, u8 mid, u8 sid)
 {
 	int ret;
 
 	if (!ctrl || !ctrl->cmd || ctrl->dev.type != &spmi_ctrl_type)
 		return -EINVAL;
 
-	ret = ctrl->cmd(ctrl, opcode, sid);
+	ret = ctrl->cmd(ctrl, opcode, mid, sid);
 	trace_spmi_cmd(opcode, sid, ret);
 	return ret;
 }
 
-static inline int spmi_read_cmd(struct spmi_controller *ctrl, u8 opcode,
+static inline int spmi_read_cmd(struct spmi_controller *ctrl, u8 opcode, u8 mid,
 				u8 sid, u16 addr, u8 *buf, size_t len)
 {
 	int ret;
@@ -112,12 +112,12 @@ static inline int spmi_read_cmd(struct spmi_controller *ctrl, u8 opcode,
 		return -EINVAL;
 
 	trace_spmi_read_begin(opcode, sid, addr);
-	ret = ctrl->read_cmd(ctrl, opcode, sid, addr, buf, len);
+	ret = ctrl->read_cmd(ctrl, opcode, mid, sid, addr, buf, len);
 	trace_spmi_read_end(opcode, sid, addr, ret, len, buf);
 	return ret;
 }
 
-static inline int spmi_write_cmd(struct spmi_controller *ctrl, u8 opcode,
+static inline int spmi_write_cmd(struct spmi_controller *ctrl, u8 opcode, u8 mid,
 				 u8 sid, u16 addr, const u8 *buf, size_t len)
 {
 	int ret;
@@ -126,7 +126,7 @@ static inline int spmi_write_cmd(struct spmi_controller *ctrl, u8 opcode,
 		return -EINVAL;
 
 	trace_spmi_write_begin(opcode, sid, addr, len, buf);
-	ret = ctrl->write_cmd(ctrl, opcode, sid, addr, buf, len);
+	ret = ctrl->write_cmd(ctrl, opcode, mid, sid, addr, buf, len);
 	trace_spmi_write_end(opcode, sid, addr, ret);
 	return ret;
 }
@@ -145,7 +145,7 @@ int spmi_register_read(struct spmi_device *sdev, u8 addr, u8 *buf)
 	if (addr > 0x1F)
 		return -EINVAL;
 
-	return spmi_read_cmd(sdev->ctrl, SPMI_CMD_READ, sdev->usid, addr,
+	return spmi_read_cmd(sdev->ctrl, SPMI_CMD_READ, sdev->mid, sdev->usid, addr,
 			     buf, 1);
 }
 EXPORT_SYMBOL_GPL(spmi_register_read);
@@ -167,7 +167,7 @@ int spmi_ext_register_read(struct spmi_device *sdev, u8 addr, u8 *buf,
 	if (len == 0 || len > 16)
 		return -EINVAL;
 
-	return spmi_read_cmd(sdev->ctrl, SPMI_CMD_EXT_READ, sdev->usid, addr,
+	return spmi_read_cmd(sdev->ctrl, SPMI_CMD_EXT_READ, sdev->mid, sdev->usid, addr,
 			     buf, len);
 }
 EXPORT_SYMBOL_GPL(spmi_ext_register_read);
@@ -189,7 +189,7 @@ int spmi_ext_register_readl(struct spmi_device *sdev, u16 addr, u8 *buf,
 	if (len == 0 || len > 8)
 		return -EINVAL;
 
-	return spmi_read_cmd(sdev->ctrl, SPMI_CMD_EXT_READL, sdev->usid, addr,
+	return spmi_read_cmd(sdev->ctrl, SPMI_CMD_EXT_READL, sdev->mid, sdev->usid, addr,
 			     buf, len);
 }
 EXPORT_SYMBOL_GPL(spmi_ext_register_readl);
@@ -208,7 +208,7 @@ int spmi_register_write(struct spmi_device *sdev, u8 addr, u8 data)
 	if (addr > 0x1F)
 		return -EINVAL;
 
-	return spmi_write_cmd(sdev->ctrl, SPMI_CMD_WRITE, sdev->usid, addr,
+	return spmi_write_cmd(sdev->ctrl, SPMI_CMD_WRITE, sdev->mid, sdev->usid, addr,
 			      &data, 1);
 }
 EXPORT_SYMBOL_GPL(spmi_register_write);
@@ -222,7 +222,7 @@ EXPORT_SYMBOL_GPL(spmi_register_write);
  */
 int spmi_register_zero_write(struct spmi_device *sdev, u8 data)
 {
-	return spmi_write_cmd(sdev->ctrl, SPMI_CMD_ZERO_WRITE, sdev->usid, 0,
+	return spmi_write_cmd(sdev->ctrl, SPMI_CMD_ZERO_WRITE, sdev->mid, sdev->usid, 0,
 			      &data, 1);
 }
 EXPORT_SYMBOL_GPL(spmi_register_zero_write);
@@ -244,7 +244,7 @@ int spmi_ext_register_write(struct spmi_device *sdev, u8 addr, const u8 *buf,
 	if (len == 0 || len > 16)
 		return -EINVAL;
 
-	return spmi_write_cmd(sdev->ctrl, SPMI_CMD_EXT_WRITE, sdev->usid, addr,
+	return spmi_write_cmd(sdev->ctrl, SPMI_CMD_EXT_WRITE, sdev->mid, sdev->usid, addr,
 			      buf, len);
 }
 EXPORT_SYMBOL_GPL(spmi_ext_register_write);
@@ -266,7 +266,7 @@ int spmi_ext_register_writel(struct spmi_device *sdev, u16 addr, const u8 *buf,
 	if (len == 0 || len > 8)
 		return -EINVAL;
 
-	return spmi_write_cmd(sdev->ctrl, SPMI_CMD_EXT_WRITEL, sdev->usid,
+	return spmi_write_cmd(sdev->ctrl, SPMI_CMD_EXT_WRITEL, sdev->mid, sdev->usid,
 			      addr, buf, len);
 }
 EXPORT_SYMBOL_GPL(spmi_ext_register_writel);
@@ -281,7 +281,7 @@ EXPORT_SYMBOL_GPL(spmi_ext_register_writel);
  */
 int spmi_command_reset(struct spmi_device *sdev)
 {
-	return spmi_cmd(sdev->ctrl, SPMI_CMD_RESET, sdev->usid);
+	return spmi_cmd(sdev->ctrl, SPMI_CMD_RESET, sdev->mid, sdev->usid);
 }
 EXPORT_SYMBOL_GPL(spmi_command_reset);
 
@@ -293,7 +293,7 @@ EXPORT_SYMBOL_GPL(spmi_command_reset);
  */
 int spmi_command_sleep(struct spmi_device *sdev)
 {
-	return spmi_cmd(sdev->ctrl, SPMI_CMD_SLEEP, sdev->usid);
+	return spmi_cmd(sdev->ctrl, SPMI_CMD_SLEEP, sdev->mid, sdev->usid);
 }
 EXPORT_SYMBOL_GPL(spmi_command_sleep);
 
@@ -306,7 +306,7 @@ EXPORT_SYMBOL_GPL(spmi_command_sleep);
  */
 int spmi_command_wakeup(struct spmi_device *sdev)
 {
-	return spmi_cmd(sdev->ctrl, SPMI_CMD_WAKEUP, sdev->usid);
+	return spmi_cmd(sdev->ctrl, SPMI_CMD_WAKEUP, sdev->mid, sdev->usid);
 }
 EXPORT_SYMBOL_GPL(spmi_command_wakeup);
 
@@ -318,7 +318,7 @@ EXPORT_SYMBOL_GPL(spmi_command_wakeup);
  */
 int spmi_command_shutdown(struct spmi_device *sdev)
 {
-	return spmi_cmd(sdev->ctrl, SPMI_CMD_SHUTDOWN, sdev->usid);
+	return spmi_cmd(sdev->ctrl, SPMI_CMD_SHUTDOWN, sdev->mid, sdev->usid);
 }
 EXPORT_SYMBOL_GPL(spmi_command_shutdown);
 
@@ -477,15 +477,16 @@ struct spmi_controller *spmi_controller_alloc(struct device *parent,
 }
 EXPORT_SYMBOL_GPL(spmi_controller_alloc);
 
-static void of_spmi_register_devices(struct spmi_controller *ctrl)
+static void of_spmi_register_devices(struct spmi_controller *ctrl,
+				     struct device_node *parent, u8 mid)
 {
 	struct device_node *node;
 	int err;
 
-	if (!ctrl->dev.of_node)
+	if (!parent)
 		return;
 
-	for_each_available_child_of_node(ctrl->dev.of_node, node) {
+	for_each_available_child_of_node(parent, node) {
 		struct spmi_device *sdev;
 		u32 reg[2];
 
@@ -519,6 +520,7 @@ static void of_spmi_register_devices(struct spmi_controller *ctrl)
 
 		sdev->dev.of_node = node;
 		sdev->usid = (u8)reg[0];
+		sdev->mid = mid;
 
 		err = spmi_device_add(sdev);
 		if (err) {
@@ -529,6 +531,30 @@ static void of_spmi_register_devices(struct spmi_controller *ctrl)
 	}
 }
 
+static int of_spmi_register_bus_masters(struct spmi_controller *ctrl)
+{
+	struct device_node *node = ctrl->dev.of_node, *child;
+	int mid = 0;
+
+	for_each_available_child_of_node(node, child) {
+		if (of_node_name_eq(child, "spmi-bus-master"))
+			of_spmi_register_devices(ctrl, child, mid++);
+	}
+
+	return 0;
+}
+
+static bool of_spmi_has_bus_multi_master(struct spmi_controller *ctrl)
+{
+	struct device_node *node = ctrl->dev.of_node, *child;
+
+	for_each_available_child_of_node(node, child)
+		if (of_node_name_eq(child, "spmi-bus-master"))
+			return true;
+
+	return false;
+}
+
 /**
  * spmi_controller_add() - Add an SPMI controller
  * @ctrl:	controller to be registered.
@@ -548,8 +574,12 @@ int spmi_controller_add(struct spmi_controller *ctrl)
 	if (ret)
 		return ret;
 
-	if (IS_ENABLED(CONFIG_OF))
-		of_spmi_register_devices(ctrl);
+	if (IS_ENABLED(CONFIG_OF)) {
+		if (of_spmi_has_bus_multi_master(ctrl))
+			of_spmi_register_bus_masters(ctrl);
+		else
+			of_spmi_register_devices(ctrl, ctrl->dev.of_node, 0);
+	}
 
 	dev_dbg(&ctrl->dev, "spmi-%d registered: dev:%p\n",
 		ctrl->nr, &ctrl->dev);
diff --git a/include/linux/spmi.h b/include/linux/spmi.h
index 28e8c8bd3944..6e9031df47f0 100644
--- a/include/linux/spmi.h
+++ b/include/linux/spmi.h
@@ -34,12 +34,14 @@
  * struct spmi_device - Basic representation of an SPMI device
  * @dev:	Driver model representation of the device.
  * @ctrl:	SPMI controller managing the bus hosting this device.
- * @usid:	This devices' Unique Slave IDentifier.
+ * @usid:	This device's Unique Slave IDentifier.
+ * @mid:	This device's Bus Master IDentifier.
  */
 struct spmi_device {
 	struct device		dev;
 	struct spmi_controller	*ctrl;
 	u8			usid;
+	u8			mid;
 };
 
 static inline struct spmi_device *to_spmi_device(struct device *d)
@@ -80,10 +82,10 @@ void spmi_device_remove(struct spmi_device *sdev);
 struct spmi_controller {
 	struct device		dev;
 	unsigned int		nr;
-	int	(*cmd)(struct spmi_controller *ctrl, u8 opcode, u8 sid);
-	int	(*read_cmd)(struct spmi_controller *ctrl, u8 opcode,
+	int	(*cmd)(struct spmi_controller *ctrl, u8 opcode, u8 mid, u8 sid);
+	int	(*read_cmd)(struct spmi_controller *ctrl, u8 opcode, u8 mid,
 			    u8 sid, u16 addr, u8 *buf, size_t len);
-	int	(*write_cmd)(struct spmi_controller *ctrl, u8 opcode,
+	int	(*write_cmd)(struct spmi_controller *ctrl, u8 opcode, u8 mid,
 			     u8 sid, u16 addr, const u8 *buf, size_t len);
 };
 

-- 
2.34.1


