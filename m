Return-Path: <linux-kernel+bounces-131028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900DB89822A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:26:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4503D280DFB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B3D59B78;
	Thu,  4 Apr 2024 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzE0cENk"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D342A85;
	Thu,  4 Apr 2024 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215599; cv=none; b=WzuKfDdkt0Si2yL0T54aEsALq0c3LZ1ph6ITSaD4hSeaSRbgA/x959EKopteYYXtDlru/cvcE6+qJuiverCHPIvAbSvEsBkq3nbWo9+Txm2ZyGZqYFEUCvbANi/PBUmxC6GXLbW6hU9Yi2S2L7GUGORO03IlbX43h2RH2l+HGFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215599; c=relaxed/simple;
	bh=bxutVDq3jvxJ2/BdSIG6FsWWr1MXcCJ7bqlpB8XINAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EPNF1LqmaouvcyCwqVzOGwbuUxW+XX6TDqTAmwa44Mc4gQUCBgju/zX899pYDarXTFtWwIiDNrUFBg1DxzUPXuOwztgs5XKGcsjf4mLV93gkDaxOleCsXveRz/YEEyS8GmsIwkqEg+d3dosodgSyxY6L9NUomuVZXD7jRT++dgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzE0cENk; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-516cbf3fe68so416302e87.0;
        Thu, 04 Apr 2024 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712215595; x=1712820395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rO9l67DyNAYztIIepGRa+ILhoMRMSzC35pno11nJTs4=;
        b=bzE0cENkVPTHaMVduANnk10ZVjXgl5RrtNQPaTWcyH1yqQXJZ6Vi3cMCs9tfUNtOx9
         LbiVOaQBfSAgephLysSyK6uE9IEaZPXM+XyAbdCkkIFUZLlDSzh9e4EsKqEVeHr7Iqf/
         jXqOt6JZIRJOvxaHmecXNyJgjLWADBzX6Q/Dh2w8F2t86QdJ2ERXmnC9MYUYqSzUlU2w
         J3FZbUCI+TBBM9BjZMozasmAZse81FPD+o+bG6aGfH8BEWSi0NgYpE/XMQbCt7ffQpB4
         Q8aUN/DcPvxjeozc2OoCig/HXC248jouUU06D7PAH9mSmcVbGPTzexBJNzIKq8JnV1tY
         eiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712215596; x=1712820396;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rO9l67DyNAYztIIepGRa+ILhoMRMSzC35pno11nJTs4=;
        b=DWOn3luZhn38d0cpTRIAR7Xsv0J7x4pEtDY8Srs9WBj87sJWRLK5HiINZn1nuSJVvx
         VWyIZVLnGg9+82g2vOcN1E+RvtgmUA51IdXb66efsroJabRGCxeJmv+YTvCMhAvk/EY8
         uEniWTS2OOp1JCeJuMj1ymzdqBz3f0hgT0k4PSUEX+8S3BonM9+uvMhk8sMYGfmackS1
         5olhaaUTm47ba7WiftRNhrlkA/LJ7/JMdpaYwIm7+OVIAS+DOepBVUi3BMmNavF5W0eX
         8QiEYmz24yHyHovDySkNDaF+4aAG4Z41W9w9M7A/qeuF/KEO277kxrJR7ObZlSIV3gOh
         5Hqg==
X-Forwarded-Encrypted: i=1; AJvYcCWKJ4jMkf3vEgX8gC0St1J+h1T6vtcVTyXYcvZBsypnZIped4SZJDsIFuVfAAcYfZgxPYf6HYqjqHkr9GYxwgXR3N5Lz7tUJknWk6t2cXzDz3+6GKjfSesApLjMw4423b8GHF1ItaYQN049zIdoaCMT6W4dQIUgbgr5pmoXk4L01NRz9Ds5WBt6
X-Gm-Message-State: AOJu0YxfFXDwZ9KXZourg/nhvfg2fHHYHaWQOk1jVj8bo0XJKuxOQLAX
	NZeX+T3E/j2pVfztpJRwE2V+OGPEHgoAIDGFXXM2lmPV1rQQDn0V
X-Google-Smtp-Source: AGHT+IEQ2JydvSdL64tE/FBbnAR2CfEo14JNionxOt6Lp5oV3SUb3i4t/TAxDuT8yuXQyjF5xYMMEw==
X-Received: by 2002:a19:8c1c:0:b0:516:bead:a1b6 with SMTP id o28-20020a198c1c000000b00516beada1b6mr1050955lfd.5.1712215595243;
        Thu, 04 Apr 2024 00:26:35 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 13-20020ac2484d000000b005130ece9099sm2219235lfy.277.2024.04.04.00.26.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 00:26:34 -0700 (PDT)
Message-ID: <f7d454ac-6ecb-4431-a1de-c9b5d1240969@gmail.com>
Date: Thu, 4 Apr 2024 10:26:34 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/6] Support ROHM BD96801 scalable PMIC
Content-Language: en-US, en-GB
To: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1712058690.git.mazziesaccount@gmail.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <cover.1712058690.git.mazziesaccount@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/24 16:07, Matti Vaittinen wrote:
> Another "oddity" is that the PMIC has two physical IRQ lines. When I
> last wrote this patch in 2021 I had some naming collison in debugfs for
> the IRQ domains. Back then I used:
> irq_domain_update_bus_token(intb_domain, DOMAIN_BUS_WIRED);
> to work-around the issue. Now, when rebasing to v6.9-rc1 the naming
> collision was gone and things seemed to work. However, it'd be great if
> the IRQ code in MFD driver was reviewed by greater minds :)

It appears my statement "things seemed to work" is a bit too optimistic. 
I am afraid my approach of having two separate IRQ domains for one 
device (and DT-node) is just somehow fundamentally wrong. It'd be great 
to learn what's the correct "ideology" here.

It appears the naming collision is still there. My config just had the 
CONFIG_GENERIC_IRQ_DEBUGFS disabled. Enabling it shows the same naming 
collison:
debugfs: File 
':ocp:interconnect@48000000:segment@100000:target-module@9c000:i2c@0:pmic@60' 
in directory 'domains' already present!

If I'm not mistaken the debugfs file name is generated from the 
device-tree node path+name. This is a subtle hint that it is not 
expected there are more than 1 IRQ-domain / device. I guess this kind of 
makes sense if we can have more than 1 HWIRQ handled by a single domain 
(I don't recall having to ever write such domain/IRQ-controller before, 
but I think it should be possible).

I have now 3 new questions =)

1. Should we be able to have more than 1 IRQ domain / device?
2. Should regmap_irq support having more than 1 HWIRQ
3. If answer to 1 is "no" - should we protect against this somehow? (see 
why below).

When CONFIG_GENERIC_IRQ_DEBUGFS is disabled, adding the two IRQ 
controllers with own IRQ domains (intb and errb here) to a single device 
is seemingly successful. I see no complaints / errors. Also, most of the 
IRQs seem to work - but not all. In my case trying to issue:

cat /proc/interrupts

will oops. Also, looking in the /sys/kernel/irq/ lists folders for all 
the "intb" and "errb" IRQs - but reading the files contained in these 
directories will cause an oops for all "errb" interrupts except for the 
first 16.

Finally, if I use the
irq_domain_update_bus_token(intb_domain, DOMAIN_BUS_WIRED);

to add "-1" at the end of the "intb" - domain name resulting domains:

:ocp:interconnect@48000000:segment@100000:target-module@9c000:i2c@0:pmic@60
:ocp:interconnect@48000000:segment@100000:target-module@9c000:i2c@0:pmic@60-1

then it seems that reading the IRQ information from the /proc/interrupts 
works as expected. Here I am making a wild guess that the name of the 
domain is used as a key for some data-lookups, and having two domains 
with a same name will either overwrite something or cause wrong domain 
data to be fetched. (This is just guessing for now).

Any tips, hints or thoughts on this?

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


