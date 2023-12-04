Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9654B802B1D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 05:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234444AbjLDExC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 23:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDExB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 23:53:01 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA43E6;
        Sun,  3 Dec 2023 20:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701665586;
        bh=nAiPGlgLoJa5HE+3iDYkQzrj50qeuCSm7BSrr4hJq50=;
        h=Date:From:To:Cc:Subject:From;
        b=KLfgdvfZdzrNCk2R9c7gAS+ObFswQlGbwfjUZeCw4AFmSFBIQA66tNm35a/7PLpFH
         JvcC0YuHLHs4DkcHyAOwCK+msoDxIawKP7EU79qiV4KsbgAkqbbSNU81tYy23dnvu3
         mEQn6EalYR3aEGh643sM8tP2Ndm2NVDeverpgPp0621hMHg/TvcKP2D4VxPl3Rh3cS
         btC0l16+7KoRC3mzjLE2MTXZJqrPKDBOIFLOm7p0TbkoNabF1Tvj5yQ8x35FH8owD7
         3AevB/wSYyXzBblH5gADO4P7Mj7RsG5by9ZXjvwWa7AXxz9G+9Y8RfjJYmPmcmeXMv
         QZkas7agbjYXA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SkBBB01CJz4xdk;
        Mon,  4 Dec 2023 15:53:05 +1100 (AEDT)
Date:   Mon, 4 Dec 2023 15:53:04 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the drm-misc tree
Message-ID: <20231204155304.630c53eb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XfN08Ybtx2W8wlh79T7O6KX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XfN08Ybtx2W8wlh79T7O6KX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (htmldocs)
produced these warnings:

include/drm/drm_plane.h:60: warning: expecting prototype for struct solid_f=
ill_property. Prototype was for struct drm_solid_fill instead
include/drm/drm_plane.h:833: warning: Function parameter or member 'pixel_s=
ource_property' not described in 'drm_plane'

Introduced by commits

  e50e5fed41c7 ("drm: Introduce pixel_source DRM plane property")
  85863a4e16e7 ("drm: Introduce solid fill DRM plane property")

--=20
Cheers,
Stephen Rothwell

--Sig_/XfN08Ybtx2W8wlh79T7O6KX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVtWzAACgkQAVBC80lX
0GwvrAf/W6rEf7jwVg7bjAeXJL9rUPUCc5f2948+wlPigwjs+VIIGtrffACqu/Va
q3pzDydgm18znC2RrlYCSWuCvJF2UnXBcrj+UfyiN7QYeiw+xhlN2VC5+T4LLLFR
SToiudDrhTZLxcnSThvORm7gQGdj5TEq7JL1DfwHB3NqV8EUa2AtJuvdQnYQhR8B
k16MrTmY90KjHvehsgrYb5Pl3PIG3NxnB2mQUu5Gka6NY501tdK4IuRLlKJ9ww6f
QQi9UoX8Whava7t5liiR8aBKgkpTfqmWWyyYWqwhY5XBS02v8VsqQmKFq1sF2ZOq
pJZZJwT/aEa6qD2uhUO3zkYyB56oAA==
=GvJO
-----END PGP SIGNATURE-----

--Sig_/XfN08Ybtx2W8wlh79T7O6KX--
