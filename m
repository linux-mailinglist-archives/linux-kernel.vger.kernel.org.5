Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81112812AF9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:03:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjLNJDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjLNJDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:03:40 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3734113;
        Thu, 14 Dec 2023 01:03:45 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE8pA3k007659;
        Thu, 14 Dec 2023 09:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=qcppdkim1; bh=CEmD2Io
        8I30NU9IsgDTAgfw6x3bBuAFuwff3Y2iUpWs=; b=fFM3xcmN9p0FMX+cBO7VIWd
        aHICKqkaBvrUogzjOriukPB4AdhJ0Cs7RavBDKo8QK3Bihbp1o43AKBPOzZbadao
        4chbsXoXNrpiYJ5uizOc/7bzQd1bah1XNuV2+RUSqmmrHLnIoDRpsfXjW+6LbFd6
        pfvRJMhSd0KwXlkSomkT5iz6Uxv3JQT41Pfqo4pKfkJR1FlpvONeeo/WGSsbLSZH
        cad+aA4IRF37VysdR/QkTzPXFS7fqPkisT0tMsPtsDwjuHHiVCteNhJwCOBO30+O
        Z7Vw0MESVWt1FK6mnyc3wis1tC5gCIqSm4inN5iWHzVIdXDwG8VoPhvsLcNFM1A=
        =
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uynvy90yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:03:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE93O6t019890
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 09:03:24 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:03:19 -0800
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
Subject: [PATCH v3 0/5] support ipq5332 platform
Date:   Thu, 14 Dec 2023 17:02:59 +0800
Message-ID: <20231214090304.16884-1-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HoUA1_qfyPvjIpdjHqM530fb9N7xuvvV
X-Proofpoint-ORIG-GUID: HoUA1_qfyPvjIpdjHqM530fb9N7xuvvV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v3:
	* fix the christmas-tree format issue.
	* improve the dt-binding changes.

Luo Jie (5):
  net: mdio: ipq4019: move eth_ldo_rdy before MDIO bus register
  net: mdio: ipq4019: enable the SoC uniphy clocks for ipq5332 platform
  net: mdio: ipq4019: configure CMN PLL clock for ipq5332
  net: mdio: ipq4019: support MDIO clock frequency divider
  dt-bindings: net: ipq4019-mdio: Document ipq5332 platform

 .../bindings/net/qcom,ipq4019-mdio.yaml       | 143 ++++++++-
 drivers/net/mdio/mdio-ipq4019.c               | 296 ++++++++++++++++--
 2 files changed, 410 insertions(+), 29 deletions(-)


base-commit: 11651f8cb2e88372d4ed523d909514dc9a613ea3
-- 
2.42.0

