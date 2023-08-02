Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C2976C8C6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 10:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbjHBIxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 04:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbjHBIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 04:53:37 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832052706;
        Wed,  2 Aug 2023 01:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690966413; x=1722502413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tv4M0P+a0kjE58sJhnwrk9HUNB9uEWwAlkNuhiNh6pg=;
  b=AMpzeVkTfOSUBg1vn4AoJA6fls7pmuo1Tn+7DAjCZyLCCg+GdO1SmidJ
   8C2O0RHeOxYQre9s6TTqa0z66ns40ZTrpHFj3THfmM6sV5BLB4SbHsITJ
   dQwfZkuRrxYQv/r1utXVGbBgXvK0mQp5egt9jyF9IJ0l1G+MFV/1fDlK6
   HSoeSTyl2FEPBI6/q02W2+IPmEI8MpPSZO9tlv9f7knEkQH1PBhJWF+KB
   nQiJNv3r15B4p/pnDyfwLES+ZdihK6wIqw8HBpySrefgxrfJgenbmgEKC
   grH4ffnxLR+SVA/OMFZQGhmkeMF268XLAGlWtcrIrDbpT/XUSD3cv//a3
   A==;
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="asc'?scan'208";a="223448015"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2023 01:53:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 2 Aug 2023 01:53:23 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 2 Aug 2023 01:53:21 -0700
Date:   Wed, 2 Aug 2023 09:52:45 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Minda Chen <minda.chen@starfivetech.com>,
        Conor Dooley <conor@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Dao Lu <daolu@rivosinc.com>, Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Mason Huo <mason.huo@starfivetech.com>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH v1] riscv: Using TOOLCHAIN_HAS_ZIHINTPAUSE marco replace
 zihintpause
Message-ID: <20230802-decibel-unshaved-fde1cfba2d20@wendy>
References: <20230802064215.31111-1-minda.chen@starfivetech.com>
 <20230802-sharpness-spoon-f9b8804fb66f@wendy>
 <d64874cb-8628-a6d2-d2f4-8af4d0ebf8b2@starfivetech.com>
 <20230802-seismic-gallstone-fca0f4b17076@wendy>
 <c42bd997-8795-8bf7-eee1-3ac8b153371a@starfivetech.com>
 <2023080253-headache-moneybags-a833@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FW1Kj+nV7cDQRX/N"
Content-Disposition: inline
In-Reply-To: <2023080253-headache-moneybags-a833@gregkh>
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

--FW1Kj+nV7cDQRX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 10:33:27AM +0200, Greg KH wrote:
> On Wed, Aug 02, 2023 at 04:17:51PM +0800, Minda Chen wrote:
> >=20
> >=20
> > On 2023/8/2 15:48, Conor Dooley wrote:
> > > On Wed, Aug 02, 2023 at 03:32:15PM +0800, Minda Chen wrote:
> > >>=20
> > >>=20
> > >> On 2023/8/2 14:54, Conor Dooley wrote:
> > >> > Hey Minda,
> > >> >=20
> > >> > On Wed, Aug 02, 2023 at 02:42:15PM +0800, Minda Chen wrote:
> > >> >> Actually it is a part of Conor's
> > >> >> commit aae538cd03bc ("riscv: fix detection of toolchain
> > >> >> Zihintpause support").
> > >> >> It is looks like a merge issue.
> > >> >=20
> > >> > Yup, spot on.
> > >> >=20
> > >> >> Samuel's
> > >> >> commit 0b1d60d6dd9e ("riscv: Fix build with
> > >> >> CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy") do not base on Conor's commit a=
nd
> > >> >> revert to __riscv_zihintpause. So this patch can fix it.
> > >> >>=20
> > >> >> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > >> >=20
> > >> > Did you actually manage to trigger this, or was this by inspection?
> > >> > clang-15 + binutils 2.35 was, IIRC, how we spotted this because th=
at's
> > >> > what the clang-built-linux CI uses to test the LTS kernels from be=
fore
> > >> > LLVM's IAS was supported for RISC-V. Seemingly all that needs to be
> > >> > satisfied there is that zihintpause doesn't appear in -march so th=
is has
> > >> > gone unnoticed.
> > >> >=20
> > >> > Fixes: 3c349eacc559 ("Merge patch "riscv: Fix build with CONFIG_CC=
_OPTIMIZE_FOR_SIZE=3Dy"")
> > >> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > >> >=20
> > >> > Thanks,
> > >> > Conor.
> > >> >=20
> > >> Thanks, Conor. I found this just by inspection. I found a issue that=
 vdso.so call cpu_relax
> > >> cause application core dump in kernel 6.1.31. I need Samuel'patch to=
 fix this. And I search the log
> > >> of processor.h found this issue.
> > >=20
> > > That doesn't look like it is fixed in later stable kernels (we are at
> > > 6.1.42-rcN right now I think). It sounds we should ask Greg to backpo=
rt
> > > 0b1d60d6dd9e ("riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=3Dy")
> > > to 6.1. Does that make sense to you?
> > Yes. 6.1 is lts kernel. Starfive will use this kernel for a long time. =
Thanks.
>=20
> What is preventing you from moving to a newer kernel version?  All of
> your kernel changes are already properly merged into Linus's tree,
> right?

Regardless of their reasons, "vdso.so call cpu_relax cause application
core dump" is something that we should fix in stable kernels, no?

--FW1Kj+nV7cDQRX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMoZXQAKCRB4tDGHoIJi
0oRWAP9BTGH3q07+XeBW8yRULD9PA1MB/TiLZFZTyMSVwZ+k7gEAkN5bfTlTj2Bu
4J2aZnx6QsteTBSDwjAzsIcBaqYmGQU=
=deFA
-----END PGP SIGNATURE-----

--FW1Kj+nV7cDQRX/N--
