Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6377AA66C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjIVBRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVBRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:17:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7C6CC;
        Thu, 21 Sep 2023 18:16:56 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M1EWNL007144;
        Fri, 22 Sep 2023 01:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9w/IvZDIHWszFH1Ek0ypivr8vKkPAhorWbAZ9pveNCw=;
 b=Zl+gPP1bJrmAyIy4/jZ/Jw4HYqHOylLpyDbdOObaRRInCisgH40Jhp+R62JtW7Vwj23n
 Ww0K2m/iXCHiaVzfHeNSK15IiMOBQWzh2IUElkjVp5xqu1wTsu7sVaiXsk6/YnBibziZ
 Y/SKwVarI991Jvo1iqiaCVq3qPzv82ILTWlJ7I6M9wFHsYHNy1TiaEvtesW364JXLAnM
 TC8PVU3LOGiHnOxfRHV46Axx1nWuKoiWqolFLbvMvxj+iuVygd9FEvhmKis6odMrHBFu
 lLWlSsHmiqfaeKAWtC1T50lvbMJlRwuj5kRxkI6quyFlVtx44z5EpY9crErEiAynglnx NQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8txpgnk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 01:16:17 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38M1GFiF013645
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 01:16:16 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 21 Sep
 2023 18:16:07 -0700
Message-ID: <e3391f32-0684-473e-8602-13293bd0f36d@quicinc.com>
Date:   Fri, 22 Sep 2023 09:16:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] arm64: dts: qcom: sm4450: Add apps_rsc and cmd_db
 node
To:     Bjorn Andersson <andersson@kernel.org>
CC:     <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <catalin.marinas@arm.com>,
        <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230915021509.25773-1-quic_tengfan@quicinc.com>
 <20230915021509.25773-7-quic_tengfan@quicinc.com>
 <kk3xwrq6d7jpkoti2b4lg4hwqfoyqilvf7cp3tuccfmhdj57rf@hicfde4whvzm>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <kk3xwrq6d7jpkoti2b4lg4hwqfoyqilvf7cp3tuccfmhdj57rf@hicfde4whvzm>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: pkGtoYlBqaxvEB2KOcQGLRxJAq0e2MYx
X-Proofpoint-GUID: pkGtoYlBqaxvEB2KOcQGLRxJAq0e2MYx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_01,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220010
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/20/2023 11:49 AM, Bjorn Andersson 写道:
> On Fri, Sep 15, 2023 at 10:15:06AM +0800, Tengfei Fan wrote:
>> From: Ajit Pandey <quic_ajipan@quicinc.com>
>>
>> Add apps_rsc node and cmd_db memory region for sm4450.
>>
>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm4450.dtsi | 34 ++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> index c4e5b33f5169..0d1d39197d77 100644
>> --- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> @@ -5,6 +5,7 @@
>>   
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   
>>   / {
>>   	interrupt-parent = <&intc>;
>> @@ -328,6 +329,18 @@
>>   		};
>>   	};
>>   
>> +	reserved_memory: reserved-memory {
>> +		#address-cells = <2>;
>> +		#size-cells = <2>;
>> +		ranges;
>> +
>> +		aop_cmd_db_mem: cmd-db@80860000 {
>> +			compatible = "qcom,cmd-db";
>> +			reg = <0x0 0x80860000 0x0 0x20000>;
>> +			no-map;
>> +		};
>> +	};
>> +
>>   	soc: soc@0 {
>>   		#address-cells = <2>;
>>   		#size-cells = <2>;
>> @@ -335,6 +348,27 @@
>>   		dma-ranges = <0 0 0 0 0x10 0>;
>>   		compatible = "simple-bus";
>>   
>> +		apps_rsc: rsc@17a00000 {
>> +			compatible = "qcom,rpmh-rsc";
>> +			reg = <0 0x17a00000 0 0x10000>,
> 
> As your later patch shows, and Krzysztof pointed out, the sort order is
> wrong here (sort nodes under /soc by address).
I will ajdust this sort order.
> 
>> +			      <0 0x17a10000 0 0x10000>,
>> +			      <0 0x17a20000 0 0x10000>;
>> +			reg-names = "drv-0", "drv-1", "drv-2";
>> +			interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>> +				     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +			label = "apps_rsc";
>> +			qcom,tcs-offset = <0xd00>;
>> +			qcom,drv-id = <2>;
>> +			qcom,tcs-config = <ACTIVE_TCS    2>, <SLEEP_TCS     3>,
>> +					  <WAKE_TCS      3>, <CONTROL_TCS   0>;
> 
> Please confirm that you indeed want 0 CONTROL_TCSs.
> 
> Thanks,
> Bjorn
Hi Bjorn,
yes, I confirmed this from internal power team, CONTROL_TCS with 0 is ok.
> 
>> +			power-domains = <&CLUSTER_PD>;
>> +
>> +			apps_bcm_voter: bcm-voter {
>> +				compatible = "qcom,bcm-voter";
>> +			};
>> +		};
>> +
>>   		tcsr_mutex: hwlock@1f40000 {
>>   			compatible = "qcom,tcsr-mutex";
>>   			reg = <0x0 0x01f40000 0x0 0x40000>;
>> -- 
>> 2.17.1
>>

-- 
Thx and BRs,
Tengfei Fan
