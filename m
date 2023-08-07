Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E8D772A07
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 18:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjHGQEA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 12:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjHGQD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 12:03:58 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1213FE72;
        Mon,  7 Aug 2023 09:03:58 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1bba254a7d4so3657843fac.2;
        Mon, 07 Aug 2023 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691424237; x=1692029037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i0HzKgbYKKrvsEPlpYd7jVcrOdTWIpWoaM9sLQyzqjU=;
        b=T1KpFTPFFfg7EBXxFuTH79npAj9QZ6WzQgsj0rt5xhp0KzAdeaCPb712kYjt6k3mvP
         K0dpeMBIJUIVhbzaQj8JgX26qIhjkINkwpI2A31UZPM8OfwIkoXSbn6Aykj6bObWaAYE
         9QCaqthsx6x1DIm/L/rFaypSQ3AQDVuMkGZCJuaq8XwTGIptx6g6m40LIn+1hXsWGAD/
         BKGLopuvLpXV56emiXDHJo3fVT+nIsX+DpaRgwHBNrgKxVU8h1WY9s+xx/5MrsX0OGd1
         vxHUWbWA3HLJAIoCpjNm7DOWFzM0gXFO+2fVAOxqL4M0/uQ8Zg4FIgSKqQ4JwRwd2ahV
         XxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691424237; x=1692029037;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i0HzKgbYKKrvsEPlpYd7jVcrOdTWIpWoaM9sLQyzqjU=;
        b=ZExEHDkfYPXQn3joV6lEwFI9f1PEhrT3/CD1KbL7GYlAL0Ft6gcTu2Q3r7EHfT1876
         mbsCxBOmC5StoPqOMxaLkrS46aFHwLpogRlqWe1OtUEiaYcOgajO7F5+ViG+yXWdAvxQ
         WsNraVDrl72Qljukv+e2HyoFYYrqd4OYaAu0haRgRRxQGdO+qYun7fyDRTZmD0grA08K
         T5/hQbbk055UllblpFByRlkb8yygegWD5rzHYXO2p8ojk8JnFKEUM9hojR6yOolNt1e5
         A1EmhHPXIHmDtjfYymzv/tEuqrk9qFvei4nCF9ktQEKngMMYlg1q34PsS/Hw+OTIXGcd
         d9sw==
X-Gm-Message-State: AOJu0YxZcVDuSynl0og34Az20HzgFuB/IfGa8Goo1dDpbZtBzF2woLle
        uUGFRl3rI7i3JstKMPlR9zsEpv45vA8zZAkinvY=
X-Google-Smtp-Source: AGHT+IGByrGtGdbLv2uelLBwo0dxbfZy3X9Jlh6s0Niy41MuX4JTPdCN9HFcdski9pT/I3obFKA0M8RkE8hxR9FnPuk=
X-Received: by 2002:a05:6870:331e:b0:1be:ffae:29a3 with SMTP id
 x30-20020a056870331e00b001beffae29a3mr11079367oae.23.1691424237245; Mon, 07
 Aug 2023 09:03:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230726123747.4097755-1-james.hilliard1@gmail.com> <20230726-frosted-scroll-a42298d2ee9c@spud>
In-Reply-To: <20230726-frosted-scroll-a42298d2ee9c@spud>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Mon, 7 Aug 2023 10:03:45 -0600
Message-ID: <CADvTj4oPKyAx3szHhvphJ+cCpvwWaLZiTfaWZdWYQrmU5Aymxg@mail.gmail.com>
Subject: Re: [PATCH v7 1/3] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM with
 Custom Board
To:     Conor Dooley <conor@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Pierluigi Passaro <pierluigi.p@variscite.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
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

On Wed, Jul 26, 2023 at 12:26=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Wed, Jul 26, 2023 at 06:37:39AM -0600, James Hilliard wrote:
> > Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM with Custom Board.
> >
> > Cc: Pierluigi Passaro <pierluigi.p@variscite.com>
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documenta=
tion/devicetree/bindings/arm/fsl.yaml
> > index 2510eaa8906d..76bb098605e7 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -385,6 +385,12 @@ properties:
> >            - const: toradex,apalis_imx6q
> >            - const: fsl,imx6q
> >
> > +      - description: i.MX6Q Variscite VAR-SOM-MX6 Boards
> > +        items:
> > +          - const: variscite,mx6customboard
> > +          - const: variscite,var-som-imx6q
> > +          - const: fsl,imx6q
>
> I find it hard to tell what the sort order here is meant to be, but it
> appears to be first by what I.MX processor and then by the board
> compatibles? If so, this is added out of order.

Ordering follows the same pattern as say the "Variscite VAR-SOM-MX8MM
based boards", should it be different?

>
> > +
> >        - description: TQ-Systems TQMa6Q SoM (variant A) on MBa6x
> >          items:
> >            - const: tq,imx6q-mba6x-a
> > --
> > 2.34.1
> >
