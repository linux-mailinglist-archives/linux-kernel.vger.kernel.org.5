Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9057DC53E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 05:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbjJaESO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 00:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235993AbjJaESM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 00:18:12 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8673DA;
        Mon, 30 Oct 2023 21:18:09 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39V47gZd023618;
        Tue, 31 Oct 2023 04:17:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BbZXHE7mlS+VfSXUUUknc7meDx7x2KaOvjBinYOgTbI=;
 b=QHN22VBpfn4bUfoqj4/IrWl7qS+jPTKaNA6KcpteRTmaqSp6Bb422ZjSPqYYo/iEZPz7
 Shogsct8eCdkdZx00HNVx1Ht6MA0jlwVpp4mlfeebQj5pd8Lw3LgQeC1w28gEKO8ZljG
 bkryftgZ5yYzd7eICgc8OOX80srm0MQjketnDVi4PemvgP+/Z0DPReogao7bv6xRs0Sm
 Ed4so8hhQkGL0kwqqLfx5dKGfppTj1/tjKB3fk7UtQE1ewkwRD/EX877GPYz1hGlfzfM
 MbA/8PaRkY3IPlEUdqOU15Stt95h2Fm35Uu4eaOwV4azfdUglj5e1QAeyRl0Rbm82PAK cg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u2egsshum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 04:17:58 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39V4Hv1l003299
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 04:17:57 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Mon, 30 Oct
 2023 21:17:51 -0700
Message-ID: <57c0f1b7-7536-4a13-bf96-5f885170a68d@quicinc.com>
Date:   Tue, 31 Oct 2023 09:47:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] dt-bindings: clock: add IPQ5332 NSSCC clock and reset
 definitions
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com>
 <20231030-ipq5332-nsscc-v1-5-6162a2c65f0a@quicinc.com>
 <02e2bd74-2509-4cec-a85e-4acfc13eea84@linaro.org>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <02e2bd74-2509-4cec-a85e-4acfc13eea84@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8wjTzmmCPKjYR6f5xvlFha3oiMYewRzN
X-Proofpoint-GUID: 8wjTzmmCPKjYR6f5xvlFha3oiMYewRzN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_13,2023-10-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=775 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310310031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/30/2023 4:41 PM, Krzysztof Kozlowski wrote:
> On 30/10/2023 10:47, Kathiravan Thirumoorthy wrote:
>> Add NSSCC clock and reset definitions for IPQ5332.
> 
> Qualcomm IPQ5332
> 
> This applies to all your patches in all your patchsets in entire
> Qualcomm organisation. You add code to common, upstream Linux kernel
> where hundreds of companies also contribute. Except me and few more
> folks, no one knows what is IPQ5332. Other 5000 developers do not know.
> Other millions of users do not know.


Thanks, Understand the concern. Will follow it in the upcoming patches / 
series.

> 
>>
>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>> ---
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Thanks!

> 
> Best regards,
> Krzysztof
> 
