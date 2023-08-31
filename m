Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9846378F542
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347657AbjHaWDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHaWDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:03:09 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F701B2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:03:05 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d78328bc2abso1009666276.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693519385; x=1694124185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1Nhr+MlGU8motavYCyDqtqnGnLslEKTIGE/1NrcgH84=;
        b=bpd7oDZrgtdqG/vB/0Os+UGsLIYH4L8obUQ/ULomra6c/J5qjp0k2SGWk8TFd3FQhQ
         tTR0+wcZpp1hxau8hI9WMYuihlxKLwv96217DbG68+PaZe4h6Awk3PCUZD4w3jx4H+x+
         fz564XJROYDayfgvjx+08wB6qXWfBstFIac+4mRBA6K+YnP3ko4z+7lpqQK/ReMagNhQ
         dY+eNNeGYKOLrn+Cof51rU+yDsT7LVhqtJMOy0L4Bkp11Ue+OIicsUycNB1pOs57yVqm
         w7Bbig+0U2nbr+D+bDsi3uzy8HQnPjx0s5HewHYYVLzMdhny6d5Tac0BuvN09akSd2/Z
         d/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693519385; x=1694124185;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Nhr+MlGU8motavYCyDqtqnGnLslEKTIGE/1NrcgH84=;
        b=Mxy4iq31BXo4Qs+yuTpgro8YE2yvEdYGCEOoh/XmIHvVMNJqN2sVF/DBTU/zPPsR2E
         Wg8oGrfKFX++YwSLUKytSLQgh5ZbkIcmeF1KQ+Wg+BIrcx92qARSkhrMMVqDbp6SQZVs
         0ognoeNsSfUnyvSAwmLVU4sLzFOEv6Q17rMvLDnVmARuMMVJvBDho+a6AbNR6my3UtcJ
         NJ5TKpTzoHOL1vewY3qojDSboHIZzxoTqthOiAY9N5En7h1GnltvfCPUabK7gQYxZS0v
         hHgEsCIug7Egh7iTzAAGbe/gvW5eKlHfpcvy30OYEojFptC27ggJo+MjyCGsF3O+N8HV
         F+WQ==
X-Gm-Message-State: AOJu0Yx/EHysT3BMSJY7KIBNWVEW3EE7zSwyNaM5nJIxdFthyp4l7QdI
        TPaDj+Gl3aSn8sR6m4Z1+EhA/7x+prsBRiM7oLpriA==
X-Google-Smtp-Source: AGHT+IGu/8umP4ViODWJYwkjfphaRkMX0GAjallqMv7PlNEBVl3a9Cn1lw/JTW8EU9hrvomRWdeDj5CICMQ+IJSGZXE=
X-Received: by 2002:a25:cb52:0:b0:d4d:b6de:69bd with SMTP id
 b79-20020a25cb52000000b00d4db6de69bdmr1210138ybg.23.1693519384881; Thu, 31
 Aug 2023 15:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230217-topic-cpr3h-v14-0-9fd23241493d@linaro.org>
 <20230217-topic-cpr3h-v14-3-9fd23241493d@linaro.org> <CAPDyKFrXT+2NEMUzVv-kWjXAhLinXq99GKq4_Ge2VjthtYxtaA@mail.gmail.com>
 <20230831162835.GA2390385-robh@kernel.org> <f1f60df1-7632-48a2-a211-dcd6c1fa419f@linaro.org>
In-Reply-To: <f1f60df1-7632-48a2-a211-dcd6c1fa419f@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 1 Sep 2023 00:02:27 +0200
Message-ID: <CAPDyKFokY6F3dxhR3d8PyUwTvLOrt6+W=_JbfvGW_4XHHPaTsg@mail.gmail.com>
Subject: Re: [PATCH v14 3/9] dt-bindings: soc: qcom: cpr3: Add bindings for
 CPR3 driver
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
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

On Thu, 31 Aug 2023 at 18:40, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> On 31.08.2023 18:28, Rob Herring wrote:
> > On Tue, Aug 29, 2023 at 01:01:44PM +0200, Ulf Hansson wrote:
> >> On Mon, 28 Aug 2023 at 13:42, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>
> >>> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> >>>
> >>> Add the bindings for the CPR3 driver to the documentation.
> >>>
> >>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> >>> [Konrad: Make binding check pass; update AGdR's email]
> >>> Tested-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> >>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >>> ---
> >>>  .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    | 286 +++++++++++++++++++++
> >>>  1 file changed, 286 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
> >>> new file mode 100644
> >>> index 000000000000..acf2e294866b
> >>
> >> [...]
> >>
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    #include <dt-bindings/clock/qcom,gcc-msm8998.h>
> >>> +    #include <dt-bindings/interrupt-controller/irq.h>
> >>> +
> >>> +    cpus {
> >>> +        #address-cells = <2>;
> >>> +        #size-cells = <0>;
> >>> +
> >>> +        cpu@0 {
> >>> +            compatible = "qcom,kryo280";
> >>> +            device_type = "cpu";
> >>> +            reg = <0x0 0x0>;
> >>> +            operating-points-v2 = <&cpu0_opp_table>;
> >>> +            power-domains = <&apc_cprh 0>;
> >>> +            power-domain-names = "cprh";
> >>
> >> Rather than using a Qcom specific power-domain-name, perhaps a common
> >> power-domain-name for cpus, that can be used for "the performance
> >> domain" would be a good idea here?
> >>
> >> I have suggested using "perf" for the SCMI performance domain [1],
> >> perhaps that description should be extended to cover this and other
> >> performance domains too?
> >
> > Better yet, nothing. There's no value to -names when there is only 1
> > entry.
> As of today, it's required for devm_pm_opp_attach_genpd()
>
> Ulf, is there a better way to do this that doesn't require names?

In my opinion I think using names is valuable from a future and
flexibility point of view. To pick the proper name is another
question.

Anyway, in this case I think you should consider the case of
potentially having multiple power-domains for the cpu. Having both a
cpr(h) (for performance-scaling) and a psci (for power) power-domain
sounds like a combination that should already exist. Maybe not
upstream wise, but at least this is what I have been told to exist
several years ago by Qcom engineers.

Kind regards
Uffe
