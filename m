Return-Path: <linux-kernel+bounces-165943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BFA8B93AB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 05:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73F5E1C2142A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 03:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF4C1A702;
	Thu,  2 May 2024 03:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AWCWmjPk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70807171AA;
	Thu,  2 May 2024 03:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714621389; cv=none; b=nX/ycGQP8560fJuDS7bjhflOq2fQ1oHJrleqWNszmLEV3XITX/H+iySUFGQPQxkYSl0taoDCcOL/adBxnr1SE+NHFU+pjvMwNYvXJQGTQ9B2DeKNsz4MDEB3tNPk5MfG1fCkhXuFgLorK5kIUQd4gt62FAl/JodR16LP6R7sLOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714621389; c=relaxed/simple;
	bh=tmsjShpqsEq0HAAjahxF2xhs/w2jg75Ng8GplS2wmuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bgBGLndnch9r6a3fX+khphnuOXWhI8MTKtdh5ePeUJGUFqMxIED3JI4AhA8ozAIpEjfaSF4uQnoOnhPGwFtB3jMNOj7jC0PQ94OaHrjxwZoLlr2M3C3cUbchVnqn5y2e5Or/r97TcC1SWUmE0TX81/x+86EmGKovo6KmmwfXLZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AWCWmjPk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4423cqWZ024441;
	Thu, 2 May 2024 03:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=qcppdkim1; bh=gxdEopZ/Ro0CDr4L5WL6
	Rzvof/Wduh9C1em6P9/T0vs=; b=AWCWmjPkN7mZOiBLNxh9xZkzEXxlr7/360O7
	9/yb4HMhHlUk34p2tWHTvwTIXjcgjwHwMsF0W7qIJyugEMoBQoNT3ijQxxgWEwp3
	VDNO7bBPESngmYUeI3S9H4rU9J2h5VAw9UnV7VUMQPbX18nR5EBK/G4Xz1WasLDL
	Mj0FMAmrHd8em6GRwRJc1+Vo5HK1atyIyyhiXGbIY7/Yw1Rb/rUQAH7nHo9nS/5c
	Wud0jcWMu7Jzroe1bkEafJcQNMKbcZOJxeF1v95r8dr5XAha0spxr1U8cbt7NHDO
	6zHr6gKeYGA2ojNB666aJGUOXOhCcQT3rFXYpTgJul3WLC4aBw==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xud76adtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 03:43:02 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 4423gxGx005872;
	Thu, 2 May 2024 03:42:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 3xv1t60e4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 03:42:59 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4423gxDU005867;
	Thu, 2 May 2024 03:42:59 GMT
Received: from hu-devc-blr-u22-a.qualcomm.com (hu-mdalam-blr.qualcomm.com [10.131.36.157])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4423gxA8005862
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 03:42:59 +0000
Received: by hu-devc-blr-u22-a.qualcomm.com (Postfix, from userid 466583)
	id 47C234127E; Thu,  2 May 2024 09:12:58 +0530 (+0530)
From: Md Sadre Alam <quic_mdalam@quicinc.com>
To: mturquette@baylibre.com, sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com, quic_varada@quicinc.com
Cc: quic_mdalam@quicinc.com
Subject: [PATCH] clk: qcom: gcc-ipq9574: Add BRANCH_HALT_VOTED flag
Date: Thu,  2 May 2024 09:12:47 +0530
Message-Id: <20240502034247.2621996-1-quic_mdalam@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: zATVBlhobrCKXkkuarJ1tPcnhUf3XnL6
X-Proofpoint-GUID: zATVBlhobrCKXkkuarJ1tPcnhUf3XnL6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 clxscore=1011 bulkscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2405020015

Add BRANCH_HALT_VOTED flag to inform clock framework
don't check for CLK_OFF bit.

CRYPTO_AHB_CLK_ENA and CRYPTO_AXI_CLK_ENA enable bit is
present in other VOTE registers also, like TZ.
If anyone else also enabled this clock, even if we turn
off in GCC_APCS_CLOCK_BRANCH_ENA_VOTE | 0x180B004, it won't
turn off.

Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
---
 drivers/clk/qcom/gcc-ipq9574.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
index 0a3f846695b8..f8b9a1e93bef 100644
--- a/drivers/clk/qcom/gcc-ipq9574.c
+++ b/drivers/clk/qcom/gcc-ipq9574.c
@@ -2140,9 +2140,10 @@ static struct clk_rcg2 pcnoc_bfdcd_clk_src = {
 
 static struct clk_branch gcc_crypto_axi_clk = {
 	.halt_reg = 0x16010,
+	.halt_check = BRANCH_HALT_VOTED,
 	.clkr = {
-		.enable_reg = 0x16010,
-		.enable_mask = BIT(0),
+		.enable_reg = 0xb004,
+		.enable_mask = BIT(15),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_crypto_axi_clk",
 			.parent_hws = (const struct clk_hw *[]) {
@@ -2156,9 +2157,10 @@ static struct clk_branch gcc_crypto_axi_clk = {
 
 static struct clk_branch gcc_crypto_ahb_clk = {
 	.halt_reg = 0x16014,
+	.halt_check = BRANCH_HALT_VOTED,
 	.clkr = {
-		.enable_reg = 0x16014,
-		.enable_mask = BIT(0),
+		.enable_reg = 0xb004,
+		.enable_mask = BIT(16),
 		.hw.init = &(const struct clk_init_data) {
 			.name = "gcc_crypto_ahb_clk",
 			.parent_hws = (const struct clk_hw *[]) {
-- 
2.34.1


