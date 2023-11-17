Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3927EEE17
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 10:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbjKQJFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 04:05:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234623AbjKQJFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 04:05:49 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6314F92
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:05:46 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9ace5370a0so1754282276.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 01:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700211945; x=1700816745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHktqX0dsfDB3Qr0B56p59hxtShUO+SjWYreoHWuWgI=;
        b=P7KRCixjAIwKZLOPtQf4jviSWmxNZU+fBcVYQL2tcKC5xsyL33e70Jhc2OQvqgpWL/
         LAK3qYim9oI7alq9Gc4jdlPbRYOuOzPzocUPnNiJ1IUMK+9vw5vrTbBNPrjCzOrK5bJW
         RP66Ajzi2rqJWqMvMpADT0d6F7F2dLof6an05+BtmvOV+2FWKphpDwNSLRydy4YoxzCU
         Ev3vd5lCLdeQ+LYCqua9s+C3e95eFXJYiceD/YDhVvquvogG0OV/KH3BNsEhMCEOM9V+
         yTF7nXf071PRteCKX7NZXThGXLoyax+1MJvu4eRUVjueMkH6iPmqWQL9KHNDqvONeiPq
         z+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700211945; x=1700816745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UHktqX0dsfDB3Qr0B56p59hxtShUO+SjWYreoHWuWgI=;
        b=hakahz/rq17xHQa3fGJ27xWGGbCE9H+peUUzOjxwzKwauIwmv4ZswzeCZ0vpL+SdHn
         h0i+AMBrTnjypA4WnapUbwfGyPnsbl9JBlNX7Fytxz+b6U4EXCNXaLN6BeIiCmkV3vKC
         Vr6B46tbpttxrkxlMA3q82536uBI2RU61HZtYqWNe89L8XGezV8khGV60k6b/vTjZ3Og
         hab5lCbgNHNcHqniVQcwsaG552UzAfI6g9XwizlfBGBMiEP18uMrqvuzkTnt5keIFup3
         we5jLex8YkgPxiZZhn+ZcITHiifd+xgmSuwfl55i61OYt6oQIHNmE9Q4h71tWM/IUhSV
         HkIw==
X-Gm-Message-State: AOJu0Yx6A1OjSYxS37PhmJNPh5T5rno2njrh+tv1uvbbkf+HAxw0pULo
        u6QILjuhMlBvAQkqjnZsH+GVgkW7M5BLDDG4UeOrWA==
X-Google-Smtp-Source: AGHT+IG4HTWn9HZidIE2HS1fQ6EFEvW84+FwgGTso15wTPMx1IMjEpMnW8BrfkDiBGYwevVBxogpQL9blqjY29XxeXc=
X-Received: by 2002:a25:d614:0:b0:d9c:707f:1f4f with SMTP id
 n20-20020a25d614000000b00d9c707f1f4fmr15840596ybg.3.1700211945470; Fri, 17
 Nov 2023 01:05:45 -0800 (PST)
MIME-Version: 1.0
References: <20231117055849.534671-1-quic_rohiagar@quicinc.com> <20231117090349.GA244633@thinkpad>
In-Reply-To: <20231117090349.GA244633@thinkpad>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 17 Nov 2023 11:05:34 +0200
Message-ID: <CAA8EJpqj4_HhkEXtm4JNo5+dfUb3eRtHxAF=NUaeRohDADVx0w@mail.gmail.com>
Subject: Re: [PATCH v3] arm64: defconfig: Enable GCC, pinctrl and interconnect
 for SDX75
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Rohit Agarwal <quic_rohiagar@quicinc.com>, catalin.marinas@arm.com,
        will@kernel.org, quic_bjorande@quicinc.com,
        geert+renesas@glider.be, konrad.dybcio@linaro.org, arnd@arndb.de,
        krzysztof.kozlowski@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, m.szyprowski@samsung.com, u-kumar1@ti.com,
        peng.fan@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 at 11:03, Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Fri, Nov 17, 2023 at 11:28:49AM +0530, Rohit Agarwal wrote:
> > Enable Global Clock controller, pinctrl and interconnect framework
> > support for Qualcomm's SDX75 SoC which is required to boot to
> > console on sdx75-idp platform.
> >
> > Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> > ---
> >
> > Hi,
> >
> > Changes in v3:
> >  - Clubbed all the three patches in a single patch.
> >  - Link to v2: https://lore.kernel.org/all/20231116093513.14259-1-quic_=
rohiagar@quicinc.com/
> >
> > Changes in v2:
> >  - Updated the commit message for the patches.
> >
> > Thanks,
> > Rohit.
> >
> >  arch/arm64/configs/defconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfi=
g
> > index b60aa1f89343..4c0cd428d073 100644
> > --- a/arch/arm64/configs/defconfig
> > +++ b/arch/arm64/configs/defconfig
> > @@ -599,6 +599,7 @@ CONFIG_PINCTRL_SC8280XP=3Dy
> >  CONFIG_PINCTRL_SDM660=3Dy
> >  CONFIG_PINCTRL_SDM670=3Dy
> >  CONFIG_PINCTRL_SDM845=3Dy
> > +CONFIG_PINCTRL_SDX75=3Dy
> >  CONFIG_PINCTRL_SM6115=3Dy
> >  CONFIG_PINCTRL_SM6115_LPASS_LPI=3Dm
> >  CONFIG_PINCTRL_SM6125=3Dy
> > @@ -1252,6 +1253,7 @@ CONFIG_SDM_GPUCC_845=3Dy
> >  CONFIG_SDM_VIDEOCC_845=3Dy
> >  CONFIG_SDM_DISPCC_845=3Dy
> >  CONFIG_SDM_LPASSCC_845=3Dm
> > +CONFIG_SDX_GCC_75=3Dy
> >  CONFIG_SM_CAMCC_8250=3Dm
> >  CONFIG_SM_DISPCC_6115=3Dm
> >  CONFIG_SM_DISPCC_8250=3Dy
> > @@ -1519,6 +1521,7 @@ CONFIG_INTERCONNECT_QCOM_SC7280=3Dy
> >  CONFIG_INTERCONNECT_QCOM_SC8180X=3Dy
> >  CONFIG_INTERCONNECT_QCOM_SC8280XP=3Dy
> >  CONFIG_INTERCONNECT_QCOM_SDM845=3Dy
> > +CONFIG_INTERCONNECT_QCOM_SDX75=3Dy
>
> Is there any criteria to make ICC built-in? I'd vote for built-in on all
> platforms to keep it aligned eventhough old platforms do not require it f=
or
> booting.

I'd say, we should be able to open the console without any additional
modules. Thus I support your idea.

>
> - Mani
>
> >  CONFIG_INTERCONNECT_QCOM_SM8150=3Dm
> >  CONFIG_INTERCONNECT_QCOM_SM8250=3Dm
> >  CONFIG_INTERCONNECT_QCOM_SM8350=3Dm
> > --
> > 2.25.1
> >
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D



--=20
With best wishes
Dmitry
