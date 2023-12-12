Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD45180E287
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345792AbjLLDMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:12:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLLDME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:12:04 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8496CA0;
        Mon, 11 Dec 2023 19:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702350730;
        bh=gp6e0CjpYzTfweZHrhPCpFYj23TVC2Kc6wxzQsjXuUA=;
        h=Date:From:To:Cc:Subject:From;
        b=TnvYOyi2W9RR7HEFHILNlbS4EMMJm6/0pd1bHDODwGe3Phy4BoJbA8e9bCUVUwrxg
         iqZBAcMMv1uMFQfk7lJspKCKv2fdsrpdYo+M0YbVEQirHWe9gKtFS/Pj5QhiBpfPTN
         IR2UMYO82IAvrghqiQghG2NJ7QuAoeG/qgPVNjOYdRZB/FtCqcv1ZR8ir3F0J3Iqm9
         0S1qqizj5f/1zS4LFbHhQV88rjL/e7sBIPpN/JQSwVzMx4AKPOh11wo4PpaQC6tJFJ
         f6Ec8jnhWdLC9o88CP52D7ePcP41KL8B8EUszSUpmfgudGoJsnhnX5bWANmW88xc8l
         2u4g/4mv/e+DQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sq3Z174hCz4wc1;
        Tue, 12 Dec 2023 14:12:09 +1100 (AEDT)
Date:   Tue, 12 Dec 2023 14:12:08 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the hwmon-staging tree
Message-ID: <20231212141208.42ece7fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RQ_/sx5xwmKjlfvedWg=mgj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RQ_/sx5xwmKjlfvedWg=mgj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hwmon-staging tree, today's linux-next build (htmldocs)
produced this warning:

MAINTAINERS:27997: WARNING: unknown document: '../devicetree/bindings/hwmon=
/ltc4286'

Introduced by commit

  892a1aa5d051 ("dt-bindings: hwmon: Add lltc ltc4286 driver bindings")

--=20
Cheers,
Stephen Rothwell

--Sig_/RQ_/sx5xwmKjlfvedWg=mgj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmV3z4gACgkQAVBC80lX
0GwDgwf9GlNJ+bj/bA41hLvjhSxo0zswbqfs5eAkPqOQ/PJsmngkqSZTreY+Ou/5
yiVKXy5TZlz2sulcWuOFKTQIj8ZhGAlbYVhJ7xhdNuYd6YEUJcInpFuVs8b8HlGQ
WzdQ8/ZWdOynbCO/KXDMNHtcHUCMRbLzYcHuShzU5BJD6JDiRJ85pajp6lN6dXFm
6KKe8mLtdv2g+/hpcKNRFhHtp8tiiffDs+Tbg7Lg512p5aSfPCk0cWx1h++VeM1F
o7VphXlCzBZc5Sn44xGtvxicllcy/FTYHnaPyiYShRIgEmOac/RYkUaewTB0TRpr
kYwR7h9B7LK+gCl2FygmccO6qBLmAg==
=O9FF
-----END PGP SIGNATURE-----

--Sig_/RQ_/sx5xwmKjlfvedWg=mgj--
