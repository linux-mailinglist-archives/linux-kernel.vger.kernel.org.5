Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D267776EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 05:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjHJDqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 23:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjHJDqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 23:46:52 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF4A1FF7;
        Wed,  9 Aug 2023 20:46:52 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37A3A2tG031184;
        Thu, 10 Aug 2023 03:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tNIB9CWuZsfxwANQ8w/LgWn1H+QqrahFM2/0oBipDfc=;
 b=H0JCPP/hpykQ2YF4+/JjzfoFO8c3ohHiCUW5Rrf14ZULXmgeH3VU3Zw3bCfGWXQ9Q8+a
 9wYY+g4VjYn2dI1+oMcBxdE1775N71Ro38WnxAV0Vpr5nEg2F3Nw9hJZNCHUiU7mjjrc
 l7FTxWlSie4G+GNDIN2CVAFCNHywHSTe0FZQXvEv5ZGl7vuNSVF85KHPfN2H6i7DJuWm
 isUUE/3gmzlqjqN9mpHirn4CmBJ9x5bUceFthWl5aGIj52lYRZo6a/L1FvYL1O0Zo8Kd
 HAqBduAyduoXPazFuwR4RHxjo7vSEyP+MrepdYI3A+hxYMrrBxGDRzPjww29mD8eg8TP Yw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3scnsf87m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 03:46:36 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37A3kZ1d029961
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 03:46:35 GMT
Received: from [10.253.39.188] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 20:46:31 -0700
Message-ID: <a7613006-4e38-2ea8-5e7f-048bf203dabc@quicinc.com>
Date:   Thu, 10 Aug 2023 11:46:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v1 1/4] clk: qcom: branch: Add clk_branch2_qca8k_ops
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <andersson@kernel.org>,
        <agross@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230809080047.19877-1-quic_luoj@quicinc.com>
 <20230809080047.19877-2-quic_luoj@quicinc.com>
 <7009b7c7-8c53-47b1-9648-6d8fc8c4134a@linaro.org>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <7009b7c7-8c53-47b1-9648-6d8fc8c4134a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: gHThOd6t3XQPBWXi3MseCYYL_EmJQGMR
X-Proofpoint-ORIG-GUID: gHThOd6t3XQPBWXi3MseCYYL_EmJQGMR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_01,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=578 malwarescore=0 priorityscore=1501 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308100030
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/2023 12:56 AM, Konrad Dybcio wrote:
> On 9.08.2023 10:00, Luo Jie wrote:
>> Add the clk_branch2_qca8k_ops for supporting clock controller
>> where the hardware register is accessed by MDIO bus, and the
>> spin clock can't be used because of sleep during the MDIO
>> operation.
>>
>> The clock is enabled by the .prepare instead of .enable when
>> the clk_branch2_qca8k_ops is used.
>>
>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>> ---
> clk_branch2_mdio_ops?
> 
> Konrad
okay, will update it to clk_branch2_mdio_ops, thanks Konrad.
