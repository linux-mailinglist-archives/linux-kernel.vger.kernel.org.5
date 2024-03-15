Return-Path: <linux-kernel+bounces-104534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD20187CF5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E826E1C22817
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429803D55D;
	Fri, 15 Mar 2024 14:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KWDBifJA"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976B23C6A3;
	Fri, 15 Mar 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513930; cv=none; b=UuUAtxvcRaj/wra8Fo8YjP1sfIhQun+GydACadwMyGJrDGpjGGgt8qEGRTC+Te7ZHkBuaTHVvwZmMlgYr4G+q1GQ2TKr1a8UysIUnYpo5eB0VilpHib/RwUpQAd/1LUPb7bMM200snAPR8yymI0cwAMeCSeC5pVNk8ZIIi3wYek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513930; c=relaxed/simple;
	bh=7+fJfBST5IdB1sgP/eTQYRwwxuAf0nFH5htcIsMtVUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K3fdD3KwQ6hEM76q8A6yLCXNOrWeAR3oLtQR29niLLpyJjSETJFT1m+nOWEJd9gwbjwCu7E8s5rO9rZw+h2MoPr5cucz6gy+kmIdNRTJO+2/kAT2t01zMXcVerVMW9j5YuiCfQVK9s+v1Saaxc+P8oL11VFsnRgEUEeRsnnLfbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KWDBifJA; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A85231BF20C;
	Fri, 15 Mar 2024 14:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710513925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lCzVTi/8qiIkWIQuMQeabN+Upuh5rS0d0MiWy39obn8=;
	b=KWDBifJAeamjCj4tFGXOKgrfAdJ+TaLvUBsIFlZSmEqiozMYaPqkiTjZKk+6rPwCnKloM7
	tCnUNg4sxFveR6d7CK8E47hqVzEvvypk7BtvNEW3jHLxBdCOrFXrO4s1KNYGVjvxZEtkMX
	SA29cZrOEH6nQ3hGtJ69pjG0SxbvbDwb+F4naOcJKjsU2SIdcr2AkLJwa8m/kJkxkdBZob
	ZovQHltOeOJMR00N20S1O4tlOMtDtJ/TCRtE3PUQAk3MpBehBg1GMFLROjSzPG/u3J2VzW
	OYDeQ+H/rCftP6Mfp7AA0EOz9xvxO/DjZj7Xg9PnMTgpKXCe3mNbtvKDYJUFXA==
Message-ID: <13faa6c8-ad4f-4f81-935a-5ea74621d373@bootlin.com>
Date: Fri, 15 Mar 2024 15:45:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/13] ASoC: ti: davinci-i2s: Enable unexpected frame
 pulses detection
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Ujfalusi
 <peter.ujfalusi@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-10-bastien.curutchet@bootlin.com>
 <51866f62-460d-4035-bcf1-b9f03cf9be0b@sirena.org.uk>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <51866f62-460d-4035-bcf1-b9f03cf9be0b@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Mark,

On 3/15/24 15:09, Mark Brown wrote:
> On Fri, Mar 15, 2024 at 12:27:41PM +0100, Bastien Curutchet wrote:
> 
>> McBSP can generate an SYNCERR when unexpected frame pulses are
>> detected. The driver always disables this feature and ignore the
>> unexpected frame pulses.
> 
> What does "unexpected" mean?

Unexpected frame sync pulse is defined in datasheet as a sync pulse that 
occurs <N> bit clocks earlier than the last transmitted bit of the 
previous frame. The <N> can be configured through registers.

> 
>> Enable the generation of SYNCERR by the McBSP according to the
>> 'ti,enable-sync-err' device-tree property.
> 
> Why would this be optional, and how is this reported - I'm not seeing
> any interrupt handling updates?

It is possible to deliberately ignore them and that is what is done 
today in the driver.
This is reported as a status bit in a register. An interrupt can indeed 
be generated from this but I'm not using it (now at least).
I use the fact that McBSP automatically drops previous element and 
starts a new reception when an unexpected frame pulse occurs.


Best regards,
Bastien

