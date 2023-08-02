Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC1C76C9D8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbjHBJvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjHBJvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:51:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B37E57;
        Wed,  2 Aug 2023 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690969865; x=1722505865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vzNzAgti1mALKRkB7nhHCwcw9iaYKtu7Mwjj/hXtAh8=;
  b=YC4sgU/6B0VC6GNPIchqCnmp/cwJ2DrScFtLbhsewCcBQe9bzEl//uA5
   HCOVPLz4D4k+jwi6FPvJLIE4Xcm4nmkqz+SNFsqBYWq2MOnhd0XC8zHTP
   ThlDqcG27Y10qy0fWHBpabfCENHaVtjEUIOuGn7tYOFNYPyMIpYeK3bNb
   7MRiAl7Aghvsfs0ubG1y3Asr3+VouAn8yqmgEXsQ+ZTcs59LHB8cvTJqc
   kcTRIDmxsJgqZyO+4yDzJ37xaaEy4xKsfDmNwz/rqmCG62U0eoqtJkTF/
   MjrDvrJJBc7NcGpWvz3C0MHuH/gNrU1IT7bLGBJooH1c266+w1HXwIoaU
   g==;
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="asc'?scan'208";a="164455134"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2023 02:51:04 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 2 Aug 2023 02:51:04 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 2 Aug 2023 02:51:01 -0700
Date:   Wed, 2 Aug 2023 10:50:25 +0100
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
Message-ID: <20230802-tightwad-squeezing-bcdded12330d@wendy>
References: <20230802064215.31111-1-minda.chen@starfivetech.com>
 <20230802-sharpness-spoon-f9b8804fb66f@wendy>
 <d64874cb-8628-a6d2-d2f4-8af4d0ebf8b2@starfivetech.com>
 <20230802-seismic-gallstone-fca0f4b17076@wendy>
 <c42bd997-8795-8bf7-eee1-3ac8b153371a@starfivetech.com>
 <2023080253-headache-moneybags-a833@gregkh>
 <20230802-decibel-unshaved-fde1cfba2d20@wendy>
 <2023080255-stomp-smell-43ae@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7mmglFYMmxEffWC0"
Content-Disposition: inline
In-Reply-To: <2023080255-stomp-smell-43ae@gregkh>
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

--7mmglFYMmxEffWC0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 11:42:59AM +0200, Greg KH wrote:
> On Wed, Aug 02, 2023 at 09:52:45AM +0100, Conor Dooley wrote:
> > On Wed, Aug 02, 2023 at 10:33:27AM +0200, Greg KH wrote:
> > > On Wed, Aug 02, 2023 at 04:17:51PM +0800, Minda Chen wrote:
> > > > On 2023/8/2 15:48, Conor Dooley wrote:
> > > > > On Wed, Aug 02, 2023 at 03:32:15PM +0800, Minda Chen wrote:
> > > > >> On 2023/8/2 14:54, Conor Dooley wrote:

> > > > >> Thanks, Conor. I found this just by inspection. I found a issue =
that vdso.so call cpu_relax
> > > > >> cause application core dump in kernel 6.1.31. I need Samuel'patc=
h to fix this. And I search the log
> > > > >> of processor.h found this issue.
> > > > >=20
> > > > > That doesn't look like it is fixed in later stable kernels (we ar=
e at
> > > > > 6.1.42-rcN right now I think). It sounds we should ask Greg to ba=
ckport
> > > > > 0b1d60d6dd9e ("riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=
=3Dy")
> > > > > to 6.1. Does that make sense to you?
> > > > Yes. 6.1 is lts kernel. Starfive will use this kernel for a long ti=
me. Thanks.
> > >=20
> > > What is preventing you from moving to a newer kernel version?  All of
> > > your kernel changes are already properly merged into Linus's tree,
> > > right?
> >=20
> > Regardless of their reasons, "vdso.so call cpu_relax cause application
> > core dump" is something that we should fix in stable kernels, no?
>=20
> Yes.

It doesn't apply cleanly as a cherry-pick onto linux-6.1, so it'll need
to be submitted. Maybe Minda can do that, since they've got an already
tested version of the patch. Failing that, I will.

--7mmglFYMmxEffWC0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMom4QAKCRB4tDGHoIJi
0ic9AP9ecnH7XK0svOPmGN8QdpCH7CToY7UNWnokQhm/lLP35AD5ASAuSUm4fkdF
mj9dosTVhTn+FzFakG4X8lLMnfEMwwM=
=5zWd
-----END PGP SIGNATURE-----

--7mmglFYMmxEffWC0--
