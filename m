Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F7976E043
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjHCGbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjHCGbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:31:42 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C89E7D;
        Wed,  2 Aug 2023 23:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691044301; x=1722580301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qFKr8bkFiCSUT8gGs1rqFHXGm44qmaw6Qe7PkE1fKq8=;
  b=BTMAWzDY7cy20yafNRxa7+Z8l7Rxj17yWl5eLG3lBXtG3kaN3Zngb/lu
   /Vz9q7FXilKG0qTAawTBOR78nE5WGiN9Wj8tGN9fz8VsvxybtdaZja+Md
   GNkJ1hMAaCVz5pTeqVfjEdCQVo0EGhsfC1ewIKqmbE48WW/ymR8e1qqGk
   MPDMXX2Sj5aDheC0RZWpIWTDa+myaL69hFXun5Y0/bBNofqf0ftO5XlaG
   jqmv/qWJDJmAeg3tOrXM6qgn/Xx+lHRmKHchRkaF3x9cCNpwokhlethFj
   Jp6pr8ohmkgUc7tFr3DiFWIXgMrGMuKpxfTMJOizkQKgUfKs7wC6gTYDj
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="asc'?scan'208";a="239517581"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2023 23:31:32 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 2 Aug 2023 23:31:32 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 2 Aug 2023 23:31:29 -0700
Date:   Thu, 3 Aug 2023 07:30:53 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
CC:     Conor Dooley <conor@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Jianmin Lv <lvjianmin@loongson.cn>,
        <wanghongliang@loongson.cn>, Liu Peibao <liupeibao@loongson.cn>,
        <loongson-kernel@lists.loongnix.cn>
Subject: Re: [PATCH v2 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
Message-ID: <20230803-tartar-tainted-968687047460@wendy>
References: <20230801-whenever-imitation-b2759b212f6b@spud>
 <a5c27913-2a88-d376-0130-22ca8a3d4516@loongson.cn>
 <20230801-varsity-chemo-09cc5e250ded@spud>
 <26adb487-f8c5-9cf4-5b31-070e9161e761@loongson.cn>
 <20230802-jailer-pavilion-84fb17bb3710@wendy>
 <3534f7b9-0e02-28c1-238a-5a6fdbb95e94@loongson.cn>
 <20230802-bunkbed-siamese-57ee53bdf273@wendy>
 <db7012b2-9156-34ed-ad1f-10a3e5dfe390@loongson.cn>
 <20230802-empathy-wound-70df4990a976@spud>
 <ae74e7b0-26ae-5707-7b85-5dcf733d2bed@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="A/1BXil6Lt50okRB"
Content-Disposition: inline
In-Reply-To: <ae74e7b0-26ae-5707-7b85-5dcf733d2bed@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--A/1BXil6Lt50okRB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 03, 2023 at 09:56:02AM +0800, Yinbo Zhu wrote:
>=20
>=20
> =E5=9C=A8 2023/8/2 =E4=B8=8B=E5=8D=8811:36, Conor Dooley =E5=86=99=E9=81=
=93:
> > On Wed, Aug 02, 2023 at 04:37:50PM +0800, Yinbo Zhu wrote:
> > >=20
> > >=20
> > > =E5=9C=A8 2023/8/2 =E4=B8=8B=E5=8D=883:50, Conor Dooley =E5=86=99=E9=
=81=93:
> > > > On Wed, Aug 02, 2023 at 03:44:17PM +0800, Yinbo Zhu wrote:
> > > > > =E5=9C=A8 2023/8/2 =E4=B8=8B=E5=8D=883:22, Conor Dooley =E5=86=99=
=E9=81=93:
> > > > > > On Wed, Aug 02, 2023 at 09:38:34AM +0800, Yinbo Zhu wrote:
> > > > > > > =E5=9C=A8 2023/8/1 =E4=B8=8B=E5=8D=8811:54, Conor Dooley =E5=
=86=99=E9=81=93:
> > > > > > > > On Tue, Aug 01, 2023 at 04:34:30PM +0800, Yinbo Zhu wrote:
> > > >=20
> > > > > > > > > Sorry, I may not have described it clearly before, the ls=
2k500 was only
> > > > > > > > > as a example, actually, Loongson GPIO controllers (2k500,=
2k1000,eg)come
> > > > > > > > > in multiple variants that are compatible except for certa=
in register
> > > > > > > > > offset values.  So above all offset device property was u=
sed to in all
> > > > > > > > > loongson gpio controller.
> > > > > > > >=20
> > > > > > > > But it would be good to know why they are different. Do the=
y each
> > > > > > > > support some different features, or was there some other re=
ason for
> > > > > > > > making controllers like this?
> > > > > > >=20
> > > > > > >=20
> > > > > > > There are no other reasons, just differences in these offset =
addresses.
> > > > > >=20
> > > > > > Huh. Do you have a link to a devicetree for the ls2k500?
> > > > >=20
> > > > >=20
> > > > > Yes,  there was a link about ls2k500 dts,  but that ls2k500 dts h=
as not
> > > > > yet added a gpio node.  this gpio node will be added later.
> > > >=20
> > > > You must have something that you used to test with, no? I don't min=
d if
> > > > it is not a patch, but rather is some WIP - I'd just like to see us=
er of
> > > > the binding :)
> > >=20
> > >=20
> > > yes, I have a test, for 2k0500, that gpio dts as follows:
> > >=20
> > >                  gpio0:gpio@0x1fe10430 {
> > >                          compatible =3D "loongson,ls2k-gpio";
> > >                          reg =3D <0 0x1fe10430 0 0x20>;
> > >                          gpio-controller;
> > >                          #gpio-cells =3D <2>;
> > > 			interrupt-parent =3D <&liointc1>;
> > >                          ngpios =3D <64>;
> > >                          loongson,gpio-conf-offset =3D <0>;
> > >                          loongson,gpio-out-offset =3D <0x10>;
> > >                          loongson,gpio-in-offset =3D <0x8>;
> > >                          loongson,gpio-inten-offset =3D <0xb0>;
> > > 			loongson,gpio-ctrl-mode =3D <0x0>;
> > >                          ...
> > > 		  }
> > >=20
> > >                  gpio1:gpio@0x1fe10450 {
> > >                          compatible =3D "loongson,ls2k-gpio";
> > >                          reg =3D <0 0x1fe10450 0 0x20>;
> > >                          gpio-controller;
> > >                          #gpio-cells =3D <2>;
> > > 			interrupt-parent =3D <&liointc1>;
> > >                          ngpios =3D <64>;
> > >                          loongson,gpio-conf-offset =3D <0>;
> > >                          loongson,gpio-out-offset =3D <0x10>;
> > >                          loongson,gpio-in-offset =3D <0x8>;
> >=20
> > These 3 are the same for both controllers, no?
> > Is only the inten-offset a variable?
> >=20
> > >                          loongson,gpio-inten-offset =3D <0x98>;
> >=20
> > These offsets exceed the region that you've got in the reg property for
> > this controller, do they not?
> >=20
> > Is there some sort of "miscellaneous register area" at 0x1FE104E0, or
> > just those two interrupt registers and nothing else?
>=20
>=20
> 2k500 gpio dts is just an example, like 3a5000, or more other platform,
> above offset was different but the gpio controller was compatible.
>=20
>                 gpio: gpio@1fe00500 {
>                         compatible =3D "loongson,ls2k-gpio";
>                         reg =3D <0 0x1fe00500 0xc00>;
>                         gpio-controller;
>                         #gpio-cells =3D <2>;
>                         ngpios =3D <16>;
>                         loongson,gpio-conf-offset =3D <0x0>;
>                         loongson,gpio-out-offset =3D <0x8>;
>                         loongson,gpio-in-offset =3D <0xc>;
> 			...
> 			}

That is a different SoC and needs to have a different compatible string.
"loongson,ls2k-foo" compatible strings were a mistake that only got past
us because we were not aware it was a family, rather than a specific
SoC. They certainly should not be used in isolation on a 3a5000!

Are there more than one GPIO controllers on the 3a5000? If so, what do
those nodes look like.

--A/1BXil6Lt50okRB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMtJnQAKCRB4tDGHoIJi
0kArAQD+rcB68+jpAIMJJa1aB+J6gS04M+ayrxBbtIq8BEWAdAD/Y1jWeY6UKWZi
+L8XL7pSx3kOGm4iKgxgX2qN44GPpQc=
=mz4d
-----END PGP SIGNATURE-----

--A/1BXil6Lt50okRB--
