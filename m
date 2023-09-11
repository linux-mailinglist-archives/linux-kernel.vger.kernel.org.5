Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C6379BD73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbjIKUs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244284AbjIKTwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 15:52:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED35D1A2;
        Mon, 11 Sep 2023 12:52:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866FDC433C9;
        Mon, 11 Sep 2023 19:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694461916;
        bh=G21JeuejQT7napK47qwQ3mWfWxYoI1kT9b4AieRElDA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XnueDFqXkzFyd8n3fyZlYQAKlJIBZfDFoINZbyVigqXkeoXufs8jcHZg82KVuNI7r
         91J32n+Ncb82W5eyqTQdsh48zTOED2Pbgb9HQoBBqVAdud96vmPof0kc4xzOYDehuS
         0XK4sltwFQk72ufRQFVDcORXJMPSDNeOWcJmqlLj0Ua6ektyJ/lCUYOEjAZ5menhat
         SdrPjcM4iW44wskRDxdYJDOO/rHhOLx9wdhM6ZF98sX6zAPfFcbwReSgikbeU67KjO
         D1rKFX94GZ1rk4Ik4FENER19f9uvyPXX1whkALHDm5kHPSdPDg0F+/wCPl8lskpfaE
         +8H+PoNQUjZmQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-501ce655fcbso7775506e87.2;
        Mon, 11 Sep 2023 12:51:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YwYO9y2Hj4TzmN1zdNpKtJxVrc4ICtyxwRoeYDTpdtPA4ctHkJi
        nhG/2PlOm7Ebw4hsHt9pHPRKvFdCTaPrDy2fbg==
X-Google-Smtp-Source: AGHT+IH5pf2sDl25rbz7w518Lh3YTl7THtqx7rSMbkIlLFoE0f3fSzHpolKm+Cb4RC/Jb0STKAIDjyLn35REO3cEScA=
X-Received: by 2002:a05:6512:33c8:b0:502:a56b:65f7 with SMTP id
 d8-20020a05651233c800b00502a56b65f7mr7434456lfg.16.1694461914773; Mon, 11 Sep
 2023 12:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230901072730.13571-1-linux@fw-web.de>
In-Reply-To: <20230901072730.13571-1-linux@fw-web.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 11 Sep 2023 14:51:42 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+f9bq5Mab9m1pzDeiw304TMeNDmJk+ofG6M8J9QD3cvQ@mail.gmail.com>
Message-ID: <CAL_Jsq+f9bq5Mab9m1pzDeiw304TMeNDmJk+ofG6M8J9QD3cvQ@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: mt7986: add overlay for SATA power socket
 on BPI-R3
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
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

On Fri, Sep 1, 2023 at 2:27=E2=80=AFAM Frank Wunderlich <linux@fw-web.de> w=
rote:
>
> From: Frank Wunderlich <frank-w@public-files.de>
>
> Bananapi R3 has a Power socket entended for using external SATA drives.
> This Socket is off by default but can be switched with gpio 8.
>
> Add an overlay to activate it.
>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |  1 +
>  .../mt7986a-bananapi-bpi-r3-sata.dtso         | 39 +++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3-=
sata.dtso
>
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/=
mediatek/Makefile
> index c99c3372a4b5..822d3e36d3df 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -13,6 +13,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r=
3-emmc.dtbo
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nand.dtbo
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-nor.dtbo
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sd.dtbo
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7986a-bananapi-bpi-r3-sata.dtbo

The requirement for overlays is they have a target base dt in tree and
that you apply the overlay to it. All these existing overlays have the
same problem which I pointed out when you submitted them. Please fix
the existing ones before adding more.


Rob
