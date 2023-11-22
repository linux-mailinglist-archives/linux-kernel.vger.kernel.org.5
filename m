Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7DB7F525D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344035AbjKVVOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232747AbjKVVOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:14:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F911B2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:14:45 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9A6C43395;
        Wed, 22 Nov 2023 21:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700687685;
        bh=AdLucksemJuNek6Q2mYTXAkYIMbYexxotameJ9QABko=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eniAnwuRxcfrtO+5FXPi7U/gy0Q4Gbg+Wn8Q9WJRpf5IEfdeUI9uiRcKtgWd1UrYk
         sFXK6Y1lbQ6hSRJtK+tUi5YTpCX8BLFVnIxI8N9gw9yx18dcztECxsqtvkoOG/pRhG
         rU7IaYLnMxdkiZKYhg/wZWYV+3+t1TsayR6pnOmQn7n9lI+uG8jfSyRi+eee/7NU3S
         UTWu/G9247A0tyU++WddY9FcvlnaK2hGFwDCiVfjFxcXV/j5+kqrARX742bbXC4pEX
         7op2lIl8LsU/H8wI69JPLBHy+5bgWVD1KqlKhA4rmZWKmvUSU9diGbTM5MQIpor7g3
         HWbd6PXRCZHhQ==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a0064353af8so259876166b.0;
        Wed, 22 Nov 2023 13:14:44 -0800 (PST)
X-Gm-Message-State: AOJu0YyBJDYvB7IAWAT/BDjVzr68Xz7he3Ajq1sA2r/SWqEnpraMWGAb
        Z3q4r345m3ZFs5oHYYYLJ44YlGrD93wnKxTJYvc=
X-Google-Smtp-Source: AGHT+IGIAQGj/hNQ0yottVsGW32nM9K4Wad//z6CZkRNPSM4tQ2oBX2Rax3OWYHQw9MprWovLzjIL1OmqUf1i6gr5yE=
X-Received: by 2002:a17:906:b218:b0:a04:98ef:c73c with SMTP id
 p24-20020a170906b21800b00a0498efc73cmr600541ejz.23.1700687683439; Wed, 22 Nov
 2023 13:14:43 -0800 (PST)
MIME-Version: 1.0
References: <20231122121235.827122-1-peterlin@andestech.com> <20231122121235.827122-10-peterlin@andestech.com>
In-Reply-To: <20231122121235.827122-10-peterlin@andestech.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 23 Nov 2023 05:14:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSMe-yfzKfX92eWhBnJ_WwoYQu7_7fsOQuNqXdafHA1dg@mail.gmail.com>
Message-ID: <CAJF2gTSMe-yfzKfX92eWhBnJ_WwoYQu7_7fsOQuNqXdafHA1dg@mail.gmail.com>
Subject: Re: [PATCH v4 09/13] dt-bindings: riscv: Add T-Head PMU extension description
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com, conor@kernel.org,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, geert+renesas@glider.be, heiko@sntech.de,
        irogers@google.com, jernej.skrabec@gmail.com, jolsa@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sunxi@lists.linux.dev, locus84@andestech.com,
        magnus.damm@gmail.com, mark.rutland@arm.com, mingo@redhat.com,
        n.shubin@yadro.com, namhyung@kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, peterz@infradead.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, sunilvl@ventanamicro.com,
        tglx@linutronix.de, tim609@andestech.com, uwu@icenowy.me,
        wens@csie.org, will@kernel.org, ycliang@andestech.com,
        inochiama@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 8:17=E2=80=AFPM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> Document the ISA string for T-Head performance monitor extension
> which provides counter overflow interrupt mechanism.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
> Changes v2 -> v3:
>   - New patch
> Changes v3 -> v4:
>   - No change
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index c91ab0e46648..694efaea8fce 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -258,5 +258,11 @@ properties:
>              in commit 2e5236 ("Ztso is now ratified.") of the
>              riscv-isa-manual.
>
> +        - const: xtheadpmu
> +          description:
> +            The T-Head performance monitor extension for counter overflo=
w. For more
> +            details, see the chapter 12 in the Xuantie C906 user manual.
> +            https://github.com/T-head-Semi/openc906/tree/main/doc
> +
>  additionalProperties: true
>  ...
> --
> 2.34.1
>
Reviewed-by: Guo Ren <guoren@kernel.org>

--=20
Best Regards
 Guo Ren
