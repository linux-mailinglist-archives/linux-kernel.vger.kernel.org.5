Return-Path: <linux-kernel+bounces-106015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBDF487E78E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1915B1C212B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 278783309E;
	Mon, 18 Mar 2024 10:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ngikuw+3"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F852DF9D
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758450; cv=none; b=JvzhiyBpwe78IaGmTTLoLq9iVe0DCzubjhkgbBYnrN1Go4S1uTmug4IuHTe37ykwX8INsmm2AK/uVN5q0wjtvDgqOCsCljc1EcNzfzv0o9GTFHxMxGWRgWWCGTcdlqrauOp69ZFnAZRXJz5uxcVmk+VYOjz1OVLzvAYfP0cXll8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758450; c=relaxed/simple;
	bh=i5ixDYb3wbENoImw8j5KKJEmWmhgfjQSVNTIJMv1DhY=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Ns0MkzkwnALxdfLa7kBGHZp1KJuezYRCEiLn4jvmlMCSWtcNB//5uKcIE5mjn0ytNEHjaSqDMTPr6zx7smgHcYvKHztGCMPfG5WBhYkVnoatSFjHkuEif8Up7GlwTWwQbA2kpxCwdHZWIF07Qfh2LrayccJqltuuvGJwJQnDMdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ngikuw+3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41409fd8b6bso11107065e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1710758445; x=1711363245; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=xNzf7P8nz60f5DqiZ1A/ORzVISDkI6sI6tCR2mQw6JE=;
        b=Ngikuw+3cNJp9rXoQiOJ2p93RAsF34UruLbhm6ntsmzb9jVrQn7uD1aG7Xz6ErKrxy
         2fPnnQZVHAS6hTNgqCXBwtVIQW2TZ7YlfxjQvLeuIn6xAyind4ZIrh7Z6KU/Gh8JECv6
         vqjpkfV9IjZ9y0uKxq4tvL6YFKofrlbdB5pfdMLk48d/W1gwtxSacexXTPLG0ZDdIomJ
         RuJhePL/Fd/mX8gjzjDdV+ZeBKY+JXSXi8uH67e3mW+vx+WLGysWFlZJpETFAgwfUzuJ
         3s9W6Cz7ufbkn/6/OYUQxQ9NnxJDQs0GL6yzW/11CXrME36NCFesd/wSS2EZt6LVKaAD
         KSVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710758445; x=1711363245;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNzf7P8nz60f5DqiZ1A/ORzVISDkI6sI6tCR2mQw6JE=;
        b=uJO+bT9olJBrCH/IHufz3ZbEIE3X2bmA618IzpUYx87L+obAwLkpaopH9QlriPKjbV
         KNvB0c1pcjdg4l4qpQgKGurnR3gWtPl1copguMaX7np61ViSoW7mVIOkAV+1AK7mIVSS
         5/q5qkoIBdwSK8Xw6imBDlqEG7i9I2RfLDhUU0E2ArqSo7KWOUd1vF4R6jyNapVkDsfZ
         Xlw1GKhs8viuE5faVeB+eB9T2Mg5xXNd8eOoxNL/zS0iWNhnAF1jdMZx59SlK+EK3sgd
         6Xq6hPnBO1yqYsdvepIDqLEHIO8nl17YU2ZnyS7bdNzkrN/E8Xghwpxt3wqRKt2Hwnwv
         OCxw==
X-Forwarded-Encrypted: i=1; AJvYcCV+jMpe/ch6J1XJkrfB1mKUNgaKuze+omjcVzMIYC9gXIvoZXg/w/1FU4IhTHoRss0ZNEESydNv7jvTFow2h783R7vmQZNBKFAgw707
X-Gm-Message-State: AOJu0Yz280x2b2KIpWl5/+2jBnP/9SmTJbkEJuiqd9q2wNH9KQthkG4N
	RpLLWidG6CplA/PPFxiXfSPJmwE58n4Dk1Kf934lJ0bthQRKVYt5ob89Ee3fI/I=
X-Google-Smtp-Source: AGHT+IF2NPmkDgNrJwjlDs0dlEQjbzK0dB/C1p7NsE17fQtvvBPtrHxeI38T1w1hQ953d1PS97HQkQ==
X-Received: by 2002:a05:600c:4707:b0:414:ca1:6531 with SMTP id v7-20020a05600c470700b004140ca16531mr3050478wmo.41.1710758445095;
        Mon, 18 Mar 2024 03:40:45 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:e4d5:78c0:18b:ad85])
        by smtp.gmail.com with ESMTPSA id f19-20020a05600c155300b00414105c4cd9sm2909256wmg.21.2024.03.18.03.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 03:40:44 -0700 (PDT)
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-2-jan.dakinevich@salutedevices.com>
 <1j8r2jj24k.fsf@starbuckisacylon.baylibre.com>
 <cbfd9c66-cca5-49f5-9468-43710c48518e@salutedevices.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kevin
 Hilman <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linus.walleij@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org, linux-gpio@vger.kernel.org,
 kernel@salutedevices.com
Subject: Re: [PATCH 01/25] clk: meson: a1: restrict an amount of 'hifi_pll'
 params
Date: Mon, 18 Mar 2024 11:17:14 +0100
In-reply-to: <cbfd9c66-cca5-49f5-9468-43710c48518e@salutedevices.com>
Message-ID: <1jedc7hlg4.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Sun 17 Mar 2024 at 17:17, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:

> On 3/15/24 11:58, Jerome Brunet wrote:
>> 
>> On Fri 15 Mar 2024 at 02:21, Jan Dakinevich <jan.dakinevich@salutedevices.com> wrote:
>> 
>>> Existing values were insufficient to produce accurate clock for audio
>>> devices. New values are safe and most suitable to produce 48000Hz sample
>>> rate.
>> 
>> The hifi pll is not about 48k only. I see no reason to restrict the PLL
>> to a single setting.
>> > You've provided no justification why the PLL driver can't reach the same
>> setting for 48k. The setting below is just the crude part. the fine
>> tuning is done done with the frac parameter so I doubt this provides a
>> more accurate rate.
>> 
>
> You are right, it is not about 48k only. However, there are two issues.
>
> First, indeed, I could just extend the range of multipliers to 1..255.

Why 1..255 ? This is not what I'm pointing out

According to the datasheet - the range is 32 - 64, as currently
set in the driver.

The change you have provided request a multipler of 128/5 = 25,6
If you put assigned-rate = 614400000 in DT, I see no reason can find the
same solution on its own.

> But I am unsure if hifi_pll is able to handle whole range of
> mulptipliers. The value 128 is taken from Amlogic's branch, and I am
> pretty sure that it works.

>
> Second, unfortunately frac parameter currently doesn't work. When frac
> is used enabling of hifi_pll fails in meson_clk_pll_wait_lock(). I see
> it when try to use 44100Hz and multipliers' range is set to 1..255. So,
> support of other rates than 48k requires extra effort.

Then your change is even more problematic because it certainly does not
disable frac ... which you say is broken.

That parameter should be removed with a proper comment explaining why
you are disabling it. That type a limitation / known issue should be
mentionned in your change.

>
>>>
>>> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
>>> ---
>>>  drivers/clk/meson/a1-pll.c | 8 ++++----
>>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/clk/meson/a1-pll.c b/drivers/clk/meson/a1-pll.c
>>> index 4325e8a6a3ef..00e06d03445b 100644
>>> --- a/drivers/clk/meson/a1-pll.c
>>> +++ b/drivers/clk/meson/a1-pll.c
>>> @@ -74,9 +74,9 @@ static struct clk_regmap fixed_pll = {
>>>  	},
>>>  };
>>>  
>>> -static const struct pll_mult_range hifi_pll_mult_range = {
>>> -	.min = 32,
>>> -	.max = 64,
>>> +static const struct pll_params_table hifi_pll_params_table[] = {
>>> +	PLL_PARAMS(128, 5),
>>> +	{ },
>>>  };
>>>  
>>>  static const struct reg_sequence hifi_init_regs[] = {
>>> @@ -124,7 +124,7 @@ static struct clk_regmap hifi_pll = {
>>>  			.shift   = 6,
>>>  			.width   = 1,
>>>  		},
>>> -		.range = &hifi_pll_mult_range,
>>> +		.table = hifi_pll_params_table,
>>>  		.init_regs = hifi_init_regs,
>>>  		.init_count = ARRAY_SIZE(hifi_init_regs),
>>>  	},
>> 
>> 


-- 
Jerome

