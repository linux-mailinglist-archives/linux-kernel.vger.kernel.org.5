Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC71C7A781F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 11:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbjITJ4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 05:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbjITJz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 05:55:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91F59B6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 02:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1695203752; x=1726739752;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kv+svYrMzGZXbsH49j8A5pkAvGfMZCYzhz6MSlWTgus=;
  b=dm3tkoTKQJmwujf2DcG/FYHNI8GWQQXRcuYlxdEwTtlIyasJ8skXbPJr
   JzAqPqtBFl5Dg213G6MG+siuQ55iThb4iF77KJpPFqTzn3LJdznLQXQ9l
   Ffx8sjmRJ8wj1QZfDM830KclpoF8k0tuh1tvupZHkn4xj+8huD98jXKvV
   7ESMvSPILV+Nq80GrOECakO1GrlOOV4MJ63WYORPXO3URAV8qnhWLR2A7
   XxQbkJilB2Aw4Iv2DrSIje3F4vpZwTGkrzUssBbwnEVJGzSfj+vGzjGlR
   f5FQfOtJkEaAPY8/9Pe6SR61YDJVE3awCKIJn1ch1fhYAbdhYb965K8ZT
   w==;
X-CSE-ConnectionGUID: dbn6Zn3nR1qJCQIoTThVUg==
X-CSE-MsgGUID: 0qEvuKfASuicX6E2xi7s2w==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,161,1688454000"; 
   d="asc'?scan'208";a="5487440"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2023 02:55:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 20 Sep 2023 02:55:49 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 20 Sep 2023 02:55:47 -0700
Date:   Wed, 20 Sep 2023 10:55:30 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yu Chien Peter Lin <peterlin@andestech.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <david@redhat.com>,
        <akpm@linux-foundation.org>, <alexghiti@rivosinc.com>,
        <bjorn@rivosinc.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] riscv: Improve PTDUMP to show RSW with non-zero
 value
Message-ID: <20230920-pureblood-unwilling-f17aff1eef6a@wendy>
References: <20230920035522.3180558-1-peterlin@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="egyxQ65o8DYutaoK"
Content-Disposition: inline
In-Reply-To: <20230920035522.3180558-1-peterlin@andestech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--egyxQ65o8DYutaoK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 11:55:20AM +0800, Yu Chien Peter Lin wrote:
> RSW field can be used to encode 2 bits of software
> defined information. Currently, PTDUMP only prints
> "RSW" when its value is 1 or 3.
>=20
> To fix this issue and improve the debugging experience
> with PTDUMP, we redefine _PAGE_SPECIAL to its original
> value and use _PAGE_SOFT as the RSW mask, allow it to
> print the RSW with any non-zero value.
>=20
> This patch also removes the val from the struct prot_bits
> as it is no longer needed.
>=20

Could you please add cover letters to multi-patch patchsets?

Thanks,
Conor.

--egyxQ65o8DYutaoK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZQrBkgAKCRB4tDGHoIJi
0rl0AQDCTnGcbYIj3i57BCo5CDgqHtCeWpve6uDM+V8OgNsMhQD/cec9Sn6GA/BC
aY9PQc8PUSY8H4plXnnsX6z61H1msgA=
=3fdS
-----END PGP SIGNATURE-----

--egyxQ65o8DYutaoK--
