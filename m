Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4DCD7CE8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbjJRUVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbjJRUVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:21:00 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D69F7;
        Wed, 18 Oct 2023 13:20:57 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39IK7lTF014408;
        Wed, 18 Oct 2023 20:20:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=6mx90AgWVz5rukU5siQWHeg1KcldoQGyXo4/+bNJvWY=;
 b=RIHjq2269e3KqHnH7MR2OoKSX3GmuFpFPV6jXAVf6oXUX6rvcmkRMFNlE0ugit1O9c6f
 fwSRX77a1Dzrm4xgseyVTC+k+k10CS+oeSL5mu6oQAdrnZczDYm4DzO0WAGRLy4+axfR
 sU/0fjb4w3hiT8lRvGX6Eg1I5qPhSoOEn2sK3+hUIbsw+HkivRp74IK8jsjquSWnBhil
 myBlQ+ltlGAL+V2EzkkiehL4AfBGjWCRRl/AZeT46FKw6iH4QEdePmODhIXCUG54zjvQ
 L2edJ00zWJw8TtrA62SjNJZuZUMuRzdzQJ5fdWwUSosfKnZUZyPA83h7x+ScKTWbAJK5 1g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tt5v827du-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 20:20:21 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39IKKKhg009064
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 20:20:20 GMT
Received: from [10.110.123.255] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Wed, 18 Oct
 2023 13:20:19 -0700
Message-ID: <3c3bb8d3-694c-cd65-e15f-7c9e7b4eaf0e@quicinc.com>
Date:   Wed, 18 Oct 2023 13:20:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v9 00/34] Introduce QC USB SND audio offloading support
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <srinivas.kandagatla@linaro.org>, <bgoswami@quicinc.com>,
        <Thinh.Nguyen@synopsys.com>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20231017200109.11407-1-quic_wcheng@quicinc.com>
 <9942bb93-31ea-4574-940f-98d87a2fc127@linux.intel.com>
 <366d50fa-500f-e884-d48a-197e65bb2fb7@quicinc.com>
 <925d7c03-c288-49a4-8bcd-395b32810d75@linux.intel.com>
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <925d7c03-c288-49a4-8bcd-395b32810d75@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OPOdJVawoVqDVhG49WrZpmQGkzmOHbKL
X-Proofpoint-ORIG-GUID: OPOdJVawoVqDVhG49WrZpmQGkzmOHbKL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_18,2023-10-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=616 lowpriorityscore=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180167
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On 10/18/2023 6:54 AM, Pierre-Louis Bossart wrote:
> 
> 
> On 10/17/23 19:25, Wesley Cheng wrote:
>> Hi Pierre,
>>
>> On 10/17/2023 1:58 PM, Pierre-Louis Bossart wrote:
>>> It's been a very long time since I reviewed earlier versions, and I am
>>> still lost on terminology and concepts. The explanations below should
>>> really be added as a .rst file in Documentation for reference, not just
>>> as a cover letter.
>>>
>>
>> Thanks for the review!
>>
>> Sure, maybe I can write a more comprehensive documentation that saves
>> these details somewhere.  Will add a RST documentation for material
>> where necessary.
>>
>>>> Several Qualcomm based chipsets can support USB audio offloading to a
>>>> dedicated audio DSP, which can take over issuing transfers to the USB
>>>> host controller.  The intention is to reduce the load on the main
>>>> processors in the SoC, and allow them to be placed into lower power
>>>> modes.
>>>> There are several parts to this design:
>>>>     1. Adding ASoC binding layer
>>>>     2. Create a USB backend for Q6DSP
>>>
>>> "backend" is a loaded terms for ASoC. Can you clarify which part of the
>>> ascii art below is a 'backend'?
>>>
>>
>> This would be the Q6USB entity which is the DPCM backend for this
>> particular audio path.
> 
> DPCM is about dailinks. Technically the q6usb entity is a codec dai
> which is part of a DPCM backend dailink.
>>
>>>>     3. Introduce XHCI interrupter support
>>>>     4. Create vendor ops for the USB SND driver
>>>>
>>>>         USB                          |            ASoC
>>>> --------------------------------------------------------------------
>>>>                                      |  _________________________
>>>>                                      | |sm8250 platform card     |
>>>>                                      | |_________________________|
>>>>                                      |         |           |
>>>>                                      |      ___V____   ____V____
>>>>                                      |     |Q6USB   | |Q6AFE    |
>>>>                                      |     |"codec" | |"cpu"    |
>>>>                                      |     |________| |_________|
>>>>                                      |         ^  ^        ^
>>>>                                      |         |  |________|
>>>>                                      |      ___V____    |
>>>>                                      |     |SOC-USB |   |
>>>>      ________       ________               |        |   |
>>>>     |USB SND |<--->|QC offld|<------------>|________|   |
>>>>     |(card.c)|     |        |<----------                |
>>>>     |________|     |________|___     | |                |
>>>>         ^               ^       |    | |    ____________V_________
>>>>         |               |       |    | |   |APR/GLINK             |
>>>>      __ V_______________V_____  |    | |   |______________________|
>>>>     |USB SND (endpoint.c)     | |    | |              ^
>>>>     |_________________________| |    | |              |
>>>>                 ^               |    | |   ___________V___________
>>>>                 |               |    | |->|audio DSP              |
>>>>      ___________V_____________  |    |    |_______________________|
>>>>     |XHCI HCD                 |<-    |
>>>>     |_________________________|      |
>>>>
>>>>
>>>> Adding ASoC binding layer:
>>>> soc-usb: Intention is to treat a USB port similar to a headphone jack.
>>>
>>> What is a 'port'? USB refers to "interfaces" and "endpoints". Is a
>>> "port" a 1:1 mapping to "endpoint"?
>>>
>>> Below I read "AFE port" so not sure what concepts refer to what.
>>>
>>
>> "Port" in this explanation refers to the USB port.  So the audio device
>> connected.  You are right that a USB device can enumerate w/ multiple
>> interfaces (ie UAC + HID + ...) so the closest relation to "port" is
>> "interface."  It is not a 1:1 mapping w/ the number of endpoints exposed
>> by a device.
>>
>> "AFE port" is just something that has been termed from the audio DSP
>> end, so that concept of port is not related to the port where USB
>> devices are connected to.  This is something that is defined within the
>> audio DSP.
> 
> Wow. So there's a "USB port" and "AFE port". I would recommend avoiding
> the same term for completely different concepts. Why not use "USB device"?
> 

I think maybe USB interface is probably the most acceptable, since even 
at the USB snd level, they work based on usb_interface, not on the udev 
(USB device) itself.

>>>>    0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
>>>>                         SM8250-MTP-WCD9380-WSA8810-VA-DMIC
>>>
>>> How do you plan on exposing the USB PCM device?
>>>
>>> The lines above are really cryptic, and with no USB reference in any of
>>> the short/long card names it's not obvious that this card is different
>>> from the no-offload case, is it?
>>>
>>
>> In the end, since the offload case is handled by the audio DSP, it would
>> have to go through the platform/machine sound card.  That is the sm8250
>> device above.
>>
>>>>    1 [Audio          ]: USB-Audio - USB Audio
>>>>                         Generic USB Audio at usb-xhci-hcd.1.auto-1.4,
>>>> high speed
>>>
>>> likewise some sort of qualifier would be useful to show that card 0 and
>>> card 1 can target the same USB endpoints.
>>>
>>
>> Do userspace entities look at this card string?  Assuming there is only
>> one platform card, there are situations where maybe multiple USB audio
>> devices are connected to the same USB root hub, so offloading can happen
>> on any one of them (not at the same time).
> 
> Jaroslav cares, as measured by the changes over the years to make the
> card names more self-explanatory.
> 
> I really don't see anything in the SM8250MTPWCD938 card name that would
> hint at the support of USB. If it's not in the card string, maybe this
> can be added in the component string as well (amixer -Dhw:0 info). The
> point is that userspace should not have to maintain an 'accept-list' of
> card names but have the means to check the USB offload capability with a
> vendor-neutral convention.

I'll take a look at adding it into the components string.  At least in 
that case, we'd be able to dynamically modify to say if USB offload is 
supported or not based on the child entries/paths that are defined in 
the DT node.

Thanks
Wesley Cheng
