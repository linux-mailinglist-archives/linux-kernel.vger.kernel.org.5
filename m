Return-Path: <linux-kernel+bounces-142592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3668A2D91
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E5C1F212C2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCDE54BF9;
	Fri, 12 Apr 2024 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywI3ZrIz"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0EB54F87
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 11:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712921760; cv=none; b=p+uc8809TMKX+U9N2nl2sMemHqF0ux1GPJ592CRdIhOrMpMsvoVhH/+acwKQwVVX5xreCnR4s+MA8uUOXbX8mw5b2KJyJpx4DRPbb2YHjYKYjEPPvk6B39hS3aUOuvl5NgkFlyDK4dhEKzplG173OOxLKzTjrbHiRdgxAPJVe1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712921760; c=relaxed/simple;
	bh=NJF9N4arR9462Jsp+bJZ0yQrDcj61RvYHjkyBCMqT78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dH7yvRtPNSkqKE31d8b3boSe1aAzIcwfaXJY2SQDTsuLBn+NZC9HVniRCDAQD1VEaTv5XZwtYNvQ6zD/owvvdNKApnNFL/Iqk1UsQe0KrL6ovSE6yNrHYbxlgTsNJLzGkKi8sLfoR+i/nnVUPXlAgkvB8AyVQUQPItLCYR4SxtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ywI3ZrIz; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dd10ebcd702so797476276.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712921758; x=1713526558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eoi9o7ixA5Pm/ONJhdvvFOJW2mpeRIaiK/Xo8GdOqnQ=;
        b=ywI3ZrIz1QUguIzjOdPx6Rs0id8625Y++seD8Mutf+QS7AHoNnK2164VBDLPaDW23r
         r4H86v3Qvq1uLP5xss27q6LJ78mt9rMkHNgsDR/dZ8as7Wb0QKxcfR1TWcoUsdhiO5wl
         1MrGQL/M7d8xu23XcEDloU+i9G6ATLZ7puMhFmtFv9NGG1SJM3q/0uXmC7/PRFBFnKvY
         kue473l04eXtA7oTcn/ahwsakhFP9HTtANsDTh0GZnnKcXg+pGYEzk2q3V5LLS9fKR1E
         pmTJ6e95OMMTGO9M1vNGxjJAymUSOFhj4C6p5xhr/cd/ncubJ4vGJvtYUQbdaN/tK/Tg
         93hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712921758; x=1713526558;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eoi9o7ixA5Pm/ONJhdvvFOJW2mpeRIaiK/Xo8GdOqnQ=;
        b=M/mqqzi1K14AdsPHIPwWqpMbxGZV7yV6E0GZGGm0o+YjlO/FuMTAaBMHr08U1pTG+l
         jtLeYexMEP+eY3vpHK+dJNyhDVJSEP+z0S4t7uXHfG8Yu0LqPy6HDQMhENg8YDxNsavB
         wcMKhYL0Q2llBHG5ja+vjCLji/X9RZIRLO+V+I9eQh+XjNWMZbQM0vSMyQaZqG9ZAPgd
         xP/PdytBGIwy+QmGUBrmDQoPaAbLuUNA2xljnpOm4VQN8pL/wSdoGu6NlJwM005ihS9H
         nxEOeW0z1JT02G5a/LmR8nd5rkkaCfg73qvyLomXdg0wMB6YXaukScHHfbh47gSkP0JM
         obJg==
X-Forwarded-Encrypted: i=1; AJvYcCVqAqSh/BHAvLEWbEVWfJyiDyPVoLL8vaC5DeWgTQXa9Hk70eU8tTOY4ZUqgMNXS57utjTgymC1Qc/hifhnOazlxqc+M3Yi3uka6B2z
X-Gm-Message-State: AOJu0YxBcJXOeAMAUmO93aqh6jCgLz9bobVXv8Lv3qF1AePuSgoJs1kM
	WuUW2EBOOLKWpW8UX8d0igH96uXN2qF3FFEf8W9h6vmfpZX8SdqEVwW/Pm5hvNfNjUgdj/ZVUZr
	AnxwW2gX5gXrFfc6pP16ktuhc0BqwcPnC1gGNPg==
X-Google-Smtp-Source: AGHT+IGQA5NucnqxXQywOYE6z8CWOtmRY95fpQ3qkM3KXKr1Pc2aGN+8hWc+fqmN/ggp9dUCxqTQvK3kQVxgatjzfgk=
X-Received: by 2002:a05:6902:307:b0:dc7:5a73:184e with SMTP id
 b7-20020a056902030700b00dc75a73184emr2229795ybs.14.1712921757947; Fri, 12 Apr
 2024 04:35:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com>
 <20240411-pm8xxx-vibrator-new-design-v9-4-7bf56cb92b28@quicinc.com>
 <CAA8EJprJ4s-o1uPiPjRpq4nwG4cdV7K8XMhVLOQn2D=kJLiVzQ@mail.gmail.com>
 <c2ee9ab0-ecb2-aba2-2cc9-653f74d27396@quicinc.com> <CAA8EJppJOQ+-XtgJZa01uqYdqXJdfNznR1OUbWua_myzUqNBUA@mail.gmail.com>
 <633c4f8c-c22c-4128-b478-0627da8660bd@quicinc.com>
In-Reply-To: <633c4f8c-c22c-4128-b478-0627da8660bd@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 12 Apr 2024 14:35:50 +0300
Message-ID: <CAA8EJpp=K11+U=FeMhscaRAG1k_Zo39faw8JGerdgGj67MhJmw@mail.gmail.com>
Subject: Re: [PATCH v9 4/4] input: pm8xxx-vibrator: add new SPMI vibrator support
To: Fenglin Wu <quic_fenglinw@quicinc.com>
Cc: kernel@quicinc.com, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Apr 2024 at 07:05, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
>
>
>
> On 4/11/2024 10:21 PM, Dmitry Baryshkov wrote:
> > On Thu, 11 Apr 2024 at 16:51, Fenglin Wu <quic_fenglinw@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 2024/4/11 19:02, Dmitry Baryshkov wrote:
> >>> On Thu, 11 Apr 2024 at 11:32, Fenglin Wu via B4 Relay
> >>> <devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
> >>>>
> >>>> From: Fenglin Wu <quic_fenglinw@quicinc.com>
> >>>>
> >>>> Add support for a new SPMI vibrator module which is very similar
> >>>> to the vibrator module inside PM8916 but has a finer drive voltage
> >>>> step and different output voltage range, its drive level control
> >>>> is expanded across 2 registers. The vibrator module can be found
> >>>> in following Qualcomm PMICs: PMI632, PM7250B, PM7325B, PM7550BA.
> >>>>
> >>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> >>>> ---
> >>>>    drivers/input/misc/pm8xxx-vibrator.c | 51 +++++++++++++++++++++++++++++-------
> >>>>    1 file changed, 42 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
> >>>> index 2959edca8eb9..35bb6f450fd2 100644
> >>>> --- a/drivers/input/misc/pm8xxx-vibrator.c
> >>>> +++ b/drivers/input/misc/pm8xxx-vibrator.c
> >>>> @@ -12,10 +12,10 @@
> >>>>    #include <linux/regmap.h>
> >>>>    #include <linux/slab.h>
> >>>>
> >>>> -#define VIB_MAX_LEVEL_mV       (3100)
> >>>> -#define VIB_MIN_LEVEL_mV       (1200)
> >>>> -#define VIB_PER_STEP_mV        (100)
> >>>> -#define VIB_MAX_LEVELS         (VIB_MAX_LEVEL_mV - VIB_MIN_LEVEL_mV + VIB_PER_STEP_mV)
> >>>> +#define VIB_MAX_LEVEL_mV(vib)  (vib->drv2_addr ? 3544 : 3100)
> >>>> +#define VIB_MIN_LEVEL_mV(vib)  (vib->drv2_addr ? 1504 : 1200)
> >>>> +#define VIB_PER_STEP_mV(vib)   (vib->drv2_addr ? 8 : 100)
> >>>> +#define VIB_MAX_LEVELS(vib)    (VIB_MAX_LEVEL_mV(vib) - VIB_MIN_LEVEL_mV(vib) + VIB_PER_STEP_mV(vib))
> >>>>
> >>>>    #define MAX_FF_SPEED           0xff
> >>>>
> >>>> @@ -26,6 +26,9 @@ struct pm8xxx_regs {
> >>>>           unsigned int drv_offset;
> >>>>           unsigned int drv_mask;
> >>>>           unsigned int drv_shift;
> >>>> +       unsigned int drv2_offset;
> >>>> +       unsigned int drv2_mask;
> >>>> +       unsigned int drv2_shift;
> >>>>           unsigned int drv_en_manual_mask;
> >>>>    };
> >>>>
> >>>> @@ -45,6 +48,18 @@ static struct pm8xxx_regs pm8916_regs = {
> >>>>           .drv_en_manual_mask = 0,
> >>>>    };
> >>>>
> >>>> +static struct pm8xxx_regs pmi632_regs = {
> >>>> +       .enable_offset = 0x46,
> >>>> +       .enable_mask = BIT(7),
> >>>> +       .drv_offset = 0x40,
> >>>> +       .drv_mask = GENMASK(7, 0),
> >>>> +       .drv_shift = 0,
> >>>> +       .drv2_offset = 0x41,
> >>>> +       .drv2_mask = GENMASK(3, 0),
> >>>> +       .drv2_shift = 8,
> >>>> +       .drv_en_manual_mask = 0,
> >>>> +};
> >>>> +
> >>>>    /**
> >>>>     * struct pm8xxx_vib - structure to hold vibrator data
> >>>>     * @vib_input_dev: input device supporting force feedback
> >>>> @@ -53,6 +68,7 @@ static struct pm8xxx_regs pm8916_regs = {
> >>>>     * @regs: registers' info
> >>>>     * @enable_addr: vibrator enable register
> >>>>     * @drv_addr: vibrator drive strength register
> >>>> + * @drv2_addr: vibrator drive strength upper byte register
> >>>>     * @speed: speed of vibration set from userland
> >>>>     * @active: state of vibrator
> >>>>     * @level: level of vibration to set in the chip
> >>>> @@ -65,6 +81,7 @@ struct pm8xxx_vib {
> >>>>           const struct pm8xxx_regs *regs;
> >>>>           unsigned int enable_addr;
> >>>>           unsigned int drv_addr;
> >>>> +       unsigned int drv2_addr;
> >>>>           int speed;
> >>>>           int level;
> >>>>           bool active;
> >>>> @@ -82,6 +99,10 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
> >>>>           unsigned int val = vib->reg_vib_drv;
> >>>>           const struct pm8xxx_regs *regs = vib->regs;
> >>>>
> >>>> +       /* vibrator without drv2_addr needs be programmed in step increments */
> >>>
> >>> How are these two items related? Are you using vib->drv2_addr as a
> >>> marker for 'particular generation'? In such a case please use a flag
> >>> instead.
> >>>
> >>> The rest looks good to me.
> >>>
> >> Are you suggesting to add a flag in pm8xxx_vib as a discriminator for
> >> the new generation? I actually tried to avoid that because of this comment:
> >> https://lore.kernel.org/linux-arm-msm/ZgXSBiQcBEbwF060@google.com/#t
> >
> > Add a flag for level being programmed in steps or in mV. Using
> > drv2_addr instead of such flag is a hack.
> >
> Thanks Dmitry.
> Does this flag look good to you?

Yes, this is much better from my POV

>
> diff --git a/drivers/input/misc/pm8xxx-vibrator.c
> b/drivers/input/misc/pm8xxx-vibrator.c
> index 35bb6f450fd2..4708f441e5ac 100644
> --- a/drivers/input/misc/pm8xxx-vibrator.c
> +++ b/drivers/input/misc/pm8xxx-vibrator.c
> @@ -30,6 +30,7 @@ struct pm8xxx_regs {
>          unsigned int drv2_mask;
>          unsigned int drv2_shift;
>          unsigned int drv_en_manual_mask;
> +       bool         drv_in_step;
>   };
>
>   static const struct pm8xxx_regs pm8058_regs = {
> @@ -37,6 +38,7 @@ static const struct pm8xxx_regs pm8058_regs = {
>          .drv_mask = 0xf8,
>          .drv_shift = 3,
>          .drv_en_manual_mask = 0xfc,
> +       .drv_in_step = true;
>   };
>
>   static struct pm8xxx_regs pm8916_regs = {
> @@ -46,6 +48,7 @@ static struct pm8xxx_regs pm8916_regs = {
>          .drv_mask = 0x1F,
>          .drv_shift = 0,
>          .drv_en_manual_mask = 0,
> +       .drv_in_step = true;
>   };
>
>   static struct pm8xxx_regs pmi632_regs = {
> @@ -58,6 +61,7 @@ static struct pm8xxx_regs pmi632_regs = {
>          .drv2_mask = GENMASK(3, 0),
>          .drv2_shift = 8,
>          .drv_en_manual_mask = 0,
> +       .drv_in_step = false,
>   };
>
>   /**
> @@ -100,7 +104,7 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib,
> bool on)
>          const struct pm8xxx_regs *regs = vib->regs;
>
>          /* vibrator without drv2_addr needs be programmed in step
> increments */
> -       if (!vib->drv2_addr)
> +       if (regs->drv_in_step)
>                  vib->level /= VIB_PER_STEP_mV(vib);
>
>          if (on)
>
>
> >>
> >>>> +       if (!vib->drv2_addr)
> >>>> +               vib->level /= VIB_PER_STEP_mV(vib);
> >>>> +
> >>>>           if (on)
> >>>>                   val |= (vib->level << regs->drv_shift) & regs->drv_mask;
> >>>>           else
> >>>> @@ -93,6 +114,17 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
> >>>>
> >>>>           vib->reg_vib_drv = val;
> >>>>
> >>>> +       if (regs->drv2_mask) {
> >>>> +               if (on)
> >>>> +                       val = (vib->level << regs->drv2_shift) & regs->drv2_mask;
> >>>> +               else
> >>>> +                       val = 0;
> >>>> +
> >>>> +               rc = regmap_write_bits(vib->regmap, vib->drv2_addr, regs->drv2_mask, val);
> >>>> +               if (rc < 0)
> >>>> +                       return rc;
> >>>> +       }
> >>>> +
> >>>>           if (regs->enable_mask)
> >>>>                   rc = regmap_update_bits(vib->regmap, vib->enable_addr,
> >>>>                                           regs->enable_mask, on ? regs->enable_mask : 0);
> >>>> @@ -115,17 +147,16 @@ static void pm8xxx_work_handler(struct work_struct *work)
> >>>>                   return;
> >>>>
> >>>>           /*
> >>>> -        * pmic vibrator supports voltage ranges from 1.2 to 3.1V, so
> >>>> +        * pmic vibrator supports voltage ranges from MIN_LEVEL to MAX_LEVEL, so
> >>>>            * scale the level to fit into these ranges.
> >>>>            */
> >>>>           if (vib->speed) {
> >>>>                   vib->active = true;
> >>>> -               vib->level = ((VIB_MAX_LEVELS * vib->speed) / MAX_FF_SPEED) +
> >>>> -                                               VIB_MIN_LEVEL_mV;
> >>>> -               vib->level /= VIB_PER_STEP_mV;
> >>>> +               vib->level = VIB_MIN_LEVEL_mV(vib);
> >>>> +               vib->level += mult_frac(VIB_MAX_LEVELS(vib), vib->speed, MAX_FF_SPEED);
> >>>>           } else {
> >>>>                   vib->active = false;
> >>>> -               vib->level = VIB_MIN_LEVEL_mV / VIB_PER_STEP_mV;
> >>>> +               vib->level = VIB_MIN_LEVEL_mV(vib);
> >>>>           }
> >>>>
> >>>>           pm8xxx_vib_set(vib, vib->active);
> >>>> @@ -203,6 +234,7 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
> >>>>
> >>>>           vib->enable_addr = reg_base + regs->enable_offset;
> >>>>           vib->drv_addr = reg_base + regs->drv_offset;
> >>>> +       vib->drv2_addr = reg_base + regs->drv2_offset;
> >>>>
> >>>>           /* operate in manual mode */
> >>>>           error = regmap_read(vib->regmap, vib->drv_addr, &val);
> >>>> @@ -257,6 +289,7 @@ static const struct of_device_id pm8xxx_vib_id_table[] = {
> >>>>           { .compatible = "qcom,pm8058-vib", .data = &pm8058_regs },
> >>>>           { .compatible = "qcom,pm8921-vib", .data = &pm8058_regs },
> >>>>           { .compatible = "qcom,pm8916-vib", .data = &pm8916_regs },
> >>>> +       { .compatible = "qcom,pmi632-vib", .data = &pmi632_regs },
> >>>>           { }
> >>>>    };
> >>>>    MODULE_DEVICE_TABLE(of, pm8xxx_vib_id_table);
> >>>>
> >>>> --
> >>>> 2.25.1
> >>>>
> >>>>
> >>>
> >>>
> >
> >
> >



-- 
With best wishes
Dmitry

