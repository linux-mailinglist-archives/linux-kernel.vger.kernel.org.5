Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063D478C6E7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbjH2OHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236798AbjH2OH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:07:27 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC6DD7;
        Tue, 29 Aug 2023 07:07:18 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TCfBhj000902;
        Tue, 29 Aug 2023 14:06:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ux9fxYpJr1hfeG9Nqx7vzyVY9soFUE7yRD8+Xy/HLIA=;
 b=H73zGt6sGoC/hb60E9vFNh0WIKahymwbexQJ58bA2uunJfLNuYvjGET2W8beJUdJpDBF
 XMMhvkiV0Lz3y/eKv6HWXTEVl+KwGz5CYLQt8PYh0D3KMZC1w+z2ccdH6G8M7y8EN0Bu
 2ootTxRacDFrUQPdMbFJ6ar4LW6wseQdJ7W9qREw2db6JTygtTPJGfgTOxV9DOTUasAd
 tKqDO5FyYSZwLjrfTPAldfC/s48yT08q+HxBU7HeA1+hNwTfbmsMxALQOmfXcxXb68Vq
 goZMR2YoWTs6JviXkXrrZPa/iguqIjcyyyRJs0pC3Ax4r9O1AmUpXYkT1XmCA1TR0hdo XA== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ss2xb9xdq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 14:06:55 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37TE6sIs026854
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 14:06:54 GMT
Received: from [10.50.3.213] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Tue, 29 Aug
 2023 07:06:50 -0700
Message-ID: <21e7b893-2b84-f809-9775-f0c9c86c96a2@quicinc.com>
Date:   Tue, 29 Aug 2023 19:36:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 4/4] venus: hfi_parser: Add check to keep the number of
 codecs within range
Content-Language: en-US
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <stanimir.k.varbanov@gmail.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <hans.verkuil@cisco.com>,
        <tfiga@chromium.org>
CC:     <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <1691634304-2158-1-git-send-email-quic_vgarodia@quicinc.com>
 <1691634304-2158-5-git-send-email-quic_vgarodia@quicinc.com>
 <fec4a8c7-206f-7af8-4ea9-c919a677bf7e@linaro.org>
 <2214c31b-eca2-012e-a100-21252a724e7c@quicinc.com>
 <8b72ce47-c338-2061-f11a-c0a608686d8c@linaro.org>
 <e880da07-ccd4-e427-ed34-20b284dc7838@quicinc.com>
 <8f1a4ca0-dde8-fa5d-bca3-d317886609de@linaro.org>
 <060f4dbe-63d6-1c60-14ca-553bf1536e5a@quicinc.com>
 <c5f912a9-cc08-1645-ad04-c7a58c1e47ce@linaro.org>
 <cd9da205-ccdb-dc71-16a4-83b22ca7fcae@quicinc.com>
 <ea587bb1-8ff2-7a92-f948-fd932f6b2769@linaro.org>
 <9391ae4e-afbd-ef52-12dc-7f8875216c85@quicinc.com>
 <6ecbd88a-150f-d40e-22bf-4fda921fc483@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <6ecbd88a-150f-d40e-22bf-4fda921fc483@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: H60HqpHgS_9o0tz8Oo3wvWWRzjjcMcO6
X-Proofpoint-GUID: H60HqpHgS_9o0tz8Oo3wvWWRzjjcMcO6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_11,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxlogscore=606 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290122
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/29/2023 5:29 PM, Bryan O'Donoghue wrote:
> On 29/08/2023 09:00, Vikash Garodia wrote:
>> Hi Bryan,
>>
>> On 8/14/2023 7:45 PM, Bryan O'Donoghue wrote:
>>> On 14/08/2023 07:34, Vikash Garodia wrote:
>>>>> We have two loops that check for up to 32 indexes per loop. Why not have a
>>>>> capabilities index that can accommodate all 64 bits ?
>>>> Max codecs supported can be 32, which is also a very high number. At max the
>>>> hardware supports 5-6 codecs, including both decoder and encoder. 64 indices is
>>>> would not be needed.
>>>>
>>>
>>> But the bug you are fixing here is an overflow where we have received a full
>>> range 32 bit for each decode and encode.
>>>
>>> How is the right fix not to extend the storage to the maximum possible 2 x 32 ?
>>> Or indeed why not constrain the input data to 32/2 for each encode/decode path ?
>> At this point, we agree that there is very less or no possibility to have this
>> as a real usecase i.e having 64 (or more than 32) codecs supported in video
>> hardware. There seem to be no value add if we are extending the cap array from
>> 32 to 64, as anything beyond 32 itself indicates rogue firmware. The idea here
>> is to gracefully come out of such case when firmware is responding with such
>> data payload.
>> Again, lets think of constraining the data to 32/2. We have 2 32 bit masks for
>> decoder and encoder. Malfunctioning firmware could still send payload with all
>> bits enabled in those masks. Then the driver needs to add same check to avoid
>> the memcpy in such case.
>>
>>> The bug here is that we can copy two arrays of size X into one array of size X.
>>>
>>> Please consider expanding the size of the storage array to accommodate the full
>>> size the protocol supports 2 x 32.
>> I see this as an alternate implementation to existing handling. 64 index would
>> never exist practically, so accommodating it only implies to store the data for
>> invalid response and gracefully close the session.
> 
> What's the contractual definition of "this many bits per encoder and decoder"
> between firmware and APSS in that case ?
> 
> Where do we get the idea that 32/2 per encoder/decoder is valid but 32 per
> encoder decoder is invalid ?
> 
> At this moment in time 16 encoder/decoder bits would be equally invalid.
> 
> I suggest the right answer is to buffer the protocol data unit - PDU maximum as
> an RX or constrain the maximum number of encoder/decoder bits based on HFI version.
> 
> ie.
> 
> - Either constrain on the PDU or
> - Constrain on the known number of maximum bits per f/w version

Let me simply ask this - What benefit we will be getting with above approaches
over the existing handling ?

Thanks,
Vikash
> ---
> bod
> 
