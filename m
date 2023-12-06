Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1339807BA5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 23:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377680AbjLFWqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 17:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjLFWqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 17:46:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4309A
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 14:46:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD94C433CC;
        Wed,  6 Dec 2023 22:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701902772;
        bh=8X83r5OTQETJP3BACOnnNmvlcihfILbuzFscWCAxC/E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DBITz3Evb8Pwetp5R1BX/tFnkZoyAtKKUV/uWrwF7tABe7ICWL3lGLG9fGeJRNEh2
         hIAMeKvSoWhjBrD4nKn2NWSbVgPCWdnY9ceLFo7AAlnHqqdp1hfdZol1ciWCOeWYRk
         OxJiPudSZ6CT+S/HHLd/56imUBovQ5/bcBj8n6KOEXm5dPqchdhBXKnOhyxFt8n8Da
         B6sgEDnIXTEZnSf/qI77+lTdDMC0NljfrbIakg8olJFkf2/GQl81wNy4SxqGPNRcmd
         1AYuSo/VkMYO6IPK9N0CA0G4+84nrBd/W5FIjMfgoq+sr0CILC8JN9Fkl4P5lghfGK
         YzrPfzXhS0Qbg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50bfd7be487so31240e87.0;
        Wed, 06 Dec 2023 14:46:11 -0800 (PST)
X-Gm-Message-State: AOJu0YxxielvOk4tzptiIZEbRZ5p7eH80M3dYbMyI1fJbTcePWGaf7En
        8dauot9twohfk8lhgR1unH1iolK2DVN8EaBQMQ==
X-Google-Smtp-Source: AGHT+IETBh4KfKssDYyvEIq/NaALVdw46jfGTFoCN6msOKDqdRYDMgd6Fi1n8WkusjpxfTjwzi1IHW56DDYo3kVPYHI=
X-Received: by 2002:a05:6512:2251:b0:50b:f0df:57bb with SMTP id
 i17-20020a056512225100b0050bf0df57bbmr1074743lfu.49.1701902769936; Wed, 06
 Dec 2023 14:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20231130191815.2421978-1-robh@kernel.org> <CAOMZO5AZNz1cRg+aYQjDmpZ75ATJQUTWmC5mx+vgaYcBL6M+2w@mail.gmail.com>
 <CAL_JsqKLFpPo8xTh_vgWvDXSY5J8tQJZh9SrkW2EiK5V_ZNeeA@mail.gmail.com> <CAJ+vNU1DiFbQivka8gA1URiLMD2mWJnWSdn-77bEo8Uz0Liqcg@mail.gmail.com>
In-Reply-To: <CAJ+vNU1DiFbQivka8gA1URiLMD2mWJnWSdn-77bEo8Uz0Liqcg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 6 Dec 2023 16:45:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJmK5UDN_xKjJHac1L4Wsrx1GLDmeek5=K7gm=W9XPkOw@mail.gmail.com>
Message-ID: <CAL_JsqJmK5UDN_xKjJHac1L4Wsrx1GLDmeek5=K7gm=W9XPkOw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-venice: Fix PCI bus nodes
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 12:13=E2=80=AFPM Tim Harvey <tharvey@gateworks.com> =
wrote:
>
> On Thu, Nov 30, 2023 at 2:33=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Thu, Nov 30, 2023 at 1:28=E2=80=AFPM Fabio Estevam <festevam@gmail.c=
om> wrote:
> > >
> > > Hi Rob,
> > >
> > > On Thu, Nov 30, 2023 at 4:18=E2=80=AFPM Rob Herring <robh@kernel.org>=
 wrote:
> > > >
> > > > The imx8mm-venice boards PCI bus nodes are a complete mess. The
> > > > unit-addresses are wrong. The PCI bridge nodes are incomplete missi=
ng
> > > > "device_type" and "ranges" and just wrong for "#address-cells" and
> > > > "#size-cells" values.
> > > >
> > > > All of these issues are reported warnings if anyone bothered to pay
> > > > attention. Sigh.
>
> Rob,
>
> Sorry about that. At the time the dt was submitted there were still so
> many dt warnings it wasn't very clear what was a legitimate issue and
> the PCI bindings are not that easy to understand.
>
> > >
> > > The warnings are gone in linux-next:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/arch/arm64/boot/dts/freescale?h=3Dnext-20231130&id=3Dd61c5068729a76a6=
183a897bcad4bf26e8d3d674
> >
> > Linux-next is wrong. The ethernet device should have a node name of
> > 'ethernet'. The 'pcie' node name and 'device_type =3D "pci"' is for PCI
> > buses/bridges only.
>
> So as Fabio has tried to fix this with a patch that landed in
> linux-next this patch won't apply. I'll submit one that covers your
> changes.

Thanks.

> It's always been unfortunate to have to have this level of detail in a
> device-tree just to allow boot firmware to populate the mac address of
> a PCI ethernet device.

More unfortunate are incomplete h/w designs lacking the MAC address. :(

Not really any way around it I think if you want something that works
for any device and any number of devices.

Rob
