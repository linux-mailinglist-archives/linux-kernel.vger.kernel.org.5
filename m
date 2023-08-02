Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F84D76CE51
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234027AbjHBNTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjHBNT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:19:28 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3111729;
        Wed,  2 Aug 2023 06:19:27 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372AHdki029690;
        Wed, 2 Aug 2023 13:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=FqjENSbTHcJR9jVVz88xacGXsacgW4PCq0xnrnXYMAo=;
 b=a8BtN4rIzUHvTZZaGRsnY9snREtTtq1hyo27m//5UiGE7PrxRtGtqHWvKWM0EVX0YL3I
 C8I5wakOLvaZ6TTV3YTYw3Bs3QJKdzYWr2SI8nPWPcY3Cca/Lj7lxsQRPpKejy1lZTjV
 H59h154973I3Nk2KpqdCDdJm3juMA9LEErcumfVHC3zArn9raGnBDoxtMB3RnGkzgdoR
 d9y2h4k/vDKbIpY6bFnCGg6JYze3uKYrW+DQ6LXBUSxsVyZY2UgYVpEMoUcuV8aM3Tl8
 bZh2b9iMTomh3tTV+6AzyKMolqmd2aHq3y8vYIr2vpBYVmieFR94+U2RsEslinNQM9ap jQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s75b32fp7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Aug 2023 13:19:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 372DJKW1025620
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Aug 2023 13:19:20 GMT
Received: from [10.214.66.58] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 2 Aug
 2023 06:19:18 -0700
Message-ID: <3d4ae6d7-5c87-c3c3-553c-807a12666d29@quicinc.com>
Date:   Wed, 2 Aug 2023 18:49:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 3/8] arm64: dts: qcom: Add PMIC pm7550ba dtsi
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1690970366-30982-1-git-send-email-quic_rohiagar@quicinc.com>
 <1690970366-30982-4-git-send-email-quic_rohiagar@quicinc.com>
 <ce1af969-427a-3e4d-e85c-32d629755d9a@linaro.org>
 <bb374ec4-3dfa-42f1-dffb-fc8505625b73@quicinc.com>
 <2e97b032-4ca5-e59c-c891-2ed9ca39d237@linaro.org>
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
In-Reply-To: <2e97b032-4ca5-e59c-c891-2ed9ca39d237@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x6W7hB8bmrAqkHI8v2rmOsRpZxAwJyPx
X-Proofpoint-ORIG-GUID: x6W7hB8bmrAqkHI8v2rmOsRpZxAwJyPx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-02_09,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 mlxlogscore=585 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308020118
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/2/2023 6:44 PM, Konrad Dybcio wrote:
> On 2.08.2023 15:13, Rohit Agarwal wrote:
>> On 8/2/2023 6:12 PM, Konrad Dybcio wrote:
>>> On 2.08.2023 11:59, Rohit Agarwal wrote:
>>>> Add dtsi for PMIC pm7550ba found in Qualcomm platforms.
>>>>
>>>> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
>>>> ---
>>> Subject: "PMIC pm7550ba" -> "pm7550ba PMIC"
>>>
>>> [...]
>>>
>>>> +
>>>> +        pm7550ba_eusb2_repeater: phy@fd00 {
>>>> +            compatible = "qcom,pm8550b-eusb2-repeater";
>>> A new compatible should be introduced, so that it goes like this:
>>>
>>> compatible = "qcom,pm7550ba-eusb2-repeater", "qcom,pm8550b-eusb2-repeater";
>> Just a doubt, Since the compatible can be same why we need to introduce a new compatible.
>> Should every soc have a compatible string?
> If it turns out that we need to add a quirk for PM7550BA 3 years down
> the line, this approach lets us fix it for users that never updated
> their device trees.
Yes. Got it.

Thanks,
Rohit
>
> Konrad
