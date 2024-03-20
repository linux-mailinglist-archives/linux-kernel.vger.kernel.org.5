Return-Path: <linux-kernel+bounces-108963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7500881295
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035E41C21276
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 13:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CD854BCC;
	Wed, 20 Mar 2024 13:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="chULiYJV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEE3537FE;
	Wed, 20 Mar 2024 13:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710942193; cv=none; b=f0zSjRZUZSZtn5lRuMqPSnCUEhrlcAfDNGM6D9bfxVBZAZC3gpmYrVJvzL6sfMalPXqXtjCwIOqewo32hqqcrRrzp4ReCcWo4KVGL7vwk1AqrhkNokVKPgUM2rYT3cprDz13NfTjIzrLZYnHlGZXe6iBD0Euw1mslS5P6ydfk7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710942193; c=relaxed/simple;
	bh=z+/8gg8xzY+ZQHBgH8oQ+/DIwpwHx6zj+6q3YHqyOvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KDLe4OSRPKuDeThxGvX7jzRxMdKKItmWg4KTCY7Ohs4dIchIZbCAdzGj335NSjb/rAwsDRE6XAlAZgnViodqLtJR3F4MVa5Yv8ew8mxXjH4mJ3Djr5jU0XCnRZJ0PZz5Fsh/Ig5lPEvHI9ZC9dj0NTX6aoLZcKrNJtybJmtPpQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=chULiYJV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42KBuYQZ014867;
	Wed, 20 Mar 2024 13:43:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=IPxogLLtnEAnKXI8uuR9
	V9HkNrgZQX24KQgyniUHaf0=; b=chULiYJVra3Hu85SQnP8k5Ky8NOixmYQ+R+p
	PGflXt7ySWp0xmfdGlLX02bLApTg2pqVbgrYItubWJKvwQzhoh5KhjX4fGmHMRTl
	TrJS/+p1aTIWZWsCR0sbCrw4hL2z1QJhUROXzaMOEncbltzdrEyzLxw+J0lMJDY2
	bO0zJ9Mq9XLGYrWoBRsz9ep12JjDP+qmXwVcJREEz0c75fUx7XqvzmUsI4wAcU7p
	lgS8Rq1L+jzFyEgWQBoPwjDv1B+xXbEAcif/gofnfOwVZeblLWOl7hzoP9CgFsyR
	OAWq7nkZEeEfp/oCnjSvkZl8G8Yp5L02B1stHYQrS4pxrWCyMw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyw8x8h0h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 13:43:07 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42KDh68a018245
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 13:43:06 GMT
Received: from hu-depengs-sha.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 06:43:04 -0700
From: Depeng Shao <quic_depengs@quicinc.com>
To: <rfoss@kernel.org>, <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <quic_yon@quicinc.com>
CC: <quic_depengs@quicinc.com>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v1 7/8] media: qcom: camss: Add sm8550 resources
Date: Wed, 20 Mar 2024 19:12:26 +0530
Message-ID: <20240320134227.16587-8-quic_depengs@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240320134227.16587-1-quic_depengs@quicinc.com>
References: <20240320134227.16587-1-quic_depengs@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LGyMQ9_PJL2ePfxyA-NfS2qKEoSPbuHu
X-Proofpoint-ORIG-GUID: LGyMQ9_PJL2ePfxyA-NfS2qKEoSPbuHu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_09,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200108

From: Yongsheng Li <quic_yon@quicinc.com>

Add sm8550 resources
- 3 x VFE, 3 RDI per VFE
- 2 x VFE Lite, 4 RDI per VFE
- 3 x CSID
- 2 x CSID Lite
- 8 x CSI PHY

Signed-off-by: Yongsheng Li <quic_yon@quicinc.com>
---
 drivers/media/platform/qcom/camss/camss.c | 345 ++++++++++++++++++++++
 1 file changed, 345 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index b57cd25bf6c7..f43c957de49e 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -1233,6 +1233,337 @@ static const struct resources_icc icc_res_sc8280xp[] = {
 	},
 };
 
+static const struct camss_subdev_resources csiphy_res_8550[] = {
+	/* CSIPHY0 */
+	{
+		.regulators = {},
+		.clock = {
+			"csiphy0",
+			"csiphy0_timer" },
+		.clock_rate = {
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 } },
+		.reg = { "csiphy0" },
+		.interrupt = { "csiphy0" },
+		.ops = &csiphy_ops_2_1_2,
+	},
+	/* CSIPHY1 */
+	{
+		.regulators = {},
+		.clock = {
+			"csiphy1",
+			"csiphy1_timer" },
+		.clock_rate = {
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 } },
+		.reg = { "csiphy1" },
+		.interrupt = { "csiphy1" },
+		.ops = &csiphy_ops_2_1_2,
+	},
+	/* CSIPHY2 */
+	{
+		.regulators = {},
+		.clock = {
+			"csiphy2",
+			"csiphy2_timer" },
+		.clock_rate = {
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 } },
+		.reg = { "csiphy2" },
+		.interrupt = { "csiphy2" },
+		.ops = &csiphy_ops_2_1_2,
+	},
+	/* CSIPHY3 */
+	{
+		.regulators = {},
+		.clock = {
+			"csiphy3",
+			"csiphy3_timer" },
+		.clock_rate = {
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 } },
+		.reg = { "csiphy3" },
+		.interrupt = { "csiphy3" },
+		.ops = &csiphy_ops_2_1_2,
+	},
+	/* CSIPHY4 */
+	{
+		.regulators = {},
+		.clock = {
+			"csiphy4",
+			"csiphy4_timer" },
+		.clock_rate = {
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 } },
+		.reg = { "csiphy4" },
+		.interrupt = { "csiphy4" },
+		.ops = &csiphy_ops_2_1_2,
+	},
+	/* CSIPHY5 */
+	{
+		.regulators = {},
+		.clock = {
+			"csiphy5",
+			"csiphy5_timer" },
+		.clock_rate = {
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 } },
+		.reg = { "csiphy5" },
+		.interrupt = { "csiphy5" },
+		.ops = &csiphy_ops_2_1_2,
+	},
+	/* CSIPHY6 */
+	{
+		.regulators = {},
+		.clock = {
+			"csiphy6",
+			"csiphy6_timer" },
+		.clock_rate = {
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 } },
+		.reg = { "csiphy6" },
+		.interrupt = { "csiphy6" },
+		.ops = &csiphy_ops_2_1_2,
+	},
+	/* CSIPHY7 */
+	{
+		.regulators = {},
+		.clock = {
+			"csiphy7",
+			"csiphy7_timer" },
+		.clock_rate = {
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 400000000, 400000000, 400000000, 400000000 } },
+		.reg = { "csiphy7" },
+		.interrupt = { "csiphy7" },
+		.ops = &csiphy_ops_2_1_2,
+	}
+};
+
+static const struct camss_subdev_resources csid_res_8550[] = {
+	/* CSID0 */
+	{
+		.regulators = { "vdda-phy", "vdda-pll" },
+		.clock = {
+			"csid",
+			"csiphy_rx" },
+		.clock_rate = {
+				{ 400000000, 480000000, 480000000, 480000000, 480000000 },
+				{ 400000000, 480000000, 480000000, 480000000, 480000000 } },
+		.reg = { "csid0", "csid_top" },
+		.interrupt = { "csid0" },
+		.ops = &csid_ops_gen3,
+	},
+	/* CSID1 */
+	{
+		.regulators = { "vdda-phy", "vdda-pll" },
+		.clock = { "csid", "csiphy_rx" },
+		.clock_rate = {
+				{ 400000000, 480000000, 480000000, 480000000, 480000000 },
+				{ 400000000, 480000000, 480000000, 480000000, 480000000 } },
+		.reg = { "csid1", "csid_top" },
+		.interrupt = { "csid1" },
+		.ops = &csid_ops_gen3,
+	},
+	/* CSID2 */
+	{
+		.regulators = { "vdda-phy", "vdda-pll" },
+		.clock = { "csid", "csiphy_rx" },
+		.clock_rate = {
+				{ 400000000, 480000000, 480000000, 480000000, 480000000 },
+				{ 400000000, 480000000, 480000000, 480000000, 480000000 } },
+		.reg = { "csid2", "csid_top" },
+		.interrupt = { "csid2" },
+		.ops = &csid_ops_gen3,
+	},
+	/* CSID3 */
+	{
+		.regulators = { "vdda-phy", "vdda-pll" },
+		.clock = { "vfe_lite_csid",
+			"vfe_lite_cphy_rx" },
+		.clock_rate = {
+				{ 400000000, 480000000, 480000000, 480000000, 480000000 },
+				{ 400000000, 480000000, 480000000, 480000000, 480000000 } },
+		.reg = { "csid_lite0" },
+		.interrupt = { "csid_lite0" },
+		.ops = &csid_ops_gen3,
+	},
+	/* CSID4 */
+	{
+		.regulators = { "vdda-phy", "vdda-pll" },
+		.clock = { "vfe_lite_csid",
+			"vfe_lite_cphy_rx" },
+		.clock_rate = {
+				{ 400000000, 480000000, 480000000, 480000000, 480000000 },
+				{ 400000000, 480000000, 480000000, 480000000, 480000000 } },
+		.reg = { "csid_lite1" },
+		.interrupt = { "csid_lite1" },
+		.ops = &csid_ops_gen3,
+	}
+};
+
+static const struct camss_subdev_resources vfe_res_8550[] = {
+	/* VFE0 */
+	{
+		.regulators = {},
+		.clock = {
+			"cam_hf_axi",
+			"cpas_ahb",
+			"cpas_fast_ahb_clk",
+			"vfe0_fast_ahb",
+			"vfe0",
+			"cpas_vfe0",
+			"camnoc_axi"},
+		.clock_rate = {
+				{ 0, 0, 0, 0, 0 },
+				{ 0, 0, 0, 0, 80000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 },
+				{ 466000000, 594000000, 675000000, 785000000, 785000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 }
+				},
+		.reg = { "vfe0" },
+		.interrupt = { "vfe0" },
+		.line_num = 3,
+		.is_lite = false,
+		.has_pd = true,
+		.pd_name = "ife0",
+		.ops = &vfe_ops_780,
+	},
+	/* VFE1 */
+	{
+		.regulators = {},
+		.clock = {
+			"cam_hf_axi",
+			"cpas_ahb",
+			"cpas_fast_ahb_clk",
+			"vfe1_fast_ahb",
+			"vfe1",
+			"cpas_vfe1",
+			"camnoc_axi"},
+		.clock_rate = {
+				{ 0, 0, 0, 0, 0 },
+				{ 0, 0, 0, 0, 80000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 },
+				{ 466000000, 594000000, 675000000, 785000000, 785000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 }
+				},
+		.reg = { "vfe1" },
+		.interrupt = { "vfe1" },
+		.line_num = 3,
+		.is_lite = false,
+		.has_pd = true,
+		.pd_name = "ife1",
+		.ops = &vfe_ops_780,
+	},
+	/* VFE2 */
+	{
+		.regulators = {},
+		.clock = {
+			"cam_hf_axi",
+			"cpas_ahb",
+			"cpas_fast_ahb_clk",
+			"vfe2_fast_ahb",
+			"vfe2",
+			"cpas_vfe2",
+			"camnoc_axi"},
+		.clock_rate = {
+				{ 0, 0, 0, 0, 0 },
+				{ 0, 0, 0, 0, 80000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 },
+				{ 466000000, 594000000, 675000000, 785000000, 785000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 }
+				},
+		.reg = { "vfe2" },
+		.interrupt = { "vfe2" },
+		.line_num = 3,
+		.is_lite = false,
+		.has_pd = true,
+		.pd_name = "ife2",
+		.ops = &vfe_ops_780,
+	},
+	/* VFE3 (lite) */
+	{
+		.regulators = {},
+		.clock = {
+			"cam_hf_axi",
+			"cpas_ahb",
+			"cpas_fast_ahb_clk",
+			"vfe_lite_ahb",
+			"vfe_lite",
+			"cpas_ife_lite",
+			"camnoc_axi"},
+		.clock_rate = {
+				{ 0, 0, 0, 0, 0 },
+				{ 0, 0, 0, 0, 80000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 },
+				{ 400000000, 480000000, 480000000, 480000000, 480000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 }
+				},
+		.reg = { "vfe_lite0" },
+		.interrupt = { "vfe_lite0" },
+		.line_num = 4,
+		.is_lite = true,
+		.ops = &vfe_ops_780,
+	},
+	/* VFE4 (lite) */
+	{
+		.regulators = {},
+		.clock = {
+			"cam_hf_axi",
+			"cpas_ahb",
+			"cpas_fast_ahb_clk",
+			"vfe_lite_ahb",
+			"vfe_lite",
+			"cpas_ife_lite",
+			"camnoc_axi"},
+		.clock_rate = {
+				{ 0, 0, 0, 0, 0 },
+				{ 0, 0, 0, 0, 80000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 },
+				{ 400000000, 480000000, 480000000, 480000000, 480000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 },
+				{ 300000000, 300000000, 400000000, 400000000, 400000000 }
+				},
+		.reg = { "vfe_lite1" },
+		.interrupt = { "vfe_lite1" },
+		.line_num = 4,
+		.is_lite = true,
+		.ops = &vfe_ops_780,
+	},
+};
+
+static const struct resources_icc icc_res_sm8550[] = {
+	{
+		.name = "cam_ahb",
+		.icc_bw_tbl.avg = 2097152,
+		.icc_bw_tbl.peak = 2097152,
+	},
+	{
+		.name = "cam_hf_0_mnoc",
+		.icc_bw_tbl.avg = 2097152,
+		.icc_bw_tbl.peak = 2097152,
+	},
+	{
+		.name = "cam_sf_0_mnoc",
+		.icc_bw_tbl.avg = 2097152,
+		.icc_bw_tbl.peak = 2097152,
+	},
+	{
+		.name = "cam_sf_icp_mnoc",
+		.icc_bw_tbl.avg = 2097152,
+		.icc_bw_tbl.peak = 2097152,
+	},
+};
+
 /*
  * camss_add_clock_margin - Add margin to clock frequency rate
  * @rate: Clock frequency rate
@@ -2182,6 +2513,19 @@ static const struct camss_resources sc8280xp_resources = {
 	.vfe_num = ARRAY_SIZE(vfe_res_sc8280xp),
 };
 
+static const struct camss_resources sm8550_resources = {
+	.version = CAMSS_8550,
+	.pd_name = "top",
+	.csiphy_res = csiphy_res_8550,
+	.csid_res = csid_res_8550,
+	.vfe_res = vfe_res_8550,
+	.icc_res = icc_res_sm8550,
+	.icc_path_num = ARRAY_SIZE(icc_res_sm8550),
+	.csiphy_num = ARRAY_SIZE(csiphy_res_8550),
+	.csid_num = ARRAY_SIZE(csid_res_8550),
+	.vfe_num = ARRAY_SIZE(vfe_res_8550),
+};
+
 static const struct of_device_id camss_dt_match[] = {
 	{ .compatible = "qcom,msm8916-camss", .data = &msm8916_resources },
 	{ .compatible = "qcom,msm8996-camss", .data = &msm8996_resources },
@@ -2189,6 +2533,7 @@ static const struct of_device_id camss_dt_match[] = {
 	{ .compatible = "qcom,sdm845-camss", .data = &sdm845_resources },
 	{ .compatible = "qcom,sm8250-camss", .data = &sm8250_resources },
 	{ .compatible = "qcom,sc8280xp-camss", .data = &sc8280xp_resources },
+	{ .compatible = "qcom,sm8550-camss", .data = &sm8550_resources },
 	{ }
 };
 
-- 
2.17.1


