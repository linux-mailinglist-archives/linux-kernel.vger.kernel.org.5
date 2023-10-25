Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420A17D7245
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjJYR2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJYR2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:28:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7303112F;
        Wed, 25 Oct 2023 10:28:45 -0700 (PDT)
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D9E5F6607349;
        Wed, 25 Oct 2023 18:28:43 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1698254924;
        bh=Z4WtJ1xqFzmPBgctE13UKDki4+fr/pOhtB+GxP+i85A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kszb2A+7dBcNadiOxkvyHf9+5QoAZZs4MehyZirD41VQYHIj58SwXW6CV3MN4EFKX
         WPTCOx3mr7qrlQgJ0990AKfOWe2ivq5bg0uZNAoDlOJ0DA9jqhTrI4JaEbco39XNy8
         2dXFYAY+1OShZ0lrd0/onfSetuV8u5qmkGQKQ8DfKhz3sOaOOCpuzgU1CcwWIRvR50
         DIiaifRMBnTRfbGiTrJqmqQSKKiePvgy14hvCh1BlsxkXEP0NSAaBCf/0gswt0aP+O
         gYiBOmFDsinsQjN4qJhYMkyhqeQ/1M4kZy5wX0Ds5uHLzBOIgajrC1AxoPrRZMdso8
         Okbw3tG0+bRTg==
Received: by mercury (Postfix, from userid 1000)
        id 54DE3106057B; Wed, 25 Oct 2023 19:28:41 +0200 (CEST)
Date:   Wed, 25 Oct 2023 19:28:41 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, kernel@collabora.com
Subject: Re: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
Message-ID: <20231025172841.awb7s6o4ourqu4w5@mercury.elektranox.org>
References: <20231024161931.78567-1-sebastian.reichel@collabora.com>
 <20231024161931.78567-2-sebastian.reichel@collabora.com>
 <CAHk-=whYDbZ29fx_xeSxtYSjtF8WJkaLjzyB8RN5_Rk9Sh-YyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uxr4h7e7k7nksmyc"
Content-Disposition: inline
In-Reply-To: <CAHk-=whYDbZ29fx_xeSxtYSjtF8WJkaLjzyB8RN5_Rk9Sh-YyQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uxr4h7e7k7nksmyc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 24, 2023 at 09:32:27AM -1000, Linus Torvalds wrote:
> [ Since you're cc'ing the s390 people, I assume that means that this
> all ended up being a follow-up to the s390 issue discussion ]

Actually I've noticed the issue in the clock framework some time
ago and Andy Shevchenko pointed me towards the s390 thread, which
is more or less about the same fundamental problem. So I added
everyone in Cc, to make sure this is solved properly and not just
s390 specific.

> On Tue, 24 Oct 2023 at 06:19, Sebastian Reichel
> <sebastian.reichel@collabora.com> wrote:
> >
> > Add a new DIV_ROUND_UP helper, which cannot overflow when
> > big numbers are being used.
>=20
> This is really horrendously bad on some architectures (ie it might
> require *two* divisions):

I came up with this helper for the issue in the clock framework,
which currently use DIV_ROUND_UP_ULL() as a workaround. That solves
the issue on 32 bit systems (input arguments are of type 'unsigned
long'). But it also means doing u64 / u32 and I expect that do be
much more more expensive on 32 bit platforms than two divisons.

On 64 bit platforms the workaround is wrong, since the second
argument is reduced from 64 bit to 32 bit. It effectively breaks
platforms trying to request a frequency above 4.3 GHz from a clock
divider. Since that's not yet a common thing I guess this has not
yet been found and fixed by somebody else. I also just found it as
bycatch.

> > +#define DIV_ROUND_UP_NO_OVERFLOW(n, d) (((n) / (d)) + !!((n) % (d)))
>=20
> but David Laight at least had a suggestion for that: when allowing
> multiple uses, you can just do
>=20
>    #define DIV_ROUND_UP(n,d) ((n) ? ((n)-1)/(d)+1 : 0)
>=20
> so now you're back to just one division and no horrible extra expense.
>=20
> But we can't allow those multiple uses in general, sadly.
>=20
> I would really prefer to just make our regular DIV_ROUND_UP() DTRT.  But:
>=20
>  - people do use it with complex first arguments (ie function calls
> etc) that we don't want to evaluate twice
>=20
>  - we can't make it an inline function, because the types aren't fixed
>=20
>  - we can't even use a statement expression and __auto_type, because
> these things are used in type definitions etc and need to be constant
> expressions
>=20
> That last thing means that even the "__builtin_choose_expr()" doesn't
> work, because the statement expression still needs to be _parsed_ as
> such, and that's not something we can do in those contexts.
>=20
> Very annoying. Let me think about this.

Thanks.

-- Sebastian

--uxr4h7e7k7nksmyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmU5UDgACgkQ2O7X88g7
+poOpRAAkKKlCxY29dsN0u34xy/kd+1FGx+PGnCfzcjfAQ7bRCrxVR8aprksEv6H
aODRrJMygHPJCNuEm6wssL1y/UuDbyFxi6Xt7eTvBKAnlv83i51d6j/Nke8aZdqV
pFpBvQ6Joueu1s9Gz1f0bRGqPjtUiRzdgqspjkC/nKs1oO7qvZfNigWYMIaYpXSF
+ffjEq3F4VMKMLtoQfzJ6YQXzanWDT8B5SDmi/59Rr09qa0WmROAYTDDhXUadq3w
W2OgQPA1Iq3XcahaH19bZXLH9XUoBu+TSit6ybE77y3pCwmGZxbVUszEy96oyKs4
G2qYRvwCrlOAEDZgjST87bdSKbSo5oEhTKGiwwfKFCwIUHudGDurcn0ii7VqMynz
xUoa2efbk7I1HY48swLycUjqdc4M6mu+ARWD7em9852TqUBaJeuNqfwrPXJmeDdh
OgpFm4N9leZWaL/6m+xbuE7POPPcVxBSENC9fyMCKWmIZan4Tj3VdKV+gY4p0P4G
Ho670ITG4CoFm0gAZl1khJNbibLWYOjPQAGTC5CqZZX1B1LrPWlfG74kMQKg9aX7
ujQ/jnwKLVyMpnOO2PeuZy/QkcmVPUvN8++z6hOCsdq/8+GJ4CVr5fPqcrroL0FM
oiMd4ScT1uLisUBI9tzDsykTvXmimKv8l83DzFKM25EGNYUh+BE=
=J0Yz
-----END PGP SIGNATURE-----

--uxr4h7e7k7nksmyc--
