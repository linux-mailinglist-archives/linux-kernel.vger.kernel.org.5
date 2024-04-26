Return-Path: <linux-kernel+bounces-159518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7298B2FA7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F0A51F23C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9E013A271;
	Fri, 26 Apr 2024 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DIZtkY18"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FB81849;
	Fri, 26 Apr 2024 05:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714107934; cv=none; b=gJzsQpHJv0XoCtBB+Mtor/3VRZLYq/fbQ9jvKtng6+P3Ipva6G9OFY+liGLEPeCH9/9TQIUjrzRD1+0wCnfFM8hbt8oDYIFcdyAIKVnUIGn+fyjsEHNK57VXft364g+7BiNFmmVZ4vwnKX+1FszSoRm0QzJhIIUGOKuroFJ7g1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714107934; c=relaxed/simple;
	bh=nOVxA6EeiYfLAFMzqkem6m/lwzk/t4zAaDssFQ7c9Us=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ql/FAaqCK1qsKb3DMlAMw7UgnRK8rvyfS56Fwdco7YLHASo78cEegUiW7F2dcWSTcOGVlqkDtvxdE8NcK1YstRFsgaiXEyCAYfuzPcj5UcpH58doov5MpUmsAmy5K1YSvn77B2s6bIkIsM0gk1zxw20czzUP5Wxl3Ggwy1xZ5Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DIZtkY18; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43Q4mKcX007401;
	Fri, 26 Apr 2024 05:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=2ZOSleS
	xTGihvmq3TTCFiDPOSWhrXdviz5IBrw9JSPU=; b=DIZtkY18+zRUYK5uuWJaJ1l
	Q1C02NRpP6T5LyQ3k6Y/CZznQPn14t0YF7qXTKfSowJBZKaTouucJg1hHwdVRJD4
	lYK7iqX6/pdfSIWIPpnWyu0P2Rv47cYlk3Si5bnhO4UOhsXGXhLLvRV2EqvTw+C1
	QF05/HK4BSSFB7boKKCrF6v5av8orUvq0oupHMm2XrhE8e3HbguJNRVTjWsRCH22
	V02mHhpnSaiNb2UWp+FgTWCJdDIO6p+DX5pRP+Baw2AC/HQL9HmHdKzJls8+SJnr
	+1bL65Ms6WfIoCPX6klJ/LOy016hbmWdzHjWN41DOikJVtgXfc74JCEDseaAk9Q=
	=
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xr1ne8hxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:05:26 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43Q55P9v023284
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 26 Apr 2024 05:05:25 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 25 Apr 2024 22:05:22 -0700
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen
	<Thinh.Nguyen@synopsys.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_ppratap@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati
	<quic_kriskura@quicinc.com>,
        Johan Hovold <johan@kernel.org>, "kernel test
 robot" <lkp@intel.com>
Subject: [PATCH] usb: dwc3: core: Fix compile warning on s390 gcc in dwc3_get_phy call
Date: Fri, 26 Apr 2024 10:35:12 +0530
Message-ID: <20240426050512.57384-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7G2Kczhh-2SphlUPwcMmXhJ5CTw5y7O5
X-Proofpoint-GUID: 7G2Kczhh-2SphlUPwcMmXhJ5CTw5y7O5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_05,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=850 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404260030

Recent commit introduced support for reading Multiport PHYs and
while doing so iterated over an integer variable which runs from
[0-254] in the worst case scenario. But S390 compiler treats it as a
warning and complains that the integer write to string can go to 11
characters. Fix this by modifying iterator variable to u8.

Suggested-by: Johan Hovold <johan@kernel.org>
Fixes: 30a46746ca5a ("usb: dwc3: core: Refactor PHY logic to support Multiport Controller")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404241215.Mib19Cu7-lkp@intel.com/
Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/dwc3/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 4dc6fc79c6d9..719305ab86c0 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1449,7 +1449,7 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 	struct device_node	*node = dev->of_node;
 	char phy_name[9];
 	int ret;
-	int i;
+	u8 i;
 
 	if (node) {
 		dwc->usb2_phy = devm_usb_get_phy_by_phandle(dev, "usb-phy", 0);
@@ -1479,7 +1479,7 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 		if (dwc->num_usb2_ports == 1)
 			snprintf(phy_name, sizeof(phy_name), "usb2-phy");
 		else
-			snprintf(phy_name, sizeof(phy_name),  "usb2-%d", i);
+			snprintf(phy_name, sizeof(phy_name),  "usb2-%u", i);
 
 		dwc->usb2_generic_phy[i] = devm_phy_get(dev, phy_name);
 		if (IS_ERR(dwc->usb2_generic_phy[i])) {
@@ -1496,7 +1496,7 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 		if (dwc->num_usb3_ports == 1)
 			snprintf(phy_name, sizeof(phy_name), "usb3-phy");
 		else
-			snprintf(phy_name, sizeof(phy_name), "usb3-%d", i);
+			snprintf(phy_name, sizeof(phy_name), "usb3-%u", i);
 
 		dwc->usb3_generic_phy[i] = devm_phy_get(dev, phy_name);
 		if (IS_ERR(dwc->usb3_generic_phy[i])) {
-- 
2.34.1


