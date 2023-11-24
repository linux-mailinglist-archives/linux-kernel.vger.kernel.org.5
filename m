Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C687F69A3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjKXAAW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:00:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXAAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:00:20 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4ADD6C;
        Thu, 23 Nov 2023 16:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700784021;
        bh=4u/I//7hjlJWABhYXJ8C7CRuJPSGckPXSpzxEFjRSXw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J9heKbYiobAHKL07AHBp2Z+L1n2gM94suXGkBLEkY1bbUJP+aNRreu/xdPO1osc4k
         8L9mSRNyRCvXN4tiQXk3OCm0fX4V40wNx4rDArGONLrzotjAwKs7hd3LUWXTgx9DuX
         yQYRlp4BZQA50GvoR4LM/eS+A3ZhI434aKBit9/rtwr/oD+1jKBO2Bd2pg8ShsaVoQ
         kKI93tr5Q6fgF7DuxszoOgXnzaHV8VA5iZrurXtE1pfKrwLdANcYqx68XBliDBjfF6
         wzcl/yye3ABFb3R2DbVCYIj/NtdfiGB+BLUNyqDgiobFqgB/klRLipN3Wv99XyQkET
         0B3U+E5zX/WUA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sbw8z6FYPz4x1R;
        Fri, 24 Nov 2023 11:00:19 +1100 (AEDT)
Date:   Fri, 24 Nov 2023 11:00:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Dave Airlie <airlied@redhat.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Fangzhi Zuo <jerry.zuo@amd.com>,
        Imre Deak <imre.deak@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: Re: linux-next: manual merge of the drm-intel tree with the amdgpu
 tree
Message-ID: <20231124110018.33c10a48@canb.auug.org.au>
In-Reply-To: <20231120122818.09bb6f35@canb.auug.org.au>
References: <20231120122818.09bb6f35@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cnA4g+gCkd46mEk0SGkmvNe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cnA4g+gCkd46mEk0SGkmvNe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 20 Nov 2023 12:28:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> Today's linux-next merge of the drm-intel tree got a conflict in:
>=20
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
>=20
> between commits:
>=20
>   a58555359a9f ("drm/amd/display: Fix DSC not Enabled on Direct MST Sink")
>   c29085d29562 ("drm/amd/display: Enable DSC Flag in MST Mode Validation")
>=20
> from the amdgpu tree and commit:
>=20
>   7707dd602259 ("drm/dp_mst: Fix fractional DSC bpp handling")
>=20
> from the drm-intel tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 8d7d4024f285,2afd1bc74978..000000000000
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@@ -1650,7 -1636,8 +1650,7 @@@ enum dc_status dm_dp_mst_is_port_suppor
>   	} else {
>   		/* check if mode could be supported within full_pbn */
>   		bpp =3D convert_dc_color_depth_into_bpc(stream->timing.display_color_=
depth) * 3;
> - 		pbn =3D drm_dp_calc_pbn_mode(stream->timing.pix_clk_100hz / 10, bpp, =
false);
> + 		pbn =3D drm_dp_calc_pbn_mode(stream->timing.pix_clk_100hz / 10, bpp <=
< 4);
>  -
>   		if (pbn > aconnector->mst_output_port->full_pbn)
>   			return DC_FAIL_BANDWIDTH_VALIDATE;
>   	}

This is now a conflict between the amdgpu tree and the drm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/cnA4g+gCkd46mEk0SGkmvNe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVf55IACgkQAVBC80lX
0Gya3wf/Wu5hfPJD6u2XJMjFb6UEq7eNnLtimEME4lJwD9Byp/lIUzlV7O+8sspB
Do/KMS8hZVtlBCzLMpbjCgMUt9nuYWVX7Kr1VSiSjmOChLd7NilCWJXcQxPvf6Td
LX3Ebvi4uTeVh04da20nnlaK4Z367lf1ay+PexITtBnwHV/xN2twAibWEPBoeknW
Y/UIPIVaadc9AquF9DOHBVEUqNhUiCidlY9oj/VFCYjLkjhd8bqUMaehSqWJXcfh
vowpQI9NERRk2y5EBi2EbN5FU7bid32hN09gHnPoD7BfCVs7bgtO0V6k/A1mdLKv
MYCh1jpETpRjp1b32sAhk3z5OVHWRg==
=szxH
-----END PGP SIGNATURE-----

--Sig_/cnA4g+gCkd46mEk0SGkmvNe--
