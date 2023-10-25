Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEE17D6941
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjJYKoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234854AbjJYKnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:43:51 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9921FC3;
        Wed, 25 Oct 2023 03:42:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c9fa869a63so36375985ad.0;
        Wed, 25 Oct 2023 03:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698230578; x=1698835378; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=56h1JpcHvZsCRQ9iJdOKAqTAwTON7/OrDuQGdot/+iA=;
        b=dkz9kz8ExE1YIjnXAlKwhxJ1VbCSWPRXN1QRWJZGGLN6T01hJWx5Uy6LCMBAe2zNMs
         XIwysCDWy0qUOjO/06kxASDSMsoTREs4v9aJgLF2i65KPgrv+PuAYGH3L+X7IGRfBt+Y
         0eLY70Ju0JWd6IpQSs5jS4yBw+Yi1uY3tqkCMhZNhOrWwkH95tVA4V6/k6LGVv1vLM1y
         o5bVsbBFSAxpWXC7LabyvEkhrw5BqOR2TFdhQ9U3t2xBwfWankuL1bsw6f/DQU6w3aqk
         Fv0w73ldp+nLi52HAQ0uG7/fNZMvkPb2Ntl5Wo3nfGTb3WZa3aFdvzFxCbyA8sA307ZH
         uuKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698230578; x=1698835378;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56h1JpcHvZsCRQ9iJdOKAqTAwTON7/OrDuQGdot/+iA=;
        b=u2lAtMM3Enk+OXqIHPskJx25JvBCoI2X6kwQxXufvLn1oZGbgv6SNvdpdnEYpsXX5l
         pbYQzvfxkl0ltN6dN7tc9SbtYkpQIz2oUrojuVzZ+jM+5RJg/4L9jgBBFy26aokpNDs/
         4KQbrhJ4svaJoSJArTwkIgBEQw9KqTtq5TBb7JCy/GqwRq6dSJqAZVXgPK/Q1I3c/JaA
         3cRXWYuSa+vS5Vy5JXmaITwQ3LkF1vcUtELt7wgXAuV/jkuP4PXGZLe7I+O7hcbLJJO5
         d3rKZqBQJbodv5HQI08memJ0HFwXqg5g0atPV/3l5BKlvaE7crGGagtRVkUfk3jaCzBD
         ph6w==
X-Gm-Message-State: AOJu0YxWopUcTeWUqw24/UzIbxak2xSXqih6bM5R4cBm+WAM9QHsO8+w
        09n9UDyrwGEwqdWwVkaOBv5YhjP8vcgVEqxgvuw=
X-Google-Smtp-Source: AGHT+IGu6RadKqlaivUp1Agx0JAVTkBz0ox2q7y+J3UsKXFtZj1ToELfyUv5XsBOmBBv+Yk1JjwNb5rp81iLFbNlIcM=
X-Received: by 2002:a17:903:6c4:b0:1bd:ca80:6fe6 with SMTP id
 kj4-20020a17090306c400b001bdca806fe6mr9659343plb.41.1698230577913; Wed, 25
 Oct 2023 03:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231015162114.976202-1-robimarko@gmail.com> <f27ff251-58b1-4fc5-8ad5-cd365b7eb976@linaro.org>
 <8dce62b2-562c-4e00-840b-68e1cc865972@quicinc.com> <CAOX2RU4n8caVL33KkqgYK1_mTZv-oZtd0p=_dzPh-ntBBfH1zA@mail.gmail.com>
 <b4ce1fdf-0a05-479d-90f8-3a2a2e40b07f@quicinc.com> <CAOX2RU7Z1BS0u_k=cx58oq8RODPV=a3kV26OsbYpkDaN1atixg@mail.gmail.com>
 <444ef41e-632c-4402-849d-80e8876b6e72@quicinc.com>
In-Reply-To: <444ef41e-632c-4402-849d-80e8876b6e72@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 25 Oct 2023 12:42:46 +0200
Message-ID: <CAOX2RU5DfuOTr-pzU=mSaz_bxX9VOB1oAC6000PzS5OqmZsFEg@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: gcc-ipq6018: add QUP6 I2C clock
To:     Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        andersson@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 at 10:42, Kathiravan Thirumoorthy
<quic_kathirav@quicinc.com> wrote:
>
>
>
> On 10/21/2023 5:27 PM, Robert Marko wrote:
> > On Fri, 20 Oct 2023 at 08:40, Kathiravan Thirumoorthy
> > <quic_kathirav@quicinc.com> wrote:
> >>
> >>
> >> On 10/19/2023 7:53 PM, Robert Marko wrote:
> >>> On Thu, 19 Oct 2023 at 08:46, Kathiravan Thirumoorthy
> >>> <quic_kathirav@quicinc.com> wrote:
> >>>>
> >>>> On 10/19/2023 1:59 AM, Konrad Dybcio wrote:
> >>>>>
> >>>>> On 10/15/23 18:20, Robert Marko wrote:
> >>>>>> QUP6 I2C clock is listed in the dt bindings but it was never included in
> >>>>>> the GCC driver.
> >>>>>> So lets add support for it, its intentionally marked to never be
> >>>>>> disabled
> >>>>>> as its somehow affecting DVFS and if disabled it sometimes crashes the
> >>>>>> board.
> >>>>>>
> >>>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>>>>> ---
> >>>>> Bjorn, would you be able to get an idea of what could be sitting
> >>>>> on that bus?
> >>>>>
> >>>>> Or maybe the IPQ folks could know?
> >>>>>
> >>>> Konrad / Robert,
> >>>>
> >>>> Similar to IPQ9574, RPM needs this clock to communicate with PMIC over
> >>>> I2C interface. Discussion happened here[1] is pretty much applicable to
> >>>> IPQ6018 as well. Based on previous experience, we may need to document
> >>>> the reason for CLK_IGNORE_UNUSED in driver as well. Nevertheless,
> >>>>
> >>>> Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> >>> Thanks for the explanation, it makes sense as I used to control the
> >>> MP5496 directly
> >>> via I2C.
> >>>
> >>> Is it possible to disable RPM so it doesn't conflict and just use the
> >>> full MP5496 driver instead?
> >>> I find the RPM quite limiting as there is no way to actually retrieve
> >>> the current-voltage.
> >>
> >>
> >> Robert, checked with the team and currently we don't have any option to
> >> disable the RPM as such.
> >
> > Thanks for checking.
> >
> > BTW, is there any information you could share on the USB GDSC-s?
> > I tried converting them to GDSC-s like IPQ8074 has, but it seems that
> > they have different features.
> > It would be great to use proper GSDC support instead of manually
> > setting bits during GCC probe.
>
>
> Could you please explain the issue which you are facing? Based on quick
> look at the HW documentation, seems there is no difference between
> IPQ8074 and IPQ6018 GDSC-s.

Thanks for checking, it seems I hit a buggy kernel version last time I tried to
convert the driver to use proper GDSC-s and now it seems to work fine,
I will send patches to add GDSC-s.

Regards,
Robert
>
> Thanks,
