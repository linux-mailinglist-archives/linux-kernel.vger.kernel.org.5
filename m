Return-Path: <linux-kernel+bounces-159136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D978B29CD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9D6281C23
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B095A15380E;
	Thu, 25 Apr 2024 20:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="O/n3A6gN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PXJZFKg4"
Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09EB1534E6;
	Thu, 25 Apr 2024 20:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714076877; cv=none; b=GsP0+LkQTkJ8mzYpVS9dVxNvHL+O5xCst3VClDvZi6Jpeb+UcTZs39ZJBzNbW3ub0Wpvw5PvIVt/PgjkLh4JysWNAabYHXI2R9SAO6AxXqCfbNTiSMN7HiSHiSQyNamYuz64Dh4H30QWqCzs743TgcVcwZoyDBDusAtHSUqQPLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714076877; c=relaxed/simple;
	bh=0hvitMNES5HdanLiWjeyAzACH8peCKF8XQu82Szogd0=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=DXCoC8U+aEZKCeGovcnGiYDmmE9b4Q60si2kp/WaWCWUOQWqXaE+r1oz9nRXmBi92niDWTwnNoaukt1RpZb7Yy0+dmmVMzCQAYntvu/VPfp4bc0CQNa2krbbyUcY6xknJo0QhCBxoZ3EW2h/Ww8Mjnc7SRoeDGQzH2242TfdqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=O/n3A6gN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PXJZFKg4; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 413EB1C00119;
	Thu, 25 Apr 2024 16:27:54 -0400 (EDT)
Received: from imap52 ([10.202.2.102])
  by compute5.internal (MEProxy); Thu, 25 Apr 2024 16:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1714076873;
	 x=1714163273; bh=zXPU98xIFonWd2oKiecGlx8Xw7dR9ggDvf74tP8NE2I=; b=
	O/n3A6gNIiYzQJZuxU/EfqENSb8MDLTwfWpmUffHbo/XO9H/ZXOkAXJZa5M2uHiw
	KPJZcYA8JMSgZLGL7M51AxIRw5VFxy4teLOe0/nYC2YZBqK6hMu0WDimNCBbRLTk
	7RJPFphiEVyHlQavmtoquHXMsClAnu7KT4kM9bXb8knUwZw+W6F15B6ukBvSJhGA
	bw2SB+aEA7Ghvct6ZWOfFg6MC3I9v6Fg0WmmEIv7coDiD1x4OpOVBwaLrRfsnrpY
	rEsOMjmGNMV1DPIngE5ZpyMW76gONr5o56gJ19q0ZKAUHmS8Cf4ceEFD9FgXyx8H
	t/27+zE2dYa2a9cYXMlmxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1714076873; x=
	1714163273; bh=zXPU98xIFonWd2oKiecGlx8Xw7dR9ggDvf74tP8NE2I=; b=P
	XJZFKg42LtIGnRd/3n2smH2N0gHrSw7GOCpy72l+7qqJi82lR1Hj4RT2gRdFtyL3
	zEjDoGLNQNm3MokNVVuX5Norzaj8FNnqoN/snL4SNq0znIKbubm7Rrs2EOHM53Lw
	xGm49+lI5y+bIxNc9Q0DotKLFZ4iRdwKELo0pwjZ7hi0jL1R0ksgX6D3BV0QOJcl
	nk+XJd+5qQVPofpkb7PEAv6tBOlLiTm5A1Tjg1e8x4eCYp4DVzSSRZAe1D4wKsJU
	zD7kzDAzszr42AqH9nIWuCmBeTgn0Y6NVAWvZMnfOxrbUvydV54+f/QWY3xne1qn
	6rwHelz+herVsP0LXzgTw==
X-ME-Sender: <xms:ybwqZotcQ8c2PqohDFAEjmUn_PtIyAP3t6gW8QvErbEIbPnZ9gtptA>
    <xme:ybwqZldl7X4hLh1ko0wVfBgO7lLISbDalublJfO7aM60PcJEP2GuFntz5YP61Ctff
    GZ6snDzWbC2PBSfNrE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeljedgudehtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    nfihnhguohhnucfurghntghhvgdfuceolhhsrghntghhvgeslhihnhguvghnohdrtggrqe
    enucggtffrrghtthgvrhhnpeehfefgveejieevvdekgfeftddugfetgfetueelieduffet
    ieelheetieevvdefkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehlshgrnhgthhgvsehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:ybwqZjyotClwBYUO61vl0OD60bH1pDKvfxQX5305Z5vUSyaGQSQ5XA>
    <xmx:ybwqZrP1RHVKllE4kt8v6PcQMon8mBNo2W-z_vhl66LlLG5FI6SCng>
    <xmx:ybwqZo8zY9o1mTdJJxYRyI8qQYoOfhiaagJhciv70SsVTlIqtNWoBA>
    <xmx:ybwqZjUKSiehfrTHl0MHlFI0YvvlETuXxlagufuk9JuskU_z5nG7tA>
    <xmx:ybwqZoz6PNloyhgtjNWatH10WDaA0bKl8V98A6UgJ3c31-F3YMbkckle>
Feedback-ID: i1719461a:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0D0A8C60097; Thu, 25 Apr 2024 16:27:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d31486b6-d71d-4985-adb1-2425f19b0b5c@app.fastmail.com>
In-Reply-To: <20240425201213.apwdxazbdbjddtpr@pali>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
 <20240425201213.apwdxazbdbjddtpr@pali>
Date: Thu, 25 Apr 2024 14:27:32 -0600
From: "Lyndon Sanche" <lsanche@lyndeno.ca>
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: "Matthew Garrett" <mjg59@srcf.ucam.org>,
 "Hans de Goede" <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dell.Client.Kernel@dell.com
Subject: Re: [PATCH] platform/x86: dell-laptop: Implement platform_profile
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024, at 2:12 PM, Pali Roh=C3=A1r wrote:
> On Thursday 25 April 2024 11:27:57 Lyndon Sanche wrote:
>> +int thermal_init(void)
>> +{
>> +	int ret;
>> +	int supported_modes;
>> +
>> +	ret =3D thermal_get_supported_modes(&supported_modes);
>> +
>> +	if (ret !=3D 0 || supported_modes =3D=3D 0)
>> +		return -ENXIO;
>> +
>> +	thermal_handler =3D kzalloc(sizeof(*thermal_handler), GFP_KERNEL);
>> +	if (!thermal_handler)
>> +		return -ENOMEM;
>> +	thermal_handler->profile_get =3D thermal_platform_profile_get;
>> +	thermal_handler->profile_set =3D thermal_platform_profile_set;
>> +
>> +	if ((supported_modes >> DELL_QUIET) & 1)
>> +		set_bit(PLATFORM_PROFILE_QUIET, thermal_handler->choices);
>> +	if ((supported_modes >> DELL_COOL_BOTTOM) & 1)
>> +		set_bit(PLATFORM_PROFILE_COOL, thermal_handler->choices);
>> +	if ((supported_modes >> DELL_BALANCED) & 1)
>> +		set_bit(PLATFORM_PROFILE_BALANCED, thermal_handler->choices);
>> +	if ((supported_modes >> DELL_PERFORMANCE) & 1)
>> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
>> +
>> +	platform_profile_register(thermal_handler);
>> +
>> +	return 0;
>> +}
>> +
>> +void thermal_cleanup(void)
>> +{
>> +	platform_profile_remove();
>> +	kfree(thermal_handler);
>> +}
>> +
>>  static struct led_classdev mute_led_cdev =3D {
>>  	.name =3D "platform::mute",
>>  	.max_brightness =3D 1,
>> @@ -2266,6 +2480,11 @@ static int __init dell_init(void)
>>  		mute_led_registered =3D true;
>>  	}
>> =20
>> +	// Do not fail module if thermal modes not supported,
>> +	// just skip
>> +	if (thermal_init() !=3D 0)
>> +		pr_warn("Unable to setup platform_profile, skipping");
>
> I think that -ENOMEM error should be failure of the loading the driver.
> It does not make sense to continue of memory allocation failed.
>
> On the other hand when the thermal modes are not support (e.g. old
> Latitude models) then there should not be a warning message. It is
> expected that on systems without thermal modes the setup fails.

Thank you for your feedback.

I agree with your suggestion. -ENOMEM would indicate something bigger is=
 amiss. I can add a check:

If -ENOMEM, fail driver.
If anything other error, skip, but do not show a message.

Lyndon

