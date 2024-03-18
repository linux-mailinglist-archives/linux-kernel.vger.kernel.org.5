Return-Path: <linux-kernel+bounces-105776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A0587E430
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53797B20C08
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ABA22F13;
	Mon, 18 Mar 2024 07:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R2GBtBin"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B653C22EE5;
	Mon, 18 Mar 2024 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710747636; cv=none; b=J4aDzmiqikamHJxVHk7CwU9m1zjqvqyvIKJQXn9AHxQBcBKXK4nnFVzSKxNaTJxhk9tEzziHDeZfyxOAFcPgOtlRHee/KleVlFLRC0s++gYLW/sgSkE7ExuI/t/MGDTAYlmzxIahnsxKXGfsJHmmzU+FLc5Go8YqhOEG/+/U7Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710747636; c=relaxed/simple;
	bh=kNhMjJpwlz3byNUnufv33O0Jk3nCGQ44HS81muA0q/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ctY413x6lz15vUzJ6dVS/2liJzbLWn0Gc/IMxPmoEEcloZn3yT4F+b197w3MTjCqbYIhwKZvOxDDFyhoAm/8vkrjv3JNO0NyoHhBHqGzIgqava5lh8rFM9M1bLWsT8Ed4+hovVjWSbljmWpigs58hRsw5BnSD4LeofXe0o8HY08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R2GBtBin; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3D169240002;
	Mon, 18 Mar 2024 07:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710747626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXBzCDL3hGWbPPUQVgvtbeEN3RCK/L6n100bBjyN8L4=;
	b=R2GBtBin6QsbFPPmS6krl6SbnxGtkvas5o7sKc99wBlrUB7QA3klh1sSAR9xPA9o6x2abm
	nqZoPMyPmppP8mKuzDHotJjTAANEAiqLMGPzrDq9md6Rs01Pyuc6J8wBR2anIOsX+bTuMs
	1DlXI1wVQrkQ9kyWm1ZpBg/d9LmeCRVBCvFgL8DtDPhc9xna7SJ+QRwNEHcdj5pKXh8bp4
	FE/dI1WLDy4f4TnvBCaDgWjLqDLpXBPFEWYIWredQr430YRa0ZPQDpGRkAN6yaLLonVgpQ
	0MbRedgxSb+H0XNZyD2LiuwpYbbNOy5jBN+C486V0+/aRQFp4flKgviirFniaA==
Message-ID: <622b8b7e-7bd1-4e88-b705-79f7077b754a@bootlin.com>
Date: Mon, 18 Mar 2024 08:40:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] ASoC: ti: davinci-i2s: Replace dev_err with
 dev_err_probe
To: Mark Brown <broonie@kernel.org>, Herve Codina <herve.codina@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Ujfalusi
 <peter.ujfalusi@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 alsa-devel@alsa-project.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, christophercordahi@nanometrics.ca
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-5-bastien.curutchet@bootlin.com>
 <6102130b-b496-4e75-9b9f-f960484848fb@sirena.org.uk>
 <20240315152332.57c8fdc4@bootlin.com>
 <2f58922d-8964-4693-ab8a-612eb2f427e1@sirena.org.uk>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <2f58922d-8964-4693-ab8a-612eb2f427e1@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: bastien.curutchet@bootlin.com

Hi Mark,

On 3/15/24 15:40, Mark Brown wrote:
> On Fri, Mar 15, 2024 at 03:23:32PM +0100, Herve Codina wrote:
>> Mark Brown <broonie@kernel.org> wrote:
> 
>>> dev_err_probe() with a fixed error code doesn't seem to make much sense,
>>> the whole point is to handle deferral but for a straight lookup like
>>> this that can't happen.
> 
>> The error code is uniformly formatted and the error path is more compact.
>>    https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L4963
> 
>> IMHO, to benefit of these feature, it makes sense to use it even with a fixed
>> error code.
> 
> I'm not convinced TBH, the fixed error code smells pretty bad.

Ok. I'll keep the dev_err() for the fixed errors then, and use the 
dev_err_probe() for the others, would that be ok ?

Best regards,
Bastien



