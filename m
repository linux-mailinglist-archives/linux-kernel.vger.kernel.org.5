Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 807E175A498
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 05:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjGTDAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 23:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGTDAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 23:00:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE57172A;
        Wed, 19 Jul 2023 20:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689822008;
        bh=F0XXBdWS7R4lwC8NzegUrg8hr6Npl1NTnNeQR83Gt5I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GYm77Ex4VFZRz9HQDbOPmcZLO/G+KXbLUDRAuGsj8HcA/5inXKxmlCWBfiy/kk8SQ
         LZ1MkUdVdQsOPN4HFkIdU/uwM8iIyDKTKy3kah/SJaQEkrDuWyN6bb2sDRFew1ktET
         3M08spRBhmcTHju26URzA82itTbPos5ayHtlOvZOWzcmh6SJpy82cbo+krWIIe4Mz5
         /tagojSmCjmy4UKbiPRl5jV7ldcdQFPrxHA8AbqRi4OgyybgA636eBQbwmpngY6xCy
         M4cFKUTG0eQSoBEvQJBL5PButS9vjsZoEhzJLcnobxWZMhoZGe9vtMaWo4St4Beqr2
         Zbhv/Pz3EPcSw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R5y904frxz4wqZ;
        Thu, 20 Jul 2023 13:00:04 +1000 (AEST)
Date:   Thu, 20 Jul 2023 13:00:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20230720130003.6137c50f@canb.auug.org.au>
In-Reply-To: <20230719182439.7af84ccd@kernel.org>
References: <PH0PR11MB51269B6805230AB8ED209B14D332A@PH0PR11MB5126.namprd11.prod.outlook.com>
        <20230720105042.64ea23f9@canb.auug.org.au>
        <20230719182439.7af84ccd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//.il2tFodV=YwpKNTDAuylZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//.il2tFodV=YwpKNTDAuylZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Wed, 19 Jul 2023 18:24:39 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
>
> Something weird. We did merge it, there was a sort-of-v2-called-v1:
>=20
> https://lore.kernel.org/all/20230627174314.67688-1-kuniyu@amazon.com/
>=20
> Merged as https://git.kernel.org/netdev/net-next/c/a9c49cc2f5b5

That is not the net-next tree in linux-next.  I have always used
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git#main.

And the above commit is not in linux-next (yet?)

> Dunno how it's supposed to fix this particular issue, tho, on a closer
> look, as it still calls:
>=20
>   scm_recv_unix() -> scm_pidfd_recv() -> pidfd_prepare()

Yeah, the bluetooth tree will need to change that after the above patch
is available to it.

--=20
Cheers,
Stephen Rothwell

--Sig_//.il2tFodV=YwpKNTDAuylZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS4ozMACgkQAVBC80lX
0Gxr6gf/YGsrxsvJ6180o1dhf9YctwCHIau5DGhVsAN7Cl1HWxn3/y26On90yqcd
5KDM0gf476Ybkuyhf8rF8LnPo3bCmIXgwADohN45ctJ8WT4tXCDI6vBQR/CRtzVa
wuzxHVQJ6JiqbebmYlzzAsE7yChD/XMHoMWsKL9jTcI5OtxQ3HswII66luSL9DXg
zOu242EE6DoBadztGDJxNjG+OB8ZUE+o5owHCPf1UA6lWydQB4kM6Ycdo/b00FGS
X+/YG/+JxEjofJcDCPE1o5gR3+uNfJ65qze8dSQfGtnjndk8LrFc71hs9tw2mCxs
tu9FzpAn+L6bIvVs60SxOloidKInYQ==
=vMS4
-----END PGP SIGNATURE-----

--Sig_//.il2tFodV=YwpKNTDAuylZ--
