Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8077BD8F2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345914AbjJIKtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjJIKtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:49:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086EF9F;
        Mon,  9 Oct 2023 03:49:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5423FC433C7;
        Mon,  9 Oct 2023 10:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696848562;
        bh=2RHs21LKDO37SfNL/bdw49am/64L1L2gea5jf2rWfw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XUVAg3vUPi0p9wflccTHPT3aKU8HRD8+NXxCk5xYN5COxJslgF0BvZrb7okdDdBw0
         7fDoqYdLRFJKEdwDu/pfKEwhMXji3T8Bf/gGxMnIz5aqBS/GWJpLe3vC/zvz/rXZfX
         JMpfAyEpjicUMsqiPGxsjqniWz2RNbA0pMIjNHJSC9CvSCBb/m7PbCPVyLJF2o/NhU
         ffgXxI3g87coxyj2nbEx/7KRGtVU7QgyB+/m95V9YdTTdDY5VxnC1IG3fRv+wPCyFu
         nLvlJPhQLdMU4AC+50YtIh9hdlqIJ8rE672tp+cJMO0kL8/1vKYDjVTzqrcRapS7Pm
         +qlk5IdyvU1Vw==
Date:   Mon, 9 Oct 2023 12:49:18 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] ioctl_userfaultfd.2: describe missing UFFDIO_API
 feature flags
Message-ID: <ZSParg9Ssh3KE0kC@debian>
References: <20230919190206.388896-1-axelrasmussen@google.com>
 <20230919190206.388896-7-axelrasmussen@google.com>
 <20231009084514.GJ3303@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4a68J92++RdMlFJz"
Content-Disposition: inline
In-Reply-To: <20231009084514.GJ3303@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4a68J92++RdMlFJz
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 9 Oct 2023 12:49:18 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Axel Rasmussen <axelrasmussen@google.com>, Peter Xu <peterx@redhat.com>,
	linux-man@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] ioctl_userfaultfd.2: describe missing UFFDIO_API
 feature flags

Hi Mike,

On Mon, Oct 09, 2023 at 11:45:14AM +0300, Mike Rapoport wrote:
> On Tue, Sep 19, 2023 at 12:02:02PM -0700, Axel Rasmussen wrote:
> > Several new features have been added to the kernel recently, and the man
> > page wasn't updated to describe these new features. So, add in
> > descriptions of any missing features.
> >=20
> > Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
>=20
> Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>
>=20
> with a small nit below

Thanks for the reviews!

>=20
> > ---

[...]

> > +by allowing the user to write-protect unpopulated ptes.
>=20
> Nit: s/ptes/page table entries/

I've applied the following patch:
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/com=
mit/?h=3Dcontrib&id=3D2afbc25a7a3b1b68b638d7542a6bead7a1960a7d>

Cheers,
Alex

--=20
<https://www.alejandro-colomar.es/>

--4a68J92++RdMlFJz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUj2q4ACgkQnowa+77/
2zK9PQ//YN1/pawqSKQkOvdkULgAoUbQ2ULACyuvaGrzE4xSpO9dOQvNowhG+CHX
b+laOKHFxdfdDM5fCoqxI2n0HaWbg+T13Xd9wAUXnKLOZGBNbCXb9LrDq1cgsDzb
eTKuD7mmGvxnbPKkZIVQVBnonumVpsN6rmPcjaxbU58VBP9JBvmi0tmtloe94m+y
7ouIiEVk+Gz5ad3btJdgEy+87bc1Rmdmkk1M/LGn8JCM+rCCaX418Dc39BlTpGV5
fPHh+dQv39PhT56/lLJQeDf+ECs02MSNZw8O+iOL7cTaJHPEidtNJN300esdUWy8
F/6a59ykocFJTm7Jp/BYsZYUCwhKh17ctYJRpK67mHpjLmBxNUsHUDvwGQ4ZNwT4
HW4JllSPAqWeuroITYVX/hT6j1kKXbhnWrwn5awjDFL7zOt36SeUNCVnRasCrV0b
8QWKqjx/Sk22v+bhDJrslmue+bDxJOiqdCZv6lOxcLx2tgi3NbxvkX7Q1FlTkf8X
knmgxUYw+pSd5MpYTRLvPKSDLx8cVEVnIVVQ/zZ//xS7qIog9LcwJnYVUbKikTGe
hVJOyV2eCZKDX9V5gla/mdZuauK/JxBIWGtFxlYpvnec2eY6v+b7D0NTup5FafAN
euTcHwcCV8aV+CwcYBDUP69N5kkVkuePpeaozFEDcuApAvGXtxc=
=Hrun
-----END PGP SIGNATURE-----

--4a68J92++RdMlFJz--
