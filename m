Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB1575BA7F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjGTWU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjGTWUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:20:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1942D7D;
        Thu, 20 Jul 2023 15:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689891580;
        bh=qdbWIDnRmwX5ckyQEWL+ZpWxc5wfAxXFPHqB4zGGG2E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rHg9YJwDHoxFI7lXN60mcAYn33qzI4U/9USAv0OQh2KDCI3cmgGMDj/hCbJ8xnjat
         Vha8JGwwKqgphyEbMr4OdUAScBsh54zoJhyh1dwduWtFodWosQJFf48mUzAYgDSyly
         leIyHzZDyoEjVMvwLR16GMhM/BbD9WEFgdjd/29bWgLGMtF1LLtqEG9V91sUDECu1k
         G/Lrh55gGib3e/fbvlaRLxHkZgt6qNrHNUf2P5OweBGiZKh+LXKv1BwuoezAVaMb6R
         PJ9ZRVL+KdfHQ9NCN8fRNlA2D+stJGZUNa/cIQjlY9Y8wa/2aUMptMfaTIQpFr/aw0
         1Yr3706w8uhqw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R6Rtz6xFwz4wyH;
        Fri, 21 Jul 2023 08:19:39 +1000 (AEST)
Date:   Fri, 21 Jul 2023 08:19:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20230721081938.19ca4289@canb.auug.org.au>
In-Reply-To: <CAJqdLron07dGuchjmPZcD6xe5af+qpgNMThz5G8=tR7n4=fU1A@mail.gmail.com>
References: <PH0PR11MB51269B6805230AB8ED209B14D332A@PH0PR11MB5126.namprd11.prod.outlook.com>
        <20230720105042.64ea23f9@canb.auug.org.au>
        <20230719182439.7af84ccd@kernel.org>
        <20230720130003.6137c50f@canb.auug.org.au>
        <PH0PR11MB5126763E5913574B8ED6BDE4D33EA@PH0PR11MB5126.namprd11.prod.outlook.com>
        <20230719202435.636dcc3a@kernel.org>
        <20230720081430.1874b868@kernel.org>
        <CAJqdLron07dGuchjmPZcD6xe5af+qpgNMThz5G8=tR7n4=fU1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/VfHlyY9va_AYo3+=saPglHQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/VfHlyY9va_AYo3+=saPglHQ
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On Thu, 20 Jul 2023 17:21:54 +0200 Alexander Mikhalitsyn <alexander@mihalic=
yn.com> wrote:
>
> On Thu, Jul 20, 2023 at 5:14=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Wed, 19 Jul 2023 20:24:35 -0700 Jakub Kicinski wrote: =20
> > > On Thu, 20 Jul 2023 03:17:37 +0000 Von Dentz, Luiz wrote: =20
> > > > Sorry for not replying inline, outlook on android, we use scm_recv
> > > > not scm_recv_unix, so Id assume that change would return the initial
> > > > behavior, if it did not then it is not fixing anything. =20
> > >
> > > Ack, that's what it seems like to me as well.
> > >
> > > I fired up an allmodconfig build of linux-next. I should be able
> > > to get to the bottom of this in ~20min :) =20
> >
> > I kicked it off and forgot about it.
> > allmodconfig on 352ce39a8bbaec04 (next-20230719) builds just fine :S =20
>=20
> Thanks for checking!
>=20
> As I can see linux-next tree contains both patches:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?=
h=3Dnext-20230719&qt=3Dgrep&q=3DForward+credentials+to+monitor
>=20
> So, the fix is working, right?

I will remove the revert today.

Thanks.
--=20
Cheers,
Stephen Rothwell

--Sig_/VfHlyY9va_AYo3+=saPglHQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS5svoACgkQAVBC80lX
0GzBTwf9FXVnrPPdIATHjsk6uX3felA1BTBpCVY2Ai/8hVsJtTJSRUXMbGkgYZoM
2P2OLCkJssu59cj1HDO/Ql61DpzwOjJ2u1nIs64joBRoJSDuqlHvIfJNlnXopy+Z
dEqZLwV3eQhUiC1lhiBr7FrgxA07ZjhlsDnk+Fj/jsZbVXpgXRAMitcI9txtAo/C
sduQMSOsCH4orSvwseR/07cUAZm+pemUWkHPyTUDfepm96J+QjEC9+OYqpW6gQ6q
bovm4guPJKWnj16YsiCtwLGYR2C+1eV3nVb+QR6IxUhgOsr7jsvL+7Zuw3/qdkHr
VCuUJy18sKsyBqJDYaguZprmJ2fiVQ==
=RWug
-----END PGP SIGNATURE-----

--Sig_/VfHlyY9va_AYo3+=saPglHQ--
