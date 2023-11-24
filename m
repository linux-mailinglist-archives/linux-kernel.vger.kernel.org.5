Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6446A7F7744
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbjKXPHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:07:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345526AbjKXPHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:07:42 -0500
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6F8D72;
        Fri, 24 Nov 2023 07:07:48 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7ba8e3107c9so540750241.1;
        Fri, 24 Nov 2023 07:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700838467; x=1701443267; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cD4XTfLDfdBaVvLQQvVIb/DdNn7sLhHYoYCs/LHKvs=;
        b=Tmb2G/tvnGHshFZERUzXCMdsTYiFF9G3xS/HWzA6vu2aCZOBU7L53IItm58m/bSEoy
         Nf7IPuoR723L33Sdnk7hnkkDCShdIs7zLlcIqVFx3baex9Ly3Me8LrErfEgUmNVhUzmh
         hsXFdddvwkH+EfDyCltb7TOmQjs5ddvHdhjX9616Z4sHxaTqUr5+gt6lU+ru52OAs9be
         /8897Rw9UtKxokrkDHZzsOH9YeV3v0SZ7Ex2zt367HWaUBw60II24RxEheeCN/cirwcG
         o8NUx8NlZbs3OH0VHq+S0TEwmIcUUL8/Ptc+VnorCmwE47i/IUwSH7mARFIbuuwDQADA
         ikaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700838467; x=1701443267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cD4XTfLDfdBaVvLQQvVIb/DdNn7sLhHYoYCs/LHKvs=;
        b=qr+WFPBOjK0oHWZLt1ZgwnbvalJxUpY1UeUOOXeCIf9HolEbYo612qSG+rGjI39P/g
         tRHPnDR66kcac3tNe1SpizugQAZCs41kMjKGSfWjh5q6dEksnQR64h45Gc4xgVEwdsHS
         P7fvmyEEjOfWoZHYp+t0VqchKFAX1qK8qgSG6houFhzLjJ/gfsouFRpPZ/T1BUP+ugjH
         +LxeJKidY3UGKfkEnf6uN0mXpPq3px0PClwczMiryzgAJ0ELB/KksycH+cOJqNr0KXyH
         LMVF/7Cr+lA3rh8Vg7f7IB8upeaz0W7MQVi2eX4kdjSdOenzkw5Xrxb/j0kS7aWEB0pH
         9RSg==
X-Gm-Message-State: AOJu0YzEfja9nkf95zBVl0oqgs8yuSTb7A5t2LZH2nIRcdh4kn51wNHw
        1XYx4lQV9HKl/YH7SIcIh9AvBoSE/4y/Bz57rXU=
X-Google-Smtp-Source: AGHT+IGwXCccI84TpN5xF2DxNx/5Qx0U4TpwtpfvD5tAf/GoEOLYxxD2REsWw4Dlpn477SB/DfDmefE9drxOV1y67p8=
X-Received: by 2002:a05:6122:903:b0:49a:466c:199e with SMTP id
 j3-20020a056122090300b0049a466c199emr3335155vka.2.1700838467503; Fri, 24 Nov
 2023 07:07:47 -0800 (PST)
MIME-Version: 1.0
References: <20231122121235.827122-1-peterlin@andestech.com> <20231122121235.827122-11-peterlin@andestech.com>
In-Reply-To: <20231122121235.827122-11-peterlin@andestech.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 24 Nov 2023 15:07:21 +0000
Message-ID: <CA+V-a8s2Ep3cC_qJ-a=3xf+D_90SJKe_MObywmnm6UJzEbvA6w@mail.gmail.com>
Subject: Re: [PATCH v4 10/13] dt-bindings: riscv: Add Andes PMU extension description
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 12:18=E2=80=AFPM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
>
> Document the ISA string for Andes Technology performance monitor
> extension which provides counter overflow interrupt and mode
> filtering mechanisms.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes v2 -> v3:
>   - New patch
> Changes v3 -> v4:
>   - Include Conor's Acked-by
> ---
>  Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Do=
cumentation/devicetree/bindings/riscv/extensions.yaml
> index 694efaea8fce..4e0066afc848 100644
> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> @@ -258,6 +258,13 @@ properties:
>              in commit 2e5236 ("Ztso is now ratified.") of the
>              riscv-isa-manual.
>
> +        - const: xandespmu
> +          description:
> +            The Andes Technology performance monitor extension for count=
er overflow
> +            and privilege mode filtering. For more details, see Counter =
Related
> +            Registers in the AX45MP datasheet.
> +            https://www.andestech.com/wp-content/uploads/AX45MP-1C-Rev.-=
5.0.0-Datasheet.pdf
> +
>          - const: xtheadpmu
>            description:
>              The T-Head performance monitor extension for counter overflo=
w. For more
> --
> 2.34.1
>
>
