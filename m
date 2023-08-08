Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6A4773DD6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjHHQXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbjHHQV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:21:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8622A9ED7;
        Tue,  8 Aug 2023 08:49:14 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3785fOg6029204;
        Tue, 8 Aug 2023 06:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=29DOQZL4LXZv2685DSEWex4QGh2mQB++HdJnY7JXF4c=;
 b=dIHO3fNOcTiHzrvrdX4P10Ry/niEWzJW5COkwOBIE94Ko1dr9sRHFEVUhXWaMSAceW0c
 UrcIDvKrGxzIzdbNRRthEP7rjZwypXlkpkH+FCDqHT6z9XFTcpI168zYcGWLQnH7Yzc0
 S3aH7CuIprkUElyQMwz/L40t23lWyd995VAY2lxr+b1pjgmNe8sdvGehOH1hV9nHSm4a
 7kyffr5TaZYlhJrEI26SK2Hxd37kkk/iFxkImrSodoxIHK95Eq/5ZBbGgjTnM8NdA7I3
 58md+hZON/rpTP6/qZiFUHBNqRI6bNhvstP7Vn9CxEvey1rVbFukLhd96Bms88S+tO+C Bw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sawbgab0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 06:31:48 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3786VlpU003395
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 8 Aug 2023 06:31:47 GMT
Received: from [10.253.9.41] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 23:31:43 -0700
Message-ID: <f25e1043-6dfa-2dcc-2948-88025f4881d8@quicinc.com>
Date:   Tue, 8 Aug 2023 14:31:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] dt-bindings: clock: add qca8386/qca8084 clock and
 reset definitions
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230801085352.22873-1-quic_luoj@quicinc.com>
 <20230801085352.22873-3-quic_luoj@quicinc.com>
 <ef996a7e-6eba-4366-c3ea-0d08f2768e98@linaro.org>
 <cf9788f0-a115-5ff9-1195-f4f302551e04@quicinc.com>
 <d1172ed6-ee3b-83b6-1656-c91e35fbc2df@linaro.org>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <d1172ed6-ee3b-83b6-1656-c91e35fbc2df@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PY65P9qEFv7z6XBhPEane30M7CxqP_8D
X-Proofpoint-GUID: PY65P9qEFv7z6XBhPEane30M7CxqP_8D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_04,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=817
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308080057
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/2023 1:57 PM, Krzysztof Kozlowski wrote:
> On 08/08/2023 07:19, Jie Luo wrote:
>>>> +properties:
>>>> +  compatible:
>>>> +    const: qcom,nsscc-qca8k
>>>
>>> SoC name is before IP block names. See:
>>> Documentation/devicetree/bindings/arm/qcom-soc.yaml
>>>
>>> qca8k is not SoC specific. I don't know what you are documenting here,
>>> but if this is a SoC, then follow SoC rules.
>>>
>>> If this is not SoC, it confuses me a bit to use GCC binding.
>>>
>>> Anyway, this was not tested, as pointed out by bot... Please test the
>>> code before sending.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>>
>> Hi Krzysztof,
>>
>> Thanks for the review comments.
>> qca8383/qca8084 is a network chip that support switch mode and PHY mode,
>> the hardware register is accessed by MDIO bus, which is not a SOC.
>>
>> But it has the self-contained clock controller system, the clock
>> framework of qca8386/qca8084 is same as the GCC of ipq platform such as
>> ipq9574.
> 
> OK
> 
>>
>> would you help advise whether we can document it with the compatible
>> "qcom,qca8k-nsscc"?
> 
> For example:
> qcom,qca8084-nsscc
> 
> Best regards,
> Krzysztof
> 
Thanks Krzysztof for the suggestion.

i will document the compatible below.
"qcom,qca8084-nsscc" for the PHY mode of device.
"qcom,qca8386-nsscc" for the switch mode of device.

Jie.
