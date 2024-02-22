Return-Path: <linux-kernel+bounces-76289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B99F585F53F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06F47B25B28
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B5939861;
	Thu, 22 Feb 2024 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b="YscK8jwQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YlbyjpYY"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB93BB35;
	Thu, 22 Feb 2024 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708596310; cv=none; b=YBMAe7aHqbhFLGRITs92IEy3jWx3z3mksfPUTVmGpkeTRqe7b8b1iTUi2cXxT7K+iAzjB4qQoef9HoCgpZtWPTV96wMCzXVhumEgeKlRlsLCyeJaBZAu2qTD9S+nb1pZFftTe7kdNBCmq0zoHmzDE+diip7QRXUOtIU3ewFezrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708596310; c=relaxed/simple;
	bh=G4AOmBRKxS/WTqphDG8YVVDSIDuD3NBfSq2KaoveCrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dbwG0J+16L1EwQDAMYakte00iyuM6d66gIJv3U0duKy1mN/xZjbTa1tRbhw5qnTuLUi2gu9IwVqoSW2qZrGtgQLDXbTC0nUlFM/H/QH3jU+f9G8sBhNUKQlT3Ryk5v61a+nEpCg4GYn11aZLC/tS6IhAXw9kKa/vL1+xwrpwVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me; spf=pass smtp.mailfrom=beims.me; dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b=YscK8jwQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YlbyjpYY; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beims.me
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 2D1555C0096;
	Thu, 22 Feb 2024 05:04:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 22 Feb 2024 05:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1708596291;
	 x=1708682691; bh=a6Bu4H5OwhICFP+Cg3GexMiu885sGO/mY8lKauWqlL0=; b=
	YscK8jwQWgPI5Nal57A19elHqnKbAKJT4GaSVeYndzt+9PfaaHwRNjRfW3719eSb
	CgyXsuMCXbkkPVoLIbgmerbi7uXcvUAXirJGMRS2X57+FSJKD1vK/QkO6Cncf2z8
	+vUw1ZZtU6ALSknxAJFd/2ciBNpQld2IaGVRV3c5lbrqluNnUZFbkL9dtKwAEyLs
	Pe6DBAyQyF2XQJ8VKK8CD19+YZaaUNqeKQ68VCxysoSRfsg15XTuhVVKsc2m7TM1
	OQ9/IjLalydqUr1gJQjtV8pN1wZg8tRMphxCsfTvxRQ+KB/DQruwj2dQpDosYWOV
	5LdgEm+fkh3Opmubpz9PoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1708596291; x=
	1708682691; bh=a6Bu4H5OwhICFP+Cg3GexMiu885sGO/mY8lKauWqlL0=; b=Y
	lbyjpYYnMWsgH1sZ1tmC5DDw2FT1l/x+uAdk8gZG6cFUKOzSh396BUMOC2kkr5Rl
	SrzjLTwxUFaMEXiJ/F/MGcwKyfRv0VjNpEUV75x09L64yGxNuq2IZIdnvLDVDns1
	hN9XeUxn/iLcNuiKXBKqMixUl/SuGaZqSTP8CzktZaujpklXASbxtEKIZcp9CDKc
	c9YzEiBFjNmYg9pHBT+dBFCtbltC5DGyQNKoejPHPeD3xSPwAllaESCDJkDSKdjv
	CAFRAvcvJMLJV7GRsLNarLU/+fDkFO3uHVCH5z7Q71Vs6PWVLdN/UuHkmMft1jJD
	Nz4sKVP5rADVcofIhKx5w==
X-ME-Sender: <xms:QhzXZQ_URyVK4W4w9miyHEstehRVfSHZ1Ql27c11lxKCqxcemVeysg>
    <xme:QhzXZYvg5C9apt8Kihfp1baU9PrRZAwUFVyNbfTl6mdAszQRw8JRcNjA62ZxVkXYP
    uyHydcPI3cJ-9O4i2E>
X-ME-Received: <xmr:QhzXZWDVtId1JJEZ-jC4Dg1pznF_B01qqxxhyesLrAFqXfrUJhWzlnoeT7zntN45lSk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeggddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefkffggfgfuvfevfhfhjggt
    gfesthejredttddvjeenucfhrhhomheptfgrfhgrvghluceuvghimhhsuceorhgrfhgrvg
    hlsegsvghimhhsrdhmvgeqnecuggftrfgrthhtvghrnhepffeuveegueffvdegffekveel
    tdejteeiheefuddugfffiedtffevveetfeekvdfgnecuffhomhgrihhnpehgohhoghhlvg
    drtghomhdpthhorhgruggvgidrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehrrghfrggvlhessggvihhmshdrmhgv
X-ME-Proxy: <xmx:QhzXZQeGFnnqPKGI3LtQlaauXIIbTSrDIwYxGJy_NfyU4Ls7aylwJg>
    <xmx:QhzXZVMfuafITJ963naaLarwswaXHeI5zjJnXbKMvq7KN9qd89UQdw>
    <xmx:QhzXZamEYRfTpmOKS0FHahfDRjMLESEEEuLN3kSxaJCfngRlYyzjqg>
    <xmx:QxzXZY3IVE1YddtwSN_cHbVMQ2BMIsN5X7qFA8x7YYEIAiuBumEyPw>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 05:04:49 -0500 (EST)
Message-ID: <c6c1f096-ffe1-4ecd-885c-d50934380752@beims.me>
Date: Thu, 22 Feb 2024 07:04:46 -0300
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
 <3d1c45bd-fb89-4a4c-8f53-b1775f6c9a3e@beims.me>
 <PA4PR04MB9638007CEECACA73A6F13BCED1562@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Rafael Beims <rafael@beims.me>
In-Reply-To: <PA4PR04MB9638007CEECACA73A6F13BCED1562@PA4PR04MB9638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/02/2024 05:01, David Lin wrote:
>> From: Rafael Beims <rafael@beims.me>
>> Sent: Friday, February 16, 2024 6:11 PM
>> To: David Lin <yu-hao.lin@nxp.com>; Francesco Dolcini <francesco@dolcini.it>
>> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
>> briannorris@chromium.org; kvalo@kernel.org; Pete Hsieh
>> <tsung-hsien.hsieh@nxp.com>
>> Subject: Re: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host
>> mlme
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On 15/02/2024 22:48, David Lin wrote:
>>>> From: David Lin
>>>> Sent: Friday, February 16, 2024 9:41 AM
>>>> To: Rafael Beims <rafael@beims.me>; Francesco Dolcini
>>>> <francesco@dolcini.it>
>>>> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>> briannorris@chromium.org; kvalo@kernel.org; Pete Hsieh
>>>> <tsung-hsien.hsieh@nxp.com>
>>>> Subject: RE: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to
>>>> support host mlme
>>>>
>>>>> From: Rafael Beims <rafael@beims.me>
>>>>> Sent: Thursday, February 15, 2024 8:11 PM
>>>>> To: David Lin <yu-hao.lin@nxp.com>; Francesco Dolcini
>>>>> <francesco@dolcini.it>
>>>>> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>>> briannorris@chromium.org; kvalo@kernel.org; Pete Hsieh
>>>>> <tsung-hsien.hsieh@nxp.com>
>>>>> Subject: Re: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to
>>>>> support host mlme
>>>>>
>>>>> Caution: This is an external email. Please take care when clicking
>>>>> links or opening attachments. When in doubt, report the message
>>>>> using the 'Report this email' button
>>>>>
>>>>>
>>>>> On 14/02/2024 23:07, David Lin wrote:
>>>>>>> From: Francesco Dolcini <francesco@dolcini.it>
>>>>>>> Sent: Thursday, February 8, 2024 3:25 PM
>>>>>>> To: Rafael Beims <rafael@beims.me>
>>>>>>> Cc: David Lin <yu-hao.lin@nxp.com>;
>>>>>>> linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org;
>>>>>>> briannorris@chromium.org; kvalo@kernel.org; francesco@dolcini.it;
>>>>>>> Pete Hsieh <tsung-hsien.hsieh@nxp.com>
>>>>>>> Subject: Re: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to
>>>>>>> support host mlme
>>>>>>>
>>>>>>> Caution: This is an external email. Please take care when clicking
>>>>>>> links or opening attachments. When in doubt, report the message
>>>>>>> using the 'Report this email' button
>>>>>>>
>>>>>>>
>>>>>>> On Wed, Feb 07, 2024 at 06:30:03PM -0300, Rafael Beims wrote:
>>>>>>>> On 30/01/2024 04:19, David Lin wrote:
>>>>>>>>>> From: Rafael Beims <rafael@beims.me> On 22/12/2023 00:21,
>> David
>>>>>>>>>> Lin wrote:
>>>>>>>>>>> This series add host based MLME support to the mwifiex driver,
>>>>>>>>>>> this enables WPA3 support in both client and AP mode.
>>>>>>>>>>> To enable WPA3, a firmware with corresponding V2 Key API
>>>>>>>>>>> support is required.
>>>>>>>>>>> The feature is currently only enabled on NXP IW416 (SD8978),
>>>>>>>>>>> and it was internally validated by the NXP QA team. Other NXP
>>>>>>>>>>> Wi-Fi chips supported in current mwifiex are not affected by
>>>>>>>>>>> this
>>>> change.
>>>>>>> ...
>>>>>>>
>>>>>>>>>>> David Lin (2):
>>>>>>>>>>>        wifi: mwifiex: add host mlme for client mode
>>>>>>>>>>>        wifi: mwifiex: add host mlme for AP mode
>>>>>>> ...
>>>>>>>
>>>>>>>>>> I applied the two commits of this series on top of v6.7 but
>>>>>>>>>> unfortunately the AP is failing to start with the patches. I
>>>>>>>>>> get this output from "hostapd -d" (running on a Verdin AM62 with
>> IW416):
>>>>>>>>>> nl80211: kernel reports: Match already configured
>>>>>>>>>> nl80211: Register frame command failed (type=176): ret=-114
>>>>>>>>>> (Operation already in progress)
>>>>>>>>>> nl80211: Register frame match - hexdump(len=0): [NULL]
>>>>>>>>>>
>>>>>>>>>> If I run the same hostapd on v6.7 without the patches, the AP
>>>>>>>>>> is started with no issues.
>>>>>>>>>>
>>>>>>>>>> Is there anything else that should be done in order to test this?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>> I applied patch v8 (mbox from patch work) to Linux stable
>>>>>>>>> repository (tag
>>>>>>> v6.7.2).
>>>>>>>>> Both client and AP mode can work with and without WPA3.
>>>>>>>>>
>>>>>>>> I went back and executed the tests again. I re-applied the pach
>>>>>>>> on top of tag v6.7.2 to make sure we're seeing exactly the same thing.
>>>>>>>>
>>>>>>>> At first, the behavior I was seeing was exactly the same I
>>>>>>>> reported
>>>> before.
>>>>>>>> Upon starting hostapd with our basic example configuration, it
>>>>>>>> would fail to start the AP with the error:
>>>>>>>>
>>>>>>>> nl80211: kernel reports: Match already configured
>>>>>>>> nl80211: Could not configure driver mode
>>>>>>>>
>>>>>>>> After some investigation of what could cause this error, I found
>>>>>>>> out that it was connman that was interfering with this somehow.
>>>>>>>> After killing the connman service, the AP would start correctly.
>>>>>>>>
>>>>>>>> I want to point out that this behavior is different from the
>>>>>>>> unpatched driver. With that one we don't need to kill connman in
>>>>>>>> order to start the AP with hostapd.
>>>>>>> Any idea what's going on in this regard? Is such a change in
>>>>>>> behavior
>>>>> expected?
>>>>>>> Francesco
>>>>>> When I tried to test v6.7.2+ (with patch v8) on NB + SDIO IW416, it
>>>>>> needs to
>>>>> issue "sudo systemctl stop NetworkManager" in order to test AP mode.
>>>>>
>>>>> The issue I reported is that the kernel with the patch is behaving
>>>>> differently when compared to the kernel without the patch. I kept
>>>>> all the test conditions the same, just replacing the kernel. It
>>>>> seems that you can reproduce this on your end using NetworkManager.
>>>>>
>>>>> This is a change in behavior on userspace that's not currently explained.
>>>>>
>>>>>> For i.MX + SDIO IW416, it needs to install following two files for
>>>>>> client and
>>>>> AP mode to "/lib/systemd/network" for systemd-networkd:
>>>>>> <<Client mode: 80-wifi-station.network>>
>>>>>>
>>>>>> [Match]
>>>>>> Type=wlan
>>>>>> WLANInterfaceType=station
>>>>>>
>>>>>> [Network]
>>>>>> DHCP=yes
>>>>>>
>>>>>> <<AP mode: 80-wifi-ap.network>>
>>>>>>
>>>>>> [Match]
>>>>>> Type=wlan
>>>>>> WLANInterfaceType=ap
>>>>>>
>>>>>> [Network]
>>>>>> Address=192.168.100.1/24
>>>>>> DHCPServer=yes
>>>>>>
>>>>>> [DHCPServer]
>>>>>> PoolOffset=100
>>>>>> PoolSize=20
>>>>>>
>>>>>> I think this is not related to driver.
>>>>>>
>>>>>> David
>>>>> I didn't really understand what systemd-networkd has to do with
>>>>> anything being discussed here. We could use it to create an AP, but
>>>>> that's not the test I did. In my case I used hostapd directly.
>>>>>
>>>>>
>>>>> Rafael
>>>> I think the difference between previous driver is host mlme.
>>>> Systemd-networkd is only for address assignment, so it won't affect
>>>> the test of AP mode. However, Ubuntu Network Manager will affect AP
>>>> mode test, so it needs to stop it before running hostapd.
>>>>
>>>> David
>>> I found
>> https://groups.go/
>> ogle.com%2Fg%2Fbeagleboard%2Fc%2F3Um2Xqa2MHU&data=05%7C02%7Cy
>> u-hao.lin%40nxp.com%7C4c74f7c309e243eb6c0c08dc2ed78b4c%7C686ea1d3
>> bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638436750492293425%7CUnknow
>> n%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
>> wiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=99eQWmm39kbo63JKNFbiljFQz
>> o%2Bz7ki%2FSsllw%2FdonbE%3D&reserved=0 to setup commman with
>> hostapd. Can you give me your setting for commman? Thanks.
>>> David
>>>
>> Just to make it clear, we are *not* setting up the AP with connman. On our
>> reference images we have a simple service that starts hostapd directly. We also
>> have connman running by default and it's responsible for setting up the other
>> interfaces (ethernet, wifi client).
>>
>> In this setup, we previously were able to just start the hostapd service and the
>> AP would start working. Now with the patch, connman seems to be doing
>> something with the interface that causes the AP to fail starting.
>>
>> For reference, this is the simple AP service we start:
>>
>> [Unit]
>> Description=Hostapd IEEE 802.11 AP, IEEE 802.1X/WPA/WPA2/EAP/RADIUS
>> Authenticator Requires=enable-wifi.service
>>
>> [Service]
>> Type=forking
>> PIDFile=/run/hostapd.pid
>> ExecStart=/usr/sbin/hostapd /etc/hostapd-tdx-demo-img.conf -P
>> /run/hostapd.pid -B
>>
>>
>> [Install]
>> WantedBy=multi-user.target
>>
>>
>> If you want to replicate this behavior on your side, probably just building
>> connman with yocto and adding it to your image is enough. After enabling
>> connman to start at boot time, you can try to start hostapd manually.
>>
>>
>> Regards,
>>
>> Rafael
>>
> 1. Without host mlme, management packet filter of AP mode is the same as client mode. Authentication/Association packets are handled by firmware and once if station is connected, firmware will send station connection event to driver. So you can still start wpa_supplicant and hostapd on uap0 at same time. However, this is not correct setting and usage.
>
> 2. With host mlme, management packet filter of AP mode is not the same as client mode. Authentication/Association packets are sent to hostapd, so cfg80211 won't allow wpa_supplicant and hostapd run on uap0 at same time (different management packet filter).
>
> I think no matter with or without patch v8, setting of connman for uap0 should not be client mode. Setting of connman for uap0 should be ap mode or bypass to control it as client mode.
>
> The behavior of patch v8 is correct and it can avoid user to run wpa_supplicant and hostapd on AP wireless interface at same time. There is no side effect of patch v8 for this behavior.
>
> I also found document from Toradex about how to run connman for AP mode:
>
> https://developer.toradex.com/linux-bsp/application-development/networking-connectivity/how-to-setup-wi-fi-access-point-mode-linux/
>
> Please check section 8:
>
> Enable and start hostapd service:
> First, make sure to blacklist the uap0 interface on connmanctl by adding it to NetworkInterfaceBlacklist at connman/main.conf.
>
> I think to block uap0 from connman is correct way to run hostapd on uap0.
>
> David
>
That explains the difference in behavior, thank you!


Tested-by: <rafael.beims@toradex.com> #Verdin AM62 IW416 SD


Rafael


