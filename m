Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69517CCF75
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 23:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234963AbjJQVmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 17:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjJQVmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 17:42:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D1DA4;
        Tue, 17 Oct 2023 14:42:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBBFC433C7;
        Tue, 17 Oct 2023 21:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697578957;
        bh=bEJk/El5S1sh0NLlwpXelLcKGL2EcQlfohD4j75wrrM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=MoaQ3Ji0O3v7mU1S5rtTGqSlenPQZPxf3wArcAU0R6jMnPuNoJ7M4ULHv/ZAekdUu
         nuxnxm1oV9PxCEke3tCAn6qtwnw8PqaK/eygeiNHqEyYIVmNCfycaHXAv9djqNDdyX
         3Q9Z8NyrVtvQEGRYzocWD7YqijYwdEmqWkRqg3l6QR+p89pL3JlpsBhaxsxtAYfSM5
         48MwCJvJS9ZM50mzUDBXwWk/zxPC5QmhF7WzXMgNbQ2L5oCXSQJV8Boifry/U+2DkF
         hzpiAS2DUn/RtM7uBlCKvnuVkfTqLfJSjnch7Jfxx4mMl/XNW5BI9a8+RSUYkdynYn
         GLU5VjQK+zmkg==
Date:   Tue, 17 Oct 2023 23:42:33 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Guillem Jover <guillem@hadrons.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 4/5] ioctl_userfaultfd.2: fix / update UFFDIO_REGISTER
 error code list
Message-ID: <ZS7_yTIlIknvr7WS@debian>
References: <20231003194547.2237424-1-axelrasmussen@google.com>
 <20231003194547.2237424-5-axelrasmussen@google.com>
 <ZSMn-H_BUmJMi9La@debian>
 <ZS77PhZA9q6zQw7_@thunder.hadrons.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qDHSbjq1ltIB8fn+"
Content-Disposition: inline
In-Reply-To: <ZS77PhZA9q6zQw7_@thunder.hadrons.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qDHSbjq1ltIB8fn+
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Oct 2023 23:42:33 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Guillem Jover <guillem@hadrons.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 4/5] ioctl_userfaultfd.2: fix / update UFFDIO_REGISTER
 error code list

Hi Guillem!

On Tue, Oct 17, 2023 at 11:23:10PM +0200, Guillem Jover wrote:
> Hi!
>=20
> On Mon, 2023-10-09 at 00:06:48 +0200, Alejandro Colomar wrote:
> > This produces some unwanted space.  Please apply the following fix to
> > your patch.
> >=20
> > diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> > index 6e954e98c..795014794 100644
> > --- a/man2/ioctl_userfaultfd.2
> > +++ b/man2/ioctl_userfaultfd.2
> > @@ -432,11 +432,11 @@ .SS UFFDIO_REGISTER
> >  no mapping exists in the given range,
> >  or the mapping that exists there is invalid
> >  (e.g. unsupported type of memory),
> > -or the range values (
> > -.I range.start
> > +or the range values
> > +.IR ( range.start
>=20
> I think you meant =C2=AB.RI=C2=BB here?

Yup!  Good catch.

Cheers,
Alex

>=20
> >  or
> > -.I range.len
> > -) are not multiples of the relevant page size,
> > +.IR range.len )
> > +are not multiples of the relevant page size,
> >  or
> >  .I range.len
> >  is zero.
> >=20
>=20
> Regards,
> Guillem

--=20
<https://www.alejandro-colomar.es/>

--qDHSbjq1ltIB8fn+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUu/8kACgkQnowa+77/
2zIIsQ//dTvOtN/wns4bqPazY5U/kGVNLe9Skp5b8vVRVSvVQyevS80tzbOQsAJ/
pMyqAyg+SV/ou1VyPrnhKoUkCm6fJUPA1PCG164hbkgND64PKSSkU6fpZW58ZmTi
XQyq+DasxjEwlqbSCTRPUqslpugmNuaOVwtmDT3ggFoFHnwEmGNKmjvYBqWrM+S9
6MpJdh5JaIJGF+MY3rcgwCfwYuO8Jr5UFXV8YWCZqK8gdJT/70l0p6orptFmcMt5
dpqU6oBslTq3Ho01yTMyn4pVsEnHzPMg6nM4cXzOFI+gJPn/4SGe1PCq1YlCppOJ
sZlEo7+GEzSUBq+wXF99mhI17qWgdq1IxFRy/Srb8/egwhBhVFjsiFBK9AgKD+O7
/MvOHXwafDDxvtz4xA6mBCSCjb9a6OeuxWAWRTi693nDQxe6zHuIqABz13VPYWKW
X01HIgzMN5FRHmKJ/1IRy9cNCh0mRHJaTO6ICbVH6/HXUX+SOTxtKA47dv73kSf3
8NftmUXKYO8h4zbaDBx7sU5ZXa0G8rSKPJTQ6sZbdwdeejX95r5D9YJ1n8CSxu5t
YQzktCzPQu4yLKxzFjni5lJ4r0bxOcQzC6EKOclISGkymAv5hAWE4DozQvX+AkXl
q8/lvUylvTTn49undQUQP4MgzRvEtEGfE6RV0YD+9Dk6TVkGMOo=
=C6aY
-----END PGP SIGNATURE-----

--qDHSbjq1ltIB8fn+--
