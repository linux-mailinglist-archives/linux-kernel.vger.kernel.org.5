Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84F27849B7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjHVSxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjHVSxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:53:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9C2CF9;
        Tue, 22 Aug 2023 11:52:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16E7B65CF7;
        Tue, 22 Aug 2023 18:52:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E560C433C9;
        Tue, 22 Aug 2023 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692730375;
        bh=y2UELRC+XrfrXIM+d1BDwygTgdYn21N6QRXFuKS7+aI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mNV0oY6dloiYoJX/7q5qbg/uqnNeprKkg4mGaVd7UTCBTwxf7z9L5nAapNlV90Rss
         sDE/cMuDC326VPLmunXf68EHPmsUaRD/BRkYr8gtZjanH0jNeA95x+zB6Yi26tg1SM
         O3UuuvrrEPciTyvjX7Yb+aXvKepEcc04c7ozzej+TG3DdfvPZhAg4nL8Vyzn3RJPYh
         ZXgJjQqQpE/pe3adSfqZQ/nf/3KpSwOZU6DG4kmjmmdjlzsYpQrggC0O89LkUYJgmk
         xM5ACCkUkqAfU7e3OcZMLyiAW5MJfFl8iqT9REnaBgUU5QSnqM64VHVVCLv6XngA77
         gWenBzj5gZuzQ==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so80846301fa.2;
        Tue, 22 Aug 2023 11:52:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzy2Eh38Dz8aRCUWiIqLg6IuNLCdCdWYYNOSB7IGUM+9kf6J215
        QAo4ku9/JFAxoLSHLIiGDsM0e8nCCsKINfqWyw==
X-Google-Smtp-Source: AGHT+IEEMIR41THd0LMOBZubTsjgagaLMHV572WPlVXzbt4x3ZGS4hiPTCQhKUt6KcVET9reHOKhSgkJ+dgKFh2X5wU=
X-Received: by 2002:a2e:b049:0:b0:2bc:c38a:bd7c with SMTP id
 d9-20020a2eb049000000b002bcc38abd7cmr4455281ljl.33.1692730373473; Tue, 22 Aug
 2023 11:52:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230821194821.2961213-1-sjg@chromium.org>
In-Reply-To: <20230821194821.2961213-1-sjg@chromium.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Aug 2023 13:52:40 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+jYexj8CR86cktxeiXyo7X+8i35+Ao0GBMhinVPNUoEw@mail.gmail.com>
Message-ID: <CAL_Jsq+jYexj8CR86cktxeiXyo7X+8i35+Ao0GBMhinVPNUoEw@mail.gmail.com>
Subject: Re: [PATCH v2] schemas: Add a schema for memory map
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Tom Rini <trini@konsulko.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        Chiu Chasel <chasel.chiu@intel.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Gua Guo <gua.guo@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 2:48=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> The Devicespec specification skips over handling of a logical view of
> the memory map, pointing users to the UEFI specification.

It's more that the DT spec defines what is not used with UEFI. If UEFI
covers more than the DT Spec defined, then we should look at that.

I would look some into (IBM) PowerPC for any prior art in this area.
Unfortunately, not publicly documented other than any users.

> It is common to split firmware into 'Platform Init', which does the
> initial hardware setup and a "Payload" which selects the OS to be booted.
> Thus an handover interface is required between these two pieces.
>
> Where UEFI boot-time services are not available, but UEFI firmware is
> present on either side of this interface, information about memory usage
> and attributes must be presented to the "Payload" in some form.
>
> This aims to provide an initial schema for this mapping.
>
> Note that this is separate from the existing /memory and /reserved-memory
> nodes, since it is mostly concerned with what the memory is used for. It
> may cover only a small fraction of available memory, although it could be
> used to signal which area of memory has ECC.
>
> For now, no attempt is made to create an exhaustive binding, so there are
> some example types lists. This can be completed once this has passed
> initial review.

I don't have much interest in picking this up unless there's some
wider agreement. From the previously referenced discussion[1], it
didn't seem like there was. But none of those folk are Cc'ed here.

> ---
>
> Changes in v2:
> - Reword commit message
>
>  dtschema/schemas/memory-map.yaml | 51 ++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 dtschema/schemas/memory-map.yaml
>
> diff --git a/dtschema/schemas/memory-map.yaml b/dtschema/schemas/memory-m=
ap.yaml
> new file mode 100644
> index 0000000..97e531e
> --- /dev/null
> +++ b/dtschema/schemas/memory-map.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: BSD-2-Clause
> +# Copyright 2023 Google LLC
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/memory-map.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: /memory-map nodes
> +description: |
> +  Common properties always required in /memory-map nodes. These nodes ar=
e
> +  intended to resolve the nonchalant clause 3.4.1 ("/memory node and UEF=
I")
> +  in the Devicetree Specification.
> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +properties:
> +  $nodename:
> +    const: '/'

This goes in the root node?

> +  usage:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      Describes the usage of the memory region, e.g.:
> +
> +        "acpi-reclaim", "acpi-nvs", "bootcode", "bootdata", "bootdata",
> +        "runtime-code", "runtime-data"

Can't these be covered by reserved-memory? The client is free to
reclaim any regions if it knows what they are.

> +  attr:
> +    $ref: /schemas/types.yaml#/definitions/string-array
> +    description: |
> +      Attributes possessed by this memory region:
> +
> +        "single-bit-ecc" - supports single-bit ECC
> +        "multi-bit-ecc" - supports multiple-bit ECC
> +        "no-ecc" - non-ECC memory

Isn't this pretty much a property of a memory region as a whole. IOW,
couldn't it just go into /memory node(s)?

> +
> +patternProperties:
> +  "^([a-z][a-z0-9\\-]+@[0-9a-f]+)?$":
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      reg:
> +        minItems: 1
> +        maxItems: 1024
> +
> +    required:
> +      - reg
> +
> +additionalProperties: true
> +
> +...
> --
> 2.42.0.rc1.204.g551eb34607-goog

[1] https://patches.linaro.org/project/linux-acpi/patch/20230426034001.16-1=
-cuiyunhui@bytedance.com/
