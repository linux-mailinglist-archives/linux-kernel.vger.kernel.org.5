Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74DBF76C789
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjHBHyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjHBHxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:53:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D464C05;
        Wed,  2 Aug 2023 00:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690962692; x=1722498692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WRznruv5XtfnHSPYkYTAeVfDLfQIl7nTklBHjjn6qnA=;
  b=gCsJc8JpAB2m+EOXTEbv7UlXjxG1eIPQuHhGPTIKu+BNiEixokHU3Wl8
   ZFeKSjf3kK5BfseC6/977G+wuhJy4v1mVQ1pD27jGNB6FrJeVA2iOYq0h
   7p11dnnwdxOXQlX5dyVVp0eMkH4yJ3o1PBsaUrjKXMbvkxtuqee89Mwaj
   K0twyCkru2ZCX93DX50vPsaLW0hC29woWi/QBPOnN2j3yksFAohqCK8yD
   NbJ75GHDyBLaGRFnJieX2jH0C2SsQ9lnIBeq64L5+cCpvYNcJeohd74nu
   V9m+fxDIMZKOyWInUbPhSCoOkm5jYPnYndl3MyNfKN0k4vta6kYP8UpsH
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="asc'?scan'208";a="227527333"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2023 00:51:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 2 Aug 2023 00:51:24 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 2 Aug 2023 00:51:21 -0700
Date:   Wed, 2 Aug 2023 08:50:45 +0100
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
Message-ID: <20230802-bunkbed-siamese-57ee53bdf273@wendy>
References: <20230731091059.17323-1-zhuyinbo@loongson.cn>
 <20230731091059.17323-2-zhuyinbo@loongson.cn>
 <20230731-setback-such-61815ee3ef51@spud>
 <041bf8a6-8d91-c2ce-6752-aa7255f946c7@loongson.cn>
 <20230801-whenever-imitation-b2759b212f6b@spud>
 <a5c27913-2a88-d376-0130-22ca8a3d4516@loongson.cn>
 <20230801-varsity-chemo-09cc5e250ded@spud>
 <26adb487-f8c5-9cf4-5b31-070e9161e761@loongson.cn>
 <20230802-jailer-pavilion-84fb17bb3710@wendy>
 <3534f7b9-0e02-28c1-238a-5a6fdbb95e94@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ikEIosViUus19T29"
Content-Disposition: inline
In-Reply-To: <3534f7b9-0e02-28c1-238a-5a6fdbb95e94@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ikEIosViUus19T29
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 03:44:17PM +0800, Yinbo Zhu wrote:
> =E5=9C=A8 2023/8/2 =E4=B8=8B=E5=8D=883:22, Conor Dooley =E5=86=99=E9=81=
=93:
> > On Wed, Aug 02, 2023 at 09:38:34AM +0800, Yinbo Zhu wrote:
> > > =E5=9C=A8 2023/8/1 =E4=B8=8B=E5=8D=8811:54, Conor Dooley =E5=86=99=E9=
=81=93:
> > > > On Tue, Aug 01, 2023 at 04:34:30PM +0800, Yinbo Zhu wrote:

> > > > > Sorry, I may not have described it clearly before, the ls2k500 wa=
s only
> > > > > as a example, actually, Loongson GPIO controllers (2k500,2k1000,e=
g)come
> > > > > in multiple variants that are compatible except for certain regis=
ter
> > > > > offset values.  So above all offset device property was used to i=
n all
> > > > > loongson gpio controller.
> > > >=20
> > > > But it would be good to know why they are different. Do they each
> > > > support some different features, or was there some other reason for
> > > > making controllers like this?
> > >=20
> > >=20
> > > There are no other reasons, just differences in these offset addresse=
s.
> >=20
> > Huh. Do you have a link to a devicetree for the ls2k500?
>=20
>=20
> Yes,  there was a link about ls2k500 dts,  but that ls2k500 dts has not
> yet added a gpio node.  this gpio node will be added later.

You must have something that you used to test with, no? I don't mind if
it is not a patch, but rather is some WIP - I'd just like to see user of
the binding :)

--ikEIosViUus19T29
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMoK1QAKCRB4tDGHoIJi
0jQ/AP0cmoPcj1H6I49kVdT/0oQnmBeiVzppEkfEuCCF+ussCAEA/TawwZ9PDGww
u3dNw7OqaSxFjljTyZw+GYpISME5yAE=
=T3ma
-----END PGP SIGNATURE-----

--ikEIosViUus19T29--
