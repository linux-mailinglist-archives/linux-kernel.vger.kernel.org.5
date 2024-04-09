Return-Path: <linux-kernel+bounces-137103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0628A89DD09
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF18D289517
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F1D130E20;
	Tue,  9 Apr 2024 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIWFznCp"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031008F77;
	Tue,  9 Apr 2024 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673569; cv=none; b=eATvGXoGIU0qY4q7Hr2N6T0gnhXZuDF/hqtFE8PLtuHXCBi8k3xmA96CzKtiGQs/5J/pH6J5SR9gyqTZxdkx7oEVxgtfNy6FcZtXpehiLLdwqI6m3EiRFKsVe6Q+nHpqGleBd2SeyHfoq9xhjD/KJ2Z6W5qwUtqqYam83CYJ9LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673569; c=relaxed/simple;
	bh=VsIhIpo9XbPHMfhPqNlNwCHGDoqMfYE2kWZHJaXVHvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cge/6AJxLzbbwZqo0ynqyX3WzodxoEEZdjrXNlxvA2UB+pN7AsgI3u/2q136Wd4DN3ydIBCKDpTinksQ6SeOF4pL25eZxbiZ0oNGsZHN9xy307IbNKD6vm+EcnfccrNJ/WI8vN+ktUKV2iTxVAv58q3pNEZsRUl8zpu5OT0VSYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIWFznCp; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51381021af1so9200204e87.0;
        Tue, 09 Apr 2024 07:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712673566; x=1713278366; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKneFpmrGWPkDYn40mrK/8lEAAuKeHF1X4WijCDVMIA=;
        b=IIWFznCpURG66mpAy25tpJPS85vue2XNm1N7lv/7WcuI9aaFvn2DvQ1zTYzCkpG3XM
         NbmXUS19evI1OGD3hLtDiJ4GekKbWepD4E//ZDBY8f63zyBuuuiJAjA85O5fS6Nh+h93
         0X8uTW0seg+JSK84T48xAx5+oTtVVQ9ktkKL7MA0zs0mCdduj0EOnYDqojFlGkdU97YL
         jzyFfwY2bUq9/pCNSJ4yxF2tESIB6v/+omBk1c73k2l2Y/KPAIFT+rMeuu+J1jHdRfek
         ptNQz1BhStLU3PUFHQU3BcLWfer+1vvTBaAYFZdLX0Pp57AK9lhXkrDgoccc/7pakJQU
         JTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712673566; x=1713278366;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YKneFpmrGWPkDYn40mrK/8lEAAuKeHF1X4WijCDVMIA=;
        b=UaC5SRR0sDPP6bJIf5qwMgZ5J6lOgV03qTDRqAvPOTBrRpQt757SyO2+Tsp0l2Q5Nn
         LAFPKs9bX5xRYLKO0Rf4CVEWdlcgQW7napLzFyaag4sT+pu4MkmsKcmKzjxOnmDNQRfm
         Ho4r6XXdPiDUrK9SWqSc+dAcmS+LOKWj44ML/T/o0rCBgIRHkjjl7rVmHQ9XYen6N0k8
         FOw0hJoZClryCyWTjQrA3FGbqVVWYoo+FuaP5cG0V527R1NWKfWsFkKbZVFyCuhnVcel
         75btBTnPyTo8DOuB7lA55w0XlJvkSnrRbKH2nGzRalSXp1In7VLil4cKmLAIrP3pbQAI
         cCgw==
X-Forwarded-Encrypted: i=1; AJvYcCUiX0oeuiqPkyUM8KKOjf8mESPaanaRJ1VX5thDmy1JJYO3HiUIPGP3A3D1PB4DAHBs/ujZQ9ioL/oNA0oiNpfqCe4Pt2P+Mn/1XUKcp8kx5W4UFpf7dO+LC/35Oc7rRPscehaFyPluWw==
X-Gm-Message-State: AOJu0Yy+vJimRWCJtLx24UeAz/TTy0aZmZDe4JasVHUq92R4Jac64vnN
	QMO+qJgXAJ+JUFvznQRjkZgZkec5c9S0e5c9WQdeTZbDFSjkva3q
X-Google-Smtp-Source: AGHT+IFNvQ/ssefNKErjmnIGx6yZ1F9nt1Qiw7IcOB3RIUN0vBkaXWO1MGpGc6B7hXDExOz5QM8pow==
X-Received: by 2002:a05:6512:1188:b0:515:af1f:5bad with SMTP id g8-20020a056512118800b00515af1f5badmr12034231lfr.28.1712673565917;
        Tue, 09 Apr 2024 07:39:25 -0700 (PDT)
Received: from ?IPV6:2001:999:588:88e2:b205:90f0:e68f:63c6? ([2001:999:588:88e2:b205:90f0:e68f:63c6])
        by smtp.gmail.com with ESMTPSA id a22-20020a195f56000000b00516d0aecc5esm1594774lfj.141.2024.04.09.07.39.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 07:39:25 -0700 (PDT)
Message-ID: <e15d8d41-c4ad-4cfb-b10a-89e06a4ece11@gmail.com>
Date: Tue, 9 Apr 2024 17:39:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/13] ASoC: ti: davinci-i2s: Add features to McBSP
 driver
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, herve.codina@bootlin.com,
 christophercordahi@nanometrics.ca
References: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
Content-Language: en-US
In-Reply-To: <20240402071213.11671-1-bastien.curutchet@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bastien,

On 02/04/2024 10:12, Bastien Curutchet wrote:
> This series aims to add some features to McBSP driver.
> 
> Convert bindings from .txt to .yaml.
> Add possibility to use an external clock as sample rate generator's
> input.
> Add handling of new formats (TDM, S24_LE, BP_FC).
> Enable the detection of unexpected frame pulses.
> Set the clock free-running mode according to SND_SOC_DAIFMT_[GATED/CONT]
> configuration in DAI format.
> Add ti,T1-framing[tx/rx] properties in DT. They allow to set the data
> delay to two bit-clock periods.
> 
> This has been tested on a platform designed off of the DAVINCI/OMAP-L138
> connected to 3 daisy-chained AD7767. An external clock drives the
> sample rate generator through the CLKS pin.
> The hardware I have only allowed me to test acquisition side of McBSP.
> It is connected to a 6 channels TDM and acts as Bit clock provider and
> Frame clock consumer.

Nice and clean, thank you for the updates!

Acked-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>

PS: sorry for the delay.

> 
> Change log v1 -> v2:
>   PATCH 1 (bindings):
>      * Drop power-domains property's description
>      * Drop the unused label 'mcbsp0' in example
>      * Add <> around each entry of the 'dmas' property
>      * Add 'Reviewed-by: Rob Herring <robh@kernel.org>'
>   PATCH 2 (bindings):
>      * Drop the 'ti,enable-sync-err' flag
>      * Drop the 'ti,disable-free-run' flag
>      * Add 'Reviewed-by: Rob Herring <robh@kernel.org>'
>   PATCH 4:
>      * In probe() use dev_err for fixed error
>   PATCH 7 (TDM):
>      * set playback.max_channels to 128
>      * Add a check on tx_mask as the one done for rx_mask
>      * Allow TDM with BP_FP format
>   PATCH 9:
>      * Detection of unexpected frame pulses is enabled by default
>   PATCH 10:
>      * Free-running mode is selected by the DAI format through
>        SND_SOC_DAIFMT_[CONT/GATED]
>   PATCH 12:
>      * drop the 'ti,drive-dx' property
>      * add 'ti,T1-framing-[rx/tx]' properties
>   PATCH 13:
>      * Drop the drive_dx part
>      * Add support for 'T1 framing' with data delay set to 2 bit-clock
>        periods
> Bastien Curutchet (13):
>   ASoC: dt-bindings: davinci-mcbsp: convert McBSP bindings to yaml
>     schema
>   ASoC: dt-bindings: davinci-mcbsp: Add optional clock
>   ASoC: ti: davinci-i2s: Remove the unused clk_input_pin attribute
>   ASoC: ti: davinci-i2s: Replace dev_err with dev_err_probe
>   ASoC: ti: davinci-i2s: Use external clock to drive sample rate
>     generator
>   ASoC: ti: davinci-i2s: Delete unnecessary assignment
>   ASoC: ti: davinci-i2s: Add TDM support
>   ASoC: ti: davinci-i2s: Add handling of BP_FC format
>   ASoC: ti: davinci-i2s: Enable unexpected frame pulses detection
>   ASoC: ti: davinci-i2s: Link free-run mode to
>     SND_SOC_DAIFMT_[GATED/CONT]
>   ASoC: ti: davinci-i2s: Add S24_LE to supported formats
>   ASoC: dt-bindings: davinci-mcbsp: Add the 'ti,T1-framing-{rx/tx}'
>     flags
>   ASoC: ti: davinci-i2s: Add T1 framing support
> 
>  .../bindings/sound/davinci-mcbsp.txt          |  50 ----
>  .../bindings/sound/davinci-mcbsp.yaml         | 113 +++++++
>  include/linux/platform_data/davinci_asp.h     |  15 -
>  sound/soc/ti/davinci-i2s.c                    | 278 ++++++++++++++----
>  4 files changed, 333 insertions(+), 123 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcbsp.yaml
> 

-- 
Péter

