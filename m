Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEFA75DE71
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 22:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGVUMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 16:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGVUMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 16:12:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE6D1AB;
        Sat, 22 Jul 2023 13:11:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3DC560BAF;
        Sat, 22 Jul 2023 20:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C120C433C7;
        Sat, 22 Jul 2023 20:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690056718;
        bh=/9qrpDonabY7Xm8MCIwJtyIeTf31N3Re/7USWMHRKcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FAbEVh9Heu4E8u7iKDY+e64+Tk7EG3xFaFcSkA/oiTpv72taAYk9Q+td/YzDreOuA
         +2RDHN4MfVsWILebbSVVmIsaG9fSxAwkQ414cfBokjn5dic+30jaw0UExsHy96+Jxb
         a1dDPxRZDeutnFDey2kOvsgVzeuqTNNDxVsNhR66qbUcVZWcT+eN1SWU2QnfsSK1l6
         V19jdwhKq1ar2D2PS5GmhV0j8vkFyeR6/fSOVSYONuzecfx0FOgzLgn3fknlSs7SxH
         Gs2UVudmYXXi6Z0YnplijX7e8pduAdtiuX+Htc3Cj0jZFbfJqUb/vkFpQ8yW7wpY06
         VfyppHg6NsFcw==
Date:   Sat, 22 Jul 2023 21:11:54 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, Icenowy Zheng <uwu@icenowy.me>
Subject: Re: [PATCH RESEND RESEND] thermal/of: support thermal zones w/o
 trips subnode
Message-ID: <ZLw4CnzLI/QHPGWx@finisterre.sirena.org.uk>
References: <20230722122534.2279689-1-zhengxingda@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qmlxt8wSsnvuRw3d"
Content-Disposition: inline
In-Reply-To: <20230722122534.2279689-1-zhengxingda@iscas.ac.cn>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qmlxt8wSsnvuRw3d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 22, 2023 at 08:25:34PM +0800, Icenowy Zheng wrote:
> From: Icenowy Zheng <uwu@icenowy.me>
>=20
> Although the current device tree binding of thermal zones require the
> trips subnode, the binding in kernel v5.15 does not require it, and many
> device trees shipped with the kernel, for example,
> allwinner/sun50i-a64.dtsi and mediatek/mt8183-kukui.dtsi in ARM64, still
> comply to the old binding and contain no trips subnode.
>=20
> Allow the code to successfully register thermal zones w/o trips subnode
> for DT binding compatibility now.
>=20
> Furtherly, the inconsistency between DTs and bindings should be resolved
> by either adding empty trips subnode or dropping the trips subnode
> requirement.

This makes sense to me - it allows people to see the reported
temperature even if there's no trips defined which seems more
helpful than refusing to register.

Reviewed-by: Mark Brown <broonie@kernel.org>

--qmlxt8wSsnvuRw3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS8OAkACgkQJNaLcl1U
h9CRvwf9EgwMjwx2a6iutkecp3uFZwWNnW29QRQ4CiMFagDVw0T4QBY1c9lZHt+G
gWpeUxAmdhOlFOPqUjsECVD4WLb0jgBLR/mTStJlVTfRDh19L7sqdPjv1wusWJRC
EpvO18flHCvptt/uGpGJSpgSjvsdno2UN15ItUv21WPUo1fcyKymyRDoEREAETHy
TQNRktd6GG6MxGdDPYtg+H/2UrI80IFS5r608F+lmcjo4J67dI2+x/TiuX5MQ3dD
zR1NUdaACpYwjEctJ23troInehqwwglXs+CNm/p/WC9sWgfYaKSYdJXpjlS+mHFt
NVJaVP9uS0BcAJL7sGXEapQApo6Beg==
=Anzg
-----END PGP SIGNATURE-----

--qmlxt8wSsnvuRw3d--
