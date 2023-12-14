Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155A281266E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 05:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443119AbjLNE3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 23:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443108AbjLNE3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 23:29:12 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE4D106;
        Wed, 13 Dec 2023 20:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702528153;
        bh=fSio+a5hsquQcmFGlgo3t3PTAmDJ0JhFaGUBOmHBkOg=;
        h=Date:From:To:Cc:Subject:From;
        b=jw09IomDoeIwO8NkRPDRjaVG1dSceWD9O5jN6C1uM73ZLDgWedWDrETl6bKiZgA6E
         aWX6CjqUJtUeiJwjZzZSiI5EM6+OQs2dGCeIw6JHUYKZtTM8uGt6xtzpwy686LAsHY
         4GBNll2Amn9JDwEXZ6cTPbqDn/c/YV4BRNvskQRWgKTr3N/fEjmICoSEQorTvxMQep
         X6lu6xvYLxtJ6DmKOH5+t0Tl1ZGIMguxPx98lIP6ZIJj7eyz/Kjb/AJ0i+46Z0iYK+
         buFhpStmxqYiXze4QrKbEcsrAjWF1eWsydVVC/KWvPNRAie6k2AlFsLI22CkJtsYR8
         tEnjytqUicz8Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SrKB03bMTz4wqN;
        Thu, 14 Dec 2023 15:29:12 +1100 (AEDT)
Date:   Thu, 14 Dec 2023 15:29:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20231214152910.79669d55@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/P_BLPKXO6mXYrOnn7/Xy=dZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/P_BLPKXO6mXYrOnn7/Xy=dZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c:666: warning: Exces=
s function parameter 'crtc_state' description in 'amdgpu_dm_verify_lut3d_si=
ze'
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c:666: warning: Funct=
ion parameter or member 'plane_state' not described in 'amdgpu_dm_verify_lu=
t3d_size'

Introduced by commit

  aba8b76baabd ("drm/amd/display: add plane shaper LUT support")

--=20
Cheers,
Stephen Rothwell

--Sig_/P_BLPKXO6mXYrOnn7/Xy=dZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV6hJYACgkQAVBC80lX
0Gz65ggAkY5wM7ftzJDSboo2uOdckggzqOiwUFwq5MBhPPV2fny4SaOFIBp/fiqd
DUz8dsU8nLRaRFWDOSGIyBmETXDdqAc74JzCkda3bEiyABViyZydr3LytUJVheJg
o2j/MvOqUD275Y4E2EAekflFt6KpKGpcNUP+Q5YU9QlyIBk/aigCF48vwrFJnrkT
cLI80ooKwEDo11LjQrQ+2QpCPVUISJvk5nsIlP0nFIzres1WSwUnagtoZc9Ac0Ep
h/7fEMfIPVPvW+lpc27roPuXAbNjX7ymPDnOqUCgPckKRhUnoNZvGRVzF7ieNbZS
qU6gC8sjWL4Xkm/CIbxnX7n2gCql/A==
=Rma6
-----END PGP SIGNATURE-----

--Sig_/P_BLPKXO6mXYrOnn7/Xy=dZ--
