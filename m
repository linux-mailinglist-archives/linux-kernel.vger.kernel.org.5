Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E244A7B0186
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 12:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjI0KJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 06:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbjI0KIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 06:08:22 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34CAEB;
        Wed, 27 Sep 2023 03:08:20 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R9dL5S001454;
        Wed, 27 Sep 2023 10:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vcmf/AbqgkauR+V3cXJxEoKuVFxfwi5GPyt7nCXwHtQ=;
 b=iE3sLYMpOIdQzkImaHGeJihVeIQGwAu9Yr9Jpfwx8cP2UDB8CeLzQS2gfk3WyKIanhXD
 WvzPK5YH8RHcVNEP4RyY2fq9n6JGaN/+SpewQ9GyIwka06RU61MB5tLa7EYxUG6G1226
 RZ3xKPzWzfNyvFvR638NBaqMVjcvXS5q1wpLqK2e1aF8IOyGHOv+dFnL+2onD02fPuBY
 Lyp3DY5wtiJaNAnrfzXRpia1dbjPVM7tr8aCM5XZXW311sFbF0Zw95n0kEw0LYO+4VnP
 IVNOcaDo6rSclsbatH30r0ivhFLMnSJogzN+MA6ystF+9nRTlZGfrlW16VzoA4gHdL26 Ow== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tcda7rkqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 10:08:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38RA88v2017101
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 10:08:08 GMT
Received: from [10.218.45.181] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 27 Sep
 2023 03:08:03 -0700
Message-ID: <4e130774-0f4f-eaf1-3916-2860ea232150@quicinc.com>
Date:   Wed, 27 Sep 2023 15:38:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V3 3/4] arm64: dts: qcom: sc7280: Add UFS nodes for sc7280
 IDP board
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <mani@kernel.org>,
        <alim.akhtar@samsung.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20230927081858.15961-1-quic_nitirawa@quicinc.com>
 <20230927081858.15961-4-quic_nitirawa@quicinc.com>
 <b5146a7f-91b6-480c-b61a-514a365dc41d@linaro.org>
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <b5146a7f-91b6-480c-b61a-514a365dc41d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xa7tpmUHRGUe-ofpUtvO91LwwWOcl2G4
X-Proofpoint-GUID: xa7tpmUHRGUe-ofpUtvO91LwwWOcl2G4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_05,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=846 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270083
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/2023 2:55 PM, Konrad Dybcio wrote:
> On 27.09.2023 10:18, Nitin Rawat wrote:
>> Add UFS host controller and PHY nodes for sc7280 IDP board.
>>
>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/sc7280-idp.dtsi | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> index 2ff549f4dc7a..a0059527d9e4 100644
>> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
>> @@ -499,6 +499,25 @@
>>   	status = "okay";
>>   };
>>
>> +&ufs_mem_hc {
>> +	reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
>> +	vcc-supply = <&vreg_l7b_2p9>;
>> +	vcc-max-microamp = <800000>;
>> +	vccq-supply = <&vreg_l9b_1p2>;
>> +	vccq-max-microamp = <900000>;
>> +	vccq2-supply = <&vreg_l9b_1p2>;
>> +	vccq2-max-microamp = <900000>;
> Were you able to confirm it's correct (see the q in [1])
Sorry I missed to reply to your query in my last reply .
Yes Kodiak support both UFS2.x and UFS3.x and UFS2.x needs
vccq2 . Hence we need that node.


> 
> Konrad
> 
> [1] https://lore.kernel.org/linux-arm-msm/20230926162042.14180-1-quic_nitirawa@quicinc.com/T/#m72ca82a9145af380ffd37415455d6ef3d4195795
