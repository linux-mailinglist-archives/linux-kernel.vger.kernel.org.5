Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A17FF786ABE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235801AbjHXIww (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238017AbjHXIwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:52:23 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E422919A0;
        Thu, 24 Aug 2023 01:52:15 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37O62MmW021046;
        Thu, 24 Aug 2023 08:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cx+s08Cj0Mu6Wb6EWjkiCwnzR8pat8n2GF6Pj7jxloM=;
 b=iT/3bF0FFS/89XLAf7FspeRNJn17ynONWKmsv9VQEL+PaKA+/yaTcIfDUkNM0o4APndR
 CaMxUYIlzn163bdtyAj4aoFBgpJqK6IWSBYSTawZtqtclHcQBmmI3aP08E7KLvwkfU2Z
 Rrr2AYpTIpwN5tw3bJ+G6rCfa38nTweG0jeJUfGVK01TRTrD7Q5Vuai8GbgzEpB8RVmH
 dNWK1kB85VJM11wFWlCl6+Aj7vSOc/x6YF9iVWDGVJNni1wXAx6eat0HlsMgCShW2bnG
 K3sJUwGEXCZzDD0koiUnu7zCW/ZQpqeIe5AX8uH/j8sySuLBlunhISUcVFxkgOQAy8Ko eQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sp1k9g7v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 08:10:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37O8Ap9Z029352
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Aug 2023 08:10:51 GMT
Received: from [10.253.13.101] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 24 Aug
 2023 01:10:15 -0700
Message-ID: <f3f05dfe-a8eb-6d73-f51d-470104782655@quicinc.com>
Date:   Thu, 24 Aug 2023 16:10:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 1/4] clk: qcom: branch: Add clk_branch2_mdio_ops
To:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <catalin.marinas@arm.com>,
        <conor+dt@kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <mturquette@baylibre.com>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230823085031.27252-1-quic_luoj@quicinc.com>
 <20230823085031.27252-2-quic_luoj@quicinc.com>
 <2819cf11177d81ab1fcface7e742cf50.sboyd@kernel.org>
Content-Language: en-US
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <2819cf11177d81ab1fcface7e742cf50.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oonPTLbz0wkaJ_1CoqaRcYlSrOzsxEx3
X-Proofpoint-ORIG-GUID: oonPTLbz0wkaJ_1CoqaRcYlSrOzsxEx3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_05,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=980
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2308100000 definitions=main-2308240066
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2023 2:04 AM, Stephen Boyd wrote:
> Quoting Luo Jie (2023-08-23 01:50:28)
>> diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
>> index fc4735f74f0f..5e08c026ca4a 100644
>> --- a/drivers/clk/qcom/clk-branch.c
>> +++ b/drivers/clk/qcom/clk-branch.c
>> @@ -153,3 +153,10 @@ const struct clk_ops clk_branch_simple_ops = {
>>          .is_enabled = clk_is_enabled_regmap,
>>   };
>>   EXPORT_SYMBOL_GPL(clk_branch_simple_ops);
>> +
>> +const struct clk_ops clk_branch2_mdio_ops = {
>> +       .prepare = clk_branch2_enable,
>> +       .unprepare = clk_branch2_disable,
>> +       .is_prepared = clk_is_enabled_regmap,
>> +};
>> +EXPORT_SYMBOL_GPL(clk_branch2_mdio_ops);
> 
> I'd call it clk_branch2_simple_prepare_ops or something like that.
> There's nothing mdio specific about it.

Thanks Stephen for the proposal.

As for qcom clock controller, only the device accessed by MDIO bus has 
this kind of ops, the clk_branch2_mdio_ops can also imply that the MDIO
bus is used for accessing the HW register, i think this is also the 
reason that Konrad suggested this ops name.
