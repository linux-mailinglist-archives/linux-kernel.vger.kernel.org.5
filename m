Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73B297B00E9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjI0Jt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbjI0JtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:49:10 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9480CCA;
        Wed, 27 Sep 2023 02:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695808139; x=1727344139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oj/BIJaPlLOZ5a4Bm+3wRDEKMjmwS+415AzmToQmxko=;
  b=GjxvRm8fpvmHDF2G23csv+Moo5B6jaBJSrMFVUlYOQWb69dMLmU8lJ0O
   B6ldDfwrq9m7tO1Kmaz/MaytdEl4UnvU/wag03Vvghm0D8b+lDThTAQzm
   XbpJ9eyqoTh9FNyu2egBRbX5faiWeP0Og+A7Giq/22n2Hz9BbIRGzxDlX
   J269/0Zuosr3FtmhfGZchrWmkYu84aD4KY/3T4cEQUkrnHispEmkJ9FVX
   UQPxDw5r6ePtRWKEkPqrqS6VwrDsWbX2Vtz2T13Tjbq7X0mqffU/bdrIT
   dYlZqnLB3nTeTygE+DuIcl2d0tCl2eziMJadYn6dKPeDZEO7QBVj7HKkl
   w==;
X-CSE-ConnectionGUID: +8y/5vKTQAWpUgUoFVJWOw==
X-CSE-MsgGUID: FCeDeZE/SGCJlrPGv/SrHA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="asc'?scan'208";a="173847249"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Sep 2023 02:48:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 27 Sep 2023 02:48:03 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 27 Sep 2023 02:48:00 -0700
Date:   Wed, 27 Sep 2023 10:47:42 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Moudy Ho =?utf-8?B?KOS9leWul+WOnyk=?= <Moudy.Ho@mediatek.com>
CC:     "conor@kernel.org" <conor@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v6 12/16] dt-bindings: display: mediatek: color: add
 compatible for MT8195
Message-ID: <20230927-crunching-prancing-36fe3eb79607@wendy>
References: <20230922072116.11009-1-moudy.ho@mediatek.com>
 <20230922072116.11009-13-moudy.ho@mediatek.com>
 <20230922-zebra-modify-87ff23c70bb3@spud>
 <20230922-overhung-deception-e9b461ba0372@spud>
 <7c445195e17e15d5af5fcb30ae53f76c713e958b.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T9lGne2QQapOBRac"
Content-Disposition: inline
In-Reply-To: <7c445195e17e15d5af5fcb30ae53f76c713e958b.camel@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--T9lGne2QQapOBRac
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 27, 2023 at 07:19:28AM +0000, Moudy Ho (=E4=BD=95=E5=AE=97=E5=
=8E=9F) wrote:
> On Fri, 2023-09-22 at 16:51 +0100, Conor Dooley wrote:
> > On Fri, Sep 22, 2023 at 04:49:14PM +0100, Conor Dooley wrote:
> > > On Fri, Sep 22, 2023 at 03:21:12PM +0800, Moudy Ho wrote:
> > > > Add a compatible string for the COLOR block in MediaTek MT8195
> > > > that
> > > > is controlled by MDP3.
> > > >=20
> > > > Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
> > > > ---
> > > >  .../devicetree/bindings/display/mediatek/mediatek,color.yaml   =20
> > > >  | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/display/mediatek/mediatek,col
> > > > or.yaml
> > > > b/Documentation/devicetree/bindings/display/mediatek/mediatek,col
> > > > or.yaml
> > > > index f21e44092043..b886ca0d89ea 100644
> > > > ---
> > > > a/Documentation/devicetree/bindings/display/mediatek/mediatek,col
> > > > or.yaml
> > > > +++
> > > > b/Documentation/devicetree/bindings/display/mediatek/mediatek,col
> > > > or.yaml
> > > > @@ -26,6 +26,7 @@ properties:
> > > >            - mediatek,mt2701-disp-color
> > > >            - mediatek,mt8167-disp-color
> > > >            - mediatek,mt8173-disp-color
> > > > +          - mediatek,mt8195-mdp3-color
> > >=20
> > > How come this one is a "mdp3" not a "disp"?
> >=20
> > I don't know what mdp3 means & googling gives me no answers. What's
> > the
> > "disp" one controlled by, since it isn't controlled by mdp3?
> >=20
>=20
> Hi Conor,
>=20
> Mediatek's Media Data Path ver.3 (MDP3) is associated with MMSYS and
> acts as an independent driver that operates between VDEC and DISP.
> By controlling multiple components, it carries out tasks like
> converting color formats, resizing, and applying specific Picture
> Quality (PQ) effects.
> The driver can be found at "driver/media/platform/mediatek/mdp3".
> Since the same hardware components are configured in both MDP3 and
> DISP, considering previous discussions, I attemped to integrate into a
> single binding, named after the controlling user.

I'm still kinda struggling to understand this. Do you mean that the
hardware can be controlled by either of the disp and mdp3 drivers, and
a compatible containing "disp" would use one driver, and one containing
"mdp3" would use another?


--T9lGne2QQapOBRac
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZRP6PgAKCRB4tDGHoIJi
0kh7AP9O7MKYjrnar798S6fbop9AWuqH31/FShl/0JtdCf2N/wD/R/G17q/VHosy
cmzXFHme+vk2cMO0cR0geJwglqggtQo=
=5FSm
-----END PGP SIGNATURE-----

--T9lGne2QQapOBRac--
