Return-Path: <linux-kernel+bounces-49282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4CA84682F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FA51F22765
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C19D1803D;
	Fri,  2 Feb 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OUIOEuCO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797E18026;
	Fri,  2 Feb 2024 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856065; cv=none; b=q6pDRFYc4345eTasuHNjVj4g7UWcmmtx9Zbp1YvU3QfLVAj04gaRbjNkTks5DQcfI3mwNUFs4/2J2IgYo1ZCzuOJhOD2Rx8b9hvO/2QEdaI3/sq5Qcxcyj1YV9GuMvTf9EpjhtxBpjpFjBT8r4Tx5k0qtpv9F/R4gA9UDFeR57A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856065; c=relaxed/simple;
	bh=UyzhH5dir1DGPXoMaktPym+zMHTmhgmj4z4SIuQ9gw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vo2F7rM6fTfUVi3Xk35SraUMU2e56Pb2JY/m3m/uKufL6BlUrJONV0zQIdIf3F4K71snENTXGCPdNxhQA4v6t4f78jumig3mD11YU9ccXull/bLTq4bnxd1O2TDvkZamG+PX3qvfMM4mn7Oz0hzueqDbOn4kvEvZHBnQ+70eQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OUIOEuCO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4124C2BA011810;
	Fri, 2 Feb 2024 06:41:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=qcppdkim1; bh=i76Yi8m96sprBRJec6bt
	Nir7FxuxNQ50HS8A/sQSrag=; b=OUIOEuCOAEr8Jnl7X1qRIi9pTsskaJSuporr
	K4UtA9lqugR8+hHMuYetFSdgluqK7758fH2mVn6nEnLWtM1/OU2kVdhY8x5Ok9mL
	IWCVTy0zBCnhlXR5Z7YRRVps9p94yxZ+EIp3FZd6rDm5Wfp1+L8iQg7wyvCBkCTc
	9JOB+2tHX7GBtSrOLVHHi8k+l8JKxPwNE4RmjV3cZDzs0sm82Yl2PNPiZzvo4fMx
	A1gBOYH5l5RjYiEuwYS728VBVD21aDK1+OjcZRaDlSqqsXp4ZdlOkj2mYG9Jnec1
	YyySWj6fOt3L5AJU61gYfHG+csI2I1hccqikfeeXGsLIuR9a9g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu1rnd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 06:41:01 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4126f0Ql027239
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 06:41:00 GMT
Received: from hu-ekangupt-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 22:40:58 -0800
From: Ekansh Gupta <quic_ekangupt@quicinc.com>
To: <srinivas.kandagatla@linaro.org>, <linux-arm-msm@vger.kernel.org>
CC: <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 05/16] misc: fastrpc: Add CRC support for remote buffers
Date: Fri, 2 Feb 2024 12:10:28 +0530
Message-ID: <20240202064039.15505-6-quic_ekangupt@quicinc.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
References: <20240202064039.15505-1-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WCSlZx4IKL-cxzVI0zBdT2URgac4Mnq3
X-Proofpoint-ORIG-GUID: WCSlZx4IKL-cxzVI0zBdT2URgac4Mnq3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 malwarescore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020047

CRC check for input and output argument helps in ensuring data
consistency over a remote call. If user intends to enable CRC check,
first local user CRC is calculated at user end and a CRC buffer is
passed to DSP to capture remote CRC values. DSP is expected to
write to the remote CRC buffer which is then compared at user level
with the local CRC values.

Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
---
 drivers/misc/fastrpc.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index a7e959beabd4..a1b910459a90 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -639,6 +639,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
 	/* Released in fastrpc_context_put() */
 	fastrpc_channel_ctx_get(cctx);
 
+	ctx->crc = (u32 *)(uintptr_t)invoke->crc;
 	ctx->sc = sc;
 	ctx->retval = -1;
 	ctx->pid = current->pid;
@@ -1095,6 +1096,7 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	struct fastrpc_invoke_buf *list;
 	struct fastrpc_phy_page *pages;
 	u64 *fdlist;
+	u32 *crclist;
 	int i, inbufs, outbufs, handles;
 
 	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
@@ -1102,7 +1104,8 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 	handles = REMOTE_SCALARS_INHANDLES(ctx->sc) + REMOTE_SCALARS_OUTHANDLES(ctx->sc);
 	list = fastrpc_invoke_buf_start(rpra, ctx->nscalars);
 	pages = fastrpc_phy_page_start(list, ctx->nscalars);
-	fdlist = (uint64_t *)(pages + inbufs + outbufs + handles);
+	fdlist = (u64 *)(pages + inbufs + outbufs + handles);
+	crclist = (u32 *)(fdlist + FASTRPC_MAX_FDLIST);
 
 	for (i = inbufs; i < ctx->nbufs; ++i) {
 		if (!ctx->maps[i]) {
@@ -1127,6 +1130,11 @@ static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
 			fastrpc_map_put(mmap);
 	}
 
+	if (ctx->crc && crclist && rpra) {
+		if (copy_to_user((void __user *)ctx->crc, crclist,
+				FASTRPC_MAX_CRCLIST * sizeof(u32)))
+			return -EFAULT;
+	}
 	return 0;
 }
 
@@ -1834,6 +1842,7 @@ static int fastrpc_multimode_invoke(struct fastrpc_user *fl, char __user *argp)
 
 	switch (invoke.req) {
 	case FASTRPC_INVOKE:
+	case FASTRPC_INVOKE_ENHANCED:
 		/* nscalars is truncated here to max supported value */
 		if (copy_from_user(&einv, (void __user *)(uintptr_t)invoke.invparam,
 				   invoke.size))
-- 
2.17.0


