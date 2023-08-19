Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85A5781977
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 14:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbjHSMGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 08:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232179AbjHSMGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 08:06:44 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856BC30D62;
        Sat, 19 Aug 2023 05:05:33 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37JC3H1w029178;
        Sat, 19 Aug 2023 12:05:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=L4Ib+EIxP60IFJylV5g4eTRWOjHJdhNVdaNB7/ufAwQ=;
 b=AfLqd6B1llYZDnt/loQ+MWwkfPWiCHhTKA7Dsu8PSbXSolHaKnoKBSa+aWOcskRY8Ke9
 1gG9guPeQXmrkcPM0I3cYtp+P4mxlgydDKBe7nQD3z4zn/i2TQgoAScrP1hE5KFwIEkW
 0GN06afaySz4cNZmKvm/hHvu+SSJy2iL6/1Sd2f6BGYCa4N7ED2Kw87FpwmUs9IW9E1Y
 hCb35xyvzc+O9BySUIGZNFJ/UTIBa28cIIW9R6dVjlbf69GmOzh78l3ZC33fqSO3zmoX
 k1N1BY2BEtYTDPIS5ihan2nvQpvtOqWQw8bIUI4kOW9eiPkI3mSInBNq2hoeBSLq+Ue2 jg== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sjny90k69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Aug 2023 12:05:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37JC5PdL001474
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 19 Aug 2023 12:05:25 GMT
Received: from [10.216.10.185] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sat, 19 Aug
 2023 05:05:20 -0700
Message-ID: <5e1a8bc6-7b77-d9a9-c5c9-26adbd913f8e@quicinc.com>
Date:   Sat, 19 Aug 2023 17:35:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH V1 1/2] dt-bindings: phy: Add QMP UFS PHY comptible for
 SC7280
To:     Vinod Koul <vkoul@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <agross@kernel.org>, <kishon@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230816154841.2183-1-quic_nitirawa@quicinc.com>
 <20230816154841.2183-2-quic_nitirawa@quicinc.com>
 <CAA8EJpoMFCbHuZcEN3-cxFN94QTG6wfNb52vfwuw6qLOfmdFyg@mail.gmail.com>
 <ZN3C5EFFyT5ewdtS@matsya>
Content-Language: en-US
From:   Nitin Rawat <quic_nitirawa@quicinc.com>
In-Reply-To: <ZN3C5EFFyT5ewdtS@matsya>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 66VHpgQMYyQNTZ85UIB5Ynax4dDFrYsN
X-Proofpoint-GUID: 66VHpgQMYyQNTZ85UIB5Ynax4dDFrYsN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-19_12,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1011 adultscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308190115
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry and Vinod,

Thanks for the review. I taken care of all the comments in latest 
patchset I posted.

Regards,
Nitin


On 8/17/2023 12:19 PM, Vinod Koul wrote:
> On 16-08-23, 23:31, Dmitry Baryshkov wrote:
>> On Wed, 16 Aug 2023 at 18:50, Nitin Rawat <quic_nitirawa@quicinc.com> wrote:
>>>
>>> Document the QMP UFS PHY compatible for SC7280.
>>>
>>> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
>>> ---
>>>   .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml      | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
>>> index d981d77e82e4..ad78da9c2c1a 100644
>>> --- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
>>> +++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
>>> @@ -31,6 +31,7 @@ properties:
>>>         - qcom,sm8350-qmp-ufs-phy
>>>         - qcom,sm8450-qmp-ufs-phy
>>>         - qcom,sm8550-qmp-ufs-phy
>>> +      - qcom,sc7280-qmp-ufs-phy
>>>
>>>     reg:
>>>       maxItems: 1
>>> @@ -110,6 +111,7 @@ allOf:
>>>                 - qcom,sm8250-qmp-ufs-phy
>>>                 - qcom,sm8350-qmp-ufs-phy
>>>                 - qcom,sm8550-qmp-ufs-phy
>>> +              - qcom,sc7280-qmp-ufs-phy
>>
>> Please keep both lists sorted.
> 
> Yes please
> 
