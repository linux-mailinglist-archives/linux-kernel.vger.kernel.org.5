Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF667F7732
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345384AbjKXPFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:05:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345486AbjKXPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:05:19 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9510510CA;
        Fri, 24 Nov 2023 07:05:25 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b844e3e817so1196654b6e.0;
        Fri, 24 Nov 2023 07:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700838325; x=1701443125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX6ag15JQklH/2sh4S6Q9NdSDCc91Z9/cyhjI47Mdzg=;
        b=hiwK19AATNojdZO7hL+lSjSB2Zz9kWFd0ghJoYZrqlRkVDw0F9wQvhUPdNiwfSJfcS
         8IxIOgp/Tfn8idaHNByU3dM29dZJAkYYf0oSicUYfhCRMpHFGMWjkmBVZQkDjsDYmw1J
         F6acGoyjfEE0IKPaBi9tR9ViciBGab99LPzU+3rBhoht9zzzS4VX2Iks73dXuSJfHST4
         4gx4qw3DaqBNSURK513yh9Q09g5FjTyEjA1qKF4KnqFjByJRFHMUJYrG2uZjGdkJZTAs
         cFvXlKRxmgb3utyzr/Bx9BotsjKc9+R+lmXd+mtzKjlWPunOj5ejIOO6v8jIzKMI2ZXw
         wxVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700838325; x=1701443125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX6ag15JQklH/2sh4S6Q9NdSDCc91Z9/cyhjI47Mdzg=;
        b=Xfeb5jSA2Ugh348YmCt6KMDb8t4M6Ri7Gu41RAbOHyzux8eY6izD0iV24yqwaIetgY
         csyrBPMQu2mNyoTtbJNdKGPTXmGLnDW+uKk5C+7kvW+XK/tvGLr1OJZwb01kAqzJG8gY
         93A0m1AR4pxO3gjL87kYJ/7HvHmYeoL/aE7HJua1l6G+aVW6ajR0Rr3Dnb+b9+yqIjHu
         rl1G9V1WGk3Fa0msmXdVkNIJC1FlP+nRRNH3yvB15r+jgulhbsoxsV0Lx3urqinPYKrB
         ZWA8D7hsA0OPiifUl9TTt3Tsegxo7T6V8RiqJCG4TfzRrYXgYfi63SmUbvB1KRskqzIJ
         2vUQ==
X-Gm-Message-State: AOJu0YyiDRAo1nx3in4v7O0cV0yJFplFQGg8jBNdFAeB30rtJtsAPrTa
        PxJDQV1P30C7h4swWJ06qYRFcHwpzSlfnqiYkyzV8qhcAOigrg==
X-Google-Smtp-Source: AGHT+IHJEgTwvm9Mua8eX8HDXk8ny6QHMvkEalIYb/Rn3JabIxQSoGXmU5w6/caCi7qrgTmwdezSoogBDPpKHPRPA+s=
X-Received: by 2002:a05:6358:6f87:b0:16d:e5ab:66e with SMTP id
 s7-20020a0563586f8700b0016de5ab066emr2942380rwn.13.1700838324568; Fri, 24 Nov
 2023 07:05:24 -0800 (PST)
MIME-Version: 1.0
References: <20231122121235.827122-1-peterlin@andestech.com> <20231122121235.827122-6-peterlin@andestech.com>
In-Reply-To: <20231122121235.827122-6-peterlin@andestech.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 24 Nov 2023 15:04:58 +0000
Message-ID: <CA+V-a8uhTXrLkndHi8N3AQjHuQLG210o5zyOoekHNLbW+NgTdw@mail.gmail.com>
Subject: Re: [PATCH v4 05/13] riscv: dts: renesas: r9a07g043f: Update
 compatible string to use Andes INTC
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     acme@kernel.org, adrian.hunter@intel.com, ajones@ventanamicro.com,
        alexander.shishkin@linux.intel.com, andre.przywara@arm.com,
        anup@brainfault.org, aou@eecs.berkeley.edu, atishp@atishpatra.org,
        conor+dt@kernel.org, conor.dooley@microchip.com, conor@kernel.org,
        devicetree@vger.kernel.org, dminus@andestech.com,
        evan@rivosinc.com, geert+renesas@glider.be, guoren@kernel.org,
        heiko@sntech.de, irogers@google.com, jernej.skrabec@gmail.com,
        jolsa@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 12:18=E2=80=AFPM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> The Andes hart-level interrupt controller (Andes INTC) allows AX45MP
> cores to handle custom local interrupts, such as the performance
> counter overflow interrupt.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
> Changes v1 -> v2:
>   - New patch
> Changes v2 -> v3:
>   - Fixed possible compatibles for Andes INTC
> Changes v3 -> v4:
>   - No change
> ---
>  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi b/arch/riscv/boo=
t/dts/renesas/r9a07g043f.dtsi
> index eb301d8eb2b0..78072e80793d 100644
> --- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> @@ -38,7 +38,7 @@ cpu0: cpu@0 {
>
>                         cpu0_intc: interrupt-controller {
>                                 #interrupt-cells =3D <1>;
> -                               compatible =3D "riscv,cpu-intc";
> +                               compatible =3D "andestech,cpu-intc", "ris=
cv,cpu-intc";
>                                 interrupt-controller;
>                         };
>                 };
> --
> 2.34.1
>
>
