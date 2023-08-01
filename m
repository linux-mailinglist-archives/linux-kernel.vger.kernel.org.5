Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC7576A965
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjHAGnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjHAGnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:43:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 810C91BFD;
        Mon, 31 Jul 2023 23:42:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A2876148E;
        Tue,  1 Aug 2023 06:42:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1083C433CA;
        Tue,  1 Aug 2023 06:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690872157;
        bh=jwxHWeb0NL8oAMAbmsvzzIrWFXaXp5aIEx6g1Efrx+c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PAWIg9RVP0og5iCcVHfkMs0LUKXZLV3MoT0pMX6u3/zQ28XCLB4f3bvbf3a/SmHza
         pk7iTYFjZEd4Qmv2fB/Lu5bYy/AqkPq47uquvZYgzvR0xrvNwBwOmJSAHwHJp6pLOU
         5kz6MyDlmQ9Hp0NhxnM5TO02FrgB0nIMSBmPnkbgGgkssypqmZYpkyodWvpr0Dl8De
         3AbxRDErOa5OhRZOItdNK6cPn+SJySzhJUjc7vX2B+6e+Spmo8PKZlxvx248/YFqkE
         KRP8S2fUKsv+ws3AZ+7vTkubCu2FwMaPyQSWB8TB2YeYAaa4uYKUSmEc/MBP53QtX8
         WO7ksjU9X9qPQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b9338e4695so78900401fa.2;
        Mon, 31 Jul 2023 23:42:36 -0700 (PDT)
X-Gm-Message-State: ABy/qLYwJI8TJi3E3coUfOUHA4QlVTutU99d9F5j17no6D1pZbPeSebC
        lxJ6Vo62IpqKhleVWVB7GBInw/nPEiElFvDYLVc=
X-Google-Smtp-Source: APBJJlE+6Zki8sxaj3MeO4nDw682IVQpQVo+AIYtDW0mo7uDTNnSR1SDFzRKMjZijtwmrAQODceIkjyBqDBwXy7pxz0=
X-Received: by 2002:a2e:b0c6:0:b0:2b9:dfd1:3803 with SMTP id
 g6-20020a2eb0c6000000b002b9dfd13803mr1639482ljl.30.1690872154954; Mon, 31 Jul
 2023 23:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230719-mcrc-upstream-v1-0-dc8798a24c47@ti.com>
 <CAMj1kXGXNbkxdDRNojtZD3NhMGK97LOchqGoM-4-tVLgH5JEiA@mail.gmail.com> <87y1ive0yk.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
In-Reply-To: <87y1ive0yk.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 1 Aug 2023 08:42:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFvA=xfEUsquchpcCvE-mVaFbSmPzt30Fyp7ifO-AX9eA@mail.gmail.com>
Message-ID: <CAMj1kXFvA=xfEUsquchpcCvE-mVaFbSmPzt30Fyp7ifO-AX9eA@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH 0/5] Add support for Texas Instruments
 MCRC64 engine
To:     Kamlesh Gurudasani <kamlesh@ti.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "Menon, Nishanth" <nm@ti.com>,
        "Raghavendra, Vignesh" <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 at 08:22, Kamlesh Gurudasani <kamlesh@ti.com> wrote:
>
> Ard Biesheuvel <ardb@kernel.org> writes:
>
> > On Sun, 30 Jul 2023 at 20:56, Kamlesh Gurudasani <kamlesh@ti.com> wrote:
> >>
> >> Add support for MCRC64 engine to calculate 64-bit CRC in Full-CPU mode
> >>
> >> MCRC64 engine calculates 64-bit cyclic redundancy checks (CRC)
> >> according to the ISO 3309 standard.
> >>
> >> Generator polynomial: x^64 + x^4 + x^3 + x + 1
> >> Polynomial value: 0x000000000000001b
> >>
> >
> > How will this code be used? WIthout a user of the crc64-iso crypto API
> > algorithm, there is no point in having a driver that implements it.
>
> Thanks for the review.
>
> MCRC64 will be used to check the integrity of memory blocks.
> On TI K3 SOCs, users can use MCRC64 to accelerate the integrity check.
>

Where is the implementation of this logic? Does it use the shash/ahash API?

If so, it should be part of this series.


> >
> > Also, *if* such a user exists, we'd need to have a generic C
> > implementation as well - we don't add new algorithms unless they can
> > be enabled on all platforms and architectures.
>
> If it is must, will implement generic C code.
>
> >
> >
> >> Tested with
> >>
> >> and tcrypt,
> >> sudo modprobe tcrypt mode=329 sec=1
> >>
> >> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> >> ---
> >> Kamlesh Gurudasani (5):
> >>       crypto: crc64 - add crc64-iso test vectors
> >>       dt-bindings: crypto: Add binding for TI MCRC64 driver
> >>       crypto: ti - add driver for MCRC64 engine
> >>       arm64: dts: ti: k3-am62: Add dt node, cbass_main ranges for MCRC64
> >>       arm64: defconfig: enable MCRC module
> >>
> >>  Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml |  42 +++++++
> >>  MAINTAINERS                                             |   7 ++
> >>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi                |   7 ++
> >>  arch/arm64/boot/dts/ti/k3-am62.dtsi                     |   1 +
> >>  arch/arm64/configs/defconfig                            |   2 +
> >>  crypto/tcrypt.c                                         |   5 +
> >>  crypto/testmgr.c                                        |   7 ++
> >>  crypto/testmgr.h                                        | 401 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  drivers/crypto/Kconfig                                  |   1 +
> >>  drivers/crypto/Makefile                                 |   1 +
> >>  drivers/crypto/ti/Kconfig                               |  10 ++
> >>  drivers/crypto/ti/Makefile                              |   2 +
> >>  drivers/crypto/ti/mcrc64.c                              | 360 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  13 files changed, 846 insertions(+)
> >> ---
> >> base-commit: d7b3af5a77e8d8da28f435f313e069aea5bcf172
> >> change-id: 20230719-mcrc-upstream-7ae9a75cab37
> >>
> >> Best regards,
> >> --
> >> Kamlesh Gurudasani <kamlesh@ti.com>
> >>
