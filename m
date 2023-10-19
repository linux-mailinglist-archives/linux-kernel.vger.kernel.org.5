Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7727CED29
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 03:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjJSBG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 21:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSBGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 21:06:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50A3112;
        Wed, 18 Oct 2023 18:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697677581;
        bh=qI3z6q1s/kcUv15ANbLLzybgRpzqS1ETuO7M0rX3Iio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fdt7OpZBljd3Ar+Ua73JJ1Y4YjomRhBDuWkHlkCY93T/79skv0r+CTckcHeY+HB4m
         bvBX/B104RcWfA9d6he+rng9Su4W2wQxyC1vr83WEBczIHP0rWd2elQfMjDmhl0iuH
         nO4bV99CwSqaK8zwlV7VBdWh21xQgK5tIkFed+AnyS3KDWVGaw8mF1KqHKq2WxJ2H9
         vRt7Jz37Gy6f87V366It9uiYp51UUC87qkJg5zfl5ZYKS7/ydRFyBc6KDVNTVn2hhV
         qs9VLc5LgEtL3G12cvs3xz4g8QyyNTseRqQCwTdnbvqIhMJFPY+mNAbW02t5L+t3wl
         +we+qHB8f/a0g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9qKl6p9Gz4wcN;
        Thu, 19 Oct 2023 12:06:19 +1100 (AEDT)
Date:   Thu, 19 Oct 2023 12:06:18 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Dave Airlie <airlied@redhat.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <roman.li@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        DRI <dri-devel@lists.freedesktop.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20231019120618.71424848@canb.auug.org.au>
In-Reply-To: <20231010124357.5251e100@canb.auug.org.au>
References: <20231010124357.5251e100@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EvzrEbQXDf=esYQTxghpS2q";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EvzrEbQXDf=esYQTxghpS2q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 10 Oct 2023 12:43:57 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the amdgpu tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c: In fun=
ction 'dml_core_mode_support':
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml2/display_mode_core.c:8229:1:=
 error: the frame size of 2736 bytes is larger than 2048 bytes [-Werror=3Df=
rame-larger-than=3D]
>  8229 | } // dml_core_mode_support
>       | ^
> cc1: all warnings being treated as errors
>=20
> Caused by commit
>=20
>   7966f319c66d ("drm/amd/display: Introduce DML2")
>=20
> (or maybe something later that changed storage size).
>=20
> I have used the amdgpu tree from next-20231009 for today.

This build failure now (presumably) exists in the drm tree.  I am still
applying the 2 patches from Rodrigo to my tree as a work around.

I would have expected that this was fixed in the amdgpu tree before
Dave was asked to merge it ...
--=20
Cheers,
Stephen Rothwell

--Sig_/EvzrEbQXDf=esYQTxghpS2q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUwgQoACgkQAVBC80lX
0GwQXAgAkVWIBBZuVsrW2Ci7iYuETWMRJU6ZRAJdcR+EICRaoPi2FOpYQ3hbmZAr
zk0GnevzSy0db8RSKyXIQOqB4THKKtDepqNSsxUN9PenwCvjtNg/DeYeZoB6pQ4D
0/0qQgYImc5OKZfOJtqPBmBxl8pIStcs2RjmUXttz+F/Q5RYnXWtLm0McfrlqbI3
HRxHBu+KYyiH7QZ/AN06HjQXGlIBs1Ynp+9kJ1dLpz76LB2KZx+QxEcMf9lYpVgA
bT7oSS54vbHDW41VtZOeZ4fjx8zGCfFubwb/u5pC2D83ilNWEiHoXQ5meqdfK0IT
pAwgc2ZI1zm+/M1j0L7pfzUuUcTdAw==
=x90u
-----END PGP SIGNATURE-----

--Sig_/EvzrEbQXDf=esYQTxghpS2q--
