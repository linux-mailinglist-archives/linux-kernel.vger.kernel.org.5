Return-Path: <linux-kernel+bounces-27060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A68A982E9D8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E441F22080
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 07:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E9710A26;
	Tue, 16 Jan 2024 07:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cwLfs2F7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABF910A1E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40G5Nsi3002596;
	Tue, 16 Jan 2024 07:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id; s=qcppdkim1; bh=DX0iy88vX98i
	AdSdT71f27IKRMC90HatYQ5HwImfRkg=; b=cwLfs2F7F4ylLd6Pnze4qC8nGPlx
	7bI7W+Q6L2XEz/hQu265xrvBVV4PH7fMZ6CbbPh7lFMw+4OfRAPD6qtfjEDImMnC
	sV4cVWaOs0mPpuLaltmSuAwYe0W0SmjkLYWNxkEYAvp1FE0CrLCvRzRXP3FclJgC
	gNU++0Gw0fRX1H50ouCR24rJjFJVPs3es/UWwGkaR7+BtPlo8szchZAENFqoNgKt
	0heTo1rcJWlwQZjdN1l5KYhY/SZZDkARa29m2muJ8LRclDD3UOnYq+JuWM7cLApr
	da+Rln4HcgJpdi358Vi+gpRvdCiTB8jFjVrZZc8T0YwOMRG0PiXKahWB+A==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnht90ck5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jan 2024 07:18:24 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 40G7EQqQ019314;
	Tue, 16 Jan 2024 07:18:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 3vkkkkm222-1;
	Tue, 16 Jan 2024 07:18:20 +0000
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 40G7IKnO024252;
	Tue, 16 Jan 2024 07:18:20 GMT
Received: from hu-maiyas-hyd.qualcomm.com (hu-riteshk-hyd.qualcomm.com [10.147.241.247])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTP id 40G7IKgI024251;
	Tue, 16 Jan 2024 07:18:20 +0000
Received: by hu-maiyas-hyd.qualcomm.com (Postfix, from userid 2314801)
	id 776E0601955; Tue, 16 Jan 2024 12:48:19 +0530 (+0530)
From: Ritesh Kumar <quic_riteshk@quicinc.com>
To: neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, sam@ravnborg.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        quic_abhinavk@quicinc.com, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com
Cc: Ritesh Kumar <quic_riteshk@quicinc.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: novatek-nt36672e: Include <linux/of.h>
Date: Tue, 16 Jan 2024 12:48:03 +0530
Message-Id: <20240116071803.5264-1-quic_riteshk@quicinc.com>
X-Mailer: git-send-email 2.17.1
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9LspsGzdeywBkRaxqILt1OLL_DDjq1qm
X-Proofpoint-GUID: 9LspsGzdeywBkRaxqILt1OLL_DDjq1qm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401160055
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Include <linux/of.h> instead of <linux/of_device.h> to fix
below compilation errors:

drivers/gpu/drm/panel/panel-novatek-nt36672e.c:564:14: error: implicit declaration of function 'of_device_get_match_data'
  ctx->desc = of_device_get_match_data(dev);
              ^
drivers/gpu/drm/panel/panel-novatek-nt36672e.c:622:34: error: array type has incomplete element type 'struct of_device_id'
 static const struct of_device_id nt36672e_of_match[] = {
                                  ^

Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>

---
In the patch https://lore.kernel.org/all/20231129164316.2663565-1-robh@kernel.org/,
include of <linux/of.h> from of_device.h was removed. This change was not present
in my local build resulting in successful compilation while posting
https://lore.kernel.org/all/20240108095902.22725-3-quic_riteshk@quicinc.com/.
---
 drivers/gpu/drm/panel/panel-novatek-nt36672e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
index d4e85c2fc899..cb7406d74466 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
@@ -4,7 +4,7 @@
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
 #include <drm/drm_mipi_dsi.h>
-- 
2.17.1


