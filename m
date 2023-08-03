Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF5876E02C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 08:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjHCG0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 02:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbjHCG0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 02:26:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382261706
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 23:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691044006; x=1722580006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ZwfAoSWG3OILQCx5AkENs63AOVTeG0AjJEGkSSi5Sc=;
  b=oYN088aoHZIsHjkYJqoJITYn1bR0UCwU1U9MYjFunh5JwHByMfy9lNCK
   8LFfnfeYWh/r20aI7LFbNWSNBiOkRzrmr9ldVpYRBqJfmcI1LJZeMgFdU
   oSkTBlTGXpemF9u0bpvxDPysCU5kfDJbUx9bm/bIwhdlfgBwA8jc5eysI
   FvqBDaFbC90PE5nsIJqS8ImGCj55ieSZNOL52vzRx3Sr0oMkFGBqbfZdZ
   gm8gZ6QsTEQq9nqaSTSFCRxvr1UrszECyXGrHtiJAG6voQ2sLGHOldLwp
   wSztXJTC5DTYsXcFcPO+V6HrKynLroj5xu/16Zsst823agyVIHDj3vlLR
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="asc'?scan'208";a="239517011"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2023 23:26:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 2 Aug 2023 23:26:45 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 2 Aug 2023 23:26:44 -0700
Date:   Thu, 3 Aug 2023 07:26:08 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samuel Holland <samuel.holland@sifive.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH] riscv: Fix CPU feature detection with SMP disabled
Message-ID: <20230803-bash-spree-4c02a339a6d5@wendy>
References: <20230803012608.3540081-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IWqUTP8P5wUkOjNk"
Content-Disposition: inline
In-Reply-To: <20230803012608.3540081-1-samuel.holland@sifive.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--IWqUTP8P5wUkOjNk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 06:26:06PM -0700, Samuel Holland wrote:
> commit 914d6f44fc50 ("RISC-V: only iterate over possible CPUs in ISA
> string parser") changed riscv_fill_hwcap() from iterating over CPU DT
> nodes to iterating over logical CPU IDs. Since this function runs long
> before cpu_dev_init() creates CPU devices, it hits the fallback path in
> of_cpu_device_node_get(), which itself iterates over the DT nodes,
> searching for a node with the requested CPU ID.

> (Incidentally, this
> makes riscv_fill_hwcap() now take quadratic time.)

Ouch, that I did not realise. Should we revert that portion of the
changes? Starting to sound like we should..

> riscv_fill_hwcap() passes a logical CPU ID to of_cpu_device_node_get(),
> which uses the arch_match_cpu_phys_id() hook to translate the logical ID
> to a physical ID as found in the DT.
>=20
> arch_match_cpu_phys_id() has a generic weak definition, and RISC-V
> provides a strong definition using cpuid_to_hartid_map(). However, the
> RISC-V specific implementation is located in arch/riscv/kernel/smp.c,
> and that file is only compiled when SMP is enabled.
>=20
> As a result, when SMP is disabled, the generic definition is used, and
> riscv_isa gets initialized based on the ISA string of hart 0, not the
> boot hart. On FU740, this means has_fpu() returns false, and userspace
> crashes when trying to use floating-point instructions.
>=20
> Fix this by moving arch_match_cpu_phys_id() to a file which is always
> compiled.
>=20
> Fixes: 70114560b285 ("RISC-V: Add RISC-V specific arch_match_cpu_phys_id")
> Fixes: 914d6f44fc50 ("RISC-V: only iterate over possible CPUs in ISA stri=
ng parser")
> Reported-by: Palmer Dabbelt <palmer@rivosinc.com>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks for fixing this Samuel.

--IWqUTP8P5wUkOjNk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMtIfAAKCRB4tDGHoIJi
0vT9AP9Lu6eMzcV6VTEm4k72Es6D5W5Ni4kxzCx/NDrEq5FgTAD+OZ0n6fMavKzX
j2GbejIGfNlZJLsxERdo3/aJ5THhcQw=
=xp9a
-----END PGP SIGNATURE-----

--IWqUTP8P5wUkOjNk--
