Return-Path: <linux-kernel+bounces-108649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B32A880DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2851C20DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272F43D549;
	Wed, 20 Mar 2024 08:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d5+yCEKF"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AAE3D0D1;
	Wed, 20 Mar 2024 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924763; cv=none; b=aBK/KJa5GDBIqq6fSjm4MHVV3Y4QYq80FS/fixzd8MEEXEbibiTOUlotjnXgBzUyJCzoJhDLa+riMCsFvPPAjaEbUWg+SNHjSaxR6kRuwUtlZ+pH795bD8QhyIoP5n1kTBfEGFk7fsdtVZDyEFZgsMDukUglRBRCk9cvIsc+F0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924763; c=relaxed/simple;
	bh=Y6mEQ/hFHTShTOWNUHTojQ/qnx61oBbZk6LyN0SEfHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dT4p+YqbyllXPPJUtV6zMttIAzBDTegjBzMw3CqMqRVjSKTkksg8+kXnqnqC4LrmhClVmGYhg7ayG4cdkvvYPUNAVGA09rW6ZqrXFXhaNh5ja0KnMEbEslKO8o7iJD4CNMoMf3E/c6kMj+Al66mzEco7pBLGxxOfIs4SMb8X6eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d5+yCEKF; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E68581C000D;
	Wed, 20 Mar 2024 08:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710924758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxoLGnpPdcI2kqvbcSNFfRIJr6iOEENAEB9wuOb1S70=;
	b=d5+yCEKFkAGewcctxM5DOA0phfHQIWulV63wZ7RifzHZ74xKJxu2hr/yHHcVexxkmJz564
	ueoVBoSPeJ84KVaE5hidOSM6p51WiderjDbSZHUwDBvbrAvDwpX+Tsrmst6Wl95/EwE4ZW
	rOxG33jRYTGdF3pDl65J9e2UOB17D7l+djRToJRh3x+A0+kCKO1lvMbzUE+W+N6c2msjSu
	L7UV4T6ir0s6IhaFcRbIPa3bp9PLejvORCQ7xjYQJEWiXjMaJmDRCqx7rz13ol0EceEjJe
	kUNDmRWVVWXtJEUopKTaDVNb3moXPR7RXtIuDiNXQwaNs6OeyRFMyPAc4Lf+JA==
Message-ID: <0bb26153-8bcb-475f-8892-5eb925fec538@bootlin.com>
Date: Wed, 20 Mar 2024 09:52:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] ASoC: ti: davinci-i2s: Opitonally drive DX pin
 during capture streams
Content-Language: en-US
To: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-14-bastien.curutchet@bootlin.com>
 <00182d1d-ef29-457f-9e3e-6e9b57592118@gmail.com>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <00182d1d-ef29-457f-9e3e-6e9b57592118@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Péter,

On 3/19/24 19:29, Péter Ujfalusi wrote:
> 
> 
> On 15/03/2024 13:27, Bastien Curutchet wrote:
>> The McBSP's DX pin that outputs serial data during playback streams can
>> be used during capture streams to repeatedly output a chosen pattern.
>> For instance, this can be useful to drive an active-low signal during
>> captures (by choosing <0> as output pattern).
> 
> Are there really any other use of this than to pull down or up the DX
> pin (0 or 0xffff)
I don't know, indeed today I can only think about these two patterns.
I tried to do something in a 'generic' way so it can evolve if needed.

> If you just use the pin as GPIO then you don't need to change anything
> in the driver, The playback would not erach the pin, so no need to block it.
> 
>> Enable this behaviour when the device-tree property 'ti,drive-dx' is
>> present. DX pin is driven with the provided pattern every time a
>> capture stream is launched.
> 
> It is an interesting use of the hardware... You are controlling an
> external device (light an LED when capture is on)?

Yes I control the chip select pin of the ADC that is sending data to DR 
pin, that's why I need the DX pin to be synchronized with capture
streams.

>> This property is not compatible with classic playback stream so
>> davinci_i2s_trigger() returns an error if a playback stream is started
>> while 'ti,drive-dx' flag is present.
> 
> Propbaly add the .startup() callback and block the playback right there?
> 

Ok, TBH my mastery of the sound subsystem is not high enough to have an
opinion of where this should go so I'll trust you on this.

>>
>> This has been tested on a board designed of a DAVINCI/OMAP-L138 where
>> the DX pin is linked to the chip select pin of the converters of the
>> capture side.
> 
> Isn't the DX will be pulled down as soon as the McBSP is enabled?
> Can you just re-configure the PUPD_SEL for the pin group to make the pin
> to be pulled the other way?
> 

Well, the acquisition chain in my use case is a bit convoluted. The DX
pin's main purpose is to drive ADC chip select but it is also connected
to other components and all this needs synchronization upon captures.


I'll integrate your feedback about the code in next iteration, thank
you.


Best regards,
Bastien

