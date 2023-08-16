Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088AB77DD07
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 11:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243229AbjHPJNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 05:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237338AbjHPJNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 05:13:10 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C44173F;
        Wed, 16 Aug 2023 02:13:07 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37G7xCxx008027;
        Wed, 16 Aug 2023 09:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=h8/aEe7kEtX6gF0ysHwTfSvOItaRpNuIkrapdMZFKQk=;
 b=KhIDwfVOVH/Y6ga704Nljnx0Dudy38UswT4QSS1e8G70UvMHv5Tnzpg3oLbXDoK7sjIR
 bbhqxBt1TVJA2Ku9e3TRZfmlKb6902thXBsbKNVYsxhynBht53y6sIzA+LHp23Qjzo7j
 P/KHMaIuoz4uyse7YAAQRnTprxun8Ws7gmSy6xbtWim7ZMIeN4dBaRKt62DxIdZkSzuN
 nkglRcnxCX8YGOksNx0pNqHNnez2QwcHht96w+2+ItKmcUchCE9xTDlcZLcf31sqzwrK
 C3L+7McSf65g/UsL8QBEbElvnYVqFjFJMoPRhyAl1ul2jb+3/8stANiYRULoQ3RnXbTy qQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sgmkkrrww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 09:12:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37G9CpKW003766
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 09:12:51 GMT
Received: from [10.253.34.149] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 16 Aug
 2023 02:12:47 -0700
Message-ID: <7b3d8099-9a1f-4314-2f7d-f51ca2aeed5e@quicinc.com>
Date:   Wed, 16 Aug 2023 17:12:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 2/4] dt-bindings: clock: add qca8386/qca8084 clock and
 reset definitions
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230815085205.9868-1-quic_luoj@quicinc.com>
 <20230815085205.9868-3-quic_luoj@quicinc.com>
 <3c702ccd-6a82-1121-0b4e-9529d82ccc13@linaro.org>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <3c702ccd-6a82-1121-0b4e-9529d82ccc13@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cNJxEHmu20F18Px8cdb3tIoKJUxkIX3T
X-Proofpoint-GUID: cNJxEHmu20F18Px8cdb3tIoKJUxkIX3T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_07,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=904 spamscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160081
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/15/2023 5:15 PM, Krzysztof Kozlowski wrote:
> On 15/08/2023 10:52, Luo Jie wrote:
>> QCA8386/QCA8084 includes the clock & reset controller that is
>> accessed by MDIO bus. Two work modes are supported, qca8386 works
>> as switch mode, qca8084 works as PHY mode.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> 
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tag is "received", when
> provided in a message replied to you on the mailing list. Tools like b4
> can help here. However, there's no need to repost patches *only* to add
> the tags. The upstream maintainer will do that for tags received on the
> version they apply.
> 
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> 
> Best regards,
> Krzysztof
> 
Okay, got it, thanks Krzysztof for the reminder.
