Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D4C7BD0E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 00:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344872AbjJHW1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 18:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344751AbjJHW1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 18:27:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA9BA6;
        Sun,  8 Oct 2023 15:27:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A396C433C7;
        Sun,  8 Oct 2023 22:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696804049;
        bh=6Je5z4NUgFJLlC2dnfzAag0bpe/ujMnd3+8Y8OOL7oY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ec/IQW7yYoCYtixg/meIXXPBqT7co8S+Prxpi/TTfJzTa/B+mhGCKgLazaoyppDL3
         oREJIigq4hRy4zle2BCieRL4ENRLTGdOEliz1pgm8okIB4v4/Gk7h6UMKZA6FE+ele
         E633vrmSfaPGdj40TKSv7gKUonSi5Ygoay9BWn/CSoWtJ509sxv5RD54A6DkXSvaC3
         LJEI5TGsT7kZOIgzbrHVYbgIswqhhUyRcrn9vkZu7MWf9PXqNsTqnUNjJzhM+WtaQ9
         vM5kVTum5s5baXS+5Xn/jpRMpfu4uCTl61GJ9FZVfmFyunR1T3uc1nkfLcn1tvZdTb
         r/CHaKx2mgMNw==
Date:   Mon, 9 Oct 2023 00:27:25 +0200
From:   Alejandro Colomar <alx@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] userfaultfd man page updates
Message-ID: <ZSMszf3ASoQ8n6Hd@debian>
References: <20231003194547.2237424-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="i48LFuNyXurCh9kb"
Content-Disposition: inline
In-Reply-To: <20231003194547.2237424-1-axelrasmussen@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--i48LFuNyXurCh9kb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Mon, 9 Oct 2023 00:27:25 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Axel Rasmussen <axelrasmussen@google.com>
Cc: Peter Xu <peterx@redhat.com>, linux-man@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] userfaultfd man page updates

Hi Axel,

On Tue, Oct 03, 2023 at 12:45:42PM -0700, Axel Rasmussen wrote:
> This series includes only the remaining patches not applied from v1, with
> review comments addressed. This series is based on the "contrib" branch.

Thanks.  For the next revision, I've moved the contrib branch to my
personal repo, since it's more of a personal branch.  You can find it
here:
<https://www.alejandro-colomar.es/src/alx/linux/man-pages/man-pages.git/log=
/?h=3Dcontrib>

Cheers,
Alex

>=20
> Changelog:
>=20
> v1->v2:
>  - In patch 1 (patch 5 in v1), change "after" to "since" for consistency =
and to
>    be clear that we mean 4.11+ (inclusive).
>  - In patch 2 (patch 7 in v1), reorder error codes alphabetically (EINVAL=
 then
>    EPERM).
>  - In patch 3 (patch 8 in v1), resolve conflicts with earlier review comm=
ents.
>=20
> Original cover letter:
>=20
> Various updates for userfaultfd man pages. To summarize the changes:
>=20
> - Correctly / fully describe the two-step feature support handshake proce=
ss.
> - Describe new UFFDIO_POISON ioctl.
> - Other small improvements (missing ioctls, error codes, etc).
>=20
> Axel Rasmussen (5):
>   ioctl_userfaultfd.2: describe two-step feature handshake
>   ioctl_userfaultfd.2: correct and update UFFDIO_API ioctl error codes
>   ioctl_userfaultfd.2: clarify the state of the uffdio_api structure on
>     error
>   ioctl_userfaultfd.2: fix / update UFFDIO_REGISTER error code list
>   ioctl_userfaultfd.2: document new UFFDIO_POISON ioctl
>=20
>  man2/ioctl_userfaultfd.2 | 226 +++++++++++++++++++++++++++++++--------
>  1 file changed, 181 insertions(+), 45 deletions(-)
>=20
> --
> 2.42.0.609.gbb76f46606-goog
>=20

--=20
<https://www.alejandro-colomar.es/>

--i48LFuNyXurCh9kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmUjLM0ACgkQnowa+77/
2zItDw/9Es2KVshvygrnHn4aMBSfNmTRkokEGrJGuWuqYrCMiZWhZDqrvXPYvCum
udW07W7J4JMBUOJsPRE++BLDRn+coaiQrdMjsgKRJD4uWKjqTZkNCUbVbmU2fNZ0
o4f9ct0cF/Rz6frAV8Wqh3kvigf2+95HjXmp3Xzr6YGnbF9kjMueSLxtj3sI/5J9
yhBEFB3O4v7l4u0yeRPEeyt2uTJEYENrZXSLVK9hH6gcQYw8knDAZvPLaknKPRxv
JPvgq7/eWq09uIuKHpWbMSI9ztMDJ5xFYOaBVz/6fuRXmg27J9sUt8FNg5TQAMEk
2+IvzQyc0Ne4cC1ifVl8C7MWqnK9G2eNg4ZpLD5pRGQ+EaOmoZyDWo5juzf6nT7D
rC4jy/T+olZIvaR9K9BbdmRR8b4dLvjq97l/S7DrN+Ofxd1EDXW5JXHEJmAdP6GU
Fm3kxeZqdUy/ByZvQ7BR0SaxxyLAnKRfyXQtlVzT1PKyxTiNpii5OBHukyBjbyah
KHCZ1+BVU85920pxnmc8cepWvDMk4j3DHAoDUMb8PNVdvUcnKVF9ra+MzgaioUB1
OS67+UznAc29CvaDo075V55cTNgkW502cO8X87B4tgy7F1Q5evZBQHEgp2K/kArc
IAY3FIV0TmlJNgs+nNAMEozNZEDaIDVsUIGNRPvGYaHEQVZ7a7A=
=+UFg
-----END PGP SIGNATURE-----

--i48LFuNyXurCh9kb--
