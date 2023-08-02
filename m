Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B92576C411
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 06:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjHBEVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 00:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHBEVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 00:21:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B8C11D;
        Tue,  1 Aug 2023 21:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690950098;
        bh=ytTzxjT9vf+qopNiuLBYKW6ydrwJGNWZZ6Ruz09thxQ=;
        h=Date:From:To:Cc:Subject:From;
        b=GQdU8s+d7Sq8evVo33NXW6Jx6nuVQEjrLjld9OXk4NLl1v9HteJg0ECjqXkjAZZAo
         QT2Hk59HvFCIysY47XhMlv11+Rt9xxVeufEgngwmu4lUCE2cQOQwoP3z8xWP8zowXr
         o7JAmOhVIbCArDT6Ptplz7E0T6ToyM4amMOaJQTDQKc2KQ6TXVvgMq7t79ZJrXhn5O
         hz1jc4t+edOo+M/kQI9HtEUefOYaK74jfnChH/VLXbsiuI7xPORuZn5yopCYmLuYDe
         20ZIzALjKCrK+VKks+wPj9+wwnu5H1/CniJ9uuhdn6/4Y/0sFBfnoi5kdEY308ENat
         yJFP51+43eZUw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RFzM60zTNz4yMK;
        Wed,  2 Aug 2023 14:21:38 +1000 (AEST)
Date:   Wed, 2 Aug 2023 14:21:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20230802142136.0f67b762@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rfB=1CgUJuio3xNdF5E4QJD";
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

--Sig_/rfB=1CgUJuio3xNdF5E4QJD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (htmldocs)
produced this warning:

include/drm/drm_panel.h:270: warning: Function parameter or member 'followe=
r_lock' not described in 'drm_panel'

Introduced by commit

  de0874165b83 ("drm/panel: Add a way for other devices to follow panel sta=
te")

--=20
Cheers,
Stephen Rothwell

--Sig_/rfB=1CgUJuio3xNdF5E4QJD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTJ2dAACgkQAVBC80lX
0GzEigf9GkZipAJ97rJJHzIQGzIBLx4DxDxnYu5qb6eYT8vM5YhA0m974OsBjkZM
xaukeiWxczEgnYy/DnLMwxZtV7XVALg0cuvE9KlA8OTKCaGCSXJM0cu19WjVFqNJ
tt9827VvLK/qfKuTpjm4C84UEMERipzBY10v75ZP47osAvBSyzmQgY/EsY61xvz3
aMGLwDrjUz4tYoYPhFTETtxDAexqj8y58o5TD8IaEY/p1NnEXJeSwYvBBscpxCge
MyS3MoGPpH2cGOrfkKh+l6Ew2gQfvUEjUtTDDEWYx1RDyhK9/RC9BlVoA7v0fW++
MjxxZKABac+dADLSEB+efpC31qt6wA==
=ncfs
-----END PGP SIGNATURE-----

--Sig_/rfB=1CgUJuio3xNdF5E4QJD--
