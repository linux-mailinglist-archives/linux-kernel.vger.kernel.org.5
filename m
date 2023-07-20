Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF4A75BA4D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 00:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGTWNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 18:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGTWNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 18:13:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D9B1737;
        Thu, 20 Jul 2023 15:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1689891181;
        bh=mSCR/bGlEqj9R4QQZcZW4kJs+0AlIgm1pITLFZreeXc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p7xOPeq9UQuafSOFsJYpLLiEQMQQnQOx1l2p5mALnpSguLvR9gXtpAuJkvJmp/XNF
         C4fCdTMvViCcb06HpjHk1voXPAsmWbEpc5spcikFZSSthKB6hXOeki69cpzc7FrpZE
         gXhrtcUU1/H/Y7Jz3uZl4P6Ti9ObXbtafIZE/QxTuHV3VimTcf7G1qizqDb8UHg+xc
         r8PR6VXPFcLfrvdJVgfQDIePF9nWPxK5XWOiq8DOCVAvsRAcsPfdpnAJbKM8Mjax+h
         NPeEvnMBvDBdMOK99vx8yzzMM66j+2pbUwa/onD8cfh0wy3xSRbDKi0vhapOjwTS2H
         UB6DMc8jCozwA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4R6RlH5GX3z4wqZ;
        Fri, 21 Jul 2023 08:12:59 +1000 (AEST)
Date:   Fri, 21 Jul 2023 08:12:58 +1000
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
Message-ID: <20230721081258.35591df7@canb.auug.org.au>
In-Reply-To: <20230720081430.1874b868@kernel.org>
References: <PH0PR11MB51269B6805230AB8ED209B14D332A@PH0PR11MB5126.namprd11.prod.outlook.com>
        <20230720105042.64ea23f9@canb.auug.org.au>
        <20230719182439.7af84ccd@kernel.org>
        <20230720130003.6137c50f@canb.auug.org.au>
        <PH0PR11MB5126763E5913574B8ED6BDE4D33EA@PH0PR11MB5126.namprd11.prod.outlook.com>
        <20230719202435.636dcc3a@kernel.org>
        <20230720081430.1874b868@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/C37pAgNNiSu7JOsN7LZuAf/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/C37pAgNNiSu7JOsN7LZuAf/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Thu, 20 Jul 2023 08:14:30 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 19 Jul 2023 20:24:35 -0700 Jakub Kicinski wrote:
> > On Thu, 20 Jul 2023 03:17:37 +0000 Von Dentz, Luiz wrote: =20
> > > Sorry for not replying inline, outlook on android, we use scm_recv
> > > not scm_recv_unix, so Id assume that change would return the initial
> > > behavior, if it did not then it is not fixing anything.   =20
> >=20
> > Ack, that's what it seems like to me as well.
> >=20
> > I fired up an allmodconfig build of linux-next. I should be able=20
> > to get to the bottom of this in ~20min :) =20
>=20
> I kicked it off and forgot about it.
> allmodconfig on 352ce39a8bbaec04 (next-20230719) builds just fine :S

Of course it does, as commit

817efd3cad74 ("Bluetooth: hci_sock: Forward credentials to monitor")

is reverted in linux-next.  The question is "Does the bluetooth tree
build?" or "Does the net-next tree build *if* you merge the bluetooth
tree into it?"

--=20
Cheers,
Stephen Rothwell

--Sig_/C37pAgNNiSu7JOsN7LZuAf/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmS5sWoACgkQAVBC80lX
0GyDigf7BDnf5vdMSq2sMCKe0tQlpHqa7ltbf+M4WcT5YLOlTPkuwk/t9otngceq
P+Cra9xZBZF9lT5B+2HRr0WvYBrzdx7cQIbpNr6DGmNz5/KzCSpHAgZT812Jyhub
m5N2EDVg4vIJB48wF+tu9uciPGe3xpZH0KMRkfzU0v7HgKrz+bYjVFXWgq/mIMDd
Nk7Zv+LJdm0yqrDSBTByFgON0d/M9JHOMh1DSuSi6Hjykb2foax8VM5jvTSm+gZw
RmttcQsfH930nvFU2McKGP0LmXaFbJSt4EvgOP2jEP8E46400/jKzLoGBcbDixGo
Xq23X3LHgKDk25c4ZPpT8pX2gDfZcA==
=4Woi
-----END PGP SIGNATURE-----

--Sig_/C37pAgNNiSu7JOsN7LZuAf/--
