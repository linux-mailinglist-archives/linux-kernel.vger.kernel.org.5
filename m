Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D250A78A796
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 10:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjH1IVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 04:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjH1IUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 04:20:54 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A844D12F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 01:20:47 -0700 (PDT)
Received: from eldfell (unknown [194.136.85.206])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pq)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5AD3E6607186;
        Mon, 28 Aug 2023 09:20:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1693210846;
        bh=XLzdE2lLALnLx1tdlCiEKPKsrNTSgKEfMnf/xs+7/z8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dz69Aqyx40EFMtSJ9yFeEdg6MM2fB/ROO9OWlICc+KbFZ9LT9NgAdy2yV62Z4iBCA
         uzKowPInDRZaBfT+jiK2tzUffAr49UD0TzjRijVecm2TTT2XIAh78+1ezkmH5iRZZY
         pDASjXBuLwA86LsneLIyB8J36Xu7BAafmG/77tVsWnbZrHf7u0jW6oOToq7iEWR/p+
         uZl/Ew1W3840k+QY4U8vuca/mPKpKiZU5sO0N3+9P6gknQB89Qp3xepjhRFsxxEfvg
         32k51bVzpinZp22yCgf3FFQ/GcJ5ix2xgujkWsZy0xPzBhW3jylK2gIGJPPG8/Mfny
         uvl2oyxdybHwg==
Date:   Mon, 28 Aug 2023 11:20:41 +0300
From:   Pekka Paalanen <pekka.paalanen@collabora.com>
To:     Melissa Wen <mwen@igalia.com>
Cc:     amd-gfx@lists.freedesktop.org,
        Harry Wentland <harry.wentland@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        sunpeng.li@amd.com, Alex Deucher <alexander.deucher@amd.com>,
        dri-devel@lists.freedesktop.org, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
        Joshua Ashton <joshua@froggi.es>,
        Sebastian Wick <sebastian.wick@redhat.com>,
        Xaver Hugl <xaver.hugl@gmail.com>,
        Shashank Sharma <Shashank.Sharma@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        sungjoon.kim@amd.com, Alex Hung <alex.hung@amd.com>,
        Simon Ser <contact@emersion.fr>, kernel-dev@igalia.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 31/34] drm/amd/display: set stream gamut remap matrix
 to MPC for DCN301
Message-ID: <20230828112041.16eb5827.pekka.paalanen@collabora.com>
In-Reply-To: <20230825143708.hpndb5gmrdj3sjpp@mail.igalia.com>
References: <20230810160314.48225-1-mwen@igalia.com>
        <20230810160314.48225-32-mwen@igalia.com>
        <20230822153030.4d410ff9.pekka.paalanen@collabora.com>
        <20230825143708.hpndb5gmrdj3sjpp@mail.igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/o.k9d9d1GCoG928mAhGH+WN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o.k9d9d1GCoG928mAhGH+WN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 25 Aug 2023 13:37:08 -0100
Melissa Wen <mwen@igalia.com> wrote:

> On 08/22, Pekka Paalanen wrote:
> > On Thu, 10 Aug 2023 15:03:11 -0100
> > Melissa Wen <mwen@igalia.com> wrote:
> >  =20
> > > dc->caps.color.mpc.gamut_remap says there is a post-blending color bl=
ock
> > > for gamut remap matrix for DCN3 HW family and newer versions. However,
> > > those drivers still follow DCN10 programming that remap stream
> > > gamut_remap_matrix to DPP (pre-blending). =20
> >=20
> > That's ok only as long as CRTC degamma is pass-through. Blending itself
> > is a linear operation, so it doesn't matter if a matrix is applied to
> > the blending result or to all blending inputs. But you cannot move a
> > matrix operation to the other side of a non-linear operation, and you
> > cannot move a non-linear operation across blending. =20
>=20
> Oh, I'm not moving it, what I'm doing here is the opposite and fixing
> it. This patch puts each pre- and post-blending CTM in their right
> place, since we have the HW caps for it on DCN3+... Or are you just
> pointing out the implementation mistake on old driver versions?

It's just the old mistake.

I hope no-one complains, forcing you to revert this fix as a regression.


Thanks,
pq


> > > To enable pre-blending and post-blending gamut_remap matrix supports =
at
> > > the same time, set stream gamut_remap to MPC and plane gamut_remap to
> > > DPP for DCN301 that support both.
> > >=20
> > > It was tested using IGT KMS color tests for DRM CRTC CTM property and=
 it
> > > preserves test results.
> > >=20
> > > Signed-off-by: Melissa Wen <mwen@igalia.com>
> > > ---
> > >  .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 37 +++++++++++++++++=
++
> > >  .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  3 ++
> > >  .../drm/amd/display/dc/dcn301/dcn301_init.c   |  2 +-
> > >  3 files changed, 41 insertions(+), 1 deletion(-)

--Sig_/o.k9d9d1GCoG928mAhGH+WN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmTsWNoACgkQI1/ltBGq
qqc2XA/+IlIUTtxKBGtR+897zsMq8MTc9+totpOEfW0qeCEAnY5VoqyQRjqBeS3u
Q+ALqRVPKydxGOXUt/xy8qzRaEpahv80jtoKcXW95DrTzv9FPDLl855HZZYClTNU
N4+/sq3GVnWfDK9yP/raedG75kd+mIpK4kbIS6t45v/1POX84qbAgwJycXrVdQi6
0vXPceMqWjXm+saFrceFAwshrb+brsEMTtZdWUQEsO2ytY/dm+XA5DfznINGEb4F
ET0SkTINsXOD2DrYEUQU8iNoV0U/Gp5BuRozW/gOREyhgpDhsfHF/k9V1i5naKeM
9hRmRxEUE43z4f5PAHHhIJTQ14tShnG9/eQZFagWQBvkRipnIo3tA497wq4W/UKK
hMKOpeySI+RNnxfB+kjofGziTnrljdfdpdmsqO6Z+iBzpW63Wy8aWTAlhzbkRVhl
DslibHmDUOP2ohbBaF1NSdP19GTit4bjfhi3XAO+EDdWcw3mHQtrEjAdH5tp9kUn
cVSQQi3cwDUYABsMSCq5I8Rg8FHE0pBFhYbx0q8O1180jFzqa8swVEAQLsMU4PCP
bIMfNsm11WbfbGilVoKTy3rHzPeCF+ap6T4pR3yLBrqVxzh9YAC4AiHR23b/6uyT
oBExoEeaCL7Vsx7JvzzXEpJlaAW+ghTBZnjn3h3X/rOM3my3Wu4=
=p8Ys
-----END PGP SIGNATURE-----

--Sig_/o.k9d9d1GCoG928mAhGH+WN--
