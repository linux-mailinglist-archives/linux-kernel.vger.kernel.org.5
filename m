Return-Path: <linux-kernel+bounces-164856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C24AC8B8405
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01772B22B7B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9C7C12C;
	Wed,  1 May 2024 01:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="MDX0TdgU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="flmLz+du"
Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127656FCC;
	Wed,  1 May 2024 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714527770; cv=none; b=FV8zINvuN3xdZ5k0ODGAOFX+CpfcOhLQJheWqDLEaE3zN7IWMcXeGmEZ04fzoGqVzBT6qhBPmm4UD9S8XlO8TjIcqsjTrPe93lYJGVkmirZmF1nDAAjHPMFnrw+z647pwd43R6x9hs7iqn+c3BT3D5t3eOYqRFbMN25nF7kcIlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714527770; c=relaxed/simple;
	bh=s+K42gZIABEUE/N88ONB7Yon6cOf8NQnhlQxz3/MGhg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=qm5WzKBHHItNUJFb/3uKmB+Dkt9s2suGLDo4crOT+UbERQQDvUown9hQBc6i8pm4mGddL2VdWw1xOIzY5b3nrKfO1guoIZEJUptn8Io2wAoJ2gRBHVdUkq988mI1ZiQNAkodpMT3LCp1O+gg9VuVfC1O3bUsR1K7XiRcELnvO0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=MDX0TdgU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=flmLz+du; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 158C31380140;
	Tue, 30 Apr 2024 21:42:48 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Tue, 30 Apr 2024 21:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1714527768;
	 x=1714614168; bh=UI8eVskdm/0fVqSqYYlThaWLGBVwXSK9e2mLaByBoGU=; b=
	MDX0TdgUUsrAMX8symQpT8Cw5eEIerQ+7vxrHie7tLYorwQh6v3lDk8DQyhuoZjS
	bQJmzsRLppJDx93gsMfckp5sUc31AoQ/FDfbYJt9uUOt6vl7hlAE9U+CFOqdXPHm
	nQo0tUQ504p+BzxPb3qbmHxcK5UvvBDDDz50YecGIauWHWxvSBmcaXNRPbK6hiZk
	p40XPZg+btvdn3RFf9g4D+3wYGwwJOb6DZYjEkj879LJUDRhChLUAtqdz+Du1Sr8
	fwjlWxjR27iQ7hCgbsvaI2BcWwpXJroWsXy8NGcIf6EMuv0BWCxW0+yqCgjQxQSz
	Ivz6h0owKsbTMpW50AhtYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714527768; x=
	1714614168; bh=UI8eVskdm/0fVqSqYYlThaWLGBVwXSK9e2mLaByBoGU=; b=f
	lmLz+duLZr7gdCCm2eAyERMpNmvQ+A13xNH4OQYGp+5cow0kqzb3GuA9cMsUt2rS
	LiR6YZYAL7OEvEuR9+iGKeUIAsRAj9OzL0w6UzJ4ZMpnsr7V0JRb1re39GSknxPo
	i3ULGJ217KIpits7LcLgIsSvbjHz6ssRmkZqin8Nf07ynJIqeHZG0/QFrfbFrfp0
	GPL4wCfbvfi4aOB6bX6hSHQEpau8tc8qTZpseHKuALTN82KD+BtIAgFkRyBDu5Sw
	WLuchbgC6wyS24iooRESYdTlhc6mLC6KxNcOnL4uqJNqGsy39pCKDKXAZ4opc6Zd
	O0UVPz/4EFOJkDKcsVbVg==
X-ME-Sender: <xms:F54xZj5T_vvnygwwgWF37OrWoI45O5btWPOqmU9TrrGJ_c6rKrY1sA>
    <xme:F54xZo5BMZMQOXi4RvUSVOyydoTdw1m8SVGwnUOFzxCbUvi6wxC8DoIBwIp5eK6Jc
    p7eLRyrLC3aQHQD8m0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddugedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfn
    hihnughonhcuufgrnhgthhgvfdcuoehlshgrnhgthhgvsehlhihnuggvnhhordgtrgeqne
    cuggftrfgrthhtvghrnhepheefgfevjeeivedvkefgfedtudfgtefgteeuleeiudffteei
    leehteeivedvfeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomheplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:F54xZqfVJnd8Q5zagBuZxGxLDg05dM0LXrWS-cL_pm3o4dC_E500UQ>
    <xmx:F54xZkJuVKx6QVIi3YsLl9B5I0vpLaOY4xQVGAAcFeJSf9-ag75Dmg>
    <xmx:F54xZnICHlhY6_KSwj72VwbvRhiNNbOPDfx_w5aL7BnPzKJQE70ejQ>
    <xmx:F54xZtwS-BgDVrpbEC3f34Xs7kWT1M7AWq2eil5-NIpwrvxQZwq2zw>
    <xmx:GJ4xZkAVsgdYUg2tKfWwp1vtYoNNQZVS4DiUg6OyvYjiQ8PhocrJzNpa>
Feedback-ID: i1719461a:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 1D886C60097; Tue, 30 Apr 2024 21:42:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-416-g2c1796742e-fm-20240424.001-g2c179674
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <32d6fa42-5a8f-45a2-b07f-c16f51533e04@app.fastmail.com>
In-Reply-To: <20240501013623.ia3debwadlu2qzff@pali>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240501011507.6942-2-lsanche@lyndeno.ca>
 <20240501013623.ia3debwadlu2qzff@pali>
Date: Tue, 30 Apr 2024 19:42:26 -0600
From: "Lyndon Sanche" <lsanche@lyndeno.ca>
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: "Mario Limonciello" <mario.limonciello@amd.com>, W_Armin@gmx.de,
 srinivas.pandruvada@linux.intel.com,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 lkp@intel.com, "Matthew Garrett" <mjg59@srcf.ucam.org>,
 "Hans de Goede" <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Dell.Client.Kernel@dell.com
Subject: Re: [PATCH v4] platform/x86: dell-laptop: Implement platform_profile
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024, at 7:36 PM, Pali Roh=C3=A1r wrote:
> On Tuesday 30 April 2024 19:14:52 Lyndon Sanche wrote:
>> + *          Bit 2 AAC (Quiet)
>> + *          Bit 3 AAC (Performance)
>> + *  cbRes3, byte 3  Current Fan Failure Mode
>> + *     Bit 0 Minimal Fan Failure (at least one fan has failed, one f=
an working)
>> + *     Bit 1 Catastrophic Fan Failure (all fans have failed)
>> + *  cbArg1 0x1   (Set Thermal Information), both desired thermal mod=
e and
>
> Broken indentation. cbArg1 should have only one space after "*" and be
> at the same level as the previous cbArg1 description.
>
> And I would suggest to add a newline before cbArg1 as it start
> description of the next command.
>

I will fix this.

>> + *               desired AAC mode shall be applied
>> + *  cbArg2, byte 0  Desired Thermal Mode to set
>> + *                  (only one bit may be set for this parameter)
>> + *     Bit 0 Balanced
>> + *     Bit 1 Cool Bottom
>> + *     Bit 2 Quiet
>> + *     Bit 3 Performance
>> + *  cbArg2, byte 1  Desired Active Acoustic Controller (AAC) Mode to=
 set
>> + *     If AAC Configuration Type is Global,
>> + *         0  AAC mode disabled
>> + *         1  AAC mode enabled
>> + *
>
> And here I would suggest to remove empty line as the comment below
> belongs to the AAC description above the empty line.
>

Agreed.

>> =20
>>  /* dell-rbtn.c driver export functions which will not work correctly=
 (and could
>> diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/p=
latform/x86/dell/dell-smbios-base.c
>> index e61bfaf8b5c4..40aa4469b38b 100644
>> --- a/drivers/platform/x86/dell/dell-smbios-base.c
>> +++ b/drivers/platform/x86/dell/dell-smbios-base.c
>> @@ -9,6 +9,7 @@
>>   *  Based on documentation in the libsmbios package:
>>   *  Copyright (C) 2005-2014 Dell Inc.
>>   */
>> +#include "linux/wmi.h"
>
> Is this include file really used? Because only SELECT_THERMAL_MANAGEME=
NT
> was added and it is in the dell-smbios.h. And others constants like
> SELECT_KBD_BACKLIGHT did not needed it.
>

No it is not. It seems my IDE automatically inserted this. I glossed ove=
r it when committing it seems.

Thank you for your quick feedback.

Lyndon

