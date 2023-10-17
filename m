Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCD77CB7C6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbjJQBIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjJQBIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:08:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5689B;
        Mon, 16 Oct 2023 18:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697504919;
        bh=d4Z42x5oOnZfumZGunojlWxY0lOimjyr3kzuqIrOfb4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=osEui4qNPh0+96on9/vfqxIIaw7sImrD/wGaXanTk26SFAAI07/QLxccypnOnhLzm
         07Ba3kAcxuUzpNWFtWBpaGl7QYPUCRGaKYihqq+h6ych7u3hI801nugYfLNa/sv3vF
         GnDMMS3dlIWYGzvpKeoJnrN34sfbhcrdAYW8gQ//PNGOEoE3Lkzl1DtdqsWFRCkc2V
         uQN9++UhT36DuETYhWtu1bjLqKGcjUL+VRxYEl2ctxW6XnhgJgKAlvkDjXzjZPfUQm
         Mbst33/zQrU13OPvg8zWNy4idcrQIb40kzQjJhmYH6jXcipH2n+q5ZEmg1tIvVuE06
         1Oqr0Ny1Ftiig==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S8bTM3MfSz4wc2;
        Tue, 17 Oct 2023 12:08:39 +1100 (AEDT)
Date:   Tue, 17 Oct 2023 12:08:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Lei, Jun" <jun.lei@amd.com>,
        "Dhere, Chaitanya" <Chaitanya.Dhere@amd.com>,
        "Zhuo, Qingqing" <qingqing.zhuo@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Roman Li <roman.li@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20231017120837.390db591@canb.auug.org.au>
In-Reply-To: <20231017075906.3906b823@canb.auug.org.au>
References: <20231010124357.5251e100@canb.auug.org.au>
        <cc75c480-5359-465e-adab-46b418ec5d97@amd.com>
        <20231016113946.698ac2da@canb.auug.org.au>
        <111ce50e-f445-4018-8d10-c1f7908b3198@amd.com>
        <20231017075906.3906b823@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rurMUTYhibMuh.5sdyIQLJc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rurMUTYhibMuh.5sdyIQLJc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Tue, 17 Oct 2023 07:59:06 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Hi Rodrigo,
>=20
> On Mon, 16 Oct 2023 08:53:05 -0600 Rodrigo Siqueira Jordao <Rodrigo.Sique=
ira@amd.com> wrote:
> >
> > Could you try this patchset?
> >=20
> > https://lore.kernel.org/amd-gfx/20231016142031.241912-1-Rodrigo.Siqueir=
a@amd.com/T/#t =20
>=20
> I will apply that to the merge of the amdgpu tree today.

That fixed the build problem.

Tested-by: Stephen Rothwell <sfr@canb.auug.org.au>

--=20
Cheers,
Stephen Rothwell

--Sig_/rurMUTYhibMuh.5sdyIQLJc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUt3pUACgkQAVBC80lX
0Gwh+Af/cOvTttoL/W3TaMtEiQcrXWWod4/zbRLLjKUuT0exmzX23l+HoEGddp7T
awjKKDzwFdbQGifRbfVs0+FeDy+x5JadhqzBnEhCprxKE8/vPysDnd/Le7gvYnTc
6aRucr17zfCuwZezSqwgmsKFVZqk00wzVOOW9jm3YxXwz/YfmY/X9LEhy3nqWULk
a2QAVZM7l7L/7hVY+aJ82PdE19qbP5ndlt9cSQHWIPdKNYotroLYM6adMslov/gT
60iNV/7F4zqET3bfhLbP2lFKYaoo5ruAOUxsLBO2Bj/f+7iTo1DPduVWqKlmZSJM
Y5vl6aoW/L4vRS0O9O3TEJvrRb75uQ==
=AHg2
-----END PGP SIGNATURE-----

--Sig_/rurMUTYhibMuh.5sdyIQLJc--
