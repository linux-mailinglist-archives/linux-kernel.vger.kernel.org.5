Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C255475A1D7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGSWZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjGSWZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:25:10 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CBB26B0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:24:45 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id ada2fe7eead31-44358c019ddso92717137.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689805478; x=1690410278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=26dnrZdbOXwc7V0lFcAmHMacjxZ28I9Y/ukTqEwlwaE=;
        b=KFVFuviOl0sIUexTYybNWDONi7gLdbLEDjD0lt6rVTHlqBwAyvQ7aGNxy9IJLJPIOC
         She10h/pcQNeCh2WX3NYUkCldqNXRxnvsCZL6Pf22XYj3mp/R2H8o/YZPnxHyVzk8tJZ
         nNgzAT56tRd7F/dnUHsr00pmut/2vdPOT9kDLJLGlO/FwTSwqohcxC1FWUMSENvYkhjI
         02uQSpj8hlxp6Lx+IbVRWxx7HjOzaIiqtpHsv34K53oy9QJwt91kOs4uVT27DjBH48lP
         ees62wLPYy7lAWmd0D/GiQjExxemKUybfoE/Ehd2E8KF4fXEcgYVq87vpjRod1fnwQcy
         qCWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805478; x=1690410278;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=26dnrZdbOXwc7V0lFcAmHMacjxZ28I9Y/ukTqEwlwaE=;
        b=aqPEC1Vf9Rua80YPjvnuIPO1pX42CGuFg8aKgR4HKeWg/M8hca2/sDzH0r8ggiXh8t
         8mYORxnJquhEklod4WWu8A2predGTia8TXEHNI0eApptLgUMtb+rAIps2mmEhBiIAnu0
         8Ticzc7yE/MW2vSg1uajaizeCid84kpJSubzrG4/UB9V2wfjJH9FD311sXIi8OBG6EFp
         tfod6+e4BfXK0a7mBmvI52RW9iRcQGjA5Y7EueiFtYE0IFZYZULopodH0MQZ1Qlsci50
         NuJcA888FZDDb5FVnxMN2jGYUgigCM3PJlbjkr6ybhO/RRbGglcVvIdKE1cNqTvPXjyl
         dLHg==
X-Gm-Message-State: ABy/qLab55AWpYzvNjWUa+EqijfsH9e+C80B3IAP/9Cf2MEcuHPKzoh/
        k1DjGpoTyjtRWWqrBP8JhBDyXdabKa3EfhdQ71FFAA==
X-Google-Smtp-Source: APBJJlHqWAyz6LumuvPI+kV38qbnV5QfCFxoeJLB0UnlwATacEi9dTeimWC/QN650Sv8DUBzTmd98lSsvTr3Ot8qPW4=
X-Received: by 2002:a67:f5c1:0:b0:443:8f10:7f72 with SMTP id
 t1-20020a67f5c1000000b004438f107f72mr10614432vso.14.1689805478306; Wed, 19
 Jul 2023 15:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230718-sm6125-dpu-v3-0-6c5a56e99820@somainline.org>
 <20230718-sm6125-dpu-v3-6-6c5a56e99820@somainline.org> <3ce19d8f-97d8-15b6-5148-78e200b112e9@linaro.org>
 <tpkiplw7l2mzdwekynkrg6dwm7svktwm2zooodb3c42btyvo3e@yjrpqem26wtx>
In-Reply-To: <tpkiplw7l2mzdwekynkrg6dwm7svktwm2zooodb3c42btyvo3e@yjrpqem26wtx>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 20 Jul 2023 01:24:27 +0300
Message-ID: <CAA8EJprHEes5T1z4-sxg_Xk+VjuyoTH0Ra-VyMnrWjTv7qG9EA@mail.gmail.com>
Subject: Re: [PATCH v3 06/15] dt-bindings: display/msm: sc7180-dpu: Describe SM6125
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, Lux Aliaga <they@mint.lgbt>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023 at 01:09, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2023-07-19 01:06:03, Dmitry Baryshkov wrote:
> > On 19/07/2023 00:24, Marijn Suijten wrote:
> > > SM6125 is identical to SM6375 except that while downstream also defines
> > > a throttle clock, its presence results in timeouts whereas SM6375
> > > requires it to not observe any timeouts.  This is represented by
> > > reducing the clock array length to 6 so that it cannot be passed.  Note
> > > that any SoC other than SM6375 (currently SC7180 and SM6350) are
> > > unconstrained and could either pass or leave out this "throttle" clock.
> >
> > Could you please describe, what kind of timeouts do you observe? Is this
> > the DSI underruns issue?
>
> Ping-pong timeouts and low(er) framerate.  However, they were previosuly
> not happening on a random boot out of tens... and now I can no longer
> reproduce the timeout on 4 consecutive boots after adding the throttle
> clock.  Could it perhaps be the power domains and opps that we added in
> v2 and v3?

Quite unlikely, but who knows. My main question is whether we should
continue skipping the throttle clocks or if it should be enabled now.

>
> We previously discussed in DMs that the rate was bouncing between 25MHz
> and 403MHz without the clock specified, and with it it it got set at 385
> or 403MHz.  Now, a month or so later, repeatedly running this command
> shows 25MHz when the panel is not being refreshed, and between 337 and
> 403MHz on modetest -r -v:
>
>     sony-pdx201 ~ $ sudo ./debugcc -p sm6125 gcc_disp_throttle_core_clk
>                 gcc_disp_throttle_core_clk: 337.848277MHz (337848277Hz)
>
> Either all these boots are flukes, or it is really fixed and this patch
> should be revised...
>
> > If so, it might be fixed by the MDSS
> > interconnect fix ([1]).
> >
> > [1] https://patchwork.freedesktop.org/series/116576/
>
> Might have an effect but I don't have any interconnects defined in this
> SoC DT yet.
>
> - Marijn
>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > ---
> > >   .../devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml   | 14 ++++++++++++++
> > >   1 file changed, 14 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> > > index 630b11480496..37f66940c5e3 100644
> > > --- a/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> > > +++ b/Documentation/devicetree/bindings/display/msm/qcom,sc7180-dpu.yaml
> > > @@ -15,6 +15,7 @@ properties:
> > >     compatible:
> > >       enum:
> > >         - qcom,sc7180-dpu
> > > +      - qcom,sm6125-dpu
> > >         - qcom,sm6350-dpu
> > >         - qcom,sm6375-dpu
> > >
> > > @@ -73,6 +74,19 @@ allOf:
> > >           clock-names:
> > >             minItems: 7
> > >
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          const: qcom,sm6125-dpu
> > > +
> > > +    then:
> > > +      properties:
> > > +        clocks:
> > > +          maxItems: 6
> > > +
> > > +        clock-names:
> > > +          maxItems: 6
> > > +
> > >   examples:
> > >     - |
> > >       #include <dt-bindings/clock/qcom,dispcc-sc7180.h>
> > >
> >
> > --
> > With best wishes
> > Dmitry
> >



-- 
With best wishes
Dmitry
