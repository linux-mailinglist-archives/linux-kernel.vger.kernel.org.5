Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4697FA69E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbjK0QiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjK0QiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:38:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DB2B6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:38:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F78FC433C7;
        Mon, 27 Nov 2023 16:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701103096;
        bh=Jc3uA/l1xBlBTvWQCweF4LiIVoRMESPYgni0yWyW2Fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RTQIm9VH39NKodbZyyDvRXxu01IHJDuYFiSXB4jaBnPiFhXMweVgff7c7Ccb6CS/F
         LnM3e6/tBcAaiZUxblFUn6aj9+y55YxbyqHf32ns3pwKhPRxDBOHY51UCo6QxclrTB
         faIMrxb/8qLlPrMx7z6Pi4ppFSX5Zqo/sR0uEDxTb7xgsFOFqSUVszxMpSu8QMvFNw
         Cph8H3g+F+BZzwmh/K0i3MIMjzxYI85fQ/0vrnLEeWtAFhcBwB6EnIgiLYbVYfKyG0
         /N2EPflRHlJAso6QDwGSjJVgRFmyhkYoeJWlLxO/9eIZwiEBRJNsyUGE+x1qB1l0ZH
         I27k7+m89VOGw==
Date:   Mon, 27 Nov 2023 17:38:13 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     rafael@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        angelogioacchino.delregno@collabora.com, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, Liu Ying <victor.liu@nxp.com>
Subject: Re: [PATCH v2 1/2] driver core: Export device_is_dependent() to
 modules
Message-ID: <v6rthnruba5xaxazsn4jsptn6catso5qwuyf5xxbf4ml25b6eo@snttjo7oqlod>
References: <20231127051414.3783108-1-victor.liu@nxp.com>
 <20231127051414.3783108-2-victor.liu@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qtwx6kzcm62expan"
Content-Disposition: inline
In-Reply-To: <20231127051414.3783108-2-victor.liu@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qtwx6kzcm62expan
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greg, Rafael,

On Mon, Nov 27, 2023 at 01:14:13PM +0800, Liu Ying wrote:
> Export device_is_dependent() since the drm_kms_helper module is starting
> to use it.
>=20
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v2:
> * Newly introduced as needed by patch 2.
>=20
>  drivers/base/core.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 67ba592afc77..bfd2bf0364b7 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -328,6 +328,7 @@ int device_is_dependent(struct device *dev, void *tar=
get)
>  	}
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(device_is_dependent);

So, a committer just applied this to drm-misc-fixes without your
approval. Could you ack it? If you don't want to, we'll fix it.

Maxime

--qtwx6kzcm62expan
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZWTF9QAKCRDj7w1vZxhR
xb0rAP48ijAtHc/miJhU3dvSZ7sHTokRzAIYyqw7KRtdReE2hwD/ahQdxB+702cR
W49SZmDCxK5raw/Hq4Pk4Xi/s7ICwA4=
=B8s7
-----END PGP SIGNATURE-----

--qtwx6kzcm62expan--
