Return-Path: <linux-kernel+bounces-43388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFD03841306
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4FFD287455
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C1B1EB42;
	Mon, 29 Jan 2024 19:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="i4o151IY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B143D76C85;
	Mon, 29 Jan 2024 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555132; cv=none; b=BvdvW2/Dtur91VTV9Iv5THsCcOX3wYrG63HXmsBkyVpk+UL4qbt9InTY4FdMnbFQqab7wK4ZmlTpKfeMUQBZ6RbSbpRbmb8gzvUJvKKM/5yJYnw3l9KgAZ6geQKn9WTb4UoSYVYqZGIifY6VK9GePZ9f0mYFiq6Pin1SvKaIl6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555132; c=relaxed/simple;
	bh=J2F3t7U90gGxRYFzv0nzoRdnJzT5QlZ5PZYI4AZgkwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EX0UdLodZG9ZlDs/QK0NCaFuRzHV8LxyItWk6ltG2mw9uvjsIWJBV0DPeT299mId7drQE496tF7/xqSlfKRJGt5cZakwDHto9JFvSl46j/BGJ44H5eJDMHfgegYPlGosY2QIDqjeSL7WmPVyYwKdWwGfU1Ph4E/fhI1C5205ZOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=i4o151IY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40TIsLAC023069;
	Mon, 29 Jan 2024 19:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=81QrPjX7gzFIZg+7qFwRZB9B2uhffa8qDakhjufL21c=; b=i4
	o151IYh5ZvGeqRCnieSpT4TyaD754RW7PHbksmDhgUIJRAV/lPN4eF18lLv+5UwV
	au4bBjC48IxoTdnp32VPmfLEKvMbngKpbk/QlVSV4/V3olcwvybDDaYjRTTYrkVD
	nGzyqqHvFzVoWu082Syox3nTPjGYtKjD9ui3phf5frhSot0s/800m0u67aNqq9yh
	OapuFp9AR1jFaR4wCiDQucxKvxFa96bHMvrJBp/FHp+Zits0P4kQPwhwcKeCHoxW
	oQ3KvL/LM1RNGEKKI6fWPcnX2GYRzmeIvruQvxtvKDjHOuK+ZYjD2ssVgp02OGZJ
	+h6rQkIiYfcMHjmQJeHA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3t9t61r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 19:05:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40TJ5D65026809
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 19:05:13 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 11:05:12 -0800
Message-ID: <99705d73-abcf-6d41-3d50-757e706cf1fc@quicinc.com>
Date: Mon, 29 Jan 2024 11:05:12 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 0/4] Support for Simulated Panels
Content-Language: en-US
To: Maxime Ripard <mripard@kernel.org>
CC: Jani Nikula <jani.nikula@linux.intel.com>,
        Jessica Zhang
	<quic_jesszhan@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, "Daniel
 Vetter" <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED
 DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
References: <20240116-jz-test-sim-panel-v1-0-f9511f46c9c7@quicinc.com>
 <x6wi5xnihnbpqsujjfjfw3ft6njncruta5l3xa44pds5oxmdkw@mmvv4bciy65s>
 <87cyu0qn81.fsf@intel.com> <e1f10583-1d5b-fdac-24bf-098a0ba06241@quicinc.com>
 <hhmbghooegclx3jbsx2neryligk3mj77lq7gns5xegags5ltoz@acdu6hssqwlw>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <hhmbghooegclx3jbsx2neryligk3mj77lq7gns5xegags5ltoz@acdu6hssqwlw>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BtSEJq69FeWsXz7GNLyzTyemKb1WNfHV
X-Proofpoint-ORIG-GUID: BtSEJq69FeWsXz7GNLyzTyemKb1WNfHV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_12,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401290141

<adding device tree maintainers to comment>

Hi Maxime

On 1/26/2024 4:45 AM, Maxime Ripard wrote:
> On Wed, Jan 17, 2024 at 09:36:20AM -0800, Abhinav Kumar wrote:
>> Hi Jani and Maxime
>>
>> On 1/17/2024 2:16 AM, Jani Nikula wrote:
>>> On Wed, 17 Jan 2024, Maxime Ripard <mripard@kernel.org> wrote:
>>>> Hi,
>>>>
>>>> On Tue, Jan 16, 2024 at 02:22:03PM -0800, Jessica Zhang wrote:
>>>>> This series introduces a simulated MIPI DSI panel.
>>>>>
>>>>> Currently, the only way to validate DSI connectors is with a physical
>>>>> panel. Since obtaining physical panels for all possible DSI configurations
>>>>> is logistically infeasible, introduce a way for DSI drivers to simulate a
>>>>> panel.
>>>>>
>>>>> This will be helpful in catching DSI misconfiguration bugs and catching
>>>>> performance issues for high FPS panels that might not be easily
>>>>> obtainable.
>>>>>
>>>>> For now, the simulated panel driver only supports setting customized
>>>>> modes via the panel_simlation.mode modparam. Eventually, we would like
>>>>> to add more customizations (such as configuring DSC, dual DSI, etc.).
>>>>
>>>> I think that it's more complicated than it needs to be.
>>>
>>> Both too complicated and not complicated enough! :p
>>
>> The end goal is to have a framework to be able to validate the display
>> pipeline with MIPI panels of any resolution , DSC/non-DSC, different MIPI
>> flags etc.
>>
>> Historically, QC has been having an in-house framework to validate the
>> panels in a simulated way as its logistically not possible to procure every
>> panel from every vendor. This has been working pretty well but its not
>> upstream yet. So we would like to work with the community to work on a model
>> which works for everyone and this RFC was initiated with that in mind.
> 
> I think the goal was pretty clear. My point was more that there's no
> reason it should be driver specific, and having a second path for it
> doesn't really exert the actual panel path in the driver. I think a
> separate driver would be better.
> 

We can make this generic. That would be great actually. One option could 
be to move the modparam we have within the msm to the drm_of.c so that 
drm_of_find_panel_or_bridge shall return the sim panel if the modparam 
is passed to select a sim panel.

So if we make this a compile time decision whether to use real panel or 
sim panel and just enable the appropriate config, we dont need the 
modparam and we can implement some policy in the drm_of to first check 
if sim panel is available and if not try the real panel then everything 
will just happen under-the-hood. But we thought that a modparam based 
switching might be convenient if users dont want to recompile the code 
to switch but will need to compile both the panels.

>> There is simulation infrastructure in place in upstream for HDMI/DP in the
>> form of chamelium based testing in IGT but no such fwk exists for DSI
>> displays.
>>
>> Different MIPI panels and resolutions test out not only the DSI controller
>> but the entire display pipeline as based on resolution, compression and MIPI
>> mode flags different parts of the pipeline can get exercised.
>>
>>>> Why do we need to support (and switch to) both the actual and
>>>> "simulated" panel?
>>>>
>>
>> As per my discussion on IRC with the panel/bridge maintainers and DT
>> maintainers, a simulation panel does not qualify for its own devicetree as
>> its not a real hardware so we needed to come up with a way to have a module
>> which can be attached to the encoder without its own bindings and
>> devicetree. Thats what led to this RFC.
> 
> I still think it's worth trying, there's plenty of virtual drivers in
> the DT already. But even then, DT policies shouldn't dictate general
> framework design decisions: we have other ways to probe panels than
> using the DT (by loading overlays, registering devices by hand, etc.). I
> still think it would be a good idea to try though.
> 

DT option would be great if accepted and will nicely solve the 
scalability issue of this as it desperately needs one.

I have absolutely no concerns and would be glad if it will be accepted.

Can the DT maintainers please comment if having a device tree for a 
simulation panel would work OR be considered because of the scalability 
of the number of panels which can be tried as Maxime wrote.

>>>> Wouldn't it be simpler if we had a vkms-like panel that we could either
>>>> configure from DT or from debugfs that would just be registered the
>>>> usual way and would be the only panel we register?
>>>
>>
>> No, we need to have validate actual hardware pipeline with the simulated
>> panel. With vkms, actual display pipeline will not be validated. With
>> incorrect display pipeline misconfigurations arising from different panel
>> combinations, this can easily be caught with any existing IGT CRC testing.
>> In addition, all performance related bugs can also be easily caught by
>> simulating high resolution displays.
> 
> That's not what I meant. What I meant was that something like a
> user-configurable, generic, panel driver would be a good idea. Just like
> vkms (with the debugfs patches) is for a full blown KMS device.
> 

Let me respond for both this question and the one below from you/Jani.

Certainly having user-configurable information is a goal here. The 
end-goal is to make everything there in the existing panels such as 
below like I wrote:

1) Display resolution with timings (drm_display_mode)
2) Compression/non-compression
3) Command mode/Video mode
4) MIPI mode flags
5) DCS commands for panel enable/disable and other panel sequences
6) Power-up/Power-down sequence for the panel

But, we also have to see what all is feasible today from the DRM fwk 
standpoint. There are some limitations about what is boot-time 
configurable using bootparams and what is runtime configurable (across a 
modeset) using debugfs.

1) Today, everything part of struct mipi_dsi_device needs to be 
available at boot time from what I can see as we need that while calling 
mipi_dsi_attach(). So for that we went with boot-params.

2) For the list of modes, we can move this to a debugfs like 
"populate_modes" which the client using a sim panel can call before 
picking a mode and triggering a commit.

But we need to have some default mode and configuration.

This is where I am not totally sure of. On HDMI/DP sinks, we usually go 
with a default of 640x480 as that one is guaranteed to be supported 
across sinks.

For MIPI displays, we will have to agree on some default configuration then.

So, we can certainly add debugfs to make the runtime params but we need 
to start with some default during boot-up and move the others to debugfs.

With vkms, can you pls point us to the debugfs patches you are referring 
to? With the current vkms, very little is available which is debugfs 
configurable (overlay, writeback and cursor support).

Ofcourse, all these concerns go away if DT option gets accepted.

>>> I get the idea of trying to test DSI code without panels, and looking at
>>> the goals above, I think your vkms suggestion is going to fall short of
>>> those goals.
>>>
>>> However, my gut feeling is that creating a simulated panel to catch DSI
>>> misconfiguration etc. is going to be insanely complicated, and this
>>> series doesn't even scratch the surface.
>>>
>>> I guess my questions are, what's the scope here really, are those goals
>>> realistic, does more code already exist beyond this skeleton?
>>>
>>
>>
>> This series is only a starting RFC to be able to validate any display mode.
>> This would have to be extended to be able to customize different pieces of
>> the panel. Lets talk about the customizable pieces:
>>
>> 1) Display resolution with timings (drm_display_mode)
>> 2) Compression/non-compression
>> 3) Command mode/Video mode
>> 4) MIPI mode flags
>> 5) DCS commands for panel enable/disable and other panel sequences
>> 6) Power-up/Power-down sequence for the panel
>>
>> Without a physical panel, yes its hard to validate if anything is wrong with
>> (4) OR (5), the display might not come up at all visually. But from our
>> experience, thats only a small portion and the real benefit of this
>> framework will actually be from the validation failures we will catch from
>> (1) to (4).
>>
>> This RFC only provides a way to customize (1) at the moment as we wanted to
>> get some feedback from the community about the best way which will work for
>> everyone to customize all these parameters.
>>
>> We are willing to expand this series based on the generic way we agree on to
>> customize other params.
>>
>> Yes, debugfs is an option too. But typically MIPI displays need some
>> parameters configured to attach the panel to the encoder. So perhaps we can
>> boot the simulation panel with a default resolution passed through command
>> line and then across a modeset switch (1) to (4).
> 
> I think Jani's feeling was that it was going to be super complicated
> fairly fast so supporting more features would definitely help to get an
> idea of where this is going.
> 
> Maxime

