Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E2D773015
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjHGUDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjHGUD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:03:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF54172B;
        Mon,  7 Aug 2023 13:03:21 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 377HUMfN016146;
        Mon, 7 Aug 2023 20:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=iuZ3TDQo1tozN5VS9Wo/E3D3xrzfQoD/Zc3kj7u+4tc=;
 b=i7m7+5zDsDl65yll7O8V+0VXjZ2JB0/0xyII8rp/O9xXwYePXbpkplVQxe5PI6Y8q2jA
 4fePmJPuDZm8c0PhzKkN5tUTEY/IDyyTk3cUTfJ/kAKBcjpVfmTlhLRToMozcCakGiXI
 s4HVeQW+Wt5PYkgliGFVXVRKr8Z5r6eCkLIHDcqEgz87I1z9rsCzgtkdS483t740lCLU
 rArF5CBgKPrfZOmjwI1JlT4UzAf69sMyprbyvjotv/DMmdg3z14Sm/yB2COPKrLPKqUt
 AnKB/LsBUIc1TW58ny0nxPaF3lNSuSTygvS5stC5YrxCV/axkoMjSC3HaSEdlRPbfriv tg== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sawbg9dan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 20:03:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 377K37Js019208
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Aug 2023 20:03:07 GMT
Received: from [10.110.62.211] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 7 Aug
 2023 13:03:06 -0700
Message-ID: <900b3b16-cfad-d043-39b4-8ea6802f87bc@quicinc.com>
Date:   Mon, 7 Aug 2023 13:03:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 2/7] dt-bindings: leds: leds-qcom-lpg: Add support for
 LPG PPG
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
CC:     <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
References: <20230725193423.25047-1-quic_amelende@quicinc.com>
 <20230725193423.25047-3-quic_amelende@quicinc.com>
 <20230803002502.GA1569972-robh@kernel.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <20230803002502.GA1569972-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tA45PtcBV9TNqiAInbRxmq3CJjyHZ6KV
X-Proofpoint-GUID: tA45PtcBV9TNqiAInbRxmq3CJjyHZ6KV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_22,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=745
 impostorscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308070183
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/2023 5:25 PM, Rob Herring wrote:
> On Tue, Jul 25, 2023 at 12:34:18PM -0700, Anjelique Melendez wrote:
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - qcom,pm8350c-pw
>> +              - qcom,pm8550-pwm
>> +    then:
>> +      properties:
>> +        nvmem:
>> +          minItems: 2
>> +        nvmem-names:
>> +          items:
>> +            - const: lpg_chan_sdam
>> +            - const: lut_sdam
> 
> This can go into the main section and then here you just say 
> 'minItems: 2'. And similar for the 1st if/then.
> 
ACK
>> +      required:
>> +        - nvmem
>> +        - nvmem-names
> 
> Looks like these are always required.
These are only required for the compatibles properties that do not
have lut peripherals. Right now this is is only for qcom,pmi632-lpg, 
qcom,pm8350c-pwm and qcom,pm8550-pwm.


