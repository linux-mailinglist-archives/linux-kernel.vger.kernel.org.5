Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607A575BB2C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 01:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjGTXa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 19:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGTXa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 19:30:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC29726A9;
        Thu, 20 Jul 2023 16:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689895852;
        bh=+v2+do6U5ksOR7odVMBUhH1HfNawzbW3pAra8B5rRsc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k5xAzMvwRFvZTDjeNDdkuREceFzP+eUOmNmFnVH9wenakxbCh3bbBKABx3N6zScUA
         kNcdtq45h/sFXtMiwTJfr7R3SYs6efIhVxI+M/s3oTY7iUVD595nvFs/ryJukyGDG+
         5aKYtX3PmepBdyZVujBXzof3jGVjPAPVouOcvALMHWLA6XXoLUfzpY97kUxWMske5u
         WHX6fllsGVw32sf6F2mNidi3uI/BqTDkBDvEPFceOdfYWEXdHFUAs+JTKzgr49OtOw
         Tj7hIgfq4wAmet/1oqayK4sLkFZ3wDEJbl00CfN92ElXx1ESa+r4gAtUYR9iu4nyKX
         RAiSjFnZCdL3Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R6TT62p2Zz4wqW;
        Fri, 21 Jul 2023 09:30:50 +1000 (AEST)
Date:   Fri, 21 Jul 2023 09:30:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        "Alexander Mikhalitsyn" <alexander@mihalicyn.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20230721093042.2167fd0e@canb.auug.org.au>
In-Reply-To: <20230720162756.08f2c66b@kernel.org>
References: <PH0PR11MB51269B6805230AB8ED209B14D332A@PH0PR11MB5126.namprd11.prod.outlook.com>
        <20230720105042.64ea23f9@canb.auug.org.au>
        <20230719182439.7af84ccd@kernel.org>
        <20230720130003.6137c50f@canb.auug.org.au>
        <PH0PR11MB5126763E5913574B8ED6BDE4D33EA@PH0PR11MB5126.namprd11.prod.outlook.com>
        <20230719202435.636dcc3a@kernel.org>
        <20230720081430.1874b868@kernel.org>
        <20230721081258.35591df7@canb.auug.org.au>
        <20230720162756.08f2c66b@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8zlJnZnvk4cyoEfeCKgEi.7";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8zlJnZnvk4cyoEfeCKgEi.7
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Thu, 20 Jul 2023 16:27:56 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 21 Jul 2023 08:12:58 +1000 Stephen Rothwell wrote:
> > > I kicked it off and forgot about it.
> > > allmodconfig on 352ce39a8bbaec04 (next-20230719) builds just fine :S =
  =20
> >=20
> > Of course it does, as commit
> >=20
> > 817efd3cad74 ("Bluetooth: hci_sock: Forward credentials to monitor")
> >=20
> > is reverted in linux-next.  The question is "Does the bluetooth tree
> > build?" or "Does the net-next tree build *if* you merge the bluetooth
> > tree into it?" =20
>=20
> Sorry for being slow, yes. I just did a test build with net-next and
> bluetooth-next combined and allmodconfig is okay, so you should be good
> to drop the revert. Fingers crossed.

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/8zlJnZnvk4cyoEfeCKgEi.7
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS5w6IACgkQAVBC80lX
0Gwm2Qf8CpXopcW+vJ3Ur80q5fytmGPoBHaL0ovqYN58G007cSN6CK1++4gGle5S
ODHe8+J93at9lrgXLTZSEtYEq4Cb6j0+ZlVfATnGwH+pKJndq6G24ApDJZ6WsuK2
m8cUVc/WJDZ7SbMgYVQG7wMORgUcFfrWDnXpiS3ws2MCgQs69CGUEhE4TtecnaVX
IrB7532P0g9+OQlN7pvM6dc96ysFHZqXw1k1fJGZMtbCXuCkjWK+WbPuFeh+KfPI
oVg74E9zJufTMoArF6UX47IZlMNacBfSsY7Q9FQ02LftN5deWqId8/0KGzFh5elI
G2NXPGCXjTMM5DcIcgd3tAwTgpucYg==
=Bha+
-----END PGP SIGNATURE-----

--Sig_/8zlJnZnvk4cyoEfeCKgEi.7--
