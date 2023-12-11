Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB8D80C282
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 08:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbjLKH7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 02:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjLKH7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 02:59:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7E4CE;
        Sun, 10 Dec 2023 23:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1702281553; x=1733817553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ahXSbRAJBTiA2MQUihFAGoimJVSEvl5KNWFHCZRfaVs=;
  b=VljjdstAgcTCa8ZUbKfxzceCxbw+Pj7bpi/pu2QD85PMWjOdo2t6D94G
   3n10gzEILG/UvKOwRAp1H3LhmvdfSjeQWXrTbF+qRDS0dqeH+5ATRBYfm
   Si13Zdb8g+lJi/GoelAcjs9wPM7pZ4ltVuAadW1EqzWF/u82iXh6HgA0a
   F6tnOyzC1LqghptQpGLB3cLQ00OMvMKp3+WVTe5++/QNWNpdCaFksjD3W
   Pp2QYZKa+56ehHiofKAUsIFftWvS5HhKlksd1POkBcF3yFHC2IRM5zATe
   MyyLRJ/jh7U4NPm1XN6qeUw2M4yIYzwhqu3NxIgCtC3vJ20xEzSPEhH/R
   w==;
X-CSE-ConnectionGUID: 8UrTKvbkTlm7b+wAo40GdQ==
X-CSE-MsgGUID: /JF1wvFzSLWglB/cfw89gA==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="asc'?scan'208";a="180266216"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Dec 2023 00:59:12 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 00:59:06 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Dec 2023 00:59:02 -0700
Date:   Mon, 11 Dec 2023 07:58:31 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
CC:     Shengyu Qu <wiagn233@outlook.com>,
        "kernel@esmil.dk" <kernel@esmil.dk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "conor@kernel.org" <conor@kernel.org>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        "drew@beagleboard.org" <drew@beagleboard.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>
Subject: Re: [PATCH v3 6/6] riscv: dts: starfive: Add initial StarFive JH8100
 device tree
Message-ID: <20231211-submerge-vegan-244889f1751c@wendy>
References: <20231201121410.95298-1-jeeheng.sia@starfivetech.com>
 <20231201121410.95298-7-jeeheng.sia@starfivetech.com>
 <TY3P286MB2611F70A3D61788E556C8A30988AA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <358bcdb3f0ab4a7b9d6bbe17ca1a696d@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hd6P+t5VhD/fQIFu"
Content-Disposition: inline
In-Reply-To: <358bcdb3f0ab4a7b9d6bbe17ca1a696d@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--hd6P+t5VhD/fQIFu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 01:38:06AM +0000, JeeHeng Sia wrote:
>=20
> > From: Shengyu Qu <wiagn233@outlook.com>
> > Sent: Friday, December 8, 2023 8:09 PM

> > Does the dubhe-80 cores actually support vector? Or vector support
> >=20
> > doesn't exist on actual silicon?

> We don't have a use case for vector application in JH8100

I am sorry, but I am not clear on what this means. Do the CPUs on
the JH8100 support vector or not?

--hd6P+t5VhD/fQIFu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXbBIwAKCRB4tDGHoIJi
0qLgAQDdnIyMYOcscMM6Xn9n15BVhbDy7y4Y61q9DeXzpLmYtgD9HbHQYif0r4fF
BViOKAMeIVjMPAbnlXqZaG4Vt1VXzgY=
=Z2qE
-----END PGP SIGNATURE-----

--hd6P+t5VhD/fQIFu--
