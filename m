Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7A97CB958
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 05:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234032AbjJQDgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 23:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQDgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 23:36:03 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C51495;
        Mon, 16 Oct 2023 20:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697513756;
        bh=bGj68V/SXIHs16Yy2CtFicTRiL3T6FVwR9IvINdSOxs=;
        h=Date:From:To:Cc:Subject:From;
        b=Uc9a4IiA3Q2Uc7LaTKU1Lbr89SgBgAlJvDqKDRJDULtYtJBLgsS+oaNVjoLw9NXWn
         3mpbufBGkN4G5732m2KdTARdk/tCuFxBeYIw91La4urFU7fuCNpjfLIcCZaODkcZg5
         QC0+eR5KhrtyEW1lOLy9XHg//qs3c2cUHy7PAKmkO262LUekxDCjoF0QhSCgcFdrUy
         4fp8DcJV/t92G9fFQze3W8NgKvLb2koCL2T6mupvZ3DyjXose880Or11oQxci+PARe
         R2Qcmae9axYN0ghKyLC9nRAADAMpNy1RLcuYZfVwyIvEviHXy2s/CbsIr+55IFTaDU
         gIwwBdE5dzjGA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8flJ0Rr9z4x1t;
        Tue, 17 Oct 2023 14:35:56 +1100 (AEDT)
Date:   Tue, 17 Oct 2023 14:35:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20231017143555.6a6450fc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KoDw1ok33qhwG0v_qKc_Nr0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KoDw1ok33qhwG0v_qKc_Nr0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/include/amd_shared.h:318: warning: Function parameter o=
r member 'prepare_suspend' not described in 'amd_ip_funcs'

Introduced by commit

  cb11ca3233aa ("drm/amd: Add concept of running prepare_suspend() sequence=
 for IP blocks")

--=20
Cheers,
Stephen Rothwell

--Sig_/KoDw1ok33qhwG0v_qKc_Nr0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUuARsACgkQAVBC80lX
0Gzn9Af9FL2/MMmSEvFQOR7Bm+Hlo+7o7tje1gOl46Yd6Ie1UQZ/aNSN7qVQY5ha
Pf2uTe7XaEYls8TieLEg8A9F5PA6GZKpqpR/o5AxKAeEp0wvkd4F/MovsS+Cn8eN
ydyG5uuEi0Fg+O2ROBGjQRcapNhT0zAkwcDFALbCC88RNEzhNXCv0sFVZHgRJHqn
Qw7QVJSdRsme+ho/g+b7L5ydltK0tUvzukN5kaRvxaZuM46WTDL+js2njGcGgiDX
H0YlFJm8VraEyphyBQ+KlwQPcp1jg/uPPz2mlm0sNQvGYS+fGs+Y99bMIzN1ErHc
GrubrzNXcrZC1DNP3lCodB8ngE2CUQ==
=Kn8x
-----END PGP SIGNATURE-----

--Sig_/KoDw1ok33qhwG0v_qKc_Nr0--
