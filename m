Return-Path: <linux-kernel+bounces-33102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41249836488
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38D3285EAF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07ACD3D0AB;
	Mon, 22 Jan 2024 13:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pruDGg1N"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7D03986C
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705930636; cv=none; b=Y6ZOlvL/HPDyTvbYJi9nlGgwk20MYgFg4tC9dTZ5K9PxSihTM8Nd0Q0zZ42suqaNu5OffOHBMVZ0smPRiIXw18UVLBuqm2pw/BZ+D+XO5fWFUf496KUFhFUzmi6ozKIj644HjpkIZgDmWfLCDH1KHwSlPeGPquTzYwizSerI4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705930636; c=relaxed/simple;
	bh=wVWuq0gawOGl8KiWuRy3jGbacbix2tLimet/jRZRsJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cn0RgOX4LpV/nx3GQD7n+R1OIpskJHoJy3SF0ufS+pfJhMuFAPhU/2oq1LlPlTnIsT+++e4heEGD7bgaSzUhco/MyS4O2NIaGl88yrrGywKegWX3pXbJAyUngRsT+e9/q9kRehwKT1OeGhX+EEisbd+d2tBslkc82c2uAkJzCSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pruDGg1N; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-600273605a9so1620347b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 05:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705930634; x=1706535434; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z7oGSHsIqEAvLZa5ynsGHrZxRD+OARNhlTzhS0egCCQ=;
        b=pruDGg1NZA+GFWey9SqXYWP+OwxwrARafzmHGL9RSFXQ0esvnS+fxmUzqPD43oNF9N
         Be27qwzPGJh6q3lIzUGvlul2D2fz08VVpl8Vy5l3sa5GFv/uRUAihwSYrlwK4K2wizNd
         9SDSvsTMuZ9kMf1P4yEe1cecSo28iuf7EOu9RrVuYrcDLHyg1Rq1ANHWIdhQgWoqJiuL
         LG8bF5+QuTgyotRB+mwl1LsJTYfFaDT5PEh09oQz4aJ76xqKIKfvwDf7B299U5Q802vF
         PuGwUlXGPNyZvpELT6u/IgdrWMKLkD2/hvEDZbx/z0ppXovCAvNqhe3x8qMD61w6J2eF
         vvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705930634; x=1706535434;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z7oGSHsIqEAvLZa5ynsGHrZxRD+OARNhlTzhS0egCCQ=;
        b=ZXjWsbw10r/LE3nnzuCToZeiSUI0yf697upqYemMedRicHIU9ySqnRYIZ/kyXtSxIv
         1qQsKYw6Oo+KVpif4LQtcTSb8AeyTwnrWvhW6aVeR5kIczQ7ROK6G9r0FP8OrlPe7QTv
         xiVdf2PSfIKFGVZrTZu479AxlLqv2doZzXppQGRV084jLZcqexpgBESTfDjGmKXmPwL7
         SToLDVzI97gLo0Jmdxyoon9OYMTGjJmT1cisrISQayOfV09SAnjwr58Qr+IgqJIXKU+/
         sIgR2w6niQ3jAoeR8ib/TmAxuEy1S/sZKWzNpy97WZUhlhAmbk9p/SSBhHraFgXVy2sc
         Mykw==
X-Gm-Message-State: AOJu0Yz458WRlw7K5gEJWq4t5k/XYnXZRBWeMp9SMDgTuaxrCDXeQp9J
	RtoaNYKF/EkTpayMteAUzkb35PyQ9FYAYcxlmcuP2SOe4k7cUOiHAOHOu0m5DBLaXrqNSm3gQUs
	z/WYXS7NcUbA96zLHWtMuoRQih10q01q98SRJiA==
X-Google-Smtp-Source: AGHT+IH5lciyRV60bliZfX5ohnB5VyzCzFgCc/JpZlAFrB61lN47m7UhohsA4v2BdT1+81l1WVs6Okc4CaE5fJIrDJs=
X-Received: by 2002:a81:5344:0:b0:5f5:9898:ca3a with SMTP id
 h65-20020a815344000000b005f59898ca3amr3418967ywb.87.1705930633919; Mon, 22
 Jan 2024 05:37:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115-lpg-v5-1-3c56f77f9cec@quicinc.com> <CAA8EJpoemnXTmshWrArVOCm0GRSkWZ5tH557nbAjRL1Tgg-Dig@mail.gmail.com>
 <e16f5ff1-9b12-4f90-89d5-f95cbfb859e7@quicinc.com> <6c29ce72-e303-406a-bb75-5b36b0cd8ee4@linaro.org>
 <44ab50c4-c63b-436c-af46-9b4543181446@quicinc.com> <CAA8EJpq8exe6n3OQnreLCsV+BnZKcu24d==rEKup=+n28nnDHw@mail.gmail.com>
 <4c82f1f0-1c5a-498f-9845-b5b26cd76468@quicinc.com> <5f6c2be1-faf9-4e64-ab3a-88046d75e2cf@quicinc.com>
 <1d948daf-1495-4208-a85f-6bd798091d82@quicinc.com>
In-Reply-To: <1d948daf-1495-4208-a85f-6bd798091d82@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 22 Jan 2024 15:37:02 +0200
Message-ID: <CAA8EJppqL=79rDzEvrhEA8N6wa=YFxN+595eK+JD=JOuCRm1gA@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: dts: qcom: qcm6490-idp: Add definition for
 three LEDs
To: hui liu <quic_huliu@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_fenglinw@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 22 Jan 2024 at 08:26, hui liu <quic_huliu@quicinc.com> wrote:
>
>
>
> On 1/22/2024 1:42 PM, hui liu wrote:
> >
> >
> > On 1/18/2024 10:06 AM, hui liu wrote:
> >>
> >>
> >> On 1/17/2024 11:41 AM, Dmitry Baryshkov wrote:
> >>> On Wed, 17 Jan 2024 at 05:02, hui liu <quic_huliu@quicinc.com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 1/15/2024 6:26 PM, Krzysztof Kozlowski wrote:
> >>>>> On 15/01/2024 11:18, hui liu wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 1/15/2024 5:56 PM, Dmitry Baryshkov wrote:
> >>>>>>> On Mon, 15 Jan 2024 at 11:48, Hui Liu via B4 Relay
> >>>>>>> <devnull+quic_huliu.quicinc.com@kernel.org> wrote:
> >>>>>>>>
> >>>>>>>> From: Hui Liu <quic_huliu@quicinc.com>
> >>>>>>>>
> >>>>>>>> Add definition for three LEDs to make sure they can
> >>>>>>>> be enabled base on QCOM LPG LED driver.
> >>>>>>>
> >>>>>>> The "function" property is still placed incorrectly. Posting the
> >>>>>>> next
> >>>>>>> iteration before concluding the discussion on the previous one is
> >>>>>>> not
> >>>>>>> the best idea.
> >>>>>> Do you mean I should update it as below? Seems there is no
> >>>>>> consumer to
> >>>>>> use the function config, do we need to add now?
> >>>>>
> >>>>> Paste the output of dtbs_check for your board (or CHECK_DTBS=y for
> >>>>> your
> >>>>> Makefile target).
> >>>> I checked the dt-binding file of LPG LED, I will update the dts as
> >>>> below, if you think it's correct, I will push v6.
> >>>
> >>> Is there any reason why you are defining three different LEDs instead
> >>> of multi-led with three components?
> >
> >> In the HW design, they are three seprete LEDs, there are three LEDs on
> >> device. why do we need to add for multi-led?
> >>
> >> Thanks,
> >> Hui
>
> I double confirmed the HW design, for IDP devcie, we should set it to
> multi led, for another similar device(RB3-GEN2, I will push LED change
> for this device later), it should be set to seperate LED.
> They are different, so I will push V6 to set it for multi-led for
> QCM6490-IDP device. Thanks for your review.

Ack, thank you.

>
> >>>
> >>>>
> >>>> +&pm8350c_pwm {
> >>>> +       #address-cells = <1>;
> >>>> +       #size-cells = <0>;
> >>>> +       status = "okay";
> >>>> +
> >>>> +       led@1 {
> >>>> +               reg = <1>;
> >>>> +               color = <LED_COLOR_ID_RED>;
> >>>> +               function = LED_FUNCTION_STATUS;
> >>>> +       };
> >>>> +
> >>>> +       led@2 {
> >>>> +               reg = <2>;
> >>>> +               color = <LED_COLOR_ID_GREEN>;
> >>>> +               function = LED_FUNCTION_STATUS;
> >>>> +       };
> >>>> +
> >>>> +       led@3 {
> >>>> +               reg = <3>;
> >>>> +               color = <LED_COLOR_ID_BLUE>;
> >>>> +               function = LED_FUNCTION_STATUS;
> >>>> +       };
> >>>> +};
> >>>
> >>>
> >>>



-- 
With best wishes
Dmitry

