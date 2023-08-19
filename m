Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD6A7819C1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 15:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjHSNiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 09:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHSNiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 09:38:19 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3582D2F9;
        Sat, 19 Aug 2023 06:35:26 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 38C195C010D;
        Sat, 19 Aug 2023 09:35:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 19 Aug 2023 09:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1692452123; x=1692538523; bh=s0
        DkB80QM5PxLvRe5qrV2u/Nzr3XG7+Odpxz7D4j7rw=; b=EXI3TMmR8q+ngoGyRv
        j0XvEaGQT+YyLBN8TQQgHDdXSPq3DtDUIUOcoriJfN8BNgJnI0s0HBnsU8eTLzXe
        7LktLYmHaidbvNQNkxi56QeXAOr9kqB2WgObb9VTYI3KWK2Etv6WWJsYe1R/hPfL
        7RyJmo72hXsrrbhI903M7jD8Di8N4ifFrwkKQkZqYS7KsjuXPsB6S2nLA2/gCZSB
        WHqyC0lj/F7eWMrD1Fc936e43nzIDNH4L9RUqaf9Qhm7RV99SO6DtEGcsDrOlr1q
        6kwwa7clKvcS+sN9NAYvMgvg5tVCiKvq4/2K3jnoCmDTfC+Upmw9iKyU0C0GlJ6w
        +7qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1692452123; x=1692538523; bh=s0DkB80QM5PxL
        vRe5qrV2u/Nzr3XG7+Odpxz7D4j7rw=; b=o8DN2OIeOrhoezr0BMMM6s4pxvYF7
        r5ACr2g5feSpE6czVR9/aNeW83FR0A88xCsDPqOacFDbop8LdEzokHh0wRBMyxqX
        7qPvxxXupXkfHRDB2rpvzHIPR6HA2X0k3B8EyZWI78QbPHeLI9KLYyvSg/5zVcSI
        ycIeO6i+FthHS4RTTiOrduMIxHCrn8hDjYn6sD7IBr+H3zI9gKdDszGjMphmNCN1
        Kh+bZbY46Ulr/ljCXggUJafjiv9dFt9SZot31u6mHgHcOkamCj+/fd3MSI3ZStb5
        rZnc7waNEErw75zXH2A4Kga3ycnp0fswp9YXFjX14eHYNFqlOS4+Gbvbg==
X-ME-Sender: <xms:GsXgZJzf5bMxfuGucmcwOlebYD9Q2CnXTDPhjnhlCPjtmlMyWWVcaw>
    <xme:GsXgZJR5jNNgDBAVF3FvQLUk5walqc5g7CntkGcEn7QV7yLKeQQ_mrXNlvDX4CCfu
    clc38GFQ_ODlcKDFA>
X-ME-Received: <xmr:GsXgZDUU26vDAUjHGl9fVG8U_7SijT-vh30GInB9WuNCowBeGi10ulomjgQP9YGhdseuDIaKSqYIufehFo8TiDB05JScB58i6l-9QCsblChT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduhedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:GsXgZLikLtxbCW_A0wfLhsHu2G1917An8jbx6q4CUrJKCygc8UHEtQ>
    <xmx:GsXgZLA2vU0mclgDGq9XWz7OWEufaTK5SnZM_ioUo5DI02Lyc_dT0Q>
    <xmx:GsXgZEIF2aNrwusi2-Uxl4NMr0Wt54YffP5AciFWmBpzw6_v_sZpnw>
    <xmx:G8XgZP1ze5i-3kVQH5igim6Ch9V0ekDoeA28PracmuwqC5-b_fuJtA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 19 Aug 2023 09:35:20 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id fb4068d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sat, 19 Aug 2023 13:32:57 +0000 (UTC)
Date:   Sat, 19 Aug 2023 15:35:15 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        charles.d.prestopine@intel.com, rafael.j.wysocki@intel.com,
        len.brown@intel.com, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>
Subject: Re: [PATCH] tpm: Don't make vendor check required for probe
Message-ID: <ZODFE7ngbLAo2vCx@ncase>
References: <20230818181516.19167-1-mario.limonciello@amd.com>
 <CUW0GZCVHKPB.1W7ESSPE7INHQ@seitikki>
 <25a21516-7201-4ee4-be2b-f67edaf97e2a@amd.com>
 <CUW2JM314GAR.36XV41132X3OX@seitikki>
 <719602ec-c9fc-4a72-9585-d50595cb6dca@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GTm5NOWFRb5wyE6r"
Content-Disposition: inline
In-Reply-To: <719602ec-c9fc-4a72-9585-d50595cb6dca@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GTm5NOWFRb5wyE6r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2023 at 06:57:57PM -0500, Limonciello, Mario wrote:
>=20
>=20
> On 8/18/2023 6:44 PM, Jarkko Sakkinen wrote:
> > On Fri Aug 18, 2023 at 10:38 PM UTC, Limonciello, Mario wrote:
> >>
> >>
> >> On 8/18/2023 5:07 PM, Jarkko Sakkinen wrote:
> >>> On Fri Aug 18, 2023 at 6:15 PM UTC, Mario Limonciello wrote:
> >>>> The vendor check introduced by commit 554b841d4703 ("tpm: Disable RN=
G for
> >>>> all AMD fTPMs") doesn't work properly on Intel fTPM.  The TPM doesn'=
t reply
> >>>> at bootup and returns back the command code.
> >>>
> >>> Is this reproducible with any production hardware? You are stating it
> >>> as it was reproducible categorically with any Intel fTPM.
> >>>
> >>
> >> Yes, it's affecting production hardware too.
> >> Someone came to the kernel bugzilla and reported a regression on 6.4.11
> >> on a Lenovo Intel laptop as well.
> >=20
> > Now the description says that cateogrically all Intel fTPM's fail.
>=20
> According to Todd this change caused 5 *different* reference Intel=20
> systems all to fail.  I know they're not production hardware, but still..

For what it's worth, I can confirm that this issue also occurs on an
ASUS Z170I motherboard with Intel i3 7100U and an integrated fTPM. If it
helps I'm happy to try out the proposed patch -- for now I simply
reverted 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs"), which
resolved the issue for me.

Patrick

--GTm5NOWFRb5wyE6r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmTgxRMACgkQVbJhu7ck
PpTGrQ/+NSOsdhrpo9Bqdl1pr45xp0zOtHBhTY34uRNDQdBxKAuniFqfxRjLy9lf
5oxS67OZC3JXYpPVEriLcrALtQj4J2iSA6/dSN3q0EUard8vO0heLVTTZdiG2BOW
/Y8zhydrxs4s1s4n1E6Z02Ofk7Own+QdCbsAOOqi+zzoKFKrwB3iY51evQ9Jvett
IOzg+zS93kDyOJFkQqCTGaz3JrPPPcHZfg/m3jbPOWImyL9+aONEXrrDYRyYXnwY
zME05dZcQ/fsjUrDtsP9d5FRkw/XA6EcQQrdOcOezxUp8GJQSlBO/a7GLbnao1hK
XxyusCSBNKVBnf1iEP0P3uPJ9frD96F6x6HT1mLUtYakmKo9XGseodZ0K35FBanG
IGmgmab/bOCp5ra1SQQZirQmkekTqLLGCSkFmVOO7dsGmrQZoinfW9hQhh/LFoNr
KMZRPzGtS+aU9+/fm32qJIJDo/D24GKZDtL48UGkyKvNUiLj13p8Ee1YqVL6Ytvq
REF0tzp1rN8r4tuD1kVtwplt2x1oRNe6ysGtJRKdOddP+CXRlGMlzuxuXBP4Eany
KLbk+WTUhqh1FdwNRTueC2vZwwIGMqi1YiQffQcJIvod5D2A2FDyP65g8fXdreoy
3VkpVnKS+ep/oEJDYYIwmP6grIx746YSjV4AKCJ/Xruj5L7qEmo=
=JhpO
-----END PGP SIGNATURE-----

--GTm5NOWFRb5wyE6r--
