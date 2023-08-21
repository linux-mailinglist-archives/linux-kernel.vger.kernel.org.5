Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A72782E75
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbjHUQar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234080AbjHUQap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:30:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27A1ED
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:30:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40B796218F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 16:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29A8BC433C8;
        Mon, 21 Aug 2023 16:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692635443;
        bh=Dp3K7WSjO0loUgrRaYzORjzHt2XX8ljKIxdU6128Yvc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gf4lnlGTrrsY5D849WLqFnyodTTXXHlNV8RAqY7ovrFoOQjlHZPNb4iu/jKIwFdsD
         u3M59Qd4gBcrphYmghRnQ6L7RCgwBNawFu5HFdZtTZT/irVdtRQycROtE5tmh+p3pO
         Q8C6IEkBMcKcDJ+I3/smTYLi634sXhf/1DvvNXf57fwAoH3FzJ4BJJjGSbxoXHcv2K
         nuwepr1Eoga9uxh62q/unQN3jDhOy24QT4Hchov0ThUecQ8P3/Z+hpRhiH8JJBEzJ6
         ye7bpIn/Tz47KPxE98qiQEQuyusUQlU44YGVTONez04ll+Q/JZxXCyEom4AyrA5wpO
         7iLB9MPfa43yA==
Date:   Mon, 21 Aug 2023 18:30:39 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: fix NULL pointer on
 hw reset
Message-ID: <ZOORL5HSSSRUxHmQ@lore-desk>
References: <5465c1609b464cc7407ae1530c40821dcdf9d3e6.1692634266.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PKt5uvKR6i4YWAdK"
Content-Disposition: inline
In-Reply-To: <5465c1609b464cc7407ae1530c40821dcdf9d3e6.1692634266.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PKt5uvKR6i4YWAdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> When a hardware reset is triggered on devices not initializing WED the
> calls to mtk_wed_fe_reset and mtk_wed_fe_reset_complete dereference a
> pointer on uninitialized stack memory.
> Break out of both functions in case a hw_list entry is 0.
>=20
> Fixes: 08a764a7c51b ("net: ethernet: mtk_wed: add reset/reset_complete ca=
llbacks")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> Changes since v1:
>  * remove unneeded {} initialization for stack allocated memory
>=20
>  drivers/net/ethernet/mediatek/mtk_wed.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethern=
et/mediatek/mtk_wed.c
> index 00aeee0d5e45f..94376aa2b34c5 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> @@ -222,9 +222,13 @@ void mtk_wed_fe_reset(void)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(hw_list); i++) {
>  		struct mtk_wed_hw *hw =3D hw_list[i];
> -		struct mtk_wed_device *dev =3D hw->wed_dev;
> +		struct mtk_wed_device *dev;
>  		int err;
> =20
> +		if (!hw)
> +			break;
> +
> +		dev =3D hw->wed_dev;
>  		if (!dev || !dev->wlan.reset)
>  			continue;
> =20
> @@ -245,8 +249,12 @@ void mtk_wed_fe_reset_complete(void)
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(hw_list); i++) {
>  		struct mtk_wed_hw *hw =3D hw_list[i];
> -		struct mtk_wed_device *dev =3D hw->wed_dev;
> +		struct mtk_wed_device *dev;
> +
> +		if (!hw)
> +			break;
> =20
> +		dev =3D hw->wed_dev;
>  		if (!dev || !dev->wlan.reset_complete)
>  			continue;
> =20
> --=20
> 2.41.0

--PKt5uvKR6i4YWAdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZOORLwAKCRA6cBh0uS2t
rFrLAP4+oRNNindNlROPTOM5+s9qcGEl/rKvdscDdNFiSKBTOQD/dRKrSAGwI3BE
t4q/7EmYsAeSWIl4xwT6WepcFdgI9Q0=
=RM2o
-----END PGP SIGNATURE-----

--PKt5uvKR6i4YWAdK--
