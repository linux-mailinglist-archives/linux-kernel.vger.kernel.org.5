Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642377D0836
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376304AbjJTGU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346657AbjJTGUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:20:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48444D46;
        Thu, 19 Oct 2023 23:20:24 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39K4jL25008824;
        Fri, 20 Oct 2023 06:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=HFa/WvIz9fMd/sjLZAHrqLbilC8HNxmewxOYOV9Hvgc=;
 b=b8gM4kDv1qMTapnXLGh2KPHt/9NXM9hFNlIAFj4/4JiXdKzbbh2Bk5NgI2oBYOqlU7R2
 J7lcMEZIvNl02rCJoKUBnaN9dmrM/ccAlo0hkcNAhOISouugyEW77DvR0hnzX8YwOOTe
 FvCD8neOLPM8x5gdZ6UtxZeG74Vhg/JKrLyfeIYczSK1VXBalFevI7RD/f1rWsqZGkfE
 1fJEjvZPLJBeAvs6gcU/PUsE7DkkNYPGAlWmJwfVQpT5Yqn9CP0/O8r6Tu9JbZGgMnr/
 jcplexlQSGW0fAH9YWB4h7NwAzdloUAeTVQm88bUGt7UYw0LmiiYHHuAtH80rcYcEyQd mg== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tubwr8wa5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 06:19:54 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39K6JrIN006105
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Oct 2023 06:19:53 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 23:19:48 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <ilia.lin@kernel.org>,
        <sivaprak@codeaurora.org>, <quic_kathirav@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v5 0/9] Enable cpufreq for IPQ5332 & IPQ9574
Date:   Fri, 20 Oct 2023 11:49:30 +0530
Message-ID: <cover.1697781921.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _t9DdBR2r8hfVrj6Sp2voBzTwx9dtkwn
X-Proofpoint-GUID: _t9DdBR2r8hfVrj6Sp2voBzTwx9dtkwn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-20_04,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=939
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 mlxscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310170001
 definitions=main-2310200053
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Depends On:
https://lore.kernel.org/lkml/20230913-gpll_cleanup-v2-6-c8ceb1a37680@quicinc.com/T/

This patch series aims to enable cpufreq for IPQ5332 and IPQ9574.
For IPQ5332, a minor enhancement to Stromer Plus ops and a safe
source switch is needed before cpu freq can be enabled.

These are also included in this series. Posting this as a single
series. Please let me know if this is not correct, will split in
the subsequent revisions.

Passed the following DT related validations
make W=1 ARCH=arm64 -j16 DT_CHECKER_FLAGS='-v -m' dt_binding_check DT_SCHEMA_FILES=qcom
make W=1 ARCH=arm64 -j16 CHECK_DTBS=y DT_SCHEMA_FILES=qcom dtbs_check

For IPQ5332:
~~~~~~~~~~~
	* This patch series introduces stromer plus ops which
	  builds on stromer ops and implements a different
	  set_rate and determine_rate.

	  A different set_rate is needed since stromer plus PLLs
	  do not support dynamic frequency scaling. To switch
	  between frequencies, we have to shut down the PLL,
	  configure the L and ALPHA values and turn on again. So
	  introduce the separate set of ops for Stromer Plus PLL.

	* Update ipq_pll_stromer_plus to use clk_alpha_pll_stromer_plus_ops
	  instead of clk_alpha_pll_stromer_ops.

	* Set 'l' value to a value that is supported on all SKUs.

	* Provide safe source switch for a53pll

	* Include IPQ5332 in cpufreq nvmem framework

	* Add OPP details to device tree

For IPQ9574:
~~~~~~~~~~~
	* Include IPQ9574 in cpufreq nvmem framework

	* Add OPP details to device tree

Removed 2 patches from V1 as they have been merged
	* dt-bindings: cpufreq: qcom-cpufreq-nvmem: document IPQ5332
	* dt-bindings: cpufreq: qcom-cpufreq-nvmem: document IPQ9574

v4:	Included a patch to fix 'kernel test robot' build error --
	https://lore.kernel.org/r/202310181650.g8THtfsm-lkp@intel.com/

v5:	Use devm_clk_notifier_register
	Merge IPQ53xx and IPQ95xx cases with APQ8096 for speed bin selection
	Add reviewed by tags
Varadarajan Narayanan (9):
  clk: qcom: config IPQ_APSS_6018 should depend on QCOM_SMEM
  clk: qcom: clk-alpha-pll: introduce stromer plus ops
  clk: qcom: apss-ipq-pll: Use stromer plus ops for stromer plus pll
  clk: qcom: apss-ipq-pll: Fix 'l' value for ipq5332_pll_config
  clk: qcom: apss-ipq6018: ipq5332: add safe source switch for a53pll
  cpufreq: qti: Enable cpufreq for ipq53xx
  arm64: dts: qcom: ipq5332: populate the opp table based on the eFuse
  cpufreq: qti: Introduce cpufreq for ipq95xx
  arm64: dts: qcom: ipq9574: populate the opp table based on the eFuse

 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 19 +++++++++--
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 21 +++++++++++-
 drivers/clk/qcom/Kconfig              |  1 +
 drivers/clk/qcom/apss-ipq-pll.c       |  4 +--
 drivers/clk/qcom/apss-ipq6018.c       | 58 +++++++++++++++++++++++++++++++-
 drivers/clk/qcom/clk-alpha-pll.c      | 63 +++++++++++++++++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.h      |  1 +
 drivers/cpufreq/cpufreq-dt-platdev.c  |  2 ++
 drivers/cpufreq/qcom-cpufreq-nvmem.c  | 12 +++++++
 9 files changed, 174 insertions(+), 7 deletions(-)

-- 
2.7.4

