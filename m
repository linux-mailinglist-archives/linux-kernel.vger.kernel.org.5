Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F96880CAAE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 14:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343618AbjLKNUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 08:20:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234350AbjLKNUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 08:20:03 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7939F;
        Mon, 11 Dec 2023 05:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702300810; x=1733836810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aWWmxlxn0pM8okQkL2E4L7uqb6CIH81faOxCrpqcrJA=;
  b=niDr1jyMnM8fxPIExSw0MLoYWMgZ1bP5Z1DdDrwGsvKwsrQoUY6kwt/h
   Dzvv7QAS2sYbU5gwtmtApf5MwXFGUwSMB1aQ1qsI3BG4fV55pIJAQpiHz
   /lMRNTVH9/zA3N6N4CNmf8Pl57zmeMbn7bFRvEaJr+pdAhUnrhzmF3uC8
   NudGdn6lbMBcwmQlWEZfSarIClLCcWS5KaRc2/9t3Hm/ob0LS5ejpMPlG
   y5WbJ7hKyl0p0YnJNojWisD413RQfAi8llM/9vlKEdtJ3f1QM3Y/FpgAi
   C+9uxf5P+2roclkO5toj7IG6cNSIZa4YXNSq766DFJb0Yg6nk+e/W+EsY
   A==;
X-CSE-ConnectionGUID: gPfR+rluR3a0j2IyXO7vGQ==
X-CSE-MsgGUID: YZcXyw1DSgOOmSXR8rHP3w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="asc'?scan'208";a="180278630"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2023 06:20:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 06:19:48 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Dec 2023 06:19:47 -0700
Date:   Mon, 11 Dec 2023 13:19:17 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Kuan-Wei Chiu <visitorckw@gmail.com>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <duje.mihanovic@skole.hr>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: mmp: pxa168: Fix memory leak in pxa168_clk_init()
Message-ID: <20231211-urgent-carol-45ca352a9d2a@wendy>
References: <20231210175232.3414584-1-visitorckw@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vwICD4jSZexuFxQq"
Content-Disposition: inline
In-Reply-To: <20231210175232.3414584-1-visitorckw@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--vwICD4jSZexuFxQq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 01:52:32AM +0800, Kuan-Wei Chiu wrote:
> In cases where mapping of mpmu/apmu/apbc registers fails, the code path
> does not handle the failure gracefully, potentially leading to a memory
> leak. This fix ensures proper cleanup by freeing the allocated memory
> for 'pxa_unit' before returning.
>=20
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

I dunno why you have CCed me on this tbh, I guess I must have acked a
patch related to this driver's bindings somehow.

I wonder, is there actually any point in freeing these, isn't the system
going to fail to actually boot if these allocations fail?

> ---
>  drivers/clk/mmp/clk-of-pxa168.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/clk/mmp/clk-of-pxa168.c b/drivers/clk/mmp/clk-of-pxa=
168.c
> index fb0df64cf053..c5a7ba1deaa3 100644
> --- a/drivers/clk/mmp/clk-of-pxa168.c
> +++ b/drivers/clk/mmp/clk-of-pxa168.c
> @@ -308,18 +308,21 @@ static void __init pxa168_clk_init(struct device_no=
de *np)
>  	pxa_unit->mpmu_base =3D of_iomap(np, 0);
>  	if (!pxa_unit->mpmu_base) {
>  		pr_err("failed to map mpmu registers\n");
> +		kfree(pxa_unit);
>  		return;
>  	}
> =20
>  	pxa_unit->apmu_base =3D of_iomap(np, 1);
>  	if (!pxa_unit->apmu_base) {
>  		pr_err("failed to map apmu registers\n");
> +		kfree(pxa_unit);
>  		return;
>  	}
> =20
>  	pxa_unit->apbc_base =3D of_iomap(np, 2);
>  	if (!pxa_unit->apbc_base) {
>  		pr_err("failed to map apbc registers\n");
> +		kfree(pxa_unit);
>  		return;
>  	}
> =20
> --=20
> 2.25.1
>=20

--vwICD4jSZexuFxQq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXcMVAAKCRB4tDGHoIJi
0npnAQDhMi0sOhFCb2XK8e4LHbB01fNeeAnX29yOGRmSBgkI6QD/RL448S6rMuJr
psmgLu7PXSxRaa4u79WAnL996jASxQY=
=0YJF
-----END PGP SIGNATURE-----

--vwICD4jSZexuFxQq--
