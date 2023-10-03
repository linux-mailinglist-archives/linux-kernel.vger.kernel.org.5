Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3597B66C9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbjJCKw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjJCKw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:52:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDC4B0;
        Tue,  3 Oct 2023 03:52:53 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393AjLNV031991;
        Tue, 3 Oct 2023 10:52:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=InmKVGM1KLLAk6jQd8wSrFaEvqZwF/oNWUzAeh/qEqI=;
 b=DDN9zv9cQeiWaxQQ0w6UtECF0C4Shy+aV6lPh86LWFbhS9FFAZftEGjJoCAsB++Y1QeJ
 gJZ1ZNbSjLzwriu+Ta4xxeB0NFJio9fxeQVGqLxyHzt2KKKAYbGTInH4cLp4vqop/OQt
 TNxI4gCQHyeXDFm5UgIDGA40BgpwZoknzh8x6bJt1+gQcqCFjC82AV5LH4YahCzeROn8
 v7axzXYahabrqorlwGoPoG/gifXRFqXEdJamo1M+sdNwHOG3pvfBUwMz7y7e6WdUVhlK
 iPOQn7wRR8rKOnXjDXzyp6DDz8HbXnB0GuGe3NwFSmwQGNtvqA7mquH5/PW6Up4r8uZw Tw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tgaw5gsdf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Oct 2023 10:52:46 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 393Aqjma017666
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Oct 2023 10:52:45 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 3 Oct
 2023 03:52:41 -0700
Message-ID: <8218d393-7840-49b9-b6d6-055a6ed372de@quicinc.com>
Date:   Tue, 3 Oct 2023 16:22:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64: dts: qcom: Add interconnect nodes for SDX75
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1696327472-21776-1-git-send-email-quic_rohiagar@quicinc.com>
 <1696327472-21776-2-git-send-email-quic_rohiagar@quicinc.com>
 <CAA8EJpp0+8FBtrmC7MGRkAdiavGSBUH7oAcQ0rN1OzLCWnsk8Q@mail.gmail.com>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <CAA8EJpp0+8FBtrmC7MGRkAdiavGSBUH7oAcQ0rN1OzLCWnsk8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6tnEZ5wUJn3u5FpiGNuWsO0RV0tsTAVV
X-Proofpoint-GUID: 6tnEZ5wUJn3u5FpiGNuWsO0RV0tsTAVV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_07,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=919 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310030076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/3/2023 3:35 PM, Dmitry Baryshkov wrote:
> On Tue, 3 Oct 2023 at 13:04, Rohit Agarwal <quic_rohiagar@quicinc.com> wrote:
>> Add interconnect nodes to support interconnects on SDX75.
>> Also parallely add the interconnect property for UART required
>> so that the bootup to shell does not break with interconnects
>> in place.
>>
>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sdx75.dtsi | 52 +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sdx75.dtsi b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> index e180aa4..ac0b785 100644
>> --- a/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sdx75.dtsi
>> @@ -8,6 +8,8 @@
>>
>>   #include <dt-bindings/clock/qcom,rpmh.h>
>>   #include <dt-bindings/clock/qcom,sdx75-gcc.h>
>> +#include <dt-bindings/interconnect/qcom,icc.h>
>> +#include <dt-bindings/interconnect/qcom,sdx75.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>>   #include <dt-bindings/power/qcom,rpmhpd.h>
>>   #include <dt-bindings/power/qcom-rpmpd.h>
>> @@ -197,6 +199,19 @@
>>                  };
>>          };
>>
>> +       clk_virt: interconnect-0 {
>> +               compatible = "qcom,sdx75-clk-virt";
>> +               #interconnect-cells = <2>;
>> +               qcom,bcm-voters = <&apps_bcm_voter>;
>> +               clocks = <&rpmhcc RPMH_QPIC_CLK>;
>> +       };
>> +
>> +       mc_virt: interconnect-1 {
>> +               compatible = "qcom,sdx75-mc-virt";
>> +               #interconnect-cells = <2>;
>> +               qcom,bcm-voters = <&apps_bcm_voter>;
>> +       };
> Interconnect comes after firmware, 'i' > 'f'.
Will update this.

Thanks,
Rohit.
>
>> +
>>          firmware {
>>                  scm: scm {
>>                          compatible = "qcom,scm-sdx75", "qcom,scm";
>> @@ -434,6 +449,9 @@
>>                          clock-names = "m-ahb",
>>                                        "s-ahb";
>>                          iommus = <&apps_smmu 0xe3 0x0>;
>> +                       interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
>> +                                        &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>;
>> +                       interconnect-names = "qup-core";
>>                          #address-cells = <2>;
>>                          #size-cells = <2>;
>>                          ranges;
>> @@ -444,6 +462,12 @@
>>                                  reg = <0x0 0x00984000 0x0 0x4000>;
>>                                  clocks = <&gcc GCC_QUPV3_WRAP0_S1_CLK>;
>>                                  clock-names = "se";
>> +                               interconnects = <&clk_virt MASTER_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS
>> +                                                &clk_virt SLAVE_QUP_CORE_0 QCOM_ICC_TAG_ALWAYS>,
>> +                                               <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
>> +                                                &system_noc SLAVE_QUP_0 QCOM_ICC_TAG_ALWAYS>;
>> +                               interconnect-names = "qup-core",
>> +                                                    "qup-config";
>>                                  interrupts = <GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH>;
>>                                  pinctrl-0 = <&qupv3_se1_2uart_active>;
>>                                  pinctrl-1 = <&qupv3_se1_2uart_sleep>;
>> @@ -453,6 +477,20 @@
>>                          };
>>                  };
>>
>> +               system_noc: interconnect@1640000 {
>> +                       compatible = "qcom,sdx75-system-noc";
>> +                       reg = <0x0 0x01640000 0x0 0x4b400>;
>> +                       #interconnect-cells = <2>;
>> +                       qcom,bcm-voters = <&apps_bcm_voter>;
>> +               };
>> +
>> +               pcie_anoc: interconnect@16c0000 {
>> +                       compatible = "qcom,sdx75-pcie-anoc";
>> +                       reg = <0x0 0x016c0000 0x0 0x14200>;
>> +                       #interconnect-cells = <2>;
>> +                       qcom,bcm-voters = <&apps_bcm_voter>;
>> +               };
>> +
>>                  tcsr_mutex: hwlock@1f40000 {
>>                          compatible = "qcom,tcsr-mutex";
>>                          reg = <0x0 0x01f40000 0x0 0x40000>;
>> @@ -733,6 +771,20 @@
>>                          #freq-domain-cells = <1>;
>>                          #clock-cells = <1>;
>>                  };
>> +
>> +               dc_noc: interconnect@190e0000 {
>> +                       compatible = "qcom,sdx75-dc-noc";
>> +                       reg = <0x0 0x190e0000 0x0 0x8200>;
>> +                       #interconnect-cells = <2>;
>> +                       qcom,bcm-voters = <&apps_bcm_voter>;
>> +               };
>> +
>> +               gem_noc: interconnect@19100000 {
>> +                       compatible = "qcom,sdx75-gem-noc";
>> +                       reg = <0x0 0x19100000 0x0 0x34080>;
>> +                       #interconnect-cells = <2>;
>> +                       qcom,bcm-voters = <&apps_bcm_voter>;
>> +               };
>>          };
>>
>>          timer {
>> --
>> 2.7.4
>>
>
