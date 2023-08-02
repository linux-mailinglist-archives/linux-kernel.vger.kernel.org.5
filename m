Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E0876D232
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 17:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbjHBPhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 11:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235282AbjHBPhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 11:37:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2A34227;
        Wed,  2 Aug 2023 08:36:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26CC1619F7;
        Wed,  2 Aug 2023 15:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50CBC433C7;
        Wed,  2 Aug 2023 15:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690990577;
        bh=VEWmaH6qGy3T08XS1lxerZ2AdTKVv4A8UoEZJDJL+zQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D25pD2YVaVmLO3FAHV4zWHO4mT4aBejdsZEfsAHPyVIJyn2f3cxKBUBZVHusNpRiq
         HcLaiBO61FC+kC7d+QfLBJTdjNMTwQdwO3Do6Wy/q9sRyNiM3iuxiHF5IwM5tXjXsZ
         O/zU+a7c3VRSSR2LJ1E3LP9m5vqJNySkS51bwr6AS6Fd+6W7h32vkrSKWC4wzAB7EY
         VGqaVaem/iT/Eh2g8HUXVvulJw/1z50vZUxL74fyTKbdwyHWpESJnCUwcwUbR1hLb1
         YTESQkj+gTrpoEoPvi9CskVKpF2pHB7u9vDnVr8iUKm+AN0c6LhJDKGUm16kmAzcgl
         dx6Mf+rE/Acew==
Date:   Wed, 2 Aug 2023 16:36:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
Message-ID: <20230802-empathy-wound-70df4990a976@spud>
References: <20230731-setback-such-61815ee3ef51@spud>
 <041bf8a6-8d91-c2ce-6752-aa7255f946c7@loongson.cn>
 <20230801-whenever-imitation-b2759b212f6b@spud>
 <a5c27913-2a88-d376-0130-22ca8a3d4516@loongson.cn>
 <20230801-varsity-chemo-09cc5e250ded@spud>
 <26adb487-f8c5-9cf4-5b31-070e9161e761@loongson.cn>
 <20230802-jailer-pavilion-84fb17bb3710@wendy>
 <3534f7b9-0e02-28c1-238a-5a6fdbb95e94@loongson.cn>
 <20230802-bunkbed-siamese-57ee53bdf273@wendy>
 <db7012b2-9156-34ed-ad1f-10a3e5dfe390@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tzYDufM4KGgTx5jl"
Content-Disposition: inline
In-Reply-To: <db7012b2-9156-34ed-ad1f-10a3e5dfe390@loongson.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tzYDufM4KGgTx5jl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 04:37:50PM +0800, Yinbo Zhu wrote:
>=20
>=20
> =E5=9C=A8 2023/8/2 =E4=B8=8B=E5=8D=883:50, Conor Dooley =E5=86=99=E9=81=
=93:
> > On Wed, Aug 02, 2023 at 03:44:17PM +0800, Yinbo Zhu wrote:
> > > =E5=9C=A8 2023/8/2 =E4=B8=8B=E5=8D=883:22, Conor Dooley =E5=86=99=E9=
=81=93:
> > > > On Wed, Aug 02, 2023 at 09:38:34AM +0800, Yinbo Zhu wrote:
> > > > > =E5=9C=A8 2023/8/1 =E4=B8=8B=E5=8D=8811:54, Conor Dooley =E5=86=
=99=E9=81=93:
> > > > > > On Tue, Aug 01, 2023 at 04:34:30PM +0800, Yinbo Zhu wrote:
> >=20
> > > > > > > Sorry, I may not have described it clearly before, the ls2k50=
0 was only
> > > > > > > as a example, actually, Loongson GPIO controllers (2k500,2k10=
00,eg)come
> > > > > > > in multiple variants that are compatible except for certain r=
egister
> > > > > > > offset values.  So above all offset device property was used =
to in all
> > > > > > > loongson gpio controller.
> > > > > >=20
> > > > > > But it would be good to know why they are different. Do they ea=
ch
> > > > > > support some different features, or was there some other reason=
 for
> > > > > > making controllers like this?
> > > > >=20
> > > > >=20
> > > > > There are no other reasons, just differences in these offset addr=
esses.
> > > >=20
> > > > Huh. Do you have a link to a devicetree for the ls2k500?
> > >=20
> > >=20
> > > Yes,  there was a link about ls2k500 dts,  but that ls2k500 dts has n=
ot
> > > yet added a gpio node.  this gpio node will be added later.
> >=20
> > You must have something that you used to test with, no? I don't mind if
> > it is not a patch, but rather is some WIP - I'd just like to see user of
> > the binding :)
>=20
>=20
> yes, I have a test, for 2k0500, that gpio dts as follows:
>=20
>                 gpio0:gpio@0x1fe10430 {
>                         compatible =3D "loongson,ls2k-gpio";
>                         reg =3D <0 0x1fe10430 0 0x20>;
>                         gpio-controller;
>                         #gpio-cells =3D <2>;
> 			interrupt-parent =3D <&liointc1>;
>                         ngpios =3D <64>;
>                         loongson,gpio-conf-offset =3D <0>;
>                         loongson,gpio-out-offset =3D <0x10>;
>                         loongson,gpio-in-offset =3D <0x8>;
>                         loongson,gpio-inten-offset =3D <0xb0>;
> 			loongson,gpio-ctrl-mode =3D <0x0>;
>                         ...
> 		  }
>=20
>                 gpio1:gpio@0x1fe10450 {
>                         compatible =3D "loongson,ls2k-gpio";
>                         reg =3D <0 0x1fe10450 0 0x20>;
>                         gpio-controller;
>                         #gpio-cells =3D <2>;
> 			interrupt-parent =3D <&liointc1>;
>                         ngpios =3D <64>;
>                         loongson,gpio-conf-offset =3D <0>;
>                         loongson,gpio-out-offset =3D <0x10>;
>                         loongson,gpio-in-offset =3D <0x8>;

These 3 are the same for both controllers, no?
Is only the inten-offset a variable?

>                         loongson,gpio-inten-offset =3D <0x98>;

These offsets exceed the region that you've got in the reg property for
this controller, do they not?

Is there some sort of "miscellaneous register area" at 0x1FE104E0, or
just those two interrupt registers and nothing else?

--tzYDufM4KGgTx5jl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMp37AAKCRB4tDGHoIJi
0iHMAQDTa52gx5TT3cVQ7/cQ116wdnoRU3huqfv/nqbEaIybaAEAzU44uXj4URMn
w3xmcvVpD3/n+tko34IORIGLDpsJvgM=
=f+BI
-----END PGP SIGNATURE-----

--tzYDufM4KGgTx5jl--
