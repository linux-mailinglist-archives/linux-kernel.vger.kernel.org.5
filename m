Return-Path: <linux-kernel+bounces-75693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E47C85ED79
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0E51F21E64
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DD812DD82;
	Wed, 21 Feb 2024 23:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VgkZDCMo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5667833062;
	Wed, 21 Feb 2024 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559800; cv=none; b=l4/jgkf3zSXkldzWhSd1z1CCCByEKi7Jy7nIU63+l3BlNyeh9TPubGrSmXTigXZpgCrlaIya0uIEqYAvLAn8htws3qOu6s3bDJ679XmxIKIrNMIDo8pT76/UTKNSQIjx2eX8n6QKdy1k2R/qOHhX1TfuUGZnlroI1An5V9wMDgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559800; c=relaxed/simple;
	bh=ZrRwdK5utpp3sgunXkm20f5u3DpzZ9wqTr3RiV71OaI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XvLgK/RF73mysMa9bUk487q01BGW+ryrrsp3tpNBxja5spodWNCYUfMTl2PsVQ/GuFgeaowvYoDOYbNp5Mereu2KmiEx2UKyUI+Q5M0V5dTBqpUuLTAs9MNppgrSva2QdpINjUZgbuO9uFq5ppmNUNnF+q2Pf8k6o/BvbJrGiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VgkZDCMo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41LNPbkR007930;
	Wed, 21 Feb 2024 23:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mBBdeNeRX1o2UytltzPYiypy62H+/fRXys7G2pTuS8U=; b=Vg
	kZDCMoyGE1qiuR9gR47YgGY9YdyOkGAR8XteT3z7QmDMjTw8dW9vAwzvleAQ8zkU
	8ACReR3JphO+AXEwhccvaqQcm9T1BZ2BI8MoWezKDPUkwTe2+KQGI7dXH7llg/SH
	3leYRnuLPVBdNZQ4HfuRbstArj+e/q/g5LLk5geynrpzQrx0DnN3VGqbxOdvd+EE
	i9U1O1WB6Mr+dwA3EQTY7w8M0QIuMMBz/guUkoVMz1P+LTSETkZx/xiRE2VOkvCi
	gDfIAGFI4LKwzAdKWEu29SYrLl4BILeTXm98E7wzRK+TjMQrVwF6BcNyyn58ClDs
	9ULYOs4yqSiw3mQ/l0TA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wdckva57u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:56:10 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41LNu8Yq006834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Feb 2024 23:56:08 GMT
Received: from [10.110.112.198] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 21 Feb
 2024 15:56:07 -0800
Message-ID: <0587cb46-1821-0daf-2d6e-08c5af5b97a3@quicinc.com>
Date: Wed, 21 Feb 2024 15:56:03 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v17 00/51] Introduce QC USB SND audio offloading support
Content-Language: en-US
To: Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg KH
	<gregkh@linuxfoundation.org>
CC: <srinivas.kandagatla@linaro.org>, <mathias.nyman@intel.com>,
        <perex@perex.cz>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <lgirdwood@gmail.com>, <andersson@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Thinh.Nguyen@synopsys.com>,
        <broonie@kernel.org>, <bgoswami@quicinc.com>, <tiwai@suse.com>,
        <robh+dt@kernel.org>, <konrad.dybcio@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-sound@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20240217001017.29969-1-quic_wcheng@quicinc.com>
 <2024021754-unengaged-saggy-6ab1@gregkh>
 <96ab6033-2cb9-daa7-ddad-090138896739@linux.intel.com>
From: Wesley Cheng <quic_wcheng@quicinc.com>
In-Reply-To: <96ab6033-2cb9-daa7-ddad-090138896739@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rs_sXXBYYB9Z73h-F7xbtB2aqFFUUtDC
X-Proofpoint-ORIG-GUID: rs_sXXBYYB9Z73h-F7xbtB2aqFFUUtDC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-21_09,2024-02-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402210188

Hi Mathias,

On 2/19/2024 2:27 AM, Mathias Nyman wrote:
> On 17.2.2024 17.25, Greg KH wrote:
>> On Fri, Feb 16, 2024 at 04:09:26PM -0800, Wesley Cheng wrote:
>>> Several Qualcomm based chipsets can support USB audio offloading to a
>>> dedicated audio DSP, which can take over issuing transfers to the USB
>>> host controller.  The intention is to reduce the load on the main
>>> processors in the SoC, and allow them to be placed into lower power 
>>> modes.
>>> There are several parts to this design:
>>>    1. Adding ASoC binding layer
>>>    2. Create a USB backend for Q6DSP
>>>    3. Introduce XHCI interrupter support
>>>    4. Create vendor ops for the USB SND driver
>>>
>>>        USB                          |            ASoC
>>> --------------------------------------------------------------------
>>>                                     |  _________________________
>>>                                     | |sm8250 platform card     |
>>>                                     | |_________________________|
>>>                                     |         |           |
>>>                                     |      ___V____   ____V____
>>>                                     |     |Q6USB   | |Q6AFE    |
>>>                                     |     |"codec" | |"cpu"    |
>>>                                     |     |________| |_________|
>>>                                     |         ^  ^        ^
>>>                                     |         |  |________|
>>>                                     |      ___V____    |
>>>                                     |     |SOC-USB |   |
>>>     ________       ________               |        |   |
>>>    |USB SND |<--->|QC offld|<------------>|________|   |
>>>    |(card.c)|     |        |<----------                |
>>>    |________|     |________|___     | |                |
>>>        ^               ^       |    | |    ____________V_________
>>>        |               |       |    | |   |APR/GLINK             |
>>>     __ V_______________V_____  |    | |   |______________________|
>>>    |USB SND (endpoint.c)     | |    | |              ^
>>>    |_________________________| |    | |              |
>>>                ^               |    | |   ___________V___________
>>>                |               |    | |->|audio DSP              |
>>>     ___________V_____________  |    |    |_______________________|
>>>    |XHCI HCD                 |<-    |
>>>    |_________________________|      |
>>>
>>>
>>> Adding ASoC binding layer:
>>> soc-usb: Intention is to treat a USB port similar to a headphone jack.
>>> The port is always present on the device, but cable/pin status can be
>>> enabled/disabled.  Expose mechanisms for USB backend ASoC drivers to
>>> communicate with USB SND.
>>>
>>> Create a USB backend for Q6DSP:
>>> q6usb: Basic backend driver that will be responsible for maintaining the
>>> resources needed to initiate a playback stream using the Q6DSP.  Will
>>> be the entity that checks to make sure the connected USB audio device
>>> supports the requested PCM format.  If it does not, the PCM open call 
>>> will
>>> fail, and userpsace ALSA can take action accordingly.
>>>
>>> Introduce XHCI interrupter support:
>>> XHCI HCD supports multiple interrupters, which allows for events to 
>>> be routed
>>> to different event rings.  This is determined by "Interrupter Target" 
>>> field
>>> specified in Section "6.4.1.1 Normal TRB" of the XHCI specification.
>>>
>>> Events in the offloading case will be routed to an event ring that is 
>>> assigned
>>> to the audio DSP.
>>>
>>> Create vendor ops for the USB SND driver:
>>> qc_audio_offload: This particular driver has several components 
>>> associated
>>> with it:
>>> - QMI stream request handler
>>> - XHCI interrupter and resource management
>>> - audio DSP memory management
>>>
>>> When the audio DSP wants to enable a playback stream, the request is 
>>> first
>>> received by the ASoC platform sound card.  Depending on the selected 
>>> route,
>>> ASoC will bring up the individual DAIs in the path.  The Q6USB 
>>> backend DAI
>>> will send an AFE port start command (with enabling the USB playback 
>>> path), and
>>> the audio DSP will handle the request accordingly.
>>>
>>> Part of the AFE USB port start handling will have an exchange of control
>>> messages using the QMI protocol.  The qc_audio_offload driver will 
>>> populate the
>>> buffer information:
>>> - Event ring base address
>>> - EP transfer ring base address
>>>
>>> and pass it along to the audio DSP.  All endpoint management will now 
>>> be handed
>>> over to the DSP, and the main processor is not involved in transfers.
>>>
>>> Overall, implementing this feature will still expose separate sound 
>>> card and PCM
>>> devices for both the platorm card and USB audio device:
>>>   0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
>>>                        SM8250-MTP-WCD9380-WSA8810-VA-DMIC
>>>   1 [Audio          ]: USB-Audio - USB Audio
>>>                        Generic USB Audio at usb-xhci-hcd.1.auto-1.4, 
>>> high speed
>>>
>>> This is to ensure that userspace ALSA entities can decide which route 
>>> to take
>>> when executing the audio playback.  In the above, if card#1 is 
>>> selected, then
>>> USB audio data will take the legacy path over the USB PCM drivers, 
>>> etc...
>>>
>>> This feature was validated using:
>>> - tinymix: set/enable the multimedia path to route to USB backend
>>> - tinyplay: issue playback on platform card
>>
>> I've applied patches 1-10 and the 2 dts changes here, as those all had
>> acks from the relevant maintainers already.
>>
> 
> Patch 10/10 is based on an old POC patch by me, but it's heavily modified.
> 
> It looks like it does a few minor things that are not optimal, like extra
> spinlock/unlock, and wait_for_completion_timeout() with magical timeout 
> value.
> 
> I haven't tested this version, but I guess any fixes or cleanups can be 
> done
> later on top of it.
> 

How about I modify the stop ep sync API to assume that the caller has 
the xhci->lock already held?  I can unlock it before the wait for 
command, and take it back after before returning to the caller.

I'll remove the timeout value from the wait for command as well, since 
if there was a command timeout, that should trigger the cmd_timer to 
expire, and be handled there.

Thanks
Wesley Cheng

