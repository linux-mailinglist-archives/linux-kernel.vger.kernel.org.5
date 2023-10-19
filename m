Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046807CFC65
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 16:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346072AbjJSOXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 10:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345647AbjJSOXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 10:23:39 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D4EB0;
        Thu, 19 Oct 2023 07:23:37 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53fa455cd94so5466743a12.2;
        Thu, 19 Oct 2023 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697725417; x=1698330217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t/BPqihyPeth/YaDAwwKeryj5x6nuyNPp4la/eCYYSU=;
        b=mmQHz8ovJZQuhK170AJJHTVR3BMtYaVVHy1I/6kg+4UiFxK1KYhsJdrxKTASAnGMm9
         TfaF/tDgDThxIStR+uDs7dGXFUDmH4e4TCFL7axeYLiIJgO4oGF1hiZVJ75IuHVaquV4
         Jw3fIJEIV/zhjWQzz4Qi9G98r0GmJsDYr7/pIWsKUIeom3tPnqTTcLKkH1sQG4N+8x1h
         fRhLfBVRjOgQTtm2eRY48tRtaBdMbARKQERA+0HNcDJruBDEm1PaBMrZw2NmnptSry5f
         cMJ6fG+H4A0uFrFcw87xDL1EmSMd/2+TQ0/085L3PHR0B9/odKFYDUt+MeAteNtBcnvv
         5haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697725417; x=1698330217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t/BPqihyPeth/YaDAwwKeryj5x6nuyNPp4la/eCYYSU=;
        b=TxZtvNiIrcq4QFfupq4YszdYnjNoZfTCyG/dx+OQv7faax01R69kFHmx/tbPnEDMCL
         uPZeEcC6gaJ9p/Y+/BFDrNA6TAlirUBkZwJH+0tXMnLsbtFL58/NdsVROBgYngSx1duS
         CAY7p+P2/HqvviG4AfANlgc5OiDPwuNkepeQD6+K9dmB1S0h2x1lZDP8AXaGK3BxIAgp
         6eLzWOyUjdnlfwbHEjThMvjjp9HoEQ2Q3Sw8UIoJ0Sg4RekfWg9DZR0ZIvVXVacsbP0G
         iQThRtAlcbhVuIiqjrfnT13DOaBTUijAl9zHZHwniyiUfXpq0Km2TqPVs7kAV4kA2+/f
         0RwQ==
X-Gm-Message-State: AOJu0YzGJdhCuoidUssa+0eo1LnvT92lu6b6L/4fJBwpAImjrmPNv1rb
        nJRaAqPjRhnzV5+8zkHVzAXeAni3LM7LBGYXO+xj2SlJ
X-Google-Smtp-Source: AGHT+IGBw5cywWDrc/8pUnDwbRBRUklWCGbuWYzqR3evGfv/RcwLcxz+VVPXAxg86IhH/2WIPGckvKV5wTwl/MkasP4=
X-Received: by 2002:a05:6a20:c19d:b0:15e:1351:f33a with SMTP id
 bg29-20020a056a20c19d00b0015e1351f33amr2441278pzb.47.1697725417214; Thu, 19
 Oct 2023 07:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231015162114.976202-1-robimarko@gmail.com> <f27ff251-58b1-4fc5-8ad5-cd365b7eb976@linaro.org>
 <8dce62b2-562c-4e00-840b-68e1cc865972@quicinc.com>
In-Reply-To: <8dce62b2-562c-4e00-840b-68e1cc865972@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Thu, 19 Oct 2023 16:23:26 +0200
Message-ID: <CAOX2RU4n8caVL33KkqgYK1_mTZv-oZtd0p=_dzPh-ntBBfH1zA@mail.gmail.com>
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

On Thu, 19 Oct 2023 at 08:46, Kathiravan Thirumoorthy
<quic_kathirav@quicinc.com> wrote:
>
>
> On 10/19/2023 1:59 AM, Konrad Dybcio wrote:
> >
> >
> > On 10/15/23 18:20, Robert Marko wrote:
> >> QUP6 I2C clock is listed in the dt bindings but it was never included in
> >> the GCC driver.
> >> So lets add support for it, its intentionally marked to never be
> >> disabled
> >> as its somehow affecting DVFS and if disabled it sometimes crashes the
> >> board.
> >>
> >> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >> ---
> > Bjorn, would you be able to get an idea of what could be sitting
> > on that bus?
> >
> > Or maybe the IPQ folks could know?
> >
>
> Konrad / Robert,
>
> Similar to IPQ9574, RPM needs this clock to communicate with PMIC over
> I2C interface. Discussion happened here[1] is pretty much applicable to
> IPQ6018 as well. Based on previous experience, we may need to document
> the reason for CLK_IGNORE_UNUSED in driver as well. Nevertheless,
>
> Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

Thanks for the explanation, it makes sense as I used to control the
MP5496 directly
via I2C.

Is it possible to disable RPM so it doesn't conflict and just use the
full MP5496 driver instead?
I find the RPM quite limiting as there is no way to actually retrieve
the current-voltage.

Regards,
Robert
>
> [1]
> https://lore.kernel.org/linux-arm-msm/2852fc37-284f-6534-f163-45b37b153db1@quicinc.com/
>
>
> > Konrad
