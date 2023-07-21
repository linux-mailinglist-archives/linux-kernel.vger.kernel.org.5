Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C2875C3E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 11:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjGUJ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 05:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbjGUJ7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 05:59:54 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9C8E53;
        Fri, 21 Jul 2023 02:59:39 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b9a2416b1cso1453810a34.2;
        Fri, 21 Jul 2023 02:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689933579; x=1690538379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVCmE9om7HRCGz7LXgi6Eo/SJGDNZwu/x57C7FuYYPE=;
        b=agKMC/WHoC/RW/qz1TC62qS9TRpriAoBvjn19gFwp+1tPf3iThHuJu1tmhbIvZ9zB8
         B7F/JAJoskqmqRyKVROa5BgdVuhw4dqlJRsHmfj+wLt5jwzOj4ehMCvsn4r2ss7EqAvm
         aA7VI3toVxFyNZIjA4lGKningKm6mCyhRvJe6L+zMSe0uiDAcjIsgvvYxbJSFhLnLbuw
         xGrsZ1jYpoB4s1f75A3pxjA0O3F+IKxlZA4XkGlM5fuMxcUcayptWFQqlhlDfMSlfZ0Q
         H2sUDuFBZCKMuBp+HXEzHQmkkuwCSg7IDm3apyZ7PYtxFQ/szls9rPJmbRfOxOqLJhHB
         3pSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689933579; x=1690538379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JVCmE9om7HRCGz7LXgi6Eo/SJGDNZwu/x57C7FuYYPE=;
        b=jGfaCttqlAKUn79y9ASXOsR2LtlEXSWNrScSGaTATTlTGMXTjBWcClcd50lpfyg9mt
         12fKiRSoClb1L8q+OwCjxq4lwcMn61ZRalcqa7rhzZlNGqJOSc9UEI4a/BJbvNchkhvb
         dFVt3Isz91m5asmFYXrHixR/4moFJDpdzb31J+9Aua8jd7VIhSybxEKmYpd4Ws8meyp3
         cHGWyjMHDXF1NqLLqL7Sn3vpjf0+/VWC8TRmegssTDBdVA3cv3182apM4aywHG5x3WRU
         XHdNRg8ZNc6VhN+vFeRiHg+MMAEXh6NWl1SsfcEUmORR22TfI0+0tDzQ8Zh8tESWRueX
         KD1w==
X-Gm-Message-State: ABy/qLbmYctSxysvcFNyHhl8h41iJutXB8Z/0mrvhAoH0k9Q7fvA8cHN
        JzZMu2kW7Nk3DRACn1MBHJHidGPMRsl6JHtBlZW29KhfzPE=
X-Google-Smtp-Source: APBJJlHpWd+ACPBsbOGlrdkAPiNtIV1YfVaRn17v4MhK1gR69+QsdCy10JyFGLHcg6nMutgUlnTzcirdDpdiUxnHDaE=
X-Received: by 2002:a05:6871:8ac:b0:1ba:8222:a6d0 with SMTP id
 r44-20020a05687108ac00b001ba8222a6d0mr1860739oaq.34.1689933578890; Fri, 21
 Jul 2023 02:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230721095003.3681484-1-james.hilliard1@gmail.com> <5dd12391-3f67-043e-9dab-19e8d556cb86@linaro.org>
In-Reply-To: <5dd12391-3f67-043e-9dab-19e8d556cb86@linaro.org>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Fri, 21 Jul 2023 03:59:27 -0600
Message-ID: <CADvTj4qHMGfXUnOTVM=sD=398pUU+ewU9GpTu4L=7jFme9tmWg@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: arm: fsl: Add VAR-SOM-MX6 SoM
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
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
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 3:58=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/07/2023 11:49, James Hilliard wrote:
> > Add support for Variscite i.MX6Q VAR-SOM-MX6 SoM.
> >
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documenta=
tion/devicetree/bindings/arm/fsl.yaml
> > index 2510eaa8906d..da486c4a4ecf 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -385,6 +385,11 @@ properties:
> >            - const: toradex,apalis_imx6q
> >            - const: fsl,imx6q
> >
> > +      - description: i.MX6Q Variscite VAR-SOM-MX6 Boards
> > +        items:
> > +          - const: variscite,var-som-imx6q
>
> Again, this cannot be on its own. This commit does not make sense on its
> own.

So I should just combine this with patch 3?

>
> Best regards,
> Krzysztof
>
