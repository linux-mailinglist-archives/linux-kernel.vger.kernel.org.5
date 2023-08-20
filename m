Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE41782029
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 23:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbjHTVT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 17:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjHTVTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 17:19:24 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6E64EFC;
        Sun, 20 Aug 2023 14:05:30 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1c4d1274f33so1743452fac.3;
        Sun, 20 Aug 2023 14:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692565529; x=1693170329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYJNnbU74bFD9hOO6r8SqtnfQbVsJ6JUf4XpbDxQI/4=;
        b=VYvvXIPfbp6oj7zukU1xIAJ7zQuYMs6qKqGUOOPbCi4y0J82TALRurcVgTPKpIviV/
         OWIzQNMRLZu/rIXhxBTMX0CNgry3yfCothPmmQWDoos4Qr4+BODcVgGMUu2yEU/xsFu5
         0sk2U+JSKfdOSatvc6ghKvlH8Wtp+eA8exNfaVAS8jukR1wmXTXkPSPcdLS1IdxRAYMs
         zGUVmO/YV9IacVC3nffflio6WIQ0jkc7z8xx0tIyjq9wMlNRrqjj+2zyqSKQBDjnYGtB
         RpIWUaVj8o7yLuxLxbUz8YykQy4jMQGIIpC56VbWQr1FoWE+Nx3vQfvYM5RHV0i0fbHc
         5MFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692565529; x=1693170329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYJNnbU74bFD9hOO6r8SqtnfQbVsJ6JUf4XpbDxQI/4=;
        b=YFZF47lipsB5Cf/EecOZcfxSxb8kSxvuIVRYH/ohzvAanpQh3SXJ4ZeLZZWHUVW1NL
         UXba8tLeqMv5/8rDLN/QsKBS7bmjL7s09KhJxRWuZoNfREC73CCLpwRO05dhWn5IqkyH
         QUA/pIVzDvswcdqPDq0vWbVQNoI+J2WvKuDcpyURf59UhT9qHxkUCQBQx2ej17q5Xkse
         q0KtBqhtxxpfku5AtwK+6aiLtYSNUHC0VBSU01irnr2JF32hoNdGJP0/iVFV7oNtp/PI
         HW9G8NbEERCCJhiTbd4DHj9FiG7JC98HIURapAEbpXIgpVGCoDqMxlownVl8oqPuxb3e
         iOog==
X-Gm-Message-State: AOJu0YxknQX2w17DBQo/HGbcvKw3nM1HS5qKGVo1t0K3cJJyd0k7HvYG
        FIViQpiyjaTvKUX1QUUzBM9e03NzuGdcmr/CwMA=
X-Google-Smtp-Source: AGHT+IH3nthfQp95+TcBsYptvt9ZSdyYti+7boLwXDHruL5qv6FYYQ78Rq3UNQWZjF6a0405lF/0TiepHKxIStoGRoc=
X-Received: by 2002:a05:6870:f153:b0:1be:f46d:a26c with SMTP id
 l19-20020a056870f15300b001bef46da26cmr7517879oac.27.1692565529140; Sun, 20
 Aug 2023 14:05:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230820175655.206723-1-aford173@gmail.com> <f5b16676-04b9-7864-ffa7-1c48f3c2ca9c@linaro.org>
 <6089b46d-a580-af52-0cac-84b46fe11e6c@linaro.org>
In-Reply-To: <6089b46d-a580-af52-0cac-84b46fe11e6c@linaro.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Sun, 20 Aug 2023 16:05:16 -0500
Message-ID: <CAHCN7xJyOjKSXbm17roAJDbk-gDKQHprE9t1d4VH2uYSMZcEDg@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: fsl_easrc: Add support for imx8mp-easrc
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 20, 2023 at 3:33=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/08/2023 22:32, Krzysztof Kozlowski wrote:
> > On 20/08/2023 19:56, Adam Ford wrote:
> >> The i.MX8MP appears to have the same easrc support as the Nano, so
> >> add imx8mp as an option with a fallback to imx8mn.
> >>
> >> Signed-off-by: Adam Ford <aford173@gmail.com>
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml b/=
Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> >> index bdde68a1059c..2d53b3b10f2c 100644
> >> --- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> >> +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> >> @@ -14,7 +14,11 @@ properties:
> >>      pattern: "^easrc@.*"
> >>
> >>    compatible:
> >> -    const: fsl,imx8mn-easrc
> >> +    oneOf:
> >> +      - items:
> >> +          - enum:
> >> +              - fsl,imx8mp-easrc
> >> +          - const: fsl,imx8mn-easrc
> >
> > You need here also const for fsl,imx8mn-easrc, otherwise you do not
> > allow it alone. Test it for fsl,imx8mn-easrc DTS - you will notice warn=
ings.
>
> Actually, I see now Rob's report... you did not have to test DTS even.
> It was enough to test your change and this test was missing :(. Please
> test your changes before sending.

For what it's worth, I did run 'make dt_binding_check', but I didn't
run it with the extra flags from Rob's e-mail.  The tool didn't return
any errors.

adam

>
> Best regards,
> Krzysztof
>
