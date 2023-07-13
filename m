Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38C0375290D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbjGMQtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbjGMQsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:48:45 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1C62D64
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:48:39 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-635e6f8bf77so5174266d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689266918; x=1691858918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zuZZdpDlXu2E+ps9F16vASGwEyrMSuGUChzbHgZ0Zbs=;
        b=Ogwo7zVaqznAygJZ64nNImcrzVqyHaNv1JhPNxCXMoYrn0vRt8xhbcP4qLsA/hHaCr
         6YqgywJHZLKtAZ3Xi+JFu9W82Iv59mNGnx8UQgHPfUIKlB7cq+ZRuGSIwskgs+8PP0me
         bCLT31PX1RJOdqyTZl490fK+v4f/x9LBvXlVA5Vqkp357+/ru6ASnkg3+S+pzWdXeWQj
         khN23h7A6iGMRVSJ29G8BsWlwtUAnE0s1RlbPMuoDi13f50rIIiIwJ5/R6WUJ46U9Bpp
         8Hk99ouZpIetg22Y1sn+jcXCPABe0lcId4t3tBbtC3K2fTu6Gbl7aVyMWW/FMOXNjKKc
         1f6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689266918; x=1691858918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuZZdpDlXu2E+ps9F16vASGwEyrMSuGUChzbHgZ0Zbs=;
        b=RQtAEM48iQe1cll4kqPjZ2LEjBkSJrFRA3z0vX41aq5wXCA0FxeJvh4wG4LCVh4YZz
         snrnQagweXRzCvfU6+6jAlYIMOSMOBu0h384YJwuOdUUg8ddepp6KEMTdAWRKQ5a8Fu3
         jHXVh6+XiwUKUniR/I48gQ4V+2Ozbde82JqTxRhCZ0qv24SytwNC1CqD8xDkGAdqPmTI
         E4wuzhsAKo269i933itNAuXwODSIxIM5kmOv6X3EpJ9xixG8v0SHHE+wvuvOGZpEEU2q
         a24AeHCrfK6ZVC6pwaQIKPVlI6YRpCaSZxEtbXhqdzT7FfLX/wSgjv4uy2dQ0zA2NHq2
         +hwQ==
X-Gm-Message-State: ABy/qLah0sSczFLlYTijwsFhGYPQfaPIB4miOn6vyCXbNVx6bvlQEaEA
        0kmf/+09LdtEnekj7QSi1ZKQSF7FQD3ATRbYmaaS9Q==
X-Google-Smtp-Source: APBJJlHZwOI2tfJYeqnIeiHgdRI9RlwmUCq3/HcwtNHtwOl/71PhsX6rco20RR1e9u0i0qN9ydSDmR92GEl8DF+4B7U=
X-Received: by 2002:a0c:e0c9:0:b0:635:dfe1:c203 with SMTP id
 x9-20020a0ce0c9000000b00635dfe1c203mr1754444qvk.64.1689266918558; Thu, 13 Jul
 2023 09:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230712130215.666924-1-amit.pundir@linaro.org>
 <3b677200-a201-680b-391f-fbf73064496a@linaro.org> <CAMi1Hd003r1kJ6e4r2urFtN1BEnCRatLcQ1Q7Eh5wBdj=2WDFA@mail.gmail.com>
 <CAA8EJpp6yprRL3qzM9pHt2uJ6sb-nPhwas5qm9aDthegSaw7DQ@mail.gmail.com>
In-Reply-To: <CAA8EJpp6yprRL3qzM9pHt2uJ6sb-nPhwas5qm9aDthegSaw7DQ@mail.gmail.com>
From:   Amit Pundir <amit.pundir@linaro.org>
Date:   Thu, 13 Jul 2023 22:18:02 +0530
Message-ID: <CAMi1Hd14Y4bByO9abr-nFppS2m5CiSyLVQ9ev7+bx55rRL5GjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: display/msm: qcom,sdm845-mdss: add
 memory-region property
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Bryan Donoghue <bryan.odonoghue@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023 at 21:13, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Thu, 13 Jul 2023 at 18:34, Amit Pundir <amit.pundir@linaro.org> wrote:
> >
> > On Wed, 12 Jul 2023 at 18:45, Dmitry Baryshkov
> > <dmitry.baryshkov@linaro.org> wrote:
> > >
> > > On 12/07/2023 16:02, Amit Pundir wrote:
> > > > Add and document the reserved memory region property
> > > > in the qcom,sdm845-mdss schema.
> > > >
> > > > Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> > > > ---
> > > >   .../devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml    | 5 +++++
> > > >   1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
> > > > index 6ecb00920d7f..3ea1dbd7e317 100644
> > > > --- a/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
> > > > +++ b/Documentation/devicetree/bindings/display/msm/qcom,sdm845-mdss.yaml
> > > > @@ -39,6 +39,11 @@ properties:
> > > >     interconnect-names:
> > > >       maxItems: 2
> > > >
> > > > +  memory-region:
> > > > +    maxItems: 1
> > > > +    description:
> > > > +      Phandle to a node describing a reserved memory region.
> > > > +
> > >
> > > Please add it to mdss-common.yaml instead
> >
> > mdss-common.yaml didn't like this property at all and
> > I ran into a lot of new dtbs_check warnings:
> > https://www.irccloud.com/pastebin/raw/pEYAeaB1
> >
> > I need some help in decoding these please.
>
> I'm not sure what happened there (and it's hard to understand without
> seeing your patch).

Yup.. It was my broken patch. I used "For example:" in the property
description and it tripped off the checks. Didn't realise that
casually used ":" can break yaml parsing until now. Sorry for all the
noise.

Regards,
Amit Pundir

> But after applying your patch to mdss-common.yaml,
> `make dt_binding_check' passes:
>
> diff --git a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> index ccd7d6417523..924fe383e4a1 100644
> --- a/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> +++ b/Documentation/devicetree/bindings/display/msm/mdss-common.yaml
> @@ -77,6 +77,11 @@ properties:
>      items:
>        - description: MDSS_CORE reset
>
> +  memory-region:
> +    maxItems: 1
> +    description:
> +      Phandle to a node describing a reserved memory region.
> +
>  required:
>    - reg
>    - reg-names
>
>
> >
> > Regards,
> > Amit Pundir
> >
> > >
> > > >   patternProperties:
> > > >     "^display-controller@[0-9a-f]+$":
> > > >       type: object
> > >
> > > --
> > > With best wishes
> > > Dmitry
> > >
>
>
>
> --
> With best wishes
> Dmitry
