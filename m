Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AD47F9DC7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbjK0Kjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:39:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232991AbjK0Kjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:39:44 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6336810F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701081590; x=1732617590;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CB+2fZP2xBpokIIQMBo8XFvxl4A+THV4m/A7MXEQi6k=;
  b=trPP0gLRz8acAbL64fFpY9/CJAmIBAzT0UQ4Pe3EehbAwAzvN16GEdQY
   ANiUBDuJ1Iijkkx5LTqzvpuTu6orHjCKX9k3x7PsbzVPLTGdI7WOqpLM0
   Bz1zlLWI0WtCJhlpPvGjepBxajZf46mool16OMYD4CL/XZlHIKVbPev7f
   fkqSqNJZ6OT37wNmsYV0zNJ8fZMVouVpvaj1H3hZzlLOMk4VYBcgweCQb
   sW7y7ndQ2YUisLb3O2lMxV6pNETcSoea9YLLW0PJ+3HJ1eKAP5tOwDR/c
   1tjPUDYj3CYKQ4r/fN6poIsDunVNHjSyksugW5q/8LL0/63frqQJtGT00
   Q==;
X-CSE-ConnectionGUID: ToBQd87lTZW/CiPHi8AqRA==
X-CSE-MsgGUID: OQfIFRUhT/eBCUlo5fisew==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="asc'?scan'208";a="12250684"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2023 03:39:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Nov 2023 03:39:46 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 27 Nov 2023 03:39:44 -0700
Date:   Mon, 27 Nov 2023 10:39:16 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Use asm-generic for {read,write}{bwlq} and their
 relaxed variant
Message-ID: <20231127-swell-garnish-3f2104647aa0@wendy>
References: <20231123142003.1759-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="X4t7/KZjh6cGf8um"
Content-Disposition: inline
In-Reply-To: <20231123142003.1759-1-jszhang@kernel.org>
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

--X4t7/KZjh6cGf8um
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 10:20:03PM +0800, Jisheng Zhang wrote:
> The asm-generic implementation is functionally identical to the riscv
> version.
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

This fails to build for nommu:
  /tmp/tmp.ojumpiEgOt/arch/riscv/include/asm/timex.h:20:16: error: implicit=
 declaration of function 'readq_relaxed' [-Werror=3Dimplicit-function-decla=
ration]
  /tmp/tmp.ojumpiEgOt/include/asm-generic/io.h:342:23: error: conflicting t=
ypes for 'readq_relaxed'; have 'u64(const volatile void *)' {aka 'long long=
 unsigned int(const volatile void *)'}

  Cheers,
  Conor.

--X4t7/KZjh6cGf8um
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWRx1AAKCRB4tDGHoIJi
0irzAP0RCdfnnaJu4CokpQ6Q2/Kpn4q5enQfhf/S5SrCa3QOLQD/U6teAtmdkAp4
TaY6f2exqhWTKIYqlWEjC1tLf0KZMQo=
=v04p
-----END PGP SIGNATURE-----

--X4t7/KZjh6cGf8um--
