Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6D678558C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 12:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbjHWKhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 06:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbjHWKhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 06:37:32 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C88DB;
        Wed, 23 Aug 2023 03:37:30 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37N7EHov021159;
        Wed, 23 Aug 2023 10:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=mvWYy01RsxAg0AJNiuOS2h/QmuSlFlwkOY2ZNs76GeA=;
 b=GtK7KzkZoxzE2jWh8lCwxczfQLgJrVbHVvI8XhCvhw2VUcv3RDWLe4FNrsPSxZ8pg3bx
 fF/W9KzMFwiaP675s3TEPNhfB8/KGlK0xXsO21U6FnN7KpaXNDJshth/eETwS4dRi9tH
 tAvDqk9bxaXMrZ3QeRZOtbRHvQ2JRRe/v3H/8NhLFCobJmfoc+/yXSAwE3DvhzVGqb6h
 E+ZLWXhjsys+S8oOjEnwamwy06rCyo8HmlEeITVPBkwp1o+VLYSIT+WL1EMolfPWntWB
 9rtZXjW/9DqdHLidZDSf0INHdguErB1uxoKwRShZkkCIEptcjjqUsc4lE3UwARSA02L0 Ew== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sn2cm1nah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 10:37:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37NAbKMH012186
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 10:37:20 GMT
Received: from [10.253.13.101] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 23 Aug
 2023 03:37:16 -0700
Message-ID: <f4e1f615-658c-541b-f322-d21ba97724a0@quicinc.com>
Date:   Wed, 23 Aug 2023 18:37:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 2/4] dt-bindings: clock: add qca8386/qca8084 clock and
 reset definitions
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <andersson@kernel.org>, <agross@kernel.org>,
        <konrad.dybcio@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <p.zabel@pengutronix.de>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_srichara@quicinc.com>
References: <20230823085031.27252-1-quic_luoj@quicinc.com>
 <20230823085031.27252-3-quic_luoj@quicinc.com>
 <692b7775-eeda-3c5b-cc24-c5dbdbb38c71@linaro.org>
 <7eaca76f-e7ad-cb1c-5a1d-5a2b68357e9c@quicinc.com>
 <715b3a1e-a7bb-6ca7-e402-05b0e09dbe42@linaro.org>
From:   Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <715b3a1e-a7bb-6ca7-e402-05b0e09dbe42@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mptchh7G9OnMyHTsMMeZPHdJJGgrkvFx
X-Proofpoint-GUID: mptchh7G9OnMyHTsMMeZPHdJJGgrkvFx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_06,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1015 mlxlogscore=696 adultscore=0 priorityscore=1501 mlxscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230096
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/2023 6:28 PM, Krzysztof Kozlowski wrote:
> On 23/08/2023 12:24, Jie Luo wrote:
>>>> Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
>>>
>>> You ignored tag, so I wrote you friendly reminder. You responded:
>>>
>>> "Okay, got it, thanks Krzysztof for the reminder."
>>>
>>> so again you ignored the tag?
>>>
>>> No, come on. Doing mistakes is fine. Doing the same mistakes over and
>>> over is not fine.
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> oh, sorry for missed stating the reason for the tag removed, this patch
>> is updated, i forget to state the reason that the register address is
>> changed from 24 to 0x10, i will keep this in mind and add this info in
>> the next patch set.
> 
> That's not really a reason for dropping the tag.
> 
> Best regards,
> Krzysztof
> 

okay, Krzysztof, understand it, i will follow up this.
