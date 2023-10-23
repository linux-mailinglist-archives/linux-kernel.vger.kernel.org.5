Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377287D2A15
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 08:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbjJWGOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 02:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJWGOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 02:14:30 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7E4D66;
        Sun, 22 Oct 2023 23:14:28 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N60Lf5024389;
        Mon, 23 Oct 2023 06:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mwIlOwqybG4uHilytYQh9OnSBlXeMal5krDHQdz1+Pc=;
 b=FjCBKr/yGtZkp56w6qyJm7p/knFkrcVTo5ykOX95nvkSFgQ+ECmP6QI7ang4FtzJXpH4
 PT1ZQIjYm6CZuwa+qoWpOs5qBsor+dZwkfrnoAEKze/nsxmkzF1n5Vjvu0ljs3wnrLvT
 /7x8Wicr2b4isp6ejG/FwagEUV3g9rlY9GV0E+XujW6TAa9GpvnDJdbwrq5mpWxhA0RJ
 0hqrDnhYgW+kt7BXeHuxhJybrL6S1hGoPg0CIf8VCskTB8JNNEyePLyEyEFeh+98xbak
 MYh1rJAc2/ZOiLZ3r7V5p6K3SsaZj7a5pL7u0mDMhIx0hk3DXG23Ewd+hV4VbzhvAqG1 GQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tv7u3uguy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:14:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39N6E5f5019085
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 06:14:05 GMT
Received: from [10.216.48.174] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Sun, 22 Oct
 2023 23:13:55 -0700
Message-ID: <bae1be51-285e-a001-fba3-1a075ec7de10@quicinc.com>
Date:   Mon, 23 Oct 2023 11:43:51 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 06/11] iio: adc: Add QCOM PMIC5 Gen3 ADC bindings
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        <krzysztof.kozlowski@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, <linux-iio@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-7-quic_jprakash@quicinc.com>
 <20230708161259.7af17fa9@jic23-huawei> <20230708162541.1a15ed14@jic23-huawei>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <20230708162541.1a15ed14@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v5eyTT8byIwCeQV8DD5quy12mGgakSiw
X-Proofpoint-ORIG-GUID: v5eyTT8byIwCeQV8DD5quy12mGgakSiw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_03,2023-10-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=559
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310230054
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 7/8/2023 8:55 PM, Jonathan Cameron wrote:
>>>   properties:
>>>     compatible:
>>> @@ -27,10 +27,11 @@ properties:
>>>             - qcom,spmi-adc5
>>>             - qcom,spmi-adc-rev2
>>>             - qcom,spmi-adc5-gen2
>>> +          - qcom,spmi-adc5-gen3
>>>   
>>>     reg:
>>>       description: VADC base address in the SPMI PMIC register map
>>> -    maxItems: 1
>>> +    minItems: 1
>> ?
> Found it now.  This needs documentation that it's providing multiple
> base addresses for gen3.  Also needs to only apply that to gen3...
>
Yes, I'll do that in the next patchset.

Thanks,

Jishnu

