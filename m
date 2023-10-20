Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848DA7D126B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377626AbjJTPPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377807AbjJTPPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:15:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A11210C4;
        Fri, 20 Oct 2023 08:15:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41D7C433C8;
        Fri, 20 Oct 2023 15:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697814902;
        bh=fQWTPcxX2DTXkfY3FpRlIf4VIzmaST2HtcNdBmy+f1o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E6K6IoatxWWQ+lVg/PZxX9Q7T1Ekg7NYw5jKs0nsptV6TCXov2uZaeZTiH3YanVJn
         dW9sI7e2VAOaFofprb4gz2qVAUYfzESWOSTF3WfnQDknB3kAW8+H6JPYhgxwN3AEse
         qNMw+aZcaAGPJjGjXYfdsTt6cOGUauMRMMeYtzcgxHphWfFLkVEt6n906mCLFUnJCH
         lyxGIMxlYnoOXaUVA9I63VPQOWAjVirM6aENuDUVkdg4CRNlwrgB+Ao3fgrleN+cik
         sv8Yeg5piWIdogVAM13Z43kMVFqtKVu6IiFTIb6l5dhoJfGsYUnyvSdefL3LvDEKsY
         yIWA6SsnHE3rA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-507cd62472dso2332921e87.0;
        Fri, 20 Oct 2023 08:15:02 -0700 (PDT)
X-Gm-Message-State: AOJu0YwEr2PNlFPMa7KlJpYzRaofaoxc0XtMjdjynxtxZvEaOGdzKFUC
        5/mZJr1tMWCAM+mxZE852iNIlKG4eYTZoiwSkA==
X-Google-Smtp-Source: AGHT+IGOqTTM+pZlPxJbb1PzmIynWyFPKiahnRFqNvOq08Vu4pWF7xMH4GoE8Q4fjtpxgTCClRTvF4DhW3eoVcfs1XE=
X-Received: by 2002:a05:6512:108d:b0:500:acae:30c5 with SMTP id
 j13-20020a056512108d00b00500acae30c5mr1833965lfg.15.1697814900823; Fri, 20
 Oct 2023 08:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231005160550.2423075-1-quic_devipriy@quicinc.com>
 <20231005160550.2423075-3-quic_devipriy@quicinc.com> <20231018204608.qyifcnnzgi2bgzn6@pengutronix.de>
In-Reply-To: <20231018204608.qyifcnnzgi2bgzn6@pengutronix.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 20 Oct 2023 10:14:48 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+df_nmNVuf46-a5Dafe4THxD-5HS-BPsTn_yzTckrOJw@mail.gmail.com>
Message-ID: <CAL_Jsq+df_nmNVuf46-a5Dafe4THxD-5HS-BPsTn_yzTckrOJw@mail.gmail.com>
Subject: Re: [PATCH V15 2/4] dt-bindings: pwm: add IPQ6018 binding
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, thierry.reding@gmail.com,
        ndesaulniers@google.com, trix@redhat.com, baruch@tkos.co.il,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linux-pwm@vger.kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 3:46=E2=80=AFPM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello,
>
> On Thu, Oct 05, 2023 at 09:35:48PM +0530, Devi Priya wrote:
> > DT binding for the PWM block in Qualcomm IPQ6018 SoC.
> >
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Co-developed-by: Baruch Siach <baruch.siach@siklu.com>
> > Signed-off-by: Baruch Siach <baruch.siach@siklu.com>
> > Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> > ---
> > v15:
> >
> >   No change
> >
> > v14:
> >
> >   Picked up the R-b tag
> >
> > v13:
> >
> >   Updated the file name to match the compatible
> >
> >   Sorted the properties and updated the order in the required field
> >
> >   Dropped the syscon node from examples
> >
> > v12:
> >
> >   Picked up the R-b tag
> >
> > v11:
> >
> >   No change
> >
> > v10:
> >
> >   No change
> >
> > v9:
> >
> >   Add 'ranges' property to example (Rob)
> >
> >   Drop label in example (Rob)
> >
> > v8:
> >
> >   Add size cell to 'reg' (Rob)
> >
> > v7:
> >
> >   Use 'reg' instead of 'offset' (Rob)
> >
> >   Drop 'clock-names' and 'assigned-clock*' (Bjorn)
> >
> >   Use single cell address/size in example node (Bjorn)
> >
> >   Move '#pwm-cells' lower in example node (Bjorn)
> >
> >   List 'reg' as required
> >
> > v6:
> >
> >   Device node is child of TCSR; remove phandle (Rob Herring)
> >
> >   Add assigned-clocks/assigned-clock-rates (Uwe Kleine-K=C3=B6nig)
> >
> > v5: Use qcom,pwm-regs for phandle instead of direct regs (Bjorn
> >     Andersson, Kathiravan T)
> >
> > v4: Update the binding example node as well (Rob Herring's bot)
> >
> > v3: s/qcom,pwm-ipq6018/qcom,ipq6018-pwm/ (Rob Herring)
> >
> > v2: Make #pwm-cells const (Rob Herring)
> >
> >  .../bindings/pwm/qcom,ipq6018-pwm.yaml        | 45 +++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pwm/qcom,ipq6018-=
pwm.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yam=
l b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> > new file mode 100644
> > index 000000000000..6d0d7ed271f7
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pwm/qcom,ipq6018-pwm.yaml
> > @@ -0,0 +1,45 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pwm/qcom,ipq6018-pwm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm IPQ6018 PWM controller
> > +
> > +maintainers:
> > +  - Baruch Siach <baruch@tkos.co.il>
>
> Not being very fluent in dt and binding yaml I wonder if adding
>
>         allOf:
>           - $ref: pwm.yaml#
>
> would be beneficial?!

Not really because the only thing you pick up is #pwm-cells, but
that's still needed here since that varies by binding. A reference
generally becomes useful when there are child nodes (e.g. a bus
binding) or multiple properties.

> > +properties:
> > +  compatible:
> > +    const: qcom,ipq6018-pwm
> > +
> > +  reg:
> > +    description: Offset of PWM register in the TCSR block.
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  "#pwm-cells":
> > +    const: 2
>
> The driver only supports normal polarity. Is this a shortcoming of the
> driver, or is the hardware incapable to do that, too?
>
> If it's only the former I'd want #pwm-cells =3D <3> here. For ease of use
> I'd not oppose if you pick #pwm-cells =3D <3> even if the hardware can
> only do normal polarity.

Devi, Can we get an answer here soon.

The MFD part has been applied and it references this schema causing
warnings. So this needs to land or MFD schema reverted.

Rob
