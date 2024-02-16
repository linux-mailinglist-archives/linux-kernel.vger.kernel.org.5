Return-Path: <linux-kernel+bounces-68418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024ED8579FB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE51282901
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FBE1CAAF;
	Fri, 16 Feb 2024 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b="Qg8HL+hO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rqWPu4V7"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AA51C2BC;
	Fri, 16 Feb 2024 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078250; cv=none; b=u6s1ReBpLz6rQZePYTVDwNCEOtr5fsM+SjMfBwmKYTfQRGziZhHtjpfGUy55OoGA+txCMxT4Ii6mxOtugPr6CmiNYeoYCyLISnMRiGeYYqGccj+4tS02esCtGMHMjOKIl+F1W7wLsUM1w4YjFDSL4CNxSo5N9hvnR9zqsi8Di7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078250; c=relaxed/simple;
	bh=QqLqQeOcfOiSF+b3Lf8HGQdoCqZ067iYASQX7TPDUp0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyzMlS1LSdRiM7R+wxM3XYqWUtoI/8Ous1d79RE1ODnokKAuKdgJtLyj4KdR2V+08FskIWwFaspJ9b8AEXeq3uYvG8o5HDCdmpsaw6S99q6609C7EjeEDxrImaqdbDuabyDj8DyOoN3DclTjSc46miTvlztpOJGZCLU+GystQok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me; spf=pass smtp.mailfrom=beims.me; dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b=Qg8HL+hO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rqWPu4V7; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beims.me
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 065765C005F;
	Fri, 16 Feb 2024 05:10:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 16 Feb 2024 05:10:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708078246;
	 x=1708164646; bh=ArrobtSAsWiMG4VSWKgAmIEZR/GcyP56P0RQAll4W5w=; b=
	Qg8HL+hOk9YjaWi5cjttNJswpxaOwXJKJRS13KPRQXeKKif6gZ/zgggYkwmsbtms
	gd0czh9T2jZj6wGFKwvOtG2j8Gj7uda3LUysvxXJP35RKBG1pyL0S0vdRkgQIKq0
	HZuj82EGZk3IatVTx+wObHR/fgVXNpyzYJmGyw57Rdn2yeaJCTGRriqcdQAw1SI7
	NZCZfl3flVnqfJ8aZ+WvHpih9cV8kWeqOwvVSqRl6euAraqois+CTxVZD+CD5OSp
	mOWZmuL7k1rofwKyzclDOJ+wMyIUjckx2Ohfu/6NCfqJCjHWXZsqu3pJ3dGu1o+q
	lOCMqfD5ADuo7zAzLxw70g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708078246; x=
	1708164646; bh=ArrobtSAsWiMG4VSWKgAmIEZR/GcyP56P0RQAll4W5w=; b=r
	qWPu4V7h9mfIGQUW4UQjS0DgAG6qTwOCacx8ukZnnEqV09vuEiadMwxW6jq+WIhZ
	oKZjn4b+UVI9qyOFzaOQsC2LJ8NJ1SXydwu2/oR7MxJ+UdJKFAF1YAkoDKXSF21g
	F+WDH/Eu851FQFMLYDocKvUqm6kxhINCr0KaE1kSpUOgXBoKc+SHkz40UEtJsJdn
	RGMroo0Jcs8ashKbJ4pbVh0mj9FwHuVzmlxnDR9R5BGo/V9kkiOGFA5Qe64kx7Cd
	BbGAu4Xhk4BSgot+CTl1aFdoEGE7aJutuNoBOs11KkLBhtBG7y8bgXc+jwCgA5ag
	QCYHGT8WKltTMiuI6Rmwg==
X-ME-Sender: <xms:pTTPZSGQXDGEhsdu1vAP3jSvNLv7Lt1c5LPqbdGIPv5G7qj2_43zRA>
    <xme:pTTPZTUgSfItg6m43YQFM0jDA-YIQhtBjwJ_EMKuxYVZ-5lm9E73CA-gPjOWeud-r
    0TN-d0wG_qa3XYnNoo>
X-ME-Received: <xmr:pTTPZcKsTnqGhrX89YRijX5LsO4MjeXTBulwr7hGZNfhSTPGXYDH2LCpgE2hM4SN_QI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefkffggfgfuvfevfhfhjggt
    gfesthejredttddvjeenucfhrhhomheptfgrfhgrvghluceuvghimhhsuceorhgrfhgrvg
    hlsegsvghimhhsrdhmvgeqnecuggftrfgrthhtvghrnheptefgueehffelgfffjeekjeek
    veelieevffduueefvddvteeiieehfeekudffuddunecuffhomhgrihhnpehgohhoghhlvg
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehrrghfrggvlhessggvihhmshdrmhgv
X-ME-Proxy: <xmx:pTTPZcFGcYamkDFh1ZB0gHI7t22Kk4pDHBSyxWDZHVhwu5QrmVpQTQ>
    <xmx:pTTPZYVK_NcHavAuP9cZS_QXDqM_5xGJ8TkbLsCv55Y62B_hybwO6w>
    <xmx:pTTPZfPU4Srott9pfAZ_TkQS-D49E82xGkyLQNGpalpwwPu1GnKLlg>
    <xmx:pjTPZSfM-nC8Bx2u7mBORAr8LLyNMAEuBDCTPOQ0A8-F6JoQfCPtRA>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 16 Feb 2024 05:10:44 -0500 (EST)
Message-ID: <3d1c45bd-fb89-4a4c-8f53-b1775f6c9a3e@beims.me>
Date: Fri, 16 Feb 2024 07:10:42 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
 mlme
Content-Language: pt-BR
To: David Lin <yu-hao.lin@nxp.com>, Francesco Dolcini <francesco@dolcini.it>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "briannorris@chromium.org" <briannorris@chromium.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
 <97bb3869-3b82-4b64-87cd-9b63d4516649@beims.me>
 <PA4PR04MB96389A5DDB41DFF80CBB4738D17D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <48364f66-99b4-40ca-b4b2-4adf1071960f@beims.me>
 <ZcSB3_16C6JTgBJB@gaggiata.pivistrello.it>
 <PA4PR04MB96381141AFBE8E61B8DD94F9D14D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <b77af968-ec6f-44df-a544-4ea2a5ad3ff2@beims.me>
 <PA4PR04MB963849A7E04ADEE5DE92002DD14C2@PA4PR04MB9638.eurprd04.prod.outlook.com>
 <PA4PR04MB963887774FBAF4E2E022C552D14C2@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Rafael Beims <rafael@beims.me>
In-Reply-To: <PA4PR04MB963887774FBAF4E2E022C552D14C2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/02/2024 22:48, David Lin wrote:
>> From: David Lin
>> Sent: Friday, February 16, 2024 9:41 AM
>> To: Rafael Beims <rafael@beims.me>; Francesco Dolcini
>> <francesco@dolcini.it>
>> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
>> briannorris@chromium.org; kvalo@kernel.org; Pete Hsieh
>> <tsung-hsien.hsieh@nxp.com>
>> Subject: RE: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
>> mlme
>>
>>> From: Rafael Beims <rafael@beims.me>
>>> Sent: Thursday, February 15, 2024 8:11 PM
>>> To: David Lin <yu-hao.lin@nxp.com>; Francesco Dolcini
>>> <francesco@dolcini.it>
>>> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
>>> briannorris@chromium.org; kvalo@kernel.org; Pete Hsieh
>>> <tsung-hsien.hsieh@nxp.com>
>>> Subject: Re: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to
>>> support host mlme
>>>
>>> Caution: This is an external email. Please take care when clicking
>>> links or opening attachments. When in doubt, report the message using
>>> the 'Report this email' button
>>>
>>>
>>> On 14/02/2024 23:07, David Lin wrote:
>>>>> From: Francesco Dolcini <francesco@dolcini.it>
>>>>> Sent: Thursday, February 8, 2024 3:25 PM
>>>>> To: Rafael Beims <rafael@beims.me>
>>>>> Cc: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org;
>>>>> linux-kernel@vger.kernel.org; briannorris@chromium.org;
>>>>> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
>>>>> <tsung-hsien.hsieh@nxp.com>
>>>>> Subject: Re: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to
>>>>> support host mlme
>>>>>
>>>>> Caution: This is an external email. Please take care when clicking
>>>>> links or opening attachments. When in doubt, report the message
>>>>> using the 'Report this email' button
>>>>>
>>>>>
>>>>> On Wed, Feb 07, 2024 at 06:30:03PM -0300, Rafael Beims wrote:
>>>>>> On 30/01/2024 04:19, David Lin wrote:
>>>>>>>> From: Rafael Beims <rafael@beims.me> On 22/12/2023 00:21, David
>>>>>>>> Lin wrote:
>>>>>>>>> This series add host based MLME support to the mwifiex driver,
>>>>>>>>> this enables WPA3 support in both client and AP mode.
>>>>>>>>> To enable WPA3, a firmware with corresponding V2 Key API
>>>>>>>>> support is required.
>>>>>>>>> The feature is currently only enabled on NXP IW416 (SD8978),
>>>>>>>>> and it was internally validated by the NXP QA team. Other NXP
>>>>>>>>> Wi-Fi chips supported in current mwifiex are not affected by this
>> change.
>>>>> ...
>>>>>
>>>>>>>>> David Lin (2):
>>>>>>>>>       wifi: mwifiex: add host mlme for client mode
>>>>>>>>>       wifi: mwifiex: add host mlme for AP mode
>>>>> ...
>>>>>
>>>>>>>> I applied the two commits of this series on top of v6.7 but
>>>>>>>> unfortunately the AP is failing to start with the patches. I get
>>>>>>>> this output from "hostapd -d" (running on a Verdin AM62 with IW416):
>>>>>>>>
>>>>>>>> nl80211: kernel reports: Match already configured
>>>>>>>> nl80211: Register frame command failed (type=176): ret=-114
>>>>>>>> (Operation already in progress)
>>>>>>>> nl80211: Register frame match - hexdump(len=0): [NULL]
>>>>>>>>
>>>>>>>> If I run the same hostapd on v6.7 without the patches, the AP is
>>>>>>>> started with no issues.
>>>>>>>>
>>>>>>>> Is there anything else that should be done in order to test this?
>>>>>>>>
>>>>>>>>
>>>>>>> I applied patch v8 (mbox from patch work) to Linux stable
>>>>>>> repository (tag
>>>>> v6.7.2).
>>>>>>> Both client and AP mode can work with and without WPA3.
>>>>>>>
>>>>>> I went back and executed the tests again. I re-applied the pach on
>>>>>> top of tag v6.7.2 to make sure we're seeing exactly the same thing.
>>>>>>
>>>>>> At first, the behavior I was seeing was exactly the same I reported
>> before.
>>>>>> Upon starting hostapd with our basic example configuration, it
>>>>>> would fail to start the AP with the error:
>>>>>>
>>>>>> nl80211: kernel reports: Match already configured
>>>>>> nl80211: Could not configure driver mode
>>>>>>
>>>>>> After some investigation of what could cause this error, I found
>>>>>> out that it was connman that was interfering with this somehow.
>>>>>> After killing the connman service, the AP would start correctly.
>>>>>>
>>>>>> I want to point out that this behavior is different from the
>>>>>> unpatched driver. With that one we don't need to kill connman in
>>>>>> order to start the AP with hostapd.
>>>>> Any idea what's going on in this regard? Is such a change in
>>>>> behavior
>>> expected?
>>>>> Francesco
>>>> When I tried to test v6.7.2+ (with patch v8) on NB + SDIO IW416, it
>>>> needs to
>>> issue "sudo systemctl stop NetworkManager" in order to test AP mode.
>>>
>>> The issue I reported is that the kernel with the patch is behaving
>>> differently when compared to the kernel without the patch. I kept all
>>> the test conditions the same, just replacing the kernel. It seems that
>>> you can reproduce this on your end using NetworkManager.
>>>
>>> This is a change in behavior on userspace that's not currently explained.
>>>
>>>> For i.MX + SDIO IW416, it needs to install following two files for
>>>> client and
>>> AP mode to "/lib/systemd/network" for systemd-networkd:
>>>> <<Client mode: 80-wifi-station.network>>
>>>>
>>>> [Match]
>>>> Type=wlan
>>>> WLANInterfaceType=station
>>>>
>>>> [Network]
>>>> DHCP=yes
>>>>
>>>> <<AP mode: 80-wifi-ap.network>>
>>>>
>>>> [Match]
>>>> Type=wlan
>>>> WLANInterfaceType=ap
>>>>
>>>> [Network]
>>>> Address=192.168.100.1/24
>>>> DHCPServer=yes
>>>>
>>>> [DHCPServer]
>>>> PoolOffset=100
>>>> PoolSize=20
>>>>
>>>> I think this is not related to driver.
>>>>
>>>> David
>>> I didn't really understand what systemd-networkd has to do with
>>> anything being discussed here. We could use it to create an AP, but
>>> that's not the test I did. In my case I used hostapd directly.
>>>
>>>
>>> Rafael
>> I think the difference between previous driver is host mlme. Systemd-networkd
>> is only for address assignment, so it won't affect the test of AP mode. However,
>> Ubuntu Network Manager will affect AP mode test, so it needs to stop it before
>> running hostapd.
>>
>> David
> I found https://groups.google.com/g/beagleboard/c/3Um2Xqa2MHU to setup commman with hostapd. Can you give me your setting for commman? Thanks.
>
> David
>
Just to make it clear, we are *not* setting up the AP with connman. On 
our reference images we have a simple service that starts hostapd 
directly. We also have connman running by default and it's responsible 
for setting up the other interfaces (ethernet, wifi client).

In this setup, we previously were able to just start the hostapd service 
and the AP would start working. Now with the patch, connman seems to be 
doing something with the interface that causes the AP to fail starting.

For reference, this is the simple AP service we start:

[Unit]
Description=Hostapd IEEE 802.11 AP, IEEE 802.1X/WPA/WPA2/EAP/RADIUS 
Authenticator
Requires=enable-wifi.service

[Service]
Type=forking
PIDFile=/run/hostapd.pid
ExecStart=/usr/sbin/hostapd /etc/hostapd-tdx-demo-img.conf -P 
/run/hostapd.pid -B


[Install]
WantedBy=multi-user.target


If you want to replicate this behavior on your side, probably just 
building connman with yocto and adding it to your image is enough. After 
enabling connman to start at boot time, you can try to start hostapd 
manually.


Regards,

Rafael



