Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7492178B1DA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbjH1Nbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbjH1Nb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:31:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9BCB9;
        Mon, 28 Aug 2023 06:31:24 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37SBGGxn029491;
        Mon, 28 Aug 2023 13:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=Zvk+0yqcW0+tIVhSR4EVhIcKbNFO/itO/fFAjY/hjGQ=;
 b=IVXZSw+KD559P3Fn/gpOKcOY/LxMwcW4ndVumvgilCQREW8DDAi68U5f838h7I/zZtad
 wXYO6a3lJxJOSKauXvpQ7rr+G8cw1b5CtazQWG7iCYb22MURXCDacXKrurQC46cyhA5Z
 xchgLR/WiWSsRwit5Zj47+jNXs+T09kpv1sLy6y5YMOGxYPE9Gv+YA4maGhMdy/1qADy
 rCE8N+L5em5Nhc/ZTg+Jrl2pKsgGRcaMFbgXA/ne0coyJOB2hKZTi9m2yb9At+eTp/ew
 i0PHmq+cz3oMgBCNXh5lMspYlQo2qI74bMZIe+lUWJHF6+xFR7gTlbVLxz0ror18R43j fw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3srt8s09cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:31:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37SDVALM012914
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 13:31:10 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 28 Aug 2023 06:31:03 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <quic_pkondeti@quicinc.com>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, <ahalaney@redhat.com>,
        <quic_shazhuss@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v11 03/13] usb: xhci: Move extcaps related macros to respective header file
Date:   Mon, 28 Aug 2023 19:00:23 +0530
Message-ID: <20230828133033.11988-4-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230828133033.11988-1-quic_kriskura@quicinc.com>
References: <20230828133033.11988-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HdgUPWm1pS8iKjFntaXdgn5EwFeX6cbW
X-Proofpoint-GUID: HdgUPWm1pS8iKjFntaXdgn5EwFeX6cbW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-28_10,2023-08-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=902 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308280118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DWC3 driver needs access to XHCI Extended Capabilities registers to
read number of usb2 ports and usb3 ports present on multiport controller.
Since the extcaps header is sufficient to parse this info, move port_count
related macros and structure from xhci.h to xhci-ext-caps.h.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/host/xhci-ext-caps.h | 27 +++++++++++++++++++++++++++
 drivers/usb/host/xhci.h          | 27 ---------------------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/host/xhci-ext-caps.h b/drivers/usb/host/xhci-ext-caps.h
index e8af0a125f84..96eb36a58738 100644
--- a/drivers/usb/host/xhci-ext-caps.h
+++ b/drivers/usb/host/xhci-ext-caps.h
@@ -79,6 +79,33 @@
 /* true: Controller Not Ready to accept doorbell or op reg writes after reset */
 #define XHCI_STS_CNR		(1 << 11)
 
+/**
+ * struct xhci_protocol_caps
+ * @revision:		major revision, minor revision, capability ID,
+ *			and next capability pointer.
+ * @name_string:	Four ASCII characters to say which spec this xHC
+ *			follows, typically "USB ".
+ * @port_info:		Port offset, count, and protocol-defined information.
+ */
+struct xhci_protocol_caps {
+	u32	revision;
+	u32	name_string;
+	u32	port_info;
+};
+
+#define	XHCI_EXT_PORT_MAJOR(x)	(((x) >> 24) & 0xff)
+#define	XHCI_EXT_PORT_MINOR(x)	(((x) >> 16) & 0xff)
+#define	XHCI_EXT_PORT_PSIC(x)	(((x) >> 28) & 0x0f)
+#define	XHCI_EXT_PORT_OFF(x)	((x) & 0xff)
+#define	XHCI_EXT_PORT_COUNT(x)	(((x) >> 8) & 0xff)
+
+#define	XHCI_EXT_PORT_PSIV(x)	(((x) >> 0) & 0x0f)
+#define	XHCI_EXT_PORT_PSIE(x)	(((x) >> 4) & 0x03)
+#define	XHCI_EXT_PORT_PLT(x)	(((x) >> 6) & 0x03)
+#define	XHCI_EXT_PORT_PFD(x)	(((x) >> 8) & 0x01)
+#define	XHCI_EXT_PORT_LP(x)	(((x) >> 14) & 0x03)
+#define	XHCI_EXT_PORT_PSIM(x)	(((x) >> 16) & 0xffff)
+
 #include <linux/io.h>
 
 /**
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 7e282b4522c0..77016338bee1 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -558,33 +558,6 @@ struct xhci_doorbell_array {
 #define DB_VALUE(ep, stream)	((((ep) + 1) & 0xff) | ((stream) << 16))
 #define DB_VALUE_HOST		0x00000000
 
-/**
- * struct xhci_protocol_caps
- * @revision:		major revision, minor revision, capability ID,
- *			and next capability pointer.
- * @name_string:	Four ASCII characters to say which spec this xHC
- *			follows, typically "USB ".
- * @port_info:		Port offset, count, and protocol-defined information.
- */
-struct xhci_protocol_caps {
-	u32	revision;
-	u32	name_string;
-	u32	port_info;
-};
-
-#define	XHCI_EXT_PORT_MAJOR(x)	(((x) >> 24) & 0xff)
-#define	XHCI_EXT_PORT_MINOR(x)	(((x) >> 16) & 0xff)
-#define	XHCI_EXT_PORT_PSIC(x)	(((x) >> 28) & 0x0f)
-#define	XHCI_EXT_PORT_OFF(x)	((x) & 0xff)
-#define	XHCI_EXT_PORT_COUNT(x)	(((x) >> 8) & 0xff)
-
-#define	XHCI_EXT_PORT_PSIV(x)	(((x) >> 0) & 0x0f)
-#define	XHCI_EXT_PORT_PSIE(x)	(((x) >> 4) & 0x03)
-#define	XHCI_EXT_PORT_PLT(x)	(((x) >> 6) & 0x03)
-#define	XHCI_EXT_PORT_PFD(x)	(((x) >> 8) & 0x01)
-#define	XHCI_EXT_PORT_LP(x)	(((x) >> 14) & 0x03)
-#define	XHCI_EXT_PORT_PSIM(x)	(((x) >> 16) & 0xffff)
-
 #define PLT_MASK        (0x03 << 6)
 #define PLT_SYM         (0x00 << 6)
 #define PLT_ASYM_RX     (0x02 << 6)
-- 
2.40.0

