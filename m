Return-Path: <linux-kernel+bounces-3466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43622816CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 586501C21F41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B851CA9E;
	Mon, 18 Dec 2023 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hr88ExrJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD21C6A7;
	Mon, 18 Dec 2023 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BIB0Cqb001111;
	Mon, 18 Dec 2023 11:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=2RhQtL+sFcwJZo/VmDn+5n1VU9Q22OgEKdRfJvEjC8g=; b=hr
	88ExrJvBVxjn2q3J3LUJWIXKZhX/7712NvhJWDqGTbHyI9P1iDKbmDw1adr1Gq5X
	iZus0Cv9NYgL1fkkZRVrxSSjIegrra7xaQ5nMTOOsrFlDRD1Gmk8RjtZDYWR/pCX
	LtRQ9y7eL5u6R5QyEoWch+XPWvZARUpIjmZtCq5q8aL11FhKTR5zhRnXc+a1CRVM
	nDy90MaIZV1WfteTK0i6IqhpcV3BWgoUHL+oQbqeM26DeLxtV0QYiCmv9ZbHbbEd
	dWyOw0aHMEYeSKxeHE2PzDxnDym0DUlyEBY4R4bbJUf2ZcDSMZeC2LwiqMwRvpQN
	7MflnMAkQRxI4rn3mW0w==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2md2r4n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Dec 2023 11:40:03 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3BIBX5KW029944;
	Mon, 18 Dec 2023 11:40:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3v14ym00af-1;
	Mon, 18 Dec 2023 11:40:00 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BIBa9rW000378;
	Mon, 18 Dec 2023 11:36:09 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-dikshita-hyd.qualcomm.com [10.213.110.13])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3BIBX864030065;
	Mon, 18 Dec 2023 11:36:09 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 347544)
	id 7432D2390; Mon, 18 Dec 2023 17:03:04 +0530 (+0530)
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
To: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
Subject: [PATCH v2 34/34] media: iris: add power management for encoder
Date: Mon, 18 Dec 2023 17:02:29 +0530
Message-Id: <1702899149-21321-35-git-send-email-quic_dikshita@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5IZyREQe7H_wDHPhZJZUdD50bi2vuaba
X-Proofpoint-GUID: 5IZyREQe7H_wDHPhZJZUdD50bi2vuaba
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 mlxlogscore=999 suspectscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2312180084
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hardware specific power sequence include programming specific
sequence of registers. Implements this sequence for iris3.

Also, implement iris3 Encoder specific calculation for clock
and bus bandwidth which depends on hardware configuration,
codec format, resolution and frame rate.

Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
---
 .../media/platform/qcom/vcodec/iris/iris_ctrls.c   |   2 +
 .../media/platform/qcom/vcodec/iris/iris_power.c   |  15 ++--
 .../platform/qcom/vcodec/iris/platform_common.h    |   3 +
 .../platform/qcom/vcodec/iris/platform_sm8550.c    |  14 +++
 .../platform/qcom/vcodec/iris/vpu_iris3_power.c    | 100 +++++++++++++++------
 5 files changed, 103 insertions(+), 31 deletions(-)

diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
index 559b0dd..1a2e305 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_ctrls.c
@@ -799,6 +799,8 @@ int decide_quality_mode(struct iris_inst *inst)
 	if (mbpf <= max_hq_mbpf && mbps <= max_hq_mbps)
 		mode = MAX_QUALITY_MODE;
 
+	inst->cap[QUALITY_MODE].value = mode;
+
 	return mode;
 }
 
diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_power.c b/drivers/media/platform/qcom/vcodec/iris/iris_power.c
index 77439e3..be71751 100644
--- a/drivers/media/platform/qcom/vcodec/iris/iris_power.c
+++ b/drivers/media/platform/qcom/vcodec/iris/iris_power.c
@@ -48,11 +48,16 @@ static int iris_vote_buses(struct iris_inst *inst)
 	vote_data->height = inp_f->fmt.pix_mp.height;
 	vote_data->fps = inst->max_rate;
 
-	if (is_linear_colorformat(out_f->fmt.pix_mp.pixelformat)) {
-		vote_data->color_formats[0] = V4L2_PIX_FMT_NV12;
-		vote_data->color_formats[1] = out_f->fmt.pix_mp.pixelformat;
-	} else {
-		vote_data->color_formats[0] = out_f->fmt.pix_mp.pixelformat;
+	if (inst->domain == ENCODER) {
+		vote_data->color_formats[0] =
+			v4l2_colorformat_to_driver(inst, inst->fmt_src->fmt.pix_mp.pixelformat);
+	} else if (inst->domain == DECODER) {
+		if (is_linear_colorformat(out_f->fmt.pix_mp.pixelformat)) {
+			vote_data->color_formats[0] = V4L2_PIX_FMT_NV12;
+			vote_data->color_formats[1] = out_f->fmt.pix_mp.pixelformat;
+		} else {
+			vote_data->color_formats[0] = out_f->fmt.pix_mp.pixelformat;
+		}
 	}
 
 	call_session_op(core, calc_bw, inst, vote_data);
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_common.h b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
index 42ac662..e9b5c99 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_common.h
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_common.h
@@ -174,6 +174,7 @@ enum plat_inst_cap_type {
 	INPUT_BUF_HOST_MAX_COUNT,
 	STAGE,
 	PIPE,
+	QUALITY_MODE,
 	POC,
 	CODED_FRAMES,
 	BIT_DEPTH,
@@ -279,6 +280,8 @@ struct format_capability {
 struct platform_data {
 	const struct bus_info *bus_tbl;
 	unsigned int bus_tbl_size;
+	const struct bw_info *bw_tbl_enc;
+	unsigned int bw_tbl_enc_size;
 	const struct bw_info *bw_tbl_dec;
 	unsigned int bw_tbl_dec_size;
 	const char * const *pd_tbl;
diff --git a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
index 17c5856..d47c985 100644
--- a/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
+++ b/drivers/media/platform/qcom/vcodec/iris/platform_sm8550.c
@@ -1005,6 +1005,11 @@ static struct plat_inst_cap instance_cap_data_sm8550[] = {
 		NULL,
 		set_pipe},
 
+	{QUALITY_MODE, ENC, CODECS_ALL,
+		MAX_QUALITY_MODE,
+		POWER_SAVE_MODE, 1,
+		POWER_SAVE_MODE},
+
 	{POC, DEC, H264, 0, 2, 1, 1,
 		0,
 		HFI_PROP_PIC_ORDER_CNT_TYPE},
@@ -1051,6 +1056,13 @@ static const char * const sm8550_pd_table[] = { "iris-ctl", "vcodec", NULL };
 
 static const char * const sm8550_opp_pd_table[] = { "mxc", "mmcx", NULL };
 
+static const struct bw_info sm8550_bw_table_enc[] = {
+	{ 1944000, 1491000, 2693000 },	/* 3840x2160@60 */
+	{  972000,  765000, 1366000 },	/* 3840x2160@30 */
+	{  489600,  557000, 780000 },	/* 1920x1080@60 */
+	{  244800,  288000, 399000 },	/* 1920x1080@30 */
+};
+
 static const struct bw_info sm8550_bw_table_dec[] = {
 	{ 2073600, 1608000, 2742000 },	/* 4096x2160@60 */
 	{ 1036800,  826000, 1393000 },	/* 4096x2160@30 */
@@ -1133,6 +1145,8 @@ struct platform_data sm8550_data = {
 	.clk_rst_tbl = sm8550_clk_reset_table,
 	.clk_rst_tbl_size = ARRAY_SIZE(sm8550_clk_reset_table),
 
+	.bw_tbl_enc = sm8550_bw_table_enc,
+	.bw_tbl_enc_size = ARRAY_SIZE(sm8550_bw_table_enc),
 	.bw_tbl_dec = sm8550_bw_table_dec,
 	.bw_tbl_dec_size = ARRAY_SIZE(sm8550_bw_table_dec),
 
diff --git a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c
index 2828227..8497b84 100644
--- a/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c
+++ b/drivers/media/platform/qcom/vcodec/iris/vpu_iris3_power.c
@@ -11,12 +11,13 @@
 
 u64 iris_calc_freq_iris3(struct iris_inst *inst, u32 data_size)
 {
+	u32 operating_rate, vsp_factor_num = 1, vsp_factor_den = 1;
 	u64 vsp_cycles = 0, vpp_cycles = 0, fw_cycles = 0;
 	u64 fw_vpp_cycles = 0, bitrate = 0, freq = 0;
+	u32 vpp_cycles_per_mb, mbs_per_second;
 	u32 base_cycles = 0, fps, mbpf;
 	u32 height = 0, width = 0;
 	struct v4l2_format *inp_f;
-	u32 mbs_per_second;
 
 	inp_f = inst->fmt_src;
 	width = max(inp_f->fmt.pix_mp.width, inst->crop.width);
@@ -29,32 +30,74 @@ u64 iris_calc_freq_iris3(struct iris_inst *inst, u32 data_size)
 	fw_cycles = fps * inst->cap[MB_CYCLES_FW].value;
 	fw_vpp_cycles = fps * inst->cap[MB_CYCLES_FW_VPP].value;
 
-	vpp_cycles = mbs_per_second * inst->cap[MB_CYCLES_VPP].value /
-		inst->cap[PIPE].value;
-	vpp_cycles += max(vpp_cycles / 20, fw_vpp_cycles);
-
-	if (inst->cap[PIPE].value > 1)
-		vpp_cycles += div_u64(vpp_cycles * 59, 1000);
-
-	base_cycles = inst->cap[MB_CYCLES_VSP].value;
-	bitrate = fps * data_size * 8;
-	vsp_cycles = bitrate;
-
-	if (inst->codec == VP9) {
-		vsp_cycles = div_u64(vsp_cycles * 170, 100);
-	} else if (inst->cap[ENTROPY_MODE].value ==
-		V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC) {
-		vsp_cycles = div_u64(vsp_cycles * 135, 100);
-	} else {
-		base_cycles = 0;
-		vsp_cycles = div_u64(vsp_cycles, 2);
-	}
-	vsp_cycles = div_u64(vsp_cycles * 21, 20);
+	if (inst->domain == ENCODER) {
+		vpp_cycles_per_mb =
+			inst->cap[QUALITY_MODE].value == POWER_SAVE_MODE ?
+			inst->cap[MB_CYCLES_LP].value :
+			inst->cap[MB_CYCLES_VPP].value;
+
+		vpp_cycles = mbs_per_second * vpp_cycles_per_mb / inst->cap[PIPE].value;
+
+		if (inst->cap[B_FRAME].value > 1)
+			vpp_cycles += (vpp_cycles / 4) + (vpp_cycles / 8);
+		else if (inst->cap[B_FRAME].value)
+			vpp_cycles += vpp_cycles / 4;
+
+		vpp_cycles += max(div_u64(vpp_cycles, 20), fw_vpp_cycles);
+		if (inst->cap[PIPE].value > 1)
+			vpp_cycles += div_u64(vpp_cycles, 100);
+
+		operating_rate = inst->cap[OPERATING_RATE].value >> 16;
+		if (operating_rate > (inst->cap[FRAME_RATE].value >> 16) &&
+		    (inst->cap[FRAME_RATE].value >> 16)) {
+			vsp_factor_num = operating_rate;
+			vsp_factor_den = inst->cap[FRAME_RATE].value >> 16;
+		}
+		vsp_cycles = div_u64(((u64)inst->cap[BIT_RATE].value * vsp_factor_num),
+				     vsp_factor_den);
+
+		base_cycles = inst->cap[MB_CYCLES_VSP].value;
+		if (inst->cap[ENTROPY_MODE].value ==
+			V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC) {
+			vsp_cycles = div_u64(vsp_cycles * 135, 100);
+		} else {
+			base_cycles = 0;
+			vsp_cycles = div_u64(vsp_cycles, 2);
+		}
+		vsp_cycles = div_u64(vsp_cycles * 21, 20);
+
+		if (inst->cap[STAGE].value == STAGE_1)
+			vsp_cycles = vsp_cycles * 3;
 
-	if (inst->cap[STAGE].value == STAGE_1)
-		vsp_cycles = vsp_cycles * 3;
+		vsp_cycles += mbs_per_second * base_cycles;
+	} else if (inst->domain == DECODER) {
+		vpp_cycles = mbs_per_second * inst->cap[MB_CYCLES_VPP].value /
+			inst->cap[PIPE].value;
+		vpp_cycles += max(vpp_cycles / 20, fw_vpp_cycles);
+
+		if (inst->cap[PIPE].value > 1)
+			vpp_cycles += div_u64(vpp_cycles * 59, 1000);
+
+		base_cycles = inst->cap[MB_CYCLES_VSP].value;
+		bitrate = fps * data_size * 8;
+		vsp_cycles = bitrate;
+
+		if (inst->codec == VP9) {
+			vsp_cycles = div_u64(vsp_cycles * 170, 100);
+		} else if (inst->cap[ENTROPY_MODE].value ==
+				V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC) {
+			vsp_cycles = div_u64(vsp_cycles * 135, 100);
+		} else {
+			base_cycles = 0;
+			vsp_cycles = div_u64(vsp_cycles, 2);
+		}
+		vsp_cycles = div_u64(vsp_cycles * 21, 20);
+
+		if (inst->cap[STAGE].value == STAGE_1)
+			vsp_cycles = vsp_cycles * 3;
 
 		vsp_cycles += mbs_per_second * base_cycles;
+	}
 
 	freq = max3(vpp_cycles, vsp_cycles, fw_cycles);
 
@@ -78,8 +121,13 @@ int iris_calc_bw_iris3(struct iris_inst *inst, struct bus_vote_data *data)
 	if (mbps == 0)
 		return 0;
 
-	bw_tbl = core->platform_data->bw_tbl_dec;
-	num_rows = core->platform_data->bw_tbl_dec_size;
+	if (inst->domain == DECODER) {
+		bw_tbl = core->platform_data->bw_tbl_dec;
+		num_rows = core->platform_data->bw_tbl_dec_size;
+	} else if (inst->domain == ENCODER) {
+		bw_tbl = core->platform_data->bw_tbl_enc;
+		num_rows = core->platform_data->bw_tbl_enc_size;
+	}
 
 	if (!bw_tbl || num_rows == 0)
 		return 0;
-- 
2.7.4


