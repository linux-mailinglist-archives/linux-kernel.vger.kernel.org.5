Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFE37ABA64
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 22:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjIVUJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 16:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjIVUJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 16:09:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B22A9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 13:09:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D96FC433C7;
        Fri, 22 Sep 2023 20:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695413361;
        bh=AHLsm+//Drjgdq1RMAfycEOsiVnacXmgu1AI48p1mr4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=epPR8EA/dExFShKHOUKdpcaThakwLUQN1Z1CVvXQa/Fj5oIIM1qVjZbdGcHb7oiLm
         eInHFIwBWogZccskWgUoHzKp9dMzFDe0P6hlUFuWFQGjyGosG5NZPBiriu5hqWA0Pv
         1G+5jsv1pUKZuFrb5A5Mq6CXCjiUD1tZXmehAqMiV/V09ZioBJvtPSXyOuClyCEeO/
         fjYAkK09uZLDdtg1XinrtKjmgmqltErGVZM7WIf9eD/1+yABzMJhDECj+BCQRBGsdr
         lnCh66W7X7r5yLv4V6J8dTgoTfclaBObC1cSoU9LYifoPrnxAb1RKZ0gZ0tSrV6lRh
         bZoM6gVyiUzKQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5031ccf004cso4431996e87.2;
        Fri, 22 Sep 2023 13:09:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YwsCnGUqvWoe4BGghTiKNmr/kmNIdus+bk4tIJlB+VXZz/bhGTy
        gmhI0iaSEItmMu2fsk/ghhMTdKuAv6UiKGiEeA==
X-Google-Smtp-Source: AGHT+IGFqC9FB0x299iVTOZ8zvTG+lxLZa9XS3sg2oFHCL70TvCL5i7aOA4f+aMgtOsKkLHBK5NYuqYovIM5DdYW+Go=
X-Received: by 2002:a19:8c16:0:b0:503:3446:8ef5 with SMTP id
 o22-20020a198c16000000b0050334468ef5mr451086lfd.10.1695413359094; Fri, 22 Sep
 2023 13:09:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230920133450.54226-1-rogerq@kernel.org> <20230920133450.54226-3-rogerq@kernel.org>
 <20230920135802.3ej2wcuaruqjidel@uncouth> <e8f26137-1284-4f45-a74d-a0a5f2aa2f93@kernel.org>
 <20230920164424.rrjvm6nvtv4ysyrw@unreal> <c7ec6ccd-37de-244d-0b3b-cb5d13bae539@ti.com>
 <6f2b38f8-1962-46f2-a095-b1eaf99ed407@kernel.org> <f79f521b-bfaf-27d2-f152-2f2f21d6f2b7@ti.com>
 <3eef2d49-d13e-40cf-a633-94b52948b065@kernel.org>
In-Reply-To: <3eef2d49-d13e-40cf-a633-94b52948b065@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 22 Sep 2023 15:09:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLmv904+_2EOmsQ__y1yLDvsT+_02i85phuh0cpe7X8NQ@mail.gmail.com>
Message-ID: <CAL_JsqLmv904+_2EOmsQ__y1yLDvsT+_02i85phuh0cpe7X8NQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: ti: am642-evm: Add overlay for NAND
 expansion card
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Tony Lindgren <tony@atomide.com>, david@gibson.dropbear.id.au,
        vigneshr@ti.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, srk@ti.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 4:03=E2=80=AFAM Roger Quadros <rogerq@kernel.org> w=
rote:
>
>
>
> On 21/09/2023 20:23, Andrew Davis wrote:
> > On 9/21/23 6:37 AM, Roger Quadros wrote:
> >> On 20/09/2023 20:06, Andrew Davis wrote:
> >>> On 9/20/23 11:44 AM, Nishanth Menon wrote:
> >>>> On 18:18-20230920, Roger Quadros wrote:
> >>>>>
> >>>>>
> >>>>> On 20/09/2023 16:58, Nishanth Menon wrote:
> >>>>>> On 16:34-20230920, Roger Quadros wrote:
> >>>>>>> The NAND expansion card plugs in over the HSE (High Speed Expansi=
on)
> >>>>>>> connector. Add support for it.
> >>>>>>>
> >>>>>>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> >>>>>>> ---
> >>>>>>>    arch/arm64/boot/dts/ti/Makefile               |   1 +
> >>>>>>>    arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso | 140 ++++++++++=
++++++++
> >>>>>>>    2 files changed, 141 insertions(+)
> >>>>>>>    create mode 100644 arch/arm64/boot/dts/ti/k3-am642-evm-nand.dt=
so
> >>>>>>>
> >>>>>>> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dt=
s/ti/Makefile
> >>>>>>> index 06d6f264f292..ece74085a6be 100644
> >>>>>>> --- a/arch/arm64/boot/dts/ti/Makefile
> >>>>>>> +++ b/arch/arm64/boot/dts/ti/Makefile
> >>>>>>> @@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_K3) +=3D k3-am62p5-sk.dtb
> >>>>>>>      # Boards with AM64x SoC
> >>>>>>>    dtb-$(CONFIG_ARCH_K3) +=3D k3-am642-evm.dtb
> >>>>>>> +dtb-$(CONFIG_ARCH_K3) +=3D k3-am642-evm-nand.dtbo
> >>>>>>>    dtb-$(CONFIG_ARCH_K3) +=3D k3-am642-phyboard-electra-rdk.dtb
> >>>>>>>    dtb-$(CONFIG_ARCH_K3) +=3D k3-am642-sk.dtb
> >>>>>>>    dtb-$(CONFIG_ARCH_K3) +=3D k3-am642-tqma64xxl-mbax4xxl.dtb
> >>>>>>
> >>>>>> Also see https://lore.kernel.org/all/20230911165610.GA1362932-robh=
@kernel.org/
> >>>>>>
> >>>>>> you may not get the dtbo installed when doing make dtbs_install
> >>>>>>
> >>>>>> [...]
> >>>>>>
> >>>>>
> >>>>> $ v8make dtbs_install INSTALL_DTBS_PATH=3D/tmp
> >>>>>     INSTALL /tmp/ti/k3-am625-beagleplay.dtb
> >>>>>     INSTALL /tmp/ti/k3-am625-phyboard-lyra-rdk.dtb
> >>>>>     INSTALL /tmp/ti/k3-am625-sk.dtb
> >>>>>     INSTALL /tmp/ti/k3-am625-verdin-nonwifi-dahlia.dtb
> >>>>>     INSTALL /tmp/ti/k3-am625-verdin-nonwifi-dev.dtb
> >>>>>     INSTALL /tmp/ti/k3-am625-verdin-nonwifi-yavia.dtb
> >>>>>     INSTALL /tmp/ti/k3-am625-verdin-wifi-dahlia.dtb
> >>>>>     INSTALL /tmp/ti/k3-am625-verdin-wifi-dev.dtb
> >>>>>     INSTALL /tmp/ti/k3-am625-verdin-wifi-yavia.dtb
> >>>>>     INSTALL /tmp/ti/k3-am62-lp-sk.dtb
> >>>>>     INSTALL /tmp/ti/k3-am62x-sk-hdmi-audio.dtbo
> >>>>>     INSTALL /tmp/ti/k3-am62a7-sk.dtb
> >>>>>     INSTALL /tmp/ti/k3-am62p5-sk.dtb
> >>>>>     INSTALL /tmp/ti/k3-am642-evm.dtb
> >>>>>     INSTALL /tmp/ti/k3-am642-evm-nand.dtbo
> >>>>> ^^^^
> >>>>>     INSTALL /tmp/ti/k3-am642-phyboard-electra-rdk.dtb
> >>>>>     INSTALL /tmp/ti/k3-am642-sk.dtb
> >>>>>
> >>>>>
> >>>>> What did I miss?
> >>>>
> >>>> I missed it, actually. See Rob's comment:
> >>>> https://lore.kernel.org/all/CAL_Jsq+GR3hP6hFvFn2z5aXvSXnh9butD3aKZ-y=
_XJgx0_YPTw@mail.gmail.com/
> >>>>
> >>>> Having orphan dtbo is apparently frowned upon
> >>>>
> >>>
> >>> And if you apply these overlays to the base DTB then it gets
> >>> symbols added automatically, no need for your patch [1/2] here.
> >>>
> >>
> >> Is this OK?
> >>
> >>     k3-am642-evm-nand-dtbs :=3D k3-am642-evm.dtb k3-am642-evm-nand.dtb=
o
> >>     dtb-$(CONFIG_ARCH_K3) +=3D k3-am642-evm-nand.dtb
> >>
> >> So patch 1 is not required in this case but we have an
> >> extra dtb file which is not really required.
> >>
> >
> > While I agree we will end up with several pre-overlayed DTB files
> > that are arguably not required as they could be later built/applied,
> > until we find a better way to check at build time these overlays
> > need applied to something as a test.
> >
> >> I have 2 more issues to point out
> >>
> >> 1)
> >> With existing examples e.g. J7200 EVM
> >> wouldn't  k3-j7200-evm.dtb include the k3-j7200-evm-quad-port-eth-exp.=
dtbo?
> >> Is this what we really want?
> >>
> >> likewise for k3-j721e-evm.dtb and k3-am654-gp-evm.dtb
> >>
> >
> > Yes, that is the idea, the base-board.dtb is just the raw main board, b=
ut
> > the "EVM" when you buy it comes with the quad-port daughtercard attache=
d.
> > That is what we consider the "EVM" and the DTB names match that.
> >
> >> 2)
> >> Another issue (unrelated to this change) is the below warning:
> >>
> >>     arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso:65.8-140.3: Warning =
(avoid_default_addr_size): /fragment@3/__overlay__: Relying on default #add=
ress-cells value
> >>     arch/arm64/boot/dts/ti/k3-am642-evm-nand.dtso:65.8-140.3: Warning =
(avoid_default_addr_size): /fragment@3/__overlay__: Relying on default #siz=
e-cells value
> >>
> >> This is because we use the 'ranges' property in the gpmc0 node
> >> and the compiler doesn't know the #address/size-cells of the
> >> parent node.
> >>
> >> Is there a trick to specify it in the dtso file?
> >>
> >
> > Hmm, seems like a tricky one. Do you really need to do the ranges here?
> > Could you use the default `ranges;` for gpmc0? Then do the range transl=
ation
> > down inside the nand node to keep the partition addresses sane.
>
> GPMC has separate address spaces per chip select.
>
> From Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
>   ranges:
>     minItems: 1
>     description: |
>       Must be set up to reflect the memory layout with four
>       integer values for each chip-select line in use,
>       <cs-number> 0 <physical address of mapping> <size>
>
> The ranges location in the device tree overlay is correct. The overlay is
> meaningless without the base tree.
>
> The correct solution would be to fix dtc so it doesn't print this warning
> for DT overlays.

https://www.spinics.net/lists/devicetree-compiler/msg04036.html
