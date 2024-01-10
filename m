Return-Path: <linux-kernel+bounces-22118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE211829989
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:46:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97D191C222C4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A4C4A9A9;
	Wed, 10 Jan 2024 11:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LlpN2E90"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B6448CD5;
	Wed, 10 Jan 2024 11:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40AAhKar012709;
	Wed, 10 Jan 2024 11:42:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=f0yjLvxIsBNyj7tkXEpAgfEIKkE98nJGHq3ch3fPuRQ=; b=Ll
	pN2E90DgC54xYx8+rxUCX9usWwaqBH3H/lvFKvEmVTkXwtxXp8bUKnjCjsESPRoa
	nRf3f87H/jjYDFfYsAt96eVlA78CbJtE33ONRJ6pnuiCfSH3MfNSZx0HwuI33k3p
	Ayz726c1Wf98rVsD9zInLMaHcJtplCvACMdqVlIDtQjToClXU37wWoZf/znTjx6d
	YaWNMejCHXGcfojLIDBBduCNEi0YyZ5DzIXS79SXSe/zyfmIjvGl1OUkQJcmA4Oj
	jzwVrgcAue7ajeHOfmCgrgwKOe7JNSJlrQ2lK9I0e2nc4kCfAdHhDlNh/u2QLrQQ
	eFTOt1utM321a7dPs1ew==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhsqyr480-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:42:38 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40ABgaEJ019519
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 11:42:36 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 10 Jan 2024 03:42:26 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <linux@armlinux.org.uk>,
        <shannon.nelson@amd.com>, <anthony.l.nguyen@intel.com>,
        <jasowang@redhat.com>, <brett.creeley@amd.com>,
        <rrameshbabu@nvidia.com>, <joshua.a.hay@intel.com>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>, <u-kumar1@ti.com>,
        <jacob.e.keller@intel.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <ryazanov.s.a@gmail.com>, <ansuelsmth@gmail.com>,
        <quic_kkumarcs@quicinc.com>, <quic_suruchia@quicinc.com>,
        <quic_soni@quicinc.com>, <quic_pavir@quicinc.com>,
        <quic_souravp@quicinc.com>, <quic_linchen@quicinc.com>,
        <quic_leiwei@quicinc.com>
Subject: [PATCH net-next 09/20] net: ethernet: qualcomm: Add PPE queue config
Date: Wed, 10 Jan 2024 19:40:21 +0800
Message-ID: <20240110114033.32575-10-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240110114033.32575-1-quic_luoj@quicinc.com>
References: <20240110114033.32575-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MTo69q-kg4TgpbdIfTjb0y9PQ9RO-K0a
X-Proofpoint-ORIG-GUID: MTo69q-kg4TgpbdIfTjb0y9PQ9RO-K0a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100096

Assign the default queue base for the physical port. Each physical port
has an independent profile. The egress queue ID is decided by queue
base, priority class offset and hash class offset.

1. The queue base is configured based on the destination port or CPU
code or service code.

2. The maximum priority offset is decided by the range of the DRR
available for the physical port, which is from the device tree scheduler
resource.

3. The hash class offset is configured as 0 by default, which can be
adjusted by the EDMA driver for load balance on the CPU cores.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/ethernet/qualcomm/ppe/ppe.c      | 98 ++++++++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe_ops.c  | 79 ++++++++++++++++
 drivers/net/ethernet/qualcomm/ppe/ppe_ops.h  | 34 +++++++
 drivers/net/ethernet/qualcomm/ppe/ppe_regs.h | 16 ++++
 4 files changed, 227 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe.c b/drivers/net/ethernet/qualcomm/ppe/ppe.c
index 75c24a87e2be..dd032a158231 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe.c
@@ -1017,6 +1017,98 @@ static int of_parse_ppe_config(struct ppe_device *ppe_dev,
 	return of_parse_ppe_scheduler(ppe_dev, ppe_node);
 }
 
+static int ppe_qm_init(struct ppe_device *ppe_dev)
+{
+	const struct ppe_queue_ops *ppe_queue_ops;
+	struct ppe_queue_ucast_dest queue_dst;
+	int profile_id, priority, res, class;
+
+	ppe_queue_ops = ppe_queue_config_ops_get();
+
+	/* Initialize the PPE queue base ID and queue priority for each
+	 * physical port, the egress queue ID is decided by the queue
+	 * base ID added by the queue priority class and RSS hash class.
+	 *
+	 * Each physical port has the independent profile ID, so that
+	 * each physical port can be configured with the independent
+	 * queue base and queue priority class and RSS hash class.
+	 */
+	profile_id = 0;
+	while (profile_id < PPE_SCHEDULER_PORT_NUM) {
+		memset(&queue_dst, 0, sizeof(queue_dst));
+
+		/* The device tree property of queue-config is as below,
+		 * <queue_base queue_num group prealloc ceil weight
+		 * resume_off dynamic>;
+		 */
+		res = ppe_scheduler_res[profile_id].ucastq[0];
+		queue_dst.dest_port = profile_id;
+
+		/* Configure queue base ID and profile ID that is same as
+		 * physical port ID.
+		 */
+		if (ppe_queue_ops->queue_ucast_base_set)
+			ppe_queue_ops->queue_ucast_base_set(ppe_dev,
+							    queue_dst,
+							    res,
+							    profile_id);
+
+		/* Queue maximum priority supported by each phiscal port */
+		res = ppe_scheduler_res[profile_id].l0cdrr[1] -
+		      ppe_scheduler_res[profile_id].l0cdrr[0];
+
+		priority = 0;
+		while (priority < PPE_QUEUE_PRI_MAX) {
+			if (priority > res)
+				class = res;
+			else
+				class = priority;
+
+			if (ppe_queue_ops->queue_ucast_pri_class_set)
+				ppe_queue_ops->queue_ucast_pri_class_set(ppe_dev,
+									 profile_id,
+									 priority,
+									 class);
+			priority++;
+		}
+
+		/* Configure the queue RSS hash class value as 0 by default,
+		 * which can be configured as the value same as the ARM CPU
+		 * core number to distribute traffic for the traffic load balance.
+		 */
+		priority = 0;
+		while (priority < PPE_QUEUE_HASH_MAX) {
+			if (ppe_queue_ops->queue_ucast_hash_class_set)
+				ppe_queue_ops->queue_ucast_hash_class_set(ppe_dev,
+									  profile_id,
+									  priority,
+									  0);
+			priority++;
+		}
+
+		profile_id++;
+	}
+
+	/* Redirect ARP reply packet with the max priority on CPU port, which
+	 * keeps the ARP reply with highest priority received by EDMA when
+	 * there is heavy traffic.
+	 */
+	memset(&queue_dst, 0, sizeof(queue_dst));
+	queue_dst.cpu_code_en = true;
+	queue_dst.cpu_code = 101;
+	res = ppe_scheduler_res[0].ucastq[0];
+	priority = ppe_scheduler_res[0].l0cdrr[1] - ppe_scheduler_res[0].l0cdrr[0];
+	if (ppe_queue_ops->queue_ucast_base_set)
+		ppe_queue_ops->queue_ucast_base_set(ppe_dev, queue_dst, res, priority);
+
+	return 0;
+}
+
+static int ppe_dev_hw_init(struct ppe_device *ppe_dev)
+{
+	return ppe_qm_init(ppe_dev);
+}
+
 static int qcom_ppe_probe(struct platform_device *pdev)
 {
 	struct ppe_device *ppe_dev;
@@ -1059,6 +1151,12 @@ static int qcom_ppe_probe(struct platform_device *pdev)
 				     ret,
 				     "of parse ppe failed\n");
 
+	ret = ppe_dev_hw_init(ppe_dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev,
+				     ret,
+				     "ppe device hw init failed\n");
+
 	ppe_dev->is_ppe_probed = true;
 	return 0;
 }
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
index 7853c2fdcc63..eaa3f1e7b525 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.c
@@ -194,9 +194,88 @@ static int ppe_queue_scheduler_get(struct ppe_device *ppe_dev,
 		return -EINVAL;
 }
 
+static int ppe_queue_ucast_base_set(struct ppe_device *ppe_dev,
+				    struct ppe_queue_ucast_dest queue_dst,
+				    int queue_base, int profile_id)
+{
+	u32 reg_val;
+	int index;
+
+	if (queue_dst.service_code_en)
+		index = 2048 + (queue_dst.src_profile << 8) + queue_dst.service_code;
+	else if (queue_dst.cpu_code_en)
+		index = 1024 + (queue_dst.src_profile << 8) + queue_dst.cpu_code;
+	else
+		index = (queue_dst.src_profile << 8) + queue_dst.dest_port;
+
+	reg_val = FIELD_PREP(PPE_UCAST_QUEUE_MAP_TBL_PROFILE_ID, profile_id) |
+		  FIELD_PREP(PPE_UCAST_QUEUE_MAP_TBL_QUEUE_ID, queue_base);
+
+	return ppe_write(ppe_dev, PPE_UCAST_QUEUE_MAP_TBL + index * PPE_UCAST_QUEUE_MAP_TBL_INC,
+			 reg_val);
+}
+
+static  int ppe_queue_ucast_base_get(struct ppe_device *ppe_dev,
+				     struct ppe_queue_ucast_dest queue_dst,
+				     int *queue_base, int *profile_id)
+{
+	u32 reg_val;
+	int index;
+
+	if (queue_dst.service_code_en)
+		index = 2048 + (queue_dst.src_profile << 8) + queue_dst.service_code;
+	else if (queue_dst.cpu_code_en)
+		index = 1024 + (queue_dst.src_profile << 8) + queue_dst.cpu_code;
+	else
+		index = (queue_dst.src_profile << 8) + queue_dst.dest_port;
+
+	ppe_read(ppe_dev, PPE_UCAST_QUEUE_MAP_TBL + index * PPE_UCAST_QUEUE_MAP_TBL_INC, &reg_val);
+
+	*queue_base = FIELD_GET(PPE_UCAST_QUEUE_MAP_TBL_QUEUE_ID, reg_val);
+	*profile_id = FIELD_GET(PPE_UCAST_QUEUE_MAP_TBL_PROFILE_ID, reg_val);
+
+	return 0;
+}
+
+static int ppe_queue_ucast_pri_class_set(struct ppe_device *ppe_dev,
+					 int profile_id,
+					 int priority,
+					 int class_offset)
+{
+	u32 reg_val;
+	int index;
+
+	index = (profile_id << 4) + priority;
+	reg_val = FIELD_PREP(PPE_UCAST_PRIORITY_MAP_TBL_CLASS, class_offset);
+
+	return ppe_write(ppe_dev,
+			 PPE_UCAST_PRIORITY_MAP_TBL + index * PPE_UCAST_PRIORITY_MAP_TBL_INC,
+			 reg_val);
+}
+
+static int ppe_queue_ucast_hash_class_set(struct ppe_device *ppe_dev,
+					  int profile_id,
+					  int rss_hash,
+					  int class_offset)
+{
+	u32 reg_val;
+	int index;
+
+	index = (profile_id << 4) + rss_hash;
+	reg_val = FIELD_PREP(PPE_UCAST_HASH_MAP_TBL_HASH, class_offset);
+
+	return ppe_write(ppe_dev,
+			 PPE_UCAST_HASH_MAP_TBL + index * PPE_UCAST_HASH_MAP_TBL_INC,
+			 reg_val);
+}
+
 static const struct ppe_queue_ops qcom_ppe_queue_config_ops = {
 	.queue_scheduler_set = ppe_queue_scheduler_set,
 	.queue_scheduler_get = ppe_queue_scheduler_get,
+	.queue_ucast_base_set = ppe_queue_ucast_base_set,
+	.queue_ucast_base_get = ppe_queue_ucast_base_get,
+	.queue_ucast_pri_class_set = ppe_queue_ucast_pri_class_set,
+	.queue_ucast_hash_class_set = ppe_queue_ucast_hash_class_set,
 };
 
 const struct ppe_queue_ops *ppe_queue_config_ops_get(void)
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
index 4980e3fed1c0..181dbd4a3d90 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_ops.h
@@ -10,6 +10,9 @@
 #ifndef __PPE_OPS_H__
 #define __PPE_OPS_H__
 
+#define PPE_QUEUE_PRI_MAX		16
+#define PPE_QUEUE_HASH_MAX		256
+
 /* PPE hardware QoS configurations used to dispatch the packet passed
  * through PPE, the scheduler supports DRR(deficit round robin with the
  * weight) and SP(strict priority).
@@ -27,6 +30,21 @@ struct ppe_qos_scheduler_cfg {
 	int drr_frame_mode;
 };
 
+/* The egress queue ID can be decided by service code, CPU code and
+ * egress port.
+ *
+ * service code has the highest priority to decide queue base, then
+ * CPU code, finally egress port when all are enabled.
+ */
+struct ppe_queue_ucast_dest {
+	int src_profile;
+	bool service_code_en;
+	int service_code;
+	bool cpu_code_en;
+	int cpu_code;
+	int dest_port;
+};
+
 /* The operations are used to configure the PPE queue related resource */
 struct ppe_queue_ops {
 	int (*queue_scheduler_set)(struct ppe_device *ppe_dev,
@@ -39,6 +57,22 @@ struct ppe_queue_ops {
 				   int level,
 				   int *port,
 				   struct ppe_qos_scheduler_cfg *scheduler_cfg);
+	int (*queue_ucast_base_set)(struct ppe_device *ppe_dev,
+				    struct ppe_queue_ucast_dest queue_dst,
+				    int queue_base,
+				    int profile_id);
+	int (*queue_ucast_base_get)(struct ppe_device *ppe_dev,
+				    struct ppe_queue_ucast_dest queue_dst,
+				    int *queue_base,
+				    int *profile_id);
+	int (*queue_ucast_pri_class_set)(struct ppe_device *ppe_dev,
+					 int profile_id,
+					 int priority,
+					 int class_offset);
+	int (*queue_ucast_hash_class_set)(struct ppe_device *ppe_dev,
+					  int profile_id,
+					  int rss_hash,
+					  int class_offset);
 };
 
 const struct ppe_queue_ops *ppe_queue_config_ops_get(void);
diff --git a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
index 10daa70f28e9..9fdb9592b44b 100644
--- a/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
+++ b/drivers/net/ethernet/qualcomm/ppe/ppe_regs.h
@@ -148,6 +148,22 @@ union ppe_bm_port_fc_cfg_u {
 	struct ppe_bm_port_fc_cfg bf;
 };
 
+#define PPE_UCAST_QUEUE_MAP_TBL					0x810000
+#define PPE_UCAST_QUEUE_MAP_TBL_NUM				3072
+#define PPE_UCAST_QUEUE_MAP_TBL_INC				0x10
+#define PPE_UCAST_QUEUE_MAP_TBL_PROFILE_ID			GENMASK(3, 0)
+#define PPE_UCAST_QUEUE_MAP_TBL_QUEUE_ID			GENMASK(11, 4)
+
+#define PPE_UCAST_HASH_MAP_TBL					0x830000
+#define PPE_UCAST_HASH_MAP_TBL_NUM				4096
+#define PPE_UCAST_HASH_MAP_TBL_INC				0x10
+#define PPE_UCAST_HASH_MAP_TBL_HASH				GENMASK(7, 0)
+
+#define PPE_UCAST_PRIORITY_MAP_TBL				0x842000
+#define PPE_UCAST_PRIORITY_MAP_TBL_NUM				256
+#define PPE_UCAST_PRIORITY_MAP_TBL_INC				0x10
+#define PPE_UCAST_PRIORITY_MAP_TBL_CLASS			GENMASK(3, 0)
+
 #define PPE_AC_UNI_QUEUE_CFG_TBL				0x848000
 #define PPE_AC_UNI_QUEUE_CFG_TBL_NUM				256
 #define PPE_AC_UNI_QUEUE_CFG_TBL_INC				0x10
-- 
2.42.0


