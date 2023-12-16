Return-Path: <linux-kernel+bounces-1897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D4A815572
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C31DA1C24836
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8173B3D0CA;
	Sat, 16 Dec 2023 00:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JCfeh98Q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1FF37D20;
	Sat, 16 Dec 2023 00:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BFNYWWb005842;
	Sat, 16 Dec 2023 00:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=dyB/ua3LVYneyuF6Yg+6NdNcj7CDy3ND+aki9ubcU9M
	=; b=JCfeh98QyKrD5I5NXZos1zEOUGTG0RwdUWMQmi9xjI2WeZzH2FedCu9SATv
	+qXxwn+D0pM5erkN3+9nQf/7TXgP8RKAIWJtA6k8mi3tRFdI0ddaaNYspzHmny9u
	alpzK9FCYqIKxpiyHEW97JdEXoJu4I0kZ+tUS+gFmQxWbdUJHcG6MlYrX5W/aPOQ
	H+yRspTzK+Qfn5nxXDBjisyuzCrdAlOFcOYgKw8R+0fdgptkTNc/y0JnrV33faUq
	k5+x1r/M8UdjacymdK3EWiXFn4CVVZGjPY9pyZWuFRXGSWmsOyhInSZ2a+4u6jye
	JPqwDYp9lD/P0dT3rAQdN2fCItg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v0k90t5er-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:19 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BG0LJEp005053
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Dec 2023 00:21:19 GMT
Received: from [169.254.0.1] (10.49.16.6) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 15 Dec
 2023 16:21:18 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
Date: Fri, 15 Dec 2023 16:21:11 -0800
Subject: [PATCH RFC v15 30/30] MAINTAINERS: Add Gunyah hypervisor drivers
 section
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231215-gunyah-v15-30-192a5d872a30@quicinc.com>
References: <20231215-gunyah-v15-0-192a5d872a30@quicinc.com>
In-Reply-To: <20231215-gunyah-v15-0-192a5d872a30@quicinc.com>
To: Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri
	<quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu
	<quic_pheragu@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Fuad
 Tabba" <tabba@google.com>,
        Sean Christopherson <seanjc@google.com>
CC: <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Elliot Berman
	<quic_eberman@quicinc.com>
X-Mailer: b4 0.13-dev
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DT_YwXeEHE8MiOYixEiRS891fRU6M1qa
X-Proofpoint-GUID: DT_YwXeEHE8MiOYixEiRS891fRU6M1qa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 mlxlogscore=854 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312160001

Add myself and Prakruthi as maintainers of Gunyah hypervisor drivers.

Reviewed-by: Alex Elder <elder@linaro.org>
Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>
---
 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b589218605b4..fa2fe28f922f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9251,6 +9251,19 @@ L:	linux-efi@vger.kernel.org
 S:	Maintained
 F:	block/partitions/efi.*
 
+GUNYAH HYPERVISOR DRIVER
+M:	Elliot Berman <quic_eberman@quicinc.com>
+M:	Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
+L:	linux-arm-msm@vger.kernel.org
+S:	Supported
+F:	Documentation/devicetree/bindings/firmware/gunyah-hypervisor.yaml
+F:	Documentation/virt/gunyah/
+F:	arch/arm64/gunyah/
+F:	drivers/mailbox/gunyah-msgq.c
+F:	drivers/virt/gunyah/
+F:	include/linux/gunyah*.h
+F:	samples/gunyah/
+
 HABANALABS PCI DRIVER
 M:	Oded Gabbay <ogabbay@kernel.org>
 L:	dri-devel@lists.freedesktop.org

-- 
2.43.0


