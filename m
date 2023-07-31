Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF9D76A039
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjGaST5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjGaSTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:19:55 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC50F119;
        Mon, 31 Jul 2023 11:19:54 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36VGnCgQ024787;
        Mon, 31 Jul 2023 18:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1m8chiVrC0BiaOwGhXbnzapyxsLvLZAjLiFngURK47I=;
 b=bNIQoUEexb8ib1bD7euvpxaN+LAbGaHlKLDpYOF2C5QhkYwmlXJHlEPdZDum4b8GXstr
 tVPPeRsIST2VtKAwsy0Pk7+m1+lLgWnFiM8zqyXgpVKuOQpInFDHWDu7gUc74MtM+M0t
 MrcvSA7m60ScCZ8+kt54qRA/OdB2bN+s/GzfLL3jbS3cr4m4qXM7AUIOuEhzReDY1tPu
 HY6T1IvriKFFdCW1siuraAWj7uFsGkkMaYiAhoW4FFblTyOCwSrblHUM3vZyoPijmJ6o
 zTvhXHCl3iVk35UACUHY1CfFamI1Alz+KdKqxdTj+bvEpg6453II7a0aiDRUi/v4a1pa Ug== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s4uxscqj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 18:19:41 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36VIJRMW022223
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 18:19:27 GMT
Received: from [10.110.93.66] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 11:19:26 -0700
Message-ID: <c8161fb4-fa35-b2dd-6bfa-968ce7d4ead7@quicinc.com>
Date:   Mon, 31 Jul 2023 11:19:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/7] dt-bindings: soc: qcom: Add qcom-pbs bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <pavel@ucw.cz>, <lee@kernel.org>, <thierry.reding@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>
CC:     <luca.weiss@fairphone.com>, <konrad.dybcio@linaro.org>,
        <u.kleine-koenig@pengutronix.de>, <quic_subbaram@quicinc.com>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
References: <20230725193423.25047-1-quic_amelende@quicinc.com>
 <20230725193423.25047-2-quic_amelende@quicinc.com>
 <367ea415-6b33-248d-6725-de7330b3984b@linaro.org>
From:   Anjelique Melendez <quic_amelende@quicinc.com>
In-Reply-To: <367ea415-6b33-248d-6725-de7330b3984b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sYl_3TNi85lCE9oluGEGUp1AmD0_pRFj
X-Proofpoint-GUID: sYl_3TNi85lCE9oluGEGUp1AmD0_pRFj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-31_12,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 impostorscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307310166
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/2023 12:53 AM, Krzysztof Kozlowski wrote:
> On 25/07/2023 21:34, Anjelique Melendez wrote:
>> Add binding for the Qualcomm Programmable Boot Sequencer device.
>>
>> Signed-off-by: Anjelique Melendez <quic_amelende@quicinc.com>
>> ---
>>  .../bindings/soc/qcom/qcom-pbs.yaml           | 40 +++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom-pbs.yaml
> 
> 
> Again not tested.
> 
> Also, you missed comments. :(
> 
> This is a friendly reminder during the review process.
> 
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.
> 
> Thank you.
> 
> 
> Best regards,
> Krzysztof
> 
Hi Krzysztof,

Sorry about the testing, found that my dt_binding_checker was out dated and that
is why it has not been picking up those dt_binding errors :/ 

I went back to take a look at the original comments I missed and just wanted to
list them for a quick double check.

1. Rename binding to be qcom,pbs so that it matches compatible
2. Include Soc specific compatibles i.e. 
   compatible:
     items:
       - enum:
         - qcom,pmi632-pbs
       - const: qcom,pbs
3. Fix the example node

Thanks,
Anjelique

   

