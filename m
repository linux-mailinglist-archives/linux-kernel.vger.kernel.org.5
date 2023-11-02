Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030607DFC50
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 23:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377469AbjKBWVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 18:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjKBWVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 18:21:45 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E786D192;
        Thu,  2 Nov 2023 15:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698963697;
        bh=f3Mv1PfjmUThu6abXvcPwvt2F05nrGBngw82Qc8TZG0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TcRVjMFN4RlTyBBpWwyQEExQLWja3pC/WWTGxRFEOSuWgoOdy7hZ/pR8DIvkMBQ9p
         Ovz69uZq2p9GkK4h5xVMKeoQeHoyvddUMM2DOn5l50bKh11f1dvgbeWDJyG90FZAnQ
         eITN0A4bqsR/6fuMUdq56EULrfNglwgt9GUpRfVZ3pdidVZPnFfeFIsvqR2JnuBxJ7
         wC/gyA+gT79lIdKiMm+o+O795iuKrZc9FC+TU6V1s6bZHeAWGvx6Se9XxfZ+JNUrI8
         j/PhXXprimR5CS/9//G0J2ymmI/mkyELWMt1LgLjFjGqvsHE+gLp5qpXOtDu3fIBfe
         k+O/ouuYExTLg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SLyym43vBz4xNH;
        Fri,  3 Nov 2023 09:21:36 +1100 (AEDT)
Date:   Fri, 3 Nov 2023 09:21:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shuah Khan <shuah@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: linux-next: manual merge of the kselftest tree with the
 mm-hotfixes tree
Message-ID: <20231103092134.7ddde5c3@canb.auug.org.au>
In-Reply-To: <20231019163310.6c24d6ac@canb.auug.org.au>
References: <20231019163310.6c24d6ac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_A+MC2CEDlPX8.Osu64lCNT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_A+MC2CEDlPX8.Osu64lCNT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 19 Oct 2023 16:33:10 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the kselftest tree got a conflict in:
>=20
>   tools/testing/selftests/clone3/clone3.c
>=20
> between commit:
>=20
>   fc7f04dc23db ("selftests/clone3: Fix broken test under !CONFIG_TIME_NS")
>=20
> from the mm-hotfixes tree and commit:
>=20
>   34dce23f7e40 ("selftests/clone3: Report descriptive test names")
>=20
> from the kselftest tree.
>=20
> I fixed it up (I used this file from the latter commit) and can carry the
> fix as necessary. This is now fxed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

This is now a conflict between the mm-hotfixes tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/_A+MC2CEDlPX8.Osu64lCNT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVEIO4ACgkQAVBC80lX
0GxtQAf/QyTWDq17gLUDulERb35r/zP9xK5HCbelCG2ew58C5Z2WuWXUzYiJUAgQ
+eTofCe59u+9kxYGnIpZ938Nk7wLuQu00dYpg4EzK2cOZ54ALg6EzWzvP57sduZA
tUj9kxMYeGjGLMdpPc/3u3DZ3b0tEhRpnDMGSPs6Fy3I16HE7Q05Asw0cH1p7dx1
iVYCmiV4S6Zgqaq8UyAFfBpZbiXUxqvLWMGPn8W6eraj9nTmVgUo/zD76CHUf/B4
lmPX0bHzAapGF4Y/bt6bjtEorUmhAzs0ojOCuWuTeGXlnHdBZSTOPhySug/Jw3SD
rvukq2IEim6rYwXLkhmHaSOHmyIbyw==
=qXVh
-----END PGP SIGNATURE-----

--Sig_/_A+MC2CEDlPX8.Osu64lCNT--
