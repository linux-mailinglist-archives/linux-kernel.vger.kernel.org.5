Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC32A7E6532
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 09:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjKIIXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 03:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjKIIXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 03:23:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9512B273E;
        Thu,  9 Nov 2023 00:23:31 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A96OrKd004383;
        Thu, 9 Nov 2023 08:23:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=B+GqainagvNOtu1pq9n6NRHe6VBbgoJkIl8FNVDCxec=;
 b=krV4FkK9QJwNboB4Fg6CPpaW3aArdIEqllJSGOJ2fRlS5qmcY6Q0J1MWrjuKHdzTtbuH
 KzNwL+D1ZC3wId26rBbqkVDbbKIxLykIAvCOqtECJxkDBOvIeMuchLbVTkGhelvpXk8/
 fYb/DJxNftdiStCsnLoojs64P+sZPrHFm8YlRNlgw3olMK+5Ucwdt5pttVSoUqqkDILu
 byBG4jmj/q/3wsCfKlvasL8w2+nLgELjuMU85F0WhP2OqX6EKMmWlA6tBevxgDLiSi+v
 Q3sLzJHIDwQjus5X7atHVvQXqLqnjQPQRDkxldoLm1eOZGDJAtRGvcjjhp9PkQiNbksU sQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u8t0nrfjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Nov 2023 08:23:16 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3A98NFUx009181
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Nov 2023 08:23:15 GMT
Received: from [10.218.16.59] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 9 Nov
 2023 00:23:08 -0800
Message-ID: <7ccaf08e-0add-33e5-fbea-ce737e53fa28@quicinc.com>
Date:   Thu, 9 Nov 2023 13:52:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 03/11] ARM: dts: qcom: Update devicetree for ADC7 rename
 for QCOM PMICs
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linus.walleij@linaro.org>,
        <Jonathan.Cameron@huawei.com>, <sboyd@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <quic_subbaram@quicinc.com>,
        <quic_collinsd@quicinc.com>, <quic_kamalw@quicinc.com>,
        <marijn.suijten@somainline.org>,
        <andriy.shevchenko@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        <linux-arm-msm@vger.kernel.org>
CC:     <linux-iio@vger.kernel.org>, <linux-arm-msm-owner@vger.kernel.org>
References: <20230708072835.3035398-1-quic_jprakash@quicinc.com>
 <20230708072835.3035398-4-quic_jprakash@quicinc.com>
 <839cfac2-8f74-3386-5854-e3fb2ba4e07f@linaro.org>
 <27b5806f-ef15-7a90-5adc-5ee12690f2ca@quicinc.com>
 <7af782f3-fe6c-415b-a993-55962845a102@linaro.org>
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
In-Reply-To: <7af782f3-fe6c-415b-a993-55962845a102@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2NcRwwyqo7OSH7oFqVYuiZwco9kz_LKS
X-Proofpoint-GUID: 2NcRwwyqo7OSH7oFqVYuiZwco9kz_LKS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-09_07,2023-11-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0
 mlxlogscore=605 spamscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311090068
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 10/23/2023 12:02 PM, Krzysztof Kozlowski wrote:
> On 23/10/2023 08:09, Jishnu Prakash wrote:
>> Hi Krzysztof,
>>
>> On 7/9/2023 10:48 PM, Krzysztof Kozlowski wrote:
>>> On 08/07/2023 09:28, Jishnu Prakash wrote:
>>>> The name "ADC7" needs to be replaced with the name "ADC5_GEN2"
>>>> everywhere to match the convention used for these ADC peripherals
>>>> on Qualcomm Technologies, Inc. PMICs. Update devicetree files for
>>> We do not rename compatibles to match convention. Please provide proper
>>> rationale.
>> I'll avoid renaming the compatible directly, will just mark it
>> deprecated - but is it fine to do the other changes, for updating the
>> macro names used in devicetree (replacing the ADC7 macros with the ADC5
>> Gen2 macros)?
> Please provide proper rationale why "ADC7 needs to be replaced". Your
> marketing is not a proper rationale.


The name "ADC7" was the one used internally at first, but it got changed 
later to "ADC5 Gen2" by our HW team, after we had added this support 
both downstream and upstream. Since we are now adding support for the 
next generation named "ADC5 Gen3", we thought it would be helpful to 
indicate in some way that this generation (ADC7) lies between the 
earlier ADC5 and the latest ADC5 Gen3.

Since you do not want us to modify the existing bindings, is it fine if 
I just add a new compatible for ADC5 Gen2 and comments to indicate the 
ADC7 compatible should be considered deprecated?

If you are not convinced, we can drop the Gen2 name related changes from 
the patch series.


>
>> I do see an example of a macro change in devicetree done in this patch:
>> https://lore.kernel.org/all/cover.1646388139.git.zong.li@sifive.com/.
>>
>> Patch 2 here replaced some macro definitions:
>> https://lore.kernel.org/all/f9284873c2993a9952d9fe4f8dd5e89f20daab75.1646388139.git.zong.li@sifive.com/.
>>
>> Patch 3 made the corresponding update in devicetree files:
>> https://lore.kernel.org/all/db92d209fa700f7da8bc8028083476fcc138d80e.1646388139.git.zong.li@sifive.com/.
> And what is rationale in that patchset?


Right, I see that the change was made to refactor the driver code and 
avoid unused variable errors, not just a name change.

Thanks,

Jishnu


>
>>
>>   From this mail, it looks like the maintainer was willing to pick them
>> at that time:
>> https://lore.kernel.org/all/20220315225652.CDAD1C340E8@smtp.kernel.org/,
>> would something similar be possible here?
> For stated before marketing reasons - no, would not be possible.
>
> Best regards,
> Krzysztof
>
