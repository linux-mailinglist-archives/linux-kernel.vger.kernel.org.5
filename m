Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A0A780455
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 05:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354040AbjHRDVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 23:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357514AbjHRDVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 23:21:07 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53C730F5;
        Thu, 17 Aug 2023 20:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692328864;
        bh=Tpyx1B445b6D45UQRfR4DprDQ8S8METPX2CP3UsjIVo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=oczjNicFv859VV/m5CIKwT2XPeut792oqAVV3FZmUbvNIl3gbZDAtQF031rqsF9dR
         8/NEfGd+qepahMnlYV6B2/FSVcfJBvrmRV3pbuHsRUMLSIJqaMHSyMovvCw0kFyzkQ
         WP8qBjHmRHDzve67ZGrOP4/uxodn1MLlmpEgvV9mSHfe9qoG6/MHc3NoHeW3avqSh9
         564oiowj4rqbZcmT8lWokXD8jJOm7nLT+xABwO77vXaRsLNPEPfidm9wGNDS+PLXYo
         SkxKTMVeE4yXuYKFvBe1nHqrBmOMjXHPGpUGezZpJx0PTJrjBWQrgSpqhQVV9zDYu/
         gRBtKUs6ZToGA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RRnFq20GCz4wxy;
        Fri, 18 Aug 2023 13:21:03 +1000 (AEST)
Date:   Fri, 18 Aug 2023 13:21:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Joel Stanley <joel@jms.id.au>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the aspeed tree
Message-ID: <20230818132102.11ef3fea@canb.auug.org.au>
In-Reply-To: <CACPK8Xez-xQDEAG_JuN5VqMVBreLWO_Qhu+3Vq3EA1PiebR5hw@mail.gmail.com>
References: <20230815114143.23e4b2ff@canb.auug.org.au>
        <CACPK8Xez-xQDEAG_JuN5VqMVBreLWO_Qhu+3Vq3EA1PiebR5hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/oGPZtMIRHW_+kWMk5wf8kUc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/oGPZtMIRHW_+kWMk5wf8kUc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Joel,

On Fri, 18 Aug 2023 02:19:11 +0000 Joel Stanley <joel@jms.id.au> wrote:
>
> On Tue, 15 Aug 2023 at 01:41, Stephen Rothwell <sfr@canb.auug.org.au> wro=
te:
> >
> > The following commits are also in the arm-soc-fixes tree as different
> > commits (but the same patches):
> >
> >   0955e3867b54 ("soc: aspeed: socinfo: Add kfree for kstrdup")
> >   c5835b6e7aff ("soc: aspeed: uart-routing: Use __sysfs_match_string")
> >
> > These are commits
> >
> >   6e6d847a8ce1 ("soc: aspeed: socinfo: Add kfree for kstrdup")
> >   e4ad279ae345 ("soc: aspeed: uart-routing: Use __sysfs_match_string")
> >
> > in the arm-soc-fixes tree. =20
>=20
> This is expected as I sent the changes as patches for Arnd to merge
> via the soc tree.
>=20
> What would you like to see when this happens? Should I rebase them out
> of the aspeed tree?

They are currently not causing any conflicts (that I would need to
manually fix up), so you can just leave them it you like.

More generally, they could have gone into a separate branch that you
merge and you ask Arnd to merge so that we only have one copy.  In
particular, quite a few people have a separate "-fixes" branch for
current release bug fixes.
--=20
Cheers,
Stephen Rothwell

--Sig_/oGPZtMIRHW_+kWMk5wf8kUc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTe454ACgkQAVBC80lX
0Gw8fgf/Un4qrcGHgCaXVQKeaGqEkg5Kr4W/CoecLVGqNAEJVcx9AsiBO66oF1Oc
44qiL0NbuS1nd9RflqhocLKYyQwmaorcN7LhlHd77BCKlJ51I4js2b+UNmOagb4f
B36swddNvNpRvrset+9phyoWGKfwBPXeBG9E9VwMBr1SZjFATwsh0gzeW7NUrO6x
tlfi0K9JohIeOQRrO0ChcPNJ2okg+dPLhX3mCaIOHcJ6KdbUQ70Ygf8RUWCr7qyr
paYhCJElOKQPzCdbqbQSA1fcxCumtN30WP7zwHQ8aFzkG7jDOfGpA/O5kVCBTH/o
tPGAbujBBb3cuYAx/s815Z+rHXxfdw==
=JDa1
-----END PGP SIGNATURE-----

--Sig_/oGPZtMIRHW_+kWMk5wf8kUc--
