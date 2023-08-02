Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF3976DAB1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 00:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjHBWWI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 18:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232828AbjHBWVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 18:21:47 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F73448B;
        Wed,  2 Aug 2023 15:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1691014794;
        bh=/hLdIkpJ2/W3NINO6fpHSYC6i4J4qJm52HOlpVJphLE=;
        h=Date:From:To:Cc:Subject:From;
        b=UWiRxf4UxPghGiwSXjzP7cM0pd3aYnybXc+4j0fvH81z00gnUZv5XMfUxEoWjhI1C
         IBMLvDeNLuFxuyW1MbgkzNqTFLZWM3cViEcNaQTm57DmCrkbDz/TaHZgW7cAiWMpmQ
         NTexWL6/ueZGBPlq/8EgYuT4N4gb2hvg+idvqKtDTBgtuJbzf2Q6Il4WKztXjF11IX
         9N0GzZ7AeDSZbINaavUIMFwTTp9Szk5abnpHNKE+j58MgeV5hp4xNpeZMs8jB3NBRy
         n63QlJTuyfdDD1BTM/osBYJu79M3N/TZNEE8MCNttsWG32Vgphf49Bd4UZdVDoPB9M
         Y21x+SaTJLkvQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RGRHF70Cpz4wqX;
        Thu,  3 Aug 2023 08:19:53 +1000 (AEST)
Date:   Thu, 3 Aug 2023 08:19:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Jonathan Marek <jonathan@marek.ca>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the drm-msm-lumag tree
Message-ID: <20230803081942.79524e1e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/M6fM1y0PDtplToEXqathINZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/M6fM1y0PDtplToEXqathINZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  08bfcdc2c358 ("drm/msm/dpu: increase memtype count to 16 for sm8550")

Fixes tag

  Fixes: efcd0107 ("drm/msm/dpu: add support for SM8550")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/M6fM1y0PDtplToEXqathINZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTK1n8ACgkQAVBC80lX
0GxIcAgAmy9B+MwMRea4ucN4a1HwM0dG8p3c0L4yKLzkLiepWyJnMb87laTpL5m1
hFHt9y8Pf/krp5l5yttA9dcJxOg2L8IXWeVdxbxoNOgSxZkKWiNr5skYz0PsQt7a
FPPCQAioedSZ4U6iDLji7a4hNMTpxVDhDjjXz7fiNdw++QxESkijrMEqz2s5MkaD
sa/JCa5ScOJeZ+vHzMzWpbMxpmwxneZ+DCM/7SFaBR8Fxd0R+hkfqINYhZ6xcZxE
GbYcjLhwGsxUkc4wMquGiocenkxXDpXEZCi8P01DbSrayQ+Ug2cgj0n5ybKSUhLe
5XMJY4FWexKTuN2tSzD3OKnee1d5bQ==
=c12J
-----END PGP SIGNATURE-----

--Sig_/M6fM1y0PDtplToEXqathINZ--
