Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188A27F71DC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345533AbjKXKns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345599AbjKXKnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:43:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F200910EC;
        Fri, 24 Nov 2023 02:43:51 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO6VIqw019888;
        Fri, 24 Nov 2023 10:43:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KHgcKDrjOC7qUxvpezsgBEsx90w2iFb3n3/9l9e/5VQ=;
 b=B1LG3c7Y2u7NV4ljTWALerpKRXkbX2+Bw5mP8BQpMnb8P9v7SP2ZV6csSNAcqRLPkrLw
 CJC7PlLh5v2MfoD6mMdxUr6B4HJsa4dHCsL5j7TI5CNmlZCVftCy8ayZm63QIZ+29F1D
 tDRZWh5lP7WHFa9mnqjTpFq0REIlwbBA5LT2xNiM1FIE3XyS+V2y+rYm9TuwbL/iV1Zo
 jG+F9JKGTFZZG1qBdQUnGZ0eDU9V+rmBCE9x9HYwQSamIT+GBn1qVanMEZHbgjC3yEfH
 X+MYgnXsF8WEttUMby022EjLZ7vX2Vwc5jpgwLWWF/ske/kK3gTJYaSPqjmRDSRcu2td 3A== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj30xatpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 10:43:43 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AOAhgsg007520
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Nov 2023 10:43:42 GMT
Received: from [10.253.33.181] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 24 Nov
 2023 02:43:38 -0800
Message-ID: <7de5006c-eec7-4777-a065-682d98e22313@quicinc.com>
Date:   Fri, 24 Nov 2023 18:43:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/4] add clock controller of qca8386/qca8084
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
To:     <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20231104034858.9159-1-quic_luoj@quicinc.com>
In-Reply-To: <20231104034858.9159-1-quic_luoj@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 7oTuD-gnXMCZ-B-Ata6c5x6afa3LGWDP
X-Proofpoint-GUID: 7oTuD-gnXMCZ-B-Ata6c5x6afa3LGWDP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 clxscore=1011
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240084
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2023 11:48 AM, Luo Jie wrote:
> qca8xxx is 4 * 2.5GBaseT ports chip, working as switch mode
> named by qca8386, or working as PHY mode named by qca8084,
> clock hardware reigster is accessed by MDIO bus.
> 
> This patch series add the clock controller of qca8363/qca8084,
> and add the clock ops clk_branch2_prepare_ops to avoid spin lock
> used during the clock operation of qca8k clock controller where
> the sleep happens when accessing clock control register by MDIO
> bus.
> 
> Changes in v2:
> 	* remove clock flag CLK_ENABLE_MUTEX_LOCK.
> 	* add clock ops clk_branch2_qca8k_ops.
> 	* improve yaml file for fixing dtschema warnings.
> 	* enable clock controller driver in defconfig.
> 
> Changes in v3:
> 	* rename clk_branch2_qca8k_ops to clk_branch2_mdio_ops.
> 	* fix review comments on yaml file.
> 	* use dev_err_probe on driver probe error.
> 	* only use the compatible "qcom,qca8084-nsscc".
> 	* remove enable clock controller driver patch.
> 
> Changes in v4:
> 	* add _qcom_cc_really_probe function.
> 	* commonizing the probe function.
> 	* remove flag CLK_IS_CRITICAL from clocks only needed
> 	to be enabled in switch device.
> 	* update device tree property reg to 0x10.
> 
> Changes in v5:
> 	* commonize qcom_cc_really_probe.
> 	* add halt_check for the branch clocks.
> 	* fix the review comments on nsscc-qca8k.c.
> 
> Changes in v6:
> 	* rename clk_branch2_mdio_ops to clk_branch2_prepare_ops.
> 
> Changes in v7:
> 	* remove the clock flag CLK_IS_CRITICAL.
> 	* optimize the file nsscc-qca8k.c.
> 	* identify & fix the comments from Stephen.
> 
> Changes in v8:
> 	* add dependency on ARM in Kconfig.
> 
> Changes in v9:
> 	* take the clk_ops clk_rcg2_mux_closest_ops to remove the
> 	  redundant freq_tbls.
> 
> Changes in v10:
>          * fix the patch CHECK and improve the comments.
> 
> Changes in v11:
> 	* update the clock names to reflect hardware connecton.
> 	  NSS_CC_MAC4_SRDS1_CH2_XGMII_RX_DIV_CLK_SRC ->
> 	  NSS_CC_MAC4_SRDS1_CH3_XGMII_RX_DIV_CLK_SRC
> 
> 	  NSS_CC_MAC4_SRDS1_CH2_XGMII_TX_DIV_CLK_SRC ->
> 	  NSS_CC_MAC4_SRDS1_CH3_XGMII_TX_DIV_CLK_SRC
>          * resolve the qcom_cc_really_probe merge conflict based
> 	  on the latest code.
> 
> Changes in v12:
> 	* Fix the compile error caused by the parameter of
> 	  qcom_cc_really_probe updated from pdev to &pdev->dev in the
> 	  new merged clock driver gcc-sm4450.c and camcc-sm8550.c.
> 
> Luo Jie (4):
>    clk: qcom: branch: Add clk_branch2_prepare_ops
>    dt-bindings: clock: add qca8386/qca8084 clock and reset definitions
>    clk: qcom: common: commonize qcom_cc_really_probe
>    clk: qcom: add clock controller driver for qca8386/qca8084
> 
>   .../bindings/clock/qcom,qca8k-nsscc.yaml      |   79 +
>   drivers/clk/qcom/Kconfig                      |    9 +
>   drivers/clk/qcom/Makefile                     |    1 +
>   drivers/clk/qcom/apss-ipq6018.c               |    2 +-
>   drivers/clk/qcom/camcc-sc7180.c               |    2 +-
>   drivers/clk/qcom/camcc-sc7280.c               |    2 +-
>   drivers/clk/qcom/camcc-sdm845.c               |    2 +-
>   drivers/clk/qcom/camcc-sm6350.c               |    2 +-
>   drivers/clk/qcom/camcc-sm8250.c               |    2 +-
>   drivers/clk/qcom/camcc-sm8450.c               |    2 +-
>   drivers/clk/qcom/camcc-sm8550.c               |    2 +-
>   drivers/clk/qcom/clk-branch.c                 |    7 +
>   drivers/clk/qcom/clk-branch.h                 |    1 +
>   drivers/clk/qcom/common.c                     |    7 +-
>   drivers/clk/qcom/common.h                     |    2 +-
>   drivers/clk/qcom/dispcc-qcm2290.c             |    2 +-
>   drivers/clk/qcom/dispcc-sc7180.c              |    2 +-
>   drivers/clk/qcom/dispcc-sc7280.c              |    2 +-
>   drivers/clk/qcom/dispcc-sc8280xp.c            |    2 +-
>   drivers/clk/qcom/dispcc-sdm845.c              |    2 +-
>   drivers/clk/qcom/dispcc-sm6115.c              |    2 +-
>   drivers/clk/qcom/dispcc-sm6125.c              |    2 +-
>   drivers/clk/qcom/dispcc-sm6350.c              |    2 +-
>   drivers/clk/qcom/dispcc-sm6375.c              |    2 +-
>   drivers/clk/qcom/dispcc-sm8250.c              |    2 +-
>   drivers/clk/qcom/dispcc-sm8450.c              |    2 +-
>   drivers/clk/qcom/dispcc-sm8550.c              |    2 +-
>   drivers/clk/qcom/gcc-ipq5018.c                |    2 +-
>   drivers/clk/qcom/gcc-ipq6018.c                |    2 +-
>   drivers/clk/qcom/gcc-ipq8074.c                |    2 +-
>   drivers/clk/qcom/gcc-mdm9607.c                |    2 +-
>   drivers/clk/qcom/gcc-mdm9615.c                |    2 +-
>   drivers/clk/qcom/gcc-msm8917.c                |    2 +-
>   drivers/clk/qcom/gcc-msm8939.c                |    2 +-
>   drivers/clk/qcom/gcc-msm8953.c                |    2 +-
>   drivers/clk/qcom/gcc-msm8976.c                |    2 +-
>   drivers/clk/qcom/gcc-msm8996.c                |    2 +-
>   drivers/clk/qcom/gcc-msm8998.c                |    2 +-
>   drivers/clk/qcom/gcc-qcm2290.c                |    2 +-
>   drivers/clk/qcom/gcc-qcs404.c                 |    2 +-
>   drivers/clk/qcom/gcc-qdu1000.c                |    2 +-
>   drivers/clk/qcom/gcc-sa8775p.c                |    2 +-
>   drivers/clk/qcom/gcc-sc7180.c                 |    2 +-
>   drivers/clk/qcom/gcc-sc7280.c                 |    2 +-
>   drivers/clk/qcom/gcc-sc8180x.c                |    2 +-
>   drivers/clk/qcom/gcc-sc8280xp.c               |    2 +-
>   drivers/clk/qcom/gcc-sdm660.c                 |    2 +-
>   drivers/clk/qcom/gcc-sdm845.c                 |    2 +-
>   drivers/clk/qcom/gcc-sdx55.c                  |    2 +-
>   drivers/clk/qcom/gcc-sdx65.c                  |    2 +-
>   drivers/clk/qcom/gcc-sdx75.c                  |    2 +-
>   drivers/clk/qcom/gcc-sm4450.c                 |    2 +-
>   drivers/clk/qcom/gcc-sm6115.c                 |    2 +-
>   drivers/clk/qcom/gcc-sm6125.c                 |    2 +-
>   drivers/clk/qcom/gcc-sm6350.c                 |    2 +-
>   drivers/clk/qcom/gcc-sm6375.c                 |    2 +-
>   drivers/clk/qcom/gcc-sm7150.c                 |    2 +-
>   drivers/clk/qcom/gcc-sm8150.c                 |    2 +-
>   drivers/clk/qcom/gcc-sm8250.c                 |    2 +-
>   drivers/clk/qcom/gcc-sm8350.c                 |    2 +-
>   drivers/clk/qcom/gcc-sm8450.c                 |    2 +-
>   drivers/clk/qcom/gcc-sm8550.c                 |    2 +-
>   drivers/clk/qcom/gpucc-msm8998.c              |    2 +-
>   drivers/clk/qcom/gpucc-sa8775p.c              |    2 +-
>   drivers/clk/qcom/gpucc-sc7180.c               |    2 +-
>   drivers/clk/qcom/gpucc-sc7280.c               |    2 +-
>   drivers/clk/qcom/gpucc-sc8280xp.c             |    2 +-
>   drivers/clk/qcom/gpucc-sdm660.c               |    2 +-
>   drivers/clk/qcom/gpucc-sdm845.c               |    2 +-
>   drivers/clk/qcom/gpucc-sm6115.c               |    2 +-
>   drivers/clk/qcom/gpucc-sm6125.c               |    2 +-
>   drivers/clk/qcom/gpucc-sm6350.c               |    2 +-
>   drivers/clk/qcom/gpucc-sm6375.c               |    2 +-
>   drivers/clk/qcom/gpucc-sm8150.c               |    2 +-
>   drivers/clk/qcom/gpucc-sm8250.c               |    2 +-
>   drivers/clk/qcom/gpucc-sm8350.c               |    2 +-
>   drivers/clk/qcom/gpucc-sm8450.c               |    2 +-
>   drivers/clk/qcom/gpucc-sm8550.c               |    2 +-
>   drivers/clk/qcom/lcc-ipq806x.c                |    2 +-
>   drivers/clk/qcom/lcc-msm8960.c                |    2 +-
>   drivers/clk/qcom/lpassaudiocc-sc7280.c        |    4 +-
>   drivers/clk/qcom/lpasscorecc-sc7180.c         |    2 +-
>   drivers/clk/qcom/lpasscorecc-sc7280.c         |    2 +-
>   drivers/clk/qcom/mmcc-msm8960.c               |    2 +-
>   drivers/clk/qcom/mmcc-msm8974.c               |    2 +-
>   drivers/clk/qcom/mmcc-msm8994.c               |    2 +-
>   drivers/clk/qcom/mmcc-msm8996.c               |    2 +-
>   drivers/clk/qcom/mmcc-msm8998.c               |    2 +-
>   drivers/clk/qcom/mmcc-sdm660.c                |    2 +-
>   drivers/clk/qcom/nsscc-qca8k.c                | 2139 +++++++++++++++++
>   drivers/clk/qcom/tcsrcc-sm8550.c              |    2 +-
>   drivers/clk/qcom/videocc-sc7180.c             |    2 +-
>   drivers/clk/qcom/videocc-sc7280.c             |    2 +-
>   drivers/clk/qcom/videocc-sdm845.c             |    2 +-
>   drivers/clk/qcom/videocc-sm8150.c             |    2 +-
>   drivers/clk/qcom/videocc-sm8250.c             |    2 +-
>   drivers/clk/qcom/videocc-sm8350.c             |    2 +-
>   drivers/clk/qcom/videocc-sm8450.c             |    2 +-
>   drivers/clk/qcom/videocc-sm8550.c             |    2 +-
>   include/dt-bindings/clock/qcom,qca8k-nsscc.h  |  101 +
>   include/dt-bindings/reset/qcom,qca8k-nsscc.h  |   75 +
>   101 files changed, 2508 insertions(+), 97 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,qca8k-nsscc.yaml
>   create mode 100644 drivers/clk/qcom/nsscc-qca8k.c
>   create mode 100644 include/dt-bindings/clock/qcom,qca8k-nsscc.h
>   create mode 100644 include/dt-bindings/reset/qcom,qca8k-nsscc.h
> 
> 
> base-commit: ff269e2cd5adce4ae14f883fc9c8803bc43ee1e9

Hi Bjorn,
Is this patch series fine to be merged now?

