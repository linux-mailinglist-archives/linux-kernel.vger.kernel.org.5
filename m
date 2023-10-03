Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3723E7B6913
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232163AbjJCMeb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 08:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjJCMea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 08:34:30 -0400
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF1C83;
        Tue,  3 Oct 2023 05:34:27 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-59f6041395dso10603887b3.1;
        Tue, 03 Oct 2023 05:34:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696336466; x=1696941266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DyBs7OjE8jGf/jQcbBbdy03j+SsN0IPwt3J55hhRj0=;
        b=e0fFxxstmbGaGuXzrIAY6XEizdk4rGey1o1qDeufielZbrSSF2ZE3/KqBPctjIM8Ao
         H+slMRDLl4Zb4iOTiODrujqCvWvieGyv2cAA6Ke09wEDYkewXT0mlQ5L1zLKr1XwtwnI
         aMX7TbTsRmYuxUfIailLgK2WsZRYAWGfqr/HD+dX3i9aurMk+k8acdTVrkChvmOL4T6I
         i49sp7YmtkBx9HnQuJK0ECGelJbuAq6zPTezLEJn00xQPX47GuFDjDfQn7cdLdQUaKmM
         O7tmncPNH3RKsqlj0zV1+T/Od7R1F4sz27gGndC0o6fUHT+tGr6afkMLcsmR2Uoby1K8
         irwg==
X-Gm-Message-State: AOJu0YyCIMnm5DCq+nl+C3tQ9h/SxWGjtUsw5FHUtrYF2gDQZ3QapcJ0
        ORYXblU77ZBPax6E+1G3A9mNYvqAx2rOBQ==
X-Google-Smtp-Source: AGHT+IHQxI4Lae36EIbOfXgiDWX/lVBpqDp2zC1dMSZbiYcpijEowWNlU4EEo5ZBG2FgvApaU7ttHQ==
X-Received: by 2002:a25:8204:0:b0:d86:55a1:3e5f with SMTP id q4-20020a258204000000b00d8655a13e5fmr13761013ybk.48.1696336466400;
        Tue, 03 Oct 2023 05:34:26 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id v93-20020a25abe6000000b00d81425266c1sm373700ybi.42.2023.10.03.05.34.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 05:34:26 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-59f6e6b206fso10486567b3.3;
        Tue, 03 Oct 2023 05:34:26 -0700 (PDT)
X-Received: by 2002:a25:c791:0:b0:d81:6e88:7cb3 with SMTP id
 w139-20020a25c791000000b00d816e887cb3mr13683713ybe.47.1696336465884; Tue, 03
 Oct 2023 05:34:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230929000704.53217-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20230929000704.53217-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20230929000704.53217-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Oct 2023 14:34:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVdWzK_MRz+NeZ_mx=NcH9_EF-B0At=YsOfOABLV3B9tg@mail.gmail.com>
Message-ID: <CAMuHMdVdWzK_MRz+NeZ_mx=NcH9_EF-B0At=YsOfOABLV3B9tg@mail.gmail.com>
Subject: Re: [PATCH 5/5] riscv: configs: defconfig: Enable configs required
 for RZ/Five SoC
To:     Prabhakar <prabhakar.csengg@gmail.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prabhakar,

On Fri, Sep 29, 2023 at 2:07 AM Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Enable the configs required by the below IP blocks which are
> present on RZ/Five SoC:
> * ADC
> * CANFD
> * DMAC
> * eMMC/SDHI
> * OSTM
> * RAVB (+ Micrel PHY)
> * RIIC
> * RSPI
> * SSI (Sound+WM8978 codec)
> * Thermal
> * USB (PHY/RESET/OTG)
>
> Along with the above some core configs are enabled too,
> -> CPU frequency scaling as RZ/Five does support this.
> -> MTD is enabled as RSPI can be connected to flash chips
> -> Enabled I2C chardev so that it enables userspace to read/write
>    i2c devices (similar to arm64)
> -> Thermal configs as RZ/Five SoC does have thermal unit
> -> GPIO regulator as we might have IP blocks for which voltage
>    levels are controlled by GPIOs
> -> OTG configs as RZ/Five USB can support host/function
> -> Gadget configs so that we can test USB function (as done in arm64
>    all the gadget configs are enabled)
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

As I expect this to go in through the RISC-V tree, I will let the
RISC-V people handle any discussion about more options that should be
made modular instead of builtin.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
