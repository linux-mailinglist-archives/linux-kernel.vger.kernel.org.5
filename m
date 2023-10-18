Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFC97CD145
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 02:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjJRA0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 20:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJRA0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 20:26:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD9DA4;
        Tue, 17 Oct 2023 17:26:14 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39HNO5P7026973;
        Wed, 18 Oct 2023 00:25:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=15RYQdT6m7iWcWeSsv90aUlOyCZ517t+tMdVefgstE8=;
 b=IcG+bLna/+YaL/0UE5HxdYsa15Xv7+DhS2TRhKFhvwPI3KTZdlGL3nCsMkEk8vko1taV
 JABsmS+bsRUA1N7spOqYoM1IhmO1QaA+KTcs+40u+95vKPUeJgo+pIXyGI+koigz9xNr
 ow/QN/hVDq9X16P0KSk3vZeDuMcUSiGfHRiQhlLK/UgIG3GaUvPSZU56+n/Ua3VirGo7
 Mj8j+SU/+u1iV7t743cvP4tRy86u0HWB/UJtehEMC3fnjMsDRFPnAkGChEYGLCSbLDaf
 LTAL2l1ejfGrkfp0ghFp1FIha0rmYf9u4NHrjDqOoj7Ogsp85HPX5dsUjaNVlf/ug8Tv +g== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tsr7c1r9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 00:25:55 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39I0PsdZ012718
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 00:25:54 GMT
Received: from [10.71.115.127] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Tue, 17 Oct
 2023 17:25:53 -0700
Message-ID: <366d50fa-500f-e884-d48a-197e65bb2fb7@quicinc.com>
Date:   Tue, 17 Oct 2023 17:25:47 -0700
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
From:   Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <9942bb93-31ea-4574-940f-98d87a2fc127@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: taLlUA-GgwY8lg2uCsRZXu6Wnb8EXH4V
X-Proofpoint-GUID: taLlUA-GgwY8lg2uCsRZXu6Wnb8EXH4V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-17_07,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1011 bulkscore=0 adultscore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180000
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

On 10/17/2023 1:58 PM, Pierre-Louis Bossart wrote:
> It's been a very long time since I reviewed earlier versions, and I am
> still lost on terminology and concepts. The explanations below should
> really be added as a .rst file in Documentation for reference, not just
> as a cover letter.
> 

Thanks for the review!

Sure, maybe I can write a more comprehensive documentation that saves 
these details somewhere.  Will add a RST documentation for material 
where necessary.

>> Several Qualcomm based chipsets can support USB audio offloading to a
>> dedicated audio DSP, which can take over issuing transfers to the USB
>> host controller.  The intention is to reduce the load on the main
>> processors in the SoC, and allow them to be placed into lower power modes.
>> There are several parts to this design:
>>    1. Adding ASoC binding layer
>>    2. Create a USB backend for Q6DSP
> 
> "backend" is a loaded terms for ASoC. Can you clarify which part of the
> ascii art below is a 'backend'?
> 

This would be the Q6USB entity which is the DPCM backend for this 
particular audio path.

>>    3. Introduce XHCI interrupter support
>>    4. Create vendor ops for the USB SND driver
>>
>>        USB                          |            ASoC
>> --------------------------------------------------------------------
>>                                     |  _________________________
>>                                     | |sm8250 platform card     |
>>                                     | |_________________________|
>>                                     |         |           |
>>                                     |      ___V____   ____V____
>>                                     |     |Q6USB   | |Q6AFE    |
>>                                     |     |"codec" | |"cpu"    |
>>                                     |     |________| |_________|
>>                                     |         ^  ^        ^
>>                                     |         |  |________|
>>                                     |      ___V____    |
>>                                     |     |SOC-USB |   |
>>     ________       ________               |        |   |
>>    |USB SND |<--->|QC offld|<------------>|________|   |
>>    |(card.c)|     |        |<----------                |
>>    |________|     |________|___     | |                |
>>        ^               ^       |    | |    ____________V_________
>>        |               |       |    | |   |APR/GLINK             |
>>     __ V_______________V_____  |    | |   |______________________|
>>    |USB SND (endpoint.c)     | |    | |              ^
>>    |_________________________| |    | |              |
>>                ^               |    | |   ___________V___________
>>                |               |    | |->|audio DSP              |
>>     ___________V_____________  |    |    |_______________________|
>>    |XHCI HCD                 |<-    |
>>    |_________________________|      |
>>
>>
>> Adding ASoC binding layer:
>> soc-usb: Intention is to treat a USB port similar to a headphone jack.
> 
> What is a 'port'? USB refers to "interfaces" and "endpoints". Is a
> "port" a 1:1 mapping to "endpoint"?
> 
> Below I read "AFE port" so not sure what concepts refer to what.
> 

"Port" in this explanation refers to the USB port.  So the audio device 
connected.  You are right that a USB device can enumerate w/ multiple 
interfaces (ie UAC + HID + ...) so the closest relation to "port" is 
"interface."  It is not a 1:1 mapping w/ the number of endpoints exposed 
by a device.

"AFE port" is just something that has been termed from the audio DSP 
end, so that concept of port is not related to the port where USB 
devices are connected to.  This is something that is defined within the 
audio DSP.

>> The port is always present on the device, but cable/pin status can be
>> enabled/disabled.  Expose mechanisms for USB backend ASoC drivers to
>> communicate with USB SND.
>>
>> Create a USB backend for Q6DSP:
>> q6usb: Basic backend driver that will be responsible for maintaining the
> 
> The asciiart above suggests that q6usb exposes a codec DAI - but the
> backend dailink is created by the platform card?
> 

That is my understanding, at least.  The machine driver (sm8250.c) has 
an API that parses our DT node for the DAI relationships 
(qcom_snd_parse_of()), and seems to also create the dailinks.

>> resources needed to initiate a playback stream using the Q6DSP.  Will
> 
> is capture supported? there's explicit references to "num_capture" in
> following patches.
> 

We (QCOM) do not support capture at the moment, but the num_capture was 
added to the soc-usb driver, which is platform independent.  This is in 
case other vendors want to add this support, but have capture included 
as well.

>> be the entity that checks to make sure the connected USB audio device
>> supports the requested PCM format.  If it does not, the PCM open call will
>> fail, and userpsace ALSA can take action accordingly.
>>
>> Introduce XHCI interrupter support:
>> XHCI HCD supports multiple interrupters, which allows for events to be routed
>> to different event rings.  This is determined by "Interrupter Target" field
>> specified in Section "6.4.1.1 Normal TRB" of the XHCI specification.
>>
>> Events in the offloading case will be routed to an event ring that is assigned
>> to the audio DSP.
>>
>> Create vendor ops for the USB SND driver:
>> qc_audio_offload: This particular driver has several components associated
>> with it:
>> - QMI stream request handler
>> - XHCI interrupter and resource management
>> - audio DSP memory management
>>
>> When the audio DSP wants to enable a playback stream, the request is first
>> received by the ASoC platform sound card.  Depending on the selected route,
>> ASoC will bring up the individual DAIs in the path.  The Q6USB backend DAI
>> will send an AFE port start command (with enabling the USB playback path), and
>> the audio DSP will handle the request accordingly.
> 
> what about capture, e.g. for a headset?
> 

Not supported yet at the moment.

>> Part of the AFE USB port start handling will have an exchange of control
>> messages using the QMI protocol.  The qc_audio_offload driver will populate the
>> buffer information:
>> - Event ring base address
>> - EP transfer ring base address
>>
>> and pass it along to the audio DSP.  All endpoint management will now be handed
>> over to the DSP, and the main processor is not involved in transfers.
>>
>> Overall, implementing this feature will still expose separate sound card and PCM
>> devices for both the platorm card and USB audio device:
> 
> typo: platform
> 

Thanks, will fix this.

>>   0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
>>                        SM8250-MTP-WCD9380-WSA8810-VA-DMIC
> 
> How do you plan on exposing the USB PCM device?
> 
> The lines above are really cryptic, and with no USB reference in any of
> the short/long card names it's not obvious that this card is different
> from the no-offload case, is it?
> 

In the end, since the offload case is handled by the audio DSP, it would 
have to go through the platform/machine sound card.  That is the sm8250 
device above.

>>   1 [Audio          ]: USB-Audio - USB Audio
>>                        Generic USB Audio at usb-xhci-hcd.1.auto-1.4, high speed
> 
> likewise some sort of qualifier would be useful to show that card 0 and
> card 1 can target the same USB endpoints.
> 

Do userspace entities look at this card string?  Assuming there is only 
one platform card, there are situations where maybe multiple USB audio 
devices are connected to the same USB root hub, so offloading can happen 
on any one of them (not at the same time).

Thanks
Wesley Cheng
