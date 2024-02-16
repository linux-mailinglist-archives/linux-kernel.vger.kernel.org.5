Return-Path: <linux-kernel+bounces-68771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D68857FE1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A07B1C22823
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3DC12F370;
	Fri, 16 Feb 2024 14:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="S3H2/R8G"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C0312C7FB
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708095486; cv=none; b=pRlkuZSScMNStZigdAwULyxN1NYEZfz9VkWEEKEFJ5k/gJz0y48m4jZEbendsloZM8zEhr71ONOKHxchHl6T1gUDfsxFf/YDM+CKZcr5Wm6GiizUL+s0dBxNYXsdpPxK0dbs9dvSCIvHplZ+XWgX9MCok9RvQgvCQ55UFKEFGLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708095486; c=relaxed/simple;
	bh=iUbtcZIktnPBX01vvnY17Z/26Ffxt6Vt5I+EALt3LMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYRPXhGDvWgjgU/84YiZlGFbch3CF6tB2CFWf2alI8HJ2V1BDCcjVaS1UVJ2tHlsBWwmDRtpHil0kgSvqsS0vTFULaiKXhVzgRzlNkB7e2ScorUKk7HY/SUvaXYoUEVSZFDyUccNp+UHr8vfmV7qrN6MyW2QRGLmYR4CBSILi/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=S3H2/R8G; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id BA05087E28;
	Fri, 16 Feb 2024 15:57:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708095482;
	bh=X3NbXL/gGHd/P6iqK+xeE/pRyvyOvGn9pk40pfqJSe8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=S3H2/R8GcAq1+/JXttv9uuc1Q8rCYjVr7aJWZ1L5G/m7LupsNCEMGBA1XGXvWuyvV
	 Ol4UaoIrAo/slESxhd5vktlCDMaeZ122eTo/DXFkfw/h3OHfRHX9qhkn3RT4YjVhGG
	 otrbJhdDl8LuYwJ/9niJdjioT8lVennzJBXlC5M8c6u/kMd3DuWBfrTD3Fggf26sqh
	 MFGFaJdvSMPzu89BZBXPA+YCQF2QVTFQLW61QROaTgysg43qSQv6pO0rrICl29h4Dg
	 fsq8jRbdMRkX8c4y4ME7Z+FMbsD0XPOMsn5D1SXNu501QW5PIXRnIkaRwBOFebzwVU
	 WrdzX4vbpyKWA==
Message-ID: <bc96c6b5-a7f8-4ef3-a89b-bf577943f11c@denx.de>
Date: Fri, 16 Feb 2024 15:57:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] drm/bridge: tc358767: Fix
 DRM_BRIDGE_ATTACH_NO_CONNECTOR case
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
 Jan Kiszka <jan.kiszka@siemens.com>
Cc: linux-kernel@vger.kernel.org
References: <20231108-tc358767-v2-0-25c5f70a2159@ideasonboard.com>
 <f6af46e0-aadb-450a-9349-eec1337ea870@ti.com>
 <2f3bb86b-6f8c-4807-985e-344a0c47864c@siemens.com>
 <3277848.aeNJFYEL58@steina-w>
 <b2052bc9-b2da-489b-9e5b-3c9b4f6c1c99@ideasonboard.com>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <b2052bc9-b2da-489b-9e5b-3c9b4f6c1c99@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 2/16/24 10:10, Tomi Valkeinen wrote:
> On 15/02/2024 11:03, Alexander Stein wrote:
>> Hi everyone,
>>
>> Am Donnerstag, 15. Februar 2024, 09:53:54 CET schrieb Jan Kiszka:
>>> On 11.12.23 09:07, Aradhya Bhatia wrote:
>>>> On 06/12/23 17:41, Tomi Valkeinen wrote:
>>>>> Hi,
>>>>>
>>>>> On 08/11/2023 14:45, Alexander Stein wrote:
>>>>>> Hi Tomi,
>>>>>>
>>>>>> Am Mittwoch, 8. November 2023, 12:27:21 CET schrieb Tomi Valkeinen:
>>>>>>> These two patches are needed to make tc358767 work in the
>>>>>>> DRM_BRIDGE_ATTACH_NO_CONNECTOR case, at least when using a DP
>>>>>>> connector.
>>>>>>>
>>>>>>> I have tested this with TI AM654 EVM with a tc358767 add-on card
>>>>>>> connected to a DP monitor.
>>>>>>
>>>>>> Just a question regarding the usage of this DSI-DP bridge.
>>>>>> What is the state of the DSI lanes after the DSI host has been
>>>>>> initialized,
>>>>>> but before calling atomic_pre_enable? AFAIK this bridge requires 
>>>>>> LP-11
>>>>>> on DSI
>>>>>> at any time for accessing the AUX channel.
>>>>
>>>> + Marek
>>>>
>>>> Marek, Alexander,
>>>>
>>>> A quick grep tells me that you have added devicetree for tc358767 in 
>>>> DSI
>>>> to (e)DP mode on other platforms. Could you please test these patches
>>>> and report if you find any issue?
>>
>> Sorry, I can't provide any feedback here. I've yet to setup the DSI-DP
>> correctly.
> 
> Ok. Does anyone have a worry that these patches make the situation worse 
> for the DSI case than it was before? Afaics, if the DSI lanes are not 
> set up early enough by the DSI host, the driver would break with and 
> without these patches.
> 
> These do fix the driver for DRM_BRIDGE_ATTACH_NO_CONNECTOR and DPI, so 
> I'd like to merge these unless these cause a regression with the DSI case.

1/2 looks good to me, go ahead and apply .

