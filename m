Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616EF78CED7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240623AbjH2ViS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:38:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbjH2ViI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:38:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DA2D7;
        Tue, 29 Aug 2023 14:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18FD860C59;
        Tue, 29 Aug 2023 21:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8DCC433CA;
        Tue, 29 Aug 2023 21:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693345085;
        bh=bZfz2phEmCJxQGXRumw4s2nqkXSdSl33NAnzl+eZ1ZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uunGSJNm89QwVxNPQ6Nh11wphe9DhPiyeyiv2cR8dMNLwcXpkLNxtkC8QvEDuhwxZ
         mj7XpDRKCmv6dGxSaA5X3N/oNWrOoX/WnaBGPHb9MSg5a8828ET/BsRp0xVn3AXjkD
         cfAlPpUjJbsIbYpsKPQT2SB/V2LaX4Aj0m2499a73pBT4fNCx1eYNn//gzBSqM2lA8
         nrpspBmqvywVC4yQYFHlRVI7nNnpMSRF5GZ9OQfYjbkfzqirxo03PX1ZBOJOCwWMsn
         Ko8r6qggJOXfnivZ8BY9aIpIh/rNblv2Qtpet/Cjk1t5Od47D7JHO9ywEmFLEHX919
         NOapeEiLrFf7Q==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2bcc846fed0so74655181fa.2;
        Tue, 29 Aug 2023 14:38:05 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxv4kznxm/NdcEg++ftoildJ2eQ9PjWM2n5YgDya4igL0IbLsKR
        zpPA53v880hjVBRKBlXLvPtUMDVVvIg7oVr2qg==
X-Google-Smtp-Source: AGHT+IHB0NW0jBHCyCbqErE9944KT8lOUEIQ7JDot6AAVoaFIgShclAt6U2wVpOQkDXO6T6Sc6veW9YeqGOgOMUtRdw=
X-Received: by 2002:a2e:6e10:0:b0:2bc:fc2e:766f with SMTP id
 j16-20020a2e6e10000000b002bcfc2e766fmr323885ljc.37.1693345083531; Tue, 29 Aug
 2023 14:38:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230829191812.135759-1-sjg@chromium.org> <20230829191812.135759-4-sjg@chromium.org>
In-Reply-To: <20230829191812.135759-4-sjg@chromium.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Aug 2023 16:37:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLFX9PpMcJBv2yZXRpQyQ-h1DrGyApE0+AAYN2LCCj7Kg@mail.gmail.com>
Message-ID: <CAL_JsqLFX9PpMcJBv2yZXRpQyQ-h1DrGyApE0+AAYN2LCCj7Kg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] memory: Add ECC property
To:     Simon Glass <sjg@chromium.org>
Cc:     devicetree@vger.kernel.org, Dhaval Sharma <dhaval@rivosinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Gua Guo <gua.guo@intel.com>, Tom Rini <trini@konsulko.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        ron minnich <rminnich@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Lean Sheng Tan <sheng.tan@9elements.com>,
        Maximilian Brune <maximilian.brune@9elements.com>,
        Chiu Chasel <chasel.chiu@intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Yunhui Cui <cuiyunhui@bytedance.com>,
        linux-acpi@vger.kernel.org, Guo Dong <guo.dong@intel.com>
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

On Tue, Aug 29, 2023 at 2:18=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Some memories provides ECC correction. For software which wants to check
> memory, it is helpful to see which regions provide this feature.
>
> Add this as a property of the /memory nodes, since it presumably follows
> the hardware-level memory system.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Add new patch to update the /memory nodes
>
>  dtschema/schemas/memory.yaml | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/dtschema/schemas/memory.yaml b/dtschema/schemas/memory.yaml
> index 1d74410..981af04 100644
> --- a/dtschema/schemas/memory.yaml
> +++ b/dtschema/schemas/memory.yaml
> @@ -34,7 +34,14 @@ patternProperties:
>          description:
>            For the purpose of identification, each NUMA node is associate=
d with
>            a unique token known as a node id.
> -
> +      attr:

Kind of vague.

> +        $ref: /schemas/types.yaml#/definitions/string-array
> +        description: |
> +          Attributes possessed by this memory region:
> +
> +            "single-bit-ecc" - supports single-bit ECC
> +            "multi-bit-ecc" - supports multiple-bit ECC

"supports" means corrects or reports? Most h/w supports both, but only
reports multi-bit errors.

> +            "no-ecc" - non-ECC memory

Don't define values in free form text.

This form is difficult to validate especially when non-ECC related
attr's are added to the mix as we can't really define which
combinations are valid. For example how do we prevent:

attr =3D "single-bit-ecc", "multi-bit-ecc";

Or maybe that's valid? If so, how would we express that?

Why do we need "no-ecc"? Is that the same as no "attr" property?

I think it's better if we have 'ecc-type' or something? Or generally,
a property per class/type of attribute.

Rob
