Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A949B7D0990
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376400AbjJTHdH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 20 Oct 2023 03:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbjJTHdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:33:05 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E225F91;
        Fri, 20 Oct 2023 00:32:58 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5a7c011e113so5641517b3.1;
        Fri, 20 Oct 2023 00:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697787178; x=1698391978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VsN5y4fIi6cFNHhstQqXDFbqAjRT4Kg5GT/+7BP3xbs=;
        b=ca/96XvBQ0hjt1EtR8g2NmJ6ojqtMqYWBMhLn0zzMcGYQZy1OmlfMa+Gq5CHMw5lPZ
         P+X3s+GteWQB3YRlADR8+E4XpIq6agMDGi0w/xDX4P4lzu2gdc34b+3KX5dT4xGu4KWA
         9gJfA8oy3dJtkrWLxLLHFgJ8M5PIaHxZqq4ODO8GVyIKNOcMeXQJ2z1zJfsW/f8Lwj69
         oDa4RvAB/OvSU9AR9I+4BQc7qmZnLNLsihUP4hA2jysBKTF3vJTIyEPNQrC8Ahdtobgv
         n8IRLOL+4d2s+KQm7SOchKNp7ypEXTq5EOr5tBDYjrbab/Zklm/8SOnanqi7Yj9tr0DN
         RYzw==
X-Gm-Message-State: AOJu0Yw9rBGHbniMcRUfABLG7tjRBhI9+CG1g0epZvjHVeuYpNxp8YjY
        RqtOWYksBkE3AyrGwOu7O+Ouy5A0n9KNNw==
X-Google-Smtp-Source: AGHT+IG7ecKYJxz7q0da0lfeeR8w95QR/7uIe9C/xNzmnkOZjrpQ59at+Wwd/PacE1GWuX4itSBUZw==
X-Received: by 2002:a25:aba7:0:b0:d7b:985b:278f with SMTP id v36-20020a25aba7000000b00d7b985b278fmr986264ybi.16.1697787176607;
        Fri, 20 Oct 2023 00:32:56 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id l131-20020a25cc89000000b00d677aec54ffsm381763ybf.60.2023.10.20.00.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 00:32:56 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-5a7dd65052aso5779667b3.0;
        Fri, 20 Oct 2023 00:32:56 -0700 (PDT)
X-Received: by 2002:a81:7746:0:b0:5a8:7375:af6b with SMTP id
 s67-20020a817746000000b005a87375af6bmr1198848ywc.44.1697787176074; Fri, 20
 Oct 2023 00:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20231019140232.3660375-1-peterlin@andestech.com>
In-Reply-To: <20231019140232.3660375-1-peterlin@andestech.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 20 Oct 2023 09:32:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW1Ua4skxtT+9kyoSDiqt2kNiNG-1jHE8rf4+b14hX4Vg@mail.gmail.com>
Message-ID: <CAMuHMdW1Ua4skxtT+9kyoSDiqt2kNiNG-1jHE8rf4+b14hX4Vg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] riscv: dts: renesas: Add Andes PMU extension
To:     Yu Chien Peter Lin <peterlin@andestech.com>
Cc:     magnus.damm@gmail.com, robh+dt@kernel.org,
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
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, Oct 19, 2023 at 4:05 PM Yu Chien Peter Lin
<peterlin@andestech.com> wrote:
> Add "xandespmu" to ISA extensions, the SBI PMU driver will
> probe the extension and use the non-standard irq source.
>
> Signed-off-by: Yu Chien Peter Lin <peterlin@andestech.com>
> ---
> Changes v1 -> v2:
>   - New patch

Thanks for your patch!

> --- a/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> +++ b/arch/riscv/boot/dts/renesas/r9a07g043f.dtsi
> @@ -26,7 +26,7 @@ cpu0: cpu@0 {
>                         riscv,isa = "rv64imafdc";
>                         riscv,isa-base = "rv64i";
>                         riscv,isa-extensions = "i", "m", "a", "f", "d", "c", "zicntr", "zicsr",
> -                                              "zifencei", "zihpm";
> +                                              "zifencei", "zihpm", "xandespmu";
>                         mmu-type = "riscv,sv39";
>                         i-cache-size = <0x8000>;
>                         i-cache-line-size = <0x40>;

This extension is not documented in
Documentation/devicetree/bindings/riscv/extensions.yaml. Perhaps it was
introduced in an earlier patch in the series, to which I was not CCed?

Threading is broken, so I can't easily find the whole series in lore:
https://lore.kernel.org/all/20231019140232.3660375-1-peterlin@andestech.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
