Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073317A9D33
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjIUT3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjIUT3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:29:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62EECA9E7;
        Thu, 21 Sep 2023 10:07:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A636EC116D7;
        Thu, 21 Sep 2023 08:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695286328;
        bh=SBD9ZzEicd22ZDdkZ70qDAja5Op34wmz8fwnbFCDoPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mjYj8FDDXuN2U5Mf1F2HHeaNdS4oKHVT6ICoyBQiXFpyhdXpn6eY2PcewMf1EnIXn
         3VFwNdTQa97TsGvLsMM9F98Bmhgfy7ySgyJwpQYGGrd/8vwFY5rnQ7kVj9bI1esag0
         BPnZgsSOX34n/33Uq/bk7QHf5LXLHBGhiGMirfPth7XNf6+VCnUfVyT6B0og9+b/XI
         PHAbVrkIk1IqIhRPx5v79iYkbOQN6PBkxOfY5ORVfwgD9i3bd/o18+VpAaEt1o5v+4
         AVP6806Ei5gD184AnQEkElKbONar700d2uIve8zeAn3AbrcZogBCxzvKDdVt4ovNiM
         rzJc7gy8/TMfg==
Date:   Thu, 21 Sep 2023 09:52:01 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Inochi Amaoto <inochiama@outlook.com>
Cc:     Anup Patel <apatel@ventanamicro.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        aou@eecs.berkeley.edu, chao.wei@sophgo.com,
        evicetree@vger.kernel.org, emil.renner.berthing@canonical.com,
        guoren@kernel.org, jszhang@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, Chen Wang <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH v2 06/11] dt-bindings: timer: Add Sophgo sg2042 clint
Message-ID: <20230921-dbfb0a62538cc54852ad45b4@fedora>
References: <20230921-d7bab3f036e498a23eb6b578@fedora>
 <PH7PR20MB4962478C50534722C16B17DDBBF8A@PH7PR20MB4962.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3QkateNXglw3SC16"
Content-Disposition: inline
In-Reply-To: <PH7PR20MB4962478C50534722C16B17DDBBF8A@PH7PR20MB4962.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3QkateNXglw3SC16
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Yo,

On Thu, Sep 21, 2023 at 04:18:57PM +0800, Inochi Amaoto wrote:
> >On Thu, Sep 21, 2023 at 08:43:47AM +0800, Inochi Amaoto wrote:

> >>>>>> but not one. In another word, there is no need to defined mtimer a=
nd ipi
> >>>>>> device on the same base address.
> >>>>>
> >>>>> There's also no need to have two compatibles for the same interrupt
> >>>>> controller, so I do not get this reasoning. What actually _requires_
> >>>>> them to be split?
> >>>>>
> >>>>
> >>>> Yes, it is one, but can be mapped into different address. So I think=
 we
> >>>> need two.
> >>>
> >>> Not two compatibles though, just two memory addresses that you need to
> >>> locate (or maybe even 3, for SSWI?)
> >>>
> >>
> >> We may need four (mtime, mtimecmp, mswi, sswi) if use register range.
> >
> >Why would you need 4? The first two certainly could be individual
> >reg entries, no?
> >
>=20
> After reading the aclint doc again, I found the all of them can be mapped
> on the different address. (See the section 2.1 in that doc).

Right, that's what I meant by individual reg entries. If there's some
dynamic gap between them, then one reg entry would cover mtime and one
would cover the base of the mtimecmp region.

> But for now,
> the mtime and mtimecmp have the same base address in any platform.

How? The mtimecmp base address would have to be offset from the mtime
base address. Is what you mean that, for example, mtime is at an offset
of 0x0 from the base address & mtimecmp0 is at, for example, an offset
of 0x8 so a single reg entry can cover both?

Also, "any platform"? I figure you mean in this one specific platform?

> Anyway,
> the frozen spec in future will decided how many ranges we need.

Isn't the spec abandoned? There may well be no frozen spec.

> >> Anyway, I will use a vendor spec implementation as a temporary solutio=
n.
> >> I hope this will be corrected in a predictable future, and we can use a
> >> standard way to resolve this at that time. :)
> >
> >If the spec doesn't get frozen, there'll not be a standard way merged.
> >Hopefully not too many others go off an implement non-frozen specs, and
> >we will not really need to worry all that much about it.

Cheers,
Conor.

--3QkateNXglw3SC16
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQwELgAKCRB4tDGHoIJi
0mFBAQDD7fMHX5wOXYvk1hooV2cLDyyw+SAUv7OJKgltZw/Y1AEAlXgGk+Kx3Gm4
Kh/W9kwPQFTcI0GL2em5xAh5VCoPSw4=
=tkZX
-----END PGP SIGNATURE-----

--3QkateNXglw3SC16--
