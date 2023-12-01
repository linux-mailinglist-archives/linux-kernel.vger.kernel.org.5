Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B0080124C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379046AbjLASKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:10:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjLASKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:10:22 -0500
X-Greylist: delayed 1066 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 01 Dec 2023 10:10:28 PST
Received: from bues.ch (bues.ch [IPv6:2a01:138:9005::1:4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41534129
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 10:10:28 -0800 (PST)
Received: by bues.ch with esmtpsa (Exim 4.96)
        (envelope-from <m@bues.ch>)
        id 1r97gb-00045v-36;
        Fri, 01 Dec 2023 18:52:21 +0100
Date:   Fri, 1 Dec 2023 18:51:12 +0100
From:   Michael =?UTF-8?B?QsO8c2No?= <m@bues.ch>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     sunying@isrc.iscas.ac.cn, linux-kernel@vger.kernel.org,
        Neal Liu <neal_liu@aspeedtech.com>,
        David Howells <dhowells@redhat.com>,
        linux-crypto@vger.kernel.org,
        "pengpeng@iscas.ac.cn" <pengpeng@iscas.ac.cn>,
        "renyanjie01@gmail.com" <renyanjie01@gmail.com>
Subject: Re: Non-existing CONFIG_ options are used in source code
Message-ID: <20231201185112.1499c5ab@barney>
In-Reply-To: <1553cd01-37fe-48c6-a6e3-b6ea9974d40b@infradead.org>
References: <4e8525fe.607e2.18a8ddfdce8.Coremail.sunying@isrc.iscas.ac.cn>
        <1553cd01-37fe-48c6-a6e3-b6ea9974d40b@infradead.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/F1enqjq600B0_Bs.sGSFFKE";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/F1enqjq600B0_Bs.sGSFFKE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 13 Nov 2023 20:52:03 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 9/13/23 02:29, sunying@isrc.iscas.ac.cn wrote:
> > The following configuration options are not defined
> >  (they may have been deleted or not yet added)
> >  but are used in the source files.
> >=20
> > Is there something in these that might need fixing?
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. CONFIG_NETFS_DEBUG
> > fs/netfs/internal.h:122:#elif defined(CONFIG_NETFS_DEBUG)
> >=20
> > 2. CONFIG_SSB_DEBUG
> > include/linux/ssb/ssb.h:626:#ifdef CONFIG_SSB_DEBUG
> >=20
> > 3. CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO_DEBUG
> > drivers/crypto/aspeed/aspeed-hace-crypto.c:19:#ifdef
> > CONFIG_CRYPTO_DEV_ASPEED_HACE_CRYPTO_DEBUG
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =20
>=20
> Yes, please send separate patches to remove each of them.

I agree for CONFIG_SSB_DEBUG.

The function __ssb_dma_not_implemented() where CONFIG_SSB_DEBUG is used
can be removed and the switch-default where __ssb_dma_not_implemented()
is called can also be removed.

--=20
Michael B=C3=BCsch
https://bues.ch/

--Sig_/F1enqjq600B0_Bs.sGSFFKE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEihRzkKVZOnT2ipsS9TK+HZCNiw4FAmVqHRAACgkQ9TK+HZCN
iw61rA/9EKvsLfN9tBm61ftuiqXy5aDQd25tJicd1GEyHQANvatVK+gAgjileilU
4EvnGqVXSPC+9+41vFPAII7ZevON38mtnoW8AU1xh5j5YD075cuT0uu1nPaILjW1
Uuj/66Kj/ZEFaPHLbDZuhUeT+TtZw7I9pkSxkyqhm7RpYH4lzHal47c/4yi8oRM4
xnjzvK98MtUymNjRUz0ofTreCjqnTNIZ32rIaQgv8ln/SevxYFPoYIHBtJxoY70F
lTLLi5YHrAjtp/WWHP7JTx7b6RhfDuOhhbd5HcXZgP8FrG7P4Ud1xk+MLRoJsm1u
Z8ZGhrRTQKZsrtY3dp2dwoOfBfC/THMY4q73SlSqyuNbu7vTlH0/nHxks0Rp+Kxx
L9CH6ACEpkjq22gaFP/cE2fSnlBpzvv5v9aL0kMNYdPjXNDCMsgLQHmE0qID0ZJG
74xZvD2v1STgS0j55ZykQuN+NMEPda1tSzYd2B/M9hevHd7PCUx0+z/E/hYHzVms
KHfBiwxOK9mOxakcujjeMZtJmXUhhchmoEVKFPKEQ3XciAv3irPe3nJKI6TaOeeM
ypDiU7tuBHJHSHIEdptStnDIkbJ15ununTKTJ/im5V6s1Ofl+4BTPGcDpkBnrtCw
lOvy8Li4FbsP/9fH9q2alzIGwQUl1GXnUF9xIGWPalJWr+DrkWo=
=/Ulg
-----END PGP SIGNATURE-----

--Sig_/F1enqjq600B0_Bs.sGSFFKE--
