Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6557BEA70
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 21:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378356AbjJITQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 15:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377745AbjJITQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 15:16:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2C9B4;
        Mon,  9 Oct 2023 12:16:22 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399H8kdC006579;
        Mon, 9 Oct 2023 19:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XPhZWD6On+YuTJWF6V7tT4FLfVhogrwSdPXMFYDDgNU=;
 b=OQy7RGi4tcEwI5Jh2mp+rAwCu33n8CO9r/2Dzx+HaVgGmM4r+9ueEZVH/19SaShV8Ba3
 GcnsvnB8bz0tN1L5NjoSdKSDL7Zh6Rp9MihAZZFwORDeONmEvbxN96LwS834YL940dn9
 gTB1qQgszYneVPi3vMPty3LP04FcM+5k3WA9fSibNUdd74H5KVPVutBjroRenktompR7
 mYRO95gIevEZXtiIz2+A2r2JDS6naR/Hy3XMgvOqyYtajuyZ9Ub35xlIEYyqXTK4YsgK
 C4Ll/CRkulfZmsp+1hkQ4T5mr6xCzczecN0ubchAo3YBMZaF/wdVhI7eOTXa9K/KO6of VQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tmj0d8tjx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 19:16:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399JGBa7008944
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 19:16:11 GMT
Received: from [10.110.87.129] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 9 Oct
 2023 12:16:10 -0700
Message-ID: <fa9cf828-ae82-8145-c60a-4b15c340de86@quicinc.com>
Date:   Mon, 9 Oct 2023 12:16:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 2/2] firmware: arm_scmi: Add qcom smc/hvc transport
 support
Content-Language: en-US
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <cristian.marussi@arm.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230718160833.36397-1-quic_nkela@quicinc.com>
 <20231006164206.40710-1-quic_nkela@quicinc.com>
 <20231006164206.40710-3-quic_nkela@quicinc.com>
 <20231009144744.yi44ljq4llaxjsb7@bogus>
 <e6d9fbbb-eb61-0736-aa7b-a5e5d1a91db1@quicinc.com>
 <20231009152952.dww3fgh5q7fqysps@bogus>
 <535bbc68-74bb-21e8-0e72-8de1df9cfc99@quicinc.com>
 <20231009190800.ydkmmt2hgieazgfl@bogus>
From:   Nikunj Kela <quic_nkela@quicinc.com>
In-Reply-To: <20231009190800.ydkmmt2hgieazgfl@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: RLkhnCk4oWR9ySV4Z0D4DvpSY274-k_T
X-Proofpoint-ORIG-GUID: RLkhnCk4oWR9ySV4Z0D4DvpSY274-k_T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_17,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2309180000 definitions=main-2310090157
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/9/2023 12:08 PM, Sudeep Holla wrote:
> On Mon, Oct 09, 2023 at 10:49:44AM -0700, Nikunj Kela wrote:
>> On 10/9/2023 8:29 AM, Sudeep Holla wrote:
>>> On Mon, Oct 09, 2023 at 07:59:08AM -0700, Nikunj Kela wrote:
>>>> On 10/9/2023 7:47 AM, Sudeep Holla wrote:
>>>>> On Fri, Oct 06, 2023 at 09:42:06AM -0700, Nikunj Kela wrote:
>>>>>> This change adds the support for SCMI message exchange on Qualcomm
>>>>>> virtual platforms.
>>>>>>
>>>>>> The hypervisor associates an object-id also known as capability-id
>>>>>> with each smc/hvc doorbell object. The capability-id is used to
>>>>>> identify the doorbell from the VM's capability namespace, similar
>>>>>> to a file-descriptor.
>>>>>>
>>>>>> The hypervisor, in addition to the function-id, expects the capability-id
>>>>>> to be passed in x1 register when SMC/HVC call is invoked.
>>>>>>
>>>>>> The capability-id is allocated by the hypervisor on bootup and is stored in
>>>>>> the shmem region by the firmware before starting Linux.
>>>>>>
>>>>> Since you are happy to move to signed value, I assume you are happy to loose
>>>>> upper half of the range values ?
>>>>>
>>>>> Anyways after Bjorn pointed out inconsistency, I am thinking of moving
>>>>> all the values to unsigned long to work with both 32bit and 64bit.
>>>>>
>>>>> Does the below delta on top of this patch works for you and makes sense?
>>>> This looks good to me. Will do some testing and float v6 with the changes
>>>> you suggested below. Thanks
>>>>
>>> Please refer or use the patch from [1] when reposting. I rebased on my
>>> patch[2] that I posted few minutes back. I am trying to finalise the branch
>>> and send PR in next couple of days, so please test and post sooner. Sorry
>>> for the rush.
>> Validated the patch from [1] below on Qualcomm ARM64 virtual platform using
>> SMC64 convention. Thanks!
>>
> Thanks, since I have patched a bit, it is better if you post them so that
> we have a link for the exact patch on the list. Just pick up the patches
> from the branch[1] and post them as v6 with a change log so that all the
> details are captured for reference purposes.

v6 on its way, thanks!


>
