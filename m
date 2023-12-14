Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7613D8127F5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234290AbjLNG3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjLNG3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:29:14 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68985A6;
        Wed, 13 Dec 2023 22:29:20 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE3Rr5P026065;
        Thu, 14 Dec 2023 06:29:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=qcppdkim1; bh=ODCJhiY
        BeWEU03LHMRasSH8E7YzOuqTWK5pYz/IOpl4=; b=aV03J+iML9O2FRcdASCnAOc
        upOAvs05PL7uyoSHooUXoaiglVD7ehYw1oVPFX6q7O9FQiIDJDfd6DuEmMY0gvNu
        nTNVUOZGAL2YC7o7WYYkOcooYO1RRqX9LQdY9j2WzNxPu6DdTrPJyYq5QKuDPffl
        ndK2MnXzBkvMtwf51ccr7vdt/u3ILD2zXU0HGSaNujK2sDsqx2lYTwm2ic2ZR+Y4
        pWnVGzKQnZXjUrvWfLOGqMvU01mYRTEHd6X5XGyVWFBni4C66gTdvvjJM+385txG
        d9wvJDKw1jLRLnr7hmqlh/MWBqFgJi/nTIOOUDsdUEypLcxarRs2Xl52TZxq8Vg=
        =
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyqd50k36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 06:29:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE6T8p0006439
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 06:29:08 GMT
Received: from hu-ipkumar-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 22:29:01 -0800
From:   Praveenkumar I <quic_ipkumar@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <vkoul@kernel.org>, <kishon@kernel.org>, <mani@kernel.org>,
        <quic_nsekar@quicinc.com>, <quic_srichara@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-phy@lists.infradead.org>
CC:     <quic_varada@quicinc.com>, <quic_devipriy@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_anusha@quicinc.com>
Subject: [PATCH 00/10] Add PCIe support for Qualcomm IPQ5332
Date:   Thu, 14 Dec 2023 11:58:37 +0530
Message-ID: <20231214062847.2215542-1-quic_ipkumar@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v719Z6pncc-Lc86gqsgsO87urvOt3rkD
X-Proofpoint-ORIG-GUID: v719Z6pncc-Lc86gqsgsO87urvOt3rkD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 adultscore=0 clxscore=1011 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=754 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140039
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adds support for enabling the PCIe controller and
UNIPHY found on Qualcomm IPQ5332 platform. PCIe0 is Gen3 X1 and
PCIe1 is Gen3 X2 are added.

UNIPHY changes depends on
https://lore.kernel.org/all/20231003120846.28626-1-quic_nsekar@quicinc.com/
PCIe driver change depends on
https://lore.kernel.org/all/20230519090219.15925-1-quic_devipriy@quicinc.com/

Praveenkumar I (10):
  dt-bindings: clock: Add separate clocks for PCIe and USB for Combo PHY
  clk: qcom: ipq5332: Add separate clocks for PCIe and USB for Combo PHY
  arm64: dts: qcom: ipq5332: Add separate entry for USB pipe clock
  phy: qcom: Add support for Pipe clock rate from device data
  dt-bindings: phy: qcom,uniphy-pcie: Add ipq5332 bindings
  phy: qcom: ipq5332: Add support for g3x1 and g3x2 PCIe PHYs
  dt-bindings: PCI: qcom: Add IPQ5332 SoC
  pci: qcom: Add support for IPQ5332
  arm64: dts: qcom: ipq5332: Add PCIe related nodes
  arm64: dts: qcom: ipq5332: Enable PCIe phys and controllers

 .../bindings/clock/qcom,ipq5332-gcc.yaml      |   6 +-
 .../devicetree/bindings/pci/qcom,pcie.yaml    |  36 ++++
 .../bindings/phy/qcom,uniphy-pcie-28lp.yaml   |  65 +++++-
 arch/arm64/boot/dts/qcom/ipq5332-rdp441.dts   |  74 +++++++
 arch/arm64/boot/dts/qcom/ipq5332.dtsi         | 188 +++++++++++++++++-
 drivers/clk/qcom/gcc-ipq5332.c                |   7 +-
 drivers/pci/controller/dwc/pcie-qcom.c        |   1 +
 .../phy/qualcomm/phy-qcom-uniphy-pcie-28lp.c  |  49 ++++-
 8 files changed, 412 insertions(+), 14 deletions(-)

-- 
2.34.1

