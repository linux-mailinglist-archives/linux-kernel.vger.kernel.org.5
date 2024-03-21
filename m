Return-Path: <linux-kernel+bounces-110509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7488A885FE7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A12B28417D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8014885938;
	Thu, 21 Mar 2024 17:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n7dimlnn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565828E7;
	Thu, 21 Mar 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042690; cv=none; b=joj9k+72Sz1e24/H8ERYiv9cKW0JOMyGe+rBbmr7Nr2e2tu0ZeqgKurDIXjeY4aSX0ah8xvyC5k9Z8H+J/91UgG8baBPMGi0UQrWHO35XNeLKWwP3dAwjkW703pBRDyeI1KY/8Wef14+O0ososxnlT+wicZmVe3tHGYY8+AcaFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042690; c=relaxed/simple;
	bh=81RETnleRK3KzW4DdP8dvY6vXve5N8hXDGma1aPU8bk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rcy9HmklSpRQv7o6bt69HNFT+2030HcGoAHY22I1fziCSfvsBSnUVeKYUTHOSTMCUzQluKUXQnOrMyCIBjws2qhNMdgPKDHj3TbFmPAyPJ6Q5yIBp3XVA36GpLWzMV/Iz+Xcicr9kvsEbPsWXrn3fgEXVQJimIeOlJlC9mt+eKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n7dimlnn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LAgtBk021280;
	Thu, 21 Mar 2024 17:38:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	qcppdkim1; bh=wxk934c+KKjtUvRTg1ca/ZYYS/iTahoKBSELgInNPuM=; b=n7
	dimlnnwfwP+NJU3ujUXe4picMDz9DGIXOVBf+kfjNlgP/3mofnh3wchb02gSF8B6
	as748FHwY2DDzpPW98VTRgo7UAW/YH8KjmbVpZDNPQXezL9MgNjruShJIeHqvYPM
	GcXsRaR1Z/hop6BsE/qxitlaV1N95Q6EUwHQZ95eZMi0mrV1EvZptKBpgtw4W7xQ
	RqS2FOW1B8CFeVepbFzwYeYdg/uhsYRgSpkoKWrpqAXq0eQMzhbFL9NeM1FaqD9P
	oDmSUFMi4xIZx6k6KwqwbLjtiHc0MdOIKrNr2scYigK6uGXJA6VPJtkMNG91PPlA
	kXwiOcch2Re6uIAlQRGQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x0fa7hnyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 17:38:00 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42LHbxKY022396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 17:37:59 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Mar 2024 10:37:57 -0700
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <andersson@kernel.org>, <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mukesh
 Ojha" <quic_mojha@quicinc.com>,
        Poovendhan Selvaraj
	<quic_poovendh@quicinc.com>
Subject: [PATCH v13] firmware: qcom: scm: Modify only the download bits in TCSR register
Date: Thu, 21 Mar 2024 23:07:35 +0530
Message-ID: <1711042655-31948-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mOn9i1qV9O3J-lZccpoi_KoNm_YSsYGQ
X-Proofpoint-ORIG-GUID: mOn9i1qV9O3J-lZccpoi_KoNm_YSsYGQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 clxscore=1015
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403210128

Crashdump collection is done based on DLOAD bits of TCSR register.
To retain other bits, scm driver need to read the register and
modify only the DLOAD bits, as other bits in TCSR may have their
own significance.

Co-developed-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com> # IPQ9574 and IPQ5332
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
---
This patch should be applied on top of below series
https://lore.kernel.org/lkml/1711034642-22860-1-git-send-email-quic_mojha@quicinc.com/


Changes in v13:
 - Removed the usage of exported qcom_scm_io_rmw() and kept it static.
 - Kept the T-by and R-by tag as there is not much change in the approach.

 v12:

 https://lore.kernel.org/lkml/20240227155308.18395-3-quic_mojha@quicinc.com/
 https://lore.kernel.org/lkml/ncyanjtxtqyx236d5tfm46nepvy6ncxikonc6g6hlddhx2joee@jqjhfxtu3sr6/

 All the past v1 to v12 can be found in below link cover-letter.
 - https://lore.kernel.org/lkml/20240227155308.18395-1-quic_mojha@quicinc.com/

 drivers/firmware/qcom/qcom_scm.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index f014a934a603..70775ead1508 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -4,6 +4,8 @@
  */
 
 #include <linux/arm-smccc.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -114,6 +116,10 @@ static const u8 qcom_scm_cpu_warm_bits[QCOM_SCM_BOOT_MAX_CPUS] = {
 #define QCOM_SMC_WAITQ_FLAG_WAKE_ONE	BIT(0)
 #define QCOM_SMC_WAITQ_FLAG_WAKE_ALL	BIT(1)
 
+#define QCOM_DLOAD_MASK		GENMASK(5, 4)
+#define QCOM_DLOAD_NODUMP	0
+#define QCOM_DLOAD_FULLDUMP	1
+
 static const char * const qcom_scm_convention_names[] = {
 	[SMC_CONVENTION_UNKNOWN] = "unknown",
 	[SMC_CONVENTION_ARM_32] = "smc arm 32",
@@ -493,13 +499,29 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
 	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
 }
 
+static int qcom_scm_io_rmw(phys_addr_t addr, unsigned int mask, unsigned int val)
+{
+	unsigned int old;
+	unsigned int new;
+	int ret;
+
+	ret = qcom_scm_io_readl(addr, &old);
+	if (ret)
+		return ret;
+
+	new = (old & ~mask) | (val & mask);
+
+	return qcom_scm_io_writel(addr, new);
+}
+
 static void qcom_scm_set_download_mode(bool enable)
 {
+	u32 val = enable ? QCOM_DLOAD_FULLDUMP : QCOM_DLOAD_NODUMP;
 	int ret = 0;
 
 	if (__scm->dload_mode_addr) {
-		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
-					 enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
+		ret = qcom_scm_io_rmw(__scm->dload_mode_addr, QCOM_DLOAD_MASK,
+				      FIELD_PREP(QCOM_DLOAD_MASK, val));
 	} else if (__qcom_scm_is_call_available(__scm->dev, QCOM_SCM_SVC_BOOT,
 						QCOM_SCM_BOOT_SET_DLOAD_MODE)) {
 		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
-- 
2.7.4


