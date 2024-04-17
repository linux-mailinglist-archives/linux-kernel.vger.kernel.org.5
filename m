Return-Path: <linux-kernel+bounces-149203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FB68A8D21
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6822728B796
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67E4524DB;
	Wed, 17 Apr 2024 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mo2jhAhK"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F217C4EB30
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 20:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386467; cv=none; b=APP3OPx+axEYA6Ir89K9P3oVh38AyVtaSk2eiLrBMltL4Bj5oeR4RC+C+ukn7RbYGE8yyf4OFt4fv+/cII3/4rnkDUiSPg7XRNkV+nZqWu4Sez2Kcrxhel/i6D/OvKfAGSm8MHWkbbpNBYzJZ7cyop8b1Ck22JmZWKs7i18IfoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386467; c=relaxed/simple;
	bh=ITiZ2fpq/HihRXMxMD+fOObCfd7iBh/mgSkX4vJZggY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=E+kMbTQaRqLQJXu7Fhl/1hC4yaX5eoHHimqBk85xvzOrGEsFYX3xQMSsYZIYU5kROCHUaKnRJkv58x3qLvi/4KyISWqiTsXt0rH0soiRYy/9q/X1Q6efo6GKMrVfm0aGBLVO4CQV2DW66DxrH7D+jYNTNxBvgj/qNndsIq8Q9lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mo2jhAhK; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a55323f2ef9so6439366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 13:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713386462; x=1713991262; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RcVoTPuXW+WHmIbLPZ+MXT1yyVJDN45gbEWOWncMp6E=;
        b=mo2jhAhKuLqo9nNDGxiD6wu2fu42rCCq2XAl+eVVCTIMl0G052I4ZLqfqTLyyHArY7
         CGYDjJwr5cIZp+0SICe+3FJhzyvOqg3/UNlwoK0GN1ysojIY1r+YYZlOO8rytQVXYR22
         Uoxxh816CI5IbJ5YnTq4umpb6XhuYFi8triPXAeBJ4Zspw6DB41k+H+HiHY3+SbKZeeI
         SQPYDJKBFp3kSwqhmt/q6oIjGefc8XKvJ35xV+lkEfBbOkCmRRCuxOKVk5+BLHd+b0o+
         n7ZtyFPdlNWfi+pTjX425dVslhhVcXvT4glaZHWMpDlRaEXborDk699qxeFGKHClsSIR
         j56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713386462; x=1713991262;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:cc
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RcVoTPuXW+WHmIbLPZ+MXT1yyVJDN45gbEWOWncMp6E=;
        b=E8nfx2vKnBV2GO46AXxfczua+pTUqC+Jl0itoWYxdrO71/W+yRxwteOVVhkHqh1xOC
         zi+xutBu43szSs7dK6CI+MfTJv22eFV6Z8/Vgo+7K1n1llKrdkWIB0A4NoX32PC+Xh6n
         fV6eZjf/ML65tY/JOvJefj38Zsakx2h0iPA9u8EV9P9HDgBIRALx7HcfQ6gXKwqwwQ8D
         9blNdKI8o3HGO2/1lFHYyWrG9sZVdcDOrs0nQTkS1AmPPSRgImlgOKucu71bXTGm2u9Q
         BH/uEsWDZ6JjgEmRc6NcVqI8otoIDjUvaUP/6SD2cneblntCqOU5BAOlDHM3sd1NBXEi
         C9hw==
X-Forwarded-Encrypted: i=1; AJvYcCUivVusJ5mQp/VzmRpjx5joNI+M8vSZi3udtaDCKCxY3I0uunBWgrZiLjQk562K6v41cw+bDubXNsFel+nA7hFaXzyzkMdEd18S2AfK
X-Gm-Message-State: AOJu0YxV4Axai51nFUNOspd8dh+7c9ilbsVhJC/ex0IYTIeUV3xa5UhG
	pZ20iOb83c/0H9CCN6fGZ6N7VyAzKk/STpcGrHhaHQUk0sz0y9thf+xdP5V/f/U=
X-Google-Smtp-Source: AGHT+IFi6XKPbjhVKyt/GrjH0V0LKXLGUkLoERph9F8lMB5GSwa7YKRSVRyIuDtKGhFSjbvQdag8Hw==
X-Received: by 2002:a17:906:5ac6:b0:a52:2772:b9cb with SMTP id x6-20020a1709065ac600b00a522772b9cbmr362840ejs.24.1713386462247;
        Wed, 17 Apr 2024 13:41:02 -0700 (PDT)
Received: from [192.168.45.55] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id k23-20020a17090627d700b00a556adcf5fbsm19193ejc.116.2024.04.17.13.40.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 13:41:00 -0700 (PDT)
Message-ID: <c5e9e2a4-5506-4cce-b218-ec9a5baff40a@linaro.org>
Date: Wed, 17 Apr 2024 22:40:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] ASoC: codecs: wcd937x: add wcd937x codec driver
To: Prasad Kumpatla <quic_pkumpatl@quicinc.com>
References: <20240416063600.309747-3-quic_mohs@quicinc.com>
Content-Language: en-US
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Jaroslav Kysela <perex@perex.cz>, Banajit Goswami <bgoswami@quicinc.com>,
 quic_rohkumar@quicinc.com, Takashi Iwai <tiwai@suse.com>,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 Trilok Soni <quic_tsoni@quicinc.com>,
 Bjorn Andersson <quic_bjorande@quicinc.com>,
 Alex Elder <alex.elder@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240416063600.309747-3-quic_mohs@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16.04.2024 8:35 AM, Prasad Kumpatla wrote:
> This patch adds basic SoundWire codec driver to support for
> WCD937X TX and RX devices.
> 
> WCD937x has Multi Button Headset Control hardware to support Headset
> insertion, type detection, 8 headset buttons detection, Over Current
> detection and Impedence measurements.
> This patch adds support for this using wcd-mbhc apis.
> ---
>  sound/soc/codecs/wcd937x.c | 1583 ++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/wcd937x.h |  617 ++++++++++++++
>  2 files changed, 2200 insertions(+)
>  create mode 100644 sound/soc/codecs/wcd937x.c
>  create mode 100644 sound/soc/codecs/wcd937x.h
> 
> diff --git a/sound/soc/codecs/wcd937x.c b/sound/soc/codecs/wcd937x.c
> new file mode 100644
> index 000000000000..d29cb56630c7
> --- /dev/null
> +++ b/sound/soc/codecs/wcd937x.c
> @@ -0,0 +1,1583 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) 2023-2024 Qualcomm Innovation Center, Inc. All rights reserved.

Well this is pretty disappointing

This is clearly built upon my commit [1] (which itself is built upon QC
downstream, for which it retains the QuIC copyright), which can be seen
e.g. in the funny bitwise ORing in wcd937x_set_micbias_data or the
precise comments/function ordering..

Please at least include the Linaro copyright.

Konrad

[1] https://git.codelinaro.org/konrad.dybcio/linux/-/commit/a62f9c6fc53d4249e9de57898821e5ca4d2e7ca2

