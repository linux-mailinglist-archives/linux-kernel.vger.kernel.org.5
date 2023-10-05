Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B121F7BA149
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239117AbjJEOlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236990AbjJEOhj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:37:39 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AC783E5;
        Thu,  5 Oct 2023 07:03:23 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3955buOu012274;
        Thu, 5 Oct 2023 07:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D8BC3BO3azckk+Ehrf8XzxN2xBK3e06fHyqblWk1k/I=;
 b=X75GR4wzkbqXeGM0oJnfHW2IK106HRJRgI3R5yrGLPC2NhseK4QLVKpMiy+LirA+JNXF
 QdzgRTJQqMEz1KLtFRJ1UxEoDHuV2ZxM0uOoetbuDIBUOQH9Ai/wZ8hmkXaWJPPO+4oI
 HQxgIZBnXOfltTtgPz7NsFGrUpmEFbxhNBYWZxl9ncsZNwVRH2ECBc+mFVbuw9eQxU21
 1CoUjteGyYxq1STjhmsz5SHQ3NUugZeignhMoWWAE1Dv68NML1VP2qikdGNEoiH0bCAW
 QBKs9CQqlpuTRkoIBkFHmCNxJxpPfDZou5qRcSqwffj/1S9NcnIqdIjqN5wciL0RodKP uQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3thn058c5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 07:36:40 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3957adOs003567
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Oct 2023 07:36:39 GMT
Received: from [10.216.40.132] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Thu, 5 Oct
 2023 00:36:32 -0700
Message-ID: <cc5fef7a-d4d1-d725-36a5-86183bacc5a0@quicinc.com>
Date:   Thu, 5 Oct 2023 13:06:27 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V14 3/4] dt-bindings: mfd: qcom,tcsr: Add simple-mfd
 support for IPQ6018
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <thierry.reding@gmail.com>, <ndesaulniers@google.com>,
        <trix@redhat.com>, <baruch@tkos.co.il>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
CC:     <linux-pwm@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <nathan@kernel.org>
References: <20231005033053.2626465-1-quic_devipriy@quicinc.com>
 <20231005033053.2626465-4-quic_devipriy@quicinc.com>
 <cfbc4805-c2e8-4dee-92bc-14d805dc2320@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <cfbc4805-c2e8-4dee-92bc-14d805dc2320@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6-_sl-_tzVzavNW99DG16uhxP881mC0P
X-Proofpoint-GUID: 6-_sl-_tzVzavNW99DG16uhxP881mC0P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_04,2023-10-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 spamscore=0 mlxlogscore=644 priorityscore=1501
 mlxscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310050057
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2023 1:04 PM, Krzysztof Kozlowski wrote:
> On 05/10/2023 05:30, Devi Priya wrote:
>> Update the binding to include pwm as the child node to TCSR block and
>> add simple-mfd support for IPQ6018.
>>
>> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> 
> Why did you send it twice? It's just brings confusion...

Sorry, kindly ignore. As the patches were not delivered to the list,
tried sending it again.

Regards,
Devi priya
> 
> Best regards,
> Krzysztof
> 
