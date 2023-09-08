Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD3179832D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 09:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242527AbjIHHSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 03:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbjIHHSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 03:18:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93761BC8;
        Fri,  8 Sep 2023 00:18:34 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3886kSal002858;
        Fri, 8 Sep 2023 07:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AQRJztB1EIXtKQ30bg7zjUOkkFMv/a0+9Ng4lj8iTgQ=;
 b=DcHO3STdosLn517EPMu6SppVKk9ouXXBRs7clWZpgeQOZ39aEF1v1ur5eryeaSSTJAtx
 OlX06f7ysmGZWo5g7H7O/8spTxwTqbjReRQkl7ZmC8RAXZHAT0FvaLD4XvTY65gvwtLx
 bkMBCKcQlgNTks/NXbez15kp05NCsL1Io5x8gDNBIKAgw+/V/nBlGxSTEPaZsVwapEwq
 TJVwXFaQ5RKW0Yi2UYg7iUhy+WJh25bMCL6U4n+efuTT/Cxyk7mks8UpJaMSHEnqRXRu
 b5ducSAUAye0AZbiG8wtNLs9ZU0zrDLzKqvPlLsh9S3mSanURoRCyONG+c8L/TZH7I7R NQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3syaad2jx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Sep 2023 07:18:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3887IQ4j016159
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 8 Sep 2023 07:18:26 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Fri, 8 Sep
 2023 00:18:19 -0700
Message-ID: <88c10e82-65bf-4610-9bcb-f7c5cc10570e@quicinc.com>
Date:   Fri, 8 Sep 2023 15:18:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sm4450: Add apps_rsc and cmd_db
 node
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <lee@kernel.org>
CC:     <robimarko@gmail.com>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <kernel@quicinc.com>,
        <quic_bjorande@quicinc.com>, Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230908065847.28382-1-quic_tengfan@quicinc.com>
 <20230908065847.28382-5-quic_tengfan@quicinc.com>
 <5cc6b461-0a19-429c-ba06-7df73a48c46c@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <5cc6b461-0a19-429c-ba06-7df73a48c46c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Hdys387iJFyVno62Toh86agCinJgrNQj
X-Proofpoint-GUID: Hdys387iJFyVno62Toh86agCinJgrNQj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-08_04,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 suspectscore=0 clxscore=1011 mlxlogscore=999
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309080066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/8/2023 3:03 PM, Dmitry Baryshkov 写道:
> On 08/09/2023 09:58, Tengfei Fan wrote:
>> From: Ajit Pandey <quic_ajipan@quicinc.com>
>>
>> Add apps_rsc node and cmd_db memory region for sm4450.
>>
>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm4450.dtsi | 34 ++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi 
>> b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> index c4e5b33f5169..eb544d875806 100644
>> --- a/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> @@ -5,6 +5,7 @@
>>   #include <dt-bindings/gpio/gpio.h>
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/soc/qcom,rpmh-rsc.h>
>>   / {
>>       interrupt-parent = <&intc>;
>> @@ -328,6 +329,18 @@
>>           };
>>       };
>> +    reserved_memory: reserved-memory {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges;
>> +
>> +        aop_cmd_db_mem: cmd-db@80860000 {
> 
> Judging from sm8550, this should be aop-cmd-db-region@....
Got below message when internal review this node name, so update to 
cmd-db@80860000
"memory" is a "reserved word", so these nodes needs to be given a
non-generic name (contrary to all other cases), there was also a recent
cry from the maintainers that we don't need the "-region" suffix that
we've been using on recent platform.

> 
>> +            compatible = "qcom,cmd-db";
>> +            reg = <0x0 0x80860000 0x0 0x20000>;
>> +            no-map;
>> +        };
>> +    };
>> +
>>       soc: soc@0 {
>>           #address-cells = <2>;
>>           #size-cells = <2>;
>> @@ -335,6 +348,27 @@
>>           dma-ranges = <0 0 0 0 0x10 0>;
>>           compatible = "simple-bus";
>> +        apps_rsc: rsc@17a00000 {
>> +            label = "apps_rsc";
>> +            compatible = "qcom,rpmh-rsc";
>> +            reg = <0 0x17a00000 0 0x10000>,
>> +                  <0 0x17a10000 0 0x10000>,
>> +                  <0 0x17a20000 0 0x10000>;
>> +            reg-names = "drv-0", "drv-1", "drv-2";
>> +            interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +            qcom,tcs-offset = <0xd00>;
>> +            qcom,drv-id = <2>;
>> +            qcom,tcs-config = <ACTIVE_TCS    2>, <SLEEP_TCS     3>,
>> +                      <WAKE_TCS      3>, <CONTROL_TCS   0>;
>> +            power-domains = <&CLUSTER_PD>;
>> +
>> +            apps_bcm_voter: bcm-voter {
>> +                compatible = "qcom,bcm-voter";
>> +            };
>> +        };
>> +
>>           tcsr_mutex: hwlock@1f40000 {
>>               compatible = "qcom,tcsr-mutex";
>>               reg = <0x0 0x01f40000 0x0 0x40000>;
> 

-- 
Thx and BRs,
Tengfei Fan
