Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAA17F1504
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232637AbjKTN7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232128AbjKTN7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:59:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5C192;
        Mon, 20 Nov 2023 05:59:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3451C433C8;
        Mon, 20 Nov 2023 13:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700488774;
        bh=kp9GIj/goDcYsosIrC/QG7Ed0kq5bMEXQ3yCcvXKf7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1VRC4aDFojjm/UQogsTGuCn+zMKMIt7xImvA/CpumGE2XX+jYts3al4PcCRKW/+L
         gOn0NhLIcrSs3rfG74IoGuU/U2uBM9mH+zzwoW5wSqkuKGEB8D1k17puMeYZIefsDJ
         E4oRU1ZZ/n77yaHaa63uUJjQB2jILK+evLvOzZU5hj+yzTt3uspanCgzKDRsRCausY
         buPLO4iqshwPnClWLQnJ0Kr8JKUb0ssGDdiKmB0Zf0IZEWZ6KMeUuGlAsY1HoELju1
         VIodMcFB4YgUqP4guOo3F2OQs0Prq2un9Iq1ad/SjCyqz6BwQuypsJQNPqRk9tcSAt
         8i4Rp0FMvTKzA==
Date:   Mon, 20 Nov 2023 13:59:29 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Maciej Strozek <mstrozek@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] ASoC: cs43130: Allow driver to work without IRQ
 thread
Message-ID: <0e0eb66f-b4e5-4c6d-b788-6ea66dddd705@sirena.org.uk>
References: <20231120104153.76248-1-mstrozek@opensource.cirrus.com>
 <7d8bf03f-e9a5-405b-8753-a360f46a04df@sirena.org.uk>
 <e9698a93d2eeae8c00cfcebdfa69f686849ded0b.camel@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AITBtLlNg/X8BBBy"
Content-Disposition: inline
In-Reply-To: <e9698a93d2eeae8c00cfcebdfa69f686849ded0b.camel@opensource.cirrus.com>
X-Cookie: <Manoj> I *like* the chicken
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AITBtLlNg/X8BBBy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 01:51:33PM +0000, Maciej Strozek wrote:
> W=C2=A0dniu pon, 20.11.2023 o=C2=A0godzinie 12=E2=88=B631=E2=80=89+0000, =
u=C5=BCytkownik Mark Brown
> > On Mon, Nov 20, 2023 at 10:41:53AM +0000, Maciej Strozek wrote:

> > > This is to support systems without physical IRQ connection. The
> > > device
> > > only requires the IRQ for a couple of internal delays, this polling
> > > mechanism is a fallback when no IRQ is specified.

> > Your changelog here doesn't describe the change - is then intention
> > here
> > to remove the IRQ thread (and presumably open code?) or to make
> > interrupts entirely optional?

> Apologies, I thought the word "fallback" would describe the intention
> of making an optional way for the driver to work in absence of IRQ
> rather than removing the IRQ thread. Will send an amended (and
> unnumbered) v3.

Your subject line says that the patch is changing things to work
"without an IRQ thread" - the thread specifically.  This conflicts with
the additional text you've added in the body of the changelog which
talks about removing the need
for an interrupt entirely.

--AITBtLlNg/X8BBBy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmVbZkAACgkQJNaLcl1U
h9AAdwf/arV0PhcfCyqkCFakj1BG46dMC7HVL4Dzu+KIWk731zcL7HMZhPF2p/Dd
bP4EiQbsY31kAqZp2Xw/RIy0O1a6fkmGp5wC0Sjgg/gNPDIzrAhlYxoBqevGg0Ps
GR27N690fXA/f12/4htbB2ToBFdqvpIRlYvkKdpovz8x/9iaeGmwZxTkVzUG0VcS
hVucwQCowQU9ii2P+4iQsY1wKElbCslbw5uaA/MSBs/DD3En2pImFNqdnaVoIObk
fx61W/rfDoWMASGXx0cVb4xnHFGmth79GWm16QBx1NWn8tR+dmccgO2m7KmVzRZJ
nJkb4OrE+QoFeEo6br01/lWG7iWpPg==
=zt0C
-----END PGP SIGNATURE-----

--AITBtLlNg/X8BBBy--
