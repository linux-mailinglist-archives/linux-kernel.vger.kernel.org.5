Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857C97D6097
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 05:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjJYDuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 23:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjJYDuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 23:50:10 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C372F90;
        Tue, 24 Oct 2023 20:50:08 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39P30CMx011193;
        Wed, 25 Oct 2023 03:50:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rZmYiKo8tWy9GaB0AD6lA01FHY8CzNZxdNsmy7s2JBw=;
 b=eiqMjyIDKU7AFdZoq1B6XT2MjhmC9qk6Z2Uk2AI7f4kzKq6CnPBV9RC9YPu6JVPnhabx
 SXrUcYifr+kqSAk73Jg0aEn1VU91/uLdeZpPKL+cWA0zMxVF6Dsvkjs1gGLQWy+1N1Ok
 u5x8kI8BJzl9r4IDP7mGxrpeDSCflFFULGnO4XDoa+pP3A53t/oh+fuES4XvqjrHYftg
 NPh9Fnv6EV+JxDg2QCpKxuwekTLjoO60NUsG2ZzSd0M6veAwwd6pI26EZmt8jhhvCjoB
 TJxK0vTO5+p6FlDpALor5lRFwM3IW3V2Gwz5J61dSbLQVkBx2PxqcV615qX2kxEBTh2d Sg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3txngvgm30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 03:50:01 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39P3o00X008552
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Oct 2023 03:50:00 GMT
Received: from [10.201.2.96] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 24 Oct
 2023 20:49:56 -0700
Message-ID: <0fa6630b-ca9f-4441-b698-f983ed8b9748@quicinc.com>
Date:   Wed, 25 Oct 2023 09:19:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3 v7] Misc SCM changes
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Mukesh Ojha <quic_mojha@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <p.zabel@pengutronix.de>, <linus.walleij@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1696440338-12561-1-git-send-email-quic_mojha@quicinc.com>
 <f3a4c114-b430-47ce-a746-4a840994dc58@quicinc.com>
 <CAA8EJpr0Nnn5Tr=2CBAADYfNU6cnKuq==x5L5YQoko9C=3q2tg@mail.gmail.com>
 <d6f48748-22c4-4e4c-a1e9-7a6940b9b432@quicinc.com>
 <CAA8EJpqd-1=sFd3Hm-XbAq8WJfY+hL2Hd5mc23RnCimMbQM69w@mail.gmail.com>
From:   Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
In-Reply-To: <CAA8EJpqd-1=sFd3Hm-XbAq8WJfY+hL2Hd5mc23RnCimMbQM69w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9MB8euq6kkXIVYVe34pFj1iGcjGIdNJF
X-Proofpoint-ORIG-GUID: 9MB8euq6kkXIVYVe34pFj1iGcjGIdNJF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-25_01,2023-10-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 mlxlogscore=895 impostorscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310170001 definitions=main-2310250031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/2023 1:34 AM, Dmitry Baryshkov wrote:
> On Tue, 24 Oct 2023 at 19:00, Kathiravan Thirumoorthy
> <quic_kathirav@quicinc.com> wrote:
>>
>>
>> On 10/24/2023 8:38 PM, Dmitry Baryshkov wrote:
>>
>> On Tue, 24 Oct 2023 at 16:31, Kathiravan Thirumoorthy
>> <quic_kathirav@quicinc.com> wrote:
>>
>> On 10/4/2023 10:55 PM, Mukesh Ojha wrote:
>>
>> I have given version to this series as v7 as it has already
>> gone through v6 and later got added to minidump patch series
>> However, these 3 patches can go independently and has no
>> relation with minidump hence, separated it from minidump series.
>>
>> Mukesh, Can you rebase this series on top of linux-next, since there is
>> a conflict?
>>
>>
>> Bjorn, after rebase is done, will you able to pick it up for v6.7 if
>> there is a time? These patches(#1  and #3) are required for the crash
>> dump collection on IPQ9574 and IPQ5332 SoCs.
>>
>> It is not obvious that they are fixes for the crash. You did not add
>> Fixes tags, you didn't follow
>> Documentation/process/stable-kernel-rules.rst. Cover letter is
>> useless. How can we guess that they are urgent / important?
>>
>>
>> Dmitry,
> 
> Could you please turn off HTML message composition. For example your
> message completely messed up the quoting in the text above.


My bad. After the mail client update, HTML message composition is enabled.

> 
>> These patches are not the *fixes* for the existing crashes, these are required to *enable* the crash dump / ram dump collection by boot loader when qcom_scm.download_mode is set to 1 on IPQ9574 and IPQ5332 SoCs.
> 
> Please excuse me, I misread your message, mea culpa. Indeed, they are
> not a fix for the existing error...


Yeah, no problem at all.


> 
>>
>> Reason why I *requested* to pick it up for 6.7 if possible is, initial version is submitted in Jan 2023 by Poovendhan[1] and then later Mukesh integrated the initial series into his minidump series. Then I separated out these patches[2] from mindump series since there is no dependency for these patches to be part of minidump series but unfortunately again integrated back into the minidump series. Finally Mukesh again separated out these patches now.
>>
>> Since there are no active comments to be addressed, I was hoping this series to be picked for 6.7. As long as these patches doesn't go out of the radar, I'm fine :)
>>
> 
> 
> --
> With best wishes
> Dmitry
