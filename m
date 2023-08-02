Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F003876C5FE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 08:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjHBG7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 02:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjHBG7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 02:59:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B026710E;
        Tue,  1 Aug 2023 23:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690959546; x=1722495546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1VOVjYDQD8/gz+/pZmZ6WnPy9qqNJ4oQN6mKmeNp/84=;
  b=a/DP8Y6M0mAdbQEYVYFd0eE/fi7LS0BmZwLtQqGWLQ8jL9khRIR/fFzz
   4XFm04vK+ihgwGHMijnollMrYuKKX8I4zKB+LX7VuMtRnyBKGzKuGljME
   vO1X4WpXn6P11wx2N4UTI9nMYMa6x9wmxMMBZuG26Veq42fvEf3ZBQ+21
   tzfOBXg7+zIz5nb2G7Ckzj5tmnhzaNBWaFm2D7ILJZl5TRLLA3RqZ5uGk
   Idlvp8BEuDUbJbzuugFl2wcc2zZPZuwB6PjfGHVjVrPDqTzIEeOuyLjCW
   hlrr0v4srUez5sBxw3lxgEy5G3TxAnHmelfn2h9nrER4Qk1jYGjCi0pxA
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="asc'?scan'208";a="227517769"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Aug 2023 23:59:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 1 Aug 2023 23:58:50 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 1 Aug 2023 23:58:47 -0700
Date:   Wed, 2 Aug 2023 07:58:12 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
CC:     Conor Dooley <conor@kernel.org>,
        "Ng, Adrian Ho Yin" <adrian.ho.yin.ng@intel.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Turquette, Mike" <mturquette@baylibre.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "wen.ping.teh@intel.com" <wen.ping.teh@intel.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: clock: add Intel Agilex5 clock
 manager
Message-ID: <20230802-untreated-twice-932a7afbacfc@wendy>
References: <20230618132235.728641-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-1-niravkumar.l.rabara@intel.com>
 <20230801010234.792557-4-niravkumar.l.rabara@intel.com>
 <20230801-handball-glorifier-e55d44a2b638@spud>
 <DM6PR11MB3291BD9E538528059D199EBCA20BA@DM6PR11MB3291.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X5cmR5QgCpmYgaum"
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3291BD9E538528059D199EBCA20BA@DM6PR11MB3291.namprd11.prod.outlook.com>
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

--X5cmR5QgCpmYgaum
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 03:06:51AM +0000, Rabara, Niravkumar L wrote:
> > From: Conor Dooley <conor@kernel.org>
> > On Tue, Aug 01, 2023 at 09:02:32AM +0800, niravkumar.l.rabara@intel.com
> > wrote:

> > > +examples:
> >=20
> > > +  # Clock controller node:
> >=20
> > This comment seems utterly pointless.
> > Otherwise this looks okay to me.
> >=20
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > Thanks,
> > Conor.
> >=20
>=20
> Removed in [PATCH v3 3/5].

To be clear, you don't need to send a v3 just for that - I gave you the
reviewed-by after all.


--X5cmR5QgCpmYgaum
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMn+gwAKCRB4tDGHoIJi
0o2/AP4lW8VcXGN8U5mLA1eAOA0nQHnoT7R0w7am8jQclz5I0wEAwXt9GT4Jk4lk
4+Zvf/M6iC4LLdyL8pgZ7CxYU0KI9QM=
=tNAR
-----END PGP SIGNATURE-----

--X5cmR5QgCpmYgaum--
