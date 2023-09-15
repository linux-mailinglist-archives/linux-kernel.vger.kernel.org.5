Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783237A20B0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235509AbjIOOSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235448AbjIOOSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:18:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C0B1FD0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 07:18:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33293C433C8;
        Fri, 15 Sep 2023 14:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694787510;
        bh=NGHyNfngYAoRYPFTNCehZc9kQqdxb/OpDzME1uzZLxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LqAfXzb/dZXYaiwskKA5YNGfPCbSuNQl9f66a8h27Cnuou+XHGq+dQvzv8g4NNZT5
         zEjBpJqXz1wZqeffS2g5wIEztBcFRqcZIfdnO15tx31hFIr4ykCeErVMV+L83UO+f8
         joyEDx1yenRjihRF0LyDocrmppGqqzPIJDQzevhtAwsZ6lXrcIleAXn3cAwrQCxZFN
         RBZhlA6cz5bA15WjjBG8NZxY9LFbCfy8CUu/yZNcTI6vgHZ32v2+foXOqTQwXM0QdV
         18bQzJfdDRvdcQgemwwVf8UH1Aarlczb5rVpVJt9s8x6hccEDObhT+ju9CELH6yIrq
         TgKhairxl/eHQ==
Date:   Fri, 15 Sep 2023 15:18:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Wang Chen <unicornxw@gmail.com>
Cc:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jszhang@kernel.org, guoren@kernel.org, chao.wei@sophgo.com,
        xiaoguang.xing@sophgo.com, Wang Chen <wangchen20@iscas.ac.cn>
Subject: Re: [PATCH 03/12] dt-bindings: riscv: add sophgo sg2042 bindings
Message-ID: <20230915-reoccupy-clustered-231e58a00f3c@spud>
References: <20230915072242.117935-1-wangchen20@iscas.ac.cn>
 <20230915-boxing-emporium-669d2715a347@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5kwtB/G/oIJ2SyNw"
Content-Disposition: inline
In-Reply-To: <20230915-boxing-emporium-669d2715a347@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5kwtB/G/oIJ2SyNw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 15, 2023 at 03:11:04PM +0100, Conor Dooley wrote:
> On Fri, Sep 15, 2023 at 03:22:42PM +0800, Wang Chen wrote:
> > Add DT binding documentation for the Sophgo SG2042 Soc [1] and the
> > Milk-V Pioneer board [2].
> >=20
> > [1]: https://en.sophgo.com/product/introduce/sg2042.html
> > [2]: https://milkv.io/pioneer
> >=20
> > Signed-off-by: Wang Chen <wangchen20@iscas.ac.cn>
> > Signed-off-by: Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 90f13281d297..0e0d477dab38 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -20063,6 +20063,12 @@ F:	drivers/char/sonypi.c
> >  F:	drivers/platform/x86/sony-laptop.c
> >  F:	include/linux/sony-laptop.h
> > =20
> > +SOPHGO DEVICETREES
> > +M:	Xiaoguang Xing <xiaoguang.xing@sophgo.com>
> > +M:	Chao Wei <chao.wei@sophgo.com>
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/riscv/sophgo.yaml
>=20
> I would like to see an Ack from those you are volunteering here.

I'm going to assume that you also add coverage here for the dts files
later in the series, but since the thing isnt't threaded it is hard to
check easily. If not, then a MAINTAINERS entry covering them should be
added, featuring a person that is going to monitor the lists, apply
patches and send PRs to the soc maintainers.

As a last resort, I can do that, but I don't have this hardware and
would rather someone that specifically cares for this hardware does it.

Thanks,
Conor.


--5kwtB/G/oIJ2SyNw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQRnsQAKCRB4tDGHoIJi
0milAQDChQzQ2fACthHIoqVBo61pfNxHONif3TV7/ItXZYpXmgD+KlVm9OHBkyJ2
QkzEmFmLHELmhoQTeGYPQPnb/MjeuwA=
=CP99
-----END PGP SIGNATURE-----

--5kwtB/G/oIJ2SyNw--
