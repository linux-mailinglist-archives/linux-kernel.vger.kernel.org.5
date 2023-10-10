Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED3D7BF08A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441819AbjJJBy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378764AbjJJBy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:54:56 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5578F;
        Mon,  9 Oct 2023 18:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696902892;
        bh=FvQLIwREJVf7WrgmiGT2N4Fx5PDTplt2oikneiOj0h0=;
        h=Date:From:To:Cc:Subject:From;
        b=oAJviFeNXsOevbl5qrTlpPMjsH8J5K11C8eNjL+wDkKGOiUXCCyHFWBcvMsQh/wW7
         YhUQnALhTvdJgB06FNsNrn21R3lOLEdiJ5m/XbNxZFW3k5VjanUE5V27BfwXJO7dz1
         FosHcnvGR+f+HEiPZIlGOJ669aJbWxLGnIMyHfFNrt/D6Eyv0EtZ0y6aLPmjznXle9
         wY4jyt6du5pU6rSHU6wQJiGDyyBAnuE99D/kPntYtc3fVTiIvX7otsJvzEHql8pwd+
         PV9c7wwwri5MnfXbX4W+/tPrl1gBfqoPVAqs5jj4WUz1LuCHclJ71HQOdmdWf+9k0A
         ISFxMbkwp0Twg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S4Jqw287vz4xM4;
        Tue, 10 Oct 2023 12:54:52 +1100 (AEDT)
Date:   Tue, 10 Oct 2023 12:54:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-msm tree
Message-ID: <20231010125451.533d0dbc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XYBKMPgrI_Q7/2pGXGaccpN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XYBKMPgrI_Q7/2pGXGaccpN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-msm tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/gpu/drm/msm/msm_drv.c:59:1: error: data definition has no type or s=
torage class [-Werror]
   59 | DECLARE_FAULT_ATTR(fail_gem_alloc);
      | ^~~~~~~~~~~~~~~~~~
drivers/gpu/drm/msm/msm_drv.c:59:1: error: type defaults to 'int' in declar=
ation of 'DECLARE_FAULT_ATTR' [-Werror=3Dimplicit-int]
drivers/gpu/drm/msm/msm_drv.c:59:1: error: parameter names (without types) =
in function declaration [-Werror]
drivers/gpu/drm/msm/msm_drv.c:60:1: error: data definition has no type or s=
torage class [-Werror]
   60 | DECLARE_FAULT_ATTR(fail_gem_iova);
      | ^~~~~~~~~~~~~~~~~~
drivers/gpu/drm/msm/msm_drv.c:60:1: error: type defaults to 'int' in declar=
ation of 'DECLARE_FAULT_ATTR' [-Werror=3Dimplicit-int]
drivers/gpu/drm/msm/msm_drv.c:60:1: error: parameter names (without types) =
in function declaration [-Werror]
drivers/gpu/drm/msm/msm_drv.c: In function 'msm_ioctl_gem_new':
drivers/gpu/drm/msm/msm_drv.c:454:13: error: implicit declaration of functi=
on 'should_fail' [-Werror=3Dimplicit-function-declaration]
  454 |         if (should_fail(&fail_gem_alloc, args->size))
      |             ^~~~~~~~~~~
cc1: all warnings being treated as errors

Presumably caused by commit

  506efcba3129 ("drm/msm: carve out KMS code from msm_drv.c")

I have used the drm-msm tree from next-20231009 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/XYBKMPgrI_Q7/2pGXGaccpN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUkrusACgkQAVBC80lX
0Gy2Wgf+OUiu0lgIw8Bf6eOgEFT6A7OK/cNR/rk5U8HZoTuppmCS2l+jUhOjeo+j
Em6NVOvV+9D8L++W0ku1lCuDyFGV4Od8s9Dw5tXyeTqaqmcH8tH9wvetpTrt7XUT
Eu92lJ13g5Ef4NHJPdh8de+d9olBOpOy9qFehpDJsYvlCr6eqHyW5YsumCUpOn8s
X6Z0dXTzP1T3pocntTu8IPpZDC6dlSEC4R0uO9x5ralvnONj9rZz18WCyX2+WD7t
VMruRFMf4MQFWvaitoaAeUspUn9rKEN6C6hZS4KinZr+D1t1lQi9b6sXko3ceXyf
RYTIhCBnirR5Ua+tT2SleXr+Saa6Mw==
=TPWc
-----END PGP SIGNATURE-----

--Sig_/XYBKMPgrI_Q7/2pGXGaccpN--
