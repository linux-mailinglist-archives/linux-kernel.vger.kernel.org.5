Return-Path: <linux-kernel+bounces-76267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A948485F4EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 604D51F2137D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6B639876;
	Thu, 22 Feb 2024 09:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pwJMM1Kg"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F123770E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708595200; cv=none; b=Sh7BzBG2pg1bUoLYLLIB4VTd4URDjmop+CxbKq/rLRDXJHoavhaMAk3PxCLxa9XhBU97KVEsRSOwN6piT+IhV27lXMqtrWz0sr13TfUlCk3Qw6rTN6MODwrOwuv9NrR48wppu7wq3pQnL4PNj8sydgpYEYDK5MEGaVpgI80YnPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708595200; c=relaxed/simple;
	bh=bPCV+xnb1Qk+NcS73lqI21dN52imcgJotWmT68p5gz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNbge5Ihg1b2Uv0VLuzAu8ONkin7bnTu4VGFLxO/5H8+W5m6dzTCUMzVYCrB7iK6NrksurN9ump+IYt48YSZYNDN1aZqqgViXhI41z6Rtwsydbic8icafUpK8A8qV+MzNDuS2mIWhq7iggfyWwUf+5Abv+h0XEzrmkgn4XIiRHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pwJMM1Kg; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so7208198276.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708595198; x=1709199998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JrHiV4SbPrNlHGeovFDnwlGAOJlYDpe2wRYcFnz5Qkw=;
        b=pwJMM1Kg351ZaCBT3YrECkJG+hyPYFBHZHDTOpW6+w8TdKKaKoWjQXhgfiQAeqVDtS
         J9vb+bRFaFVPElzAL1rQLjzX6xe6RDsI+UL7EembEkspgS2BZPiKGiSIQviPw/OE2/oZ
         sMJvAYsziXeWepafAgDrugdocNvpbIDQtjixX3rPIR57M76JBg7bfvkvuuUWOymhzP9F
         5pZh2ZlQK53um/05k3+gCqRyCrNlWnSmu70T4Hy8+pxAQCrP6sKDfIoos/+JH5P530Im
         Q0DbOAa13WqEIid/ylG6BjizZGAVEVsb2DzavmRoG4eWzm1BJlPWZ9LipQqmUK6m/WD1
         UOiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708595198; x=1709199998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrHiV4SbPrNlHGeovFDnwlGAOJlYDpe2wRYcFnz5Qkw=;
        b=TUvovur7yHMNK2DenId6w2doSYA72gWNJ+5ryzHOAazME2tCkIWayZVwVVRYGJESGj
         5o0xH8Y+jteaB1vxgwtDUA4zmXXWXwo7wunwM2NrY9dzcUovgI6bAmVCNmrm3nI78eCf
         GNBTLicixxpgjIe3Vwrp0U0zMYEFb++0jdIhkG0VaRk5gYfEPEYHuqIzdRE5QQvQFfCx
         M8a1+/G918KKfJCbVY4pqVJu1rfZndDJwDqRBzaiP1z0qyiaM63kWAQjspdieJQ6X3y7
         AbieKQeU4Ke/wcgxk+Ni/C0hwp0O6gKb4upKLtw4DxsBMXwduIm8nEzDAvhbKFFIfBB7
         XhhA==
X-Forwarded-Encrypted: i=1; AJvYcCWOYM1lgig1sgM7Qa/hOA1d2GRJtuhZfzxyri6hfqFA2WsReSGOp5ZnvRbFPQqpNWc8r5qJXgVo8J9khOpCby8jcklHNGlMHLEB0H9u
X-Gm-Message-State: AOJu0Yw4mBUxCRIyjZW5Eotb8szNKTzOHV9gHvvNssIpKbxcBvX9JV5K
	bc5tfEySJ3wMpQnCYEtYmDLzCO9lah8yIrU3dE34CVqBBfiJQbNlCqi1ddVZWvrJiH6Dm52OJkz
	RFkXsNn9TAFhgjD4ZI2YYCov9D0T7un7yQD0qgQ==
X-Google-Smtp-Source: AGHT+IGEyFWMc/Bnv5N7cDt95kU2F8T66cMEz+jPU0sJPw/x3JWrXvmnu3gbf07WKBKu3lfbVlW8M9QwMg8fyGR6PUA=
X-Received: by 2002:a25:c805:0:b0:dcc:8114:5a54 with SMTP id
 y5-20020a25c805000000b00dcc81145a54mr1737712ybf.43.1708595197808; Thu, 22 Feb
 2024 01:46:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com>
 <20240221-rb3gen2-dp-connector-v1-3-dc0964ef7d96@quicinc.com>
 <CAA8EJpo=9vhM+5YzaFxUoYRuEWQyrMS8wLNPSF3K=bN5JwWyDw@mail.gmail.com>
 <8313a7c3-3ace-4dee-ad27-8f51a06cd58c@linaro.org> <CAA8EJpqFj5nf8d_=Uoup7qg+nQrxqQU-DHbL3uSP138m9AcXLw@mail.gmail.com>
 <8fcb5816-2d59-4e27-ba68-8e0ed6e7d839@linaro.org>
In-Reply-To: <8fcb5816-2d59-4e27-ba68-8e0ed6e7d839@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 11:46:26 +0200
Message-ID: <CAA8EJporaUuddHHqpyYHiYSu=toHmrDxSHf9msZUJoym4Nz72g@mail.gmail.com>
Subject: Re: [PATCH 3/9] arm64: dts: qcom: sc7280: Enable MDP turbo mode
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>, Douglas Anderson <dianders@chromium.org>, 
	Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 11:28, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 2/22/24 10:04, Dmitry Baryshkov wrote:
> > On Thu, 22 Feb 2024 at 10:56, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >>
> >>
> >> On 2/22/24 00:41, Dmitry Baryshkov wrote:
> >>> On Thu, 22 Feb 2024 at 01:19, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
> >>>>
> >>>> The max frequency listed in the DPU opp-table is 506MHz, this is not
> >>>> sufficient to drive a 4k@60 display, resulting in constant underrun.
> >>>>
> >>>> Add the missing MDP_CLK turbo frequency of 608MHz to the opp-table to
> >>>> fix this.
> >>>
> >>> I think we might want to keep this disabled for ChromeOS devices. Doug?
> >>
> >> ChromeOS devices don't get a special SoC
> >
> > But they have the sc7280-chrome-common.dtsi, which might contain a
> > corresponding /delete-node/ .
>
> What does that change? The clock rates are bound to the
> SoC and the effective values are limited by link-frequencies
> or the panel driver.

Preventing the DPU from overheating? Or spending too much power?

-- 
With best wishes
Dmitry

