Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352C77764E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 18:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjHIQSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 12:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjHIQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 12:18:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CD51982;
        Wed,  9 Aug 2023 09:18:25 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 379F7Kbd015177;
        Wed, 9 Aug 2023 16:18:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=pc+j7IaGMjxp0gWLH/cgKwZFlgWmLlLO/9/+BwPqzeo=;
 b=MJlzFhUrRSUHKJysr6TuYDlhd1iYS/ouQn6Hcs0uKBowN+fs2AUDTXES9eKdy5tVGdi7
 HIdV0LDXbuRSImfdZSXvrJwVg/DIYoWfdcPtkqaKwl1db6XtS9abTASw6EBHwI3MdbC4
 KPKAmtdsPb4jDosiBakhdB8Aonu3Q6yW8mivWZn+d0HYKw/7rD9jTRDkafVVutm6Vleb
 rla4uIAdAzJLpwStK1+98Bn8KakXzgSXPzvCe81W3AjU27dUStVXVbMvYRhkGpxOSwye
 A2f/HiVL9T4AdERYuH/Df7mwaDB1etnk9md0m7slHzSxAOFnhrOT6dDuv5O1fg5igR9T zQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sc1ny1rhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 16:18:09 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 379GI8FN018967
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 9 Aug 2023 16:18:08 GMT
Received: from [10.216.57.155] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 9 Aug
 2023 09:18:02 -0700
Message-ID: <a8750c05-15d4-1b58-c274-39f24ac018ca@quicinc.com>
Date:   Wed, 9 Aug 2023 21:47:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Feedback on Qualcomm's minidump (debug) solution for end user
 device crash
Content-Language: en-US
To:     Kukjin Kim <kgene.kim@gmail.com>, Brian Masney <bmasney@redhat.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        <linux-samsung-soc@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
References: <ZNEJAh0in/fjq6s9@brian-x1>
 <1DAA278D-BDFE-4880-8453-99F098D4E259@gmail.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1DAA278D-BDFE-4880-8453-99F098D4E259@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 75Jwzds8lHrLoCfIBzffa-zf_i-VWGcn
X-Proofpoint-ORIG-GUID: 75Jwzds8lHrLoCfIBzffa-zf_i-VWGcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_13,2023-08-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=881 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090143
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/9/2023 1:19 PM, Kukjin Kim wrote:
> 
>> 2023. 8. 8. 오전 12:08, Brian Masney <bmasney@redhat.com> 작성:
>>
>> ﻿On Mon, Aug 07, 2023 at 06:01:27PM +0530, Mukesh Ojha wrote:
>>>> On 7/30/2023 5:14 PM, Krzysztof Kozlowski wrote:
>>>> On 24/07/2023 18:59, Brian Masney wrote:
>>>>> + linux-arm-kernel list
>>>>>
>>>>> On Thu, Jul 20, 2023 at 08:32:24PM +0530, Mukesh Ojha wrote:
>>>>>> Hi Samsung/MTK/Any other SOC vendors,
>>>>>>
>>>>>> This is to bring to your notice that, we (Qualcomm) are working on
>>>>>> upstreaming our minidump solution which is to address the problem of
>>>>>> debugging on field device crashes where collecting entire ddr dump
>>>>>> would not be feasible and collecting minimal data from the ddr would
>>>>>> help in debug direction or even help in root causing issue.
>>>>>>
>>>>>> We have recently posted v4 version here [1]
>>>>>>
>>>>>> Based on comments[2], community is more worried about, if each SOC
>>>>>> vendor come up with their own dumping method today or in future and
>>>>>> whether it can have a common solution to a similar problem faced by
>>>>>> other SOC vendor.
>>>>>>
>>>>>> We wanted to take your feedback if you also encounter a similar problem
>>>>>> or maintain something similar solution in downstream which can be
>>>>>> upstreamed. This will help us in a way to have a common solution in
>>>>>> upstream.
>>>>>>
>>>>>> [1]
>>>>>> https://lore.kernel.org/lkml/10dd2ead-758a-89f0-cda4-70ae927269eb@quicinc.com/
>>>>>>
>>>>>> [2]
>>>>>> https://lore.kernel.org/lkml/CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com/
>>>>>
>>>>> Adding the main ARM list to solicit feedback from other silicon
>>>>> manufacturers.
>>>>>
>>>>> The cover sheet on the v4 patch set is available at:
>>>>> https://lore.kernel.org/lkml/1687955688-20809-1-git-send-email-quic_mojha@quicinc.com/
>>>>
>>>> I doubt anyone follows the lists, so at least Cc some maintainers.
>>>>
>>>> +Cc Alim, Kukjin, Vignesh, Nishanth, Matthias.
>>>
>>> Thanks @Krzysztof/@Brian for extending the list.
>>
>> Hi Mukesh,
>>
>> Since no one has responded yet: I suspect your best bet to land the
>> minidump functionality upstream is to refactor it to use the pstore
>> functionality that Rob suggested:
>>
>> https://lore.kernel.org/lkml/CAL_JsqK7MHR09U5h01=Gf1ZLeDVCgZdN-W1hQRH3AX+E94_uUg@mail.gmail.com/
>>
>> Brian
>>
> Hi all,
> 
> Sorry for the late response and thanks for the asking.
> 
> In Samsung side, we’re checking about that internally as well. I’d like to know whether the minidump upstreaming is considered to be used in other chipset or some logic of that can be used. In addition, if Samsung wants, own the way upstreaming can be acceptable. It doesn’t mean we have a plan at this moment though.

Thanks for the response @Kukjin

It is not something considered already instead it is what Qualcomm has
support for its SOC in the downstream and we want to upstream the linux
drivers and Minidump will need boot firmware support to be able to be
used by other SOC vendors.

So, the reason of seeking feedback on exactly the problem statement
to debug crash from field devices where complete ddr dump is not
feasible instead collect minimal information available to debug
crashes and also about if SOC vendors have any solution for this
issue which is common and upstream-able and can be leveraged.

So, if the problem statement is valid and now it is the time to
share and get conclusion on some common solution, Feel free to
check and comment on our minidump patches.

https://lore.kernel.org/lkml/10dd2ead-758a-89f0-cda4-70ae927269eb@quicinc.com/

-Mukesh

> 
> Thanks,
> Kukjin Kim <kgene(at)kernel.org>
