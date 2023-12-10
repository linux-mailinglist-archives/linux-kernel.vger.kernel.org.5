Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBC380B9AD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 08:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjLJH05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 02:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbjLJH0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 02:26:45 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A23FD6;
        Sat,  9 Dec 2023 23:26:52 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BA70HUb014626;
        Sun, 10 Dec 2023 07:26:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=qcppdkim1; bh=bBKZG0e
        5JbM21y8DbMmfAn/bcHoYE4szGRyxicHy54k=; b=X3FTt/CI9V2KiKgsZ6XcHV1
        pa92r26fZNqWhIq5Sl+1Ld64sOmmn4QAltXOmXy4TQGh4/oeEwsUGxwwN4kCnY6O
        QgU7dr3S72CRL0jXWX6bXhVYLuokdKrdl7iYZU2YQwqlkSphrvYmx9+YXOBcdZsY
        I2Dh3aFXUeIOLrNm+TusweBPaE+iUXC1mJSCJqs6gjpbILxVXZzu5NJbiZccOrmM
        OC+Hk7P6Zq+Ap/K89kdq48LYWtBTQOKU3IBIR6mhN/lmFcLbLOI0tvTn8JjhnvUd
        uyD0D3qNI2ZHWFeit0iLXnGaTI53QrqNIVu41V5fLS2bXmc2+Esr8qQxkJ/r+og=
        =
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvney13jy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Dec 2023 07:26:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BA7QjOE005581
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Dec 2023 07:26:45 GMT
Received: from hu-jinlmao-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 9 Dec 2023 23:26:44 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        "Tao Zhang" <quic_taozha@quicinc.com>
Subject: [PATCH v4 0/4] arm64: dts: qcom: Fix the warnings from coresight bindings
Date:   Sat, 9 Dec 2023 23:26:27 -0800
Message-ID: <20231210072633.4243-1-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0YyyZ_dJy0T9re2rpc9-VhUE6u8uPOwc
X-Proofpoint-ORIG-GUID: 0YyyZ_dJy0T9re2rpc9-VhUE6u8uPOwc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=470 mlxscore=0 phishscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312100063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all warnings in Qualcomm boards coming from Coresight bindings.

There are warnings below after running dtbs_check. The patches are
to fix them for Qcom boards.

funnel@3023000: 'in-ports' is a required property

etm@7c40000: 'out-ports' is a required property

etf@6047000: in-ports: '#address-cells', '#size-cells', 'port@1'
do not match any of the regexes: 'pinctrl-[0-9]+'

replicator@604a000: in-ports: '#address-cells', '#size-cells',
'port@1' do not match any of the regexes: 'pinctrl-[0-9]+'

funnel@6c2d000: out-ports: '#address-cells', '#size-cells' do not
match any of the regexes: 'pinctrl-[0-9]+'

Warning (graph_child_address): /soc@0/tpda@6004000/out-ports:
graph node has single child node 'port@0', #address-cells/#size-cells
are not necessary

Warning (graph_child_address): /soc@0/funnel@6005000/in-ports: graph
node has single child node 'port@0', #address-cells/#size-cells are
not necessary

Warning (graph_child_address): /soc@0/etf@6b05000/in-ports: graph node
has single child node 'port@0', #address-cells/#size-cells are not
necessary

Warning (graph_child_address): /soc@0/funnel@7810000/in-ports: graph
node has single child node 'port@0', #address-cells/#size-cells are
not necessary

Changes since V3:
1. Modify the indentation of dt binding smaple.

Changes since V2:
1. Remove qcom,inst-id for remote etm.
2. Modify the node name of remote etm dt node.
3. Add space between 'endpoint' and the opening brace.

Changes since V1:
1. Add new dt binding for remote etm.
2. Add new dt node modem-etm in msm8996.dtsi

Mao Jinlong (4):
  dt-bindings: arm: Add remote etm dt-binding
  arm64: dts: qcom: msm8996: Fix 'in-ports' is a required property
  arm64: dts: qcom: msm8998: Fix 'out-ports' is a required property
  arm64: dts: qcom: Fix coresight warnings in in-ports and out-ports

 .../arm/qcom,coresight-remote-etm.yaml        | 51 +++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8996.dtsi         | 21 ++++++++
 arch/arm64/boot/dts/qcom/msm8998.dtsi         | 32 +++++++-----
 arch/arm64/boot/dts/qcom/sdm845.dtsi          |  5 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi          |  5 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi          | 24 ++-------
 6 files changed, 98 insertions(+), 40 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml

-- 
2.41.0

