Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5B987F5B9F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjKWJrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:47:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjKWJrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:47:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935F4D41;
        Thu, 23 Nov 2023 01:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700732869; x=1732268869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1PBhagH7/vOdhd9ZeQlcwBuZIBpOl+fh5UyFzBiP084=;
  b=JR3wNOy4r+Xp6kQzKuVPFIA9GgHJpgNgMOUaoiyjJwLvkBgkMB+KGAqa
   //+6/bGD2/738d/BPpBCJ4mnRAHfb1UfPfjWR4hY5z+qCBnV9RDv5OXFZ
   /IISL9GTzTKuMZE3mziawSINy99kSlFPyVJwO+sxOnCTb3P+EPSCaOMhQ
   3a5TdhxX369BTIbQIHF3jqWEFHNTIXFFf03tq08Eisfm4Yr07pcXrxNBn
   FZ72alEoprS56LOpn83ChhzAWT16HnHsUE0y5BXsr+UMOf6vf4y0HvRzx
   nae/ROlnZnSzoQDNEGsb7Au/IgjswS3AX1rhlv6tetyoRj3Mx9f73a6Zs
   A==;
X-CSE-ConnectionGUID: bmtvjieoQui/t8rcBiXjvg==
X-CSE-MsgGUID: VvY/zu3aQaWWYzr2ptuE+A==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="asc'?scan'208";a="12184225"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 02:47:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Nov 2023 02:47:34 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 23 Nov 2023 02:47:31 -0700
Date:   Thu, 23 Nov 2023 09:47:03 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Conor Dooley <conor@kernel.org>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-samsung-soc@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] kbuild: Per arch/platform dtc warning levels
Message-ID: <20231123-sugar-aviator-337b290f899b@wendy>
References: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TlOjZ7bCqwxiOxdz"
Content-Disposition: inline
In-Reply-To: <20231122-dtc-warnings-v2-0-bd4087325392@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--TlOjZ7bCqwxiOxdz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 03:12:31PM -0700, Rob Herring wrote:
> This series adds support to set the dtc extra warning level on a per=20
> arch or per platform (directory really) basis.
>=20
> The first version of this was just a simple per directory override for=20
> Samsung platforms, but Conor asked to be able to do this for all of=20
> riscv.
>=20
> For merging, either I can take the whole thing or the riscv and samsung=
=20
> patches can go via their normal trees. The added variable will have no=20
> effect until merged with patch 2.

IMO, you should take the lot.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--TlOjZ7bCqwxiOxdz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV8flwAKCRB4tDGHoIJi
0gy+AP42cyrUTh4NL4eY8kIwsVmx5LejeoA0QZDYa85yy0PBgQD9EGKZIEXssWsj
vX2Y6dIUhPn8qia5tz+YByAjUriTEAE=
=2rQT
-----END PGP SIGNATURE-----

--TlOjZ7bCqwxiOxdz--
