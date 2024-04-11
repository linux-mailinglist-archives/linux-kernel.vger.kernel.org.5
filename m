Return-Path: <linux-kernel+bounces-140596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E668A16AC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D2228A813
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0971314F109;
	Thu, 11 Apr 2024 14:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ReeX4tDP"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D6F14E2F6
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844319; cv=none; b=pfdNm9tXwr8dWKB06zLwAy+pMB4QRG5ObcJfZ/Sgo4NDbJo7WSiCDoftUyhaLtnD1ZGXm7Wpv9wgZbudWNrHUpd+TrB4FIvixH9ZfQb03YfqCjQ+uDeFqsjJb/D0qaZTt7cZkHw4hg6YziZ0mWaovjgmkLxxEtuZqJh1EhThtWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844319; c=relaxed/simple;
	bh=Lx9cFcGpfk6s0y7+78RGZ89/Xxwo/ujlfeLUyEjs1Us=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0ZAkdbR0x0+ryu9asCmvCv7cXsRRxXjWmA07wIS7LUwhUOOyF3QDcrll6ZpySShtGLyiWMvZZu1cOsRGhh50mhqfvwKHrNh7ez33CzSsNwxkCFkXu9IdKU4xYpR7E0sSH6WiucV+AEizfA+loleUmw6T/unw6dFcL25Hf30yb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ReeX4tDP; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc73148611so8425560276.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 07:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712844315; x=1713449115; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LdvAFQAqIyq8uAjQoCwRGvy8hAscGhG76lHWAd3Yfhc=;
        b=ReeX4tDPzLABnC5mcZ6qtfjWCWyG3xMukwMRg+cRwfPmhedtV5QKkpL/upDPMRjvZF
         KbspDAp9H4jnfz38f8JFm8c40evccJzO+z8sApEcDFadyuIQ+Yi365wpCtR8ppJtgTix
         Lc0CcgDbyGIjCteYIpH5jWWZftxgykDLQggsqLHGq/hdkGB4XryYDJ9d4BNbVTWvz6wm
         C+bcf9Ge1gM6UOgW0sAA9tQOTnpKUBx8V2gEV4PoVLHXldO0+FolCAnzajfG+WIkI82q
         LuANQBX1aZ6BydNkbg2aABFVY6kO66o8GE3rOlmaQMOmAWdkX1k2R3bH6NcchJeThv1I
         bA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712844315; x=1713449115;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LdvAFQAqIyq8uAjQoCwRGvy8hAscGhG76lHWAd3Yfhc=;
        b=GkTm71VAwqe46B5E//ubaoWGV+uDfd9f6RapKNrXLbx1mBR/vYbs0S5doQE+uc8Ib+
         2W5NDeOt7t9NPND5cy6GDAANb6Na2ugRXVWT27okV80zTIrzSr8Xg/dyGwZWZw6emAGy
         KFjUSNpdC+CodgTt21bzV4J7GUNY7Nd/cqDsNOXf119C2ZArgD2za1oBj9StrWMwSX3V
         UnA2xPkd2g2ll0dMcLXbCYCk9YK6B2aylG7XRLLG6yTS/uv74SsqDQxIbeTufsLWikY+
         5w4CIw8OckWugo5gmUyG0Buh0TSvQmszLYviAKS1yn6eU8PRXzv6ULgOxroxWkpIakN+
         mL8A==
X-Forwarded-Encrypted: i=1; AJvYcCXkKKv0zipcho2AL+Q62qi6QYIgus/I1AgW/EbhC8BOiLdsjj3KETh2fC7DUL1c4GViSqw6iALRkmEozrqrVDKOspeV4mGkiyVNqpf5
X-Gm-Message-State: AOJu0YxN4YoV++lZTeUoZngVuXKZY01X9XovltJut11mxJCwHDdhOd4k
	ea+gKBSX8+DGpOSwhixtxelMU1ugEyGxLAemEXfrToToPPH385AmKte9QnB4JwmGChSqkoHAAEf
	KgscfbfM2MWM7AF5JHdvoGUC9libT6QMqe7x10w==
X-Google-Smtp-Source: AGHT+IEOP+y/Kkxt5waPfyW4BPcwQRgGo/wmVHJAZNTDym7NMYEkurssf0E0z3mRp6tY+g+sbEKMhK0YiGqkPhL1aB4=
X-Received: by 2002:a25:8403:0:b0:dcc:fea7:7f7b with SMTP id
 u3-20020a258403000000b00dccfea77f7bmr5635176ybk.11.1712844313731; Thu, 11 Apr
 2024 07:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com>
 <20240411-pm8xxx-vibrator-new-design-v9-2-7bf56cb92b28@quicinc.com>
 <CAA8EJpoL9vCAUgWmHcoxppo_gJqaw_xqdYqcJkS6Xza-5aSh3A@mail.gmail.com> <fa6c8b30-11f3-bd80-67cb-713e4348eccf@quicinc.com>
In-Reply-To: <fa6c8b30-11f3-bd80-67cb-713e4348eccf@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 11 Apr 2024 17:05:01 +0300
Message-ID: <CAA8EJpqa=5yaTRHuEiYynTDFy53YPFk4R3q_EV8rmsBN1iR5fA@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] input: pm8xxx-vibrator: refactor to support new
 SPMI vibrator
To: Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: kernel@quicinc.com, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Apr 2024 at 16:45, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
>
>
>
> On 2024/4/11 18:58, Dmitry Baryshkov wrote:
> > On Thu, 11 Apr 2024 at 11:32, Fenglin Wu via B4 Relay
> > <devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
> >>
> >> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> >>
> >> Currently, vibrator control register addresses are hard coded,
> >> including the base address and offsets, it's not flexible to
> >> support new SPMI vibrator module which is usually included in
> >> different PMICs with different base address. Refactor it by using
> >> the base address defined in devicetree.
> >>
> >> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> >> ---
> >>   drivers/input/misc/pm8xxx-vibrator.c | 42 ++++++++++++++++++++++++------------
> >>   1 file changed, 28 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
> >> index 89f0f1c810d8..2959edca8eb9 100644
> >> --- a/drivers/input/misc/pm8xxx-vibrator.c
> >> +++ b/drivers/input/misc/pm8xxx-vibrator.c
> >> @@ -20,26 +20,26 @@
> >>   #define MAX_FF_SPEED           0xff
> >>
> >>   struct pm8xxx_regs {
> >> -       unsigned int enable_addr;
> >> +       unsigned int enable_offset;
> >>          unsigned int enable_mask;
> >>
> >> -       unsigned int drv_addr;
> >> +       unsigned int drv_offset;
> >>          unsigned int drv_mask;
> >>          unsigned int drv_shift;
> >>          unsigned int drv_en_manual_mask;
> >>   };
> >>
> >>   static const struct pm8xxx_regs pm8058_regs = {
> >> -       .drv_addr = 0x4A,
> >> +       .drv_offset = 0x4A,
> >
> > If the DT already has reg = <0x4a> and you add drv_offset = 0x4a,
> > which register will be used by the driver?
> >
> > Also, while we are at it, please downcase all the hex numbers that you
> > are touching.
> >
> For SSBI vibrator, the "reg" value defined in DT is not used, see below.
>
>
> >>          .drv_mask = 0xf8,
> >>          .drv_shift = 3,
> >>          .drv_en_manual_mask = 0xfc,
> >>   };
> >>
> >>   static struct pm8xxx_regs pm8916_regs = {
> >> -       .enable_addr = 0xc046,
> >> +       .enable_offset = 0x46,
>
> [...]
>
> >> @@ -170,7 +173,7 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
> >>          struct pm8xxx_vib *vib;
> >>          struct input_dev *input_dev;
> >>          int error;
> >> -       unsigned int val;
> >> +       unsigned int val, reg_base = 0;
> >>          const struct pm8xxx_regs *regs;
> >>
> >>          vib = devm_kzalloc(&pdev->dev, sizeof(*vib), GFP_KERNEL);
> >> @@ -190,13 +193,24 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
> >>
> >>          regs = of_device_get_match_data(&pdev->dev);
> >>
> >> +       if (regs->enable_offset != 0) {
> >> +               error = fwnode_property_read_u32(pdev->dev.fwnode, "reg", &reg_base);
> >> +               if (error < 0) {
> >> +                       dev_err(&pdev->dev, "Failed to read reg address, rc=%d\n", error);
> >> +                       return error;
> >> +               }
> >> +       }
> >> +
> >> +       vib->enable_addr = reg_base + regs->enable_offset;
> >> +       vib->drv_addr = reg_base + regs->drv_offset;
>
> The reg_base is initialized as 0 and it is assigned as the "reg" value
> defined in DT only for SPMI vibrators.

Please don't. This is counterintuitive. We have reg in DT. We should
be using it.

>
> >> +
> >>          /* operate in manual mode */
> >> -       error = regmap_read(vib->regmap, regs->drv_addr, &val);
> >> +       error = regmap_read(vib->regmap, vib->drv_addr, &val);
> >>          if (error < 0)
> >>                  return error;
> >>
> >>          val &= regs->drv_en_manual_mask;
> >> -       error = regmap_write(vib->regmap, regs->drv_addr, val);
> >> +       error = regmap_write(vib->regmap, vib->drv_addr, val);
> >>          if (error < 0)
> >>                  return error;
> >>
> >>
> >> --
> >> 2.25.1
> >>
> >>
> >
> >



-- 
With best wishes
Dmitry

