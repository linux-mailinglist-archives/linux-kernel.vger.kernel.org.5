Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3DC7DABB1
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 09:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjJ2IAu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 29 Oct 2023 04:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ2IAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 04:00:48 -0400
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095E6C6;
        Sun, 29 Oct 2023 01:00:46 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-59b5484fbe6so29047247b3.1;
        Sun, 29 Oct 2023 01:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698566445; x=1699171245;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wq3KaWnfOKn15xc4xsqIdV2aDnDlx/ragRVM8DwqFD4=;
        b=H0wQIpcBp37h2wkDrolC+G5wR+/r+NnCHfgILo/Js4BKtGIhwbI6Hf9pmyDaO0pbLK
         Shllp7PXPnBs5ij2TwohsBU/PYOtFXwLAztJ19XIivEr+X0lfyq7VOvJWZWdwXpWYPCa
         5tPisSKw3/l4teFNarkFKy7KbF/sJpm6vVoJMJfN2eB01a2ebL5clMJ6LOaRUyqHICcl
         7qvFR8mRHrek7v/sTXjOy7qhmW2RBI6snM7GhCnch6cDIgr/Ck/2YgUZEmavSruieQeF
         zj9zkRZiUnAYQOZrTFJSGm1Q4i+rjMkk/7iy4ae7/JNN3ghiar/1ZXkh+8Ua0O/b6JZv
         Iz5g==
X-Gm-Message-State: AOJu0Ywp72PFDFSE8rzttfanb5ncA2kcBESHWrnU0+JpFWdmODQ1YP0r
        F/9yEgajlenS1TdvOBX2Uw/U8pq5BC7w2g==
X-Google-Smtp-Source: AGHT+IE5OxAFFISTEFObosT5Huf4SROkGuRN9vX13GQI/MnW2fhP1V5dUe7htTSGcbOP1j5hHA35rg==
X-Received: by 2002:a81:e50c:0:b0:5b0:6326:75a4 with SMTP id s12-20020a81e50c000000b005b0632675a4mr3217324ywl.7.1698566444767;
        Sun, 29 Oct 2023 01:00:44 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id p127-20020a0dff85000000b00597e912e67esm2766860ywf.131.2023.10.29.01.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 01:00:43 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-d9ad90e1038so2794123276.3;
        Sun, 29 Oct 2023 01:00:43 -0700 (PDT)
X-Received: by 2002:a25:d489:0:b0:da1:b041:70ac with SMTP id
 m131-20020a25d489000000b00da1b04170acmr5190692ybf.10.1698566443639; Sun, 29
 Oct 2023 01:00:43 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-ac92041d-85e9-4725-b61c-bc0fef5549ec@palmer-ri-x1c9a> <133b60f7-a71c-4fa2-ae19-4cad05596a23@sifive.com>
In-Reply-To: <133b60f7-a71c-4fa2-ae19-4cad05596a23@sifive.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 29 Oct 2023 09:00:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUdzrVX9PzZw4_KMg+-17GPAEaV9ZmfzuUWpjC4moUX5w@mail.gmail.com>
Message-ID: <CAMuHMdUdzrVX9PzZw4_KMg+-17GPAEaV9ZmfzuUWpjC4moUX5w@mail.gmail.com>
Subject: Re: [PATCH 5/5] riscv: configs: defconfig: Enable configs required
 for RZ/Five SoC
To:     Samuel Holland <samuel.holland@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, prabhakar.csengg@gmail.com,
        magnus.damm@gmail.com, conor+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
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

Hi Samuel,

On Sat, Oct 28, 2023 at 11:27 PM Samuel Holland
<samuel.holland@sifive.com> wrote:
> On 2023-10-27 5:11 PM, Palmer Dabbelt wrote:
> > On Tue, 03 Oct 2023 05:34:13 PDT (-0700), geert@linux-m68k.org wrote:
> >> On Fri, Sep 29, 2023 at 2:07 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> >>> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>>
> >>> Enable the configs required by the below IP blocks which are
> >>> present on RZ/Five SoC:
> >>> * ADC
> >>> * CANFD
> >>> * DMAC
> >>> * eMMC/SDHI
> >>> * OSTM
> >>> * RAVB (+ Micrel PHY)
> >>> * RIIC
> >>> * RSPI
> >>> * SSI (Sound+WM8978 codec)
> >>> * Thermal
> >>> * USB (PHY/RESET/OTG)
> >>>
> >>> Along with the above some core configs are enabled too,
> >>> -> CPU frequency scaling as RZ/Five does support this.
> >>> -> MTD is enabled as RSPI can be connected to flash chips
> >>> -> Enabled I2C chardev so that it enables userspace to read/write
> >>>    i2c devices (similar to arm64)
> >>> -> Thermal configs as RZ/Five SoC does have thermal unit
> >>> -> GPIO regulator as we might have IP blocks for which voltage
> >>>    levels are controlled by GPIOs
> >>> -> OTG configs as RZ/Five USB can support host/function
> >>> -> Gadget configs so that we can test USB function (as done in arm64
> >>>    all the gadget configs are enabled)
> >>>
> >>> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >>
> >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >>
> >> As I expect this to go in through the RISC-V tree, I will let the
> >> RISC-V people handle any discussion about more options that should be
> >> made modular instead of builtin.
> >
> > I'm pretty much agnostic on that front, so I'm cool just picking up this.  I've
> > got just patch 5 in my queue for testing, there's a few other things in front of
> > it but it should show up on for-next soon.
>
> Does it make sense to merge this, considering RZ/Five support depends on
> NONPORTABLE, and therefore cannot be enabled in defconfig anyway?

Indeed, that's a good point.

Note that this patch (and its review) predates the NONPORTABLE
dependency.

Palmer: are you open to adding a new rzfive_defconfig[*] instead?
I see there are already other configs, so riscv seems to follow the
arm rather than the arm64 (there can be only one ring^Wdefconfig) model.

Thanks!

[*] I do hope to reserve (possibly non-upstream) renesas_defconfig
    for the army of future Renesas RISC-V SoCs that do not need a
    dependency on NONPORTABLE ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
