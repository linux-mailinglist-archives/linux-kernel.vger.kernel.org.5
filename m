Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E187ABEC2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 10:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjIWIKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 04:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjIWIKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 04:10:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A756180;
        Sat, 23 Sep 2023 01:10:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C94C433CC;
        Sat, 23 Sep 2023 08:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695456624;
        bh=PdYJS/BSnWGeDJm882oDZ5X3HgUAebcEqDMRocFoqF8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hscrhA7wcKLppn4Mnk3i/Uh8jMS+iwW5A9X1MAihRmyx7p5t4/fxrUaAwC/1fGVsU
         tq08+IBQgueZ449yqInw7ClVUtnNVberGrV7hlws9e1rkfsP3f/JMCmfKGiVCxwfSW
         xeinYa7AUwq2avb7G6Q5Q0veMrRLysEVIZUjd3aiCtnEAG/jaeG10OfqJMBNVaexR4
         W517T+WBHfjLde5BK2fJBQlD1jBLyEHCa7U/qQVR7wZ5CROcoJDtsBo6yT0Zz28W/J
         +dyFsZO2po5jVzRPMwcKA02VIkFQkPJAERAfo+rYcC0Y1cllwfYUyq5MCuKG+PAsnC
         VCNzPekYhrzcQ==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9ad8bba8125so439847766b.3;
        Sat, 23 Sep 2023 01:10:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YwW/OP8HWNiG6ZXczb1emGFaB1ZpRt4caznLBbEti6ndz7AespG
        BYHR/i3o1BdFk+HUxFFcpknMxaW+VE5r6KUNzpY=
X-Google-Smtp-Source: AGHT+IGDzGapxUFpYPEZmxWl/fy6N5eTHbocFn+xPB3cVu16L7RwAdSEIB8UWAuFxHd1jSqiRyBMUlDgbWJMjo06pv4=
X-Received: by 2002:aa7:d4c5:0:b0:530:be79:49e7 with SMTP id
 t5-20020aa7d4c5000000b00530be7949e7mr1339748edr.37.1695456623284; Sat, 23 Sep
 2023 01:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com>
 <20230921-th1520-mmc-v1-1-49f76c274fb3@baylibre.com> <20230922-parish-ice-a22e93dc3027@spud>
 <ZQ2tP48Z19C5xRug@x1>
In-Reply-To: <ZQ2tP48Z19C5xRug@x1>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 23 Sep 2023 16:10:11 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSeKnB=Zc6o1wJAOyax7d=RmDJ0o8PSOfkVo5BYVc=sAw@mail.gmail.com>
Message-ID: <CAJF2gTSeKnB=Zc6o1wJAOyax7d=RmDJ0o8PSOfkVo5BYVc=sAw@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head TH1520 support
To:     Drew Fustini <dfustini@baylibre.com>
Cc:     Conor Dooley <conor@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Fu Wei <wefu@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Robert Nelson <robertcnelson@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Xi Ruoyao <xry111@xry111.site>, Han Gao <gaohan@iscas.ac.cn>,
        Icenowy Zheng <uwu@icenowy.me>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
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

On Fri, Sep 22, 2023 at 11:18=E2=80=AFPM Drew Fustini <dfustini@baylibre.co=
m> wrote:
>
> On Fri, Sep 22, 2023 at 10:57:36AM +0100, Conor Dooley wrote:
> > Hey Drew,
> >
> > On Thu, Sep 21, 2023 at 06:49:48PM -0700, Drew Fustini wrote:
> > > Add compatible value for the T-Head TH1520 dwcmshc controller and add
> > > thead,phy-pull-up property.
> > >
> > > Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> > > ---
> > >  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 4 ++=
++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci=
.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > index a43eb837f8da..46b768d46712 100644
> > > --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> > > @@ -19,6 +19,7 @@ properties:
> > >        - rockchip,rk3568-dwcmshc
> > >        - rockchip,rk3588-dwcmshc
> > >        - snps,dwcmshc-sdhci
> > > +      - thead,th1520-dwcmshc
> > >
> > >    reg:
> > >      maxItems: 1
> > > @@ -60,6 +61,9 @@ properties:
> > >      description: Specify the number of delay for tx sampling.
> > >      $ref: /schemas/types.yaml#/definitions/uint8
> > >
> > > +  thead,phy-pull-up:
> > > +    description: Enable weak pull-up on PHY pads
> > > +    type: boolean
> >
> > Why is the weak pull-up required? How would the dts author know if they
> > need to use this property?
>
> This is a good question, and I don't have a good reason beyond it is
> what the vendor SDK was doing.
>
> There are only two boards right now using the TH1520 that I know of.
> Both the LPi4a [1] and the Ahead [2] have the pull-up property set on
> all the mmc controller nodes their downstream device trees.
>
> Rob suggested on #devicetree that it would be simpler to just enable it
> in the driver and disable support when needed. I like this idea as it
> will simplify this binding patch and the code in the driver patch.
It's for the PHY debug. You could directly remove them, or keep it
with no-pull-up flag, then no pull-up flag in the dts for default..

static void sdhci_phy_1_8v_init_no_pull(struct sdhci_host *host)
{
        uint32_t val;
        sdhci_writel(host, 1, DWC_MSHC_PTR_PHY_R);
        sdhci_writeb(host, 1 << 4, PHY_SDCLKDL_CNFG_R);
        sdhci_writeb(host, 0x40, PHY_SDCLKDL_DC_R);

        val =3D sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
        val &=3D ~(1 << 4);
        sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);


        val =3D sdhci_readw(host, PHY_CMDPAD_CNFG_R);
        sdhci_writew(host, val | 1, PHY_CMDPAD_CNFG_R);

        val =3D sdhci_readw(host, PHY_DATAPAD_CNFG_R);
        sdhci_writew(host, val | 1, PHY_DATAPAD_CNFG_R);

        val =3D sdhci_readw(host, PHY_RSTNPAD_CNFG_R);
        sdhci_writew(host, val | 1, PHY_RSTNPAD_CNFG_R);

        val =3D sdhci_readw(host, PHY_STBPAD_CNFG_R);
        sdhci_writew(host, val | 1, PHY_STBPAD_CNFG_R);

        val =3D sdhci_readb(host, PHY_DLL_CTRL_R);
        sdhci_writeb(host, val | 1, PHY_DLL_CTRL_R);
}

static void sdhci_phy_3_3v_init_no_pull(struct sdhci_host *host)
{
        uint32_t val;
        sdhci_writel(host, 1, DWC_MSHC_PTR_PHY_R);
        sdhci_writeb(host, 1 << 4, PHY_SDCLKDL_CNFG_R);
        sdhci_writeb(host, 0x40, PHY_SDCLKDL_DC_R);

        val =3D sdhci_readb(host, PHY_SDCLKDL_CNFG_R);
        val &=3D ~(1 << 4);
        sdhci_writeb(host, val, PHY_SDCLKDL_CNFG_R);

        val =3D sdhci_readw(host, PHY_CMDPAD_CNFG_R);
        sdhci_writew(host, val | 2, PHY_CMDPAD_CNFG_R);

        val =3D sdhci_readw(host, PHY_DATAPAD_CNFG_R);
        sdhci_writew(host, val | 2, PHY_DATAPAD_CNFG_R);

        val =3D sdhci_readw(host, PHY_RSTNPAD_CNFG_R);
        sdhci_writew(host, val | 2, PHY_RSTNPAD_CNFG_R);

        val =3D sdhci_readw(host, PHY_STBPAD_CNFG_R);
        sdhci_writew(host, val | 2, PHY_STBPAD_CNFG_R);

        val =3D sdhci_readb(host, PHY_DLL_CTRL_R);
        sdhci_writeb(host, val | 1, PHY_DLL_CTRL_R);
}

>
> Thanks,
> Drew
>
> [1] https://git.beagleboard.org/beaglev-ahead/BeagleBoard-DeviceTrees/-/b=
lob/v5.10.x-ti-unified/src/riscv/light-beagle-ref.dts
> [2] https://github.com/revyos/thead-kernel/blob/lpi4a/arch/riscv/boot/dts=
/thead/light-lpi4a-ref.dts



--=20
Best Regards
 Guo Ren
