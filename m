Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AF6791E49
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 22:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238353AbjIDUgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 16:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjIDUgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 16:36:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCE9187;
        Mon,  4 Sep 2023 13:36:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 962C460A0A;
        Mon,  4 Sep 2023 20:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1545CC433C7;
        Mon,  4 Sep 2023 20:36:37 +0000 (UTC)
Date:   Mon, 4 Sep 2023 16:36:35 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     lee@kernel.org, alexandre.torgue@foss.st.com,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] counter: chrdev: fix getting array extensions
Message-ID: <ZPY/033Z0dDi5zJB@ishi>
References: <20230829134029.2402868-1-fabrice.gasnier@foss.st.com>
 <20230829134029.2402868-2-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+/TWu6qhPiWTQHjU"
Content-Disposition: inline
In-Reply-To: <20230829134029.2402868-2-fabrice.gasnier@foss.st.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+/TWu6qhPiWTQHjU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 03:40:22PM +0200, Fabrice Gasnier wrote:
> When trying to watch a component array extension, and the array isn't the
> first extended element, it fails as the type comparison is always done on
> the 1st element. Fix it by indexing the 'ext' array.
>=20
> Example on a dummy struct counter_comp:
> static struct counter_comp dummy[] =3D {
> 	COUNTER_COMP_DIRECTION(..),
> 	...,
> 	COUNTER_COMP_ARRAY_CAPTURE(...),
> };
> static struct counter_count dummy_cnt =3D {
> 	...
> 	.ext =3D dummy,
> 	.num_ext =3D ARRAY_SIZE(dummy),
> }
>=20
> Currently, counter_get_ext() returns -EINVAL when trying to add a watch
> event on one of the capture array element in such example.
>=20
> Fixes: d2011be1e22f ("counter: Introduce the COUNTER_COMP_ARRAY component=
 type")
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Applied to counter-fixes as commit 3170256d7bc1.

Thanks,

William Breathitt Gray

--+/TWu6qhPiWTQHjU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZPY/0wAKCRC1SFbKvhIj
K9hLAQDqPhZP1YNYM6y5RMNfkbjoeJho9SeB13EQIOIjwx/59gEAlFxHbZqubcku
dRYQXe4YDx4kLA6cbnrZfx8lg4Phugk=
=RCOJ
-----END PGP SIGNATURE-----

--+/TWu6qhPiWTQHjU--
