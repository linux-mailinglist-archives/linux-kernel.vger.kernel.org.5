Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747267E2686
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 15:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjKFOVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 09:21:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjKFOVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 09:21:45 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB67B8;
        Mon,  6 Nov 2023 06:21:42 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A6CIQsB016441;
        Mon, 6 Nov 2023 14:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sfQu0EihO7InF9XjKQ/DwguvwSmRl6Q79sCZ6g91iio=;
 b=a5FycRqKL73bJ4Nr0VjfGEgb2BISfb3fSgol74N2VDFPSIvCs8OunNosR2iMsuNo5/cz
 vIhWDiYyFTf+LCR3KETljY/drkII7I26rXGFx4nYZyN2JVp6/z7Ra43NBsmVjQJm1qgZ
 lXsKfaHWQy99c0N0AIidv8VmRu+szLeB69lWMNOFTO3ltqj+COxZUEdHgbqCjl8Dm1Zi
 t9+1/iWwWDHtGbWa2bVvoPwlnDnUDCHoy32hWuc8FVC8dUV0VpHOJ4D+NyEqLT5fO1Km
 4oNByJgqXTmST/wSi6Boq4WFMcj/FoW9ILCywJhIp8dhIxw4c00CXkeeUvsnT7241oXq 1g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u5efymfua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Nov 2023 14:21:36 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A6ELY6R017355
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 6 Nov 2023 14:21:34 GMT
Received: from [10.216.12.16] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 6 Nov
 2023 06:21:27 -0800
Message-ID: <eb4f49da-ecc4-54d7-1c40-efc48306308b@quicinc.com>
Date:   Mon, 6 Nov 2023 19:51:24 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 2/2] phy: qcom-qmp-pcie: Add support for keeping refclk
 always on
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_vpernami@quicinc.com>, <quic_parass@quicinc.com>
References: <20231106-refclk_always_on-v1-0-17a7fd8b532b@quicinc.com>
 <20231106-refclk_always_on-v1-2-17a7fd8b532b@quicinc.com>
 <CAA8EJpq9azRC5msZfS1V8NK4EmPN+jxh+99yGEyQ+EWkk1gROQ@mail.gmail.com>
From:   Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <CAA8EJpq9azRC5msZfS1V8NK4EmPN+jxh+99yGEyQ+EWkk1gROQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Vfh6WjbSCuhmY7NFxv9Ke-XtWw49Sl9s
X-Proofpoint-ORIG-GUID: Vfh6WjbSCuhmY7NFxv9Ke-XtWw49Sl9s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-06_12,2023-11-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1015
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311060116
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/6/2023 5:43 PM, Dmitry Baryshkov wrote:
> On Mon, 6 Nov 2023 at 13:53, Krishna chaitanya chundru
> <quic_krichai@quicinc.com> wrote:
>> In PCIe low power states like L1.1 or L1.2 the phy will stop
>> supplying refclk to endpoint. If endpoint asserts clkreq to bring
>> back link L0, then RC needs to provide refclk to endpoint.
>>
>> If there is some issues in platform with clkreq signal propagation
>> to host and due to that host will not send refclk which results PCIe link
>> down. For those platforms  phy needs to provide refclk even in low power
>> states.
>>
>> Add a flag which indicates refclk is always supplied to endpoint.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 21 +++++++++++++++++----
>>   1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> index a63ca7424974..d7e377a7d96e 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
>> @@ -43,6 +43,8 @@
>>   /* QPHY_PCS_STATUS bit */
>>   #define PHYSTATUS                              BIT(6)
>>   #define PHYSTATUS_4_20                         BIT(7)
>> +/* PCS_PCIE_ENDPOINT_REFCLK_CNTRL */
>> +#define EPCLK_ALWAYS_ON_EN                     BIT(6)
>
>>   #define PHY_INIT_COMPLETE_TIMEOUT              10000
>>
>> @@ -77,6 +79,7 @@ enum qphy_reg_layout {
>>          QPHY_START_CTRL,
>>          QPHY_PCS_STATUS,
>>          QPHY_PCS_POWER_DOWN_CONTROL,
>> +       QPHY_PCS_ENDPOINT_REFCLK_CNTRL,
>>          /* Keep last to ensure regs_layout arrays are properly initialized */
>>          QPHY_LAYOUT_SIZE
>>   };
>> @@ -103,10 +106,11 @@ static const unsigned int sdm845_qhp_pciephy_regs_layout[QPHY_LAYOUT_SIZE] = {
>>   };
>>
>>   static const unsigned int pciephy_v4_regs_layout[QPHY_LAYOUT_SIZE] = {
>> -       [QPHY_SW_RESET]                 = QPHY_V4_PCS_SW_RESET,
>> -       [QPHY_START_CTRL]               = QPHY_V4_PCS_START_CONTROL,
>> -       [QPHY_PCS_STATUS]               = QPHY_V4_PCS_PCS_STATUS1,
>> -       [QPHY_PCS_POWER_DOWN_CONTROL]   = QPHY_V4_PCS_POWER_DOWN_CONTROL,
>> +       [QPHY_SW_RESET]                         = QPHY_V4_PCS_SW_RESET,
>> +       [QPHY_START_CTRL]                       = QPHY_V4_PCS_START_CONTROL,
>> +       [QPHY_PCS_STATUS]                       = QPHY_V4_PCS_PCS_STATUS1,
>> +       [QPHY_PCS_POWER_DOWN_CONTROL]           = QPHY_V4_PCS_POWER_DOWN_CONTROL,
> No unnecessary whitespace changes, please.
I will remove above white space and keep below change as it is as it is 
throwing error as white space required there
>
>> +       [QPHY_PCS_ENDPOINT_REFCLK_CNTRL]        = QPHY_V4_PCS_PCIE_ENDPOINT_REFCLK_CNTRL,
> Any other platform having this register?
we have this register for other platforms also I will add that register 
in which ever versions it exits in next patch
>
>>   };
>>
>>   static const unsigned int pciephy_v5_regs_layout[QPHY_LAYOUT_SIZE] = {
>> @@ -2244,6 +2248,8 @@ struct qmp_pcie {
>>          struct phy *phy;
>>          int mode;
>>
>> +       bool refclk_always_on;
>> +
>>          struct clk_fixed_rate pipe_clk_fixed;
>>   };
>>
>> @@ -3159,6 +3165,10 @@ static void qmp_pcie_init_registers(struct qmp_pcie *qmp, const struct qmp_phy_c
>>          qmp_pcie_configure(pcs, tbls->pcs, tbls->pcs_num);
>>          qmp_pcie_configure(pcs_misc, tbls->pcs_misc, tbls->pcs_misc_num);
>>
>> +       if (qmp->refclk_always_on && cfg->regs[QPHY_PCS_ENDPOINT_REFCLK_CNTRL])
>> +               qphy_setbits(pcs_misc, cfg->regs[QPHY_PCS_ENDPOINT_REFCLK_CNTRL],
>> +                            EPCLK_ALWAYS_ON_EN);
>> +
>>          if (cfg->lanes >= 4 && qmp->tcsr_4ln_config) {
>>                  qmp_pcie_configure(serdes, cfg->serdes_4ln_tbl, cfg->serdes_4ln_num);
>>                  qmp_pcie_init_port_b(qmp, tbls);
>> @@ -3681,6 +3691,9 @@ static int qmp_pcie_probe(struct platform_device *pdev)
>>          if (ret)
>>                  goto err_node_put;
>>
>> +       qmp->refclk_always_on = of_property_read_bool(dev->of_node,
>> +                                                     "qcom,refclk-always-on");
> Error out if !cfg->regs[QPHY_PCS_ENDPOINT_REFCLK_CNTRL]).
> Otherwise your DT value can be silently ignored.

sure I will add this in next patch series.

- Krishna Chaitanya.

>> +
>>          ret = phy_pipe_clk_register(qmp, np);
>>          if (ret)
>>                  goto err_node_put;
>>
>> --
>> 2.42.0
>>
>
