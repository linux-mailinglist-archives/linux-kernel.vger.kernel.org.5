Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4997D097F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376406AbjJTH0s convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 03:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235634AbjJTH0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:26:46 -0400
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 502881A3;
        Fri, 20 Oct 2023 00:26:44 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-d9a518d66a1so527256276.0;
        Fri, 20 Oct 2023 00:26:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697786803; x=1698391603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NFzM112JR4s3C3Ua1fq88pZld5Dol8WVpdGu4Jwo26s=;
        b=Ump3TlN7ZriO5CvJwBxlUKDKJr/7eQ7y/EPSyA/DazmSS9raFqLxOAejVcPQD2BatR
         WHjuTpQXZxwnchqTrXv7kliBqzZopCPJnyCvYeD8zRuFMyC7FNbv/71mpCv0MiFwA6Ny
         xfOtIJT61irvfvwPk/1njctB7zY49x2AZCo51VICUBWl0/B3pw3mhMW81VY+u8iDF5yF
         a4UOHrVqspO9qTi/G1PZpdGd9MpWIEWn+QUdb/teu2WPvwulOBbDQrATHm15KXNCHe9V
         KjMdaDt/yyROi5tkwToBXV6VLgpd4MxMwZBhBEb0/bqWE9SeoMwSLlNod9kGquF+ukSu
         0L0w==
X-Gm-Message-State: AOJu0Yy6HDGdigh+ggy+Q/CQe6FnF74acOo/wM5844K3uaOTVY08RVFy
        NdCWK13RKYQsFp5BnjKK0onJwYH0dxMYEg==
X-Google-Smtp-Source: AGHT+IGVXm8xEdnx7Wq5VixBe5OYnqz9tM0dvXXShIKbUg+pvJa/tGjellZKq3XtQQlmEUE7jSxtpQ==
X-Received: by 2002:a05:6902:566:b0:d9a:e398:5b25 with SMTP id a6-20020a056902056600b00d9ae3985b25mr937011ybt.47.1697786803248;
        Fri, 20 Oct 2023 00:26:43 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id d191-20020a25e6c8000000b00d0b0bbe574asm382565ybh.44.2023.10.20.00.26.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 00:26:42 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-579de633419so5070947b3.3;
        Fri, 20 Oct 2023 00:26:42 -0700 (PDT)
X-Received: by 2002:a81:a0c9:0:b0:5a8:2b82:a031 with SMTP id
 x192-20020a81a0c9000000b005a82b82a031mr1279096ywg.26.1697786802716; Fri, 20
 Oct 2023 00:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231019135810.3657665-1-peterlin@andestech.com>
In-Reply-To: <20231019135810.3657665-1-peterlin@andestech.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 Oct 2023 09:26:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdX+8RUpmhbcBjohZ5oF+wtakfNpwrxGFbZJvTN8_aJv9g@mail.gmail.com>
Message-ID: <CAMuHMdX+8RUpmhbcBjohZ5oF+wtakfNpwrxGFbZJvTN8_aJv9g@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] riscv: dts: renesas: r9a07g043f: Update
 compatible string to use Andes INTC
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     geert+renesas@glider.be, magnus.damm@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com, tim609@andestech.com,
        dylan@andestech.com, locus84@andestech.com, dminus@andestech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

On Thu, Oct 19, 2023 at 4:01 PM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
> The Andes INTC allows AX45MP cores to handle custom local
> interrupts, such as the performance monitor overflow interrupt.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
> Changes v1 -> v2:
>   - New patch

Thanks for your patch!

> --- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> @@ -37,7 +37,7 @@ cpu0: cpu@0 {
>
>                         cpu0_intc: interrupt-controller {
>                                 #interrupt-cells = <1>;
> -                               compatible = "riscv,cpu-intc";
> +                               compatible = "andestech,cpu-intc";

This compatible value is not documented.  Perhaps it was introduced
in an earlier patch in the series, to which I was not CCed?

Threading is broken, so I can't easily find the whole series in lore:
https://lore.kernel.org/all/20231019135810.3657665-1-peterlin@andestech.com/

>                                 interrupt-controller;
>                         };
>                 };

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
