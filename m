Return-Path: <linux-kernel+bounces-30853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A63A3832520
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9442865F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F84D520;
	Fri, 19 Jan 2024 07:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AJx4gYh0"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51633CA4A;
	Fri, 19 Jan 2024 07:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650214; cv=none; b=tq0kwUmBUI3xsPcp9U3xWirhoqCZ62lMpkOBIBr/hycdyfiSIW1LJM4RJWP8yWkRzEts+8sxLwjc9qcGKhLtVJxxft7GePDHgH0BPJPcpdbMimU8upgQ5RAYdHlFC/qtciRPIJJJiug33HrTcqjUkmXpGezk0UdTGOzkghyB2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650214; c=relaxed/simple;
	bh=UXct//2LTvT2yJMrTc9ACPg53/+fA+whXWelCkJIV1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fvAbIqWMK7y3CRAzW9YWsnyVhIcige1zOzfJFoty0mtKlWOqV4pMf85gfYMF0lCiYXEcdbIKJ/uIK8+UorEY+GhCd597LUemx+4i+Ar+0EUMqjOgKkiLqz4T6pvjTwIou1UQ0U4mBVi7XYU3zpsPljtljuVgCoDmDocHXMna11M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AJx4gYh0; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 52D1E240004;
	Fri, 19 Jan 2024 07:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705650207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sp/N1KdzR2MNa38QunQH9spzza45w0SOUgEyKGyCiTA=;
	b=AJx4gYh0TjvoblphphF5x5k6WcFPXwElwfTjTWO9oXn4vYALIOThdI+XavI4wlpcv8PbYf
	ewEYMKiRigr+coIeN0TKCByFBiqcAYmXfzOOB3SHu9iuqFSPnFfhy+R19We+OLvdzkpoWG
	LvoROM/SoopGQG9peRpfrEXgIDHrkJnUB0bQnOJh7n1qapZW6i0eekchG56bqz5EdIBB3N
	Ns8tcPawTezHlKF8DQefOQFWtzpjS8jHsB5QtLxh9Ct4InKNisqtdIrXxz/Ya+Z31F6OUY
	9tSRWrzPSPyL5N2Iha4FJVZ4r5Pq7t0+YxmQvLZT//ihthx5YkL8ttTJgz/pMg==
Message-ID: <b215909e-43c7-47b5-ac0b-2a194b55cb39@bootlin.com>
Date: Fri, 19 Jan 2024 08:43:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] wifi: wilc1000: set preamble size to auto as default
 in wilc_init_fw_config()
To: Ajay.Kathat@microchip.com, kvalo@kernel.org
Cc: linux-wireless@vger.kernel.org, claudiu.beznea@tuxon.dev,
 davidm@egauge.net, thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org
References: <20240115-wilc_1000_fixes-v1-1-54d29463a738@bootlin.com>
 <170557027237.2797779.2354857290141885659.kvalo@kernel.org>
 <000e823e-ede1-408b-b8e1-fd9c1c73fd6e@bootlin.com>
 <5c5e1332-39de-4d6b-9646-661c78cee900@microchip.com>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <5c5e1332-39de-4d6b-9646-661c78cee900@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 1/18/24 17:52, Ajay.Kathat@microchip.com wrote:
> On 1/18/24 08:08, Alexis Lothoré wrote:

[...]

>> "WILC driver currently applies some default configuration whenever the firmware
>> is initialized, and sets the default preamble size to short. However, despite
>> this passed option, firmware is also able to successfully connect to access
>> points only using long preamble, so this setting does not really enforce short
>> preambles and is misleading regarding applied configuration.
>>
>> Update default configuration and make it match the firmware behavior by passing
>> the existing WILC_FW_PREAMBLE_AUTO value (2 instead of 0). The updated setting
>> does not really alter firmware behavior since it is still capable to connect to
>> both short preamble and long preamble access points, but at list the setting now
>> expresses for real the corresponding firmware behavior"
>>
>> To give a bit of context around this one: I do not have access to the firmware
>> internals, I just took the patch from Ajay and I merely did some tests around it
>> with multiple APs (basically, making a WILC STA connect and ping the AP), and
>> ensured with wireshark to get at least one AP be really "locked" with long
>> preamble, with WILC managing to connect to it.
>>
> 
> Here are some more details about this change. It have been implemented
> to address the transmission(Tx) blackout issue observed in the 802.11b
> mode. The modification has no impact on the other modes, which will
> continue to work as they did in the previous implementation. This change
> will allow the 802.11b transmission(2, 5.5, 11Mbps) to use long preamble.

Ah, so it fixes a specific bug (and makes parts of my suggested description
wrong). Has there been any report about this "TX blackout issue" on the mailing
lists ? If so, we could enrich the message with some details from the report and
add some missing Reported-By/Fixes/Closes tags.

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


