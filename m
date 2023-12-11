Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAD5F80C2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 09:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbjLKIGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 03:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjLKIGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 03:06:51 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C33ED;
        Mon, 11 Dec 2023 00:06:57 -0800 (PST)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB6mpwa009470;
        Mon, 11 Dec 2023 08:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        qcppdkim1; bh=XNenH5aJV/ZldxK+c+V4J8ZQ9r6vQ48/MsxKcIZksSc=; b=lX
        S/Bf6YmS+m8tmVkCxnp+adZtLhWcWMmy/nV9G8/GgqFVA5iitlAtVWKK2QxgdLtZ
        f8Sac78UUyLewB8w0Cj0kIKcOKpJjAWizYQMbSnC+HuolpJmONWbqxqI3nIJv/u3
        OD5+2zOaCCFErq93f1YXAmHMR519SeOtpUNmwnFwzlJbFgPOCzWM6WyFC0fnGN3Q
        D0+MUVZU6VnEaF4i4VUKxc9MzpyhaEcVbcOyTlsY4DOgCCER+09inGThRBLnnoRM
        THPNeJ94cmzqmR8syKaXJCqNg7DPO2g9Buh5U3fMDOFHUygo2v6qnR9h9d2dgG3T
        6WKvAPS0L9u2dFICNX7w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnyvajqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 08:06:51 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB86n8C030106
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Dec 2023 08:06:49 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Dec
 2023 00:06:46 -0800
Message-ID: <f521df97-dfd7-b56d-3799-0a72c22edf83@quicinc.com>
Date:   Mon, 11 Dec 2023 13:36:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: (subset) [PATCH v2 1/4] dt-bindings: mfd: qcom,tcsr: Add
 compatible for sm8250/sm8350
To:     Bjorn Andersson <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1698253601-11957-1-git-send-email-quic_mojha@quicinc.com>
 <170200426910.2871025.1931459275540622967.b4-ty@kernel.org>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <170200426910.2871025.1931459275540622967.b4-ty@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3UsKlVjhObpSIAv0_WQW-pZXeBKRyJiz
X-Proofpoint-ORIG-GUID: 3UsKlVjhObpSIAv0_WQW-pZXeBKRyJiz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=615 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110067
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

I have said in one of the thread here,

https://lore.kernel.org/lkml/57eed7c3-e884-a28b-a1ff-e5aecbb11137@quicinc.com/

There is a wrong register offset given for sm8550 in 4/4.
Since, you applied the changes in your tree, shall i send
the separate patch for it, or would you mind fixing it ?

-Mukesh

On 12/8/2023 8:27 AM, Bjorn Andersson wrote:
> 
> On Wed, 25 Oct 2023 22:36:38 +0530, Mukesh Ojha wrote:
>> Document the compatible for both sm8250 and sm8350 SoCs.
>>
>>
> 
> Applied, thanks!
> 
> [2/4] arm64: dts: qcom: sm8250: Add TCSR halt register space
>        commit: d59653233e8779e3fe082eb5635b9785f2095af6
> [3/4] arm64: dts: qcom: sm8350: Add TCSR halt register space
>        commit: 1accc6031d925c6045c4776d5f3646996b0b242a
> [4/4] arm64: dts: qcom: sm8550: Enable download mode register write
>        commit: 44b1f64cad5703c87918cc9ffbf9b79bb959418d
> 
> Best regards,
