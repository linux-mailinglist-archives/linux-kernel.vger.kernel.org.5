Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A0B76C6B3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232847AbjHBHXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbjHBHXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:23:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095CCE4C;
        Wed,  2 Aug 2023 00:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690960982; x=1722496982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7eFksLTYa9RuHQo4s+zL32kwqkynVdyzZ5o/ofGIt/c=;
  b=Y1ChgCtyYHPpyvA3fbvxiG0i3ox+NDLGMv4GSH1eUbrPhhlxqB6Kjbju
   45XQnyrKGNwyiZF2KUT065iIaZvD8HjtPHIJPCs7MBpJC7TVSQRkQ0SWL
   gGRCCaFhqlgHddTvwTvQpp5LyRqD2kf9KnvMf46QytFH/66xHGMLS2RWz
   31LRnt4KeTIMPmAYH+AXyIuksxA3keMPMTsapNWxStZ+oSvtKI67be1pT
   sIXpJYDmqka2PCsyRxE91Q6gXdMRhn9FGjhtjxyqcxV21D9uryKqDSjp7
   /pjJkW6pPE5GbNxVRhXexU0hGwAS9q0+S19V0Fuc087k3OH3MA1ykG93g
   g==;
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="asc'?scan'208";a="239300202"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2023 00:22:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 2 Aug 2023 00:22:49 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 2 Aug 2023 00:22:46 -0700
Date:   Wed, 2 Aug 2023 08:22:10 +0100
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
Message-ID: <20230802-jailer-pavilion-84fb17bb3710@wendy>
References: <20230731091059.17323-1-zhuyinbo@loongson.cn>
 <20230731091059.17323-2-zhuyinbo@loongson.cn>
 <20230731-setback-such-61815ee3ef51@spud>
 <041bf8a6-8d91-c2ce-6752-aa7255f946c7@loongson.cn>
 <20230801-whenever-imitation-b2759b212f6b@spud>
 <a5c27913-2a88-d376-0130-22ca8a3d4516@loongson.cn>
 <20230801-varsity-chemo-09cc5e250ded@spud>
 <26adb487-f8c5-9cf4-5b31-070e9161e761@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TdgctVrcqP1F3jZi"
Content-Disposition: inline
In-Reply-To: <26adb487-f8c5-9cf4-5b31-070e9161e761@loongson.cn>
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

--TdgctVrcqP1F3jZi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 09:38:34AM +0800, Yinbo Zhu wrote:
>=20
>=20
> =E5=9C=A8 2023/8/1 =E4=B8=8B=E5=8D=8811:54, Conor Dooley =E5=86=99=E9=81=
=93:
> > On Tue, Aug 01, 2023 at 04:34:30PM +0800, Yinbo Zhu wrote:
> > >=20
> > >=20
> > > =E5=9C=A8 2023/8/1 =E4=B8=8B=E5=8D=883:23, Conor Dooley =E5=86=99=E9=
=81=93:
> > > > On Tue, Aug 01, 2023 at 02:39:49PM +0800, Yinbo Zhu wrote:
> > > > >=20
> > > > >=20
> > > > > =E5=9C=A8 2023/7/31 =E4=B8=8B=E5=8D=8811:55, Conor Dooley =E5=86=
=99=E9=81=93:
> > > > > > On Mon, Jul 31, 2023 at 05:10:58PM +0800, Yinbo Zhu wrote:
> > > > > > > Add parsing GPIO configure, input, output, interrupt register=
 offset
> > > > > > > address and GPIO control mode support.
> > > > > >=20
> > > > > > This reeks of insufficient use of SoC specific compatibles. Do =
GPIO
> > > > > > controllers on the same SoC have different register offsets?
> > > > >=20
> > > > >=20
> > > > > Yes,
> > > > >=20
> > > > > > Where are the users for this?
> > > > >=20
> > > > >=20
> > > > > For example, ls2k500 contains multiple GPIO chips with different
> > > > > (configure, input, output, interrupt) offset addresses, but all o=
thers
> > > > > are the same.
> > > >=20
> > > > Right. That's admittedly not what I expected to hear! Can you first=
ly
> > > > explain this in the commit message,
> > >=20
> > >=20
> > > I will add following explain in the commit message. Do you think it's
> > > suitable?
> > >=20
> > > Loongson GPIO controllers come in multiple variants that are compatib=
le
> > > except for certain register offset values.  Add support in yaml file =
for
> > > device properties allowing to specify them in DT.
> >=20
> > Sure, that would be helpful.
> >=20
> > > > and secondly add a soc-specific
> > > > compatible for the ls2k500 and only allow these properties on that =
SoC?
> >=20
> > > Sorry, I may not have described it clearly before, the ls2k500 was on=
ly
> > > as a example, actually, Loongson GPIO controllers (2k500,2k1000,eg)co=
me
> > > in multiple variants that are compatible except for certain register
> > > offset values.  So above all offset device property was used to in all
> > > loongson gpio controller.
> >=20
> > But it would be good to know why they are different. Do they each
> > support some different features, or was there some other reason for
> > making controllers like this?
>=20
>=20
> There are no other reasons, just differences in these offset addresses.

Huh. Do you have a link to a devicetree for the ls2k500?

--TdgctVrcqP1F3jZi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMoEIgAKCRB4tDGHoIJi
0qehAQD/TED1c6/DUFPI/gFo3nDFxCZVNRgFga8JtpLMIN0aCQEA77DxWD0/baeB
r37YpCJXTvTMBnMSocT4alLPP0WzNQA=
=O4O8
-----END PGP SIGNATURE-----

--TdgctVrcqP1F3jZi--
