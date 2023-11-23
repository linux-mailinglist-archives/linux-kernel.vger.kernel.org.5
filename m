Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE2E47F6108
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345694AbjKWOHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345683AbjKWOHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:07:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80640B9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 06:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700748469; x=1732284469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c9m6OVf58Xo2DNf9S/Po6djMWe3D3sOi1XkgmKgo8c4=;
  b=VXiAaqqBzcn5PiatW+l0OmWPbCvlJ/uXgP3kskELfAp45mon+J4WGp3L
   7GJZzZO0R79LwrvV3Ktcys8ejOhZwIxlFm/Ok+7hqbM6fDHeYVssHSFAI
   XGcAaMbK1dU/kzpf5OYGG4RXW88AvIUMLAR5xz5wKpjN3ThRukFfJ2wqz
   498myeftyLc4DLwU8Z1xVNx+dLbaIybWvwj06KbfB6k6bPgFpPCl5GxAH
   YDM+IZAQpdWSmuypD2IUkUW3PyTmuwm58xQWxH6aoPCq5aFO5/Xrg85oe
   xc3s2R4uVVNiENQPQwkYzxLlVz8MhHULlWg/xDyDn7ef+Yc4Baxc/ZIPf
   w==;
X-CSE-ConnectionGUID: TCqVcfDDR5mXI/gzk10ZoA==
X-CSE-MsgGUID: qX52RZ4iQcWu/bkmDmP4Eg==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="asc'?scan'208";a="12115149"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 07:07:48 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Nov 2023 07:07:26 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 23 Nov 2023 07:07:23 -0700
Date:   Thu, 23 Nov 2023 14:06:55 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Samuel Holland <samuel.holland@sifive.com>
CC:     Palmer Dabbelt <palmer@dabbelt.com>,
        <linux-riscv@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andy Chiu <andy.chiu@sifive.com>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nam Cao <namcaov@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv: Fix SMP when shadow call stacks are enabled
Message-ID: <20231123-vision-nuttiness-b75be703f162@wendy>
References: <20231121211958.3158576-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="R6NWfd0pBNwexC3U"
Content-Disposition: inline
In-Reply-To: <20231121211958.3158576-1-samuel.holland@sifive.com>
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

--R6NWfd0pBNwexC3U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 01:19:29PM -0800, Samuel Holland wrote:
> This fixes two bugs in SCS initialization for secondary CPUs. First,
> the SCS was not initialized at all in the spinwait boot path. Second,
> the code for the SBI HSM path attempted to initialize the SCS before
> enabling the MMU. However, that involves dereferencing the thread
> pointer, which requires the MMU to be enabled.
>=20
> Fix both issues by setting up the SCS in the common secondary entry
> path, after enabling the MMU.

I'm curious, mostly because I do not know much about the implemtnation
of the shadow call stack, but does it actually work correctly when the
kernel is built without mmu support?

>=20
> Fixes: d1584d791a29 ("riscv: Implement Shadow Call Stack")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>=20
>  arch/riscv/kernel/head.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index b77397432403..76ace1e0b46f 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -154,7 +154,6 @@ secondary_start_sbi:
>  	XIP_FIXUP_OFFSET a3
>  	add a3, a3, a1
>  	REG_L sp, (a3)
> -	scs_load_current
> =20
>  .Lsecondary_start_common:
> =20
> @@ -165,6 +164,7 @@ secondary_start_sbi:
>  	call relocate_enable_mmu
>  #endif
>  	call .Lsetup_trap_vector
> +	scs_load_current
>  	tail smp_callin
>  #endif /* CONFIG_SMP */
> =20
> --=20
> 2.42.0
>=20

--R6NWfd0pBNwexC3U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV9cfwAKCRB4tDGHoIJi
0gIpAP9ONF1o41LhBrc0ZV8gMLPTLWtw+TTTBzcxqq0oWmjYlAEAjA9Yv8RUu/ZW
4OmzEDkWDyFj8ja5ZmEIAp4h4yfpvAg=
=pHOR
-----END PGP SIGNATURE-----

--R6NWfd0pBNwexC3U--
