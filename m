Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532AC7F0A4E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 02:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjKTB20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 20:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTB2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 20:28:25 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8136BA;
        Sun, 19 Nov 2023 17:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700443700;
        bh=Csn+rSOlc7hq+c8kVNN3ZRY0a5UgOwfACyTDU+giBM4=;
        h=Date:From:To:Cc:Subject:From;
        b=GQ5eWlmyF0MfSbdDe8/EDFZ9l/yhyRu23K+EbRZwDdGeXGB6sFWkA4WzWNDq01KsE
         2OBK9ejg8LiiGnbgxHaOP0oE0qC8se1jctVja3ONLZu8Zi9zhAoVwdwuHOl/+hY3jl
         e2cJizyF+sOt6oAdJcis+xfag/TJ2pZj155AuphfD0Of0b2aAuRjQ6Sm9TIKGioFna
         WodTWKADnR54thH/0gpRqk650dUcLz5qcng1ucfMQqy/Tkv0EoZxu2FaiXcV7Ap9h+
         24AJYfDFw/x2c33gm/pikCUHA9qgwzeJ8uiLGOe/p4J459GYV/lxq61Z/ahHBHreh6
         Pl2zBHZtz4qWw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SYVJM2FcNz4wnv;
        Mon, 20 Nov 2023 12:28:18 +1100 (AEDT)
Date:   Mon, 20 Nov 2023 12:28:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Fangzhi Zuo <jerry.zuo@amd.com>,
        Imre Deak <imre.deak@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: linux-next: manual merge of the drm-intel tree with the amdgpu tree
Message-ID: <20231120122818.09bb6f35@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+H5fErey4cTN8tJv.P0+EJV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+H5fErey4cTN8tJv.P0+EJV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c

between commits:

  a58555359a9f ("drm/amd/display: Fix DSC not Enabled on Direct MST Sink")
  c29085d29562 ("drm/amd/display: Enable DSC Flag in MST Mode Validation")

from the amdgpu tree and commit:

  7707dd602259 ("drm/dp_mst: Fix fractional DSC bpp handling")

from the drm-intel tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 8d7d4024f285,2afd1bc74978..000000000000
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@@ -1650,7 -1636,8 +1650,7 @@@ enum dc_status dm_dp_mst_is_port_suppor
  	} else {
  		/* check if mode could be supported within full_pbn */
  		bpp =3D convert_dc_color_depth_into_bpc(stream->timing.display_color_de=
pth) * 3;
- 		pbn =3D drm_dp_calc_pbn_mode(stream->timing.pix_clk_100hz / 10, bpp, fa=
lse);
+ 		pbn =3D drm_dp_calc_pbn_mode(stream->timing.pix_clk_100hz / 10, bpp << =
4);
 -
  		if (pbn > aconnector->mst_output_port->full_pbn)
  			return DC_FAIL_BANDWIDTH_VALIDATE;
  	}

--Sig_/+H5fErey4cTN8tJv.P0+EJV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVatjIACgkQAVBC80lX
0GzERQf/dspWZjht/bOS+ur+0tu/EliDMLpiAw0xVsjlhOfvvseEdYHvEo4ZQazz
lf+0LAj7yIQcd6hK+sv2xVn731w/pQwQF6wv7YEAsY/+EZhpwLekV6pnB30dEYyk
H0Cu3eB2QhLvsElHqqzKlq1FTVMpzucS1cfMG07aPFKZJhH8IbfUGBt4JdqFeio2
dpoGTEhVingpmX4KvvrBZc4jH9ef3XO8EAIq9Nm9eIsy4f46bR5+n94cBF1/A3jT
q8pqNYa3Z8b6zdxGeJJ4dT7xarfXEBzPU0JoOp6JsXJxdocFcT3i7geFZBtmKlyU
KD5wQSfN/cqr3IkHAyJdivP/Rx7sZg==
=YqFo
-----END PGP SIGNATURE-----

--Sig_/+H5fErey4cTN8tJv.P0+EJV--
