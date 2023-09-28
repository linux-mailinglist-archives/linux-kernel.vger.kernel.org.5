Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EF77B144C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 09:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjI1HNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 03:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjI1HMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 03:12:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD3455AA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 00:11:15 -0700 (PDT)
Received: from verdu-eth.calcurco.cat.235.168.192.in-addr.arpa (unknown [93.176.144.0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sergi)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3E0DC6607327;
        Thu, 28 Sep 2023 08:11:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1695885074;
        bh=32T81fKvUycfKAhnCTiHsDbfmXmo2fIN4PHbMCuJ0bs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HuS2RykrdK0vM5nrbTCy64Xc2ZB6qNUhKxlqtqFcqXi8x3JpQb6FIfbQ0H9vhZkyU
         cJJq2Lr8PSlC2GDs3B4TPSVCz0FZhgEn8wMU1PlUBd9MpQ0mLcDShZIdg392kv0Gk6
         Lp0XceWupnpVs8OwCkKW8UNCEpAtA4swFiH16gr4CWm1TpV6/pQZav7gAfocw/ZY5k
         Lz27QcV/QIPjtJdRhaNyOaYC8asYLqMCWcEyFgJ0YvVw1vGAdHaRTWzn0iHP/qhEl5
         pb1S+7809Y8Ug6AFS3OYgXolpJpjoxtsayVRf6G6q9vpv00halZBmXLlyQWI6Ql72k
         Y+sr/Y2h2o9XA==
Message-ID: <c25165891e0628b3a3a50cc528a86b2b2a65b7ae.camel@collabora.com>
Subject: Re: [RFC PATCH] drm/ci: add helper script update-xfails.py
From:   Sergi Blanch Torne <sergi.blanch.torne@collabora.com>
To:     Helen Koike <helen.koike@collabora.com>,
        dri-devel@lists.freedesktop.org
Cc:     airlied@gmail.com, daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        robdclark@gmail.com, daniel@fooishbar.org,
        vignesh.raman@collabora.com, jani.nikula@linux.intel.com,
        mripard@kernel.org, michel.daenzer@mailbox.org,
        quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        david.heidelberg@collabora.com, guilherme.gallo@collabora.com
Date:   Thu, 28 Sep 2023 09:10:58 +0200
In-Reply-To: <785cbfee-f4d3-3d53-a3e6-2f9af8fa05fb@collabora.com>
References: <20230925195556.106090-1-helen.koike@collabora.com>
         <8f946d0a5632d580b593cf731091126d59feb77f.camel@collabora.com>
         <785cbfee-f4d3-3d53-a3e6-2f9af8fa05fb@collabora.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Helen,

On Wed, 2023-09-27 at 19:28 -0300, Helen Koike wrote:
> > > +def get_unit_test_name_and_results(unit_test):
> > > +=C2=A0=C2=A0=C2=A0 if "Artifact results/failures.csv not found" in u=
nit_test:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return None, None
> > > +=C2=A0=C2=A0=C2=A0 unit_test_name, unit_test_result =3D
> > > unit_test.strip().split(",")
> > > +=C2=A0=C2=A0=C2=A0 return unit_test_name, unit_test_result
> >=20
> > Suggestion: it is not managing empty lines or comments. By now,
> > there
> > aren't, but they could be found.
>=20
> Indeed.

Just add a new if statement to discard if the strings start with # or
strip the line and check the length. Perhaps we can think of other
assertions to sanitise the string.

> > Suggestion: Sometimes tests fails with different status ("Fail" to
> > "Crash" for example) and the expectations should be updated with
> > the
> > newer status.
>=20
> The status is only present in the fails and not in the flakes list,
> so I=20
> update it with add_unit_test_or_update_result_to_fails_if_present()=20
> function below, make sense?

Absolutely, sorry that I didn't see this was a process included in the
last if statement. If it is present in the fails' file (that includes
the test name and its state) you do exactly what's necessary: add if
not present, update if it was already in the file.

>=20
Regards,


- --=20
Sergi Blanch Torn=C3=A9
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQQwWRK68l+taJfhwqAto5bHyTm9RwUCZRUnAgAKCRAto5bHyTm9
R53NAP9T2OCiwbnEjv+H0CQg/eK1xGe7yS/3cqjaPFRvvZPp1wD/V1H9NuhpRR6M
8+QZgbsS/swSPdwYABtcz+75CKpuJwo=3D
=3DXRRO
-----END PGP SIGNATURE-----
