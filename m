Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE880809A12
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573027AbjLHDL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHDL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:11:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BD2D54;
        Thu,  7 Dec 2023 19:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1702005119;
        bh=72VEtvIJ6CpxIaXsemMJUrDlyhqyH3d9y/tYOeQO1GE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tMYLAiTZEjzDYh89VKA/femGUjU9oWiIaCXH+fWg2cPcg6Ut7X8ybpi/DXgwPQjpn
         4AvXp9Pd4LMIxp51Bnpkogi4on6U7UMGhRDddy4eojamlpADi46uNgAp3ERqUtTtjl
         CrwpN+M9DZ1KaGq4N33R2pqDCvVWvoOfqxAGzyLw8awkjWH6HkDLe7tWIgw8WekwGG
         rlpsJ/DZ11fydHdQeEYnGXPU0LOHxTM2m3N10mbYZnw+v9if4HefVi5HV3OWyoQGBZ
         RNQesJTCJd8ZAKh460tIL6SXK7kIASmnmSmbamyUToJEID0L52kSE5X5ivxGrN0HnK
         nn3BtT1pb/UuA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Smblf5m4bz4x1v;
        Fri,  8 Dec 2023 14:11:58 +1100 (AEDT)
Date:   Fri, 8 Dec 2023 14:11:56 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the devicetree tree
Message-ID: <20231208141156.20341c10@canb.auug.org.au>
In-Reply-To: <CAL_JsqKyqe827YRyqZnqcVghhuAuvWoiS4U7uR8wwYoGj3=9KA@mail.gmail.com>
References: <20231207125737.5e7553e3@canb.auug.org.au>
        <CAL_JsqKXo+Cr=9s=dt1kCQeMadJ_cnuSpm06zmvK8yd-vd2X3g@mail.gmail.com>
        <20231208075847.6bbd23b8@canb.auug.org.au>
        <CAL_JsqKyqe827YRyqZnqcVghhuAuvWoiS4U7uR8wwYoGj3=9KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1u9Ex+aSgYAkr2kJerTwxtH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1u9Ex+aSgYAkr2kJerTwxtH
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Rob,

On Thu, 7 Dec 2023 16:05:27 -0600 Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Dec 7, 2023 at 2:58=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
> >
> > On Thu, 7 Dec 2023 09:11:22 -0600 Rob Herring <robh@kernel.org> wrote: =
=20
> > >
> > > I'm sending out fixes for all these. I want to get the final patch
> > > ("of: Stop circularly including of_device.h and of_platform.h") for
> > > all this in next to get some better build coverage and catch any new
> > > drivers added. But if it is dropped for every new driver that breaks,
> > > I'll never get it in. Can you fix these up or just leave them broken?
> > > I can keep the fixes in my tree until they get applied by the
> > > corresponding subsystem. =20
> >
> > These dependencies between trees are impossible to handle.  Please if
> > you really need the final patch in, then you must put all the necessary
> > fixes in the same branch.  There is no telling what order Linus (or I)
> > will merge the interdependent branches.
> >
> > The alternative is to spray the needed fixes out to the other
> > subsystems and then put the final patch in after the merge window
> > closes or the next release. =20
>=20
> Yes, that's what I've been doing since July and plan to do for the
> final patch. The final patch can't wait a cycle because then we'll
> just have more moles to wack. There's a couple of dependencies that
> still haven't been picked up (seems Sparc is unmaintained), so I'm
> going to send those along. I'll carry any further fixes until they I
> see they are applied.

OK, so I have moved your tree to be merged last and I fixed up the new
driver, so hopefully we are good, now.
--=20
Cheers,
Stephen Rothwell

--Sig_/1u9Ex+aSgYAkr2kJerTwxtH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVyiXwACgkQAVBC80lX
0GxmdAf7BqaIpe3WGH5SKEELLOV19V03pACUoh5AkIb2ZbKHd0e2JIhwMx35pibl
DfcWXgRRCAQqDt0HfWTI0jUBpzzp1eMRW/O3t0A29obWDM+JRG5JZWiyJOo6Zelq
ElhogKs/w9Y9rU3ojIoPlTMOLxggBCnR1M+B7n5WkXGIJYBezJYNYVL0BhMO9loG
sr0DeiCQioayE8ibr+ov19c6ejjTBTslcdiE2w505fEei3LGpTz8Hc6KeXhz0bKH
ck1sU10lV8H0mTEC2a+5OHadAvou9ITYPT5QdnHlWSXna4mx6I5qru1u0lLYi4KE
DD1oESM4ptz1wOX7nR7fGb/So5kCcA==
=9eEw
-----END PGP SIGNATURE-----

--Sig_/1u9Ex+aSgYAkr2kJerTwxtH--
