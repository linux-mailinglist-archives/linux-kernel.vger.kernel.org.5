Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D813B7BEA1B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 20:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378209AbjJISvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 14:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377383AbjJISvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 14:51:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19F19C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 11:51:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32660C433CA;
        Mon,  9 Oct 2023 18:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696877465;
        bh=EWYoHUxU9PfwIcw6RRafcY/b9jcGCDKgwtSwZ93vXkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TRF0Ttm8MJ0ovlRSLQWoooPhqsT+UAvgs1OOYowfWsb+HQKayDzkMSozkTrJldIA+
         6bDX75HHnX6Tv7XDvSJxmv/d2Csx6YSHWU7b9AQV4JjRuNa+zNsIXEV2g+BhxAitg7
         QCtH7GXLcozgItxfOnEUwUdUCjV8yFsv6L9qjvd187YXfEixVcGKGBHx4TV0Yv/Fh2
         J8BdOK0pbJIfxECi9BLj9KueY8NlSYhJ6b4kecg8GzPjfA0wSGxNPlKUJ9nvFb/Xsm
         VSAHOAj/da4x8EvrhWD6gcWglOBtkIpel9cd2+8omHCgi/lpYLQ37JiUO104Xh6Auy
         Xb8DuPZBDAMKQ==
Date:   Mon, 9 Oct 2023 19:50:59 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Chen Wang <unicorn_wang@outlook.com>
Cc:     Chen Wang <unicornxw@gmail.com>, aou@eecs.berkeley.edu,
        chao.wei@sophgo.com, devicetree@vger.kernel.org, guoren@kernel.org,
        jszhang@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, robh+dt@kernel.org,
        xiaoguang.xing@sophgo.com, apatel@ventanamicro.com
Subject: Re: [PATCH v5 00/10] Add Milk-V Pioneer RISC-V board support
Message-ID: <20231009-pretext-snowy-1cfb49990ddb@spud>
References: <cover.1696663037.git.unicorn_wang@outlook.com>
 <20231007-grasp-retake-0463858c13df@spud>
 <MA0P287MB0332F80102F534CBD7412ED3FEC8A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <20231007-kennel-lustily-59b0a9867aaa@spud>
 <MA0P287MB03329460B9F3B79B1148A6FDFEC8A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
 <20231007-green-correct-11d08f650ddd@spud>
 <MA0P287MB0332B11A8481F491E4F0536DFEC8A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LPpjd4457YnzLrjL"
Content-Disposition: inline
In-Reply-To: <MA0P287MB0332B11A8481F491E4F0536DFEC8A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LPpjd4457YnzLrjL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 07, 2023 at 08:48:34PM +0800, Chen Wang wrote:
>=20
> On 2023/10/7 20:36, Conor Dooley wrote:
> > On Sat, Oct 07, 2023 at 08:25:55PM +0800, Chen Wang wrote:
> > > On 2023/10/7 19:04, Conor Dooley wrote:
> > > > On Sat, Oct 07, 2023 at 06:58:51PM +0800, Chen Wang wrote:
> > > > > On 2023/10/7 18:17, Conor Dooley wrote:
> > > > > > On Sat, Oct 07, 2023 at 03:52:04PM +0800, Chen Wang wrote:
> > > > > > > From: Chen Wang <unicorn_wang@outlook.com>
> > > > > > > Changes in v5:
> > > > > > >      The patch series is based on v6.6-rc1. You can simply re=
view or test
> > > > > > >      the patches at the link [7].
> > > > > > >      - dts: changed plic to support external interrupt
> > > > > > >      - pickup improvements from Conor, details refer to [8].
> > > > > > Did you? I only see them partially picked up. I'll just replace=
 patch 8
> > > > > > with the patch 8 from this series I think.
> > > > > Yes, only the patch 8 of this series(v5) is updated for plic node=
=2E For other
> > > > > patches, I just cherry-picked them from previous "sophon" branch.
> > > > But added my signoff? I ended up seeing my signoff on the patch whe=
re I
> > > > disagreed with the commit message, which was confusing to me.
> > > Oh, I used to think I can keep the exising signoff and I didn't mean =
to add
> > > it.
> > I added mine when I applied the patches. It no longer makes sense when
> > you resent another version.
> >=20
> > > Anyway, I agree your suggestion to create a new patch with only one
> > > change should be better, I will follow this in later work.
> > :)
> >=20
> > > Regarding your changes on sg2042 series, I have acked in another emai=
l : https://lore.kernel.org/linux-riscv/MA0P287MB0332BA73D0135CC73CAEA16DFE=
C8A@MA0P287MB0332.INDP287.PROD.OUTLOOK.COM/.
> > > If anything else required, please feel free let me know.
> > An ack on Jisheng's series for the cv1800b would be nice.
>=20
> Done, I have reviewed and acked all the files related to sophgo.

Cool. Both your and Jisheng's series should end up in linux-next
tomorrow, I've pushed both to the riscv-dt-for-next branch.

Thanks!

--LPpjd4457YnzLrjL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZSRLkwAKCRB4tDGHoIJi
0rW9AQCgH7wH465HHkJZUgXkFxDSIGwT+zdKUMYezzCSJmzTiQD/RSTBvwNO9iLX
1JL/GhqiRgflLbNTazQ/f2/5CdoDRgA=
=mpd6
-----END PGP SIGNATURE-----

--LPpjd4457YnzLrjL--
