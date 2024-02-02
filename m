Return-Path: <linux-kernel+bounces-49720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E284846E82
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55DA6297290
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A1B13EFF7;
	Fri,  2 Feb 2024 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YZtNtzIh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FB113E20C;
	Fri,  2 Feb 2024 10:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871569; cv=none; b=uHD/p4RIVzTXjnBHfXxGwVhOrVUASJp0gfG6X87ZSOG+KeP7yt+/5LH/Y3WmnPMWEyPVa0cGPTBpvLypnwVd71TJ+/gnRs53EXGX7Ng7kjGXNRcobJuphr0zlQtDCTCXiVGkzt6kdTZPOxUiZLCesPpY6rJV3LgJFxaaXx0mnUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871569; c=relaxed/simple;
	bh=m1EFA5P8J0/nD2ngsANe5WNr+7ap5mfLVoefoWB8IuU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZoGFU9UgDG21eSGV6h/EPoGa0UEK5DzePVKhI/QSco6chtIov5Z3b9CKG8hcXHJpsreFObfHCxX3X+aRDzi699C7pPGvRvJ/UGwALfSIf11LrOx5a+ts2dzEcU3ctw4YLOPUguPblYOE2jLOEgvClGOlJtoM0GcPZaLuCWL09kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YZtNtzIh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4122QPr0010784;
	Fri, 2 Feb 2024 10:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=tpn2xMnaCKeuqASQPH9BaQOkPasxMEb5EX6qzIgVA2k=; b=YZ
	tNtzIhanVWa0JteiV/uXsf69Nz16uXKcz/7Xwf7OBcxLgI5i4PpcvURvYRqfFM0V
	YgpiNUypbPjgpHVqZN+iwy7tw3wU5J9Iopw8kNyf5IZQT3gSo7kzADsnzHXGBh2W
	+L3mbVNEfoUFK9XASk7o2d8xUIL/qpO4YlOdCwMwzQpoUIm39nKVx2O6pOmm6TDC
	FlpWJ9q4elLsn3+CDr3vjUZWFoxpi1j0AZWHJ37bKZCtuBOCqOjvTgAUaH3PgF0U
	h6xGIKh5cUiQq7vxBWXVOvD69hujluh5mqU10IYOqjK6vOousoA6qIr1B7hSrTMy
	u1FEadnPxos+LDSUafBA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu1s5s4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 10:59:23 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412AxMBc014804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 10:59:22 GMT
Received: from aiquny2-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 2 Feb 2024 02:59:16 -0800
From: Maria Yu <quic_aiquny@quicinc.com>
To: <andersson@kernel.org>, <linus.walleij@linaro.org>
CC: Maria Yu <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v4] pinctrl: Add lock to ensure the state atomization
Date: Fri, 2 Feb 2024 18:58:54 +0800
Message-ID: <20240202105854.26446-1-quic_aiquny@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0VlqJell03VnIUfPNApaLhsbfJNOI6Z2
X-Proofpoint-ORIG-GUID: 0VlqJell03VnIUfPNApaLhsbfJNOI6Z2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_05,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=995 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020079

Currently pinctrl_select_state is an export symbol and don't have
effective re-entrance protect design. During async probing of devices
it's possible to end up in pinctrl_select_state() from multiple
contexts simultaneously, so make it thread safe.
More over, when the real racy happened, the system frequently have
printk message like:
  "not freeing pin xx (xxx) as part of deactivating group xxx - it is
already used for some other setting".
Finally the system crashed after the flood log.
Add per pinctrl lock to ensure the old state and new state transition
atomization.
Also move dev error print message outside the region with interrupts
disabled.
Use scoped guard to simplify the lock protection needed code.

Fixes: 4198a9b57106 ("pinctrl: avoid reload of p state in list iteration")
Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
---
 drivers/pinctrl/core.c | 143 +++++++++++++++++++++--------------------
 drivers/pinctrl/core.h |   2 +
 2 files changed, 75 insertions(+), 70 deletions(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index ee56856cb80c..1f7d001d4c1e 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1061,6 +1061,7 @@ static struct pinctrl *create_pinctrl(struct device *dev,
 	p->dev = dev;
 	INIT_LIST_HEAD(&p->states);
 	INIT_LIST_HEAD(&p->dt_maps);
+	spin_lock_init(&p->lock);
 
 	ret = pinctrl_dt_to_map(p, pctldev);
 	if (ret < 0) {
@@ -1257,93 +1258,95 @@ static void pinctrl_link_add(struct pinctrl_dev *pctldev,
 static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
 {
 	struct pinctrl_setting *setting, *setting2;
-	struct pinctrl_state *old_state = READ_ONCE(p->state);
+	struct pinctrl_state *old_state;
 	int ret;
 
-	if (old_state) {
-		/*
-		 * For each pinmux setting in the old state, forget SW's record
-		 * of mux owner for that pingroup. Any pingroups which are
-		 * still owned by the new state will be re-acquired by the call
-		 * to pinmux_enable_setting() in the loop below.
-		 */
-		list_for_each_entry(setting, &old_state->settings, node) {
-			if (setting->type != PIN_MAP_TYPE_MUX_GROUP)
-				continue;
-			pinmux_disable_setting(setting);
+	scoped_guard(spinlock_irqsave, &p->lock) {
+		old_state = p->state;
+		if (old_state) {
+			/*
+			 * For each pinmux setting in the old state, forget SW's record
+			 * of mux owner for that pingroup. Any pingroups which are
+			 * still owned by the new state will be re-acquired by the call
+			 * to pinmux_enable_setting() in the loop below.
+			 */
+			list_for_each_entry(setting, &old_state->settings, node) {
+				if (setting->type != PIN_MAP_TYPE_MUX_GROUP)
+					continue;
+				pinmux_disable_setting(setting);
+			}
 		}
-	}
-
-	p->state = NULL;
 
-	/* Apply all the settings for the new state - pinmux first */
-	list_for_each_entry(setting, &state->settings, node) {
-		switch (setting->type) {
-		case PIN_MAP_TYPE_MUX_GROUP:
-			ret = pinmux_enable_setting(setting);
-			break;
-		case PIN_MAP_TYPE_CONFIGS_PIN:
-		case PIN_MAP_TYPE_CONFIGS_GROUP:
-			ret = 0;
-			break;
-		default:
-			ret = -EINVAL;
-			break;
-		}
+		p->state = NULL;
 
-		if (ret < 0)
-			goto unapply_new_state;
+		/* Apply all the settings for the new state - pinmux first */
+		list_for_each_entry(setting, &state->settings, node) {
+			switch (setting->type) {
+			case PIN_MAP_TYPE_MUX_GROUP:
+				ret = pinmux_enable_setting(setting);
+				break;
+			case PIN_MAP_TYPE_CONFIGS_PIN:
+			case PIN_MAP_TYPE_CONFIGS_GROUP:
+				ret = 0;
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
 
-		/* Do not link hogs (circular dependency) */
-		if (p != setting->pctldev->p)
-			pinctrl_link_add(setting->pctldev, p->dev);
-	}
+			if (ret < 0)
+				goto unapply_new_state;
 
-	/* Apply all the settings for the new state - pinconf after */
-	list_for_each_entry(setting, &state->settings, node) {
-		switch (setting->type) {
-		case PIN_MAP_TYPE_MUX_GROUP:
-			ret = 0;
-			break;
-		case PIN_MAP_TYPE_CONFIGS_PIN:
-		case PIN_MAP_TYPE_CONFIGS_GROUP:
-			ret = pinconf_apply_setting(setting);
-			break;
-		default:
-			ret = -EINVAL;
-			break;
+			/* Do not link hogs (circular dependency) */
+			if (p != setting->pctldev->p)
+				pinctrl_link_add(setting->pctldev, p->dev);
 		}
 
-		if (ret < 0) {
-			goto unapply_new_state;
-		}
+		/* Apply all the settings for the new state - pinconf after */
+		list_for_each_entry(setting, &state->settings, node) {
+			switch (setting->type) {
+			case PIN_MAP_TYPE_MUX_GROUP:
+				ret = 0;
+				break;
+			case PIN_MAP_TYPE_CONFIGS_PIN:
+			case PIN_MAP_TYPE_CONFIGS_GROUP:
+				ret = pinconf_apply_setting(setting);
+				break;
+			default:
+				ret = -EINVAL;
+				break;
+			}
 
-		/* Do not link hogs (circular dependency) */
-		if (p != setting->pctldev->p)
-			pinctrl_link_add(setting->pctldev, p->dev);
-	}
+			if (ret < 0)
+				goto unapply_new_state;
 
-	p->state = state;
+			/* Do not link hogs (circular dependency) */
+			if (p != setting->pctldev->p)
+				pinctrl_link_add(setting->pctldev, p->dev);
+		}
 
-	return 0;
+		p->state = state;
+
+		return 0;
 
 unapply_new_state:
-	dev_err(p->dev, "Error applying setting, reverse things back\n");
 
-	list_for_each_entry(setting2, &state->settings, node) {
-		if (&setting2->node == &setting->node)
-			break;
-		/*
-		 * All we can do here is pinmux_disable_setting.
-		 * That means that some pins are muxed differently now
-		 * than they were before applying the setting (We can't
-		 * "unmux a pin"!), but it's not a big deal since the pins
-		 * are free to be muxed by another apply_setting.
-		 */
-		if (setting2->type == PIN_MAP_TYPE_MUX_GROUP)
-			pinmux_disable_setting(setting2);
+		list_for_each_entry(setting2, &state->settings, node) {
+			if (&setting2->node == &setting->node)
+				break;
+			/*
+			 * All we can do here is pinmux_disable_setting.
+			 * That means that some pins are muxed differently now
+			 * than they were before applying the setting (We can't
+			 * "unmux a pin"!), but it's not a big deal since the pins
+			 * are free to be muxed by another apply_setting.
+			 */
+			if (setting2->type == PIN_MAP_TYPE_MUX_GROUP)
+				pinmux_disable_setting(setting2);
+		}
 	}
 
+	dev_err(p->dev, "Error applying setting, reverse things back\n");
 	/* There's no infinite recursive loop here because p->state is NULL */
 	if (old_state)
 		pinctrl_select_state(p, old_state);
diff --git a/drivers/pinctrl/core.h b/drivers/pinctrl/core.h
index 837fd5bd903d..6844edd38b4a 100644
--- a/drivers/pinctrl/core.h
+++ b/drivers/pinctrl/core.h
@@ -12,6 +12,7 @@
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/radix-tree.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #include <linux/pinctrl/machine.h>
@@ -91,6 +92,7 @@ struct pinctrl {
 	struct pinctrl_state *state;
 	struct list_head dt_maps;
 	struct kref users;
+	spinlock_t lock;
 };
 
 /**

base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.17.1


