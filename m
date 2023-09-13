Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D848079F31A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 22:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjIMUr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 16:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbjIMUr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 16:47:56 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DAB1BCC
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 13:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        sang-engineering.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=k1; bh=NXR+
        PgvUKjcXgRWB0xP/Amy8Pv4iykX+WMhdQpNglaE=; b=RiYWF6VMU2rLP8usYSEX
        HDPhnc2/jiURiA2xnbiasJemLw+54IxuUUrQehQqBV73eIKcZQPu9BNE4uOKEPfe
        AbaLYeEvyKTNfKDxPxIUYg2yXMopckUwWjDHluYPE/ZqIDspe52flAzB3ICgk1Tc
        W1ibHmu40kWEFN0xGg23fvrFLakrW+5Vd7oxKxAMWB8svjJLIvm33L4bj4BzMf3x
        iNseINfKSj53mYs0K+Vl/MNMMmoUIuNJATlSzW66hZZ6E78zrlCmVKTgNOssOf79
        AluGP9EYRNRDr4OUzSKd0iFT/VyR/TFTjCTKzScB4KrKgHABhp+2sQzFpktvm/d+
        4Q==
Received: (qmail 718964 invoked from network); 13 Sep 2023 22:47:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Sep 2023 22:47:50 +0200
X-UD-Smtp-Session: l3s3148p1@+6M1rEMF4sEujnuS
Date:   Wed, 13 Sep 2023 22:47:50 +0200
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Maximilian Heyne <mheyne@amazon.de>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] virtio-mmio: fix memory leak of vm_dev
Message-ID: <ZQIf9uwjnk7DQUf3@shikoro>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Maximilian Heyne <mheyne@amazon.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        virtualization@lists.linux-foundation.org, stable@vger.kernel.org,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org
References: <20230911090328.40538-1-mheyne@amazon.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wDMOp1ZdvPgGkrx+"
Content-Disposition: inline
In-Reply-To: <20230911090328.40538-1-mheyne@amazon.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wDMOp1ZdvPgGkrx+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 09:03:29AM +0000, Maximilian Heyne wrote:
> With the recent removal of vm_dev from devres its memory is only freed
> via the callback virtio_mmio_release_dev. However, this only takes
> effect after device_add is called by register_virtio_device. Until then
> it's an unmanaged resource and must be explicitly freed on error exit.
>=20
> This bug was discovered and resolved using Coverity Static Analysis
> Security Testing (SAST) by Synopsys, Inc.
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: 55c91fedd03d ("virtio-mmio: don't break lifecycle of vm_dev")
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Tested-by: Catalin Marinas <catalin.marinas@arm.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Sorry for overlooking this in 55c91fedd03d and thanks for fixing it!

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--wDMOp1ZdvPgGkrx+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmUCH/EACgkQFA3kzBSg
KbaqGRAApFfEH92qT8AznnA5HRP2oURDPWolKwozQbtl98b4GWUGOo6EjNGgn97z
tYqC+hAp18eklFzM/m9byVHllqLUmRH/b8JQVhPDUJuhhjVpUMbDXxltD20+MbVw
OYkyxD8jJu4zUUQC1yiXCzH2kkcj0zYW3dBIOg21xFKnH5JUFOjQjNb8esTgbZKZ
JJKzs0W0Y5ZkOIJbveyqbVCBzzsrGjRaovPbEXJ4LRiHanF9Dcrg90sdHpKGYxMQ
JEZG4sS0+Z1xZkT0kZpSq2Lti09Ku/P41TweZabpgWlEHIlAap4Rkh3WC4wzN3og
uwzWjJQ3UyzTbpTuBT4c0JDIigr3HAdGJaOXLaBOkHnki8DyLkG117dBiaWOZMJz
WUP7NM2PPt78vE8l/hgr26E9mtuzNS7XVmMZ2wEVCnHRdYchNI8OuZCJ45067T1q
srkLIu3+fZt+wIkeQEg8EhO+BjeJbTV4+65z4zwOb2/g/56KMP+bg4zn6ICVKtas
6V/aohAs76jLjBX219S0aabyGXQqBdnUCgFvQoLUcMfxy8DLYvL1NdEE0Ufn3RQo
kj4dPJNLnWTiohc66FK0m0vUC7eVdj0I3bGLru+tWFa0UW3K7HQ+lIc7cQZNt+hH
Rb1IO4u8hxJy44XezL1swxDz0Y7uvMNaOjn8ks1V9hybjUZ2dyg=
=/HT2
-----END PGP SIGNATURE-----

--wDMOp1ZdvPgGkrx+--
