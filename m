Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37CD480EADC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346363AbjLLLwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346386AbjLLLw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:52:29 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3BDAF;
        Tue, 12 Dec 2023 03:52:34 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BCBqARO019409;
        Tue, 12 Dec 2023 11:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=qcppdkim1; bh=i5kU/DH
        I2fRQRx6QhoIITu/Uxym8ekVJjFK07l1YCa8=; b=SQyQVXKBLHsGmZa/4JanVFK
        c0/zhelWdAeua5T9DXmlvV4kE39jxCCFz/KCy3W18VEjLpY9hi763YuKlKloNBLW
        FCtRUmjasC2HB4P3ySvdLl/FiZE8fytLqI5IPJUBx2ytPDN0gOGYQohr9ElHbQNe
        jgY3mOIGE5umnvdwb26zXaKpxTBzSCzi8O90mLJqJMgnRedULUR8oQ6mWq5k+fLZ
        rolKN/DoBCbZIcu238+JX2YU181iQYo85VSZfd8p/J49Sis7p4PTE+AdNP9lG5I4
        KLKOoH89/B9odDVAGcDuYGCA9ClbQh1fYmkoI9qrH04Sz3fAyrIIzJA3zeOpEaQ=
        =
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uxjxp0kg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:52:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BCBq9MG000339
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Dec 2023 11:52:09 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 12 Dec 2023 03:52:04 -0800
From:   Luo Jie <quic_luoj@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <robert.marko@sartura.hr>
CC:     <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
Subject: [PATCH v2 0/5] support ipq5332 platform
Date:   Tue, 12 Dec 2023 19:51:45 +0800
Message-ID: <20231212115151.20016-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Go0niqZI7NtW-XBjgDtMq-mK5e-BI_i0
X-Proofpoint-GUID: Go0niqZI7NtW-XBjgDtMq-mK5e-BI_i0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312120095
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For IPQ5332 platform, there are two MAC PCSs, and qca8084 is
connected with one of them.

1. The Ethernet LDO needs to be enabled to make the PHY GPIO
   reset taking effect, which uses the MDIO bus level reset.

2. The SoC GCC uniphy AHB and SYS clocks need to be enabled
   to make the ethernet PHY device accessible.

3. To provide the clock to the ethernet, the CMN clock needs
   to be initialized for selecting reference clock and enabling
   the output clock.

4. Support optional MDIO clock frequency config.

5. Update dt-bindings doc for the new added properties.

Changes in v2:
	* remove the PHY related features such as PHY address
	  program and clock initialization.

	* leverage the MDIO level GPIO reset for qca8084 PHY.


Luo Jie (5):
  net: mdio: ipq4019: move eth_ldo_rdy before MDIO bus register
  net: mdio: ipq4019: enable the SoC uniphy clocks for ipq5332 platform
  net: mdio: ipq4019: configure CMN PLL clock for ipq5332
  net: mdio: ipq4019: support MDIO clock frequency divider
  dt-bindings: net: ipq4019-mdio: Document ipq5332 platform

 .../bindings/net/qcom,ipq4019-mdio.yaml       | 157 +++++++++-
 drivers/net/mdio/mdio-ipq4019.c               | 296 ++++++++++++++++--
 2 files changed, 424 insertions(+), 29 deletions(-)


base-commit: abb240f7a2bd14567ab53e602db562bb683391e6
-- 
2.42.0

