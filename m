Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CE87AA678
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjIVBZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjIVBZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:25:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988CC192;
        Thu, 21 Sep 2023 18:25:21 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38M1ET1t023003;
        Fri, 22 Sep 2023 01:24:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NmSSypGs9Y/wvJDReYuucGRWN+O6/bnRplLbvkL+ipc=;
 b=J/ePlgJRQnJnNzrCHb/8KwAjIXZ+o8USvh6ie2LedtI615Pr2CrmaZGmmmg7lUPn8B0v
 lvslY/tlt1O5Z6lUyxB8QSuIfzuqd93uRn07jPRM+29qBhfsqT5PeDf3SXOJFUGczUWX
 TrvSObUNKw4crs0U/swJBEX4D1hAFs+wnM5vbgGvG3eJBZAlQp5O0iPH7WHBuUNsx1/s
 hN+TSf2rAC+zD6e/tGnbUgBT9c5Ehz7HM2wNQEygnocU1+vA0UL2nMJCyEkuY8nzpqDi
 jlHjYYHVAxw/hH5YlNTOLmp+FKVaD6OqFGRUpc+DxwK/Is5lkabRUVLmIrxyjlGDm8Og Gg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3t8u0s0p5c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 01:24:29 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38M1OSQZ011233
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 22 Sep 2023 01:24:28 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 21 Sep
 2023 18:24:20 -0700
Message-ID: <6c9bee5a-fee6-4c0f-b165-57d40fb41a42@quicinc.com>
Date:   Fri, 22 Sep 2023 09:24:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] arm64: dts: qcom: sm4450: Add apps_rsc and cmd_db
 node
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <tglx@linutronix.de>, <maz@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <geert+renesas@glider.be>, <arnd@arndb.de>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <peng.fan@nxp.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <quic_shashim@quicinc.com>, <quic_kaushalk@quicinc.com>,
        <quic_tdas@quicinc.com>, <quic_tingweiz@quicinc.com>,
        <quic_aiquny@quicinc.com>, <quic_ajipan@quicinc.com>,
        <kernel@quicinc.com>
References: <20230920065459.12738-1-quic_tengfan@quicinc.com>
 <20230920065459.12738-3-quic_tengfan@quicinc.com>
 <479ce1da-10e5-589d-cb98-e7fef98c5543@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <479ce1da-10e5-589d-cb98-e7fef98c5543@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JGsxiVvRye5xAMH_CplCAfaHbVGQhVcF
X-Proofpoint-ORIG-GUID: JGsxiVvRye5xAMH_CplCAfaHbVGQhVcF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-22_01,2023-09-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309220011
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 9/20/2023 6:14 PM, Konrad Dybcio 写道:
> 
> 
> On 9/20/23 08:54, Tengfei Fan wrote:
>> From: Ajit Pandey <quic_ajipan@quicinc.com>
>>
>> Add apps_rsc node and cmd_db memory region for sm4450.
>>
>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sm4450.dtsi | 35 ++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm4450.dtsi 
>> b/arch/arm64/boot/dts/qcom/sm4450.dtsi
>> index c4e5b33f5169..3d9d3b5e9510 100644
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
>> +            compatible = "qcom,cmd-db";
>> +            reg = <0x0 0x80860000 0x0 0x20000>;
>> +            no-map;
>> +        };
>> +    };
>> +
>>       soc: soc@0 {
>>           #address-cells = <2>;
>>           #size-cells = <2>;
>> @@ -419,6 +432,28 @@
>>                   status = "disabled";
>>               };
>>           };
>> +
>> +        apps_rsc: rsc@17a00000 {
>> +            compatible = "qcom,rpmh-rsc";
>> +            reg = <0 0x17a00000 0 0x10000>,
>> +                  <0 0x17a10000 0 0x10000>,
>> +                  <0 0x17a20000 0 0x10000>;
> 0x0 for consistency
Hi Konrad,
Yes, I will update "0" to "0x0" for consistency.
> 
>> +            reg-names = "drv-0", "drv-1", "drv-2";
>> +            interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
>> +                     <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
>> +            label = "apps_rsc";
>> +            qcom,tcs-offset = <0xd00>;
>> +            qcom,drv-id = <2>;
>> +            qcom,tcs-config = <ACTIVE_TCS    2>, <SLEEP_TCS     3>,
>> +                      <WAKE_TCS      3>, <CONTROL_TCS   0>;
> You haven't addressed Bjorn's comment about the number of
> CONTROL_TCSes, are you sure 0 is correct?
> 
> Konrad
I got confirm from internal power team, setting CONTROL_TCS with 0 is 
correct.


-- 
Thx and BRs,
Tengfei Fan
