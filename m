Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014107EEBA4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 05:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbjKQEUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 23:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQEUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 23:20:19 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7967E95;
        Thu, 16 Nov 2023 20:20:16 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH3eauk013464;
        Fri, 17 Nov 2023 04:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4GG+DwQbkcQngjgETnNhXPle3nt/qby0N201aLanoB8=;
 b=n/UcZs50kZNMnwSutXlxPtodyYOd/tiL+jYYHgoogh83u00Rd8rSRWXugUaaP5bIarjQ
 +S1vBH4GIOQazP2Y17USYA4+FwX2JNnK4TbjClkY6/3mA4lWOB3O8t8RjnI8hWg81T31
 g9vYxl2sTBBDQSB77dofho/f+HOT9hU0Ak26+4obK+qedWgekeM6Ntv8iqpX1q1rUGsb
 C3jUKPF1mzIgdPQ3V077d+pBD35wrfURYp2PI5vewUeX/yqInQOEu4oh+TxmIy4vG2kw
 WXfCJo8aYmSoIIPYm6uCA0kaPXdmNiaF+/EDUv8ERShWavdk35otc57dtgWYr/TkTF7g 6w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udkqa1uff-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 04:19:57 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AH4Jvuw010760
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Nov 2023 04:19:57 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 20:19:49 -0800
Message-ID: <7ab6456f-bf2d-32c1-709c-b1426c412747@quicinc.com>
Date:   Fri, 17 Nov 2023 09:49:46 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5/5] arm64: defconfig: Enable SC8380XP SoC base configs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <catalin.marinas@arm.com>, <ulf.hansson@linaro.org>
CC:     <agross@kernel.org>, <conor+dt@kernel.org>,
        <ayan.kumar.halder@amd.com>, <j@jannau.net>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <m.szyprowski@samsung.com>, <u-kumar1@ti.com>, <peng.fan@nxp.com>,
        <lpieralisi@kernel.org>, <quic_rjendra@quicinc.com>,
        <abel.vesa@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <quic_tsoni@quicinc.com>,
        <neil.armstrong@linaro.org>
References: <20231025142427.2661-1-quic_sibis@quicinc.com>
 <20231025142427.2661-6-quic_sibis@quicinc.com>
 <75b41aca-0333-4e69-aaf2-9aaa48d18d1b@linaro.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <75b41aca-0333-4e69-aaf2-9aaa48d18d1b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nP_cRFV9qtR9WyZ3c0CW7Vg5z6eJHxpo
X-Proofpoint-GUID: nP_cRFV9qtR9WyZ3c0CW7Vg5z6eJHxpo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_01,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=655
 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170031
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Krzysztof,

On 10/27/23 13:48, Krzysztof Kozlowski wrote:
> On 25/10/2023 16:24, Sibi Sankar wrote:
>> From: Rajendra Nayak <quic_rjendra@quicinc.com>
>>
>> Enable GCC, Pinctrl and Interconnect configs for SC8380XP needed to boot
>> to a console shell.
> 
> This is generic defconfig for all platforms. You must be explicit which
> SoC and board you now target. How anyone could figure out that random
> set of numbers/letters like A1204XZY SoC is Qualcomm?

Thanks, will fixup the commit message.

-Sibi

> 
> Best regards,
> Krzysztof
> 
