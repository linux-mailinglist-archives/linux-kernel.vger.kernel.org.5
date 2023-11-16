Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E917A7EDD98
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 10:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235610AbjKPJaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 04:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjKPJaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 04:30:00 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E549C;
        Thu, 16 Nov 2023 01:29:57 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG8iKDA007049;
        Thu, 16 Nov 2023 09:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=qQM2FnTXeGFHjIXM8bHi3GTM4JALf37Zt+qMG2bajKQ=;
 b=ElZ2WzzGClHcUaaUQy7T73WBRhk3UB9K/35Qnix3OtvxZeMcXJJHPXuNB9z0HKcLFA6L
 iESBxRPQtMwtt+QOilsD3mlczjEBzFwedQpl86qIALSR85Cdwu7+t9ZnjvGLBwZYQZ4g
 pKLQXWVmYOQhkCp77cuj006X3m5IJM6nWihktwZMDS3Fhl6b4DG3Ppy1v5vJZ7hsG7tc
 DtPTfhAL7C72GKDk8YKfVjnwD89LTd0ZQXId4SXm/6VHiHpgmCGRoyeobW2LBwr3hPEj
 IRPoZYMX/LcC0ShgyZMj4JccbZNJBrL0eH/GzJv8SsWtU3QgVlYnkZuAVauOWvTdI9Fw rg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucrb2k8de-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 09:29:52 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AG9Tpwd016546
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Nov 2023 09:29:51 GMT
Received: from [10.218.19.46] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 01:29:47 -0800
Message-ID: <0c1d1ccd-fff8-fb4f-12c0-8b60f3e5c3e2@quicinc.com>
Date:   Thu, 16 Nov 2023 14:59:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 2/4] clk: qcom: videocc-sm8150: Update the videocc resets
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     Bjorn Andersson <andersson@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20231110065029.2117212-1-quic_skakitap@quicinc.com>
 <20231110065029.2117212-3-quic_skakitap@quicinc.com>
 <31dac823-cc46-401e-85f8-d04544bd38c3@linaro.org>
 <2c5dae0f-5bd4-4fed-ba47-1175eba07207@linaro.org>
 <bee6062d-55ad-4577-8478-d20881c5047d@linaro.org>
From:   "Satya Priya Kakitapalli (Temp)" <quic_skakitap@quicinc.com>
In-Reply-To: <bee6062d-55ad-4577-8478-d20881c5047d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MUZYZkBjfoc71qjXBwiJoN5Ej71gxJOc
X-Proofpoint-ORIG-GUID: MUZYZkBjfoc71qjXBwiJoN5Ej71gxJOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_07,2023-11-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 spamscore=0 adultscore=0 mlxlogscore=578
 phishscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160076
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/15/2023 10:39 PM, Bryan O'Donoghue wrote:
> On 15/11/2023 16:48, Konrad Dybcio wrote:
>>> +    [VIDEO_CC_INTERFACE_BCR] = { 0x9ac },
>>> +    [VIDEO_CC_MVS0_BCR] = { 0x870 },
>>> +    [VIDEO_CC_MVS1_BCR] = { 0x8b0 },
>>> +    [VIDEO_CC_MVSC_BCR] = { 0x810 },
>> FWIW this seems to be a copypaste from
>>
>> https://git.codelinaro.org/clo/la/kernel/msm-5.4/-/blame/92b31370d31d22e910120f6a875bf0919b3f1773/drivers/clk/qcom/videocc-sm8150.c 
>>
>>
>> so if it's an issue, it should probably be fixed downstream too
>
> More of a question than a gotcha - 0x9ac is valid for sm8250 so 
> curious to me that its a different address on sm8150.


I have re-checked the offset values, as per the HW plan for SM8150 below 
values are correct:

+    [VIDEO_CC_INTERFACE_BCR] = { 0x8f0 },
+    [VIDEO_CC_MVS0_BCR] = { 0x870 },
+    [VIDEO_CC_MVS1_BCR] = { 0x8b0 },
+    [VIDEO_CC_MVSC_BCR] = { 0x810 },


> ---
> bod
