Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871807C9313
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 09:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232750AbjJNHDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 03:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJNHDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 03:03:21 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED76EBB;
        Sat, 14 Oct 2023 00:03:19 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39E6DaiA027765;
        Sat, 14 Oct 2023 07:03:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=AZfIWxobcjY8UjNacL+2ci30sZytA/+zkHoYl47zAqE=;
 b=BeRXWcOyUfYQ2Rxb3UYhOBGriCIGL9WI257/C/JA27V8JL6jWs3Nle7poR1T2aupfKLM
 mK0Csn2pZFepo0ThF3uaxezboiH3mZXw9LATtJaFBiayASIHNUcjMXyo9v7eHq6Uy5nE
 xDNXAko4fFNM5QcKgD6iUxQwsqDil9qUZCGD6RZhyfVKbol3b/uzV9ovMm/2iyHhm5W1
 a8JbVnIn60VfiAshB+Wmh5PONB4zJm8t9jVPvk06I/ThSVkIW1DPqiE9bOz/GpfP1Kti
 WKke5S5Dg1thXz0CEejjHui90jeml37+2Bbu/CSaV+o/HXi30IkPZrqKFwAs3gBpa0tR bQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tqkrp8b4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Oct 2023 07:03:07 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39E7365m020914
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 14 Oct 2023 07:03:06 GMT
Received: from [10.216.59.22] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.36; Sat, 14 Oct
 2023 00:03:02 -0700
Message-ID: <70c15867-ccce-4788-a0dd-38a73decb785@quicinc.com>
Date:   Sat, 14 Oct 2023 12:32:59 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: gadget: ncm: Add support to update
 wMaxSegmentSize via configfs
To:     =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        onathan Corbet <corbet@lwn.net>,
        Linyu Yuan <quic_linyyuan@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>
References: <20231009142005.21338-1-quic_kriskura@quicinc.com>
 <20231009142005.21338-2-quic_kriskura@quicinc.com>
 <CANP3RGfEk2DqZ3biyN78ycQYbDxCEG+H1me2vnEYuwXkNdXnTA@mail.gmail.com>
 <CANP3RGcCpNOuVpdV9n0AFxZo-wsfwi8OfYgBk1WHNHaEd-4V-Q@mail.gmail.com>
 <CANP3RGdY4LsOA6U5kuccApHCzL0_jBnY=pLOYrUuYtMZFTvnbw@mail.gmail.com>
 <d19d9d08-c119-4991-b460-49925f601d15@quicinc.com>
 <fad5a7fb-cce1-46bc-a0af-72405c76d107@quicinc.com>
 <CANP3RGcqWBYd9FqAX47rE9pFgBTB8=0CGdwkScm-OH1epHcVWQ@mail.gmail.com>
 <8ff92053-52ff-4950-95c8-0e986f6a028a@quicinc.com>
 <CANP3RGd4G4dkMOyg6wSX29NYP2mp=LhMhmZpoG=rgoCz=bh1=w@mail.gmail.com>
 <b12eb7b1-54e7-406f-8c19-0046555b82d3@quicinc.com>
 <CANP3RGcUrFTaFL8V3tpuh+qQoEi84O0Dy9ie+XD=-H01c2btAw@mail.gmail.com>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <CANP3RGcUrFTaFL8V3tpuh+qQoEi84O0Dy9ie+XD=-H01c2btAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2tF6HyJS6CjAD-SUC_f0DTQxoud4LNVz
X-Proofpoint-GUID: 2tF6HyJS6CjAD-SUC_f0DTQxoud4LNVz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-13_12,2023-10-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 suspectscore=0 mlxlogscore=316 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310140062
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/2023 4:05 AM, Maciej Żenczykowski wrote:
>>>> The intent of posting the diff was two fold:
>>>>
>>>> 1. The question Greg asked regarding why the max segment size was
>>>> limited to 15014 was valid. When I thought about it, I actually wanted
>>>> to limit the max MTU to 15000, so the max segment size automatically
>>>> needs to be limited to 15014.
>>>
>>> Note that this is a *very* abstract value.
>>> I get you want L3 MTU of 10 * 1500, but this value is not actually meaningful.
>>>
>>> IPv4/IPv6 fragmentation and IPv4/IPv6 TCP segmentation
>>> do not result in a trivial multiplication of the standard 1500 byte
>>> ethernet L3 MTU.
>>> Indeed aggregating 2 1500 L3 mtu frames results in *different* sized
>>> frames depending on which type of aggregation you do.
>>> (and for tcp it even depends on the number and size of tcp options,
>>> though it is often assumed that those take up 12 bytes, since that's the
>>> normal for Linux-to-Linux tcp connections)
>>>
>>> For example if you aggregate N standard Linux ipv6/tcp L3 1500 mtu frames,
>>> this means you have
>>> N frames: ethernet (14) + ipv6 (40) + tcp (20) + tcp options (12) +
>>> payload (1500-12-20-40=1500-72=1428)
>>> post aggregation:
>>> 1 frame: ethernet (14) + ipv6 (40) + tcp (20) + tcp options (12) +
>>> payload (N*1428)
>>>
>>> so N * 1500 == N * (72 + 1428) --> 1 * (72 + N * 1428)
>>>
>>> That value of 72 is instead 52 for 'standard Linux ipv4/tcp),
>>> it's 40/60 if there's no tcp options (which I think happens when
>>> talking to windows)
>>> it's different still with ipv4 fragmentation... and again different
>>> with ipv6 fragmentation...
>>> etc.
>>>
>>> ie. 15000 L3 mtu is exactly as meaningless as 14000 L3 mtu.
>>> Either way you don't get full frames.
>>>
>>> As such I'd recommend going with whatever is the largest mtu that can
>>> be meaningfully made to fit in 16K with all the NCM header overhead.
>>> That's likely closer to 15500-16000 (though I have *not* checked).
>>>
>>>> But my commit text didn't mention this
>>>> properly which was a mistake on my behalf. But when I looked at the
>>>> code, limiting the max segment size 15014 would force the practical
>>>> max_mtu to not cross 15000 although theoretical max_mtu was set to:
>>>> (GETHER_MAX_MTU_SIZE - 15412) during registration of net device.
>>>>
>>>> So my assumption of limiting it to 15000 was wrong. It must be limited
>>>> to 15412 as mentioned in u_ether.c  This inturn means we must limit
>>>> max_segment_size to:
>>>> GETHER_MAX_ETH_FRAME_LEN (GETHER_MAX_MTU_SIZE + ETH_HLEN)
>>>> as mentioned in u_ether.c.
>>>>
>>>> I wanted to confirm that setting MAX_DATAGRAM_SIZE to
>>>> GETHER_MAX_ETH_FRAME_LEN was correct.
>>>>
>>>> 2. I am not actually able to test with MTU beyond 15000. When my host
>>>> device is a linux machine, the cdc_ncm.c limits max_segment_size to:
>>>> CDC_NCM_MAX_DATAGRAM_SIZE               8192    /* bytes */
>>>
>>> In practice you get 50% of the benefits of infinitely large mtu by
>>> going from 1500 to ~2980.
>>> you get 75% of the benefits by going to ~6K
>>> you get 87.5% of the benefits by going to ~12K
>>> the benefits of going even higher are smaller and smaller...
>>>   > If the host side is limited to 8192, maybe we should match that here too?
>>
>> Hi Maciej,
>>
>>    Thanks for the detailed explanation. I agree with you on setting
>> device side also to 8192 instead of what max_mtu is present in u_ether
>> or practical max segment size possible.
>>
>>>
>>> But the host side limitation of 8192 doesn't seem particularly sane either...
>>> Maybe we should relax that instead?
>>>
>> I really didn't understand why it was set to 8192 in first place.
>>
>>> (especially since for things like tcp zero copy you want an mtu which
>>> is slighly more then N * 4096,
>>> ie. around 4.5KB, 8.5KB, 12.5KB or something like that)
>>>
>>
>> I am not sure about host mode completely. If we want to increase though,
>> just increasing the MAX_DATAGRAM_SIZE to some bigger value help ? (I
>> don't know the entire code of cdc_ncm, so I might be wrong).
>>
>> Regards,
>> Krishna,
> 
> Hmm, I'm not sure.  I know I've experimented with high mtu ncm in the past
> (around 2.5 years ago).  I got it working between my Linux desktop (host)
> and a Pixel 6 (device/gadget) with absolutely no problems.
> 
> I'm pretty sure I didn't change my desktop kernel, so I was probably
> limited to 8192 there
> (and I do more or less remember that).
>  From what I vaguely remember, it wasn't difficult (at all) to hit
> upwards of 7gbps for iperf tests.
> I don't remember how close to the theoretical USB 10gbps maximum of
> 9.7gbps I could get...
> [this was never the real bottleneck / issue, so I didn't ever dig
> particularly deep]
> 
> I'm pretty sure my gadget side changes were non-configurable...
> Probably just bumped one or two constants...
> 
Could you share what parameters you changed to get this high value of 
iperf throughput.

> I do *very* *vaguely* recall there being some funkiness though, where 8192 was
> *less* efficient than some slightly smaller value.
> 
> If I recall correctly the issue is that 8192 + ethernet overhead + NCM
> overhead only fits *once* into 16384, which leaves a lot of space
> wasted.
> While ~7.5 kb + overhead fits twice and is thus a fair bit better.
>Right, same goes for using 5K vs 5.5K MTU. If MTU is 5K, 3 packets can 
conveniently fit into an NTB but if its 5.5, at max only two (5.5k) 
packets can fit in (essentially filling ~11k of the 16384 bytes and 
wasting the rest)

And whether its Ipv4/Ipv6 like you mentioned on [1], the MTU is what NCM 
layer receives and we append the Ethernet header and add NCM headers and 
send it out after aggregation. Why can't we set the MAX_DATAGRAM_SIZE to 
~8050 or ~8100 ? The reason I say this value is, obviously setting it to 
8192 would not efficiently use the NTB buffer. We need to fill as much 
space in buffer as possible and assuming that each packet received on 
ncm layer is of MTU size set (not less that that), we can assume that 
even if only 2 packets are aggregated (minimum aggregation possible), we 
would be filling (2 * (8050 + ETH_HLEN) + (room for NCM headers)) would 
almost be close to 16384 ep max packet size. I already check 8050 MTU 
and it works. We can add a comment in code detailing the above 
explanation and why we chose to use 8050 or 8100 as MAX_DATAGRAM_SIZE.

Hope my reasoning of why we can chose 8.1K or 8.05K makes sense. Let me 
know your thoughts on this.

Regards,
Krishna,
