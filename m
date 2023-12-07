Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCFC808233
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 08:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjLGHzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 02:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGHzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 02:55:08 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F1B110;
        Wed,  6 Dec 2023 23:55:13 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B762Iul009026;
        Thu, 7 Dec 2023 07:55:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bEnqWaDav/f7/bZPa3m2u29tJOB/87eh9G7oILjM5Pk=;
 b=oiHr5UhJHY+XCJMc2dOHGBWd9xI74ZezY8RZQHOsueounbwctMEQu6z6/W82YQF//iC4
 b6yTELZH5lf+S0RwxJu2Qrqbp3XnC4cDQ8EPRbQSfC+ewtdn8rYXPjWGK7edhEEZUdvL
 u4E2rFOvAncCDJZLfsJJABETcHlqeuGsENs8+Ey+BQtBSLeyE5SPCWmsPNNNuQsEJBdG
 Xhwu9VIsdfA47YVZtt01oggZgDvHPdvxlMWSjP4I+9xxFk1pGAJgR8H+KcuMdM4yb60T
 PY+YW6CWYxmrggODnpbq1HlRNeLRvvQRxve8np/xJpLxIV6L3tBT/Spz9/c3dM7sw7LJ YQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utrwq2ews-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Dec 2023 07:55:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B77t9Sh031655
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Dec 2023 07:55:09 GMT
Received: from [10.239.132.204] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 23:55:06 -0800
Message-ID: <2c91c34f-6ee9-4f34-863e-c26b0107f6d3@quicinc.com>
Date:   Thu, 7 Dec 2023 15:55:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <linus.walleij@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20231206020840.33228-1-quic_tengfan@quicinc.com>
 <20231206020840.33228-2-quic_tengfan@quicinc.com>
 <006c3c39-5266-4177-ae7f-263af5f0821c@linaro.org>
From:   Tengfei Fan <quic_tengfan@quicinc.com>
In-Reply-To: <006c3c39-5266-4177-ae7f-263af5f0821c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1IZZSB5iSE9z6-IUVdLEWPSdjMM4vFe4
X-Proofpoint-GUID: 1IZZSB5iSE9z6-IUVdLEWPSdjMM4vFe4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_05,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=978 malwarescore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312070063
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 12/6/2023 5:04 PM, Krzysztof Kozlowski 写道:
> On 06/12/2023 03:08, Tengfei Fan wrote:
>> Add device tree binding Documentation details for Qualcomm SM4450
>> TLMM device.
>>
>> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
>> ---
>>   .../bindings/pinctrl/qcom,sm4450-tlmm.yaml    | 151 ++++++++++++++++++
>>   1 file changed, 151 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
>>
> 
> There was no reason to drop my review tag here. You did not explain why
> it had to be dropped and changing indentation on example is for sure not
> the case.
> 
> Please read submitting-patches before posting new patches to mailing list.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Best regards,
> Krzysztof
> 
Hi Krzysztof,
I read submitting-patches.rst today. Like you said that I shouldn't drop 
your review tag due to change indentation. This is my fault.
Thank you again for your patient reviw and explanation.

submitting-patches.rst:
By offering my Reviewed-by: tag, I state that:
(c) While there may be things that could be improved with this
     submission, I believe that it is, at this time, (1) a
     worthwhile modification to the kernel, and (2) free of known
     issues which would argue against its inclusion.

-- 
Thx and BRs,
Tengfei Fan
