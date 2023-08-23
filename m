Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E7A78573F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 13:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234602AbjHWLxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 07:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjHWLxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 07:53:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579B0CF;
        Wed, 23 Aug 2023 04:53:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8ACA660D3;
        Wed, 23 Aug 2023 11:53:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064C5C433C8;
        Wed, 23 Aug 2023 11:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692791620;
        bh=9ozTPMOCGjgHLaJa54zNz+3htX4e52MyhqXdip941jo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=l24jGUE83dTC5LIpesTj/6es0p1WS7ylU3MUON3FJiuoWQxxRCjlR5z3wIFk4K+oU
         K2AWIcTPkmDsluBNADDyBlpMDLA8Rp+uKKqJoCHs0avzOBmXGyOqYqn+BCh16bjUI2
         hvhq9h51Ry+gIiCJSOxxraYuuki2GsBa0J1eiiJ7gXumwLCguGvREwpTyW9YV+YEk7
         dNwAKeoP3UDdpi+bdNOnHPI9JPaBhU60YEN1dK+7znlOZ/CRo/Tve9mIsDAErxAZ59
         jKyyPyla2DIuaYkyUmtM5hqQ6DDKwQ7Gc/a1lvWnat8Yxav7r0p1B08W1yk1QFolNU
         SsschzuYYGj6A==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b9a2033978so85419711fa.0;
        Wed, 23 Aug 2023 04:53:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YzeoE8DrkY1ssL4mcHThu/+2gPw1ranXjVHX0bhmCULQnxwjCkE
        vr5i4h/rxjHgTNHGXbG+3iz2c7reamk9dk5gEA==
X-Google-Smtp-Source: AGHT+IG6AYWn2ZBtqiggebw0M0LEoLpjEjEkmAuyxGb6SqXHXb0v7iaIhaSPWuqzMe7IxI9zjdhMNEvmSNHymSTc/JA=
X-Received: by 2002:a2e:7008:0:b0:2bc:d8fd:13df with SMTP id
 l8-20020a2e7008000000b002bcd8fd13dfmr2086615ljc.41.1692791617967; Wed, 23 Aug
 2023 04:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230714174702.4059100-1-robh@kernel.org> <CABb+yY0ZEkU2fEoFcihDM0GPuNBkCJHYXfkq-+bLJY1xtbf5Jw@mail.gmail.com>
In-Reply-To: <CABb+yY0ZEkU2fEoFcihDM0GPuNBkCJHYXfkq-+bLJY1xtbf5Jw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Aug 2023 06:53:25 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+EbxHkdXEJsgAETrQj8Ps30umOMcArt1fCaNumxBem5A@mail.gmail.com>
Message-ID: <CAL_Jsq+EbxHkdXEJsgAETrQj8Ps30umOMcArt1fCaNumxBem5A@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Explicitly include correct DT includes
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@amd.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 6:05=E2=80=AFPM Jassi Brar <jassisinghbrar@gmail.co=
m> wrote:
>
> On Fri, Jul 14, 2023 at 12:47=E2=80=AFPM Rob Herring <robh@kernel.org> wr=
ote:
> >
> > The DT of_device.h and of_platform.h date back to the separate
> > of_platform_bus_type before it as merged into the regular platform bus.
> > As part of that merge prepping Arm DT support 13 years ago, they
> > "temporarily" include each other. They also include platform_device.h
> > and of.h. As a result, there's a pretty much random mix of those includ=
e
> > files used throughout the tree. In order to detangle these headers and
> > replace the implicit includes with struct declarations, users need to
> > explicitly include the correct includes.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> I thought I was to pick the patch. But I see you intend to do it. Np.

No, please apply it.

Thanks,
Rob

>
> Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
>
> thanks
