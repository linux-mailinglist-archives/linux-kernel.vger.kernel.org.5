Return-Path: <linux-kernel+bounces-46291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0BA843D89
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DE1C292365
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F9A7AE7E;
	Wed, 31 Jan 2024 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D1/7/u8K"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C806C7A716;
	Wed, 31 Jan 2024 10:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706698731; cv=none; b=lUXcPfoLwdJpQMk5Tle3YbZtFl5lwIrTDKW8Pb1yYENygZt5MLmeKj4N3uGojAQOovP2MjUtvEsm/MaEGMfSdPZTTn2QzhGRL4tHKCEnU90oY/9L4CtxAdmCNKCsNjwjakDFzG5+H2rVR39rV3dhDaYSf+wsF/mQTUGn1WrXvZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706698731; c=relaxed/simple;
	bh=WV/fdPNH0Zy8bOz53st7fySCJAhuCz2uTpzOhf8G3XU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WcCRJMTABG7gL7HkH+AnVHqpwmVj/aiUA7DDrMcKHClRXV6VyfHkPOZXQ+s8YzbgpyorbdtzJOAxGHUQiqFi7GjqT+W5HAsz8xPhAfKdsr5Cl7kdVLKG+wVwvi0AL0pLEauBvhoOgW3ld0mXKCSez4l/tPqWsjXD/wcKV0EJ68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D1/7/u8K; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V77NN8028431;
	Wed, 31 Jan 2024 10:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=n1PwXNbOSzmmcOnrrXNWhBBczgfzE4P1QBgC2EhbCIs=; b=D1
	/7/u8KK+TkyObQveTkV62S3HtcgLCFQTijeUivHvEZWdJ/SKpFq8G/hE1lKzLGY2
	9ny45zMJ3ShI0OIeSSgXgi6b13z2I3hQyrSZ9q81o7Qv1OySooiCzRuqK2SPpYGg
	qCt+Tj7syx2DCIZRnCHh7kuoxn/GX6XHW0E17ARHcQBOHrcQri5l0oaasfnNBuK0
	ezkga+Rbx0XZtNC73KFVIzx+EX+Nn4TN9su+C29W8fkDeHzCCgkQnbwEuwqa37TX
	RbzNf8HgB0zKf9ZrSXjv2RvX62+x7NCbJzHxDQRnkWRJrVH6gJc7y88/XssvlkAG
	Enx7FiaEEADQbtEUt/rA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyfr30wkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 10:58:28 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40VAwR4w022367
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 10:58:27 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 31 Jan 2024 02:58:21 -0800
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <corbet@lwn.net>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <mathieu.poirier@linaro.org>, <vigneshr@ti.com>,
        <nm@ti.com>, <matthias.bgg@gmail.com>, <kgene@kernel.org>,
        <alim.akhtar@samsung.com>, <bmasney@redhat.com>
CC: <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mukesh Ojha
	<quic_mojha@quicinc.com>
Subject: [PATCH v8 05/10] init: export linux_banner data variable
Date: Wed, 31 Jan 2024 16:27:29 +0530
Message-ID: <20240131105734.13090-6-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.43.0.254.ga26002b62827
In-Reply-To: <20240131105734.13090-1-quic_mojha@quicinc.com>
References: <20240131105734.13090-1-quic_mojha@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YJiimOrgVkdV1Mv_l2_p1sZz8VpRKRPd
X-Proofpoint-ORIG-GUID: YJiimOrgVkdV1Mv_l2_p1sZz8VpRKRPd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_06,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401310083

Some debug loadable module like minidump is interested in knowing
the kernel version against which it is being build. Let's export
linux_banner.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
---
 include/linux/init.h     | 3 +++
 init/version-timestamp.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/init.h b/include/linux/init.h
index 58cef4c2e59a..d3d96188551c 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -145,6 +145,9 @@ extern char *saved_command_line;
 extern unsigned int saved_command_line_len;
 extern unsigned int reset_devices;
 
+/* Defined in init/version-timestamp.c */
+extern const char linux_banner[];
+
 /* used by init/main.c */
 void setup_arch(char **);
 void prepare_namespace(void);
diff --git a/init/version-timestamp.c b/init/version-timestamp.c
index 043cbf80a766..a48f2c19e5d7 100644
--- a/init/version-timestamp.c
+++ b/init/version-timestamp.c
@@ -6,6 +6,7 @@
 #include <linux/refcount.h>
 #include <linux/uts.h>
 #include <linux/utsname.h>
+#include <linux/init.h>
 
 struct uts_namespace init_uts_ns = {
 	.ns.count = REFCOUNT_INIT(2),
@@ -28,3 +29,4 @@ struct uts_namespace init_uts_ns = {
 const char linux_banner[] =
 	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
+EXPORT_SYMBOL_GPL(linux_banner);
-- 
2.43.0.254.ga26002b62827


