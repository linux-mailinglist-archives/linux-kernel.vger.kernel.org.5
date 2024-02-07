Return-Path: <linux-kernel+bounces-57231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6C284D560
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BEEA1C2579C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6E312AAC6;
	Wed,  7 Feb 2024 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b="T72Bcz8g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvrIiZoW"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64F5823B8;
	Wed,  7 Feb 2024 21:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341413; cv=none; b=dJGTj30RDf7BmzYxkI9EPhxSDssXzmzWkBuKDQRjvYldxDWE2BGhMk2Y5cydHZh+mE4rTSL+sLPJQ8hzov6bjLV9UdittUpE6mMVnxKqolZNPIGks+iG0frwT2qZnfwlgxiBNIZ0IgWR+sqPDFsVHeeehBe1BFRTKfixa8U9J9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341413; c=relaxed/simple;
	bh=g0gLIVsTVlzEVgXEZE5VyWYUAXSY6iiynaTgHHjaG2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mdZZ0x6sZ6m98ZbnDHbzj0I8/ct8jEGT5DYLc4QKnVzM9z290RaAVqZful4K8HqhlJFMoruheBeykl5oyPEF2Avr6lqqjA+83dvb0/s5GLRB3BSUMSco/j5VSLiXdoXxoFB/8nXjWwwf1jBAnH6swPF3zY6olIhfuy9loURAFa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me; spf=pass smtp.mailfrom=beims.me; dkim=pass (2048-bit key) header.d=beims.me header.i=@beims.me header.b=T72Bcz8g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZvrIiZoW; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=beims.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=beims.me
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 9EF555C00C6;
	Wed,  7 Feb 2024 16:30:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 07 Feb 2024 16:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=beims.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1707341408;
	 x=1707427808; bh=Vilm1ec4KJ+cVj/DgCBF0t8G880tQw9jQT+O9WGH1A0=; b=
	T72Bcz8gyrFrOLWjwX11/7ujKoPMWZQvm2oyQ/7El/MmrBVn8sodwkYXlUg5KU02
	bs6zMbLuiTWy3LRQ3Gjl2xALYSK/REGtqbZMY96endXINadRuliXIjKHrtH1whhn
	58QgxHHfKqZQIer8e2K9pq0go4erqAYhGTzGoR42E5/fVUIGcM9pRe9Xuj8MpZtW
	Iy2Yi+Mj9XR7htpZxnlE30+VzolEKNwUaYUkwXmX6g/Jgjhx3mYA2fxPObjb2jSH
	zOa2buUnr2LZ6WF2oW6+cY04ZNeHDiDuq+Y3hGUaG2xz5Fa9LBDh4UbSJJfSj4vx
	A5Na8jZfocv1FhByzhBKfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707341408; x=
	1707427808; bh=Vilm1ec4KJ+cVj/DgCBF0t8G880tQw9jQT+O9WGH1A0=; b=Z
	vrIiZoWEyRe4Ac3TP+/yEzsdIdC9IxSmc1I+EtMixQKv5o7chm6NQv3yQmsS/z4J
	csb7UJB626+AeBcg5FaSJxqc4d7Fw9qDVpKb7aq6w/ite0IBRqM1K0g5ek2QG4TL
	Ep/Slge7Ws/DxLmt1ppaFtxata6sC+XlkRQYcYZVg7nmv5av3JLGZS+cYddTQ2oW
	jo5HkBOmlg1fIVUsMUXYSBk88bfZj4D2KeFDfFnRfPs6OvxYb9InnxcM4XLP15W7
	Zhq9LOoSAOxMEzcj7cQI+sCRH8X+3YFMm7Csxg/ErxXN7RJg0zlv7bbREt5jkCD7
	cH7qetKzzAzmhL9TvGLpQ==
X-ME-Sender: <xms:X_bDZdjOGTxUoAD5EA0fRE_MSljYhIG-U1qv0w8iKD_LS5ijXQEzGA>
    <xme:X_bDZSA-6Q0puZq7ifhZ5Jii_rBAZhA9WOwGUepK3Y5cWKhTBD1z-hvSBqVyZ12hU
    yRASjy7MsCZ7pYI6bM>
X-ME-Received: <xmr:X_bDZdGLAHcKyid5Tu4S6jmlOnnWryEt1RkezthHFXAFZLeDzs1DCT394g2fBb_zzK0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddvgddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeftrghf
    rggvlhcuuegvihhmshcuoehrrghfrggvlhessggvihhmshdrmhgvqeenucggtffrrghtth
    gvrhhnpedutdfgjeeitddtkedthffhvdevteefgedutdefhfelueeiledviefhffefudel
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrg
    hfrggvlhessggvihhmshdrmhgv
X-ME-Proxy: <xmx:X_bDZSS6aJD8xMKyYbLHmonu3gaZ1iO5OvT4oMfQJGfuVq3mKejQGA>
    <xmx:X_bDZaxdR6G_xp2aKWsdpRrLjvLDGDXlX64lQr2IWQp95aU2Qx3lzA>
    <xmx:X_bDZY4GAs0bdP6G7sEnRZSo0DwEA1RKDHZH5lrkFtQHLH73dU0mFg>
    <xmx:YPbDZRpSwEy17DkhVBWO5kOPxFNQB8h1ONQeafpOgj_YBfLvsrKRsg>
Feedback-ID: idc214666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Feb 2024 16:30:06 -0500 (EST)
Message-ID: <48364f66-99b4-40ca-b4b2-4adf1071960f@beims.me>
Date: Wed, 7 Feb 2024 18:30:03 -0300
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
To: David Lin <yu-hao.lin@nxp.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "briannorris@chromium.org" <briannorris@chromium.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 "francesco@dolcini.it" <francesco@dolcini.it>,
 Pete Hsieh <tsung-hsien.hsieh@nxp.com>
References: <20231222032123.1036277-1-yu-hao.lin@nxp.com>
 <97bb3869-3b82-4b64-87cd-9b63d4516649@beims.me>
 <PA4PR04MB96389A5DDB41DFF80CBB4738D17D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
From: Rafael Beims <rafael@beims.me>
In-Reply-To: <PA4PR04MB96389A5DDB41DFF80CBB4738D17D2@PA4PR04MB9638.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/01/2024 04:19, David Lin wrote:
>> From: Rafael Beims <rafael@beims.me>
>> Sent: Friday, January 19, 2024 1:09 AM
>> To: David Lin <yu-hao.lin@nxp.com>; linux-wireless@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; briannorris@chromium.org;
>> kvalo@kernel.org; francesco@dolcini.it; Pete Hsieh
>> <tsung-hsien.hsieh@nxp.com>
>> Subject: [EXT] Re: [PATCH v8 0/2] wifi: mwifiex: add code to support host mlme
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On 22/12/2023 00:21, David Lin wrote:
>>
>>> This series add host based MLME support to the mwifiex driver, this
>>> enables WPA3 support in both client and AP mode.
>>> To enable WPA3, a firmware with corresponding V2 Key API support is
>>> required.
>>> The feature is currently only enabled on NXP IW416 (SD8978), and it
>>> was internally validated by the NXP QA team. Other NXP Wi-Fi chips
>>> supported in current mwifiex are not affected by this change.
>>>
>>> v8:
>>>      - Separate 6/12 from patch v7.
>>>        As it's a bug fix not part of host MLME feature.
>>>      - Rearrnage MLME feature into 2 patches:
>>>        a. Add host based MLME support for STA mode.
>>>        b. Add host based MLME support for AP mode.
>>>
>>> v7:
>>>      - Fix regression: Downlink throughput degraded by 70% in AP mode.
>>>      - Fix issue: On STAUT, kernel Oops occurs when there is no association
>>>        response from AP.
>>>      - Fix issue: On STAUT, if AP leaves abruptly and deauth is missing,
>>>        STA can't connect to AP anymore.
>>>      - Fix regression: STA can't connect to AP when host_mlme is disabled
>>>        (impact all chips).
>>>      - Address reviewer comments.
>>>
>>> v6:
>>>      - Correct mailing sequence.
>>>
>>> v5:
>>>      - Add host base MLME support to enable WPA3 functionalities for both
>>>        STA and AP mode.
>>>      - This feature (WPA3) required a firmware with corresponding Key API
>> V2
>>>        support.
>>>      - QA validation and regression have been covered for IW416.
>>>      - This feature (WPA3) is currently enabled and verified only for IW416.
>>>      - Changelogs since patch V4:
>>>        a. Add WPA3 support for AP mode.
>>>        b. Bug fix: In WPA3 STA mode, deice gets disconnected from AP
>>>           when group rekey occurs.
>>>        c. Bug fix: STAUT doesn't send WMM IE in association request when
>>>           associate to a WMM-AP.
>>>
>>> v4:
>>>      - Refine code segment per review comment.
>>>      - Add API to check firmware encryption key command version when
>>>        host_mlme is enabled.
>>>
>>> v3:
>>>      - Cleanup commit message.
>>>
>>> v2:
>>>      - Fix checkpatch error (pwe[1] -> pwe[0]).
>>>      - Move module parameter 'host_mlme' to mwifiex_sdio_device
>> structure.
>>>        Default only enable for IW416.
>>>      - Disable advertising NL80211_FEATURE_SAE if host_mlme is not
>> enabled.
>>> David Lin (2):
>>>     wifi: mwifiex: add host mlme for client mode
>>>     wifi: mwifiex: add host mlme for AP mode
>>>
>>>    .../net/wireless/marvell/mwifiex/cfg80211.c   | 394
>> +++++++++++++++++-
>>>    drivers/net/wireless/marvell/mwifiex/cmdevt.c |  27 ++
>>>    drivers/net/wireless/marvell/mwifiex/decl.h   |  22 +
>>>    drivers/net/wireless/marvell/mwifiex/fw.h     |  54 +++
>>>    drivers/net/wireless/marvell/mwifiex/init.c   |   6 +
>>>    drivers/net/wireless/marvell/mwifiex/ioctl.h  |   5 +
>>>    drivers/net/wireless/marvell/mwifiex/join.c   |  66 ++-
>>>    drivers/net/wireless/marvell/mwifiex/main.c   |  54 +++
>>>    drivers/net/wireless/marvell/mwifiex/main.h   |  17 +
>>>    drivers/net/wireless/marvell/mwifiex/scan.c   |   6 +
>>>    drivers/net/wireless/marvell/mwifiex/sdio.c   |  13 +
>>>    drivers/net/wireless/marvell/mwifiex/sdio.h   |   2 +
>>>    .../wireless/marvell/mwifiex/sta_cmdresp.c    |   2 +
>>>    .../net/wireless/marvell/mwifiex/sta_event.c  |  36 +-
>>>    .../net/wireless/marvell/mwifiex/sta_ioctl.c  |   3 +-
>>>    drivers/net/wireless/marvell/mwifiex/sta_tx.c |   9 +-
>>>    .../net/wireless/marvell/mwifiex/uap_cmd.c    | 171 ++++++++
>>>    drivers/net/wireless/marvell/mwifiex/util.c   | 104 +++++
>>>    18 files changed, 974 insertions(+), 17 deletions(-)
>>>
>>>
>>> base-commit: 783004b6dbda2cfe9a552a4cc9c1d168a2068f6c
>> I applied the two commits of this series on top of v6.7 but unfortunately the AP
>> is failing to start with the patches. I get this output from "hostapd -d" (running
>> on a Verdin AM62 with IW416):
>>
>> nl80211: kernel reports: Match already configured
>> nl80211: Register frame command failed (type=176): ret=-114 (Operation
>> already in progress)
>> nl80211: Register frame match - hexdump(len=0): [NULL]
>>
>> If I run the same hostapd on v6.7 without the patches, the AP is started with no
>> issues.
>>
>>
>> Is there anything else that should be done in order to test this?
>>
>>
>> Rafael
> I applied patch v8 (mbox from patch work) to Linux stable repository (tag v6.7.2).
>
> Both client and AP mode can work with and without WPA3.
>
> David
>
I went back and executed the tests again. I re-applied the pach on top 
of tag v6.7.2 to make sure we're seeing exactly the same thing.

At first, the behavior I was seeing was exactly the same I reported 
before. Upon starting hostapd with our basic example configuration, it 
would fail to start the AP with the error:

nl80211: kernel reports: Match already configured
nl80211: Could not configure driver mode

After some investigation of what could cause this error, I found out 
that it was connman that was interfering with this somehow. After 
killing the connman service, the AP would start correctly.

I want to point out that this behavior is different from the unpatched 
driver. With that one we don't need to kill connman in order to start 
the AP with hostapd.


After seeing the AP starting up, I did a quick series of tests (Toradex 
Verdin AM62 with 1GB of RAM and two antennas connected via SMA adapter):

1) AP test: I was able to use the simple AP configuration with two 
clients connected simultaneously. I executed simple ping tests and also 
a quick run of iperf3 with the following results

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  16.8 MBytes  14.1 Mbits/sec 11             sender
[  5]   0.00-10.05  sec  16.4 MBytes  13.7 Mbits/sec                  
receiver

I repeated the same iperf3 test several times with similar results.

Comparing the iperf3 results with what I get on the unpatched driver 
(v6.7.2), there seems to be a difference in average bandwidth:

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  20.2 MBytes  17.0 Mbits/sec 0             sender
[  5]   0.00-10.04  sec  19.7 MBytes  16.4 Mbits/sec                  
receiver


2) Client test: I also executed a similar test but now with the AM62 as 
the client. It was possible to connect to an AP and do the ping tests 
without problems.

The iperf3 results are in line with what we see on the AP:

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  19.3 MBytes  16.2 Mbits/sec 32             sender
[  5]   0.00-10.01  sec  19.0 MBytes  15.9 Mbits/sec                  
receiver

Comparing with the unpatched v6.7.2 we can also see a difference:

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  23.4 MBytes  19.6 Mbits/sec 0             sender
[  5]   0.00-10.01  sec  20.7 MBytes  17.3 Mbits/sec                  
receiver


3) Simple WPA3 AP test: to finish this round of tests, I started an AP 
with a configuration enabling SAE. The AP was started successfully and I 
could connect a client with wpa_supplicant. Ping tests were also 
succesful here.

The iperf3 result shows a bigger bandwidth than all the previous tests:

[ ID] Interval           Transfer     Bitrate         Retr
[  5]   0.00-10.00  sec  20.6 MBytes  17.3 Mbits/sec 35             sender
[  5]   0.00-10.04  sec  19.8 MBytes  16.6 Mbits/sec                  
receiver


To summarize the results, it seems that the basic functionality is 
working and also WPA3 support.

We have a different behavior when starting the AP, where now we need to 
stop connman (blacklisting the uap0 interface will probably also work) 
beforehand.

I don't know if the bandwidth results are something to be worried about, 
I saw some variation between iperf3 runs, but the results I posted show 
an average of what I was seeing.


Rafael


