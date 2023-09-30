Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD2A87B428B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbjI3RNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbjI3RNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:13:02 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86ECADA;
        Sat, 30 Sep 2023 10:12:57 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38UGauPZ009468;
        Sat, 30 Sep 2023 17:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=QpsScOf9/QJkhluz9qVoVCK0j/moMriR7Sl3NGMbTqE=;
 b=EhlmSxeFEYjU7A8Zy0jlaGqyqX/JpRsDz8gHGC/tv/pIfv+s8Nuc0QXCvRdHvh77r5Rh
 iksq5zeUPOkSQKShZ0Jj3Lzrota4OAcjbAXxBj4q+uUfg1O9oV1bZIW6XttlKnnyso0E
 xGquum6hHQEaFc+PjhRNeHdczXjlXJE8T46Xv54V/G4HLKeV+37Ij5vj9Phmv/UqOz6O
 m1yTIAvZHdw4k5shKwLp6ro4HYot3i2aUoZTp7i7DyOROmHqXt7lv4oqLmMjlPSlUJev
 swHiGV4fcDoPiv85FCES3blnpK0h4RBW3jhv7QSDlbkKCXxfPVBwBwaeOBzSXuUUPe+F ZQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3teaperuh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 30 Sep 2023 17:12:27 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38UHCQKG011720
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 30 Sep 2023 17:12:26 GMT
Received: from [10.216.56.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sat, 30 Sep
 2023 10:12:20 -0700
Message-ID: <012936e8-48dd-4f10-735a-9dcfafb49915@quicinc.com>
Date:   Sat, 30 Sep 2023 22:42:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH V12 2/3] dt-bindings: pwm: add IPQ6018 binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <ndesaulniers@google.com>,
        <trix@redhat.com>, <baruch@tkos.co.il>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <llvm@lists.linux.dev>
CC:     <linux-pwm@vger.kernel.org>, <u.kleine-koenig@pengutronix.de>,
        <nathan@kernel.org>
References: <20230925065915.3467964-1-quic_devipriy@quicinc.com>
 <20230925065915.3467964-3-quic_devipriy@quicinc.com>
 <42338d41-1b90-4f77-958e-479d32e0ce1d@linaro.org>
 <59c9dbdb-8673-8dc7-ecca-32ff120ccf80@quicinc.com>
 <4636a990-1044-1f67-dae5-8583f96021be@quicinc.com>
 <175d9803-8ad7-4c70-ad8c-b2d661828b61@linaro.org>
From:   Devi Priya <quic_devipriy@quicinc.com>
In-Reply-To: <175d9803-8ad7-4c70-ad8c-b2d661828b61@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I3rGPngaB39L4wh4X_n3QP85oXCDkKE_
X-Proofpoint-GUID: I3rGPngaB39L4wh4X_n3QP85oXCDkKE_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-30_15,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 adultscore=0 clxscore=1015 mlxlogscore=797 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309300141
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/30/2023 9:02 PM, Krzysztof Kozlowski wrote:
> On 29/09/2023 10:56, Devi Priya wrote:
> 
>>>>> diff --git a/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
>>>>> b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..857086ad539e
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/pwm/ipq-pwm.yaml
>>>>
>>>> Filename matching compatible, so qcom,ipq6018-pwm.yaml
>>> okay
>> We would have other ipq compatibles (ipq9574 & ipq5332) being added to
>> the binding in the upcoming series.
>> So, shall we rename the binding to qcom,ipq-pwm.yaml
> 
> I prefer not.
> 
Sure, okay

Thanks,
Devi Priya
> Best regards,
> Krzysztof
> 
