Return-Path: <linux-kernel+bounces-159401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DC48B2E29
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DF1C284F47
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 00:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F55EDB;
	Fri, 26 Apr 2024 00:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="fjSs3AtI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K5kerXH6"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF188812;
	Fri, 26 Apr 2024 00:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714092862; cv=none; b=kJfMPlqSP8C3TUBkptWBjMX4laTdXBgyEQAnRmyhDiDhFSqxz0I5eBOoHE6n+xmS/lT7Z7uZY0SayD2kYYwnS/vPF8Hk9NrpDgFC41dblnQ7ojgEtVpHTfRC+fsrI3olM1xHaG6ff4M+zsfgHy0smdYl5Ooiry5qDSu8MEKEiYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714092862; c=relaxed/simple;
	bh=rAXhkiYjsE9dF+PJ35ywofdQtX1orXOFQH2EqWBJemg=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cf7fB6T5+YM6fMQ09OwVH92JDm29fTJKePWf4cqFsT3WwNiMyaYMRIwWKOjKgj6ooxjhvlhiNsjFk6iv9wxiAz+zo6T7Csw37cnQUmwFackqry1f2Ilqi+f1e2kXRHSZRZDYCfN/BlFC13Mj/ZlCT1X+jJyP7V+FsWnf6+OyxTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=fjSs3AtI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K5kerXH6; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 48B7B114014E;
	Thu, 25 Apr 2024 20:54:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 25 Apr 2024 20:54:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714092859; x=1714179259; bh=bgecerkCbm
	g9U207wkZU6fnoe87J+8tse47C97qfz3M=; b=fjSs3AtIhSxEkULmfiuYnW5TU5
	T1xRIoYi6rGwrzWLA7HaM783wMuHYEQpX5qqfAS+Q0z3iYiL+XZ/6NQWpQPbqMAj
	NUa7ZxQ5tB2EQhaME6HALYesmrCgR/0KBPLd1UxolXhpRdO3rpkAhX0KG/6K1Ot0
	eyK2Qosf87Zlgsl/4othAcNSp8kx1zvZxNBZ3aiFidPSY+MwOFjgznOGr/l2Sz5+
	klO8A0U+mGEBWQzFK70BLlDV0PlxP5I+rQ05hLAZZ0ytO7WAFwzpTzIRxkBcV95n
	NrkNaC7Tpcr4KXNe8C0Eou3HL/HAuM3166LKUZwlIKZ/PtqoMXvpV91R0ptQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714092859; x=1714179259; bh=bgecerkCbmg9U207wkZU6fnoe87J
	+8tse47C97qfz3M=; b=K5kerXH6tH1tFk80RVaCEUIjwXlcSRFmXOlOqJg2f9Fq
	FpEyH6Jj5m0ihsVmL3mwaLglTrtBqo4nnYi93ji6No/+bBnO4+WMP3lwltuNIvq5
	IipJZKXZok5W01q5VjHzFaZUqUUTSHoOosgiDx0MrZua84MEIQfHX4bbMwDv54W0
	nz7hXp5LlbYswXMI44wgyGWrBhwyG+u3UIyTlssROon65fSDt0c0Xm4ELme7uaUy
	NdCIwmH5pwiAjmvIgn28ZVDYr//+mDh4oPwyakej/TXiEESNWPenQVYe2pC6alLN
	/znEb2nzSmGx6NTKcGQz5NrX3i7c0FHMPNeVMUZ7Zw==
X-ME-Sender: <xms:OvsqZhLq0VEYvST_G7J6BAOdzOha7qH7OIThHjdHiFBW1zrGeIaZSQ>
    <xme:OvsqZtLxOhs2Bd18iy_qPycm3KLx8q9QcGJ7TvJwmZoOi2sQNzNfAWSp7tyi8_dYB
    GUmgMylwALT9GAB7Lc>
X-ME-Received: <xmr:OvsqZpv6U448N6S-X6zlbRSPdm7pttLVL8iGxTxR4CnCI-vVcmmakekGVkDk1eTMSNbnSsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudelkedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhuffvvefkjghfofggtgesthdtredtredtvdenucfhrhhomhepnfihnhgu
    ohhnucfurghntghhvgcuoehlshgrnhgthhgvsehlhihnuggvnhhordgtrgeqnecuggftrf
    grthhtvghrnhepjeffueekgeeijefhvddugedtkeefveevtefghfevfeeufffgvdevleei
    udfhtddvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eplhhsrghntghhvgeslhihnhguvghnohdrtggr
X-ME-Proxy: <xmx:OvsqZiZisMLgPra3UWvMnc20RWiBXDplGLkdt6WMVvhcXLFhiY1FKA>
    <xmx:OvsqZoaykwiqg_rdHY1mPDnOHCywB_BD5ndJQZqmbpaGPk2dYLQjOQ>
    <xmx:OvsqZmADtqEGH9AF_8f21kH1wadV-t8_r-yJmMsPaLMM-547cu2Q9Q>
    <xmx:OvsqZmZBpTCu8Uv76MC2Ol5VKrLPgooawHzcOiyXUjWCWBENVBkNIQ>
    <xmx:O_sqZuO_MrF4NZ003Of1trIU8gTSOJ37IqUnXSATYh-qTpTwaTvfP1GA>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Apr 2024 20:54:14 -0400 (EDT)
Date: Thu, 25 Apr 2024 18:54:03 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
Subject: Re: [PATCH] platform/x86: dell-laptop: Implement platform_profile
To: Armin Wolf <W_Armin@gmx.de>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Pali =?iso-8859-1?b?Um9o4XI=?=
	<pali@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Message-Id: <3IYICS.H9INGKTE6BW73@lyndeno.ca>
In-Reply-To: <7a215986-4702-443a-9e1d-a2fb1172276a@gmx.de>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
	<7a215986-4702-443a-9e1d-a2fb1172276a@gmx.de>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Thu, Apr 25 2024 at 11:07:22 PM +02:00:00, Armin Wolf 
<W_Armin@gmx.de> wrote:
> Am 25.04.24 um 19:27 schrieb Lyndon Sanche:
>> 
>> +//         1  AAC mode enabled
>> +//
>> +//     If AAC Configuration Type is USTT mode specific (multiple 
>> bits may be set for this parameter),
> 
> Hi,
> 
> checkpatch reports: WARNING: line length of 101 exceeds 100 columns

I can wrap this last line.

> 
>> +//         Bit 0 AAC (Balanced)
>> +//         Bit 1 AAC (Cool Bottom
>> +//         Bit 2 AAC (Quiet)
>> +//         Bit 3 AAC (Performance)
>> +static int thermal_get_mode(void)
>> +{
>> +	struct calling_interface_buffer buffer;
>> +	int state;
>> +	int ret;
>> +
>> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
>> +	ret = dell_send_request(&buffer, CLASS_INFO, 
>> SELECT_THERMAL_MANAGEMENT);
>> +	if (ret)
>> +		return ret;
>> +	state = buffer.output[2];
>> +	if ((state >> DELL_BALANCED) & 1)
>> +		return DELL_BALANCED;
>> +	else if ((state >> DELL_COOL_BOTTOM) & 1)
>> +		return DELL_COOL_BOTTOM;
>> +	else if ((state >> DELL_QUIET) & 1)
>> +		return DELL_QUIET;
>> +	else if ((state >> DELL_PERFORMANCE) & 1)
>> +		return DELL_PERFORMANCE;
>> +	else
>> +		return 0;
> 
> This would return DELL_BALANCED if no option is set. Please return an 
> appropriate error code.

Thanks for catching this, I will return a proper error code.

> 
>> +}
>> +
>> +static int thermal_get_supported_modes(int *supported_bits)
>> +{
>> +	struct calling_interface_buffer buffer;
>> +	int ret;
>> +
>> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
>> +	ret = dell_send_request(&buffer, CLASS_INFO, 
>> SELECT_THERMAL_MANAGEMENT);
>> +	if (ret)
>> +		return ret;
>> +	*supported_bits = buffer.output[1] & 0xF;
>> +	return 0;
>> +}
>> +
>> +static int thermal_get_acc_mode(int *acc_mode)
>> +{
>> +	struct calling_interface_buffer buffer;
>> +	int ret;
>> +
>> +	dell_fill_request(&buffer, 0x0, 0, 0, 0);
>> +	ret = dell_send_request(&buffer, CLASS_INFO, 
>> SELECT_THERMAL_MANAGEMENT);
>> +	if (ret)
>> +		return ret;
>> +	*acc_mode = ((buffer.output[3] >> 8) & 0xFF);
>> +	return 0;
>> +}
>> +
>> +static int thermal_set_mode(enum thermal_mode_bits state)
>> +{
>> +	struct calling_interface_buffer buffer;
>> +	int ret;
>> +	int acc_mode;
>> +
>> +	ret = thermal_get_acc_mode(&acc_mode);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dell_fill_request(&buffer, 0x1, (acc_mode << 8) | BIT(state), 0, 
>> 0);
>> +	ret = dell_send_request(&buffer, CLASS_INFO, 
>> SELECT_THERMAL_MANAGEMENT);
>> +	return ret;
>> +}
>> +
>> +static int thermal_platform_profile_set(struct 
>> platform_profile_handler *pprof,
>> +					enum platform_profile_option profile)
>> +{
>> +	int ret;
>> +
>> +	switch (profile) {
>> +	case PLATFORM_PROFILE_BALANCED:
>> +		ret = thermal_set_mode(DELL_BALANCED);
>> +		break;
> 
> Maybe using "return thermal_set_mode()" would be better in this cases.

Good idea, I can clean up the code with this suggestion.

> 
>> +	case PLATFORM_PROFILE_PERFORMANCE:
>> +		ret = thermal_set_mode(DELL_PERFORMANCE);
>> +		break;
>> +	case PLATFORM_PROFILE_QUIET:
>> +		ret = thermal_set_mode(DELL_QUIET);
>> +		break;
>> +	case PLATFORM_PROFILE_COOL:
>> +		ret = thermal_set_mode(DELL_COOL_BOTTOM);
>> +		break;
>> +	default:
>> +		return -EOPNOTSUPP;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int thermal_platform_profile_get(struct 
>> platform_profile_handler *pprof,
>> +					enum platform_profile_option *profile)
>> +{
>> +	switch (thermal_get_mode()) {
> 
> Please check if thermal_get_mode() returned an error code and return 
> it in this case.

Will add error checking.

>> +		set_bit(PLATFORM_PROFILE_PERFORMANCE, thermal_handler->choices);
>> +
>> +	platform_profile_register(thermal_handler);
>> +
>> +	return 0;
> 
> Please check the return value of platform_profile_register() and 
> return the error if this function fails,
> see commit fe0e04cf66a1 ("platform/surface: platform_profile: 
> Propagate error if profile registration fails")
> for an explanation.

Thank you for catching this. I forgot to handle the return value.

> 
>> +}
>> +
>> +void thermal_cleanup(void)
>> +{
>> +	platform_profile_remove();
>> +	kfree(thermal_handler);
>> +}
>> +
>>   static struct led_classdev mute_led_cdev = {
>>   	.name = "platform::mute",
>>   	.max_brightness = 1,
>> @@ -2266,6 +2480,11 @@ static int __init dell_init(void)
>>   		mute_led_registered = true;
>>   	}
>> 
>> +	// Do not fail module if thermal modes not supported,
>> +	// just skip
>> +	if (thermal_init() != 0)
>> +		pr_warn("Unable to setup platform_profile, skipping");
>> +
>>   	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
>>   		return 0;
>> 
>> @@ -2344,6 +2563,7 @@ static void __exit dell_exit(void)
>>   		platform_device_unregister(platform_device);
>>   		platform_driver_unregister(&platform_driver);
>>   	}
>> +	thermal_cleanup();
> 
> Should only be called when thermal_init() was successful.

I do not believe it is incorrect to skip checking for this.

platform_profile_remove() does not return anything and does not panic 
when a profile is not currently registered. My understanding from 
reading the source is it handles the case of no profile gracefully. 
Please let me know if my understanding is incorrect however.

kfree does not care of the thermal handler is allocated or not. Please 
let me know if calling kfree on NULL pointers is poor form for this 
application.

Thank you for your feedback, I do appreciate it.

Lyndon



