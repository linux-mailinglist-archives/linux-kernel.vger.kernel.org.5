Return-Path: <linux-kernel+bounces-109109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3838814BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005822828E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B77535C6;
	Wed, 20 Mar 2024 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6wC8N0T"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C17239AF4;
	Wed, 20 Mar 2024 15:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949227; cv=none; b=YwRjpNl5W5MVOI0UWF/Q8jO25QpkgrLwv5lXWH+FFTGr6NQv4m1yGvbdO5TCB7e4q/KzGa0coJk6Vdkktzmq7oQ7z9VdtIUbHA6mHl632rx39rLaEH/4rDFzb6u0UFjl1StS2D4znWeZPNkh6GhNfbiAoctLgXx8EfHnZ1VGE74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949227; c=relaxed/simple;
	bh=yBSdj607UAc5s+hvP7CPVuKFZYFu/uVZGG+qtqxl8+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFkDPaiiX3vk9yWRW4BCLXUqEEu7vsVrrh/QnRSiv04aTRDGqRWJ2gbd8tL9udI0Ky8moQXU7M8yX6FmHuu9NwJaE6UUp0tIPGs9rFMjupe8s2u5HmUra1q++M5lXnYrXpUBMpJ07YSJfPo+Y/sddcDeajMPF44U/vVQdROyWB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6wC8N0T; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d41d1bedc9so121421681fa.3;
        Wed, 20 Mar 2024 08:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710949224; x=1711554024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxYGnvFML+VTUWkD++QvXGadpkGwkGYbiArVcV37wmI=;
        b=Q6wC8N0TbpvdQ8+2lbGY6AnO8TbzfuGgOJDNnnaIyyO1lMn4wPdyAObUhr9I6lo2vJ
         JoayA2WtV49LxGzzXxKni1rXMdK5MdTY/LEZhqBcoGkyuRVefEqVz48p0sC0wkhSz/Pq
         qOfQndGyWae6/2RKUs7i5pZcSkZNRNhe2zx3J+/jL4tJomvI3QNahQqnngBIpXji4iL5
         +Cx/cbnn7K/cwC/nC+lbQCqfpitbfzfv6M8lgpr7rInFxHae2O/rS5z0McO3fJpnVKir
         rG2Q5JBJCrztRqm21meWviO3q3SVvIfy7hGnqlVuSEPIgFqa2l30R6FcAYTnEKQm41Rl
         h/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710949224; x=1711554024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxYGnvFML+VTUWkD++QvXGadpkGwkGYbiArVcV37wmI=;
        b=OyBmJcNdRzjYhexnX+tuGLRq9aBNTrd8oMXKDjsHD0JES7rffTP9NFdSwUaYx8OPHE
         16v8gdUXxydNzPHGo7SjBnDmZjNMF0pYkgIdvZrWB2Mu/2j9flEPPpfGNYOFAN74SB2u
         c4ZWoV0wBhfHb7aW3zMesjCcevpHAjmjX3cYlLCqRMACh7fwY06BTRCL/m8Q/mkPAIhM
         XNHmmPuQqGvliG4dNXtwMgYQItYFukS8o4yYXF19wg90Blc48BG0SbBOW1e9250eDMAS
         UWHgK//HiwI5s8VluIGrCnf+u0NCTy8pRHBnopaYeAxOLpCmNIAJ7VwxhMiJj00zfufY
         GoWw==
X-Forwarded-Encrypted: i=1; AJvYcCV2ZO8HGxPbpbwah08lqnwwpyUlOp8fmo4U06l+n5BQlkb0JHLQDCMGq7EiK7AsXkxb/wRRv3uBsPPA2ft+gdN26AjyhbUYabqmrgYdK5kaELlHxoaAiqFyqdkyO7h1+4QjaJNINbV2Bg==
X-Gm-Message-State: AOJu0YzyoRvHzdbZVkT7bZTLNhW/tNUC16IudDRbSWWMh8P5Erfe1L2D
	jKjB9GWlKeDmCzGTdgTcpb4zgPBAI6Se5kvehcNhHY1wV2IRriQh
X-Google-Smtp-Source: AGHT+IFkjCDnIG+obH3vpqIoZtlRGajoCZ7GqSL0r6s79HfobNhYOMoOfjpHT3b/0GeCUbIua5NJmg==
X-Received: by 2002:a05:651c:388:b0:2d4:707d:8b3c with SMTP id e8-20020a05651c038800b002d4707d8b3cmr10212936ljp.18.1710949223984;
        Wed, 20 Mar 2024 08:40:23 -0700 (PDT)
Received: from ?IPV6:2001:999:708:5b57:30d6:2195:bb7b:bb94? ([2001:999:708:5b57:30d6:2195:bb7b:bb94])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e87d7000000b002d2b76dd76esm2196040ljj.57.2024.03.20.08.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 08:40:23 -0700 (PDT)
Message-ID: <7925bbe5-17e8-42cb-a5f0-4f3e06810a90@gmail.com>
Date: Wed, 20 Mar 2024 17:42:05 +0200
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
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
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
 <0bb26153-8bcb-475f-8892-5eb925fec538@bootlin.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <0bb26153-8bcb-475f-8892-5eb925fec538@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bastien,

On 20/03/2024 10:52, Bastien Curutchet wrote:
> Hi Péter,
> 
> On 3/19/24 19:29, Péter Ujfalusi wrote:
>>
>>
>> On 15/03/2024 13:27, Bastien Curutchet wrote:
>>> The McBSP's DX pin that outputs serial data during playback streams can
>>> be used during capture streams to repeatedly output a chosen pattern.
>>> For instance, this can be useful to drive an active-low signal during
>>> captures (by choosing <0> as output pattern).
>>
>> Are there really any other use of this than to pull down or up the DX
>> pin (0 or 0xffff)
>
> I don't know, indeed today I can only think about these two patterns.
> I tried to do something in a 'generic' way so it can evolve if needed.

I think the definition of the 'ti,drive-dx' is somehow odd. It allows
you to set it to 0x1234 and the DX pin will show 0x1234 when you capture
32bit. If you capture 16bit then it will transmit 0x12 (or 0x34?), no?
If you have 4 channel capture then I won't speculate what will be on the
DX pin ;)

Would not be better to say that the DX pin will be driven low or high
during capture _and_ disable the playback support?

> 
>> If you just use the pin as GPIO then you don't need to change anything
>> in the driver, The playback would not erach the pin, so no need to
>> block it.
>>
>>> Enable this behaviour when the device-tree property 'ti,drive-dx' is
>>> present. DX pin is driven with the provided pattern every time a
>>> capture stream is launched.
>>
>> It is an interesting use of the hardware... You are controlling an
>> external device (light an LED when capture is on)?
> 
> Yes I control the chip select pin of the ADC that is sending data to DR
> pin, that's why I need the DX pin to be synchronized with capture
> streams.

I see. Still a a novel use of a feature ;)

> 
>>> This property is not compatible with classic playback stream so
>>> davinci_i2s_trigger() returns an error if a playback stream is started
>>> while 'ti,drive-dx' flag is present.
>>
>> Propbaly add the .startup() callback and block the playback right there?
>>
> 
> Ok, TBH my mastery of the sound subsystem is not high enough to have an
> opinion of where this should go so I'll trust you on this.

It would be more elegant to only create PCM for the capture in this
case, but I would not bother with it.
Stopping user right at startup time is second better.

>>>
>>> This has been tested on a board designed of a DAVINCI/OMAP-L138 where
>>> the DX pin is linked to the chip select pin of the converters of the
>>> capture side.
>>
>> Isn't the DX will be pulled down as soon as the McBSP is enabled?
>> Can you just re-configure the PUPD_SEL for the pin group to make the pin
>> to be pulled the other way?
>>
> 
> Well, the acquisition chain in my use case is a bit convoluted. The DX
> pin's main purpose is to drive ADC chip select but it is also connected
> to other components and all this needs synchronization upon captures.

OK, thanks for the explanation.

-- 
Péter

