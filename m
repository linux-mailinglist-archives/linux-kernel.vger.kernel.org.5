Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ACE79C1DC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 03:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235311AbjILBqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 21:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbjILBqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 21:46:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4149713AF20;
        Mon, 11 Sep 2023 16:43:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38525C433BA;
        Mon, 11 Sep 2023 21:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694466391;
        bh=emY+8OOcII6sxAHBz/ueLAdDUaQM+gjoMKh7SHfBk1M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Tfe97YsfXcfKG5h/8G4yZP+eRv0qt8cCoMlRBYzI0MAfyU4DdQKymBPxuPSEvuPyB
         NyC0hnNLkbs5Xs860kSiFKoD1O2W84hsUijA9DTiJASMNBiq/3de5qPC8geSoEVkRh
         SOfkxgUYfuplCjC8lFKGCdKsBWZx0wUj1yxHCvvPupYNdxSflhB/yvVNrBC5LG9KW0
         5RpQhlAzzCN6IIeJnUGhm+FyS/qgBH9LkYKRnYkOFZEr9T8o9eFhtADqBv5xIUvccf
         45ua3df6Lrc7W2v1XbZqdzyaREJIExUwp3zVzXT5fvES8+qwNRnEJ9AQSwd0BH7X8I
         v1AsIuZW5dzIg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-500913779f5so8460595e87.2;
        Mon, 11 Sep 2023 14:06:31 -0700 (PDT)
X-Gm-Message-State: AOJu0YzNNkdb0zoBno1uD67kyz5MBGNE55W7/3LxJ4khZi0vAZQ9rFY8
        5rP0ejFBLZf3pZyE75ymcUyRHlHWIgHQJeC1DA==
X-Google-Smtp-Source: AGHT+IFIlnCjhKkjK04xViV3+eFz0aY5IAvCPJkUT/P8yaXEYd0nahR4SLre1VfiOPhvbszphcoq47BjPmOBQ6Yktoc=
X-Received: by 2002:a05:6512:3496:b0:500:863e:fc57 with SMTP id
 v22-20020a056512349600b00500863efc57mr7380863lfr.25.1694466389428; Mon, 11
 Sep 2023 14:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230901072730.13571-1-linux@fw-web.de> <CAL_Jsq+f9bq5Mab9m1pzDeiw304TMeNDmJk+ofG6M8J9QD3cvQ@mail.gmail.com>
 <76060BF0-B432-4BB8-A5C8-39EFF3D628EA@public-files.de>
In-Reply-To: <76060BF0-B432-4BB8-A5C8-39EFF3D628EA@public-files.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Sep 2023 16:06:16 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJSi=kJSix=f3787ULZnaCy_Y26Phdhy5y9fat_vkDuUw@mail.gmail.com>
Message-ID: <CAL_JsqJSi=kJSix=f3787ULZnaCy_Y26Phdhy5y9fat_vkDuUw@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: mt7986: add overlay for SATA power socket
 on BPI-R3
To:     frank-w@public-files.de
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
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

On Mon, Sep 11, 2023 at 3:11=E2=80=AFPM Frank Wunderlich
<frank-w@public-files.de> wrote:
>
> Am 11. September 2023 21:51:42 MESZ schrieb Rob Herring <robh+dt@kernel.o=
rg>:
> >On Fri, Sep 1, 2023 at 2:27=E2=80=AFAM Frank Wunderlich <linux@fw-web.de=
> wrote:
> >>
> >> From: Frank Wunderlich <frank-w@public-files.de>
> >>
> >> Bananapi R3 has a Power socket entended for using external SATA drives=
.
> >> This Socket is off by default but can be switched with gpio 8.
> >>
> >> Add an overlay to activate it.
> >>
> >> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> >> ---
> >>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
> >>  .../mt7986a-bananapi-bpi-r3-sata.dtso         | 39 ++++++++++++++++++=
+
> >>  2 files changed, 40 insertions(+)
> >>  create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-=
r3-sata.dtso
> >>
> >> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/d=
ts/mediatek/Makefile
> >> index c99c3372a4b5..822d3e36d3df 100644
> >> --- a/arch/arm64/boot/dts/mediatek/Makefile
> >> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> >> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bp=
i-r3-emmc.dtbo
> >>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nand.dtbo
> >>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nor.dtbo
> >>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd.dtbo
> >> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sata.dtbo
> >
> >The requirement for overlays is they have a target base dt in tree and
> >that you apply the overlay to it. All these existing overlays have the
> >same problem which I pointed out when you submitted them. Please fix
> >the existing ones before adding more.
> >
> >
> >Rob
>
> Hi Rob,
>
> i do not understand the problem as there is a target base dt...mt7986a-ba=
nanapi-bpi-r3.dtb.
>
> Do you mean that overlays should be merged with basedt at compiletime?

Yes, because we want to know an overlay can actually apply to what's upstre=
am.

> We pack the base-dt and all overlays into one fit image and let uboot dyn=
amically select the combination to apply. E.g. check if emmc is available, =
if yes apply emmc overlay else the sd one,same for nand/nor.

That's irrelevant.

Though do you really want to wait until that point to find out you
made some mistake in your overlay that it doesn't apply when you could
find out much sooner?

> Else i do not know *how* to fix as i don't see it as broken.

You need what I pointed out last time[1].

Rob

[1] https://lore.kernel.org/all/CAL_JsqK_3xxD0DFwipXO85P=3Dq=3DEYjUdjE1_8g1=
MKtvw3vVzx5A@mail.gmail.com/
