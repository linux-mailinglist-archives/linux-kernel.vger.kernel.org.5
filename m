Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F206797A64
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245242AbjIGRjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245204AbjIGRjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:39:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C77E1FEA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:38:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60EC7C433CD;
        Thu,  7 Sep 2023 06:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694069507;
        bh=aPO6USzzdxuixOq9PQ0iJB0Us+7uTGzd+PLWgzkmPBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dLqYu4bOXnOawS/rR2H/pGassLtLUAXIzQYm40TLW44NUNTR0W4qACqxqaAhM0cRR
         LI4Y7HpZR/wx7paImxUEWdxzPpp1doqWoTftC+fPwnlmbiH/Fs0U7dcZ0hxgC8DfTF
         2wBITpI00WkU2PL5l71yONX9lXFa3fvZ8T28wt5qZYQJ7etZ4z5ExNfkAvTSKMUuGV
         eWgFLhzYlmrRd6ZJFfZzoM0/zcLLwkdSQT5B0KaVgh94JAhC/Tq9RwUdjfef8wArA3
         a+tT9gIyFlxSDseYVLJ4Hzd89UEjuzsxF/9jV2h7Gyi+wCiy5AIGvxIPbNiG0iDEpG
         2FyC0qTgvleCg==
Date:   Thu, 7 Sep 2023 08:51:44 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, daniel.vetter@ffwll.ch,
        daniel@ffwll.ch, jani.nikula@intel.com,
        ville.syrjala@linux.intel.com, seanpaul@chromium.org,
        robdclark@gmail.com,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>
Subject: Re: [PATCH v3 1/5] drm/connector: add trailing newlines to drm_dbg
 msgs
Message-ID: <p3pmpj6a72tinjalmntxjw4cqhltkqux2zjwgwx4sxvvqeitkp@6wqr7aujr4h6>
References: <20230906190224.583577-1-jim.cromie@gmail.com>
 <20230906190224.583577-2-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gmy6cug3yiqzvetg"
Content-Disposition: inline
In-Reply-To: <20230906190224.583577-2-jim.cromie@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gmy6cug3yiqzvetg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2023 at 01:02:19PM -0600, Jim Cromie wrote:
> By at least strong convention, a print-buffer's trailing newline says
> "message complete, send it".  The exception (no TNL, followed by a call
> to pr_cont) proves the general rule.
>=20
> Most DRM.debug calls already comport with this: 207 DRM_DEV_DEBUG,
> 1288 drm_dbg.  Clean up the remainders, in maintainer sized chunks.
>=20
> No functional changes.
>=20
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
> ---
>  drivers/gpu/drm/drm_connector.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index f28725736237..14020585bdc0 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2925,7 +2925,9 @@ int drm_mode_getconnector(struct drm_device *dev, v=
oid *data,
>  						     dev->mode_config.max_width,
>  						     dev->mode_config.max_height);
>  		else
> -			drm_dbg_kms(dev, "User-space requested a forced probe on [CONNECTOR:%=
d:%s] but is not the DRM master, demoting to read-only probe",
> +			drm_dbg_kms(dev,
> +				    "User-space requested a forced probe on [CONNECTOR:%d:%s] "
> +				    "but is not the DRM master, demoting to read-only probe\n",
>  				    connector->base.id, connector->name);

I'm fine with the general idea behind this patch, but we shouldn't break
the message itself.

See https://www.kernel.org/doc/html/latest/process/coding-style.html#breaki=
ng-long-lines-and-strings

Maxime

--gmy6cug3yiqzvetg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZPlzAAAKCRDj7w1vZxhR
xbqrAP9CgpjovfOg+REj39MWlNMI8yrtH+BY1wWGACZsq9xiCgEAnGaAZPYdt4fM
C4Y1xIty+CU5YiD1WRooqMMGh6jHJws=
=vfeP
-----END PGP SIGNATURE-----

--gmy6cug3yiqzvetg--
