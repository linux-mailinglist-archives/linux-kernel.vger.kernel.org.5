Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377A980042F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 07:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjLAGzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 01:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjLAGzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 01:55:14 -0500
X-Greylist: delayed 361 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Nov 2023 22:55:19 PST
Received: from mail.avm.de (mail.avm.de [212.42.244.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DEF171A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 22:55:19 -0800 (PST)
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Fri,  1 Dec 2023 07:49:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1701413356; bh=UkHNm551AemnKql0mWZXE1Rzd6MlbxdsnUeJmPzDx9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vaC3ywoCokr58m2guflRShHIjBHDySrAqb7IWv6oCUTRVVxIqYansECY/EQ6H94zV
         7BH34Gec5kwu1NYdtQWGEl0xoeVU3amJLXNeEUk+FMIAY55FIEH50yjWKlft7bJAQQ
         5fJUdMRlZYKiSenptrFXxxu0th8c47pRTFiHGbjw=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
        by mail-auth.avm.de (Postfix) with ESMTPA id 91CCA80596;
        Fri,  1 Dec 2023 07:49:15 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
        id 835A91811CC; Fri,  1 Dec 2023 07:49:15 +0100 (CET)
Date:   Fri, 1 Dec 2023 07:49:13 +0100
From:   Nicolas Schier <n.schier@avm.de>
To:     Hu Haowen <2023002089@link.tyut.edu.cn>
Cc:     gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/show_delta: reformat code
Message-ID: <ZWmB67THrLcztb-3@buildd.core.avm.de>
References: <20231201053540.9534-1-2023002089@link.tyut.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x9YCRS3AC2fWuNsT"
Content-Disposition: inline
In-Reply-To: <20231201053540.9534-1-2023002089@link.tyut.edu.cn>
Organization: AVM GmbH
X-purgate-ID: 149429::1701413356-B56E3A59-5B79312B/0/0
X-purgate-type: clean
X-purgate-size: 2617
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x9YCRS3AC2fWuNsT
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 1 Dec 2023 07:49:13 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Hu Haowen <2023002089@link.tyut.edu.cn>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
	masahiroy@kernel.org, ndesaulniers@google.com, ojeda@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/show_delta: reformat code

On Fri, Dec 01, 2023 at 01:35:40PM +0800, Hu Haowen wrote:
> Correct some lines in irregular coding style to make them look more
> harmonious and fit the common coding regulations in Python.
>=20
> Signed-off-by: Hu Haowen <2023002089@link.tyut.edu.cn>
> ---
>  scripts/show_delta | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/scripts/show_delta b/scripts/show_delta
> index 291ad65e3089..33446adce74b 100755
> --- a/scripts/show_delta
> +++ b/scripts/show_delta
> @@ -13,7 +13,7 @@ import sys
>  import string
> =20
>  def usage():
> -	print ("""usage: show_delta [<options>] <filename>
> +	print("""usage: show_delta [<options>] <filename>

Hi,

thanks for your patch.  What Miguel already noticed for v1 is valid for
v2, too: there are still inconsistencies in the coding style, e.g.
`print (...)` and `print(...)`.

To simplify a consistent coding style for future work on the script,
using an external tool for reformatting (and mentioning it in the commit
message) would be helpful.  Miguel suggested Black or Ruff, I think this
is a good idea.

Kind regards,
Nicolas

--x9YCRS3AC2fWuNsT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEDv+Fiet06YHnC6RpiMa8nIiabbgFAmVpgekACgkQiMa8nIia
bbiuKA//Var3w983693LJ/e1B3Mn0KJvP4LlvdFlcoevj6NnSa4RLO7BFVLwPfPN
LV/v4Be6+Qe8SwLwCZTL1QPyF98F1tP9/zHetlEnMw2zG+Il+dvAqmpkc4bmYntu
JROh0n9C9hUmka0xiEYrEPgU7sEn6HXXjhiqliLCfeEsnmnaFdLr6RIAo7n5U5Za
kxVZc+Inp4wi3sGD2QnzuJOEMUgvtrSJBtQYniWz54ZZju0cMqGZWAzK7PMItcen
fwzh38U3UC/p7bACiZPz/BLDqVOyISZV4TT7geMUUPHLs+U7wY/kovZEoNVSMqBQ
/nV4t2xaQ0+xifxRHGHSHIWhzJl5Q4SDKTsxXR0hRXQK6hHWwILFUjq6s52GecNi
coUWrp0zqh/qniCPGvSWaH9xkYBhTJKj5V45eiFdhzn/bAIa+OuKE8si0aF7ZJ1t
519hXo017GU9IUQCu0tqMXs4J02flRgdFjcqvaW4zmOu1npKxkAGxkJe3so0xKnV
/2e4kwsiYgEqAfoVXINJk9CD9D1C8+Szh9bv9wbpidELRlQnve3PdgrrocRZX2JO
S6/1hR6AwJXfBYQ+xbZZZeVM6HHhHBlAL55+GNb1CAlBGq8TF0Xgl9V4nsSko3Hc
aPIYEaRdPJUycLNP3NXI3R+NXI8TTBjgDJaKlTJQFYJ26PaK4Yw=
=fejp
-----END PGP SIGNATURE-----

--x9YCRS3AC2fWuNsT--
