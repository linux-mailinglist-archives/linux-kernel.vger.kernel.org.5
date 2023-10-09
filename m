Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900077BD913
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346150AbjJIK63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346133AbjJIK61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:58:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4E49C;
        Mon,  9 Oct 2023 03:58:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15177C433C8;
        Mon,  9 Oct 2023 10:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696849105;
        bh=pFDYRue/bKj9ILdCpjBIpmgz7Ku880Uz+C01332gWuE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZye6kFSL5tEFdCjs6MTkk47EvSnsY2Nre6JIrO0oUkmZGhBkTxD4fw/6M2ik+6UH
         OBaW2AcdSVzxvRAfU1YsDqLBjItnHo70Xgcre3gbmhvUWUzhYCbuvppcC8n6ovUbbA
         d2gaYsklkkBN+k3GvWEybOTdQ5C1+tnV5e94K8VhIoaemsBCW2K8ZjCL2ZXvcf16s1
         5SaqClDch5QdecmGk5sGuuGEFSyBsRwtoOfrh0YVFUehMqY0IeJyh+z38Y0DD48uJL
         38td8l2QsNxmDuvBATmuYgSS5bspoLX52/Z+cHkY3hZwtfyLyK+leO2tkdvVDxhbvJ
         4GwmYAnYaJZTw==
Date:   Mon, 9 Oct 2023 12:58:21 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] ioctl_userfaultfd.2: describe two-step feature
 handshake
Message-ID: <ZSPczSndiAlZfDOU@debian>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-6-axelrasmussen@google.com>
 <20231009084247.GI3303@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="W7HwIlpxFh93S0s/"
Content-Disposition: inline
In-Reply-To: <20231009084247.GI3303@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--W7HwIlpxFh93S0s/
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 9 Oct 2023 12:58:21 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>, Peter Xu <peterx@redhat.com>,
	linux-man@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/10] ioctl_userfaultfd.2: describe two-step feature
 handshake

Hi Mike,

On Mon, Oct 09, 2023 at 11:42:47AM +0300, Mike Rapoport wrote:
> On Tue, Sep 19, 2023 at 12:02:01PM -0700, Axel Rasmussen wrote:
> > Fully describe how UFFDIO_API can be used to perform a two-step feature
> > handshake, and also note the case where this isn't necessary (programs
> > which don't depend on any extra features).
> >=20
> > This lets us clean up an old FIXME asking for this to be described.
> >=20
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>=20
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

Since v2 is unchanged, I've added this tag.  Thanks for the review!

Cheers,
Alex

>=20
> > ---
> >  man2/ioctl_userfaultfd.2 | 37 +++++++++++++++++++++----------------
> >  1 file changed, 21 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/man2/ioctl_userfaultfd.2 b/man2/ioctl_userfaultfd.2
> > index 339adf8fe..e91a1dfc8 100644
> > --- a/man2/ioctl_userfaultfd.2
> > +++ b/man2/ioctl_userfaultfd.2
> > @@ -83,7 +83,6 @@ struct uffdio_api {
> >  The
> >  .I api
> >  field denotes the API version requested by the application.
> > -.PP
> >  The kernel verifies that it can support the requested API version,
> >  and sets the
> >  .I features
> > @@ -93,6 +92,25 @@ fields to bit masks representing all the available f=
eatures and the generic
> >  .BR ioctl (2)
> >  operations available.
> >  .PP
> > +After Linux 4.11,
> > +applications should use the
> > +.I features
> > +field to perform a two-step handshake.
> > +First,
> > +.BR UFFDIO_API
> > +is called with the
> > +.I features
> > +field set to zero.
> > +The kernel responsds by setting all supported feature bits.

s/responsds/responds/ amended.

> > +.PP
> > +Applications which do not require any specific features
> > +can begin using the userfaultfd immediately.
> > +Applications which do need specific features
> > +should call
> > +.BR UFFDIO_API
> > +again with a subset of the reported feature bits set
> > +to enable those features.
> > +.PP
> >  Before Linux 4.11, the
> >  .I features
> >  field must be initialized to zero before the call to
> > @@ -102,24 +120,11 @@ and zero (i.e., no feature bits) is placed in the
> >  field by the kernel upon return from
> >  .BR ioctl (2).
> >  .PP
> > -Starting from Linux 4.11, the
> > -.I features
> > -field can be used to ask whether particular features are supported
> > -and explicitly enable userfaultfd features that are disabled by defaul=
t.
> > -The kernel always reports all the available features in the
> > -.I features
> > -field.
> > -.PP
> > -To enable userfaultfd features the application should set
> > -a bit corresponding to each feature it wants to enable in the
> > -.I features
> > -field.
> > -If the kernel supports all the requested features it will enable them.
> > -Otherwise it will zero out the returned
> > +If the application sets unsupported feature bits,
> > +the kernel will zero out the returned
> >  .I uffdio_api
> >  structure and return
> >  .BR EINVAL .
> > -.\" FIXME add more details about feature negotiation and enablement
> >  .PP
> >  The following feature bits may be set:
> >  .TP
> > --=20
> > 2.42.0.459.ge4e396fd5e-goog
> >=20
> >=20
>=20
> --=20
> Sincerely yours,
> Mike.

--=20
<https://www.alejandro-colomar.es/>

--W7HwIlpxFh93S0s/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUj3M0ACgkQnowa+77/
2zIljg/+O+XKXPmc+OxbhyCJMh2jHqOEpdFbUq6rqZM6ZkTGGSD+G4lM4tN7QNvd
9UYN/jrxFq/Og4zpCYULSxSqYwgnKC25e3l2KNK0wT49D/T05vl/Fq2zQSD7lL2/
303w2aAKijCdicWZumFytoUxAVybgHvsDGqgyq65w57muAWV+mSQjIQYnpXIvBKw
uA1wncaMpXTU0CG7uehIGbudIRrc1FpmNp1yPjSMyCeN8LucS8xTOwDOaf1a1Q4L
X4pgP/sr8t2uKC/1M9rnaA8GvhZp9vwxHBJxBvKyVhmkoiD8Fc15AtjI+OBKuo60
6Wh2jsrKQZsSeuYU/pITUO2XszbckymBatAIQkAbMPsQODthglIfb59GGCTxLoVU
MJ88Pguc/WaSFz06T+AErgJaT94dnup4o2oDSloeQ+etRR0Ooqf5Dsm2cImRoIMt
wKwYcJuYivqex+y85tBiD3UMIrKzpyyb3oTaYEfHMWpAzQnUYS7HJ0TAEW+pLF+f
g8G8SohJkpxpkZ4SQKfs719tCB7qkUR0ToQhi18q2vGaQMjbFU48xZKidyV8bBju
HwU2DpsYG6Iw0F7K1dcF3lACdvMhcdbOLygcM+tSDGD2asntQ6qEMn4EjgX18fCg
kOLjOIYUJRaGMWxRBetts4DI41BN394UznxLu93XjJ+WVdSwV3k=
=BdwT
-----END PGP SIGNATURE-----

--W7HwIlpxFh93S0s/--
