Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A6078C191
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbjH2JdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234927AbjH2Jcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:32:41 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D9DE50;
        Tue, 29 Aug 2023 02:32:09 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37T35jjd009315;
        Tue, 29 Aug 2023 09:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Dl72e+NJ95BCie+mZrUBKA6qjxhNizUs85uIVqwYcbw=;
 b=nt0wE9ZFLeQ4sM3eN8PzQVlcewDOfjkid/Uf43bX0La9p2Bwxz1nITUfhY6nWd/sk4UB
 fxPOocvegtLmRq7RFAvd1vEKUIz7pa+brsWOrPNMb53b/wmWT1bPTTtstQNtXczyyfap
 O7AgQHhSrY+4Ekj8cSvLbL/d+Qy18k5mArppN4inOhQ69r0w/sruSWx4vTyeWsvy1YuH
 ttkUnQwZQ+rTn7z5xgj0nYKGbZPTfREiB0528vGTc05cmOx7so8d2fasa7BpHtL4jKpe
 9TcWoc/9ADBhNXBFXaz4OIgJQo2/uOmeLpzz+7dMUUh2PvcEc7HwQtOrTDHS09x8OMfd yw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss7merx77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 09:31:41 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37T9Vevt018453
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 09:31:40 GMT
Received: from [10.218.10.146] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 02:31:35 -0700
Message-ID: <1125da3a-eef0-99fd-943f-8b42ad75a4b8@quicinc.com>
Date:   Tue, 29 Aug 2023 15:01:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 3/4] dt-bindings: clock: qcom: Add GCC clocks for SM4450
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230824173410.550126-1-quic_ajipan@quicinc.com>
 <20230824173410.550126-4-quic_ajipan@quicinc.com>
 <CAA8EJppMdE_CmsLWPgfZXKJZ8COqrn+8yCveDMwphha71e1kDQ@mail.gmail.com>
From:   Ajit Pandey <quic_ajipan@quicinc.com>
In-Reply-To: <CAA8EJppMdE_CmsLWPgfZXKJZ8COqrn+8yCveDMwphha71e1kDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PvvCv2sAzmwygVFYo0lisaBBiLMi4OcQ
X-Proofpoint-GUID: PvvCv2sAzmwygVFYo0lisaBBiLMi4OcQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_06,2023-08-28_04,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 priorityscore=1501 clxscore=1011 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290082
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/25/2023 2:40 AM, Dmitry Baryshkov wrote:
> On Thu, 24 Aug 2023 at 20:36, Ajit Pandey <quic_ajipan@quicinc.com> wrote:
>>
>> Add support for qcom global clock controller bindings for SM4450 platform.
>>
>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>> ---
>>   .../bindings/clock/qcom,sm4450-gcc.yaml       |  54 +++++
>>   include/dt-bindings/clock/qcom,sm4450-gcc.h   | 197 ++++++++++++++++++
>>   2 files changed, 251 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml
>>   create mode 100644 include/dt-bindings/clock/qcom,sm4450-gcc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml
>> new file mode 100644
>> index 000000000000..8c767bdf7f9d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/qcom,sm4450-gcc.yaml
>> @@ -0,0 +1,54 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/qcom,sm4450-gcc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Qualcomm Global Clock & Reset Controller on SM4450
>> +
>> +maintainers:
>> +  - Ajit Pandey <quic_ajipan@quicinc.com>
>> +  - Taniya Das <quic_tdas@quicinc.com>
>> +
>> +description: |
>> +  Qualcomm global clock control module provides the clocks, resets and power
>> +  domains on SM4450
>> +
>> +  See also:: include/dt-bindings/clock/qcom,sm4450-gcc.h
>> +
>> +properties:
>> +  compatible:
>> +    const: qcom,sm4450-gcc
>> +
>> +  clocks:
>> +    items:
>> +      - description: Board XO source
>> +      - description: Sleep clock source
>> +      - description: UFS Phy Rx symbol 0 clock source (Optional clock)
>> +      - description: UFS Phy Rx symbol 1 clock source (Optional clock)
>> +      - description: UFS Phy Tx symbol 0 clock source (Optional clock)
>> +      - description: USB3 Phy wrapper pipe clock source (Optional clock)
>> +    minItems: 2
> 
> I'd suggest dropping minItems here. Pass <0> instead for the clocks
> which are not present yet.
> 

Sure, will remove minItems from here
>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +
>> +allOf:
>> +  - $ref: qcom,gcc.yaml#
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/qcom,rpmh.h>
>> +    clock-controller@100000 {
>> +      compatible = "qcom,sm4450-gcc";
>> +      reg = <0x00100000 0x001f4200>;
>> +      clocks = <&rpmhcc RPMH_CXO_CLK>, <&sleep_clk>;
>> +      #clock-cells = <1>;
>> +      #reset-cells = <1>;
>> +      #power-domain-cells = <1>;
>> +    };
>> +
>> +...
>> diff --git a/include/dt-bindings/clock/qcom,sm4450-gcc.h b/include/dt-bindings/clock/qcom,sm4450-gcc.h
>> new file mode 100644
>> index 000000000000..c18e47a86f40
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/qcom,sm4450-gcc.h
>> @@ -0,0 +1,197 @@
>> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>> +/*
>> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SM4450_H
>> +#define _DT_BINDINGS_CLK_QCOM_GCC_SM4450_H
>> +
>> +/* GCC clocks */
>> +#define GCC_AGGRE_NOC_PCIE_0_AXI_CLK                           0
>> +#define GCC_AGGRE_UFS_PHY_AXI_CLK                              1
>> +#define GCC_AGGRE_UFS_PHY_AXI_HW_CTL_CLK                       2
>> +#define GCC_AGGRE_USB3_PRIM_AXI_CLK                            3
>> +#define GCC_BOOT_ROM_AHB_CLK                                   4
>> +#define GCC_CAMERA_AHB_CLK                                     5
>> +#define GCC_CAMERA_HF_AXI_CLK                                  6
>> +#define GCC_CAMERA_SF_AXI_CLK                                  7
>> +#define GCC_CAMERA_SLEEP_CLK                                   8
>> +#define GCC_CAMERA_XO_CLK                                      9
>> +#define GCC_CFG_NOC_PCIE_ANOC_AHB_CLK                          10
>> +#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK                          11
>> +#define GCC_DDRSS_GPU_AXI_CLK                                  12
>> +#define GCC_DDRSS_PCIE_SF_TBU_CLK                              13
>> +#define GCC_DISP_AHB_CLK                                       14
>> +#define GCC_DISP_HF_AXI_CLK                                    15
>> +#define GCC_DISP_XO_CLK                                                16
>> +#define GCC_EUSB3_0_CLKREF_EN                                  17
>> +#define GCC_GP1_CLK                                            18
>> +#define GCC_GP1_CLK_SRC                                                19
>> +#define GCC_GP2_CLK                                            20
>> +#define GCC_GP2_CLK_SRC                                                21
>> +#define GCC_GP3_CLK                                            22
>> +#define GCC_GP3_CLK_SRC                                                23
>> +#define GCC_GPLL0                                              24
>> +#define GCC_GPLL0_OUT_EVEN                                     25
>> +#define GCC_GPLL0_OUT_ODD                                      26
>> +#define GCC_GPLL1                                              27
>> +#define GCC_GPLL3                                              28
>> +#define GCC_GPLL4                                              29
>> +#define GCC_GPLL9                                              30
>> +#define GCC_GPLL10                                             31
>> +#define GCC_GPU_CFG_AHB_CLK                                    32
>> +#define GCC_GPU_GPLL0_CLK_SRC                                  33
>> +#define GCC_GPU_GPLL0_DIV_CLK_SRC                              34
>> +#define GCC_GPU_MEMNOC_GFX_CLK                                 35
>> +#define GCC_GPU_SNOC_DVM_GFX_CLK                               36
>> +#define GCC_HLOS1_VOTE_AGGRE_NOC_MMU_AUDIO_TBU_CLK             37
>> +#define GCC_HLOS1_VOTE_AGGRE_NOC_MMU_PCIE_TBU_CLK              38
>> +#define GCC_HLOS1_VOTE_AGGRE_NOC_MMU_TBU1_CLK                  39
>> +#define GCC_HLOS1_VOTE_AGGRE_NOC_MMU_TBU2_CLK                  40
>> +#define GCC_HLOS1_VOTE_MMNOC_MMU_TBU_HF0_CLK                   41
>> +#define GCC_HLOS1_VOTE_MMNOC_MMU_TBU_HF1_CLK                   42
>> +#define GCC_HLOS1_VOTE_MMNOC_MMU_TBU_SF0_CLK                   43
>> +#define GCC_HLOS1_VOTE_MMU_TCU_CLK                             44
>> +#define GCC_PCIE_0_AUX_CLK                                     45
>> +#define GCC_PCIE_0_AUX_CLK_SRC                                 46
>> +#define GCC_PCIE_0_CFG_AHB_CLK                                 47
>> +#define GCC_PCIE_0_CLKREF_EN                                   48
>> +#define GCC_PCIE_0_MSTR_AXI_CLK                                        49
>> +#define GCC_PCIE_0_PHY_RCHNG_CLK                               50
>> +#define GCC_PCIE_0_PHY_RCHNG_CLK_SRC                           51
>> +#define GCC_PCIE_0_PIPE_CLK                                    52
>> +#define GCC_PCIE_0_PIPE_CLK_SRC                                        53
>> +#define GCC_PCIE_0_PIPE_DIV2_CLK                               54
>> +#define GCC_PCIE_0_PIPE_DIV2_CLK_SRC                           55
>> +#define GCC_PCIE_0_SLV_AXI_CLK                                 56
>> +#define GCC_PCIE_0_SLV_Q2A_AXI_CLK                             57
>> +#define GCC_PDM2_CLK                                           58
>> +#define GCC_PDM2_CLK_SRC                                       59
>> +#define GCC_PDM_AHB_CLK                                                60
>> +#define GCC_PDM_XO4_CLK                                                61
>> +#define GCC_QMIP_CAMERA_NRT_AHB_CLK                            62
>> +#define GCC_QMIP_CAMERA_RT_AHB_CLK                             63
>> +#define GCC_QMIP_DISP_AHB_CLK                                  64
>> +#define GCC_QMIP_GPU_AHB_CLK                                   65
>> +#define GCC_QMIP_PCIE_AHB_CLK                                  66
>> +#define GCC_QMIP_VIDEO_VCODEC_AHB_CLK                          67
>> +#define GCC_QUPV3_WRAP0_CORE_2X_CLK                            68
>> +#define GCC_QUPV3_WRAP0_CORE_CLK                               69
>> +#define GCC_QUPV3_WRAP0_S0_CLK                                 70
>> +#define GCC_QUPV3_WRAP0_S0_CLK_SRC                             71
>> +#define GCC_QUPV3_WRAP0_S1_CLK                                 72
>> +#define GCC_QUPV3_WRAP0_S1_CLK_SRC                             73
>> +#define GCC_QUPV3_WRAP0_S2_CLK                                 74
>> +#define GCC_QUPV3_WRAP0_S2_CLK_SRC                             75
>> +#define GCC_QUPV3_WRAP0_S3_CLK                                 76
>> +#define GCC_QUPV3_WRAP0_S3_CLK_SRC                             77
>> +#define GCC_QUPV3_WRAP0_S4_CLK                                 78
>> +#define GCC_QUPV3_WRAP0_S4_CLK_SRC                             79
>> +#define GCC_QUPV3_WRAP1_CORE_2X_CLK                            80
>> +#define GCC_QUPV3_WRAP1_CORE_CLK                               81
>> +#define GCC_QUPV3_WRAP1_S0_CLK                                 82
>> +#define GCC_QUPV3_WRAP1_S0_CLK_SRC                             83
>> +#define GCC_QUPV3_WRAP1_S1_CLK                                 84
>> +#define GCC_QUPV3_WRAP1_S1_CLK_SRC                             85
>> +#define GCC_QUPV3_WRAP1_S2_CLK                                 86
>> +#define GCC_QUPV3_WRAP1_S2_CLK_SRC                             87
>> +#define GCC_QUPV3_WRAP1_S3_CLK                                 88
>> +#define GCC_QUPV3_WRAP1_S3_CLK_SRC                             89
>> +#define GCC_QUPV3_WRAP1_S4_CLK                                 90
>> +#define GCC_QUPV3_WRAP1_S4_CLK_SRC                             91
>> +#define GCC_QUPV3_WRAP_0_M_AHB_CLK                             92
>> +#define GCC_QUPV3_WRAP_0_S_AHB_CLK                             93
>> +#define GCC_QUPV3_WRAP_1_M_AHB_CLK                             94
>> +#define GCC_QUPV3_WRAP_1_S_AHB_CLK                             95
>> +#define GCC_SDCC1_AHB_CLK                                      96
>> +#define GCC_SDCC1_APPS_CLK                                     97
>> +#define GCC_SDCC1_APPS_CLK_SRC                                 98
>> +#define GCC_SDCC1_ICE_CORE_CLK                                 99
>> +#define GCC_SDCC1_ICE_CORE_CLK_SRC                             100
>> +#define GCC_SDCC2_AHB_CLK                                      101
>> +#define GCC_SDCC2_APPS_CLK                                     102
>> +#define GCC_SDCC2_APPS_CLK_SRC                                 103
>> +#define GCC_UFS_0_CLKREF_EN                                    104
>> +#define GCC_UFS_PAD_CLKREF_EN                                  105
>> +#define GCC_UFS_PHY_AHB_CLK                                    106
>> +#define GCC_UFS_PHY_AXI_CLK                                    107
>> +#define GCC_UFS_PHY_AXI_CLK_SRC                                        108
>> +#define GCC_UFS_PHY_AXI_HW_CTL_CLK                             109
>> +#define GCC_UFS_PHY_ICE_CORE_CLK                               110
>> +#define GCC_UFS_PHY_ICE_CORE_CLK_SRC                           111
>> +#define GCC_UFS_PHY_ICE_CORE_HW_CTL_CLK                                112
>> +#define GCC_UFS_PHY_PHY_AUX_CLK                                        113
>> +#define GCC_UFS_PHY_PHY_AUX_CLK_SRC                            114
>> +#define GCC_UFS_PHY_PHY_AUX_HW_CTL_CLK                         115
>> +#define GCC_UFS_PHY_RX_SYMBOL_0_CLK                            116
>> +#define GCC_UFS_PHY_RX_SYMBOL_0_CLK_SRC                                117
>> +#define GCC_UFS_PHY_RX_SYMBOL_1_CLK                            118
>> +#define GCC_UFS_PHY_RX_SYMBOL_1_CLK_SRC                                119
>> +#define GCC_UFS_PHY_TX_SYMBOL_0_CLK                            120
>> +#define GCC_UFS_PHY_TX_SYMBOL_0_CLK_SRC                                121
>> +#define GCC_UFS_PHY_UNIPRO_CORE_CLK                            122
>> +#define GCC_UFS_PHY_UNIPRO_CORE_CLK_SRC                                123
>> +#define GCC_UFS_PHY_UNIPRO_CORE_HW_CTL_CLK                     124
>> +#define GCC_USB30_PRIM_MASTER_CLK                              125
>> +#define GCC_USB30_PRIM_MASTER_CLK_SRC                          126
>> +#define GCC_USB30_PRIM_MOCK_UTMI_CLK                           127
>> +#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC                       128
>> +#define GCC_USB30_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC               129
>> +#define GCC_USB30_PRIM_SLEEP_CLK                               130
>> +#define GCC_USB3_0_CLKREF_EN                                   131
>> +#define GCC_USB3_PRIM_PHY_AUX_CLK                              132
>> +#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC                          133
>> +#define GCC_USB3_PRIM_PHY_COM_AUX_CLK                          134
>> +#define GCC_USB3_PRIM_PHY_PIPE_CLK                             135
>> +#define GCC_USB3_PRIM_PHY_PIPE_CLK_SRC                         136
>> +#define GCC_VCODEC0_AXI_CLK                                    137
>> +#define GCC_VENUS_CTL_AXI_CLK                                  138
>> +#define GCC_VIDEO_AHB_CLK                                      139
>> +#define GCC_VIDEO_THROTTLE_CORE_CLK                            140
>> +#define GCC_VIDEO_VCODEC0_SYS_CLK                              141
>> +#define GCC_VIDEO_VENUS_CLK_SRC                                        142
>> +#define GCC_VIDEO_VENUS_CTL_CLK                                        143
>> +#define GCC_VIDEO_XO_CLK                                       144
>> +
>> +/* GCC power domains */
>> +#define GCC_PCIE_0_GDSC                                                0
>> +#define GCC_UFS_PHY_GDSC                                       1
>> +#define GCC_USB30_PRIM_GDSC                                    2
>> +#define GCC_VCODEC0_GDSC                                       3
>> +#define GCC_VENUS_GDSC                                         4
>> +
>> +/* GCC resets */
>> +#define GCC_CAMERA_BCR                                         0
>> +#define GCC_DISPLAY_BCR                                                1
>> +#define GCC_GPU_BCR                                            2
>> +#define GCC_PCIE_0_BCR                                         3
>> +#define GCC_PCIE_0_LINK_DOWN_BCR                               4
>> +#define GCC_PCIE_0_NOCSR_COM_PHY_BCR                           5
>> +#define GCC_PCIE_0_PHY_BCR                                     6
>> +#define GCC_PCIE_0_PHY_NOCSR_COM_PHY_BCR                       7
>> +#define GCC_PCIE_PHY_BCR                                       8
>> +#define GCC_PCIE_PHY_CFG_AHB_BCR                               9
>> +#define GCC_PCIE_PHY_COM_BCR                                   10
>> +#define GCC_PDM_BCR                                            11
>> +#define GCC_QUPV3_WRAPPER_0_BCR                                        12
>> +#define GCC_QUPV3_WRAPPER_1_BCR                                        13
>> +#define GCC_QUSB2PHY_PRIM_BCR                                  14
>> +#define GCC_QUSB2PHY_SEC_BCR                                   15
>> +#define GCC_SDCC1_BCR                                          16
>> +#define GCC_SDCC2_BCR                                          17
>> +#define GCC_UFS_PHY_BCR                                                18
>> +#define GCC_USB30_PRIM_BCR                                     19
>> +#define GCC_USB3_DP_PHY_PRIM_BCR                               20
>> +#define GCC_USB3_DP_PHY_SEC_BCR                                        21
>> +#define GCC_USB3_PHY_PRIM_BCR                                  22
>> +#define GCC_USB3_PHY_SEC_BCR                                   23
>> +#define GCC_USB3PHY_PHY_PRIM_BCR                               24
>> +#define GCC_USB3PHY_PHY_SEC_BCR                                        25
>> +#define GCC_VCODEC0_BCR                                                26
>> +#define GCC_VENUS_BCR                                          27
>> +#define GCC_VIDEO_BCR                                          28
>> +#define GCC_VIDEO_VENUS_BCR                                    29
>> +#define GCC_VENUS_CTL_AXI_CLK_ARES                             30
>> +#define GCC_VIDEO_VENUS_CTL_CLK_ARES                           31
>> +
>> +#endif
>> --
>> 2.25.1
>>
> 
> 

-- 
Thanks, and Regards
Ajit
