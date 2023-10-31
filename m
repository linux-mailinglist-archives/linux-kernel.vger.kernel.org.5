Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F797DC6F5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 08:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343561AbjJaHMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 03:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343497AbjJaHMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 03:12:48 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C9BBB;
        Tue, 31 Oct 2023 00:12:46 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V2doOx007914;
        Tue, 31 Oct 2023 07:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=DGc89/LkVBj7LFjVtuq1SQIPGuwD8Fsui9aN/ARipZo=;
 b=pOssUApblMfgM6s8T/Qohb6V2EYwLE3RBQFa4hXO/JvL54Z4w9sS+63BteLI5gYIxymn
 4bGJ5zIrYMs8GfS9uzJ0U0rimm4azFiQ8wZTndp6gpORk64gr/kt6BiWUF4CYTeowvg3
 GY4HXPClbYn0ejPWOsiwqL2NWrsMzvWPex/Xru7iQeoS7QfqWW8YJPpX5ZGImMCfj7u9
 aYCeB4ulKfAVkMLcPQo6aJjXMqa+FvoHqSPd160eRkotOVE1L/wSP9DcycV+UJnedqBT
 tUdGhzwcgLdvYW5uiAGdhS6GNy4hL0ZUUsRKE38F2W37c1KtOhruC+MlTAT89VFJbSzx gA== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2fuvhkhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 07:12:12 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V7CAcI004048
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 07:12:10 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 31 Oct 2023 00:12:04 -0700
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
Subject: [PATCH v6 0/2] Enable cpufreq for IPQ5332 & IPQ9574
Date:   Tue, 31 Oct 2023 12:41:37 +0530
Message-ID: <cover.1698735972.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HYfTC8sYS48ABBb2_FJWDb7disZEA_wR
X-Proofpoint-GUID: HYfTC8sYS48ABBb2_FJWDb7disZEA_wR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011 mlxscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=962 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310054
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

v6:	Except these 2 patches, rest have been merged...
	Rebased these to latest top as they don't apply cleanly
	(https://lore.kernel.org/linux-arm-msm/20231025062508.vccrmkem45p3fnwe@vireshk-i7/)

Varadarajan Narayanan (2):
  cpufreq: qti: Enable cpufreq for ipq53xx
  cpufreq: qti: Introduce cpufreq for ipq95xx

 drivers/cpufreq/cpufreq-dt-platdev.c |  2 ++
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

-- 
2.7.4

