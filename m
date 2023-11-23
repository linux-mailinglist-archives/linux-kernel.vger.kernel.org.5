Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD737F6019
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345445AbjKWNUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345271AbjKWNUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:20:09 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C0D1B3;
        Thu, 23 Nov 2023 05:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700745616; x=1732281616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fWNtfXHzXywCV3rJawk3X+XqobnQl2nUu8oA1ElHfxI=;
  b=AboTjH3xu8fuu0PWuAzOb1DB5nU5Wy9Ma7KNcRTZK8Uu/CGLuqXUo6Sm
   G6criFqY6MKpGlemc+mMMv1tDzjOyf90LMX3Qx9aNhF6EOxskr1vJxWb8
   lqn7f0M08JTQXld/N2j/C3jqOjhU1wBajVSO8SmqW55CgWNNwWz58LlCs
   Qj0eRkB2+ffzVb1LQhat01Efa8gIYQnC7q4ltsbpyGXSJ9RZEXl88gJMc
   JCBA5TgoxgUmR0qDhNahh7fGXQGK6dxV+W1SEKtE1XMG99qREMEXuzkWv
   6/E+XP56KkGLn2Zg1fpUQx45AJtYy932zOfcYY97gbPw6HhckeNb0fAzh
   g==;
X-CSE-ConnectionGUID: bvAY+6v1Q022ekVbEs8Vvw==
X-CSE-MsgGUID: E6+Bsg93R3eTTQTJUaz5eQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="asc'?scan'208";a="12192189"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 06:20:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Nov 2023 06:20:08 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 23 Nov 2023 06:20:06 -0700
Date:   Thu, 23 Nov 2023 13:19:38 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Rob Herring <robh@kernel.org>
CC:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: perf: riscv,pmu: drop unneeded quotes
Message-ID: <20231123-nutlike-handiwork-2b24bffc64ac@wendy>
References: <20231122224414.2809184-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="VwNbz+r5L7xIZna3"
Content-Disposition: inline
In-Reply-To: <20231122224414.2809184-1-robh@kernel.org>
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

--VwNbz+r5L7xIZna3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 03:44:14PM -0700, Rob Herring wrote:
> Drop unneeded quotes over simple string values to fix a soon to be
> enabled yamllint warning:
>=20
>   [error] string value is redundantly quoted with any quotes (quoted-stri=
ngs)
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--VwNbz+r5L7xIZna3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV9RagAKCRB4tDGHoIJi
0pBwAP0cuJ5+YBbNci6dtuViPbnpzFtnjRuPYpj7iZekyYXM6QD+IJJFLGfqJprA
5v+CEke2yJopFXOGNr0Y9vZLmj/imQg=
=G5Mg
-----END PGP SIGNATURE-----

--VwNbz+r5L7xIZna3--
