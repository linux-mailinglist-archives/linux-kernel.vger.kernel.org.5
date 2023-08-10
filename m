Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199F1776F3A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 06:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjHJEv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 00:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjHJEvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 00:51:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B762111;
        Wed,  9 Aug 2023 21:51:55 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A2pbft013813;
        Thu, 10 Aug 2023 04:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kFmXhoSZ5LZVC13vVJs34RGYU0yi9sf5UgFh3xp9E2E=;
 b=KRq7E4TzGVxl+w8XWxfQn39TAdKg8WuiJ7V1Dat2jzSYqILQee/zl0t5cA8ezB3x28qs
 ij8+aqxfHB7YJuKPKb5vQNaNLDwdKR3hzMR63a7clpXTMFQUKj5wP9autqNLVfaLT1l1
 j2IJAcff12D2J3ht83/XXrmC477oCnlatruyXrxc05CvJG/JR+ULYoI1UfC66HfkjAHW
 tSe5BEK0+UQkMKQjZeIx2LnRnJKhzUvGsWcgS1ulVvSbq8cp4XVp3VWmFDNdZO2D/0Xs
 xRmtMXATQ1WWnOxn5GCNKxQVywhy1hwzIEw0c/MUiMHH4KwhzFRUCeTyIgqU3qgohwSC 2Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc5es2dvt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 04:51:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A4peEJ002193
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 04:51:40 GMT
Received: from [10.253.39.188] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 21:51:35 -0700
Message-ID: <8189905f-861d-371e-52f8-6953e928262a@quicinc.com>
Date:   Thu, 10 Aug 2023 12:51:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 0/4] add clock controller of qca8386/qca8084
Content-Language: en-US
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
References: <20230809080047.19877-1-quic_luoj@quicinc.com>
 <0aa707b9-8fa0-be00-af8f-dd57828cd336@linaro.org>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <0aa707b9-8fa0-be00-af8f-dd57828cd336@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Wj5B3xI-rY2ju2GYl6BzzrNfOIfIAz2h
X-Proofpoint-GUID: Wj5B3xI-rY2ju2GYl6BzzrNfOIfIAz2h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_02,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=744
 spamscore=0 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100042
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/2023 11:32 PM, Krzysztof Kozlowski wrote:
> On 09/08/2023 10:00, Luo Jie wrote:
>> qca8xxx is 4 * 2.5GBaseT ports chip, working as switch mode
>> named by qca8386, or working as PHY mode named by qca8084,
>> clock hardware reigster is accessed by MDIO bus.
>>
>> This patch series add the clock controller of qca8363/qca8084,
>> and add the clock ops clk_branch2_qca8k_ops to avoid spin lock
>> used during the clock operation of qca8k clock controller where
>> the sleep happens when accessing clock control register by MDIO
>> bus.
>>
>> Changes in v1:
>> 	* remove clock flag CLK_ENABLE_MUTEX_LOCK.
>> 	* add clock ops clk_branch2_qca8k_ops.
>> 	* improve yaml file for fixing dtschema warnings.
>> 	* enable clock controller driver in defconfig.
> 
> So this is v2, not v1. Your next version, if happens, will be v3, please.
> 
> Best regards,
> Krzysztof
> 
got it, i will use V3 in the next patch set, thanks Krzysztof.
