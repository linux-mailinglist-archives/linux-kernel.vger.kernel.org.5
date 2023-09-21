Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6669E7A9B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjIUTBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjIUTBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:01:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A05480FB0;
        Thu, 21 Sep 2023 10:36:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C58AC116AC;
        Thu, 21 Sep 2023 08:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695283538;
        bh=cYb7Ub3bti/deKs/jdrs9q+vuzARawcOGZH6tlkcZ0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rzndAuD5lDrILdYmfpKN3DCvqeXqeVrLQZankoX6JfzmLsKO16hXwIWP7+77ALI3g
         6SwpEcPdr0JvsbnP13j7BllSZgFElmxjR/0Yin7ZHXWsFKaSaD6Z3Hu9p4wqvnm4E0
         8RnqaD3d6DuKPAt8ILyxMFWgiWUT7f9ovQLmodULkRiyvryk4jdrFhE+1CS9PLkDfN
         9rZDGaF6EB68ZyWC1fNCNGYUGzvdcG0tDQgKhU2vjpK48e4mdp8OSxMY8dmrNhfu30
         HAVKv2GxAuuXwelQ3pt+z3LY2dQFxdRB+jETIdNiMmT+tl3x/0c0oiw72DzhmIbBrY
         tjYfVZjbu1VlA==
Date:   Thu, 21 Sep 2023 09:05:32 +0100
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
Message-ID: <20230921-d7bab3f036e498a23eb6b578@fedora>
References: <20230920-53a04651c08acb0796dc63b4@fedora>
 <IA1PR20MB495358928C0DCF5854C99584BBF8A@IA1PR20MB4953.namprd20.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kdBFnvGRk9OScnKc"
Content-Disposition: inline
In-Reply-To: <IA1PR20MB495358928C0DCF5854C99584BBF8A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kdBFnvGRk9OScnKc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 21, 2023 at 08:43:47AM +0800, Inochi Amaoto wrote:

> >>>> but not one. In another word, there is no need to defined mtimer and=
 ipi
> >>>> device on the same base address.
> >>>
> >>> There's also no need to have two compatibles for the same interrupt
> >>> controller, so I do not get this reasoning. What actually _requires_
> >>> them to be split?
> >>>
> >>
> >> Yes, it is one, but can be mapped into different address. So I think we
> >> need two.
> >
> >Not two compatibles though, just two memory addresses that you need to
> >locate (or maybe even 3, for SSWI?)
> >
>=20
> We may need four (mtime, mtimecmp, mswi, sswi) if use register range.

Why would you need 4? The first two certainly could be individual
reg entries, no?

> Anyway, I will use a vendor spec implementation as a temporary solution.
> I hope this will be corrected in a predictable future, and we can use a
> standard way to resolve this at that time. :)

If the spec doesn't get frozen, there'll not be a standard way merged.
Hopefully not too many others go off an implement non-frozen specs, and
we will not really need to worry all that much about it.

Cheers,
Conor.

--kdBFnvGRk9OScnKc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQv5SAAKCRB4tDGHoIJi
0kwBAQCMThCZ01ziaG8cYDl53BVrJCuqYiEaCp+5ivC/5BrsOAEAptaWzL8Sle9r
wuC74Jhg0ariLbfG9Of8Zpra2j83dAM=
=fXxo
-----END PGP SIGNATURE-----

--kdBFnvGRk9OScnKc--
