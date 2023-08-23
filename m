Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C034B785550
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjHWKZS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjHWKZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:25:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAC211F;
        Wed, 23 Aug 2023 03:25:12 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N9ULXg016321;
        Wed, 23 Aug 2023 10:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=K5KxTV25eSkKqVuPGc6yQJ66jbQLXcAGnNjeCidT3UQ=;
 b=o5UngKoeSvDyA91pfj7O9oBE6EvrhS223fgCv2nm2JVedgtuEgXdylP85+vkI3/xXkxV
 IwIYNAUjDnfIPAzpIGlf1MiYCtVvxPwi2MuL9oEUJ1uDbZZylGRQ8ilumYz9K4Ds/M23
 maBtbKlQpfYiR2aHRLsVB1TrAfO0zGdQ2CKCZKNhj42XSh8SlMVwi3+y5TbmPNZ+j0Kv
 gqXa2qTW19/et3xBhw+tonGrZsJevYvohQWS9E33sg/lRhojwY9rvzLSl4b4YYuFN7SK
 8JRSnenR7OYOtCNCWq/+B5EeE/hJ243fjHjo5eHXxMs55rIfq+PxgPTZOQKWEWMUnnu+ mA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn2mvhjne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 10:25:03 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37NAP1Lx016960
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 10:25:02 GMT
Received: from [10.253.13.101] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 23 Aug
 2023 03:24:58 -0700
Message-ID: <7eaca76f-e7ad-cb1c-5a1d-5a2b68357e9c@quicinc.com>
Date:   Wed, 23 Aug 2023 18:24:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 2/4] dt-bindings: clock: add qca8386/qca8084 clock and
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
References: <20230823085031.27252-1-quic_luoj@quicinc.com>
 <20230823085031.27252-3-quic_luoj@quicinc.com>
 <692b7775-eeda-3c5b-cc24-c5dbdbb38c71@linaro.org>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <692b7775-eeda-3c5b-cc24-c5dbdbb38c71@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4eGDYzjcRDnS-wAmADU4X7l1O_k-SKiC
X-Proofpoint-GUID: 4eGDYzjcRDnS-wAmADU4X7l1O_k-SKiC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 mlxlogscore=742 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230094
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/2023 6:11 PM, Krzysztof Kozlowski wrote:
> On 23/08/2023 10:50, Luo Jie wrote:
>> QCA8386/QCA8084 includes the clock & reset controller that is
>> accessed by MDIO bus. Two work modes are supported, qca8386 works
>> as switch mode, qca8084 works as PHY mode.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
> 
> You ignored tag, so I wrote you friendly reminder. You responded:
> 
> "Okay, got it, thanks Krzysztof for the reminder."
> 
> so again you ignored the tag?
> 
> No, come on. Doing mistakes is fine. Doing the same mistakes over and
> over is not fine.
> 
> Best regards,
> Krzysztof
> 
oh, sorry for missed stating the reason for the tag removed, this patch 
is updated, i forget to state the reason that the register address is 
changed from 24 to 0x10, i will keep this in mind and add this info in 
the next patch set.

Thanks Krzysztof for this reminder.
