Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A2E7BC6FD
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 13:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343855AbjJGLEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 07:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343826AbjJGLEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 07:04:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2005083
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 04:04:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AE2C433C7;
        Sat,  7 Oct 2023 11:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696676670;
        bh=Y20YNDErf8+O0Uirh1MexdXjCNi6je8JK4gr+jq+D/4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BgF7wMxa207/Mac9QAxEm5FvzBxZ9YIvLFFHdVCk5q4V6ORJOG8JO+WHY66KGcPr2
         Kr51mja0zcVwKrOcaEOtLxVpuqUTYl5lGAaUlzQNt0mPM5YoRBpw4A4g3K3A4iO4Ek
         iXZEuR8utzO3nj6471NoehywXnLJd8oJuWjOGuZI9PykJzqqmdTzKE+wpvIPNF1BK1
         w2VgVJbepIl/ChoSizjE7WVn47KjhqFFYn/ky2q2Brh7wHg4NwDpJSAdC4vV5SgzBO
         SKsudqBQU+oZ21BUqdQy4AnOC4XjH/bRu0mGOgCTgY+vZVIvEajR6TyNba7EOgctBi
         HqhUeGq6C1A8g==
Date:   Sat, 7 Oct 2023 12:04:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicorn_wang@outlook.com>
Cc:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, devicetree@vger.kernel.org, guoren@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Subject: Re: [PATCH v5 00/10] Add Milk-V Pioneer RISC-V board support
Message-ID: <20231007-kennel-lustily-59b0a9867aaa@spud>
References: <cover.1696663037.git.unicorn_wang@outlook.com>
 <20231007-grasp-retake-0463858c13df@spud>
 <MA0P287MB0332F80102F534CBD7412ED3FEC8A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Usml4cP+MUcKhLiY"
Content-Disposition: inline
In-Reply-To: <MA0P287MB0332F80102F534CBD7412ED3FEC8A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Usml4cP+MUcKhLiY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 06:58:51PM +0800, Chen Wang wrote:
>=20
> On 2023/10/7 18:17, Conor Dooley wrote:
> > On Sat, Oct 07, 2023 at 03:52:04PM +0800, Chen Wang wrote:
> > > From: Chen Wang <unicorn_wang@outlook.com>
> > >=20
> > > Milk-V Pioneer [1] is a developer motherboard based on SOPHON SG2042 =
[2]
> > > in a standard mATX form factor. Add minimal device
> > > tree files for the SG2042 SOC and the Milk-V Pioneer board.
> > >=20
> > > Now only support basic uart drivers to boot up into a basic console.
> > >=20
> > > Thanks,
> > > Chen
> > >=20
> > > ---
> > >=20
> > > Changes in v5:
> > >    The patch series is based on v6.6-rc1. You can simply review or te=
st
> > >    the patches at the link [7].
> > >    - dts: changed plic to support external interrupt
> > >    - pickup improvements from Conor, details refer to [8].
> > Did you? I only see them partially picked up. I'll just replace patch 8
> > with the patch 8 from this series I think.
>=20
> Yes, only the patch 8 of this series(v5) is updated for plic node. For ot=
her
> patches, I just cherry-picked them from previous "sophon" branch.

But added my signoff? I ended up seeing my signoff on the patch where I
disagreed with the commit message, which was confusing to me.

> BTW, what I did this time may be a bit redundant. I would like to ask, if=
 I
> encounter a similar situation in the future (that is, only one patch needs
> to be modified, and the others remain unchanged), is there a better way to
> submit the patchset?

You could have sent the plic change as a incremental change on top. So a
new patch with just that one change in it.

Thanks,
Conor.

--Usml4cP+MUcKhLiY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSE7OQAKCRB4tDGHoIJi
0tYoAQCfpiz+XYlsXbrOM1jH/kmXLPj1YIVw6DT2XQAQ0p0ZMQD+JedP/XPzZ3rS
cn2UlsfA/CV2IIz+FkD2l5OoZdELTQ0=
=56si
-----END PGP SIGNATURE-----

--Usml4cP+MUcKhLiY--
