Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E926678672D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 07:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239860AbjHXF1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 01:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239794AbjHXF0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 01:26:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25DA198;
        Wed, 23 Aug 2023 22:26:42 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O5DI8N026426;
        Thu, 24 Aug 2023 05:26:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bOgs1mB1zlTdBpD4rupOhWFVyHKEo2JmyL+UiN2aZes=;
 b=TQUoOIZ5MfHqPdB+DNAWASs+1cQmMhkpXO0mvZgV9cl67KnVxqz2mitCEt6IHQ05M5ID
 yAOUVo/yMxtqEVC2EBUPN9oFoQohgWJK001tGSX6bewIsSPyikcSyLs4Q0UWziP8fdEb
 fpzJCB94Lxfpz2YhRYQCjJBzoWxePqZzwEPOjCtB5NTj+tjVaSqGc9gO8CJodU/oGcSn
 3l2mmlEzuD7H+xpi49Fms70mxRL20+z/PmqgpNsO+IsSfN/kkJwxE4fDSgD4914PxVKy
 Spgr1/6VPumBXpsgyICyIEJORcT5figo1LtnjFJmq6WCjgVyTchK80jqkPC87KyaDGqV jQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3snxtar7fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 05:26:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37O5Q5fw012926
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 05:26:05 GMT
Received: from [10.216.48.216] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Wed, 23 Aug
 2023 22:25:54 -0700
Message-ID: <e07948d3-8766-b932-2eb4-7dc90b894f91@quicinc.com>
Date:   Thu, 24 Aug 2023 10:55:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 6/6] arm64: defconfig: Build NSS Clock Controller driver
 for IPQ9574
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>, <richardcochran@gmail.com>,
        <arnd@arndb.de>, <geert+renesas@glider.be>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <rafal@milecki.pl>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
CC:     <quic_saahtoma@quicinc.com>
References: <20230711093529.18355-1-quic_devipriy@quicinc.com>
 <20230711093529.18355-7-quic_devipriy@quicinc.com>
 <f234891f-c508-20de-6d6b-c7b37f6adb2b@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <f234891f-c508-20de-6d6b-c7b37f6adb2b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: z3CMQHD-4r6G21l9nMmw1F8IcRfDtqOs
X-Proofpoint-GUID: z3CMQHD-4r6G21l9nMmw1F8IcRfDtqOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_02,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0
 mlxlogscore=983 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240043
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/11/2023 4:18 PM, Dmitry Baryshkov wrote:
> On 11/07/2023 12:35, Devi Priya wrote:
>> Build Qualcomm IPQ9574 NSSCC driver.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
>> ---
>>   arch/arm64/configs/defconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 9ce0f1554f4d..d10083da2401 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -1180,6 +1180,7 @@ CONFIG_IPQ_GCC_5332=y
>>   CONFIG_IPQ_GCC_6018=y
>>   CONFIG_IPQ_GCC_8074=y
>>   CONFIG_IPQ_GCC_9574=y
>> +CONFIG_IPQ_NSSCC_9574=y
> 
> Can it work if it is built as a module? This defconfig is used on all 
> variety of platforms, including even non-Qualcomm ones. We are trying to 
> limit the built-in drivers list to the crucial-only ones.
> 
Sure, got it

Thanks,
Devi priya
>>   CONFIG_MSM_GCC_8916=y
>>   CONFIG_MSM_GCC_8994=y
>>   CONFIG_MSM_MMCC_8994=m
> 
