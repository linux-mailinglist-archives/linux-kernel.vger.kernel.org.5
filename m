Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398E27820BF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 01:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjHTXsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 19:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231708AbjHTXsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 19:48:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C169A7;
        Sun, 20 Aug 2023 16:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692575327;
        bh=COkvBI7N2ehOTBVtUIyn0e6v0RX3iu9A9TgUepdtMyI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X+4h8ujfVLohlsjft6+UDhKlSdPKmzBwJ3Fp1oZWXh/UNBoA+CXXAo6ycMo4f4dhF
         Xg7LUF1XeVFDNInzbMzi9WpzHfpfhJtEFiiSpFmIr8KXR/iIOkqQZ11HIFxEbRDVax
         Shy4uqdt7m5zZsjTJwtd2T/DO+QtwBiPv7amtgo1Rs1KvVSuMvUEqYdcjvieVbV/95
         VdEUkRBu054T4K0LVGX2Ur9Kq/Xs3dQ2efRaOCGLvZRP/7tXIj4XjaHYiZvxx+zLtJ
         RV/etosS5uzI2tbiEVlMdWp25v1uR9Avw7ceZupQ0BNgkVT1GjKcsrXsQ9igamiXrH
         5dbVBYxJK5kdw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RTXPW0zGNz4x2D;
        Mon, 21 Aug 2023 09:48:46 +1000 (AEST)
Date:   Mon, 21 Aug 2023 09:48:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the nvmem tree
Message-ID: <20230821094845.440c96b2@canb.auug.org.au>
In-Reply-To: <20230815202508.0523ecce@canb.auug.org.au>
References: <20230815202508.0523ecce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/m_uatn3UTxXxDPvysnGgUWZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/m_uatn3UTxXxDPvysnGgUWZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 15 Aug 2023 20:25:08 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the nvmem tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/nvmem/sec-qfprom.c: In function 'sec_qfprom_probe':
> drivers/nvmem/sec-qfprom.c:59:13: error: unused variable 'ret' [-Werror=
=3Dunused-variable]
>    59 |         int ret;
>       |             ^~~
> cc1: all warnings being treated as errors
>=20
> Caused by commit
>=20
>   9c7f2bce8a0e ("nvmem: sec-qfprom: Add Qualcomm secure QFPROM support")
>=20
> I have used the nvmem tree from next-20230809 for today.

Ping?

--=20
Cheers,
Stephen Rothwell

--Sig_/m_uatn3UTxXxDPvysnGgUWZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTipl0ACgkQAVBC80lX
0GwyiQgAj1wTUFqxmYTqDwZASyJvnwdlULBZSZ7VhSpuujBua3r6DyytUKAcuh6h
y9Hvlgx7u0akWiBt4U6fJb2EJnX9duFcSKRqtd5OeYJuuRw/SVqdBJkaDKK3bk+n
Gz/jCpc3P95utJg0Harqf0Q353rLpuYpILZR0oVLNH/JMb0+28tFlpi5OIaMF9Cz
tLzB22Th7tVIP/fYo+LNFD/mG64RngisMiFb+koOkSgfy2QH306C4Q7UXFiC4p26
yUOKrXVQ4VNXkpApmIk0Wa+Xlwn+YggTICmlHHQPEikSRcwbGAziWV6BzG0aOQPy
ZPhG0dYeC90hSy0rTRb9XLEfXz18Rg==
=ALqr
-----END PGP SIGNATURE-----

--Sig_/m_uatn3UTxXxDPvysnGgUWZ--
