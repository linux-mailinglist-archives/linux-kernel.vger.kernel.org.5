Return-Path: <linux-kernel+bounces-55733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C4B84C0F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93AE7287E07
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623B7200A5;
	Tue,  6 Feb 2024 23:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FEUHtfrJ"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9B1CF87
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 23:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707262444; cv=none; b=lg97mlxIA4rvOkBULQBOYkynE7447fG1cr0yzEb02Zl7Eh0XX6ski2BESXwQOMf7yFLzj/5odR+4NYMwVhM8b0RnxWckt/GYa7JJBUex09YjoQkFZQh/uUlmLQAqkBpiK+WWWha/nRo8AIj5G6ZTNNbddIxnBrMsSTBFFdsEg68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707262444; c=relaxed/simple;
	bh=NmuldgNdqpIlMByAEHYiIY61Dibof9Ljm6X8BETrSbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vgv65qHzNECVWMw49hzWwVlUdCts/lc/w6XfqHgYm3yKiZQxxGJwQROcgpd/OV43seTTiv6TumP8PwFpvPp9iSn1W4Gc22M2zSPyC0KNRCcbfQTW6qCUPatNZP9uem57alm+fy/Zlc/8W3eK8AL98xotlgd2mb+HB/RF4VqRCsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FEUHtfrJ; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d0abdde3easo465531fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 15:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707262435; x=1707867235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNvhVcYKnoD4WkHhhgiqqzAkvMSwPovLCbKzfar9yzk=;
        b=FEUHtfrJgksAMv86cjYpPP5CIew+zTeu+xoZMm5CJKz+vgdEA/3/vvrMLhPtCHzpmF
         XJlXe0kEGRRE1Qhv6Vn/jq69f3LmHNZf6deuQYr8+H0bMlxrHQ1I7cVbnw9GHPbJrvMA
         Lv9NQUBS77Z9kb6h2ZP1RsI+tVTKMfW7iQDvNiUcQm2U6fZS6QJAf+oxMVMTogcTELg8
         fuByKqrTCqeoyEU03QB23UXvFh1fEgMVxkmrktocgNwtyBsgCQpri6J+cuGFPmGQpLv9
         An/1zDa8IuS1cNv3RZ36CvSDCiBDxRmHscyWgr+hgLuvgD4X+py0PlQjgrV2JDNl66mB
         NY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707262435; x=1707867235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNvhVcYKnoD4WkHhhgiqqzAkvMSwPovLCbKzfar9yzk=;
        b=TPAIU7L6ec0f+rchMHpsMkKp5qaYDgF3NJ2wVzVUMm8ndgHrYXO1PIVpdZeOhakrDA
         mtRPSbdAO8hqBdxYw+f1ZfrYDXAHazQ39jUxDIMeUc91i+RoakVn5Ae661v7mqf93+2y
         4xmY5xW3Yc1SQCgP6r1c6/sCpOmwOTwVhJVYS57aaVLRfBJdKZq8N+USw0oX3zru64r9
         eCmuuk+Vy59JAvpVSpLR3KPDxwK18Yz7y37wNB0Hpa3usnOnvm/+26G/y4zaa+gt/twD
         8fXrK1iVpFgdrXMEbsXpIlLdvShkS2m++qG90H55RyBL6AR7q+VR9D8b2rqgzvtrgkI4
         exgg==
X-Gm-Message-State: AOJu0Yyl3kyR0iYTj3037EJOUYt4ezq5slxLr0yYuEAOATaLGyEHgtnI
	kF/qSzkAVIPmUe3SyEMo1FqXrd4XRklbrdfdv54DifmKIIcPtbv5d3e4z6wMlvo=
X-Google-Smtp-Source: AGHT+IEcQA9ru/RLAifbapfR8PCk0EOEi7eagfklCFWfAQ876xnwB7jcj233OF/9gYYXXWCbGf9Csg==
X-Received: by 2002:a05:6512:3708:b0:511:5237:a357 with SMTP id z8-20020a056512370800b005115237a357mr2462783lfr.48.1707262434857;
        Tue, 06 Feb 2024 15:33:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXbg5yOjSau89Uv2uCZst+hB0e7MRHDg7xJ6uoTBjq6HR0qhMbRDRak76C0hwSOuuFPWYTQihDIApuD2hIDs3nnrDA/1kwiv8K+MbGbDfzV5xjSGN1s2a3zrZdiBkkxqILsHoMcXo0dKso+E9rxVMnFFapUMsdbzdzPZnkn1pk09ObJDD+11qLA0qptUP6En9g/XcMs+56oyLT73L4LTQkDLEVMKDIBulBfPjKfjUW9cWVDBSoMa11zy2PyZRSoiWvzhODhb3SIOtdg5xyuI9X/O60qRVUDgUu7io0BHRf6AxXuKUx79P4cZp29m+A2DSE5aFre8Y8cmuuFCiJpx85GIkgU51HukRpthTkSyVjaR+QoNc1bUUnpxdYi/AhD
Received: from [127.0.1.1] ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id un9-20020a170907cb8900b00a36ed37683fsm72404ejc.215.2024.02.06.15.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 15:33:54 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Wed, 07 Feb 2024 01:33:43 +0200
Subject: [PATCH RFC 2/2] spmi: pmic-arb: Add support for multi-master
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-spmi-multi-master-support-v1-2-ce57f301c7fd@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=53584; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=NmuldgNdqpIlMByAEHYiIY61Dibof9Ljm6X8BETrSbk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlwsHdPJ97AwmfP339RmkL0jW8xuxxus0MNNyjI
 Xf9oxyutjKJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZcLB3QAKCRAbX0TJAJUV
 VhQaD/904nQZHhBeUsWlnHxy//NIQhIT3u6MUwPFgTX3F3LlmPnhyLIszpk5P6N8tuivCO6vne3
 weQwZ8v3VSd/wvHPvIptm8WdVOPPnTkv8iuJUo2YWTajoONTDWYnI6iFQ9VHxxZoFNqyIXK5lS/
 1GYashUJomqilK6JWVdZaX0CckmnNu7kMw0+hKxdN79zvm/0ifF04usvu5vU0zZW2NVpMHKidVA
 dil7yPBoJF1zO/GdyIlzl0tOJnj3yevgV8WlnxfdiPF0fLdQiUlUUj+6O8I8oseqf/MpVBFdz1f
 eLlQExymf9caChuDLLz0P6aCF+z7otJgAZXkbyp1dJEgSHMCc1xZkZzcpFsCtz4psPAm5C+pErA
 SwvF69/OPOBpPEVeVv32Q66YwpHZplDfpv75q0ad9ArnOavqeM72HAK4qumBBN6gpnQgzZcALGc
 ptod0WN1E7MbpTVyg4ItPhz4oToyItA4PbtVyTEIQzdoGU81LjZcd4H9OkBE2nCA7JNzipWuNl2
 dufOdOSpILOS6cV/f8guMEcAumAF1zo34rY0YWy3dHESbWbmMIojP5SHvxowvBSPVqIgszYJGi5
 foRz9DwD/IBoF60r/VFj0qd+JDhUoTsEHtzD1KrTQgFgJfN4hEUXYL59DAYPA+2/2nFkV26vOlh
 Ry5Z8S27dpd45kA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The v7 HW supports currently 2 masters. So register
each master and adapt all ops to pass on the master id.
Legacy mode is still supported as long as there is no
child node that represents a bus master, but rather all
devicetree child nodes are actual slave decices.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/spmi/spmi-pmic-arb.c | 711 +++++++++++++++++++++++++++----------------
 1 file changed, 444 insertions(+), 267 deletions(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 597207720146..4a281da3310c 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -13,6 +13,8 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/spmi.h>
@@ -125,6 +127,25 @@ struct apid_data {
 	u8		irq_ee;
 };
 
+struct spmi_pmic_arb;
+
+struct spmi_pmic_master {
+	struct spmi_pmic_arb	*pmic_arb;
+	struct irq_domain	*domain;
+	void __iomem		*intr;
+	void __iomem		*cnfg;
+	u32			bus_instance;
+	u16			base_apid;
+	int			apid_count;
+	u16			*ppid_to_apid;
+	u16			last_apid;
+	struct apid_data	*apid_data;
+	u16			min_apid;
+	u16			max_apid;
+	int			irq;
+	u8			id;
+};
+
 /**
  * struct spmi_pmic_arb - SPMI PMIC Arbiter object
  *
@@ -155,34 +176,26 @@ struct apid_data {
 struct spmi_pmic_arb {
 	void __iomem		*rd_base;
 	void __iomem		*wr_base;
-	void __iomem		*intr;
-	void __iomem		*cnfg;
 	void __iomem		*core;
 	resource_size_t		core_size;
 	raw_spinlock_t		lock;
 	u8			channel;
-	int			irq;
 	u8			ee;
 	u32			bus_instance;
-	u16			min_apid;
-	u16			max_apid;
-	u16			base_apid;
-	int			apid_count;
 	u32			*mapping_table;
 	DECLARE_BITMAP(mapping_table_valid, PMIC_ARB_MAX_PERIPHS);
-	struct irq_domain	*domain;
 	struct spmi_controller	*spmic;
 	const struct pmic_arb_ver_ops *ver_ops;
-	u16			*ppid_to_apid;
-	u16			last_apid;
-	struct apid_data	*apid_data;
 	int			max_periphs;
+	struct spmi_pmic_master *masters;
+	int			masters_count;
 };
 
 /**
  * struct pmic_arb_ver_ops - version dependent functionality.
  *
  * @ver_str:		version string.
+ * @init_apid:		finds the apid base and count
  * @ppid_to_apid:	finds the apid for a given ppid.
  * @non_data_cmd:	on v1 issues an spmi non-data command.
  *			on v2 no HW support, returns -EOPNOTSUPP.
@@ -202,20 +215,21 @@ struct spmi_pmic_arb {
  */
 struct pmic_arb_ver_ops {
 	const char *ver_str;
-	int (*ppid_to_apid)(struct spmi_pmic_arb *pmic_arb, u16 ppid);
+	int (*init_apid)(struct spmi_pmic_master *master);
+	int (*ppid_to_apid)(struct spmi_pmic_master *master, u16 ppid);
 	/* spmi commands (read_cmd, write_cmd, cmd) functionality */
-	int (*offset)(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
-			enum pmic_arb_channel ch_type);
+	int (*offset)(struct spmi_pmic_master *master, u8 sid, u16 addr,
+		      enum pmic_arb_channel ch_type);
 	u32 (*fmt_cmd)(u8 opc, u8 sid, u16 addr, u8 bc);
 	int (*non_data_cmd)(struct spmi_controller *ctrl, u8 opc, u8 sid);
 	/* Interrupts controller functionality (offset of PIC registers) */
-	void __iomem *(*owner_acc_status)(struct spmi_pmic_arb *pmic_arb, u8 m,
+	void __iomem *(*owner_acc_status)(struct spmi_pmic_master *master, u8 m,
 					  u16 n);
-	void __iomem *(*acc_enable)(struct spmi_pmic_arb *pmic_arb, u16 n);
-	void __iomem *(*irq_status)(struct spmi_pmic_arb *pmic_arb, u16 n);
-	void __iomem *(*irq_clear)(struct spmi_pmic_arb *pmic_arb, u16 n);
+	void __iomem *(*acc_enable)(struct spmi_pmic_master *master, u16 n);
+	void __iomem *(*irq_status)(struct spmi_pmic_master *master, u16 n);
+	void __iomem *(*irq_clear)(struct spmi_pmic_master *master, u16 n);
 	u32 (*apid_map_offset)(u16 n);
-	void __iomem *(*apid_owner)(struct spmi_pmic_arb *pmic_arb, u16 n);
+	void __iomem *(*apid_owner)(struct spmi_pmic_master *master, u16 n);
 };
 
 static inline void pmic_arb_base_write(struct spmi_pmic_arb *pmic_arb,
@@ -260,16 +274,17 @@ static void pmic_arb_write_data(struct spmi_pmic_arb *pmic_arb, const u8 *buf,
 }
 
 static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
-				  void __iomem *base, u8 sid, u16 addr,
+				  void __iomem *base, u8 mid, u8 sid, u16 addr,
 				  enum pmic_arb_channel ch_type)
 {
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_master *master = &pmic_arb->masters[mid];
 	u32 status = 0;
 	u32 timeout = PMIC_ARB_TIMEOUT_US;
 	u32 offset;
 	int rc;
 
-	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, addr, ch_type);
+	rc = pmic_arb->ver_ops->offset(master, sid, addr, ch_type);
 	if (rc < 0)
 		return rc;
 
@@ -287,8 +302,8 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
 			}
 
 			if (status & PMIC_ARB_STATUS_FAILURE) {
-				dev_err(&ctrl->dev, "%s: %#x %#x: transaction failed (%#x)\n",
-					__func__, sid, addr, status);
+				dev_err(&ctrl->dev, "%s: %#x %#x %#x: transaction failed (%#x) reg: 0x%x\n",
+					__func__, sid, mid, addr, status, offset);
 				WARN_ON(1);
 				return -EIO;
 			}
@@ -313,12 +328,13 @@ static int
 pmic_arb_non_data_cmd_v1(struct spmi_controller *ctrl, u8 opc, u8 sid)
 {
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_master *master = &pmic_arb->masters[0];
 	unsigned long flags;
 	u32 cmd;
 	int rc;
 	u32 offset;
 
-	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, 0, PMIC_ARB_CHANNEL_RW);
+	rc = pmic_arb->ver_ops->offset(master, sid, 0, PMIC_ARB_CHANNEL_RW);
 	if (rc < 0)
 		return rc;
 
@@ -327,7 +343,7 @@ pmic_arb_non_data_cmd_v1(struct spmi_controller *ctrl, u8 opc, u8 sid)
 
 	raw_spin_lock_irqsave(&pmic_arb->lock, flags);
 	pmic_arb_base_write(pmic_arb, offset + PMIC_ARB_CMD, cmd);
-	rc = pmic_arb_wait_for_done(ctrl, pmic_arb->wr_base, sid, 0,
+	rc = pmic_arb_wait_for_done(ctrl, pmic_arb->wr_base, 0, sid, 0,
 				    PMIC_ARB_CHANNEL_RW);
 	raw_spin_unlock_irqrestore(&pmic_arb->lock, flags);
 
@@ -341,7 +357,7 @@ pmic_arb_non_data_cmd_v2(struct spmi_controller *ctrl, u8 opc, u8 sid)
 }
 
 /* Non-data command */
-static int pmic_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 master_id, u8 sid)
+static int pmic_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 mid, u8 sid)
 {
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
 
@@ -354,13 +370,14 @@ static int pmic_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 master_id, u8 s
 	return pmic_arb->ver_ops->non_data_cmd(ctrl, opc, sid);
 }
 
-static int pmic_arb_fmt_read_cmd(struct spmi_pmic_arb *pmic_arb, u8 opc, u8 sid,
+static int pmic_arb_fmt_read_cmd(struct spmi_pmic_arb *pmic_arb, u8 opc, u8 mid, u8 sid,
 				 u16 addr, size_t len, u32 *cmd, u32 *offset)
 {
+	struct spmi_pmic_master *master = &pmic_arb->masters[mid];
 	u8 bc = len - 1;
 	int rc;
 
-	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, addr,
+	rc = pmic_arb->ver_ops->offset(master, sid, addr,
 				       PMIC_ARB_CHANNEL_OBS);
 	if (rc < 0)
 		return rc;
@@ -388,7 +405,7 @@ static int pmic_arb_fmt_read_cmd(struct spmi_pmic_arb *pmic_arb, u8 opc, u8 sid,
 }
 
 static int pmic_arb_read_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
-				      u32 offset, u8 sid, u16 addr, u8 *buf,
+				      u32 offset, u8 mid, u8 sid, u16 addr, u8 *buf,
 				      size_t len)
 {
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
@@ -396,7 +413,7 @@ static int pmic_arb_read_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
 	int rc;
 
 	pmic_arb_set_rd_cmd(pmic_arb, offset + PMIC_ARB_CMD, cmd);
-	rc = pmic_arb_wait_for_done(ctrl, pmic_arb->rd_base, sid, addr,
+	rc = pmic_arb_wait_for_done(ctrl, pmic_arb->rd_base, mid, sid, addr,
 				    PMIC_ARB_CHANNEL_OBS);
 	if (rc)
 		return rc;
@@ -410,7 +427,7 @@ static int pmic_arb_read_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
 	return 0;
 }
 
-static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 master_id, u8 sid,
+static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 mid, u8 sid,
 			     u16 addr, u8 *buf, size_t len)
 {
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
@@ -418,26 +435,27 @@ static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 master_id,
 	u32 cmd, offset;
 	int rc;
 
-	rc = pmic_arb_fmt_read_cmd(pmic_arb, opc, sid, addr, len, &cmd,
+	rc = pmic_arb_fmt_read_cmd(pmic_arb, opc, mid, sid, addr, len, &cmd,
 				   &offset);
 	if (rc)
 		return rc;
 
 	raw_spin_lock_irqsave(&pmic_arb->lock, flags);
-	rc = pmic_arb_read_cmd_unlocked(ctrl, cmd, offset, sid, addr, buf, len);
+	rc = pmic_arb_read_cmd_unlocked(ctrl, cmd, offset, mid, sid, addr, buf, len);
 	raw_spin_unlock_irqrestore(&pmic_arb->lock, flags);
 
 	return rc;
 }
 
-static int pmic_arb_fmt_write_cmd(struct spmi_pmic_arb *pmic_arb, u8 opc,
+static int pmic_arb_fmt_write_cmd(struct spmi_pmic_arb *pmic_arb, u8 opc, u8 mid,
 				  u8 sid, u16 addr, size_t len, u32 *cmd,
 				  u32 *offset)
 {
+	struct spmi_pmic_master *master = &pmic_arb->masters[mid];
 	u8 bc = len - 1;
 	int rc;
 
-	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, addr,
+	rc = pmic_arb->ver_ops->offset(master, sid, addr,
 					PMIC_ARB_CHANNEL_RW);
 	if (rc < 0)
 		return rc;
@@ -467,7 +485,7 @@ static int pmic_arb_fmt_write_cmd(struct spmi_pmic_arb *pmic_arb, u8 opc,
 }
 
 static int pmic_arb_write_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
-				      u32 offset, u8 sid, u16 addr,
+				      u32 offset, u8 mid, u8 sid, u16 addr,
 				      const u8 *buf, size_t len)
 {
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
@@ -482,11 +500,11 @@ static int pmic_arb_write_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
 
 	/* Start the transaction */
 	pmic_arb_base_write(pmic_arb, offset + PMIC_ARB_CMD, cmd);
-	return pmic_arb_wait_for_done(ctrl, pmic_arb->wr_base, sid, addr,
+	return pmic_arb_wait_for_done(ctrl, pmic_arb->wr_base, mid, sid, addr,
 				      PMIC_ARB_CHANNEL_RW);
 }
 
-static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 master_id, u8 sid,
+static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 mid, u8 sid,
 			      u16 addr, const u8 *buf, size_t len)
 {
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
@@ -494,20 +512,20 @@ static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 master_id
 	u32 cmd, offset;
 	int rc;
 
-	rc = pmic_arb_fmt_write_cmd(pmic_arb, opc, sid, addr, len, &cmd,
+	rc = pmic_arb_fmt_write_cmd(pmic_arb, opc, mid, sid, addr, len, &cmd,
 				    &offset);
 	if (rc)
 		return rc;
 
 	raw_spin_lock_irqsave(&pmic_arb->lock, flags);
-	rc = pmic_arb_write_cmd_unlocked(ctrl, cmd, offset, sid, addr, buf,
+	rc = pmic_arb_write_cmd_unlocked(ctrl, cmd, offset, mid, sid, addr, buf,
 					 len);
 	raw_spin_unlock_irqrestore(&pmic_arb->lock, flags);
 
 	return rc;
 }
 
-static int pmic_arb_masked_write(struct spmi_controller *ctrl, u8 sid, u16 addr,
+static int pmic_arb_masked_write(struct spmi_controller *ctrl, u8 mid, u8 sid, u16 addr,
 				 const u8 *buf, const u8 *mask, size_t len)
 {
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
@@ -516,18 +534,18 @@ static int pmic_arb_masked_write(struct spmi_controller *ctrl, u8 sid, u16 addr,
 	unsigned long flags;
 	int rc, i;
 
-	rc = pmic_arb_fmt_read_cmd(pmic_arb, SPMI_CMD_EXT_READL, sid, addr, len,
+	rc = pmic_arb_fmt_read_cmd(pmic_arb, SPMI_CMD_EXT_READL, mid, sid, addr, len,
 				   &read_cmd, &read_offset);
 	if (rc)
 		return rc;
 
-	rc = pmic_arb_fmt_write_cmd(pmic_arb, SPMI_CMD_EXT_WRITEL, sid, addr,
+	rc = pmic_arb_fmt_write_cmd(pmic_arb, SPMI_CMD_EXT_WRITEL, mid, sid, addr,
 				    len, &write_cmd, &write_offset);
 	if (rc)
 		return rc;
 
 	raw_spin_lock_irqsave(&pmic_arb->lock, flags);
-	rc = pmic_arb_read_cmd_unlocked(ctrl, read_cmd, read_offset, sid, addr,
+	rc = pmic_arb_read_cmd_unlocked(ctrl, read_cmd, read_offset, mid, sid, addr,
 					temp, len);
 	if (rc)
 		goto done;
@@ -535,7 +553,7 @@ static int pmic_arb_masked_write(struct spmi_controller *ctrl, u8 sid, u16 addr,
 	for (i = 0; i < len; i++)
 		temp[i] = (temp[i] & ~mask[i]) | (buf[i] & mask[i]);
 
-	rc = pmic_arb_write_cmd_unlocked(ctrl, write_cmd, write_offset, sid,
+	rc = pmic_arb_write_cmd_unlocked(ctrl, write_cmd, write_offset, mid, sid,
 					 addr, temp, len);
 done:
 	raw_spin_unlock_irqrestore(&pmic_arb->lock, flags);
@@ -564,11 +582,12 @@ struct spmi_pmic_arb_qpnpint_type {
 static void qpnpint_spmi_write(struct irq_data *d, u8 reg, void *buf,
 			       size_t len)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_master *master = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	u8 sid = hwirq_to_sid(d->hwirq);
 	u8 per = hwirq_to_per(d->hwirq);
 
-	if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, 0, sid,
+	if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, master->id, sid,
 			       (per << 8) + reg, buf, len))
 		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed irqchip transaction on %x\n",
 				    d->irq);
@@ -576,11 +595,12 @@ static void qpnpint_spmi_write(struct irq_data *d, u8 reg, void *buf,
 
 static void qpnpint_spmi_read(struct irq_data *d, u8 reg, void *buf, size_t len)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_master *master = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	u8 sid = hwirq_to_sid(d->hwirq);
 	u8 per = hwirq_to_per(d->hwirq);
 
-	if (pmic_arb_read_cmd(pmic_arb->spmic, SPMI_CMD_EXT_READL, 0, sid,
+	if (pmic_arb_read_cmd(pmic_arb->spmic, SPMI_CMD_EXT_READL, master->id, sid,
 			      (per << 8) + reg, buf, len))
 		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed irqchip transaction on %x\n",
 				    d->irq);
@@ -590,12 +610,13 @@ static int qpnpint_spmi_masked_write(struct irq_data *d, u8 reg,
 				     const void *buf, const void *mask,
 				     size_t len)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_master *master = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	u8 sid = hwirq_to_sid(d->hwirq);
 	u8 per = hwirq_to_per(d->hwirq);
 	int rc;
 
-	rc = pmic_arb_masked_write(pmic_arb->spmic, sid, (per << 8) + reg, buf,
+	rc = pmic_arb_masked_write(pmic_arb->spmic, master->id, sid, (per << 8) + reg, buf,
 				   mask, len);
 	if (rc)
 		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed irqchip transaction on %x rc=%d\n",
@@ -603,34 +624,36 @@ static int qpnpint_spmi_masked_write(struct irq_data *d, u8 reg,
 	return rc;
 }
 
-static void cleanup_irq(struct spmi_pmic_arb *pmic_arb, u16 apid, int id)
+static void cleanup_irq(struct spmi_pmic_master *master, u16 apid, int id)
 {
-	u16 ppid = pmic_arb->apid_data[apid].ppid;
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
+	u16 ppid = master->apid_data[apid].ppid;
 	u8 sid = ppid >> 8;
 	u8 per = ppid & 0xFF;
 	u8 irq_mask = BIT(id);
 
 	dev_err_ratelimited(&pmic_arb->spmic->dev, "%s apid=%d sid=0x%x per=0x%x irq=%d\n",
 			__func__, apid, sid, per, id);
-	writel_relaxed(irq_mask, pmic_arb->ver_ops->irq_clear(pmic_arb, apid));
+	writel_relaxed(irq_mask, pmic_arb->ver_ops->irq_clear(master, apid));
 }
 
-static int periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
+static int periph_interrupt(struct spmi_pmic_master *master, u16 apid)
 {
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	unsigned int irq;
 	u32 status, id;
 	int handled = 0;
-	u8 sid = (pmic_arb->apid_data[apid].ppid >> 8) & 0xF;
-	u8 per = pmic_arb->apid_data[apid].ppid & 0xFF;
+	u8 sid = (master->apid_data[apid].ppid >> 8) & 0xF;
+	u8 per = master->apid_data[apid].ppid & 0xFF;
 
-	status = readl_relaxed(pmic_arb->ver_ops->irq_status(pmic_arb, apid));
+	status = readl_relaxed(pmic_arb->ver_ops->irq_status(master, apid));
 	while (status) {
 		id = ffs(status) - 1;
 		status &= ~BIT(id);
-		irq = irq_find_mapping(pmic_arb->domain,
-					spec_to_hwirq(sid, per, id, apid));
+		irq = irq_find_mapping(master->domain,
+				       spec_to_hwirq(sid, per, id, apid));
 		if (irq == 0) {
-			cleanup_irq(pmic_arb, apid, id);
+			cleanup_irq(master, apid, id);
 			continue;
 		}
 		generic_handle_irq(irq);
@@ -642,16 +665,17 @@ static int periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
 
 static void pmic_arb_chained_irq(struct irq_desc *desc)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_desc_get_handler_data(desc);
+	struct spmi_pmic_master *master = irq_desc_get_handler_data(desc);
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	const struct pmic_arb_ver_ops *ver_ops = pmic_arb->ver_ops;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	int first = pmic_arb->min_apid;
-	int last = pmic_arb->max_apid;
+	int first = master->min_apid;
+	int last = master->max_apid;
 	/*
 	 * acc_offset will be non-zero for the secondary SPMI bus instance on
 	 * v7 controllers.
 	 */
-	int acc_offset = pmic_arb->base_apid >> 5;
+	int acc_offset = master->base_apid >> 5;
 	u8 ee = pmic_arb->ee;
 	u32 status, enable, handled = 0;
 	int i, id, apid;
@@ -662,7 +686,7 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 	chained_irq_enter(chip, desc);
 
 	for (i = first >> 5; i <= last >> 5; ++i) {
-		status = readl_relaxed(ver_ops->owner_acc_status(pmic_arb, ee, i - acc_offset));
+		status = readl_relaxed(ver_ops->owner_acc_status(master, ee, i - acc_offset));
 		if (status)
 			acc_valid = true;
 
@@ -676,9 +700,9 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 				continue;
 			}
 			enable = readl_relaxed(
-					ver_ops->acc_enable(pmic_arb, apid));
+					ver_ops->acc_enable(master, apid));
 			if (enable & SPMI_PIC_ACC_ENABLE_BIT)
-				if (periph_interrupt(pmic_arb, apid) != 0)
+				if (periph_interrupt(master, apid) != 0)
 					handled++;
 		}
 	}
@@ -687,19 +711,19 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 	if (!acc_valid) {
 		for (i = first; i <= last; i++) {
 			/* skip if APPS is not irq owner */
-			if (pmic_arb->apid_data[i].irq_ee != pmic_arb->ee)
+			if (master->apid_data[i].irq_ee != pmic_arb->ee)
 				continue;
 
 			irq_status = readl_relaxed(
-					     ver_ops->irq_status(pmic_arb, i));
+					     ver_ops->irq_status(master, i));
 			if (irq_status) {
 				enable = readl_relaxed(
-					     ver_ops->acc_enable(pmic_arb, i));
+					     ver_ops->acc_enable(master, i));
 				if (enable & SPMI_PIC_ACC_ENABLE_BIT) {
 					dev_dbg(&pmic_arb->spmic->dev,
 						"Dispatching IRQ for apid=%d status=%x\n",
 						i, irq_status);
-					if (periph_interrupt(pmic_arb, i) != 0)
+					if (periph_interrupt(master, i) != 0)
 						handled++;
 				}
 			}
@@ -714,12 +738,13 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
 
 static void qpnpint_irq_ack(struct irq_data *d)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_master *master = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	u8 irq = hwirq_to_irq(d->hwirq);
 	u16 apid = hwirq_to_apid(d->hwirq);
 	u8 data;
 
-	writel_relaxed(BIT(irq), pmic_arb->ver_ops->irq_clear(pmic_arb, apid));
+	writel_relaxed(BIT(irq), pmic_arb->ver_ops->irq_clear(master, apid));
 
 	data = BIT(irq);
 	qpnpint_spmi_write(d, QPNPINT_REG_LATCHED_CLR, &data, 1);
@@ -735,14 +760,15 @@ static void qpnpint_irq_mask(struct irq_data *d)
 
 static void qpnpint_irq_unmask(struct irq_data *d)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_master *master = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	const struct pmic_arb_ver_ops *ver_ops = pmic_arb->ver_ops;
 	u8 irq = hwirq_to_irq(d->hwirq);
 	u16 apid = hwirq_to_apid(d->hwirq);
 	u8 buf[2];
 
 	writel_relaxed(SPMI_PIC_ACC_ENABLE_BIT,
-			ver_ops->acc_enable(pmic_arb, apid));
+			ver_ops->acc_enable(master, apid));
 
 	qpnpint_spmi_read(d, QPNPINT_REG_EN_SET, &buf[0], 1);
 	if (!(buf[0] & BIT(irq))) {
@@ -799,9 +825,9 @@ static int qpnpint_irq_set_type(struct irq_data *d, unsigned int flow_type)
 
 static int qpnpint_irq_set_wake(struct irq_data *d, unsigned int on)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_master *master = irq_data_get_irq_chip_data(d);
 
-	return irq_set_irq_wake(pmic_arb->irq, on);
+	return irq_set_irq_wake(master->irq, on);
 }
 
 static int qpnpint_get_irqchip_state(struct irq_data *d,
@@ -823,17 +849,18 @@ static int qpnpint_get_irqchip_state(struct irq_data *d,
 static int qpnpint_irq_domain_activate(struct irq_domain *domain,
 				       struct irq_data *d, bool reserve)
 {
-	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_master *master = irq_data_get_irq_chip_data(d);
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	u16 periph = hwirq_to_per(d->hwirq);
 	u16 apid = hwirq_to_apid(d->hwirq);
 	u16 sid = hwirq_to_sid(d->hwirq);
 	u16 irq = hwirq_to_irq(d->hwirq);
 	u8 buf;
 
-	if (pmic_arb->apid_data[apid].irq_ee != pmic_arb->ee) {
+	if (master->apid_data[apid].irq_ee != pmic_arb->ee) {
 		dev_err(&pmic_arb->spmic->dev, "failed to xlate sid = %#x, periph = %#x, irq = %u: ee=%u but owner=%u\n",
 			sid, periph, irq, pmic_arb->ee,
-			pmic_arb->apid_data[apid].irq_ee);
+			master->apid_data[apid].irq_ee);
 		return -ENODEV;
 	}
 
@@ -860,7 +887,8 @@ static int qpnpint_irq_domain_translate(struct irq_domain *d,
 					unsigned long *out_hwirq,
 					unsigned int *out_type)
 {
-	struct spmi_pmic_arb *pmic_arb = d->host_data;
+	struct spmi_pmic_master *master = d->host_data;
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	u32 *intspec = fwspec->param;
 	u16 apid, ppid;
 	int rc;
@@ -876,7 +904,7 @@ static int qpnpint_irq_domain_translate(struct irq_domain *d,
 		return -EINVAL;
 
 	ppid = intspec[0] << 8 | intspec[1];
-	rc = pmic_arb->ver_ops->ppid_to_apid(pmic_arb, ppid);
+	rc = pmic_arb->ver_ops->ppid_to_apid(master, ppid);
 	if (rc < 0) {
 		dev_err(&pmic_arb->spmic->dev, "failed to xlate sid = %#x, periph = %#x, irq = %u rc = %d\n",
 		intspec[0], intspec[1], intspec[2], rc);
@@ -885,10 +913,10 @@ static int qpnpint_irq_domain_translate(struct irq_domain *d,
 
 	apid = rc;
 	/* Keep track of {max,min}_apid for bounding search during interrupt */
-	if (apid > pmic_arb->max_apid)
-		pmic_arb->max_apid = apid;
-	if (apid < pmic_arb->min_apid)
-		pmic_arb->min_apid = apid;
+	if (apid > master->max_apid)
+		master->max_apid = apid;
+	if (apid < master->min_apid)
+		master->min_apid = apid;
 
 	*out_hwirq = spec_to_hwirq(intspec[0], intspec[1], intspec[2], apid);
 	*out_type  = intspec[3] & IRQ_TYPE_SENSE_MASK;
@@ -942,15 +970,33 @@ static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
 	return 0;
 }
 
-static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb *pmic_arb, u16 ppid)
+/*
+ * For non-v5 and non-v7, just set up the max and min apid.
+ */
+static int pmic_arb_init_apid_v1(struct spmi_pmic_master *master)
 {
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
+
+	/*
+	 * Initialize max_apid/min_apid to the opposite bounds, during
+	 * the irq domain translation, we are sure to update these
+	 */
+	master->max_apid = 0;
+	master->min_apid = pmic_arb->max_periphs - 1;
+
+	return 0;
+}
+
+static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_master *master, u16 ppid)
+{
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	u32 *mapping_table = pmic_arb->mapping_table;
 	int index = 0, i;
 	u16 apid_valid;
 	u16 apid;
 	u32 data;
 
-	apid_valid = pmic_arb->ppid_to_apid[ppid];
+	apid_valid = master->ppid_to_apid[ppid];
 	if (apid_valid & PMIC_ARB_APID_VALID) {
 		apid = apid_valid & ~PMIC_ARB_APID_VALID;
 		return apid;
@@ -958,7 +1004,7 @@ static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 
 	for (i = 0; i < SPMI_MAPPING_TABLE_TREE_DEPTH; ++i) {
 		if (!test_and_set_bit(index, pmic_arb->mapping_table_valid))
-			mapping_table[index] = readl_relaxed(pmic_arb->cnfg +
+			mapping_table[index] = readl_relaxed(master->cnfg +
 						SPMI_MAPPING_TABLE_REG(index));
 
 		data = mapping_table[index];
@@ -968,9 +1014,9 @@ static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 				index = SPMI_MAPPING_BIT_IS_1_RESULT(data);
 			} else {
 				apid = SPMI_MAPPING_BIT_IS_1_RESULT(data);
-				pmic_arb->ppid_to_apid[ppid]
+				master->ppid_to_apid[ppid]
 					= apid | PMIC_ARB_APID_VALID;
-				pmic_arb->apid_data[apid].ppid = ppid;
+				master->apid_data[apid].ppid = ppid;
 				return apid;
 			}
 		} else {
@@ -978,9 +1024,9 @@ static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 				index = SPMI_MAPPING_BIT_IS_0_RESULT(data);
 			} else {
 				apid = SPMI_MAPPING_BIT_IS_0_RESULT(data);
-				pmic_arb->ppid_to_apid[ppid]
+				master->ppid_to_apid[ppid]
 					= apid | PMIC_ARB_APID_VALID;
-				pmic_arb->apid_data[apid].ppid = ppid;
+				master->apid_data[apid].ppid = ppid;
 				return apid;
 			}
 		}
@@ -990,24 +1036,26 @@ static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 }
 
 /* v1 offset per ee */
-static int pmic_arb_offset_v1(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
-			enum pmic_arb_channel ch_type)
+static int pmic_arb_offset_v1(struct spmi_pmic_master *master, u8 sid, u16 addr,
+			      enum pmic_arb_channel ch_type)
 {
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	return 0x800 + 0x80 * pmic_arb->channel;
 }
 
-static u16 pmic_arb_find_apid(struct spmi_pmic_arb *pmic_arb, u16 ppid)
+static u16 pmic_arb_find_apid(struct spmi_pmic_master *master, u16 ppid)
 {
-	struct apid_data *apidd = &pmic_arb->apid_data[pmic_arb->last_apid];
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
+	struct apid_data *apidd = &master->apid_data[master->last_apid];
 	u32 regval, offset;
 	u16 id, apid;
 
-	for (apid = pmic_arb->last_apid; ; apid++, apidd++) {
+	for (apid = master->last_apid; ; apid++, apidd++) {
 		offset = pmic_arb->ver_ops->apid_map_offset(apid);
 		if (offset >= pmic_arb->core_size)
 			break;
 
-		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(pmic_arb,
+		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(master,
 								     apid));
 		apidd->irq_ee = SPMI_OWNERSHIP_PERIPH2OWNER(regval);
 		apidd->write_ee = apidd->irq_ee;
@@ -1017,33 +1065,34 @@ static u16 pmic_arb_find_apid(struct spmi_pmic_arb *pmic_arb, u16 ppid)
 			continue;
 
 		id = (regval >> 8) & PMIC_ARB_PPID_MASK;
-		pmic_arb->ppid_to_apid[id] = apid | PMIC_ARB_APID_VALID;
+		master->ppid_to_apid[id] = apid | PMIC_ARB_APID_VALID;
 		apidd->ppid = id;
 		if (id == ppid) {
 			apid |= PMIC_ARB_APID_VALID;
 			break;
 		}
 	}
-	pmic_arb->last_apid = apid & ~PMIC_ARB_APID_VALID;
+	master->last_apid = apid & ~PMIC_ARB_APID_VALID;
 
 	return apid;
 }
 
-static int pmic_arb_ppid_to_apid_v2(struct spmi_pmic_arb *pmic_arb, u16 ppid)
+static int pmic_arb_ppid_to_apid_v2(struct spmi_pmic_master *master, u16 ppid)
 {
 	u16 apid_valid;
 
-	apid_valid = pmic_arb->ppid_to_apid[ppid];
+	apid_valid = master->ppid_to_apid[ppid];
 	if (!(apid_valid & PMIC_ARB_APID_VALID))
-		apid_valid = pmic_arb_find_apid(pmic_arb, ppid);
+		apid_valid = pmic_arb_find_apid(master, ppid);
 	if (!(apid_valid & PMIC_ARB_APID_VALID))
 		return -ENODEV;
 
 	return apid_valid & ~PMIC_ARB_APID_VALID;
 }
 
-static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
+static int pmic_arb_read_apid_map_v5(struct spmi_pmic_master *master)
 {
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	struct apid_data *apidd;
 	struct apid_data *prev_apidd;
 	u16 i, apid, ppid, apid_max;
@@ -1065,9 +1114,9 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
 	 * where N = number of APIDs supported by the primary bus and
 	 *       M = number of APIDs supported by the secondary bus
 	 */
-	apidd = &pmic_arb->apid_data[pmic_arb->base_apid];
-	apid_max = pmic_arb->base_apid + pmic_arb->apid_count;
-	for (i = pmic_arb->base_apid; i < apid_max; i++, apidd++) {
+	apidd = &master->apid_data[master->base_apid];
+	apid_max = master->base_apid + master->apid_count;
+	for (i = master->base_apid; i < apid_max; i++, apidd++) {
 		offset = pmic_arb->ver_ops->apid_map_offset(i);
 		if (offset >= pmic_arb->core_size)
 			break;
@@ -1078,19 +1127,18 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
 		ppid = (regval >> 8) & PMIC_ARB_PPID_MASK;
 		is_irq_ee = PMIC_ARB_CHAN_IS_IRQ_OWNER(regval);
 
-		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(pmic_arb,
-								     i));
+		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(master, i));
 		apidd->write_ee = SPMI_OWNERSHIP_PERIPH2OWNER(regval);
 
 		apidd->irq_ee = is_irq_ee ? apidd->write_ee : INVALID_EE;
 
-		valid = pmic_arb->ppid_to_apid[ppid] & PMIC_ARB_APID_VALID;
-		apid = pmic_arb->ppid_to_apid[ppid] & ~PMIC_ARB_APID_VALID;
-		prev_apidd = &pmic_arb->apid_data[apid];
+		valid = master->ppid_to_apid[ppid] & PMIC_ARB_APID_VALID;
+		apid = master->ppid_to_apid[ppid] & ~PMIC_ARB_APID_VALID;
+		prev_apidd = &master->apid_data[apid];
 
 		if (!valid || apidd->write_ee == pmic_arb->ee) {
 			/* First PPID mapping or one for this EE */
-			pmic_arb->ppid_to_apid[ppid] = i | PMIC_ARB_APID_VALID;
+			master->ppid_to_apid[ppid] = i | PMIC_ARB_APID_VALID;
 		} else if (valid && is_irq_ee &&
 			   prev_apidd->write_ee == pmic_arb->ee) {
 			/*
@@ -1101,16 +1149,16 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
 		}
 
 		apidd->ppid = ppid;
-		pmic_arb->last_apid = i;
+		master->last_apid = i;
 	}
 
 	/* Dump the mapping table for debug purposes. */
 	dev_dbg(&pmic_arb->spmic->dev, "PPID APID Write-EE IRQ-EE\n");
 	for (ppid = 0; ppid < PMIC_ARB_MAX_PPID; ppid++) {
-		apid = pmic_arb->ppid_to_apid[ppid];
+		apid = master->ppid_to_apid[ppid];
 		if (apid & PMIC_ARB_APID_VALID) {
 			apid &= ~PMIC_ARB_APID_VALID;
-			apidd = &pmic_arb->apid_data[apid];
+			apidd = &master->apid_data[apid];
 			dev_dbg(&pmic_arb->spmic->dev, "%#03X %3u %2u %2u\n",
 			      ppid, apid, apidd->write_ee, apidd->irq_ee);
 		}
@@ -1119,24 +1167,25 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
 	return 0;
 }
 
-static int pmic_arb_ppid_to_apid_v5(struct spmi_pmic_arb *pmic_arb, u16 ppid)
+static int pmic_arb_ppid_to_apid_v5(struct spmi_pmic_master *master, u16 ppid)
 {
-	if (!(pmic_arb->ppid_to_apid[ppid] & PMIC_ARB_APID_VALID))
+	if (!(master->ppid_to_apid[ppid] & PMIC_ARB_APID_VALID))
 		return -ENODEV;
 
-	return pmic_arb->ppid_to_apid[ppid] & ~PMIC_ARB_APID_VALID;
+	return master->ppid_to_apid[ppid] & ~PMIC_ARB_APID_VALID;
 }
 
 /* v2 offset per ppid and per ee */
-static int pmic_arb_offset_v2(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
-			   enum pmic_arb_channel ch_type)
+static int pmic_arb_offset_v2(struct spmi_pmic_master *master, u8 sid, u16 addr,
+			      enum pmic_arb_channel ch_type)
 {
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	u16 apid;
 	u16 ppid;
 	int rc;
 
 	ppid = sid << 8 | ((addr >> 8) & 0xFF);
-	rc = pmic_arb_ppid_to_apid_v2(pmic_arb, ppid);
+	rc = pmic_arb_ppid_to_apid_v2(master, ppid);
 	if (rc < 0)
 		return rc;
 
@@ -1144,19 +1193,58 @@ static int pmic_arb_offset_v2(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
 	return 0x1000 * pmic_arb->ee + 0x8000 * apid;
 }
 
+/*
+ * v5 only supports one master. Compute apid accordingly.
+ */
+static int pmic_arb_init_apid_v5(struct spmi_pmic_master *master)
+{
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
+	int ret;
+
+	if (master->id != 0) {
+		dev_err(&pmic_arb->spmic->dev, "Unsupported masters count %d detected\n",
+			master->id);
+		return -EINVAL;
+	}
+
+	master->base_apid = 0;
+	master->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
+					   PMIC_ARB_FEATURES_PERIPH_MASK;
+
+	if (master->base_apid + master->apid_count > pmic_arb->max_periphs) {
+		dev_err(&pmic_arb->spmic->dev, "Unsupported APID count %d detected\n",
+			master->base_apid + master->apid_count);
+		return -EINVAL;
+	}
+
+	ret = pmic_arb_init_apid_v1(master);
+	if (ret)
+		return ret;
+
+	ret = pmic_arb_read_apid_map_v5(master);
+	if (ret) {
+		dev_err(&pmic_arb->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * v5 offset per ee and per apid for observer channels and per apid for
  * read/write channels.
  */
-static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
-			   enum pmic_arb_channel ch_type)
+static int pmic_arb_offset_v5(struct spmi_pmic_master *master, u8 sid, u16 addr,
+			      enum pmic_arb_channel ch_type)
 {
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	u16 apid;
 	int rc;
 	u32 offset = 0;
 	u16 ppid = (sid << 8) | (addr >> 8);
 
-	rc = pmic_arb_ppid_to_apid_v5(pmic_arb, ppid);
+	rc = pmic_arb_ppid_to_apid_v5(master, ppid);
 	if (rc < 0)
 		return rc;
 
@@ -1166,7 +1254,7 @@ static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
 		offset = 0x10000 * pmic_arb->ee + 0x80 * apid;
 		break;
 	case PMIC_ARB_CHANNEL_RW:
-		if (pmic_arb->apid_data[apid].write_ee != pmic_arb->ee) {
+		if (master->apid_data[apid].write_ee != pmic_arb->ee) {
 			dev_err(&pmic_arb->spmic->dev, "disallowed SPMI write to sid=%u, addr=0x%04X\n",
 				sid, addr);
 			return -EPERM;
@@ -1178,19 +1266,64 @@ static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
 	return offset;
 }
 
+/*
+ * Only v7 supports 2 bus masters. Each master will get a different apid count,
+ * read from different registers.
+ */
+static int pmic_arb_init_apid_v7(struct spmi_pmic_master *master)
+{
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
+	int ret;
+
+	if (master->id == 0) {
+		master->base_apid = 0;
+		master->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
+						   PMIC_ARB_FEATURES_PERIPH_MASK;
+	} else if (master->id == 1) {
+		master->base_apid = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
+						  PMIC_ARB_FEATURES_PERIPH_MASK;
+		master->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES1) &
+						   PMIC_ARB_FEATURES_PERIPH_MASK;
+	} else {
+		dev_err(&pmic_arb->spmic->dev, "Unsupported masters count %d detected\n",
+			master->id);
+		return -EINVAL;
+	}
+
+	if (master->base_apid + master->apid_count > pmic_arb->max_periphs) {
+		dev_err(&pmic_arb->spmic->dev, "Unsupported APID count %d detected\n",
+			master->base_apid + master->apid_count);
+		return -EINVAL;
+	}
+
+	ret = pmic_arb_init_apid_v1(master);
+	if (ret)
+		return ret;
+
+	ret = pmic_arb_read_apid_map_v5(master);
+	if (ret) {
+		dev_err(&pmic_arb->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 /*
  * v7 offset per ee and per apid for observer channels and per apid for
  * read/write channels.
  */
-static int pmic_arb_offset_v7(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
-			   enum pmic_arb_channel ch_type)
+static int pmic_arb_offset_v7(struct spmi_pmic_master *master, u8 sid, u16 addr,
+			      enum pmic_arb_channel ch_type)
 {
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	u16 apid;
 	int rc;
 	u32 offset = 0;
 	u16 ppid = (sid << 8) | (addr >> 8);
 
-	rc = pmic_arb->ver_ops->ppid_to_apid(pmic_arb, ppid);
+	rc = pmic_arb->ver_ops->ppid_to_apid(master, ppid);
 	if (rc < 0)
 		return rc;
 
@@ -1200,7 +1333,7 @@ static int pmic_arb_offset_v7(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
 		offset = 0x8000 * pmic_arb->ee + 0x20 * apid;
 		break;
 	case PMIC_ARB_CHANNEL_RW:
-		if (pmic_arb->apid_data[apid].write_ee != pmic_arb->ee) {
+		if (master->apid_data[apid].write_ee != pmic_arb->ee) {
 			dev_err(&pmic_arb->spmic->dev, "disallowed SPMI write to sid=%u, addr=0x%04X\n",
 				sid, addr);
 			return -EPERM;
@@ -1223,104 +1356,110 @@ static u32 pmic_arb_fmt_cmd_v2(u8 opc, u8 sid, u16 addr, u8 bc)
 }
 
 static void __iomem *
-pmic_arb_owner_acc_status_v1(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
+pmic_arb_owner_acc_status_v1(struct spmi_pmic_master *master, u8 m, u16 n)
 {
-	return pmic_arb->intr + 0x20 * m + 0x4 * n;
+	return master->intr + 0x20 * m + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_owner_acc_status_v2(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
+pmic_arb_owner_acc_status_v2(struct spmi_pmic_master *master, u8 m, u16 n)
 {
-	return pmic_arb->intr + 0x100000 + 0x1000 * m + 0x4 * n;
+	return master->intr + 0x100000 + 0x1000 * m + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_owner_acc_status_v3(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
+pmic_arb_owner_acc_status_v3(struct spmi_pmic_master *master, u8 m, u16 n)
 {
-	return pmic_arb->intr + 0x200000 + 0x1000 * m + 0x4 * n;
+	return master->intr + 0x200000 + 0x1000 * m + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_owner_acc_status_v5(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
+pmic_arb_owner_acc_status_v5(struct spmi_pmic_master *master, u8 m, u16 n)
 {
-	return pmic_arb->intr + 0x10000 * m + 0x4 * n;
+	return master->intr + 0x10000 * m + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_owner_acc_status_v7(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
+pmic_arb_owner_acc_status_v7(struct spmi_pmic_master *master, u8 m, u16 n)
 {
-	return pmic_arb->intr + 0x1000 * m + 0x4 * n;
+	return master->intr + 0x1000 * m + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_acc_enable_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_acc_enable_v1(struct spmi_pmic_master *master, u16 n)
 {
-	return pmic_arb->intr + 0x200 + 0x4 * n;
+	return master->intr + 0x200 + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_acc_enable_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_acc_enable_v2(struct spmi_pmic_master *master, u16 n)
 {
-	return pmic_arb->intr + 0x1000 * n;
+	return master->intr + 0x1000 * n;
 }
 
 static void __iomem *
-pmic_arb_acc_enable_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_acc_enable_v5(struct spmi_pmic_master *master, u16 n)
 {
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	return pmic_arb->wr_base + 0x100 + 0x10000 * n;
 }
 
 static void __iomem *
-pmic_arb_acc_enable_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_acc_enable_v7(struct spmi_pmic_master *master, u16 n)
 {
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	return pmic_arb->wr_base + 0x100 + 0x1000 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_status_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_status_v1(struct spmi_pmic_master *master, u16 n)
 {
-	return pmic_arb->intr + 0x600 + 0x4 * n;
+	return master->intr + 0x600 + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_status_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_status_v2(struct spmi_pmic_master *master, u16 n)
 {
-	return pmic_arb->intr + 0x4 + 0x1000 * n;
+	return master->intr + 0x4 + 0x1000 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_status_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_status_v5(struct spmi_pmic_master *master, u16 n)
 {
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	return pmic_arb->wr_base + 0x104 + 0x10000 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_status_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_status_v7(struct spmi_pmic_master *master, u16 n)
 {
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	return pmic_arb->wr_base + 0x104 + 0x1000 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_clear_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_clear_v1(struct spmi_pmic_master *master, u16 n)
 {
-	return pmic_arb->intr + 0xA00 + 0x4 * n;
+	return master->intr + 0xA00 + 0x4 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_clear_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_clear_v2(struct spmi_pmic_master *master, u16 n)
 {
-	return pmic_arb->intr + 0x8 + 0x1000 * n;
+	return master->intr + 0x8 + 0x1000 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_clear_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_clear_v5(struct spmi_pmic_master *master, u16 n)
 {
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	return pmic_arb->wr_base + 0x108 + 0x10000 * n;
 }
 
 static void __iomem *
-pmic_arb_irq_clear_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_irq_clear_v7(struct spmi_pmic_master *master, u16 n)
 {
+	struct spmi_pmic_arb *pmic_arb = master->pmic_arb;
 	return pmic_arb->wr_base + 0x108 + 0x1000 * n;
 }
 
@@ -1340,9 +1479,9 @@ static u32 pmic_arb_apid_map_offset_v7(u16 n)
 }
 
 static void __iomem *
-pmic_arb_apid_owner_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_apid_owner_v2(struct spmi_pmic_master *master, u16 n)
 {
-	return pmic_arb->cnfg + 0x700 + 0x4 * n;
+	return master->cnfg + 0x700 + 0x4 * n;
 }
 
 /*
@@ -1351,13 +1490,14 @@ pmic_arb_apid_owner_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
  * 0.
  */
 static void __iomem *
-pmic_arb_apid_owner_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
+pmic_arb_apid_owner_v7(struct spmi_pmic_master *master, u16 n)
 {
-	return pmic_arb->cnfg + 0x4 * (n - pmic_arb->base_apid);
+	return  master->cnfg + 0x4 * (n - master->base_apid);
 }
 
 static const struct pmic_arb_ver_ops pmic_arb_v1 = {
 	.ver_str		= "v1",
+	.init_apid		= pmic_arb_init_apid_v1,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v1,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v1,
 	.offset			= pmic_arb_offset_v1,
@@ -1372,6 +1512,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v1 = {
 
 static const struct pmic_arb_ver_ops pmic_arb_v2 = {
 	.ver_str		= "v2",
+	.init_apid		= pmic_arb_init_apid_v1,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v2,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
 	.offset			= pmic_arb_offset_v2,
@@ -1386,6 +1527,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v2 = {
 
 static const struct pmic_arb_ver_ops pmic_arb_v3 = {
 	.ver_str		= "v3",
+	.init_apid		= pmic_arb_init_apid_v1,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v2,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
 	.offset			= pmic_arb_offset_v2,
@@ -1400,6 +1542,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v3 = {
 
 static const struct pmic_arb_ver_ops pmic_arb_v5 = {
 	.ver_str		= "v5",
+	.init_apid		= pmic_arb_init_apid_v5,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v5,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
 	.offset			= pmic_arb_offset_v5,
@@ -1414,6 +1557,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v5 = {
 
 static const struct pmic_arb_ver_ops pmic_arb_v7 = {
 	.ver_str		= "v7",
+	.init_apid		= pmic_arb_init_apid_v7,
 	.ppid_to_apid		= pmic_arb_ppid_to_apid_v5,
 	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
 	.offset			= pmic_arb_offset_v7,
@@ -1433,6 +1577,128 @@ static const struct irq_domain_ops pmic_arb_irq_domain_ops = {
 	.translate = qpnpint_irq_domain_translate,
 };
 
+static int spmi_pmic_master_init(struct platform_device *pdev,
+				 struct device_node *node,
+				 struct spmi_pmic_arb *pmic_arb, u8 id)
+{
+	struct spmi_pmic_master *master = &pmic_arb->masters[id];
+	struct device *dev = &pdev->dev;
+	void __iomem *intr;
+	void __iomem *cnfg;
+	int bus_instance = id;
+	int index, ret;
+	u32 irq;
+
+	master->ppid_to_apid = devm_kcalloc(dev, PMIC_ARB_MAX_PPID,
+					    sizeof(*master->ppid_to_apid),
+					    GFP_KERNEL);
+	if (!master->ppid_to_apid)
+		return -ENOMEM;
+
+	master->apid_data = devm_kcalloc(dev, pmic_arb->max_periphs,
+					 sizeof(*master->apid_data),
+					 GFP_KERNEL);
+	if (!master->apid_data)
+		return -ENOMEM;
+
+	/* Optional property for v7: */
+	of_property_read_u32(node, "qcom,bus-id", &bus_instance);
+	if (bus_instance != id) {
+		dev_err(dev, "wrong bus-id value");
+		return -EINVAL;
+	}
+
+	index = of_property_match_string(node, "reg-names", "cnfg");
+	if (index < 0) {
+		dev_err(dev, "cnfg reg region missing");
+		return -EINVAL;
+	}
+
+	cnfg = devm_of_iomap(dev, node, index, NULL);
+	if (IS_ERR(cnfg))
+		return PTR_ERR(cnfg);
+
+	index = of_property_match_string(node, "reg-names", "intr");
+	if (index < 0) {
+		dev_err(dev, "intr reg region missing");
+		return -EINVAL;
+	}
+
+	intr = devm_of_iomap(dev, node, index, NULL);
+	if (IS_ERR(intr))
+		return PTR_ERR(intr);
+
+	irq = of_irq_get_byname(node, "periph_irq");
+	if (irq < 0)
+		return irq;
+
+	master->pmic_arb = pmic_arb;
+	master->intr = intr;
+	master->cnfg = cnfg;
+	master->irq = irq;
+	master->id = id;
+
+	ret = pmic_arb->ver_ops->init_apid(master);
+	if (ret)
+		return ret;
+
+	dev_dbg(&pdev->dev, "adding irq domain for master %d\n", id);
+
+	master->domain = irq_domain_add_tree(pdev->dev.of_node,
+					     &pmic_arb_irq_domain_ops, master);
+	if (!master->domain) {
+		dev_err(&pdev->dev, "unable to create irq_domain\n");
+		return -ENOMEM;
+	}
+
+	irq_set_chained_handler_and_data(master->irq,
+					 pmic_arb_chained_irq, master);
+
+	return 0;
+}
+
+static int spmi_pmic_arb_register_masters(struct spmi_pmic_arb *pmic_arb,
+					  struct platform_device *pdev)
+{
+	struct spmi_controller *ctrl = pmic_arb->spmic;
+	struct device_node *node = pdev->dev.of_node;
+	struct device_node *child;
+	int child_count = of_get_available_child_count(node);
+	int ret, i = 0;
+
+	/* Even without child nodes, there is at least one master */
+	pmic_arb->masters_count = child_count ? child_count : 1;
+
+	pmic_arb->masters = devm_kcalloc(&ctrl->dev, pmic_arb->masters_count,
+					 sizeof(*pmic_arb->masters),
+					 GFP_KERNEL);
+	if (!pmic_arb->masters)
+		return -ENOMEM;
+
+	if (child_count) {
+		for_each_available_child_of_node(node, child) {
+			ret = spmi_pmic_master_init(pdev, child, pmic_arb, i++);
+			if (ret)
+				return ret;
+		}
+	} else {
+		ret = spmi_pmic_master_init(pdev, node, pmic_arb, 0);
+	}
+
+	return ret;
+}
+
+static void spmi_pmic_arb_deregister_masters(struct spmi_pmic_arb *pmic_arb)
+{
+	int i;
+
+	for (i = 0; i < pmic_arb->masters_count; i++) {
+		irq_set_chained_handler_and_data(pmic_arb->masters[i].irq,
+						 NULL, NULL);
+		irq_domain_remove(pmic_arb->masters[i].domain);
+	}
+}
+
 static int spmi_pmic_arb_probe(struct platform_device *pdev)
 {
 	struct spmi_pmic_arb *pmic_arb;
@@ -1461,18 +1727,12 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	 * which does not result in a devm_request_mem_region() call.
 	 */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
-	core = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
+	core = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (IS_ERR(core))
 		return PTR_ERR(core);
 
 	pmic_arb->core_size = resource_size(res);
 
-	pmic_arb->ppid_to_apid = devm_kcalloc(&ctrl->dev, PMIC_ARB_MAX_PPID,
-					      sizeof(*pmic_arb->ppid_to_apid),
-					      GFP_KERNEL);
-	if (!pmic_arb->ppid_to_apid)
-		return -ENOMEM;
-
 	hw_ver = readl_relaxed(core + PMIC_ARB_VERSION);
 
 	if (hw_ver < PMIC_ARB_VERSION_V2_MIN) {
@@ -1493,86 +1753,27 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						   "obsrvr");
-		pmic_arb->rd_base = devm_ioremap(&ctrl->dev, res->start,
+		pmic_arb->rd_base = devm_ioremap(&pdev->dev, res->start,
 						 resource_size(res));
 		if (IS_ERR(pmic_arb->rd_base))
 			return PTR_ERR(pmic_arb->rd_base);
 
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						   "chnls");
-		pmic_arb->wr_base = devm_ioremap(&ctrl->dev, res->start,
+		pmic_arb->wr_base = devm_ioremap(&pdev->dev, res->start,
 						 resource_size(res));
 		if (IS_ERR(pmic_arb->wr_base))
 			return PTR_ERR(pmic_arb->wr_base);
 	}
 
-	pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
-
-	if (hw_ver >= PMIC_ARB_VERSION_V7_MIN) {
+	if (hw_ver == PMIC_ARB_VERSION_V7_MIN)
 		pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS_V7;
-		/* Optional property for v7: */
-		of_property_read_u32(pdev->dev.of_node, "qcom,bus-id",
-					&pmic_arb->bus_instance);
-		if (pmic_arb->bus_instance > 1) {
-			dev_err(&pdev->dev, "invalid bus instance (%u) specified\n",
-				pmic_arb->bus_instance);
-			return -EINVAL;
-		}
-
-		if (pmic_arb->bus_instance == 0) {
-			pmic_arb->base_apid = 0;
-			pmic_arb->apid_count =
-				readl_relaxed(core + PMIC_ARB_FEATURES) &
-				PMIC_ARB_FEATURES_PERIPH_MASK;
-		} else {
-			pmic_arb->base_apid =
-				readl_relaxed(core + PMIC_ARB_FEATURES) &
-				PMIC_ARB_FEATURES_PERIPH_MASK;
-			pmic_arb->apid_count =
-				readl_relaxed(core + PMIC_ARB_FEATURES1) &
-				PMIC_ARB_FEATURES_PERIPH_MASK;
-		}
-
-		if (pmic_arb->base_apid + pmic_arb->apid_count > pmic_arb->max_periphs) {
-			dev_err(&pdev->dev, "Unsupported APID count %d detected\n",
-				pmic_arb->base_apid + pmic_arb->apid_count);
-			return -EINVAL;
-		}
-	} else if (hw_ver >= PMIC_ARB_VERSION_V5_MIN) {
-		pmic_arb->base_apid = 0;
-		pmic_arb->apid_count = readl_relaxed(core + PMIC_ARB_FEATURES) &
-					PMIC_ARB_FEATURES_PERIPH_MASK;
-
-		if (pmic_arb->apid_count > pmic_arb->max_periphs) {
-			dev_err(&pdev->dev, "Unsupported APID count %d detected\n",
-				pmic_arb->apid_count);
-			return -EINVAL;
-		}
-	}
-
-	pmic_arb->apid_data = devm_kcalloc(&ctrl->dev, pmic_arb->max_periphs,
-					   sizeof(*pmic_arb->apid_data),
-					   GFP_KERNEL);
-	if (!pmic_arb->apid_data)
-		return -ENOMEM;
+	else
+		pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
 
-	dev_info(&ctrl->dev, "PMIC arbiter version %s (0x%x)\n",
+	dev_info(&pdev->dev, "PMIC arbiter version %s (0x%x)\n",
 		 pmic_arb->ver_ops->ver_str, hw_ver);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "intr");
-	pmic_arb->intr = devm_ioremap_resource(&ctrl->dev, res);
-	if (IS_ERR(pmic_arb->intr))
-		return PTR_ERR(pmic_arb->intr);
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cnfg");
-	pmic_arb->cnfg = devm_ioremap_resource(&ctrl->dev, res);
-	if (IS_ERR(pmic_arb->cnfg))
-		return PTR_ERR(pmic_arb->cnfg);
-
-	pmic_arb->irq = platform_get_irq_byname(pdev, "periph_irq");
-	if (pmic_arb->irq < 0)
-		return pmic_arb->irq;
-
 	err = of_property_read_u32(pdev->dev.of_node, "qcom,channel", &channel);
 	if (err) {
 		dev_err(&pdev->dev, "channel unspecified.\n");
@@ -1599,16 +1800,12 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	}
 
 	pmic_arb->ee = ee;
-	mapping_table = devm_kcalloc(&ctrl->dev, pmic_arb->max_periphs,
-					sizeof(*mapping_table), GFP_KERNEL);
+	mapping_table = devm_kcalloc(&pdev->dev, pmic_arb->max_periphs,
+				     sizeof(*mapping_table), GFP_KERNEL);
 	if (!mapping_table)
 		return -ENOMEM;
 
 	pmic_arb->mapping_table = mapping_table;
-	/* Initialize max_apid/min_apid to the opposite bounds, during
-	 * the irq domain translation, we are sure to update these */
-	pmic_arb->max_apid = 0;
-	pmic_arb->min_apid = pmic_arb->max_periphs - 1;
 
 	platform_set_drvdata(pdev, ctrl);
 	raw_spin_lock_init(&pmic_arb->lock);
@@ -1617,34 +1814,14 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	ctrl->read_cmd = pmic_arb_read_cmd;
 	ctrl->write_cmd = pmic_arb_write_cmd;
 
-	if (hw_ver >= PMIC_ARB_VERSION_V5_MIN) {
-		err = pmic_arb_read_apid_map_v5(pmic_arb);
-		if (err) {
-			dev_err(&pdev->dev, "could not read APID->PPID mapping table, rc= %d\n",
-				err);
-			return err;
-		}
-	}
-
-	dev_dbg(&pdev->dev, "adding irq domain\n");
-	pmic_arb->domain = irq_domain_add_tree(pdev->dev.of_node,
-					 &pmic_arb_irq_domain_ops, pmic_arb);
-	if (!pmic_arb->domain) {
-		dev_err(&pdev->dev, "unable to create irq_domain\n");
+	err = spmi_pmic_arb_register_masters(pmic_arb, pdev);
+	if (err)
 		return -ENOMEM;
-	}
 
-	irq_set_chained_handler_and_data(pmic_arb->irq, pmic_arb_chained_irq,
-					pmic_arb);
 	err = spmi_controller_add(ctrl);
 	if (err)
-		goto err_domain_remove;
-
-	return 0;
+		spmi_pmic_arb_deregister_masters(pmic_arb);
 
-err_domain_remove:
-	irq_set_chained_handler_and_data(pmic_arb->irq, NULL, NULL);
-	irq_domain_remove(pmic_arb->domain);
 	return err;
 }
 
@@ -1652,9 +1829,9 @@ static void spmi_pmic_arb_remove(struct platform_device *pdev)
 {
 	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
 	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+
 	spmi_controller_remove(ctrl);
-	irq_set_chained_handler_and_data(pmic_arb->irq, NULL, NULL);
-	irq_domain_remove(pmic_arb->domain);
+	spmi_pmic_arb_deregister_masters(pmic_arb);
 }
 
 static const struct of_device_id spmi_pmic_arb_match_table[] = {

-- 
2.34.1


