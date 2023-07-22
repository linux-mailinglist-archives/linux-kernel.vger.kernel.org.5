Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F8E75DF37
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 01:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGVXDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 19:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjGVXDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 19:03:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87901A7;
        Sat, 22 Jul 2023 16:02:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CA8A60BC1;
        Sat, 22 Jul 2023 23:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8C0C433C7;
        Sat, 22 Jul 2023 23:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690066978;
        bh=oxydY8zP9vTYei9N9QKOKvEqr0CBZuoc4IFd+3PE0fM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hKIqXzH4yK5OcIOMiU8Mtl3M0SnI2Z9Twm6sjPQzvk45eAkj2MIz7VzuceLFhCtNv
         wDQ8DmL7D1abre6aU5kA0fL2Q/12073n0q24H24LpkzkPDxcoEChwa3aPydLcSW5Mw
         sqzsIfC44bvYhdhRjZ13eh+kVwkfn7L2g2vCl3GV48mU2jtHz8JlWZ5YVtIyF5bekX
         6Du5G8GGWugDEg5Zvk3Xmv/TZF8x5O2EXKfU9Xyb3SRhkGm5iURrG7Lxh+86pRcYfA
         GRB2rPJUZoi4PqCCjwB0ZOEY//qEyaJD6J1u4mI8FrjPkUKAIhBfntqAxAK0gAtiMX
         PxNlLltp6dNYQ==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-9922d6f003cso528791866b.0;
        Sat, 22 Jul 2023 16:02:58 -0700 (PDT)
X-Gm-Message-State: ABy/qLZGC4MGq/o3PKjxFxZMFxWrAeBNNmvka+r7Jz4Qc/wevGFleIYE
        Gi378KU8hxcM3CWHqQ3Nthi3fPK7VCNvqrAURoo=
X-Google-Smtp-Source: APBJJlH099m3nlcMvsJUawIkWH6RZSsbUIsNu72XyBUcZHbHfeYgp2+/9vP02KU1K1e2wTWOyV/5p0uIX/ThDId0vrE=
X-Received: by 2002:a17:906:8451:b0:994:1fd2:cf96 with SMTP id
 e17-20020a170906845100b009941fd2cf96mr5911842ejy.0.1690066977024; Sat, 22 Jul
 2023 16:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230722-upstream-beaglev-ahead-dts-v1-0-ccda511357f4@baylibre.com>
 <20230722-upstream-beaglev-ahead-dts-v1-2-ccda511357f4@baylibre.com>
In-Reply-To: <20230722-upstream-beaglev-ahead-dts-v1-2-ccda511357f4@baylibre.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 23 Jul 2023 07:02:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTMTDjAjTL=93nuDxamfegwFfiBXB+WU2GbcnVFhBAGqA@mail.gmail.com>
Message-ID: <CAJF2gTTMTDjAjTL=93nuDxamfegwFfiBXB+WU2GbcnVFhBAGqA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: riscv: Add BeagleV Ahead board compatibles
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Jisheng Zhang <jszhang@kernel.org>, Fu Wei <wefu@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 5:56=E2=80=AFAM Drew Fustini <dfustini@baylibre.com=
> wrote:
>
> Document the compatible strings for the BeagleV Ahead board which uses
> the T-Head TH1520 SoC.
>
> Link: https://beagleboard.org/beaglev-ahead
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> ---
>  Documentation/devicetree/bindings/riscv/thead.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/thead.yaml b/Documen=
tation/devicetree/bindings/riscv/thead.yaml
> index e62f6821372e..3b8b24812a24 100644
> --- a/Documentation/devicetree/bindings/riscv/thead.yaml
> +++ b/Documentation/devicetree/bindings/riscv/thead.yaml
> @@ -24,6 +24,11 @@ properties:
>            - const: sipeed,lichee-module-4a
>            - const: thead,th1520
>
> +      - description: BeagleV Ahead single board computer
> +        items:
> +          - const: beagle,beaglev-ahead
> +          - const: thead,th1520
Reviewed-by: Guo Ren <guoren@kernel.org>

> +
>  additionalProperties: true
>
>  ...
>
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren
