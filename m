Return-Path: <linux-kernel+bounces-82725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8800B8688BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 436302838F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B91A5339F;
	Tue, 27 Feb 2024 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHjdJZ7X"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0986D52F87;
	Tue, 27 Feb 2024 05:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709012417; cv=none; b=UhpvrrdXKhBuQbkMmR/2lzQD+9TV4iiO1zxFS2jmG9u/sYLHfRoyd7ajrrQO0seJSui60jWXRlt3WXSEa4ziI6g7E+6PbidQk4um7zV2SBZyiCCnG0Tq5N9WBs3qk57aTwAlFqL/Gd7QH+RQHwMVZ47Sx3EVgl7OlNMjWgAIaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709012417; c=relaxed/simple;
	bh=+6eq/f9Tmy106iT9TwTGE+dX/adDfzYQzTvxXDtIyCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovaUSA8X0yAVEAzXTJfRgqWBQLuke7gC1TtmOY1dlwBQ2bFN2P2kUI61JDsxISNgDe6jE1ZiDMZ5WEtj9c5JMqHc3EdJA7ZJSNC/MsorcId6RVSgtTjLf5M1ScyAjB39mMoNogdTqILpPiI8ZDfO0Ug1HnyHJAMTNlfYZWRCBjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHjdJZ7X; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-512e1991237so3206409e87.1;
        Mon, 26 Feb 2024 21:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709012413; x=1709617213; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOQsAxKqGhTJfZZYcKVcf/XQO7LmQkwuY4v0xs+Hoic=;
        b=ZHjdJZ7XweVYLtnIBdTH0sv1zL4GgSqgEYETuP92ovU6T/r4mOiYIknAoQ1wNlVTee
         S6ZsyTCjXS2i0RlkLKyjMOMuJ9jqrF59dT2+LUTDM5G5Ksr6BRYq+Su1e1s/Qe6o3SZB
         TPgC0agvhrR5yltwcmiQVW4Bc0wRzsdeMH5y7Gqs4Xpj8mIPvn6WDgSQ5S90IOnYZrhe
         +hxwjFAEAeSFvqd5pQdRGM4wV8hLVBVq2UzwSr/kV/O//mjF4wLHhuKB5B5gSxhtZYuc
         q4e0r2mvaTm26bqEx0STGFvwD1ZiTK5DuyaRV9GsOjz1yl1saNbWD3yrbzMC37m6Aa5g
         zJ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709012413; x=1709617213;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sOQsAxKqGhTJfZZYcKVcf/XQO7LmQkwuY4v0xs+Hoic=;
        b=hx5jwVWU7hNWjmoG2JPIzezmnaAazRTFtwiqblJCJPQJL3yi4xmsNShS6tInvXBWQC
         95oHfIWAX7pqLjqPQemJ178GODn4cSwFPOgo2ta1D4aHKHr4HzCC+AwtQU0JO/sBCzTL
         tjigGBlhnROp/5sHycXegS8iB/+SK2Q9GRzi/wVTjCVk4lpyioVBGVhZ4OrDNrpAzslj
         4gYZE6pTlHIzOLBkOUnrmRiw4z8RpDbTDtuD2CGCpBfiCMiOBZnCKocxj58Cmass+8Lp
         MWFndhza3swzxUqLdX3x4g5blL759yNgW5PTmXJ6twTe+JCBpggyFmeKsHOHI0q+fzfk
         RNzA==
X-Forwarded-Encrypted: i=1; AJvYcCXf67NOdLVK+VPkQ0ngioGHluOL8Mb5TTCU1Srvte/mSozUA5WQDaah8+oiHRPNpa6s+LsNKnXnRvbYWmqh7hCg1kPrKxIdT1G3EK8B5N8HD2EYzXvlQRG7AeMmVeNblQIYZWUPH8Eo/HP2mkRwfbScichMTfSccm8jV74ptRSoWVZ7MOfOi/lPZvFS0a48wWMUxoclBI65QkakZWRezeZTkYiAiHjZO6I=
X-Gm-Message-State: AOJu0YxGX12LWKvgCaeh6Ovg+4zhGcc2v32fPlS+ayIJ0ZhCVjdF90on
	bpP2CcyStgc9ZqFkwttNSiF7z3rmsBKOzeJAudFWhQHmu2hFz/mmNSN/59z3q99ztdSTmvvX0J7
	8Ko6sZZOn/uABj7rYYnTQEEZ/P5Y=
X-Google-Smtp-Source: AGHT+IHbvFOaaALOTL6UGMbm9bPbdAdKYCZInM58FlSITvmPdjUio+/WwAoWEmUcXcTDW0h35GUZ+2gg6b8WcR30Oig=
X-Received: by 2002:ac2:46cb:0:b0:512:db3c:702f with SMTP id
 p11-20020ac246cb000000b00512db3c702fmr2663203lfo.9.1709012412994; Mon, 26 Feb
 2024 21:40:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240226055615.79195-1-raihan1999ahamed@gmail.com> <170896502279.859050.12118817690939109079.robh@kernel.org>
In-Reply-To: <170896502279.859050.12118817690939109079.robh@kernel.org>
From: Raihan Ahamed <raihan1999ahamed@gmail.com>
Date: Tue, 27 Feb 2024 11:10:01 +0530
Message-ID: <CANt1HJtS-WcdUO3s4+sYSHJffRr_KQ-GQ7FKtbOK560cNu5UyA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: msm8953-lenovo-kuntao: Add initial
 device tree
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-msm@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Rob Herring <robh+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	Bjorn Andersson <andersson@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have checked with latest dtschema before sending version 3, it does
not give anything related to gpu and iommu.

On Mon, Feb 26, 2024 at 10:24=E2=80=AFPM Rob Herring <robh@kernel.org> wrot=
e:
>
>
> On Mon, 26 Feb 2024 11:25:56 +0530, Raihan Ahamed wrote:
> > Lenovo P2 is a handset using the MSM8953 SoC released in 2016
> >
> > Add a device tree for with initial support for:
> >
> > - GPIO keys
> > - SDHCI (internal and external storage)
> > - USB Device Mode
> > - WCNSS (WiFi/BT)
> > - Regulators
> >
> > Signed-off-by: Raihan Ahamed <raihan1999ahamed@gmail.com>
> > ---
> >  arch/arm64/boot/dts/qcom/Makefile             |   1 +
> >  .../boot/dts/qcom/msm8953-lenovo-kuntao.dts   | 240 ++++++++++++++++++
> >  2 files changed, 241 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dts
> >
>
>
> My bot found new DT warnings on the .dts files added or changed in this
> series.
>
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not.
>
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
>
>   pip3 install dtschema --upgrade
>
>
> New warnings running 'make CHECK_DTBS=3Dy qcom/msm8953-lenovo-kuntao.dtb'=
 for 20240226055615.79195-1-raihan1999ahamed@gmail.com:
>
> arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dtb: gpu@1c00000: clock-na=
mes:5: 'anyOf' conditional failed, one must be fixed:
>         'core' was expected
>         'iface' was expected
>         'mem' was expected
>         'mem_iface' was expected
>         'alt_mem_iface' was expected
>         'gfx3d' was expected
>         'rbbmtimer' was expected
>         'rbcpr' was expected
>         from schema $id: http://devicetree.org/schemas/display/msm/gpu.ya=
ml#
> arch/arm64/boot/dts/qcom/msm8953-lenovo-kuntao.dtb: iommu@1c48000: compat=
ible: 'oneOf' conditional failed, one must be fixed:
>         'qcom,msm8953-iommu' is not one of ['qcom,msm8976-iommu']
>         'qcom,msm-iommu-v1' was expected
>         from schema $id: http://devicetree.org/schemas/iommu/qcom,iommu.y=
aml#
>
>
>
>
>

