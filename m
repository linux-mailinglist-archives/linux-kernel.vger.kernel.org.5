Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B4E80726B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 15:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378833AbjLFOaH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 6 Dec 2023 09:30:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378695AbjLFOaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 09:30:05 -0500
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C6A1BF;
        Wed,  6 Dec 2023 06:30:12 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5d747dbf81eso43225027b3.1;
        Wed, 06 Dec 2023 06:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701873011; x=1702477811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TKgGiwP9nAffHhrzMau6NrZ+ya7fy76CJB3C0voaPJ0=;
        b=sdRKDy9GiPeJYP3lqahBlPIqqUy0OZTGMnICGHIcq7KQU8wfb3LHE4I2iaLVDnJa2Y
         qhByelZkqWwzbhiDoIM1vybQFbCuqHhdPc4UJ48/EBXdfPrFuSXTFfsJ32l4pL6nwgls
         3TwoUG8iiAxlgsSo3sc6r9DfwoN+GDfIEt/ZYFC9FnjKB2g/FZ7a6azFFGmJ+ZH1T4Fy
         qbuW0jVShvjlR1fk001ktoSEDG+gl3KWRJDe7icas5SBsWwdBfj/oFXEU2IizKLhMyy8
         0+PoL6nDw5Rk5DmN6dx+AkNJEOuTpovT+JISDl6cW7BGQvXAMsE/0nxMSJ7acoHlVelO
         ORYQ==
X-Gm-Message-State: AOJu0YzqL03If5dTpFAPlyvBqStodqeA9+Omno5RDm+B9ul8ynWZV7SL
        VpD654IAQIzGsy86mRa7BFP9xteMLn21nP3j
X-Google-Smtp-Source: AGHT+IHjDSZfWf7/GDHlgHwSwlx9oiOT6tT+oGfEiqGG3806yH0mv3K+TZzXYQ/LmntWSpcaYVObSg==
X-Received: by 2002:a81:c944:0:b0:5d7:545e:3bdd with SMTP id c4-20020a81c944000000b005d7545e3bddmr842146ywl.3.1701873011474;
        Wed, 06 Dec 2023 06:30:11 -0800 (PST)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id d17-20020a81ab51000000b005d6fb42cf39sm3801123ywk.52.2023.12.06.06.30.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 06:30:07 -0800 (PST)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-5d3d5b10197so61975817b3.2;
        Wed, 06 Dec 2023 06:30:07 -0800 (PST)
X-Received: by 2002:a05:690c:706:b0:5d7:1941:acb with SMTP id
 bs6-20020a05690c070600b005d719410acbmr666458ywb.102.1701873007473; Wed, 06
 Dec 2023 06:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20231201131551.201503-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20231201131551.201503-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20231201131551.201503-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Dec 2023 15:29:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW=1tLt0QX7jR9+2ZvYBW4BEGwM9OJQkKch3y5KLvtQww@mail.gmail.com>
Message-ID: <CAMuHMdW=1tLt0QX7jR9+2ZvYBW4BEGwM9OJQkKch3y5KLvtQww@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] riscv: dts: renesas: r9a07g043f: Update
 gpio-ranges property
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

Thanks for your patch!

On Fri, Dec 1, 2023 at 2:16 PM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> On RZ/Five we have additional pins compared to the RZ/G2UL SoC so update
> the gpio-ranges property in RZ/Five SoC DTSI.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> @@ -46,6 +46,10 @@ cpu0_intc: interrupt-controller {
>         };
>  };
>
> +&pinctrl {
> +       gpio-ranges = <&pinctrl 0 0 232>;
> +};
> +
>  &soc {
>         dma-noncoherent;
>         interrupt-parent = <&plic>;

I believe this has a hard dependency on the pinctrl driver changes, due to
the following check in in rzg2l_gpio_register():

    if (of_args.args[0] != 0 || of_args.args[1] != 0 ||
        of_args.args[2] != pctrl->data->n_port_pins) {
            dev_err(pctrl->dev, "gpio-ranges does not match selected SOC\n");
            return -EINVAL;
    }

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
