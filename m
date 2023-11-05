Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729827E17D5
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 00:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjKEXOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 18:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEXOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 18:14:41 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9EBE0;
        Sun,  5 Nov 2023 15:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699226076;
        bh=KNZfu7OjolZplMBWHK4KYrGyxje/IEIPmuS4nt+hcXA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PkTUoPjS8C+kZTg2HC6IGXC2Rrya/zlyd5oe7zF2CvviO8Q5nwGYY4bOMps0a5k42
         qcZeo2mIy5xW1uvWTjQawq5fxh3I4dii2Kqcz4rIitGtW2lFQpPWRZEgAclG4y4tBo
         x2dJvSmADQjV5a0tVpYrcwD/1FqsoTMDYfk2WX99ADmOzOh6exVv1l+PsEwFeHzqSA
         OK0TMydgjmA47PQB4cvgCbjHNu5TES2WjG+Wt2EN7b9xwQJgV5XurXDr25V6e4tKhF
         qklMJbpsoN6NZmrh7ReI/Ecce/bmiwwFiUqkPUcAQs6Hrj1QRQls1rAvdXwf9eB9W6
         HNBxeQ5wDfcag==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SNr0X2q4sz4xPL;
        Mon,  6 Nov 2023 10:14:36 +1100 (AEDT)
Date:   Mon, 6 Nov 2023 10:14:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Subject: Re: linux-next: manual merge of the apparmor tree with the security
 tree
Message-ID: <20231106101434.70c62773@canb.auug.org.au>
In-Reply-To: <CAHC9VhR=x7qB3gmQg+GPYLnXtGU88S3KCiZGjRYtDKSJHp4P1g@mail.gmail.com>
References: <20231027130320.69469330@canb.auug.org.au>
        <CAHC9VhQ+Nt7CrLxSZcOVNEtAypruOmM0ST0P0JJMrOq4XYmAkw@mail.gmail.com>
        <4b4eb40c-b65a-46e2-9e23-5412a9cdcad0@canonical.com>
        <CAHC9VhQbxJ4-z4Hp7CSmtcTNOWGFeQF2eEyct9=nHCMN_89YXw@mail.gmail.com>
        <20231031074649.3bdbec45@canb.auug.org.au>
        <CAHC9VhR=x7qB3gmQg+GPYLnXtGU88S3KCiZGjRYtDKSJHp4P1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_zu0BJwfrCMGY12QZZF2a/8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_zu0BJwfrCMGY12QZZF2a/8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Paul,

[Sorry for the slow reply]

On Mon, 30 Oct 2023 17:04:01 -0400 Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Oct 30, 2023 at 4:46=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.o=
rg.au> wrote:
> >
> > On Mon, 30 Oct 2023 12:52:50 -0400 Paul Moore <paul@paul-moore.com> wro=
te: =20
> > >
> > > On Sun, Oct 29, 2023 at 5:09=E2=80=AFPM John Johansen <john.johansen@=
canonical.com> wrote: =20
> > > >
> > > > is part of the Three basic syscalls series, the plan is still to ha=
ve that
> > > > series bake in next for a full cycle? =20
> > >
> > > Yes, that's still the plan.  Once v6.7-rc1 is out I'll rebase the LSM
> > > syscall patches and I expect the vast majority of these conflicts to
> > > disappear, although I'm sure we'll pick up some new ones with the rest
> > > of the v6.7-rcX cycle :) =20
> >
> > These patches should not be in linux-next until after v6.7-rc1. =20
>=20
> What if we wanted additional testing beyond the typical?  Do you not
> support that?

No, I try hard not to.  It just complicates things when I and others
have to cope with conflicts and build problems caused by
patches/features destined for next+1 while trying to stabilise the
current/next release.

Sometimes it happens that a feature slips after being added to -next,
but please don't do it deliberately.
--=20
Cheers,
Stephen Rothwell

--Sig_/_zu0BJwfrCMGY12QZZF2a/8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVIIdoACgkQAVBC80lX
0Gx1IAf9H6V82cvAQtkUP2Py/ZW41u9lLBGGfLJ/mePRq+auXqJ7G2Tl1wOqx+4t
dzNmZq5f/VDFeXghE4jA6GHxst1C1/JPeIjew6g32BRSMQ0sHMIax8JFZg6kGrnf
kE/jTG6YyW2lfK+DhfL2x7FU1d2vDK19oIwr8rR+oQjADKGAta91pGZWfCMpOpsK
T9YMg4wqrb1iQ85g4H1aA1xnddA4+4NDqZpyyrxjeiRbdU3VtAb5IAnQAp/iFjVo
fbtXRxW6hsk4dXxIPJG1rwttUNWBj9J23WtFyn/WdFfsFh4fsKpvpSF23AZkJ4a7
pCQpF/51mND8VV4sBjJ67cOa3aq+sQ==
=5v1Q
-----END PGP SIGNATURE-----

--Sig_/_zu0BJwfrCMGY12QZZF2a/8--
