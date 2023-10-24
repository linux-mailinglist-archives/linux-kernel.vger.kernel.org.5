Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0647D5D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344371AbjJXVlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344272AbjJXVlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:41:12 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E161B3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:41:08 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507973f3b65so7855514e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698183666; x=1698788466; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8/l3iCnOIbHxgn209fI6Ue3Dyqs1H9WjYDgBhKPc4nY=;
        b=Rrx1myZZxr6WTSJOyLzrBRa77/qO7kSqRvhLCzgtpCwtf3m8QHZ0VxKGn8PuadDVNa
         5MtGgJLINumg344vQxOIMAGbgOGIbnCBzrRYATyErR5ddApbyqP7kvqHAm2aCxFDWF+J
         NJtrlKivCxq4gkDR2OY43l5Ez2vrxXp26pLFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698183666; x=1698788466;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8/l3iCnOIbHxgn209fI6Ue3Dyqs1H9WjYDgBhKPc4nY=;
        b=NSFueKwtQu3eAHMdu1LErv0eGZ4dmMg4xnVRT/aHqm5UH8kZpyzcQlXzZ66hrp6Z2V
         DKZOvIJm9C58+oclmci5J16x5h7zM5Ryt09w1ldYB5y/QbDXItDJb/yaBvoR9sxELm0g
         xd4VdVuL/9RswnfT1B9FZK1BIKL+UCQcWVvK/CJncZnF+MOPzxeK0RDOkUiVZaRP1yqg
         9s+dMNfd1/4BHea9yqvmJnVdxqzuqbEI2fAfL+A4K0M0CozypR8WAYTLBROqyqtje+5l
         MW8mGroSjbsrsIEgXlm2y+BO8+EmzBAAcKIeGf9+0wL2DH/kxUPFBkq54YganY++dZv2
         ouAg==
X-Gm-Message-State: AOJu0Yxcxv1d/yaSr6VPOD9zk7y0tajqUSV0LhSHF03Aae85HdKK5Bj5
        Kb8t9/NaH15KC61vGWcPwpCT7z4/FjUcgsSvauTyPA==
X-Google-Smtp-Source: AGHT+IFScWIum/OTHr5wNhT1S/G7FDAmrtGJXwLdpLF1M/LYqy7vRAiXQHkkcwQgTLFDVP6Hd+bZsDD/O+/8wNKhQNw=
X-Received: by 2002:a05:6512:3a8e:b0:507:a1e5:74fe with SMTP id
 q14-20020a0565123a8e00b00507a1e574femr11574219lfu.54.1698183666243; Tue, 24
 Oct 2023 14:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20231009220436.2164245-1-sjg@chromium.org> <20231009220436.2164245-2-sjg@chromium.org>
 <20231024161644.GB3707756-robh@kernel.org>
In-Reply-To: <20231024161644.GB3707756-robh@kernel.org>
From:   Simon Glass <sjg@chromium.org>
Date:   Tue, 24 Oct 2023 14:40:54 -0700
Message-ID: <CAPnjgZ0G3W0a1T5TMuS_8L+4OwqFU3xXBKPnTs+MDDFBWYP_VA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: mtd: binman-partition: Add binman compatibles
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <mwalle@kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, 24 Oct 2023 at 09:16, Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Oct 09, 2023 at 04:04:14PM -0600, Simon Glass wrote:
> > Add two compatible for binman entries, as a starting point for the
> > schema.
> >
> > Note that, after discussion on v2, we decided to keep the existing
> > meaning of label so as not to require changes to existing userspace
> > software when moving to use binman nodes to specify the firmware
> > layout.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v4:
> > - Correct selection of multiple compatible strings
> >
> > Changes in v3:
> > - Drop fixed-partitions from the example
> > - Use compatible instead of label
> >
> > Changes in v2:
> > - Use plain partition@xxx for the node name
> >
> >  .../mtd/partitions/binman-partition.yaml      | 49 +++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> > new file mode 100644
> > index 000000000000..35a320359ec1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mtd/partitions/binman-partition.yaml
> > @@ -0,0 +1,49 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2023 Google LLC
> > +
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mtd/partitions/binman-partition.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Binman partition
> > +
> > +maintainers:
> > +  - Simon Glass <sjg@chromium.org>
> > +
> > +select: false
>
> So this schema is never used. 'select: false' is only useful if
> something else if referencing the schema.

OK. Is there a user guide to this somewhere? I really don't understand
it very well.

>
> > +
> > +description: |
> > +  This corresponds to a binman 'entry'. It is a single partition which holds
> > +  data of a defined type.
> > +
> > +allOf:
> > +  - $ref: /schemas/mtd/partitions/partition.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    oneOf:
> > +      - const: binman,entry     # generic binman entry
>
> 'binman' is not a vendor. You could add it if you think that's useful.
> Probably not with only 1 case...

I think it is best to use this for generic things implemented by
binman, rather than some other project. For example, binman supports a
'fill' region. It also supports sections which are groups of
sub-entries. So we will likely start with half a dozen of these and it
will likely grow: binman,fill, binman,section, binman,files

If we don't use 'binman', what do you suggest?

>
> > +      - items:
> > +          - const: u-boot       # u-boot.bin from U-Boot project
> > +          - const: atf-bl31     # bl31.bin or bl31.elf from TF-A project
>
> Probably should use the new 'tfa' rather than old 'atf'. Is this the
> only binary for TFA? The naming seems inconsistent in that every image
> goes in (or can go in) a bl?? section. Why does TFA have it but u-boot
> doesn't? Perhaps BL?? is orthogonal to defining what is in each
> partition. Perhaps someone more familar with all this than I am can
> comment.

From what I can tell TF-A can produce all sorts of binaries, of which
bl31 is one. U-Boot can also produce lots of binaries, but its naming
is different (u-boot, u-boot-spl, etc.). Bear in mind that U-Boot is
used on ARM, where this terminology is defined, and on x86 (for
example), where it is not.

>
> Once you actually test this, you'll find you are specifying:
>
> compatible = "u-boot", "atf-bl31";

I don't understand that, sorry. I'll send a v5 and see if the problem goes away.

>
>
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    partitions {
> > +        compatible = "binman";
> > +        #address-cells = <1>;
> > +        #size-cells = <1>;
> > +
> > +        partition@100000 {
> > +            compatible = "u-boot";
> > +            reg = <0x100000 0xf00000>;
> > +        };
> > +
> > +        partition@200000 {
> > +            compatible = "atf-bl31";
> > +            reg = <0x200000 0x100000>;
> > +        };
> > +    };
> > --
> > 2.42.0.609.gbb76f46606-goog
> >

Regards,
Simon
