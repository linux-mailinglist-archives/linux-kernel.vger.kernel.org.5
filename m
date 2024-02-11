Return-Path: <linux-kernel+bounces-60800-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D29485099E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9797BB21453
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2494B5B660;
	Sun, 11 Feb 2024 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="moKGnYEF"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBBD5B5C5;
	Sun, 11 Feb 2024 14:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707661465; cv=none; b=A99yeAJw/U6diWMzhvzLsrIjgiVXI+puHPAurc93DiKGATi0Wj6oa3Xogv8F2vXpimfxsD8WLMQX8X5rI4fpDr45+5fuptnHS1sT8+j0ppq2hrAv0kOAOT/z6xuX8LCB2NxJFm1F6t9H8r2LJ75lQkmkjXQnNMKe6CbgZVpcI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707661465; c=relaxed/simple;
	bh=Tb95ezS1kuQ7AfOb9cS+P5DRUsMOemO7Zw6de/TuQY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjm0ue6vwKVW7UJxom5mPih3cwAGM6h2KnLIBiXey26wIWc0yIVzeySO2S0kea6bNgdtUXC7oMmqdjgYUGfWd6MBCdy/h1S6KQMpHEFhhUDnOylKvfrcFo8TGxUL1KXhrCUs3V+pRbHldOT/oDjFtYSTBfce8BCh5wJc7+zbEpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=moKGnYEF; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51178bbb5d9so2011121e87.2;
        Sun, 11 Feb 2024 06:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707661461; x=1708266261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GCAOLl3pei0rSyoGXtik0PziUaBSCc9hClSrM+7S6s4=;
        b=moKGnYEFaLgP2jZUJ2dI66M2POTQuyiqA0zZalcHtcn74I1nUNI7gpVz0FvPdI/GYS
         SOmGicCghRWdfHd4llKFUpfemzyd8PP3ExuWDxay9gLMSOBiTq4w3Rm9inkJXKiRyt1m
         sP8rQg4AXCfqHT5J72Ss+YZ9AVDkkgwVLqd3Sp1IfD0rkSaldpRfTpON+ZV8hvEQe4Jg
         2DdsPbzeYSSFr/824pCtJOcgxsBLOLZbH99hSulTzQNOzhvDD4XDafhme72HP8irOIyA
         2YyhzOGwzQlBlKlusPv/hI5BftQmLklHMpRbrYu8AEpNcZ/6jdhkA17H8mvAGekzF53i
         T7IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707661461; x=1708266261;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCAOLl3pei0rSyoGXtik0PziUaBSCc9hClSrM+7S6s4=;
        b=AWv5zPmJ8/Iq9apnU2Ndh/fv8vZxbqSvTzhPIRNF2/sa/IpqG67J1HcGk3raeuwEOp
         E4pP0PEhJhYpjUtXpatG+e5BOjKaSTnry2cd94bWbeD8ZgYbxwrhLSlu8JypVRZtMt/P
         pgDTazWNMjXvAkobCawVooBmw0rO76dkQL1Ba6bRD3fjxKnfdOymSHUy21e+k0U9FzbJ
         m8+8ZmqpkKxHF5I+zUEDMTqTC+nHslxqx305LlVCrI7C8GXTg/iv94LWJTUC7khs5Tzk
         ZycPTEPSxvVi2Le97PHPxmJ/2KPU/xDI26jsXIEpYJNd4HX+QwWp9Fo9sr4jo8xpQyRY
         ZUWA==
X-Forwarded-Encrypted: i=1; AJvYcCUGxMpklfN7saXr5F0GI4flyHRUkZ9P635jk4swTsi05LTVoLSeLJ2DUkP9CuSJdagW8Fc1Vscmk/TgsFgh6s6cxuibA26hnOkbKdgSGWk2utB5+j8xUPcgokf8TWX6adK5fg4SXVCJLw==
X-Gm-Message-State: AOJu0YxeDFN7GyZ4jVX9kHQoTBFs+SpwTu5AFUiwAt9r2XVxc4SN60Fv
	MggQBEz2CspsTWhXx8wtyy/+ExkzVFrobkttSoW21yVY5x7WhI/T
X-Google-Smtp-Source: AGHT+IHZpUJzzYsh4gKWkK7ZJHSVvy0xwkNJvI45AqT/LzplWFW3ITpDHyQyraOqk+co4xr+fdoUQQ==
X-Received: by 2002:a05:6512:2101:b0:511:31b4:ac16 with SMTP id q1-20020a056512210100b0051131b4ac16mr2642019lfr.47.1707661460349;
        Sun, 11 Feb 2024 06:24:20 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUyuas5J8CkYG9BE8O92OW7jFT2z/udTl3RiHKENMJiWoCinJ0gPn5XNXNC7qpby9Odovk2GJvJ3BLydrUUwOXp1A49uSqhIhFuebACfzNuuTnlZ4MNIggb9nFyFryjSu534so0x1Li9zdChHh0xfc1olyM9S1enIvdpH0AjPXRxJesD/7yM0aGbPdPiFjd5WdckVAb7TLdxua7URCZS2wcJYgjWGds8mFihcj+w/su8iPWctN9cnTKZ2pDzZZ6/dECXbU+A7+hR6OSugzG35J/N3Wpu9JZS/cQAo9WYBVrMVAathTcpb11015pfSs6fyoInx8JuQmuj/iycXFYGDcX8HtAFT5nrK3OlQz/kGcAWM2cBpQ6k6uCV9sGaTaaZlrFqwIeC8qhcfQ3Q1MAztw04gLEztxsI/qUc2tEgUIMYG/JyhOWdZOI/Ef9vMLjdH6W283YrI5Pg0Rubip+RPR7hGXkt9yjtTTwqRI3CLckRJlDLDa+
Received: from localhost ([2a05:3580:f312:6c01:1b8f:2a1b:d18:1951])
        by smtp.gmail.com with ESMTPSA id v8-20020a056512348800b005114e5d3515sm537766lfr.96.2024.02.11.06.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 06:24:19 -0800 (PST)
Date: Sun, 11 Feb 2024 17:24:19 +0300
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Add thermal trip points for
 GPU
Message-ID: <ZcjYk8MD4jotKNcq@skv.local>
Mail-Followup-To: Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Andre Przywara <andre.przywara@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Alexey Klimov <alexey.klimov@linaro.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20240211105326.506049-1-andrej.skvortzov@gmail.com>
 <20240211125209.15d58462@minigeek.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240211125209.15d58462@minigeek.lan>

Hi Andre,

On 24-02-11 12:52, Andre Przywara wrote:
> On Sun, 11 Feb 2024 13:53:26 +0300
> Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:
> 
> Hi Andrey,
> 
> > From: Alexey Klimov <alexey.klimov@linaro.org>
> > 
> > Without trip points for GPU, the following errors are printed in the
> > dmesg log and the sun8i-thermal driver fails to load:
> 
> So how does that post differ from Alexey one's a few weeks back:
> https://lore.kernel.org/linux-arm-kernel/20240101000008.65747-1-alexey.klimov@linaro.org/
> It seems like the same patch?

Yes, it's the same patch. I've added only information about failed
dtbs_check errors in already supported boards to commit message.
I've found this patch from June 2023 without any feedback. [1] Since I've
worked on dts changes for PinePhone A64, I've decided to resend
it. Sorry, I wasn't aware that Alexey resent it in the mean time. It's
better to continue discussion in original Alexey's patch.

> And Jernej and I had some comments (no mentioning of "Linux" in commit
> message, add cooling maps, source of trip temperature values), can you
> please try to address them?
> 
> 
> > thermal_sys: Failed to find 'trips' node
> > thermal_sys: Failed to find trip points for thermal-sensor id=1
> > sun8i-thermal: probe of 1c25000.thermal-sensor failed with error -22
> 
> I think it's pretty obvious that the trip points are missing when they
> shouldn't, so this does not need too much explanation or rationale in
> the commit message, so you can cut this short.
> 
> > When thermal zones are defined, trip points definitions are mandatory.
> > Trip values for the GPU are assumed to be the same values as the CPU
> > ones. The available specs do not provide any hints about thermal regimes
> > for the GPU and it seems GPU is implemented on the same die as the CPU.
> > 
> > 'make dtbs_check' complains about problem in dts for 18 A64-based boards
> > supported by the kernel:
> > 
> > sun50i-a64-pine64.dtb: thermal-zones: gpu0-thermal: 'trips' is a required property
> > 	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
> > sun50i-a64-pine64.dtb: thermal-zones: gpu1-thermal: 'trips' is a required property
> > 	from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
> > 
> > Tested on Pine a64+ and PinePhone 1.2.
> > 
> > Cc: Samuel Holland <samuel@sholland.org>
> > Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> > Tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> 
> You would need your Signed-off-by: here, since you send this, even when
> on Alexey's behalf.
> 
> Cheers,
> Andre
>

1.  https://lkml.org/lkml/2023/6/4/416

-- 
Best regards,
Andrey Skvortsov

