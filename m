Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEA975ACD1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 13:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGTLRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 07:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjGTLQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 07:16:36 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA1BE;
        Thu, 20 Jul 2023 04:16:19 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KBDrYg021492;
        Thu, 20 Jul 2023 11:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Y/AVyy3eVUhLJPSl/fjofbi3XXu96ZS05+ot+xzodXA=;
 b=BnNwQfuOwa5I4RqXetQXSh79oqmLMQ3MxHEKl40njhyKj5SlgY6dgg0nbNb0jeGHO3Fz
 PAtUyZSZBWuSBfGVBZRPCmINIsOwjmyLd8boxOfZvYIRxKHrV56tbdDr65/lTsxfGEjS
 7tll+jwr7Azf2/42BDHm2mRkuXOowgyoOAe1bcethnaPZsd0Z4heg/wKa/Xt6FqhPOEn
 gd8Mil7KhZ3wXqfPOMBTNfpshRAVzAWB5g+Cbfl8Bu2RDRaqj3ZWiDglwvigM5wdnVfk
 MkWcrT7rzSs0tqa3y+QUNqW2jCeACxh2RHg0bqa7Bwqp9jUMf2e7qmr2OCYVfqO1onXh nA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rxexkjfx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:16:14 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36KBGBcO009098
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jul 2023 11:16:11 GMT
Received: from [10.201.197.30] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 20 Jul
 2023 04:16:07 -0700
Message-ID: <267e7d8d-887e-99e8-f367-f6b614a721fb@quicinc.com>
Date:   Thu, 20 Jul 2023 16:46:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] arm64: dts: qcom: ipq5018: add support for the RDP415
 variant
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <quic_srichara@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>
References: <20230720074846.20350-1-quic_harihk@quicinc.com>
 <20230720074846.20350-3-quic_harihk@quicinc.com>
 <6f26ab9d-cf92-e918-866c-daa68096ee08@linaro.org>
From:   Hariharan K <quic_harihk@quicinc.com>
In-Reply-To: <6f26ab9d-cf92-e918-866c-daa68096ee08@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: xIjgTt_tvrlytDtmoN-RK_-50dpItyKr
X-Proofpoint-GUID: xIjgTt_tvrlytDtmoN-RK_-50dpItyKr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_04,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 mlxlogscore=827 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307200094
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/2023 1:46 PM, Konrad Dybcio wrote:
> On 20.07.2023 09:48, Hariharan K wrote:
>> Add the initial device tree support for the Reference Design
>> Platform(RDP) 415 based on IPQ5018 family of SoC. This patch
>> carries the support for Console UART and eMMC.
>>
>> Signed-off-by: Hariharan K <quic_harihk@quicinc.com>
>> ---
> [...]
> 
>> +
>> +&sdhc_1 {
>> +	pinctrl-0 = <&sdc_default_state>;
>> +	pinctrl-names = "default";
>> +	mmc-ddr-1_8v;
>> +	mmc-hs200-1_8v;
>> +	max-frequency = <192000000>;
>> +	bus-width = <4>;
>> +	status = "okay";
> Since some (but presumably not all) SKUs have SDHCI, you can define
> the plumbing for it in the common DTSI but only enable it on ones
> that do (or disable on those that don't)

Sure. Will update in the next version.

Best regards,
Hariharan K

> 
> Konrad
