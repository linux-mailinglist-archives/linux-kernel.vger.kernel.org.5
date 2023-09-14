Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1267A0716
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbjINOSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239493AbjINOSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:18:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549A0B9;
        Thu, 14 Sep 2023 07:18:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE83BC433C7;
        Thu, 14 Sep 2023 14:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694701100;
        bh=O0Vdo75uGuQ70r2R2tPq6kz4JrAy5xHqML/ZtLJgtv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rmAOOQtmHbVUufqL3SindTElEfz7B4/drHCv7tui7JsAlw3gKPsTtr3iHKt3MeeK9
         HgbLY9d/0tE3N0sIXPQNuf5kjviENlSUtiK7v24bq3uvjZsXjwLQHZngjOINy65MSa
         BPz5FeozhwN+XhFRal2oHtg++2DC+veSc10+M848z0xgnq5eoMHLmaDivQ58/v+qft
         TMYboF0fIU9XV0M3tormeFx4M/s4qrXbmZEomLZn6cKnU4LdGIlAcTWWGOudsWHSA1
         lzYnZ4vG9t6ESnD0AF/CWFhNAjWQgRfYu+36UCly8mTZ3CpQshY1G+qF4ivVRsEU40
         ZDk2Cf+eRZkew==
Date:   Thu, 14 Sep 2023 15:18:14 +0100
From:   Conor Dooley <conor@kernel.org>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, Andy Chiu <andy.chiu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/6] RISC-V BLAKE2s Vector implementation
Message-ID: <20230914-squad-ripping-e8c98e2d336b@spud>
References: <20230912115728.172982-1-bjorn@kernel.org>
 <20230914-roaming-plunging-948c78d9831c@wendy>
 <87pm2kap1p.fsf@all.your.base.are.belong.to.us>
 <20230914-float-uneven-7cd1a18b3978@wendy>
 <87zg1o3kpd.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BoFtOlqfEEGc0sg6"
Content-Disposition: inline
In-Reply-To: <87zg1o3kpd.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BoFtOlqfEEGc0sg6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 14, 2023 at 04:15:10PM +0200, Bj=F6rn T=F6pel wrote:
> Conor Dooley <conor.dooley@microchip.com> writes:
>=20
> > On Thu, Sep 14, 2023 at 02:59:30PM +0200, Bj=F6rn T=F6pel wrote:
> >> Conor Dooley <conor.dooley@microchip.com> writes:
> >>=20
> >> > On Tue, Sep 12, 2023 at 01:57:22PM +0200, Bj=F6rn T=F6pel wrote:
> >> >> From: Bj=F6rn T=F6pel <bjorn@rivosinc.com>
> >> >>=20
> >> >> Hi,
> >> >>=20
> >> >> This is Andy's kernel mode vector V2 series [1], with my BLAKE2s
> >> >> AVX-512-to-RISC-V translation patch appended.
> >> >>=20
> >> >> I've tagged it as RFC, since Andy's series is still not in-tree yet.
> >> >>=20
> >> >> It's a first step towards a Vector aided Wireguard! ;-)
> >> >
> >> > This has the same problems as Andy's stuff & doesn't build properly =
for the
> >> > automation. What is the plan between yourself and Andy for submittin=
g a
> >> > version of the in-kernel vector support that passes build testing?
> >>=20
> >> I'll synch up with Andy! I'm not even sure the blake2s patch should pa=
rt
> >> of the "in-kernel vector" series at all.
> >
> > The in-kernel vector stuff should come with a user, otherwise it's dead
> > code :)
>=20
> Sure, just so we're on the same page; Patch 3 (Vector XOR) is a user
> from my perspective, no?

D'oh

--BoFtOlqfEEGc0sg6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQMWJgAKCRB4tDGHoIJi
0mSZAP9QxZxEOa2w5PdNwZc4V1YJq0no6zTaa5YmzIbEImXKBwEAzXGzM8jb/VBR
mo1rZ4gmHUV8MTurBVpK8FYf9j+bLAo=
=vx8E
-----END PGP SIGNATURE-----

--BoFtOlqfEEGc0sg6--
