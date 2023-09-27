Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199197AFB40
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjI0Gnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjI0Gng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:43:36 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28059F4;
        Tue, 26 Sep 2023 23:43:35 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R5nPjR010615;
        Wed, 27 Sep 2023 06:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : subject :
 date : message-id : mime-version : content-type :
 content-transfer-encoding : to : cc; s=qcppdkim1;
 bh=hNBJJmbBpAYvrY4LaMiKewOmArBoB7dabJIZbpjgBhU=;
 b=iggL3OTSYQC9jEDyQ2y2hONiiGph5Jg/jSk17n2aQYVHL0WLyDWsZ5k2JDR7rRX53f6B
 c8K22DEZ8sIx3vAP8p717e+Iw4PKxfg6/9RSAAHaFyGW97YZAj9rMGKL8Nc9+R2Hod5E
 ByOn9vUG2u0XFYW6xyI2zrVbD2/1fxY+5b7vTqCIoIBvSqxeEKcHUhxpo8T8R1ZgSsym
 dsZ0mRc3a4Xf53vuSKRn4Rjw4fUy+SUPAkVmktpWN9IhE4Xi0ZD+UoMwSy8ZERy0s+hI
 srAqxJ48FdwH63mYn2CU2oLjZhjPyaYfHeZTq9Pgw1D9N9gQcVppUyB6rSRnKqH9pLju XQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc5hc0y90-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:43:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R6hUXk031664
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:43:30 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Tue, 26 Sep 2023 23:43:26 -0700
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Subject: [PATCH v3 0/2] Add common RDP dtsi file for IPQ9574
Date:   Wed, 27 Sep 2023 12:13:17 +0530
Message-ID: <20230927-common-rdp-v3-0-3d07b3ff6d42@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAXPE2UC/0WNQQrDIBRErxJc9wc1DWJXvUcpxZhvdaGm36QUQ
 u5e7aYwi3kMM7OzghSwsEu3M8J3KCGnCsOpY9ab9EQIc2UmuRy4lgpsjjEnoHmBUTrN3VylFKu
 FyRSEiUyyvlWiKStSCxZCFz6/l9u9sqMcYfWE5r+txCD4qLnuxVlyDQJeW7APk7bizbX5kGxf3
 9lxfAHDeX67tgAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Anusha Rao <quic_anusha@quicinc.com>,
        Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695797006; l=1825;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=byy6280lYDSJfrolP4cJDoEKRYE3BKOLgzskFRP9tiA=;
 b=xJsEDIRsBsvicefRCJYIZh1cA1ofVJ46cg9Ozjc0nptjkgCiWoKICzErDKDLZsLu2kYYcLr7M
 JskkJ3aQ+GnBODGag2Mt2jRFVB4CHsCLmedvGENDXmrlrAoNBYCPZeJ
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: u6XfVUkI6gt4gSZQIJcX_QeWjRATPa_f
X-Proofpoint-GUID: u6XfVUkI6gt4gSZQIJcX_QeWjRATPa_f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 mlxlogscore=427
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270056
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some interfaces are common across RDPs. Move the common nodes to
ipq9574-rdp-common.dtsi like how it is done for IPQ5332. Use rdp specific
dts file to include interfaces that vary across RDPs. For instance, IPQ9574
has 4 PCIE controllers. RDP417 enables PCIE0 and PCIE1 whereas RDP433
enables PCIE1, PCIE2 and PCIE3.

With the introduction of the common RDP DTSI,
	- RDP433 gains SPI NOR support
	- All the IPQ9574 RDPs gains USB2 and USB3 support

While at it, add support for WPS buttons.

Since Anusha's is busy and can't take up this series right now, I'm
stepping up to work on this series.

Changes in V3:
	- Reworded the cover letter to indicate the need and advantages
	  of common RDP DTSI
	- Change logs are in respective patches
	- V2: https://lore.kernel.org/linux-arm-msm/20230713105909.14209-1-quic_anusha@quicinc.com/

Changes in V2:
	- Detailed change logs are added to the respective patches.
	- V1: https://lore.kernel.org/linux-arm-msm/20230614085040.22071-1-quic_anusha@quicinc.com/

---
Anusha Rao (2):
      arm64: dts: qcom: ipq9574: Add common RDP dtsi file
      arm64: dts: qcom: ipq9574: Enable WPS buttons

 arch/arm64/boot/dts/qcom/ipq9574-rdp-common.dtsi | 147 +++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/ipq9574-rdp418.dts      |  63 +---------
 arch/arm64/boot/dts/qcom/ipq9574-rdp433.dts      |  91 +-------------
 arch/arm64/boot/dts/qcom/ipq9574-rdp449.dts      |  65 +---------
 arch/arm64/boot/dts/qcom/ipq9574-rdp453.dts      |  65 +---------
 arch/arm64/boot/dts/qcom/ipq9574-rdp454.dts      |  66 +---------
 6 files changed, 152 insertions(+), 345 deletions(-)
---
base-commit: 18030226a48de1fbfabf4ae16aaa2695a484254f
change-id: 20230927-common-rdp-52f90fd0fd77

Best regards,
-- 
Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

