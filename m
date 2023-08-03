Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714AD76E5F6
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbjHCK63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232154AbjHCK6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:58:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF4201AB;
        Thu,  3 Aug 2023 03:58:20 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3737707x007072;
        Thu, 3 Aug 2023 10:58:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=JcecF8mLd6NgooXMFFgDYR6KkurfXYyV6RGucJK0uP4=;
 b=g9KL8lPI9KK6HuJ9ZOPlXKOifD29ebDitYP+f5MaO9uSMzgbfACa2QXjGARvl6abPBrC
 uU5wEjge8pa70tZu6DdOzjvk4o3PkmeylFT7D35uaQyaMg60IknhXhitSOkuBn3Hm0Xi
 PA3Va0rIrPm4t7eNM6Ki/Txes1J1KVpm8r2fi+ha8Lv3elROmL9l0z78V+1eRXqDw7Ma
 uSxeXPvdVEK36i+S7FUPkGG9y0okZaYBxosqHlpwP7t37ca6QG55AOjA2aS9DfTH9r4G
 aAg00hqNkx9/RIG0qqF/8e93U5ZgeT+fTWRlPThGPXEr1zFNOig7UEBdVj5QuK/d6M4g nw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s87jhge0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Aug 2023 10:58:14 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 373AwD2p009255
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 10:58:13 GMT
Received: from hu-imrashai-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 3 Aug 2023 03:58:07 -0700
From:   Imran Shaik <quic_imrashai@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Melody Olvera <quic_molvera@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        "Ajit Pandey" <quic_ajipan@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Subject: [PATCH V5 0/8] Update GCC clocks for QDU1000 and QRU1000 SoCs
Date:   Thu, 3 Aug 2023 16:27:33 +0530
Message-ID: <20230803105741.2292309-1-quic_imrashai@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Vph3punzd6ZHJQrnQBMqYGsUhnOmwYUs
X-Proofpoint-ORIG-GUID: Vph3punzd6ZHJQrnQBMqYGsUhnOmwYUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_09,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=990 spamscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308030098
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update GCC clocks and add support for GDSCs for QDU1000 and QRU1000 SoCs.

Changes since v4:
 - Updated the commit text as per the review comments
 - Split the gcc_ddrss_ecpri_gsi_clk and gcc_gpll1_out_even clock changes

Changes since v3:
 - Split the gcc rcg ops changes as per the review comments

Changes since v2:
 - Split the gcc clkref clock changes as per the review comments

Changes since v1:
 - Dropped the v2 variant compatible changes
 - Update tha maintainers list
 - Split the GCC driver patch as per the review comments

Previous series:
v4 - https://patchwork.kernel.org/project/linux-arm-msm/list/?series=767111
v3 - https://patchwork.kernel.org/project/linux-arm-msm/list/?series=763044
v2 - https://patchwork.kernel.org/project/linux-arm-msm/list/?series=760862
v1 - https://patchwork.kernel.org/project/linux-arm-msm/list/?series=757828

Imran Shaik (8):
  dt-bindings: clock: Update GCC clocks for QDU1000 and QRU1000 SoCs
  clk: qcom: gcc-qdu1000: Fix gcc_pcie_0_pipe_clk_src clock handling
  clk: qcom: gcc-qdu1000: Fix clkref clocks handling
  clk: qcom: gcc-qdu1000: Register gcc_gpll1_out_even clock
  clk: qcom: gcc-qdu1000: Add gcc_ddrss_ecpri_gsi_clk support
  clk: qcom: gcc-qdu1000: Add support for GDSCs
  clk: qcom: gcc-qdu1000: Update the SDCC clock RCG ops
  clk: qcom: gcc-qdu1000: Update the RCGs ops

 .../bindings/clock/qcom,qdu1000-gcc.yaml      |   3 +-
 drivers/clk/qcom/gcc-qdu1000.c                | 159 ++++++++++++------
 include/dt-bindings/clock/qcom,qdu1000-gcc.h  |   4 +-
 3 files changed, 110 insertions(+), 56 deletions(-)

-- 
2.25.1

