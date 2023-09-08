Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59C979920E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 00:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244032AbjIHWNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 18:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243926AbjIHWNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 18:13:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FBD19B4;
        Fri,  8 Sep 2023 15:13:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DFF3C433C9;
        Fri,  8 Sep 2023 22:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694211221;
        bh=EhV7aq6l8cffyJEnGd90vbqDmbbpCcFDQb/v/HDeZcY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G+ddOzO5T/u0fCFiCPMNbrFLgdtL1nNNqfq0dxja5oSMJwXEJK82bsk35VaRdE2tS
         YtxYyWycVZgGSSQwt8FIMYqwyeojkfUSpkT5sRhUJUfRE8o2GVfKMwlkmvQcZWfcEH
         pbx93T7x3fGQFsHf4xbbs5RK87y4UksLHapRf9NrghyRTEbs1UQtyOCf1Wj2Tsg/aD
         YvXCRa+G4mjClraLKCetCDaH1Sfr6rmgo0V673qSyd7rAvucCE/sgr1LNzhEKzS8CV
         tR2IxbUCAb8m9L4aSeA0NLKNXxQnr4mwOpyKFFtsfc1ZmBJ2Bz5oa4SpaSpGkMoHBD
         I2KhLcQUGZDjg==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-50078eba7afso4369489e87.0;
        Fri, 08 Sep 2023 15:13:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YzG0JUL3D3IYU8NlcYQOzuY/2t8ea+B9p4E8Xc/OOvrs9AmKsiL
        FXGu3evBa1bKv+W35fE/Or+NQVnFKWHEtZuulA==
X-Google-Smtp-Source: AGHT+IFOcDuM/RrciNdg4GYNfpTR0hXLXVRX/pv2D/1YHz85dgHViYZ5GukNJpXClFTV9LGvScME+sBle69muAptStQ=
X-Received: by 2002:a05:6512:5cc:b0:4fb:741f:75bf with SMTP id
 o12-20020a05651205cc00b004fb741f75bfmr2667800lfo.16.1694211219298; Fri, 08
 Sep 2023 15:13:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230809084559.17322-1-a-bhatia1@ti.com> <20230809084559.17322-5-a-bhatia1@ti.com>
In-Reply-To: <20230809084559.17322-5-a-bhatia1@ti.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 8 Sep 2023 17:13:27 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+GR3hP6hFvFn2z5aXvSXnh9butD3aKZ-y_XJgx0_YPTw@mail.gmail.com>
Message-ID: <CAL_Jsq+GR3hP6hFvFn2z5aXvSXnh9butD3aKZ-y_XJgx0_YPTw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] arm64: dts: ti: am62x-sk: Add overlay for HDMI audio
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
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

On Wed, Aug 9, 2023 at 3:46=E2=80=AFAM Aradhya Bhatia <a-bhatia1@ti.com> wr=
ote:
>
> From: Jai Luthra <j-luthra@ti.com>
>
> Enable audio output over HDMI instead of the 3.5mm jack.
>
> A FET switch (U65) on the EVM muxes serial audio lines coming from McASP
> between the codec (tlv320aic3106) and the HDMI bridge (sii9022).
>
> By default it uses the codec, but it can be toggled to use the HDMI
> bridge by shorting a (J24) header on the board.
>
> Signed-off-by: Jai Luthra <j-luthra@ti.com>
> [a-bhatia1: Cosmetic changes]
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  arch/arm64/boot/dts/ti/Makefile               |  3 ++
>  .../boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso   | 40 +++++++++++++++++++
>  2 files changed, 43 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
>
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Mak=
efile
> index 437a3d7e8e3a..e3eadf69d43b 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -19,6 +19,7 @@ dtb-$(CONFIG_ARCH_K3) +=3D k3-am625-verdin-wifi-dahlia.=
dtb
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am625-verdin-wifi-dev.dtb
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am625-verdin-wifi-yavia.dtb
>  dtb-$(CONFIG_ARCH_K3) +=3D k3-am62-lp-sk.dtb
> +dtb-$(CONFIG_ARCH_K3) +=3D k3-am62x-sk-hdmi-audio.dtbo

Overlays need to be applied to something. That's done like this:

foo-dtbs :=3D base.dtb k3-am62x-sk-hdmi-audio.dtbo
dtb-y +=3D foo.dtb

Please send a fix for this.

Rob
