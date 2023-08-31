Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C538678F4D1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 23:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347610AbjHaVs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 17:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347613AbjHaVsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:48:25 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD07ACF3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:48:18 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d71dd633f33so1009406276.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693518498; x=1694123298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vYQm3HLTVW0PLSRJWbeaTbNjeFSBbaECmMIm+40Gbmk=;
        b=yd/40IO2G+j0u0NQqPr0r5ze685Tm8YwWkrpW3hhdJ2pGzVxwAmB1isM0N74o3bB5x
         WwbaCYOL/x1y2pcBYBhRJd6TqC2RPP2683Mq41sUamjSfroUelKphqBthsNN5YC9arFn
         vHRjSWiCIRxA8fBXsDfk4nExZTt5u7l5Ug3dRc4MnWkpzMWjY7qVZp4xc2D1jtrfmTaj
         XJouyoVcUzAN0nIooeE57yn5XYLMMWnRdv4M2Kd1OPV86vSSUwJypNojoNFnLsjc610l
         PWr5KIpljhyf/6EN3C2PsRGeaOp6TE7643CJc/FxwJBZ6/e+9+Xb2Y27PCsKEdnxwvta
         HADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693518498; x=1694123298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYQm3HLTVW0PLSRJWbeaTbNjeFSBbaECmMIm+40Gbmk=;
        b=Sxm4iNNexdJn48f31zkoV2urMmVAxg/FvjOzsIsRAZqEnZDl89cZ36C0QaXoWxaSUZ
         dzaFCAdej50IPgAtyDDVUY5Hiu2G0YsnA+2ceYhe44PseWstBbYEPe9ABqMLIihwNUxV
         SiAyZ5Yu1eAocNllg0SD3ernCJE2cm5uHKQPLHYwZ7PZL05F8/bm7pF7JSZFMSi7SCeR
         nUfgCzAraMQ1D4x0CmjWcifBahw+OP/cqB+fQuWcNdWt5+wpqG1pCTbUWmd+8U9x0+KF
         LKQEz13xUUE6pKKRfkhSxolN+Eb5ktftosqjp7i9jNjoQOHpUbtzIyhcGFbBVsNV4V1y
         te+A==
X-Gm-Message-State: AOJu0Yx1B+HrVba1gE9CVAymlQ1P3xiZpDNkh7ruxsoFtyGmtWD5dFOS
        b2kBSxB5mryQgufh6SVB/ENbiMhSILBUNulwXZ+BvRnqCsu5OOK5baZe8A==
X-Google-Smtp-Source: AGHT+IGUdiOKQp2YoszPk/mqnRyLATy++xSQZaMCP71grCQFvhU122vT3LwQYefcUXv4RXe/FHdk3jTendYgMlkPz/o=
X-Received: by 2002:a25:e082:0:b0:d7b:9f03:20c9 with SMTP id
 x124-20020a25e082000000b00d7b9f0320c9mr1026573ybg.10.1693518498053; Thu, 31
 Aug 2023 14:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
 <20230217-topic-cpr3h-v14-3-9fd23241493d@linaro.org> <CAPDyKFrXT+2NEMUzVv-kWjXAhLinXq99GKq4_Ge2VjthtYxtaA@mail.gmail.com>
 <20230831162835.GA2390385-robh@kernel.org>
In-Reply-To: <20230831162835.GA2390385-robh@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 31 Aug 2023 23:47:40 +0200
Message-ID: <CAPDyKFrpumkD0fPwgu_0xr1q3XM3t+U5rT9nj0Cg78tF9CGZ0w@mail.gmail.com>
Subject: Re: [PATCH v14 3/9] dt-bindings: soc: qcom: cpr3: Add bindings for
 CPR3 driver
To:     Rob Herring <robh@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 18:28, Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Aug 29, 2023 at 01:01:44PM +0200, Ulf Hansson wrote:
> > On Mon, 28 Aug 2023 at 13:42, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> > >
> > > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > >
> > > Add the bindings for the CPR3 driver to the documentation.
> > >
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > > [Konrad: Make binding check pass; update AGdR's email]
> > > Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > > Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > ---
> > >  .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    | 286 +++++++++++++++++++++
> > >  1 file changed, 286 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
> > > new file mode 100644
> > > index 000000000000..acf2e294866b
> >
> > [...]
> >
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/qcom,gcc-msm8998.h>
> > > +    #include <dt-bindings/interrupt-controller/irq.h>
> > > +
> > > +    cpus {
> > > +        #address-cells = <2>;
> > > +        #size-cells = <0>;
> > > +
> > > +        cpu@0 {
> > > +            compatible = "qcom,kryo280";
> > > +            device_type = "cpu";
> > > +            reg = <0x0 0x0>;
> > > +            operating-points-v2 = <&cpu0_opp_table>;
> > > +            power-domains = <&apc_cprh 0>;
> > > +            power-domain-names = "cprh";
> >
> > Rather than using a Qcom specific power-domain-name, perhaps a common
> > power-domain-name for cpus, that can be used for "the performance
> > domain" would be a good idea here?
> >
> > I have suggested using "perf" for the SCMI performance domain [1],
> > perhaps that description should be extended to cover this and other
> > performance domains too?
>
> Better yet, nothing. There's no value to -names when there is only 1
> entry.

The above is just an example of a consumer node for a cpu. The
bindings for cpus are in
Documentation/devicetree/bindings/arm/cpus.yaml.

Please have a look there. We don't even have a maxItems specified for it.

Kind regards
Uffe
