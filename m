Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2FA575A3A7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjGTAuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjGTAux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:50:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE761BF7;
        Wed, 19 Jul 2023 17:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689814245;
        bh=+FJGw/a2wwYQth4TQeBq+2ary9gPssFvgCsr9GTPDSY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iMg5IsOnCZ03VEOMi1JjkdaRKSIjw8AqHkSpW2KYgqanZynC8Ulh6wetTOBguNbEf
         MYK9Np46gHHJg2d7n/Attik3Ym6hkVi5Qo594wI8HeW9ve3KLDOvgPVLiYuHFydT3n
         uNY4vBZNlMVT1bkkKHuYx5oek4FRASsFw9GvxBGxzLilxH4nGMcE1pCJg0Kc2qf+ra
         k9+tFaXk1FOb3kNzyFJKb6H/aavO9/YR7f9Tj+DAVe79FW35uLz1tgikXzaFCTDm1f
         nXDHXLLMu2Ak7pL/nUPP0epL+9HsfDagUj7Z15sZeI2N4tzVENhZqa8QOhDHYxMlbN
         OAvV2tOCh6xnA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R5vHm1t01z4wxR;
        Thu, 20 Jul 2023 10:50:43 +1000 (AEST)
Date:   Thu, 20 Jul 2023 10:50:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Linux Next Mailing List" <linux-next@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Networking <netdev@vger.kernel.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>
Subject: Re: linux-next: build failure after merge of the bluetooth tree
Message-ID: <20230720105042.64ea23f9@canb.auug.org.au>
In-Reply-To: <PH0PR11MB51269B6805230AB8ED209B14D332A@PH0PR11MB5126.namprd11.prod.outlook.com>
References: <PH0PR11MB51269B6805230AB8ED209B14D332A@PH0PR11MB5126.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L2uyadlyg/Sa+tHsujj4rwR";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L2uyadlyg/Sa+tHsujj4rwR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sat, 8 Jul 2023 00:17:15 +0000 "Von Dentz, Luiz" <luiz.von.dentz@intel.c=
om> wrote:
>
> There was a patch sent to net-next that was supposed to fix this:
>=20
> [PATCH v1 net-next 2/2] net: scm: introduce and use scm_recv_unix helper
>=20
> I am waiting for it to be merged.
>=20
>=20
> ________________________________
> From: Stephen Rothwell
> Sent: Thursday, July 6, 2023 4:41 PM
> To: Marcel Holtmann; Johan Hedberg
> Cc: Von Dentz, Luiz; Linux Kernel Mailing List; Linux Next Mailing List
> Subject: Re: linux-next: build failure after merge of the bluetooth tree
>=20
> Hi all,
>=20
> On Fri, 16 Jun 2023 08:32:37 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > On Tue, 13 Jun 2023 13:02:58 +1000 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> > > =20
> >  After merging the bluetooth tree, today's linux-next build (arm =20
> > > multi_v7_defconfig) failed like this:
> > >
> > > ERROR: modpost: "pidfd_prepare" [net/bluetooth/bluetooth.ko] undefine=
d!
> > >
> > > Caused by commit
> > >
> > >   817efd3cad74 ("Bluetooth: hci_sock: Forward credentials to monitor")
> > >
> > > I have reverted that commit for today. =20
> >
> > I am still reverting that commit. =20
>=20
> Ditto

This is getting a bit ridiculous ... a build failure reported over a
month ago with a fix
(https://lore.kernel.org/netdev/20230626215951.563715-1-aleksandr.mikhalits=
yn@canonical.com)
posted 3 weeks ago, has not yet been fixed :-(

What is stopping that fix (with the appropriate followup) being added
to the bluetooth tree?  Or just the fix being added to the net-next tree?

Yes, I know that the time period includes the merge window, but it has
been more that a week since then.
--=20
Cheers,
Stephen Rothwell

--Sig_/L2uyadlyg/Sa+tHsujj4rwR
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS4hOIACgkQAVBC80lX
0Gzz8Qf/dNoWUCwBnpzL1kVRbKtoaMqjen04toUg7vU1wKXCRw1+o2WObDVGRMaz
I+MYJCBNEepUV93nnua7jeTKYqv3Oh30yhLT92KkRSpppCVojQ1kl0BreBeUHXIn
Ib0ZScIDZ1FWesTbm9+R39013kbECOTVffGuvfOfNgeJ3TGFwyz8WdERB5WWTGN+
zVrXtpBiAtP+1jw9pygplyaJFiJ852W6zLP/pMC8/FwwHLcDSTozigkLfU80lNpE
biRRcjpJMafx33CVVegpA77zly5k9yrYYY2AklQe/TDchIMUEBuiuUflUWaBC6XE
eYPFl1Q0mIinw8DHkgsMVlODO97chw==
=BBmM
-----END PGP SIGNATURE-----

--Sig_/L2uyadlyg/Sa+tHsujj4rwR--
