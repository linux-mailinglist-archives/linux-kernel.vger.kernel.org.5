Return-Path: <linux-kernel+bounces-85846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AA286BC2A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6458C1F2612C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4423FB97;
	Wed, 28 Feb 2024 23:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K7HSEoza"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECE913D314
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162818; cv=none; b=ubNTVh1o6QMs8SgQdU4VJJRBTvdpfgsvpDnHqqo1grPnFjs5lDlwmXaDMjAM/fTqusl8sDOfrDiXb3o9AfJ+rG2uJmXmvhVnpcO/wNwoZ2j2UBWpKqROlvfRiKCJQJOITk7MrgDnnjfsCo0V3SBqeV98IGTwHrfWO5MC9boq+YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162818; c=relaxed/simple;
	bh=8FTj6Koa44+7wIfYWJIPoAle8PfST8SPtRF2sQxL16I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mcHGsgNS9dgc596VNBxM2YGyz0ingSgPe7iq/MkQ7QBUb4aeTLsgcuHVnKYtKlHfeh8441XCoFvkZSF0AFkxsS2XTUVOqbrHZkA1Yi7U5jzxeqTiqbKUoQzWGxrUZVpYb8EDPaSK9KrxiacIgPUBm9Mz685TbLzytpNKHMD8gPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K7HSEoza; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512e4f4e463so170881e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709162815; x=1709767615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7eYiCisy9EvDzPpdsA8EnqFrzrb2WGQGdFzfYxWz3OE=;
        b=K7HSEoza7DCdIqrcWgXXP62YbQCQYuMTXvgq7CHcNaOta4aWB5IYuuPC4ZTd00TQIC
         dDRItLh2fANircRuUuzCH1UrwlY9WjWUkYNIifpwhQpZaSCv3QvyOjOFE9UCNApaduLt
         CdW+mGt3xCIKGv0rTlSKBJBDIehivzbzwHRLyo4oebRX1cs49wR2n6HOLU4FkmyciG6z
         1TUR+xNX++n69zJfmA2NwhWLV8fJkRy8wmSK/Feeme5DN6K0hzbi73TfyBdqJLngT4yn
         FhMoJWm4kvhic9OJBIgQUnC7VIrKHWDadTbXx+K1t2jyR42CznPlLgT0h+P8q7ZmuyiL
         VHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162815; x=1709767615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eYiCisy9EvDzPpdsA8EnqFrzrb2WGQGdFzfYxWz3OE=;
        b=Acrkp3hNO0XENie20RT1FqhHhze+IhZemdJj8i+ktWTgRsRRvQUeLzPdkbzeGe23Te
         sYLywA0v3pZOsoV3p/SQT9JUiGyYWIacas/I14Sl7DVrSUj/BIJ8Uan61oI8LuZI/SlG
         NUfo+N/ws3v/2vpP6UHQeTWCwSfKEsI3O0zAu2ZDHKskEtcSqtJ82n2aSeU7Ady0GUCV
         7pCjHVdEo/4drWgFuzaxwJLrcpFqXdUs0aeojHCDjHUfiW5O3xLM6cnf7Mc/3eI92SNr
         joDN4tjMpTG/JEJhq3IP1m2u7O8h18OROsd7qkvEWiZeRJwnDEaofOwALOw60HYJ+Tu3
         a+6w==
X-Gm-Message-State: AOJu0YwLSA81FQ5RjexOoOy71G6SWIQUcy8b1IlEWM09jIYS0cw5keOr
	NxxrmYFREqKJLDleOC48sZHov+BDdtZuQ7JfzTzGFvrR9Ge4/V/2RP7Hg8pMg/g=
X-Google-Smtp-Source: AGHT+IEauPA8YU76AZ2HWn9YzhqJSaQh/sxY5dBOq9kCUqmFc1a7D67zChdJwrqxqulBHP/Mq3mKqg==
X-Received: by 2002:a05:6512:34d3:b0:512:f6a0:1311 with SMTP id w19-20020a05651234d300b00512f6a01311mr236650lfr.47.1709162815082;
        Wed, 28 Feb 2024 15:26:55 -0800 (PST)
Received: from [172.30.205.146] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id j10-20020a056512028a00b00512dec300dcsm28686lfp.2.2024.02.28.15.26.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Feb 2024 15:26:54 -0800 (PST)
Message-ID: <c25aa425-f350-4ad2-b92e-67de996daed3@linaro.org>
Date: Thu, 29 Feb 2024 00:26:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: pmic_glink_altmode: Use common error handling
 code in pmic_glink_altmode_probe()
To: Markus Elfring <Markus.Elfring@web.de>, linux-arm-msm@vger.kernel.org,
 kernel-janitors@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Johan Hovold <johan+linaro@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Clark <robdclark@gmail.com>,
 Robert Foss <rfoss@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Peter Zijlstra <peterz@infradead.org>
References: <29b63eb4-2342-4ca8-a313-5de2a6ec6a83@web.de>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <29b63eb4-2342-4ca8-a313-5de2a6ec6a83@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/28/24 19:05, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 28 Feb 2024 18:45:13 +0100
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function implementation.
> 
> This issue was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---

(+CC Peter)

Hmm.. this looks very similar to the problem that __free solves
with <linux/cleanup.h>..

I know no better, but wouldn't the same mechanism, down to the
usage of DEFINE_FREE work fine for _put-like functions?

Konrad

