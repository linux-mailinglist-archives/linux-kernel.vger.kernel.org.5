Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5C17B8479
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbjJDQGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbjJDQGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:06:11 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A215C0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 09:06:04 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso750166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Oct 2023 09:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696435562; x=1697040362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JXMY0UlzCXXysobfPTUw3MvymyulfDMm4djV4xjuSLo=;
        b=ZVa3RbpwCT1AiRfWJqPz+yV61jZMJz4Ltv/Fo0omcqeAmEtfAc9x4VlJOw90ukIynr
         VOmqQ559D2IpWxHPKnDuE498p+GQtv2rQIwaP71l+Gcp2bCoW7ddu2hUtEwRv7KeOHjp
         Kql7MgV6qK77+KMiMQT6KVkcUSdgJcfKsVC5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696435562; x=1697040362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXMY0UlzCXXysobfPTUw3MvymyulfDMm4djV4xjuSLo=;
        b=WCf4hX/DQ5RKVZugSnNCHBmVQ5xTsBmr9jZF7XFqTJdaaLn/zeZ7ZrO/+bGH5K02i7
         JRwthgfvSqQce/RHIc+AE56wjrjiUbnXIXrAiYRCrIdAKaj4EGNWEzZkWte4oLSamazg
         Gtmvv26HCwFheP5+jQtQMXHz2AzL7NFGix1sqHpj/18PrQn2CRcxtnh1ZCtEqFSlSjp2
         jqLJnzLPKubHnt3PgfsuAadOBjJRKc6iC8/NXcI6xCXwpQKTNTwziY0zxpX+tUtFYKyv
         Lm+ZF26GIEML0pY19fFZ4GOnO0tVij9WUgEuHcEy0LmVdfgFUMoDYjevQ1iLxINhkFXn
         c5hA==
X-Gm-Message-State: AOJu0Yxe3mnoVXyai3HPgFHqesYrxL8qPvR3nOuW2Azp4gacfRER/al8
        Er53v0zk09wpTm+1CJeesapRYjg3gDH+YfB4hhCrww==
X-Google-Smtp-Source: AGHT+IGqVaYwYjDX7LnINduPH2/9kJQhL4we82kv8wvcqWvPtz+C2ElHBSAuMC4vIAj9ICBYHQriteVS30W2xb61XAI=
X-Received: by 2002:a17:906:23e9:b0:9b2:c583:cd71 with SMTP id
 j9-20020a17090623e900b009b2c583cd71mr2451474ejg.50.1696435562091; Wed, 04 Oct
 2023 09:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231002174948.1015223-1-sjg@chromium.org> <20231004093620.2b1d6917@xps-13>
In-Reply-To: <20231004093620.2b1d6917@xps-13>
From:   Simon Glass <sjg@chromium.org>
Date:   Wed, 4 Oct 2023 10:05:43 -0600
Message-ID: <CAPnjgZ3bsNvCO_DkUG+99Ep_RPtQR42+AvxbLoZGBq+G8cWtPQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: mtd: fixed-partitions: Add binman compatible
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        linux-mtd@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pratyush Yadav <ptyadav@amazon.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On Wed, 4 Oct 2023 at 01:36, Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Simon,
>
> sjg@chromium.org wrote on Mon,  2 Oct 2023 11:49:40 -0600:
>
> > Add a compatible string for binman, so we can extend fixed-partitions
> > in various ways.
>
> I've been thinking at the proper way to describe the binman partitions.
> I am wondering if we should really extend the fixed-partitions
> schema. This description is really basic and kind of supposed to remain
> like that. Instead, I wonder if we should not just keep the binman
> compatible alone, like many others already. This way it would be very clear
> what is expected and allowed in both cases. I am thinking about
> something like that:
>
>         Documentation/devicetree/bindings/mtd/partitions/brcm,bcm4908-partitions.yaml
>
> this file is also referenced there (but this patch does the same, which
> is what I'd expect):
>
>         Documentation/devicetree/bindings/mtd/partitions/partitions.yaml
>
> I'll let the binding maintainers judge whether they think it's
> relevant, it's not a strong opposition.

OK, yes I can do that. I suppose they would still remain backwards
compatible, due to the use of '$ref: partition.yaml#'

>
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
>
> [...]
>
> > +properties:
> > +  compatible:
> > +    const: binman
>
> Right now this does not fit (I believe) the example. But if we no
> longer extend fixed-partitions but just create binman.yaml, this will
> probably be enough.

OK

>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    partitions {
> > +        compatible = "binman", "fixed-partitions";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        partition@100000 {
> > +            label = "u-boot";
> > +            reg = <0x100000 0xf00000>;
> > +        };
> > +    };

Regards,
Simon
