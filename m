Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C32775A0F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 13:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjHILFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 07:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbjHILFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 07:05:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762A910F3;
        Wed,  9 Aug 2023 04:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691579102; x=1723115102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p4FORBjsEVC++BkkUwWMyRT93MEizkm2MWw3FwdJmlM=;
  b=MPnK12+r7pE9s3a/7CNNgdacB1T6t79JtWA3z5Otc5jRvrhK9CLkd4IX
   r9bHVKPUniZxu0Ps+N+cjy5fiaWOTaM6wwCjXpu9k6NWqVRZwFZ/fYBPM
   rYNMs1BAipaZh2AhMotNZKewHbz2I0Y/tKILaaWMCjMCT62b5oO1bHOPK
   x/QhyO0yCV8I2w5E/IMw5Bo19nHSGs0hJaL7CDZakvvZ7vzK2ORTWez5/
   kAGWM4Bh3vT+Z2WEgs/hySkyXUe9ENVrWepY2he7ue656xuaG3b5t1w3t
   +/NmOXzyzTXAD74BlijCvrd7S8Dn9MScPlcw2PvVcl9M2I8IONibGvQSU
   A==;
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="asc'?scan'208";a="228848708"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Aug 2023 04:05:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 9 Aug 2023 04:04:54 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 9 Aug 2023 04:04:51 -0700
Date:   Wed, 9 Aug 2023 12:04:14 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>
CC:     Conor Dooley <conor@kernel.org>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
        Song Shuai <suagrfillet@gmail.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [RFT 1/2] RISC-V: handle missing "no-map" properties for
 OpenSBI's PMP protected regions
Message-ID: <20230809-eastcoast-glimmer-a16985ff08f0@wendy>
References: <20230802-purse-hydrant-6f44f77364b0@wendy>
 <20230802-detention-second-82ab2b53e07a@wendy>
 <3e066032031e4552b4b7903755deb669@EXMBX066.cuchost.com>
 <20230808-humility-rut-e1e46cf75708@spud>
 <3931cc7932e644bd88f9baf2beddd00d@EXMBX066.cuchost.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="D7xFCxRFk6Od56Zz"
Content-Disposition: inline
In-Reply-To: <3931cc7932e644bd88f9baf2beddd00d@EXMBX066.cuchost.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--D7xFCxRFk6Od56Zz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2023 at 10:24:57AM +0000, JeeHeng Sia wrote:
>=20
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Tuesday, August 8, 2023 9:13 PM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Cc: Conor Dooley <conor.dooley@microchip.com>; palmer@dabbelt.com; Paul=
 Walmsley <paul.walmsley@sifive.com>; Atish Patra
> > <atishp@rivosinc.com>; Anup Patel <apatel@ventanamicro.com>; Alexandre =
Ghiti <alexghiti@rivosinc.com>; Bj=F6rn T=F6pel
> > <bjorn@rivosinc.com>; Song Shuai <suagrfillet@gmail.com>; Petr Tesarik =
<petrtesarik@huaweicloud.com>; linux-
> > riscv@lists.infradead.org; linux-kernel@vger.kernel.org; stable@vger.ke=
rnel.org
> > Subject: Re: [RFT 1/2] RISC-V: handle missing "no-map" properties for O=
penSBI's PMP protected regions
> >=20
> > On Mon, Aug 07, 2023 at 12:44:07AM +0000, JeeHeng Sia wrote:
> >=20
> > > > +/* SBI implementation IDs */
> > > > +#define SBI_IMP_OPENSBI	1
> > > I would suggest to create an enum struct for the SBI Imp ID in
> > > the sbi.h file. What do you think?
> >=20
> > I'm not really sure what the advantage of doing so is.
> The macro SBI_IMP_OPENSBI seems weird (I would read it as "SBI Implementa=
tion OpenSBI").

That is what it is though, so I don't see what's weird about that.

> However, if we implement an enum struct for SBI_IMP_ID

> (There are numerous IDs available),

Ohh I know, but I didn't see the point adding those when I was only
focusing on a single implementation.

> the macro can be abbreviated to OpenSBI. By doing this, the conditional
> checking of the implementation ID would be more readable, as shown below:
> if (sbi_firmware_id !=3D OPENSBI)

I don't see that it can become that simple, it'd still need to be
prefixed with SBI_ to be consistent with any other SBI related enum, and
at that point adding the extra IMP_ makes little odds.

--D7xFCxRFk6Od56Zz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNNyrgAKCRB4tDGHoIJi
0rvGAP0SyeQqm6UAvnXOLJzlnblTo0HwOabHKj0s86xTLkhOfwD/YaRKdWFfgbVn
VGwGKCt34I07EXIAbaW33QoCY9kxkQk=
=SRBE
-----END PGP SIGNATURE-----

--D7xFCxRFk6Od56Zz--
