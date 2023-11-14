Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1369B7EA8EB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 04:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjKNDJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 22:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNDJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 22:09:01 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074711A2;
        Mon, 13 Nov 2023 19:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699931336;
        bh=KR70QR5w0XcJMdBR3lpoccH3RNhz/GxEKE8X92erxPo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cR0Oijz6kqsaAOj2bX3dKtjU6GqQ2VpQlZH7oTiDKgeiabmR9Rrzdv1Zh3kfILIj2
         bFu4EX308PElGpnVtrD8NDN8zbMfRa20ljPsZ69cCN6N4t5xSwGvEa1R4N4QKxOVdO
         G9mNu0+iocotAbhuAut9dDp/1eCqhew9eIf5FGgPJDxvRMWSc/E+w297tVzEDjNC/W
         c/A7a9uoOhqSNgKrDL4ObreCmfkG5Ss4//zucg/ujO2JzYjQxWQRtRcFbU3A73woSA
         SlU/RGBC+jXSZKwgyzaeWl5Ug3b/vX+3ECvziN/oyd60NA/7YUDcmnZr5YfeL5blWW
         FuMoRS7jaxnXg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4STrqD4Wbcz4wd1;
        Tue, 14 Nov 2023 14:08:56 +1100 (AEDT)
Date:   Tue, 14 Nov 2023 14:08:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luben Tuikov <ltuikov89@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the drm-misc
 tree
Message-ID: <20231114140855.0b259b2d@canb.auug.org.au>
In-Reply-To: <530b6100-4f4e-4b3d-8fea-5b316e989633@gmail.com>
References: <20231114075501.61321c29@canb.auug.org.au>
        <19740d41-dd5a-47e4-b3e8-539b45bbd3e5@gmail.com>
        <3c306310-04b3-4658-a197-4b2d22a88274@gmail.com>
        <20231114134506.2ba0de1f@canb.auug.org.au>
        <530b6100-4f4e-4b3d-8fea-5b316e989633@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Na+7zaGwGVDM71As2dVxmhu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Na+7zaGwGVDM71As2dVxmhu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Luben,

BTW, cherry picking commits does not avoid conflicts - in fact it can
cause conflicts if there are further changes to the files affected by
the cherry picked commit in either the tree/branch the commit was
cheery picked from or the destination tree/branch (I have to deal with
these all the time when merging the drm trees in linux-next).  Much
better is to cross merge the branches so that the patch only appears
once or have a shared branches that are merged by any other branch that
needs the changes.

I understand that things are not done like this in the drm trees :-(
--=20
Cheers,
Stephen Rothwell

--Sig_/Na+7zaGwGVDM71As2dVxmhu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVS5McACgkQAVBC80lX
0GwvNwf+MEx46vQARdiMElHN+CoLXNfijWWip4XP0uRKP3n2eVw2ti11KGgJGzv0
3eAexQBSII18+NeF/0L2HJAFdR5t0NH13Q41rr5Z2Jnd1ypRRBufmBvU4ASizvWp
HScZe5MAOJ5MaSBS0aUDnurA/r1nSNWNFHbj1IyPMnvVLzNTos4Ft9eKGtzBeuiO
3VrRmm3cAVgdLmG1dm3KYEc/CPu6ko6Tbb2oPvlxjDWDCqZJsHRiRrIv7FQ4Rv9f
WCtJC7bLC0vTpwoqwDhcLzcj3ngHEruR+3ulvg8zTaPG4P4og8C8dcc8YG5vxkx3
621pcqKp87aFR7Avtziv79hWt2B0tA==
=EHf7
-----END PGP SIGNATURE-----

--Sig_/Na+7zaGwGVDM71As2dVxmhu--
