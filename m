Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578017668C3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbjG1JZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbjG1JZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:25:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C69165B0;
        Fri, 28 Jul 2023 02:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690535973; x=1722071973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u5XPF3Vt1StqQYCIWI5YcWOIyc/PAuKXYiBw4jhm1/A=;
  b=NpE9erayBSSaHi/SvPndUJUenBBfkNnVo5e3AJAd2CZ/XjhGx+YODB/l
   VDzRHEbMSIyl0jg4a2rDRoYK7vS2nsin9g5yg2nwdNxgsswVFaGP09ice
   u0n/qdFK5qHD58I5/+ueeYNtaLlnd2bua/y60sMpIBrZPW5BjOKOTDrL8
   c8Y9TOCmbCxbcBnXKKC/qK2GVOb0aGvzDUg4BnQvMti5EG6uX8Mmvu3q2
   NiGCN/a1DwlQZHhoLVoWm2fcJ8p3rTQEOHwr2/7NqzQHrc9moePXC9WJv
   rH57A7OX/0lXkvRcI1U2iAnfOg+ExXZ511mtndm2FeIvFFZksTE28lXUZ
   w==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="asc'?scan'208";a="226615085"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 02:19:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 02:19:30 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 28 Jul 2023 02:19:27 -0700
Date:   Fri, 28 Jul 2023 10:18:52 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     =?utf-8?B?6ZmI5Y2O5omN?= <chenhuacai@loongson.cn>,
        <loongson-kernel@lists.loongnix.cn>, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        <wanghongliang@loongson.cn>, Liu Peibao <liupeibao@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>, Liu Yun <liuyun@loongson.cn>
Subject: Re: [PATCH v5 0/2] soc: loongson2_pm: add power management support
Message-ID: <20230728-pessimism-exclaim-de0dd7f4bb64@wendy>
References: <20230728074944.26746-1-zhuyinbo@loongson.cn>
 <74a37e9d.9a24.1899b9bea85.Coremail.chenhuacai@loongson.cn>
 <1c8b12b4-79c3-5018-c7df-946fe690e8c8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="523xuRZw0fU82LBP"
Content-Disposition: inline
In-Reply-To: <1c8b12b4-79c3-5018-c7df-946fe690e8c8@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--523xuRZw0fU82LBP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 10:36:42AM +0200, Krzysztof Kozlowski wrote:
> On 28/07/2023 10:27, =E9=99=88=E5=8D=8E=E6=89=8D wrote:
> > Reviewd-by: Huacai Chen <chenhuacai@loongson.cn>
>=20
> ...
>=20
> >=20
> >=20
> > =E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=E5=90=
=AB=E6=9C=89=E9=BE=99=E8=8A=AF=E4=B8=AD=E7=A7=91=E7=9A=84=E5=95=86=E4=B8=9A=
=E7=A7=98=E5=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=
=8F=91=E9=80=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=
=97=E5=87=BA=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=
=E7=A6=81=E6=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=
=BB=BB=E4=BD=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=
=AC=E4=BD=86=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=
=E5=88=86=E5=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E6=88=96=E6=
=95=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=
=84=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=
=E6=82=A8=E9=94=99=E6=94=B6=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=
=82=A8=E7=AB=8B=E5=8D=B3=E7=94=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=
=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=
=E9=82=AE=E4=BB=B6=E3=80=82=20
> > This email and its attachments contain confidential information from Lo=
ongson Technology , which is intended only for the person or entity whose a=
ddress is listed above. Any use of the information contained herein in any =
way (including, but not limited to, total or partial disclosure, reproducti=
on or dissemination) by persons other than the intended recipient(s) is pro=
hibited. If you receive this email in error, please notify the sender by ph=
one or email immediately and delete it.=20
>=20
>=20
> Ooops!
>=20
> Are we intended person/entities to receive your Reviewed-by tag?

It's okay, you only got a "Reviewd-by" tag ;)

> We will
> be using it (total/partial disclosure, reproduction, dissemination).
> People not on To/Cc will also do it and for sure they are not intended
> recipients.
>=20
> Please talk with your IT that such disclaimers in open-source are not
> desired (if not harmful even).


--523xuRZw0fU82LBP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMOH/AAKCRB4tDGHoIJi
0gMjAQCwuOOqioqhXBcVVNNlEUbzvUFOeQosva5CuZ1VI8i2PgD/eYqFU0jIHamT
Ph+ow795RHsFOuI0i+//fT4i05v03Aw=
=OrTB
-----END PGP SIGNATURE-----

--523xuRZw0fU82LBP--
