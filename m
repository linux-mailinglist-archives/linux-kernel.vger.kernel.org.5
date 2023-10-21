Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD797D1CEE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 13:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjJUL5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 07:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjJUL5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 07:57:31 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84692D51;
        Sat, 21 Oct 2023 04:57:29 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3b2ec9a79bdso1261356b6e.3;
        Sat, 21 Oct 2023 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697889449; x=1698494249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FxNz9djPi2ZFZLmpxAIXb8X9Wg3dZxfYM3EqSIAWSDg=;
        b=g2wq64GTFlf+UyXvUUFB9kuU+pZT6wzK6Pap1BkVrO4ySfk+Jb07lTia+G9yU4dO1z
         /MMOSzEDUUSFfNTrc7XkoaJ5J0zcsF/U3wbp9s+2WMosCYKGvQiJvEYouQFQ8oFPUuMl
         SV2otip1MSjEZTIweOOzlUk/y6LjDnty5XD9S1G+8ZqWq0jSpaVua66SRockqb6w0kLX
         S4tgpcmW+5EWBN9+GziZ8iw36cXFMt0Pl+1azsewGSxsYCsGU4bpfZ7MHQynGrYuBiB9
         ci/d8yi1U5ilUKcMwnjai/NJCqBwkSDAlCoafEXop2fqz0PYvRNvJH/cCpD5iYS6m7+j
         S9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697889449; x=1698494249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FxNz9djPi2ZFZLmpxAIXb8X9Wg3dZxfYM3EqSIAWSDg=;
        b=aSMCREsOWMiXVw7wl3wAYVWjMvyhI8q4+L8miPTlHYbU4UaGsE0LcIHT7ZNgtmMCDV
         qUvXxP+PlGeiH2+ooo7Rpdl7ItwJxZfuC7JqTax4f5RdSvuBJ/XhF+QyHfIUUE6uMiNj
         f8tUXK8TG34E91nT0CkFutfxXAPnRql3M7JTehqtl09o7a5HOs0+9PsqlnfhfD0cKjjR
         sm1Z1wrUOTypOirmE8KAW2gCXUuOHzWVxNPeOG0z0FR5QCz2GiFkBxBZMWhq26V50/tz
         fZiG9ssFu6bGAJscD9cMRD4FLeyKOGbalZpug/UI1/vpDBClesfjgH0U7w3E9E+R9cWZ
         o1dg==
X-Gm-Message-State: AOJu0Yxowp8z0ODbeAessnMHK8BFwYRD0f4S8HE28PAtKmb0CMnV81vY
        +81c4+bxW9WRKjDFHASuSPYvyWYy2TfNw8BzXK4=
X-Google-Smtp-Source: AGHT+IErCwbPPf2d1W2hR6YumknJe5gd9sptBaKAtjtmuKDZW7EB8QqNK+Wv7inqupTOwAHWQSjuO7Mf4Y/mKTyWbuk=
X-Received: by 2002:a05:6808:12:b0:3ae:a81:55ba with SMTP id
 u18-20020a056808001200b003ae0a8155bamr4812229oic.22.1697889448746; Sat, 21
 Oct 2023 04:57:28 -0700 (PDT)
MIME-Version: 1.0
References: <20231015162114.976202-1-robimarko@gmail.com> <f27ff251-58b1-4fc5-8ad5-cd365b7eb976@linaro.org>
 <8dce62b2-562c-4e00-840b-68e1cc865972@quicinc.com> <CAOX2RU4n8caVL33KkqgYK1_mTZv-oZtd0p=_dzPh-ntBBfH1zA@mail.gmail.com>
 <b4ce1fdf-0a05-479d-90f8-3a2a2e40b07f@quicinc.com>
In-Reply-To: <b4ce1fdf-0a05-479d-90f8-3a2a2e40b07f@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Sat, 21 Oct 2023 13:57:17 +0200
Message-ID: <CAOX2RU7Z1BS0u_k=cx58oq8RODPV=a3kV26OsbYpkDaN1atixg@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: gcc-ipq6018: add QUP6 I2C clock
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Oct 2023 at 08:40, Kathiravan Thirumoorthy
<quic_kathirav@quicinc.com> wrote:
>
>
> On 10/19/2023 7:53 PM, Robert Marko wrote:
> > On Thu, 19 Oct 2023 at 08:46, Kathiravan Thirumoorthy
> > <quic_kathirav@quicinc.com> wrote:
> >>
> >> On 10/19/2023 1:59 AM, Konrad Dybcio wrote:
> >>>
> >>> On 10/15/23 18:20, Robert Marko wrote:
> >>>> QUP6 I2C clock is listed in the dt bindings but it was never included in
> >>>> the GCC driver.
> >>>> So lets add support for it, its intentionally marked to never be
> >>>> disabled
> >>>> as its somehow affecting DVFS and if disabled it sometimes crashes the
> >>>> board.
> >>>>
> >>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>>> ---
> >>> Bjorn, would you be able to get an idea of what could be sitting
> >>> on that bus?
> >>>
> >>> Or maybe the IPQ folks could know?
> >>>
> >> Konrad / Robert,
> >>
> >> Similar to IPQ9574, RPM needs this clock to communicate with PMIC over
> >> I2C interface. Discussion happened here[1] is pretty much applicable to
> >> IPQ6018 as well. Based on previous experience, we may need to document
> >> the reason for CLK_IGNORE_UNUSED in driver as well. Nevertheless,
> >>
> >> Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> > Thanks for the explanation, it makes sense as I used to control the
> > MP5496 directly
> > via I2C.
> >
> > Is it possible to disable RPM so it doesn't conflict and just use the
> > full MP5496 driver instead?
> > I find the RPM quite limiting as there is no way to actually retrieve
> > the current-voltage.
>
>
> Robert, checked with the team and currently we don't have any option to
> disable the RPM as such.

Thanks for checking.

BTW, is there any information you could share on the USB GDSC-s?
I tried converting them to GDSC-s like IPQ8074 has, but it seems that
they have different features.
It would be great to use proper GSDC support instead of manually
setting bits during GCC probe.

Regards,
Robert
>
>
> >
> > Regards,
> > Robert
> >> [1]
> >> https://lore.kernel.org/linux-arm-msm/2852fc37-284f-6534-f163-45b37b153db1@quicinc.com/
> >>
> >>
> >>> Konrad
