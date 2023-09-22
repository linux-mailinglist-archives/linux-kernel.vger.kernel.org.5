Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B6C7AB4BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 17:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjIVP1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 11:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjIVP1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 11:27:05 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85507A1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:26:58 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-5315b70c50dso2688355a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 08:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695396417; x=1696001217; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ehhS94nOYDx67I5UrhN7dvh/Dlk6jqSDrmSSvlfrbig=;
        b=FK+fR5P8nkt9huqrgibuOxwp4Wbtbmm0+PxAJ+FAtIAhsTpsnlOpR4Q2clSlOYaSID
         6CpxIv3hDrOj2enX8lMzq1zSEzlZXJ4i+xOtDjsxrpD6k1X1JxI4Zq2nZmeJLaOaR/p2
         f4KB7rTmdNNIvT+sjWq/oyPAlOk2f4Lst3BWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695396417; x=1696001217;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ehhS94nOYDx67I5UrhN7dvh/Dlk6jqSDrmSSvlfrbig=;
        b=XmCAa+xRqHibg0LEeZ1qUMI5dGZshiUL7vUCWnPWUiVxHjE1+l2tTXVnFYXmaPOQQ2
         lnoKWQPjhNYDovLXBXeTUlulwzICdzjKNnQx6wJ93DMTzcgBjUnPwC7vtZXuhOPdH0ZM
         yLPJjKA8b50kd1A85tr3opmzEX5oXO6l/Tz7y4AiaNXh4GPWph5dZKIS2bn6bfaXtm0t
         Di8C/lpqaNpLBHD3H2iSt9B6Xu93I8FJXHsyGO4F/1vFWgjnmPKsaRlJEcq8MqUamzAQ
         f8DueajqmD1w4Jp0Mgzz8XuW/szPolM+DVGkJCg8AaEfy2jg+vWji9lVShEQwCJ4P9CJ
         m45A==
X-Gm-Message-State: AOJu0YzfpYusITWVuO/nIqaKRbtxN95JPnJiTA2/aCc0LQ3B60ulK/qC
        F+BOir1MR/NNhFOq2qinmxNFFeKz0sLRebHbmdvPlQ==
X-Google-Smtp-Source: AGHT+IFoGrL2e/v7oEth7xaYwVHjp41m5T5R1E9Jh7pwjgOEp/hjouucyihvUHkWO43wehoYyZSTEdxlA2dO6pUlS5M=
X-Received: by 2002:aa7:cd18:0:b0:530:c880:9171 with SMTP id
 b24-20020aa7cd18000000b00530c8809171mr8099822edw.27.1695396416625; Fri, 22
 Sep 2023 08:26:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230921124459.1.I91ddcfacf9b234af5cc3eabea4b62edb31153317@changeid>
 <da77e965-2893-097a-b438-85787c43dcb0@linaro.org>
In-Reply-To: <da77e965-2893-097a-b438-85787c43dcb0@linaro.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Fri, 22 Sep 2023 09:26:38 -0600
Message-ID: <CAPnjgZ2EyWxwCfUi6vHby4tYUfH0Dw6nfC7tOo-g4ahKhTMRjg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mtd: Add a schema for binman
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org, Tom Rini <trini@konsulko.com>,
        Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dhruva Gole <d-gole@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, 22 Sept 2023 at 01:02, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 21/09/2023 20:45, Simon Glass wrote:
> > Binman[1] is a tool for creating firmware images. It allows you to
> > combine various binaries and place them in an output file.
> >
> > Binman uses a DT schema to describe an image, in enough detail that
> > it can be automatically built from component parts, disassembled,
> > replaced, listed, etc.
> >
> > Images are typically stored in flash, which is why this binding is
> > targeted at mtd. Previous discussion is at [2] [3].
> >
> > [1] https://u-boot.readthedocs.io/en/stable/develop/package/binman.html
> > [2] https://lore.kernel.org/u-boot/20230821180220.2724080-3-sjg@chromium.org/
> > [3] https://www.spinics.net/lists/devicetree/msg626149.html
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >  .../bindings/mtd/partitions/binman.yaml       | 50 +++++++++++++++
> >  .../bindings/mtd/partitions/binman/entry.yaml | 61 +++++++++++++++++++
> >  .../bindings/mtd/partitions/partitions.yaml   |  1 +
> >  MAINTAINERS                                   |  5 ++
> >  4 files changed, 117 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > new file mode 100644
> > index 00000000000000..c792d5a37b700a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/binman.yaml
> > @@ -0,0 +1,50 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2023 Google LLC
> > +
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/partitions/binman.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Binman firmware layout
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +description: |
> > +  The binman node provides a layout for firmware, used when packaging firmware
> > +  from multiple projects. For now it just supports a very simple set of
> > +  features, as a starting point for discussion.
> > +
> > +  Documentation for Binman is available at:
> > +
> > +  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html
> > +
> > +  with the current image-description format at:
> > +
> > +  https://u-boot.readthedocs.io/en/latest/develop/package/binman.html#image-description-format
> > +
> > +properties:
> > +  compatible:
> > +    const: u-boot,binman
> > +
> > +required:
> > +  - compatible
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    firmware {
> > +      binman {
> > +        compatible = "u-boot,binman";
> > +
> > +        u-boot {
>
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint.

Yes this came out of dt-schema and I assumed it was similar. I will rework it.

>
>
> > +          size = <0xa0000>;
> > +        };
> > +
> > +        atf-bl31 {
> > +          offset = <0x100000>;
> > +        };
> > +      };
> > +    };
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
> > new file mode 100644
> > index 00000000000000..8003eb4f1a994f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/binman/entry.yaml
> > @@ -0,0 +1,61 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2023 Google LLC
> > +
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/partitions/binman/entry.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Binman entry
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +description: |
> > +  The entry node specifies a single entry in the firmware.
> > +
> > +  Entries have a specific type, such as "u-boot" or "atf-bl31". If the type
> > +  is missing, the name is used as the type.
> > +
> > +  Note: This definition is intended to be hierarchical, so that entries can
> > +  appear in other entries. Schema for that is TBD.
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "^[-a-z]+(-[0-9]+)?$"
>
> Why do you need this?

It seemed to be needed in dt-schema. I will drop it.
Regards,
Simon
