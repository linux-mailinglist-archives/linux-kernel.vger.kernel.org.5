Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D5E766A03
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:15:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbjG1KPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbjG1KPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:15:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AE73A8C;
        Fri, 28 Jul 2023 03:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690539299; x=1722075299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2Y1RwJe5SvO00BHqB2fl57z6OWd7GWBq/2G+78g04Ys=;
  b=F1M0ZmpUkd2xMNJRLbIELPAE62kW3P7FHj0LZPmL6XmnTbd5PVBgjnrs
   r2cHx+H70/epDefndGtjVPeHc7UWP1kix+2q6ZQktSuCRcTxAs2HoCGki
   xmAywaIHl80zLDQH5GUHcHmO05pCw7JzxZWeVN5cy9ewaMV9XYHqgawKA
   P85hnYsZqn5S6c+2Qz59P2zcQZrisj+LOF0LvzSJEPzpHhgitjdhbQ70r
   zCyNWQdB1Q68yiT4tqAdpi1HKnIRxSwgrkmRgdSPkSaKngH7y//zd9A8F
   S3oOsd3x4z0vuMhhyLOWon1z7ir1SOX0IAf+2LXOyTWg5pxphtdMnnuKL
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="asc'?scan'208";a="163711690"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 03:14:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 03:14:52 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Fri, 28 Jul 2023 03:14:49 -0700
Date:   Fri, 28 Jul 2023 11:14:14 +0100
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
Message-ID: <20230728-overview-suitor-b54b5f27389f@wendy>
References: <20230728074944.26746-1-zhuyinbo@loongson.cn>
 <74a37e9d.9a24.1899b9bea85.Coremail.chenhuacai@loongson.cn>
 <1c8b12b4-79c3-5018-c7df-946fe690e8c8@linaro.org>
 <20230728-pessimism-exclaim-de0dd7f4bb64@wendy>
 <7986a634-63b2-28d6-5f17-7b982ae56bcf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zsU3D00B1ldVVR3H"
Content-Disposition: inline
In-Reply-To: <7986a634-63b2-28d6-5f17-7b982ae56bcf@linaro.org>
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

--zsU3D00B1ldVVR3H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2023 at 11:45:48AM +0200, Krzysztof Kozlowski wrote:
> On 28/07/2023 11:18, Conor Dooley wrote:
> > On Fri, Jul 28, 2023 at 10:36:42AM +0200, Krzysztof Kozlowski wrote:

> >> Are we intended person/entities to receive your Reviewed-by tag?
> >=20
> > It's okay, you only got a "Reviewd-by" tag ;)
>=20
> I guess so, especially that this disclaimer should be useless. But on
> the other hand, do I want to deal with it if once Loongson sends me
> Cease-and-desist letter for something? Why even thinking about this
> should be my problem? Why should I even consider this topic: is it
> harmless or is there any risk?

Oh for sure complain. My corp email is not in the CC, but it arrived in
my inbox there...
I was just noting that the tag was not correctly provided in the first
place.

--zsU3D00B1ldVVR3H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMOU9gAKCRB4tDGHoIJi
0kJGAP4pIpuIY7agqW8Bqh7t11MHx+nP+lWKCwDBB4GVve76mgEA9NdSi8m8r//J
pOXLWY0SEHeXTFqjSWKy3zue4Y5l0gA=
=LrWr
-----END PGP SIGNATURE-----

--zsU3D00B1ldVVR3H--
