Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803827800BD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355469AbjHQWFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349240AbjHQWFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:05:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C24B3C38;
        Thu, 17 Aug 2023 15:04:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D52D64D82;
        Thu, 17 Aug 2023 22:03:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4960C433C7;
        Thu, 17 Aug 2023 22:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692309800;
        bh=x+FnH9jPDfmQHGu5RL7djdVhTpurY2NLl0O3LxkstvQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=SdnKka5B3LrYRieuWpc6s5R3xFOMAbTY4pMnrratUp0urruf7P9NiRFhprvWcnQ3T
         EvYZcKxk2GJpyuNi0JQN3DcCcgUapFi7NgQxDo516hc1BWJkRSNb/xGYNkkreiiOyJ
         02skDXJnxWPezdsWR52KgQbDB/5E+R1gcGdy47+Tpz9peJoX1tzG7xxK9sN+e1cn6Z
         P0IJAe/MEPGkOrDK8WWtepcYoD+793p8lDmr4/Ng/Bj6YMF6kHCrPVAipOaIBPPqd0
         4V8RnnW5g2HcOj09xclQ6eS1frA4nDzK4nK4vqWAc7skXq4u4ANjDPMa0H+WSHjLZy
         fuBK740U0eocw==
Message-ID: <57a30a95-b63c-7ad4-070f-db70262b6b7c@kernel.org>
Date:   Fri, 18 Aug 2023 00:03:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH 2/4] linux/array_size.h: Add ARRAY_SIZE_OF_FIELD()
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
        herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, qat-linux@intel.com,
        andriy.shevchenko@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20230817143352.132583-1-lucas.segarra.fernandez@intel.com>
 <20230817143352.132583-3-lucas.segarra.fernandez@intel.com>
 <574d3a14-6b6e-3ad2-2ce3-48c9d76e205c@kernel.org>
 <CAHp75VdZiLbE07h3Ei6OmTNFKJ69ksKMRk1EYOjSCxveR+JFCA@mail.gmail.com>
Content-Language: en-US
From:   Alejandro Colomar <alx@kernel.org>
Organization: Linux
In-Reply-To: <CAHp75VdZiLbE07h3Ei6OmTNFKJ69ksKMRk1EYOjSCxveR+JFCA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------v1TPGZhYG4YP9d3lZYzONNH9"
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------v1TPGZhYG4YP9d3lZYzONNH9
Content-Type: multipart/mixed; boundary="------------Z1QprukeyGf3CrJaicsPR0CK";
 protected-headers="v1"
From: Alejandro Colomar <alx@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>,
 herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org, qat-linux@intel.com,
 andriy.shevchenko@intel.com, Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
 Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Message-ID: <57a30a95-b63c-7ad4-070f-db70262b6b7c@kernel.org>
Subject: Re: [PATCH 2/4] linux/array_size.h: Add ARRAY_SIZE_OF_FIELD()
References: <20230817143352.132583-1-lucas.segarra.fernandez@intel.com>
 <20230817143352.132583-3-lucas.segarra.fernandez@intel.com>
 <574d3a14-6b6e-3ad2-2ce3-48c9d76e205c@kernel.org>
 <CAHp75VdZiLbE07h3Ei6OmTNFKJ69ksKMRk1EYOjSCxveR+JFCA@mail.gmail.com>
In-Reply-To: <CAHp75VdZiLbE07h3Ei6OmTNFKJ69ksKMRk1EYOjSCxveR+JFCA@mail.gmail.com>

--------------Z1QprukeyGf3CrJaicsPR0CK
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On 2023-08-17 23:30, Andy Shevchenko wrote:
> On Thu, Aug 17, 2023 at 11:34=E2=80=AFPM Alejandro Colomar <alx@kernel.=
org> wrote:
>> On 2023-08-17 16:33, Lucas Segarra Fernandez wrote:
>=20
> ...
>=20
>> Some comment about the name:
>>
>> ARRAY_SIZE() is rather ambiguous, as there's array_size()[1], which me=
ans the
>> number of bytes needed to represent the array.  I suggest a name based=
 on
>>
>> -  _Lengthof()  It has been proposed to ISO C to get the number of ele=
ments
>>                 of an array:
>>                 <https://www.open-std.org/jtc1/sc22/wg14/www/docs/n252=
9.pdf>.
>>
>> -  sizeof_field()  The kernel macro for the size of a struct member
>>
>> So, how about lengthof_field()?
>=20
> TBH I do not understand the motivation of making this kind of
> confusion and inconsistency.


> Are you suggesting renaming ARRAY_SIZE()
> to begin with?

No.  ARRAY_SIZE is a very old and known API.  It is array_size() that is
to be blamed, due to having a confusing name.

What I suggest is not reusing the root of the name of ARRAY_SIZE(), which=

since the addition of array_size() may be less unambiguous (IMHO).

So, instead of ARRAY_SIZE_*(), which is derived from ARRAY_SIZE(), maybe
it would be more unambiguous to use the _Lengthof() name as a root, since=

nobody has messed with it so far.

My suggestion is to keep ARRAY_SIZE() with its old name, but use
lengthof_field() for this struct variant of it.  It's also a shorter name=
,
which will make for shorter lines.

b19d57d0f3cc ("overflow.h: Add flex_array_size() helper")
	- (Mon Jun 8 20:22:33 2020 -0500)
610b15c50e86 ("overflow.h: Add allocation size calculation helpers")
	- (Mon May 7 16:47:02 2018 -0700)

Nevertheless, it was just a minor suggestion, and if array_size() was
seen as a good enough name, it wouldn't be as confusing as it seems to
me.  If you find them to be fine, go ahead.

Cheers,
Alex

> If so, it's definitely out of the scope of this series.
>=20

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5


--------------Z1QprukeyGf3CrJaicsPR0CK--

--------------v1TPGZhYG4YP9d3lZYzONNH9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmTemR4ACgkQnowa+77/
2zIvHxAAi/nyYuGEWGa4tuQcfHGDBKFkHEIRM+rEWcoXY0mmRFdC3lu0RAQxTCQP
El83M3eXYO5iCHjeh6k0dGFTaIBUwUUj0rrbSYH65MdmwHuR3O6GhE9uijHKjzm3
pBDdunpdeDVEP1Ln7EmP7K/WY5PPcT78iaL1jeveDtpIGDEA8O+N5kuN3TvwusYE
ztXksro67OCUjP8TA7Mp/n1GorMxQFKTF9KYJ/Q7f+o612+PJ9K3God6m0XcAuUo
jUd3CH9BEgg5rZTx+BTT67iqPqzIcJ7trq9F+qIX18lHDD+qyVDLjzzCkxtWE1xC
vXDlUe2KMI1+acrSR8qTUOYiSWQq1zrNrVbS0jwaju2YCzODnTOdyz2g9iJickiS
1NUBhPWJ3zefivmZB/oBQPApMPpcqIQ72bQYveiTzWYVdZrzbU6dL1tQG9CBZJyA
/0zQuTROfioxyKezAW9JqXmkOiDNbQO+MibAj933YMEMnxTWlh/U0VNSY2Tv2cEh
Zuv0E+Bucv7LzTcXP88VhJAaj733OaizKkanT/YGC5rn6FxN5njHHxY6flhb+bMc
DjfJfxFh5Ft4M7EJGAfZrmg/n9dNAt5AKtAfM/g1Z5sV/1/bZWf4NsCVP/krX7ge
LOrnqHiupIfx2i8CB2nIWrsy1TIL840Iv0eSbkKnRbTq0BJfCSc=
=22fs
-----END PGP SIGNATURE-----

--------------v1TPGZhYG4YP9d3lZYzONNH9--
