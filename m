Return-Path: <linux-kernel+bounces-103115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8063187BB36
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36D051F252BC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0136EB40;
	Thu, 14 Mar 2024 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbYZCwiB"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399366CDC1
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411985; cv=none; b=mWRd3wdGzkD3dKxaPmQap4l3HnTJa0gihgJ+i5VYS/sIq+LpoOdq42wDvf6VqbmlItId38QTRIBqKBG688XmUX8/RumKfcNGsM8fEPpd3Zzrad4cMn2DdPZJpx02JTmbHvLVUdyYcJTJrSv287DvNj35UklWkl7RQ/EKVCEE4ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411985; c=relaxed/simple;
	bh=bClml7W2Syxqpxl+P0XTyjEWXWGG/s5JmZLnZYmwEdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4jX9wbPyC+BMR6NfQ4razB/L+9YnPuBWbhP14e8TOUHbDlUbPwPTnCfZCHgW+wL8NvsohNcMYoUX3Zg6TGsdscvd94vDMO8Hj3nnWVao7H1dg4rAI8+RP4rXjfqzVNrxd0WafL8gOl5qn8xkcb/W55TwVp/qJrFls63hXhOQIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gbYZCwiB; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-474d1cf7832so187166137.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 03:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710411983; x=1711016783; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bClml7W2Syxqpxl+P0XTyjEWXWGG/s5JmZLnZYmwEdM=;
        b=gbYZCwiBXN0zyT4Uj+JhC5pfcZAZoCkXzwxw4o0qR7YREdG5kiBKdaPp6lSP98rEbw
         EB/5j5tn+iftiwUTRFMlsbte+cllaUBsE3668HWJYfe7lqi5kQOzuKiEyMpleHWL3Ha9
         aFJDcblp6eyGGf6n82PxXSIQK1GUxFI7opnn4cjqct23KiTwTgsMFzWpJoFeo31RQKJ6
         DtGvrlPYWq/CtXf0IiBcVvflBEGsS/sGNmGNpxD1s9hQrsJqoOqCUov8dMauKkeIaszT
         Ot8kI7r5CtPJjJsxU6uCsKFJdiTHNfIhhocGTeoCRGUG0PeBWjplUCS4GK3zFOuXc1sL
         9W7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710411983; x=1711016783;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bClml7W2Syxqpxl+P0XTyjEWXWGG/s5JmZLnZYmwEdM=;
        b=A3PZN03bNoDWXqW7Umnm78/TdtRH2S9NZGj9uBOdFTtU2yUI/Kl/tYCvmqScU6FM+t
         l4p8cSw2q8PUlscZO76xHQvyk/cAB0AFAD5NOUo/e2Q4BfscnpJZPULC/rNLY5Ba7C3c
         X2vwLjKMy7OKI0+cRQ9t/KrKZkLkV3PtS2zaPjBeHXyDrCeAx0+v+Yih8wCm/jFfNBbF
         gZeap4iFdy7mM6Kl3WlKobrc4IjugNXEfN7Lq8zfMD2C1jgfKucNng8meGztMyVXqFkP
         /Y34wJ+G0T1FzTzOYXJaABoSCTvqeB0QERG3a330vm/y8o65bNOtR6l2wvyt6xJsEmxc
         L6vw==
X-Forwarded-Encrypted: i=1; AJvYcCUh6pjVBG1zCW7OnyfDQu7/LBf7k9oLxD+uPfOA3f0T/HR8UqGVEI75G7AcprIEXUK0md3eXfiHrhcMyYtfrdluBae81AEAn15fXZLA
X-Gm-Message-State: AOJu0YxL57MpaTEkcEIbYjFwVS2xJnDsicTMDm8DZk+pBloW96j4t/mf
	kP7xlb824IdJg8YNd4BuuWWJmCwf2h9qGrVGl/YEZI+1gr27pfKydV1k0QNsMMvE8rDrHw3Mj0H
	uZhHXpXz/dm2mJlf1ONH1oaRwXck3LVP6pWNQxw==
X-Google-Smtp-Source: AGHT+IHQotcVxfbfFxcjGI7/T/ebobFcozaCDRBw/St3GkLtFEQShNOY4t4ZZOogNwvVxa7Pm+LCr1GCxRVS9jyr/Tg=
X-Received: by 2002:a67:b345:0:b0:476:7bf:8912 with SMTP id
 b5-20020a67b345000000b0047607bf8912mr1239701vsm.11.1710411983143; Thu, 14 Mar
 2024 03:26:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313123017.362570-1-sumit.garg@linaro.org>
 <20240313123017.362570-4-sumit.garg@linaro.org> <4a0a8db7-a2bc-4c99-94b2-c13facbd1bef@linaro.org>
 <CAFA6WYPh5BS_Fpi6ksAC7bwoFEyqjj1Y3EahyQxCG9Pp=KDw=Q@mail.gmail.com>
 <9dc0415c-4138-4867-861a-38b45b636182@linaro.org> <CAFA6WYPFfL18acdZt6O-_=LWnH7J2MooDuf9cA3JCaQZdoLhVA@mail.gmail.com>
 <CAFA6WYNo73S5ROHCMK0ZQSiU0DDbuDadptmaPL+GPCocE0h-mA@mail.gmail.com> <f03c7979-79f3-4894-98b0-1e5a2dc18ba6@linaro.org>
In-Reply-To: <f03c7979-79f3-4894-98b0-1e5a2dc18ba6@linaro.org>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 14 Mar 2024 15:56:11 +0530
Message-ID: <CAFA6WYNRwF7GqhBk2B7i-deT3aLxNQckhnOasjip2TYm4HZgAw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: apq8016: Add Schneider HMIBSC
 board DTS
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, stephan@gerhold.net, 
	caleb.connolly@linaro.org, neil.armstrong@linaro.org, 
	laetitia.mariottini@se.com, pascal.eberhard@se.com, abdou.saker@se.com, 
	jimmy.lalande@se.com, benjamin.missey@non.se.com, daniel.thompson@linaro.org, 
	linux-kernel@vger.kernel.org, Jagdish Gediya <jagdish.gediya@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 15:36, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 14/03/2024 10:36, Sumit Garg wrote:
> >>
> >> But it then broke dtbs_check.
> >
> > See following breakage afterwards:
> >
> > $ make qcom/apq8016-schneider-hmibsc.dtb dtbs_check
> > <snip>
> > /home/sumit/build/upstream/linux/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb:
> > leds: led@5: Unevaluated properties are not allowed ('reg' was
> > unexpected)
> > from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#
> > /home/sumit/build/upstream/linux/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb:
> > leds: led@6: Unevaluated properties are not allowed ('reg' was
> > unexpected)
> > from schema $id: http://devicetree.org/schemas/leds/leds-gpio.yaml#
> > /home/sumit/build/upstream/linux/arch/arm64/boot/dts/qcom/apq8016-schneider-hmibsc.dtb:
> > leds: '#address-cells', '#size-cells' do not match any of the regexes:
> > '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
>
> That's obvious, I don't get what is the question. Adding not correct
> properties is not a solution and dtbs_check correctly tells you that.
>
> If you only opened absolutely any existing upstream source, you would
> see how the gpio leds are represented in DTS.
>

It looks like my reference example:
arch/arm64/boot/dts/qcom/apq8016-sbc.dts wasn't correct then. I will
drop unit addresses then.

-Sumit

> Best regards,
> Krzysztof
>

