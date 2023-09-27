Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D539B7AFE30
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjI0IW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjI0IV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:21:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1090A95;
        Wed, 27 Sep 2023 01:21:55 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R6pSev007299;
        Wed, 27 Sep 2023 08:21:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8YEEJs7TF2Rwgbmw3waJ5/TM14s5m5qzE3Tt2KN3g+0=;
 b=EErM6lM94k6i7TtvPVy8a6I/VwQDUg/OTHjACmWyFU9zC/PB+Ffvvu+Q31uOn1mY3ghc
 eevXIJqVsjQXmgYFJanYzwCA7eQMBxs0C5KbVFccf5LMOHfKvO7d9XDsqHu8rm8OEo/w
 KbRiV6PNFXLxHB1eZsyPfiyvFcNvV9ynoxxDPzZQqd6ChwU8VlLZXG/N+SSfJ7LB9GoD
 6/otjDsClkKpjUGE1hVWK+kjvPySkb5yIEG6KbkOxte1XVfmfy1Ca71i5+W7KHIgsAvs
 VkfdX0JKTMDFkpMhrU5h2Z0Jhzzc7wdJKnilwg6/Dkzz1JJG5p+DGFHXid8Nmw/Klrzv Ww== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tc179hxrx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 08:21:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R8Li1A001951
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 08:21:44 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 27 Sep
 2023 01:21:39 -0700
Message-ID: <10b19caa-466b-e98e-a6e1-05658ff74cd0@quicinc.com>
Date:   Wed, 27 Sep 2023 13:51:35 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V2 2/3] arm64: dts: qcom: sc7280: Add UFS nodes for sc7280
 soc
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <mani@kernel.org>,
        <alim.akhtar@samsung.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230926162042.14180-1-quic_nitirawa@quicinc.com>
 <20230926162042.14180-3-quic_nitirawa@quicinc.com>
 <e6c77627-c257-45e1-b4bd-19807aefd829@linaro.org>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <e6c77627-c257-45e1-b4bd-19807aefd829@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BU4hg_CHuQlF71heKdsNS59VmTs8rNQO
X-Proofpoint-ORIG-GUID: BU4hg_CHuQlF71heKdsNS59VmTs8rNQO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270067
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/2023 12:01 AM, Konrad Dybcio wrote:
> On 26.09.2023 18:20, Nitin Rawat wrote:
>> Add UFS host controller and PHY nodes for sc7280 soc.
>>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280.dtsi | 64 ++++++++++++++++++++++++++++
>>   1 file changed, 64 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> index 66f1eb83cca7..3be8ea090ade 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
>> @@ -3353,6 +3353,70 @@
>>   			};
>>   		};
>>
>> +		ufs_mem_hc: ufs@1d84000 {
>> +			compatible = "qcom,sc7280-ufshc", "qcom,ufshc",
>> +				     "jedec,ufs-2.0";
>> +			reg = <0x0 0x01d84000 0x0 0x3000>;
>> +			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>;
>> +			phys = <&ufs_mem_phy>;
>> +			phy-names = "ufsphy";
>> +			lanes-per-direction = <2>;
>> +			#reset-cells = <1>;
>> +			resets = <&gcc GCC_UFS_PHY_BCR>;
>> +			reset-names = "rst";
>> +
>> +			power-domains = <&gcc GCC_UFS_PHY_GDSC>;
>> +			required-opps = <&rpmhpd_opp_nom>;
>> +
>> +			iommus = <&apps_smmu 0x80 0x0>;
>> +			dma-coherent;
>> +
>> +			clock-names = "core_clk",
>> +				      "bus_aggr_clk",
>> +				      "iface_clk",
>> +				      "core_clk_unipro",
>> +				      "ref_clk",
>> +				      "tx_lane0_sync_clk",
>> +				      "rx_lane0_sync_clk",
>> +				      "rx_lane1_sync_clk";
> As discussed, property-names is preferred to come after
> property, just like in the other node you're adding.
Sure. Updated this in latest patchset and updated the binding as well.

> 
> [...]
> 
>> +		ufs_mem_phy: phy@1d87000 {
>> +			compatible = "qcom,sc7280-qmp-ufs-phy";
>> +			reg = <0x0 0x01d87000 0x0 0xe00>;
>> +			clocks = <&rpmhcc RPMH_CXO_CLK>,
>> +				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
>> +				 <&gcc GCC_UFS_1_CLKREF_EN>;
>> +			clock-names = "ref", "ref_aux", "qref";
>> +
>> +			resets = <&ufs_mem_hc 0>;
>> +			reset-names = "ufsphy";
>> +
>> +			#clock-cells = <1>;
>> +			#phy-cells = <0>;
>> +
>> +			status = "disabled";
>> +
>> +		};
> Stray newline above.
Removed this in latest Patchset

> 
> Konrad

Thanks,
Nitin
