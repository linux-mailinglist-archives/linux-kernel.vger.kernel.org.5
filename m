Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF457CF2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjJSIli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbjJSIle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:41:34 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E41E12F;
        Thu, 19 Oct 2023 01:41:32 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39J7sYWF031717;
        Thu, 19 Oct 2023 08:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=5nq85dacz/FT/KDtbSNEQek159G2NxW0RwewWC/0M3A=;
 b=Im+CPsSeIkBrBl+5muEz2poNcdn0mh4Wthsa7prnAfICWjdPHJWmN1Qk6YsVfCfDYkzJ
 e+f37evjATFjEspkdCGuuIuSrZylx0h0+UpMq3iIUhJ/emeIwy0snPRXB8FoSdxpBstl
 m5wJFz4L83eKTdsSOTu+eXYPOrEoyXIH0CSVKyEQvQaPzpSRkxI9l9CTOLSnNjnU2xd+
 o28/qzQZOj+SkZoqx/I9isA3j14mJXBhiefYac3DktFJ6ylDmJx8kRttDbVUZtYZVGyj
 vdC3UsyAuYcnJU1554XMr8uSaSUk6t157jvM4ncWkgy1OkoyEgLQUIvUWndU+3zrB/+3 2Q== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttnnah9r7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:40:56 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39J8euhP018028
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Oct 2023 08:40:56 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Thu, 19 Oct 2023 01:40:50 -0700
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
Subject: [PATCH v4 0/9] Enable cpufreq for IPQ5332 & IPQ9574
Date:   Thu, 19 Oct 2023 14:10:34 +0530
Message-ID: <cover.1697694811.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l_mvUwQr8Z_aqSFnuoselBA5hGrldM5P
X-Proofpoint-ORIG-GUID: l_mvUwQr8Z_aqSFnuoselBA5hGrldM5P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-19_06,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 bulkscore=0
 clxscore=1011 mlxlogscore=905 impostorscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310190072
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/cpufreq/qcom-cpufreq-nvmem.c  | 16 +++++++++
 9 files changed, 178 insertions(+), 7 deletions(-)

-- 
2.7.4

