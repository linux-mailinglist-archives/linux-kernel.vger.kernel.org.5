Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FD0782CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236030AbjHUPEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbjHUPEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:04:04 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A1FE2;
        Mon, 21 Aug 2023 08:04:03 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bdcb800594so19697575ad.1;
        Mon, 21 Aug 2023 08:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692630243; x=1693235043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CqUh9skgpVHURP/Wnzp8MkCvg8JvCVWZ/A+CKRy7nI=;
        b=Wg/BO/gU5DjathycsdyIdaVkk4uKAhzGdSMJU6rd0JjzVAgz3pW2KZEFdLMROs3K9l
         pGTWwjqVJZlzRqEH3NBRypbuVvJOTLVYo+SDYWUUOGT1XAv9aJzwsgDo9XPZYxxn545M
         Cm00woQdEVJGXFDHBs9SHQPEPJvCIuQ7FeDDZ/GQ0H0UriA2y8krkIIRqED7P5Tc6TV0
         xV7VXsvj17AFj5wktkbdhVMmSby6ZHJpaXmbCjP4lYZpp+4SQyicKr7lHfLIHdjd51r1
         igwaovDa2r1xsRm7axVEQEiTZaL1jIGj9wVXbPjIYnr1vdOtkHkzzyee+bjhweeH3x6j
         3iUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692630243; x=1693235043;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0CqUh9skgpVHURP/Wnzp8MkCvg8JvCVWZ/A+CKRy7nI=;
        b=lQTVhjk0i4E0L1afKX7Xsl5MYlJec+ZMrtwaaGbsK/zBxgUokKwbYhx7O/VoTyjKLH
         8u7/YnaACcDRYZTLrLxqiVte6ojZAUdzO/XE119NSkpP1HgcpilZ9TiR9T4SW3ODuQTq
         9mhB0fA5i4vzPYdERfbFS4Ilum5uiwcjcVXOGVirMKlSgu9JilBuIJ1he8j71WyC6MYK
         ibGyjkUthTJwB4SPAVqbdBiWRdJzQkoUSxCNgvuiy4SiPFC+e+rb/7hChIHJLuooyY/+
         kGfpudlMxGS5I3/YjKytTOuYijf+JJxyz1VNoIcKKGBHfLcmVesC3nqouUMVgAspVCfg
         sr+g==
X-Gm-Message-State: AOJu0Yz7zld4uBJmqRrPY1t38XtypnxtG0md0G/PU7OeCKPkmCQMfFGk
        ityKnoZ88JauwxGWrAqTA7PIz46csGKXk0NzVp0=
X-Google-Smtp-Source: AGHT+IFiefGRjQhKwC66LQhERuF3DhfgmpQjrGA9OfwXu1NR1QIKeVOYGsAI4DZrDaxlNMwRiomEzPx7mp9QdkLU6M4=
X-Received: by 2002:a17:90b:3712:b0:26b:4ce1:9705 with SMTP id
 mg18-20020a17090b371200b0026b4ce19705mr4100514pjb.38.1692630242691; Mon, 21
 Aug 2023 08:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230820175655.206723-1-aford173@gmail.com> <f5b16676-04b9-7864-ffa7-1c48f3c2ca9c@linaro.org>
 <6089b46d-a580-af52-0cac-84b46fe11e6c@linaro.org> <CAHCN7xJyOjKSXbm17roAJDbk-gDKQHprE9t1d4VH2uYSMZcEDg@mail.gmail.com>
 <20230821140622.GA1473812-robh@kernel.org>
In-Reply-To: <20230821140622.GA1473812-robh@kernel.org>
From:   Adam Ford <aford173@gmail.com>
Date:   Mon, 21 Aug 2023 10:03:51 -0500
Message-ID: <CAHCN7xL4SDR=QOXhFPQyppcH5tsJJOuREuHzJVyrFS8B7oKexw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: fsl_easrc: Add support for imx8mp-easrc
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 9:06=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Sun, Aug 20, 2023 at 04:05:16PM -0500, Adam Ford wrote:
> > On Sun, Aug 20, 2023 at 3:33=E2=80=AFPM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 20/08/2023 22:32, Krzysztof Kozlowski wrote:
> > > > On 20/08/2023 19:56, Adam Ford wrote:
> > > >> The i.MX8MP appears to have the same easrc support as the Nano, so
> > > >> add imx8mp as an option with a fallback to imx8mn.
> > > >>
> > > >> Signed-off-by: Adam Ford <aford173@gmail.com>
> > > >>
> > > >> diff --git a/Documentation/devicetree/bindings/sound/fsl,easrc.yam=
l b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> > > >> index bdde68a1059c..2d53b3b10f2c 100644
> > > >> --- a/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> > > >> +++ b/Documentation/devicetree/bindings/sound/fsl,easrc.yaml
> > > >> @@ -14,7 +14,11 @@ properties:
> > > >>      pattern: "^easrc@.*"
> > > >>
> > > >>    compatible:
> > > >> -    const: fsl,imx8mn-easrc
> > > >> +    oneOf:
> > > >> +      - items:
> > > >> +          - enum:
> > > >> +              - fsl,imx8mp-easrc
> > > >> +          - const: fsl,imx8mn-easrc
> > > >
> > > > You need here also const for fsl,imx8mn-easrc, otherwise you do not
> > > > allow it alone. Test it for fsl,imx8mn-easrc DTS - you will notice =
warnings.
> > >
> > > Actually, I see now Rob's report... you did not have to test DTS even=
.
> > > It was enough to test your change and this test was missing :(. Pleas=
e
> > > test your changes before sending.
> >
> > For what it's worth, I did run 'make dt_binding_check', but I didn't
> > run it with the extra flags from Rob's e-mail.  The tool didn't return
> > any errors.
>
> The error is not related to the '-m' (undocumented compatible) warning.
> It is as Krzysztof said.

I was able to replicate the message after I updated the schema.  Is
there any way we can add the dt_binding_check to the 'make help' menu?
 I do this so infrequently that I don't necessarily know what the
proper flags are, and I sometimes forget to update the schema.  I have
seen others run into similar issues, so it seems like having it in the
help menu might be beneficial to more people.

adam

>
> Rob
