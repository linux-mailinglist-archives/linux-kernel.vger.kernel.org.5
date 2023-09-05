Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A35A7931E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjIEWW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjIEWW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:22:28 -0400
X-Greylist: delayed 1200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 15:22:24 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A02185;
        Tue,  5 Sep 2023 15:22:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1B5C433CD;
        Tue,  5 Sep 2023 21:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693950292;
        bh=vcOAE7cgvg+KKXXIGsF2W5d9uDa6HKdsbuwQ5Vq67Hs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jGHavaqS13fmdKZew+/6eohIqfMfSIDMNF8ecF6e6Tftr+0gFeMN24/qbQrr9qzoN
         sxjSzQY+X2BeJ5p8QM09VzaiUGZPDxYMzFc2tFm0xQl3j44NeH4FDD88TVn7fURIJH
         rraFiv3Y6vlqQRofV/15pdh7bdx0+7MMtDnydwsxGQ/Cm+NRs5AYqa/G1BK/ZGF2K5
         m/lkJeefKDtFY/iSGIYyBJnMUO4RUH7KPkJkljUW8bWfhBGcVYEj/rHXMoL9y7xJCz
         wi6KzwC8QsrTsL18NFWJoQYOQbWKTge8YX+GDvs++0ZnufZNguFeiBI05DYbkUwK+M
         wGePCE13CxnJQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-500c6ff99acso354590e87.1;
        Tue, 05 Sep 2023 14:44:52 -0700 (PDT)
X-Gm-Message-State: AOJu0YztkWauCmyPHnu3U1KIH5nP80myWgODXWj9asxEXQgr+SeHbzrU
        1sspBihABAfOq+jnwhHwhuqxzlki7ncChtITF4E=
X-Google-Smtp-Source: AGHT+IE3byYCTiwDkfPmJIHwu7Z9lpjHaSCdjuXL4BOAI9Du2b6eV7bne/cEy1xZahbolkOSiTJRwYub7OiN3c36sv0=
X-Received: by 2002:a05:6512:2256:b0:4fe:13c9:2071 with SMTP id
 i22-20020a056512225600b004fe13c92071mr356383lfu.2.1693950290708; Tue, 05 Sep
 2023 14:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org> <20230830231758.2561402-3-sjg@chromium.org>
In-Reply-To: <20230830231758.2561402-3-sjg@chromium.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 5 Sep 2023 23:44:39 +0200
X-Gmail-Original-Message-ID: <CAMj1kXG5-aqoOtKdPFEdm=_5SdvgUTOhcDOBP1zdARAvKphJtg@mail.gmail.com>
Message-ID: <CAMj1kXG5-aqoOtKdPFEdm=_5SdvgUTOhcDOBP1zdARAvKphJtg@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] schemas: Add some common reserved-memory usages
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org,
        Maximilian Brune <maximilian.brune@9elements.com>,
        ron minnich <rminnich@gmail.com>,
        Tom Rini <trini@konsulko.com>,
        Dhaval Sharma <dhaval@rivosinc.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        linux-acpi@vger.kernel.org, Gua Guo <gua.guo@intel.com>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Guo Dong <guo.dong@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Chiu Chasel <chasel.chiu@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 01:18, Simon Glass <sjg@chromium.org> wrote:
>
> The Devicetree specification skips over handling of a logical view of
> the memory map, pointing users to the UEFI specification.
>
> It is common to split firmware into 'Platform Init', which does the
> initial hardware setup and a "Payload" which selects the OS to be booted.
> Thus an handover interface is required between these two pieces.
>
> Where UEFI boot-time services are not available, but UEFI firmware is
> present on either side of this interface, information about memory usage
> and attributes must be presented to the "Payload" in some form.
>

I don't think the UEFI references are needed or helpful here.

> This aims to provide an small schema addition for this mapping.
>
> For now, no attempt is made to create an exhaustive binding, so there are
> some example types listed. More can be added later.
>
> The compatible string is not included, since the node name is enough to
> indicate the purpose of a node, as per the existing reserved-memory
> schema.
>
> This binding does not include a binding for the memory 'attribute'
> property, defined by EFI_BOOT_SERVICES.GetMemoryMap(). It may be useful
> to have that as well, but perhaps not as a bit mask.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v5:
> - Drop the memory-map node (should have done that in v4)
> - Tidy up schema a bit
>
> Changes in v4:
> - Make use of the reserved-memory node instead of creating a new one
>
> Changes in v3:
> - Reword commit message again
> - cc a lot more people, from the FFI patch
> - Split out the attributes into the /memory nodes
>
> Changes in v2:
> - Reword commit message
>
>  .../reserved-memory/common-reserved.yaml      | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>  create mode 100644 dtschema/schemas/reserved-memory/common-reserved.yaml
>
> diff --git a/dtschema/schemas/reserved-memory/common-reserved.yaml b/dtschema/schemas/reserved-memory/common-reserved.yaml
> new file mode 100644
> index 0000000..d1b466b
> --- /dev/null
> +++ b/dtschema/schemas/reserved-memory/common-reserved.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/common-reserved.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common memory reservations
> +
> +description: |
> +  Specifies that the reserved memory region can be used for the purpose
> +  indicated by its node name.
> +
> +  Clients may reuse this reserved memory if they understand what it is for.
> +
> +maintainers:
> +  - Simon Glass <sjg@chromium.org>
> +
> +allOf:
> +  - $ref: reserved-memory.yaml
> +
> +properties:
> +  $nodename:
> +    enum:
> +      - acpi-reclaim
> +      - acpi-nvs
> +      - boot-code
> +      - boot-data
> +      - runtime-code
> +      - runtime-data
> +

These types are used by firmware to describe the nature of certain
memory regions to the OS. Boot code and data can be discarded, as well
as ACPI reclaim after its contents have been consumed. Runtime code
and data need to be mapped for runtime features to work.

When one firmware phase communicates the purpose of a certain memory
reservation to another, it is typically not limited to whether its
needs to be preserved and when it needs to be mapped (and with which
attributes). I'd expect a memory reservation appearing under this node
to have a clearly defined purpose, and the subsequent phases need to
be able to discover this information.

For example, a communication buffer for secure<->non-secure
communication or a page with spin tables used by PSCI. None of the
proposed labels are appropriate for this, and I'd much rather have a
compatible string or some other property that clarifies the nature in
a more suitable way. Note that 'no-map' already exists to indicate
that the CPU should not map this memory unless it does so for the
specific purpose that the reservation was made for.


> +  reg:
> +    description: region of memory that is reserved for the purpose indicated
> +      by the node name.
> +
> +required:
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    reserved-memory {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        boot-code@12340000 {
> +            reg = <0x12340000 0x00800000>;
> +        };
> +
> +        boot-data@43210000 {
> +            reg = <0x43210000 0x00800000>;
> +        };
> +    };
> --
> 2.42.0.rc2.253.gd59a3bf2b4-goog
>
