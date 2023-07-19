Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE997590A9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 10:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbjGSIwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 04:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjGSIwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 04:52:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D86FC;
        Wed, 19 Jul 2023 01:52:37 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36J8Gdts003054;
        Wed, 19 Jul 2023 08:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DmrA6Z9j8oN/IxGnpVAb1NIOL7nHFMRfbhGCMTkaxEw=;
 b=nSTpxgO4f1Hnr2ISC4kKxpQOiDkz+V+0XSn60+ikcp4Mg0Y65xDofvwjJvM/UtzGjYBi
 y4/xqa1KSHSA+hCkXjIvEB9Lj5BUyQ1BlFKhI31IvF8JEcXnq48DbbmxpC5rjC0GzDzV
 I9ZXVtXuRsL3hvKIhdFxqktdgHzWxcYAK7Ry8RMNnJwdtgGnv/i1XngDuk6lvuqqbWXN
 Ejn9y0K2z+bB3k6Tn/TKRhXqT7WGHW9wQb4uLb/YVCMiqS/q5YFikA01O+goRrDNj2rc
 o4wmlBe2xEKjHNtSPM4r7EgK8jIipcKEli1eHMVHltdG8RLF65Qma1f1fmdeAwcPL72w vQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rwnrrjvs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 08:52:10 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36J8q9Sa032119
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jul 2023 08:52:09 GMT
Received: from [10.239.154.73] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 19 Jul
 2023 01:52:06 -0700
Message-ID: <c22e59ef-918f-81ba-99e8-87815949fc1a@quicinc.com>
Date:   Wed, 19 Jul 2023 16:52:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1] led: flash: various minor fixes for leds-qcom-flash
 driver
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <pavel@ucw.cz>, ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Dylan Van Assche" <me@dylanvanassche.be>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Tom Rix <trix@redhat.com>, <linux-leds@vger.kernel.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>
References: <20230718092439.2482320-1-quic_fenglinw@quicinc.com>
 <d246292b-c0df-fa70-7561-9523e4db6138@linaro.org>
 <e420f2c9-4c29-e2c4-4312-291b05c97224@quicinc.com>
 <20230719085029.GI1082701@google.com>
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
In-Reply-To: <20230719085029.GI1082701@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EZ0X1Knc-eqXbkLCUBOY5q-cuertraQT
X-Proofpoint-ORIG-GUID: EZ0X1Knc-eqXbkLCUBOY5q-cuertraQT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-19_05,2023-07-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=476 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307190081
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/2023 4:50 PM, Lee Jones wrote:
> On Tue, 18 Jul 2023, Fenglin Wu wrote:
> 
>>
>>
>> On 7/18/2023 5:32 PM, Krzysztof Kozlowski wrote:
>>> On 18/07/2023 11:24, Fenglin Wu wrote:
>>>> Update the driver to address following minor issues:
>>>>    - Add a sentence in Kconfig to explain the driver can be compiled
>>>>      as a module
>>>>    - strobe off the LED channel before setting flash current to prevent
>>>>      the flash LED being lit with an incorrect brightness if it was
>>>>      already active in torch mode
>>>>    - put the child node if register any flash LED device failed.
>>>
>>> Don't mix different fixes and changes in one commit.
>>>
>>> Also, please use scripts/get_maintainers.pl to get a list of necessary
>>> people and lists to CC (and consider --no-git-fallback argument). I
>>> really do not see a point why I am cc-ed here.
>>>
>>> Best regards,
>>> Krzysztof
>>
>> I understood that we should separate the changes for different fixes.
>>
>> I am trying to address the review comment from Pavel that was coming late
>> after the original changes were applied:
>> https://lore.kernel.org/linux-arm-msm/20230325170957.GA2904@bug/ (sorry for
>> just got time to work on this), since all of them are small ones and all
>> related with the same driver, so I thought it might be good to put them
>> together and update with a single patch?
> 
> Separate patches - one per functional change please.
sure. I will separate them and send them out.
Thanks

> 
