Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E0367581FD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 18:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjGRQWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 12:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjGRQWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 12:22:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA729F7;
        Tue, 18 Jul 2023 09:22:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57DF9615E4;
        Tue, 18 Jul 2023 16:22:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2A7C433CC;
        Tue, 18 Jul 2023 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689697365;
        bh=LTwHVSHoaSY0tlwADIKNZZi0zXhTwVVUMhY+CaieK9k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tYyRPzjcP/blsFXVIkoMhFfiWwoiKxiqpWe4Q7Ru8t6qZHyBK70jkwM4aOI/VWmi6
         tzCrBR0K6oN6zG/6g1YLsjNLkVCgxEP6hj95cauURLHV+XpSENn9fWVyYhdQeFAZmM
         7vJyS+sb6E4/kanecZPhRtT5DK8pQouPIlx8NjXNh0qLTNx0wiHxtPr+cqjmTZNDvY
         EtEts9aaCRP7QIstsaZShNP6DNG0zNogM1uxdtQIUzxb37C473mA1SjtPnixZhm2Qd
         WAagwGDbjkVLuqzl3RETia988eJnBp36/QdkDyf2zIpRv5R/sgF6TWZBAdNum3F3LP
         SEXvXPa5ZiJ/Q==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so90973851fa.1;
        Tue, 18 Jul 2023 09:22:45 -0700 (PDT)
X-Gm-Message-State: ABy/qLYwMI3U9hORIfjYqMcEOoCI1XaO/mRHD4SPbLgVDTAl8JEAv8/7
        73PO4O7U21p3WPxWQrWm2ZcqI86Bjrb+lV12tw==
X-Google-Smtp-Source: APBJJlErUqDENNI/5mOg1Ib0IoWsKzMqqGjhDh5AeFCFGhdxHxjAXyO701/QGQfWI6nmT6Ma2dedRQR82oM1goiArg8=
X-Received: by 2002:a2e:3618:0:b0:2b6:ddab:506a with SMTP id
 d24-20020a2e3618000000b002b6ddab506amr11118264lja.34.1689697363824; Tue, 18
 Jul 2023 09:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230626221005.3946136-1-robh@kernel.org>
In-Reply-To: <20230626221005.3946136-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Jul 2023 10:22:31 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLGULS8nrzSHGUJhGzEVaMB+hn6_XEHmSWb3tBHmo6tPA@mail.gmail.com>
Message-ID: <CAL_JsqLGULS8nrzSHGUJhGzEVaMB+hn6_XEHmSWb3tBHmo6tPA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mediatek: Fix "status" values
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 4:10=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> The defined value for "status" is "disabled", not "disable".
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Ping!

>
> diff --git a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts b/a=
rch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> index e4605d23fdc8..86cedb0bf1a9 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt7622-bananapi-bpi-r64.dts
> @@ -585,11 +585,11 @@ &pwrap {
>  };
>
>  &sata {
> -       status =3D "disable";
> +       status =3D "disabled";
>  };
>
>  &sata_phy {
> -       status =3D "disable";
> +       status =3D "disabled";
>  };
>
>  &spi0 {
> --
> 2.40.1
>
