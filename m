Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA7778EBCF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243760AbjHaLS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242946AbjHaLS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:18:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAD8CFC;
        Thu, 31 Aug 2023 04:18:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EBF38B82261;
        Thu, 31 Aug 2023 11:18:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374C3C433C9;
        Thu, 31 Aug 2023 11:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693480700;
        bh=7XKjjJur6IISUsZtGWtOGeI27/EKhAdS31tOASxp7Ss=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nZ9zSFKAnT26GUSPehFD44ATzfOwZSAjSHXrFhHPX2LQhvLD2tjEL+aP6UthSyvNJ
         7bjbHhpLZUa/PcrUjw7qEqxWtO8rG25C8/kWWqv1sMUySOTSahIeRsEpzkZAvFbfG4
         dI3kSoZgY/dD4bnEW39s+22ZYwOhSJACR7EVuFUlCnQp3k5zxagURXEhCuM4CPuadP
         JfJIjJNIBanjRc7s+8pDpEY3iSdpNO8cP/nHUhSWYvrw9HIsQ8BTzNoeh+V8wZkmrC
         POiCuqMfLjmrLwGJRvq1DdYbW5YrI49DIv3bKJZfXTyEPBwnrvPHivXwXwuCUG97j3
         28nd67Be4dIGw==
Message-ID: <88708464-cc1c-c31d-5cb0-171a41dec936@kernel.org>
Date:   Thu, 31 Aug 2023 13:18:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2 1/2] crypto: qat - refactor included headers
Content-Language: en-US
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Cc:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        qat-linux@intel.com, Giovanni Cabiddu <giovanni.cabiddu@intel.com>
References: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
 <20230818102322.142582-2-lucas.segarra.fernandez@intel.com>
 <ZOiEHCsjBCL04Z3x@gondor.apana.org.au> <ZOigoVJbjdOx9Wea@smile.fi.intel.com>
 <ZOx1SOBKbmdIvz+b@gondor.apana.org.au> <ZOx6+i5HEAY4F4X3@smile.fi.intel.com>
 <ZO3F8AgOS/NnVaeU@gondor.apana.org.au> <ZO375Wg0+nTCgCIJ@smile.fi.intel.com>
 <ZPAPSOnSTMgYrlV/@gondor.apana.org.au>
From:   Alejandro Colomar <alx@kernel.org>
Organization: Linux
In-Reply-To: <ZPAPSOnSTMgYrlV/@gondor.apana.org.au>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hD0Xi3oWq1ZQW10n0Qk60FT0"
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hD0Xi3oWq1ZQW10n0Qk60FT0
Content-Type: multipart/mixed; boundary="------------6kEu0nV6dObclYqq0nOrIm0f";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
 qat-linux@intel.com, Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Message-ID: <88708464-cc1c-c31d-5cb0-171a41dec936@kernel.org>
Subject: Re: [PATCH v2 1/2] crypto: qat - refactor included headers
References: <20230818102322.142582-1-lucas.segarra.fernandez@intel.com>
 <20230818102322.142582-2-lucas.segarra.fernandez@intel.com>
 <ZOiEHCsjBCL04Z3x@gondor.apana.org.au> <ZOigoVJbjdOx9Wea@smile.fi.intel.com>
 <ZOx1SOBKbmdIvz+b@gondor.apana.org.au> <ZOx6+i5HEAY4F4X3@smile.fi.intel.com>
 <ZO3F8AgOS/NnVaeU@gondor.apana.org.au> <ZO375Wg0+nTCgCIJ@smile.fi.intel.com>
 <ZPAPSOnSTMgYrlV/@gondor.apana.org.au>
In-Reply-To: <ZPAPSOnSTMgYrlV/@gondor.apana.org.au>

--------------6kEu0nV6dObclYqq0nOrIm0f
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Herbert,

On 2023-08-31 05:55, Herbert Xu wrote:
> On Tue, Aug 29, 2023 at 05:08:37PM +0300, Andy Shevchenko wrote:
>>
>> Do I understand correctly that you want *ideally* to have THE kernel.h=

>> as a _single_ header and that's it?
>=20
> My rule of thumb for a .c file is that if you need more than two
> headers directly included by kernel.h then you should just use
> kernel.h.
>=20
>> While I understand your motivation as a maintainer, I hate the idea of=
 current
>> kernel.h to be included as a silver bullet to every file because peopl=
e are not
>> capable to understand this C language part of design. The usage of the=
 proper
>> headers show that developer _thought_ very well about what they are do=
ing in
>> the driver. Neglecting this affects the quality of the code in my opin=
ion.
>> That's why I strongly recommend to avoid kernel.h inclusion unless it'=
s indeed
>> the one that provides something that is used in the driver. Even thoug=
h, the
>> rest headers also need to be included (as it wasn't done by kernel.h a=
t any
>> circumstances).
>=20
> I have no qualms with fixing header files that include kernel.h
> to include whatever it is that they need directly.  That is a
> worthy goal and should be enforced for all new header files.
>=20
> I just don't share your enthusiasm about doing the same for .c
> files.

<https://include-what-you-use.org/

Maybe this is helpful, if you didn't know about it.  :)
(I disagree with the forward declarations that are recommended there,
though.)

Cheers,
Alex

>=20
> Cheers,

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5


--------------6kEu0nV6dObclYqq0nOrIm0f--

--------------hD0Xi3oWq1ZQW10n0Qk60FT0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmTwdvMACgkQnowa+77/
2zKG8RAAqRqG89soMD2RYqIFbyfLvevBTLP/COS/JPw4mrqb23M3KDQAm0OTfYLj
DO2rdpy4r1GW0ljJUIT/GVSppL/1qxmZDi1ifvJyFdDhHAPSrHWNM04xUaI3yxuR
HYXwHLkHNbO/Ov8a51ZyEeZplsEPEQ7pPE64+YxiCPMqqhUho9XYVhcp795N8ZDh
Q/tzLYmKD+kV58WOKpZ9kSir1JfN6eQdInWgLp+Q+5sdNWF/J2SlKeexp2VSAVyU
kgl6hw9i2nXdh0gxQFKF4+KMntEeMYJ6iTVxkwxXUTE87bL09LkKFEAw7BtAq8jU
jOdM89dOZJoWSUihQ9uzz2sRyhF1lowm6qjjmfW1XhyFYQc/g/mepIJRsEVhR8id
JDJJ+PXygRckqohVz/vyhOYLJfifK2ci+2PS3TYyZdGYNX5SXMH6lZTTR8p5Pye2
E2AuvfIclDhWt6D6U/sVvaNl9bs2VuQ7l6mHh9AjxbJAkJPTLgIyc1Z1RzNd+Pv9
oMDt0/B1HY6bMEeQbVYIJuDcP1XAlUSr4RGm2+/9OI15biOtb1yjhp0jXeVDB/+E
P3cjirqRPvbH4ndTgRBVJI/4/8bFe0+SLVb2vdL4P3/vqmBDQxw/UTa9Ds+GHHxp
YvfnXpUJcYp+oFAT0v3kGagw8o60C6x/YoWekuSTHbQ1d+FfDig=
=zvhu
-----END PGP SIGNATURE-----

--------------hD0Xi3oWq1ZQW10n0Qk60FT0--
