Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB482797904
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240353AbjIGRAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240202AbjIGRAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:00:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663C51FFA;
        Thu,  7 Sep 2023 09:59:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7020EC433BF;
        Thu,  7 Sep 2023 16:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694105901;
        bh=9H8krLtYfLzgGeA5i0zuj9qgIuh5eWibHtX4rliuuxQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HZSOww+G/B17lm44Q4pK901JIvTJ+z2HSd8QVDZnTmfMHtw4A/FdMMdg0G9fWUG8n
         VgwoarbRzt5ypjQeRKWF1UtKEO/iIScBixMwuctbelX+fXPN7iNwDDQkBf/gnAUYkx
         mf6r1j0bJ0GDOXTs7goJT5QasJ1jlDe/wPpJKZAcuzxHRagM7PMKEn32dCanO0a57H
         BtndR0lM1QbhEN3hLC1d6wDNm0i/GQHtxpbo5HFx1mhzL5rO/aiEqNINT5VrCu3Wi8
         xES8vBcm83QU9L+UKQa6B4ed3Ba6vkmpyDuJT0GGJXIAZvb3mgxws/PkYis79hfx4E
         V0qByRzTyJTSg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so20219491fa.2;
        Thu, 07 Sep 2023 09:58:21 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw95Z9lY3YgVvxcddr3uL29CEkVHg8KuUKJ8n1JDUln1Rz0g6yB
        asx6LKCtsna8AI/lpTpCt1CdsT+pyTtnaWMbfQ==
X-Google-Smtp-Source: AGHT+IHLKsGi67L1BWMr0evQdFmmKrCxPICw4WCCL86IJN0XnEYKyZyPOVddUmJXTpGASiUH1k4Vzk7Q+KRVgc7tkH4=
X-Received: by 2002:a2e:965a:0:b0:2bc:b815:d64d with SMTP id
 z26-20020a2e965a000000b002bcb815d64dmr5383234ljh.30.1694105899386; Thu, 07
 Sep 2023 09:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org> <20230830231758.2561402-4-sjg@chromium.org>
In-Reply-To: <20230830231758.2561402-4-sjg@chromium.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 7 Sep 2023 11:58:07 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKEbqUtWHpHXmiDSZBY7-Nw4-fLs23BEqomBevSDNBprQ@mail.gmail.com>
Message-ID: <CAL_JsqKEbqUtWHpHXmiDSZBY7-Nw4-fLs23BEqomBevSDNBprQ@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] memory: Add ECC properties
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org,
        Maximilian Brune <maximilian.brune@9elements.com>,
        ron minnich <rminnich@gmail.com>,
        Tom Rini <trini@konsulko.com>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        linux-acpi@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Gua Guo <gua.guo@intel.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Guo Dong <guo.dong@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Chiu Chasel <chasel.chiu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 6:18=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Some memories provide ECC detection and/or correction. For software which
> wants to check memory, it is helpful to see which regions provide this
> feature.
>
> Add this as a property of the /memory nodes, since it presumably follows
> the hardware-level memory system.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v5:
> - Redo to make this property specific to ECC
> - Provide properties both for detection and correction
>
> Changes in v3:
> - Add new patch to update the /memory nodes
>
>  dtschema/schemas/memory.yaml | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
> index 1d74410..944aa9f 100644
> --- a/dtschema/schemas/memory.yaml
> +++ b/dtschema/schemas/memory.yaml
> @@ -34,7 +34,37 @@ patternProperties:
>          description:
>            For the purpose of identification, each NUMA node is associate=
d with
>            a unique token known as a node id.
> +      ecc-detection:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum:
> +          - none
> +          - single-bit
> +          - multi-bit
> +        description: |
> +          If present, this inidcates the type of memory errors which can=
 be

typo

> +          detected and reported by the Error-Correction Code (ECC) memor=
y
> +          subsystem:
>
> +            none       - No error detection is possible
> +            single-bit - Detects and reports single-bit ECC errors
> +            multi-bit  - Detects and reports multiple-bit ECC errors

I don't think 'multi' is specific enough. Perhaps this should be an
int instead with how many bits. (And '-bits' is a standard unit suffix
so a type isn't needed)

> +
> +          If not present, this is equivalent to 'none'.

Can be expressed as schema:

default: none

Though if that's the default why have it as a value? (It's fine though)

> +      ecc-correction:
> +        $ref: /schemas/types.yaml#/definitions/string
> +        enum:
> +          - none
> +          - single-bit
> +          - multi-bit
> +        description: |
> +          If present, this inidcates the type of memory errors which can=
 be

typo

> +          corrected by the Error-Correction Code (ECC) memory subsystem:
> +
> +            none       - No error correction is possible
> +            single-bit - Corrects single-bit ECC errors
> +            multi-bit  - Corrects multiple-bit ECC errors
> +
> +          If not present, this is equivalent to 'none'.

One issue is with 2 properties nonsensical combinations are allowed.
Not really any way to handle that in the schema though.

Rob
