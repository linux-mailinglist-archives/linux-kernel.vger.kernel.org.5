Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B7A7FA2B9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjK0ObY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbjK0ObD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:31:03 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EE5D4D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 06:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1701095407; x=1732631407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yhykNXyZvalLGEmacnGcRuQpSVBCd7cLRjOG9XbiXxQ=;
  b=UDRdS5qW3ej+V/cFmSyUPMvVdcQWc+yumNmCMDIxd34JaV9qtXmwH8yf
   XkwOWNld1In2TBvVAPaNA1sEACINbpHRACeWwNmvJBkmVh9YRz/GgSSR7
   NQXs+7HucndWX7RWWn+4esca+YRgW0FQZesmFeTQ78LjfFijBIVnTgzEY
   3udZhv/KtIk63YaDSb2daaC+Y8Slee2T/T5ItrUBvW0qc8m/hQEBDFKuW
   L5hFcyaKGyzPjB6sfIXnAPZeEvZ6Imjh+BXSVcygyAjasCBL2/YwuLKX6
   tIHZPXE5aWqkfX02OR0DBtJbzIx8Pqg3CxPczAW6baPL/97UyLzqtwSrZ
   A==;
X-CSE-ConnectionGUID: aW6Vx/uASBWsmmLGNLaICw==
X-CSE-MsgGUID: o7HKsLUXSMGfafdsAdFZ/g==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="asc'?scan'208";a="12260096"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Nov 2023 07:30:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Nov 2023 07:29:51 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 27 Nov 2023 07:29:49 -0700
Date:   Mon, 27 Nov 2023 14:29:21 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Woody Zhang <woodylab@foxmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <alexghiti@rivosinc.com>
Subject: Re: [PATCH] riscv: reserve DTB before possible memblock allocation
Message-ID: <20231127-trifle-film-2d8c940bab4f@wendy>
References: <tencent_B15C0F1F3105597D0DCE7DADC96C5EB5CF0A@qq.com>
 <20230607-jogging-grudging-70dede86bc53@spud>
 <tencent_79F42B5A66F98A65266F989EC9C86A69F005@qq.com>
 <20230607-unruly-encore-e00661704b71@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tXbrPhgYMyqKwY6U"
Content-Disposition: inline
In-Reply-To: <20230607-unruly-encore-e00661704b71@spud>
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

--tXbrPhgYMyqKwY6U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 11:23:31PM +0100, Conor Dooley wrote:
> On Thu, Jun 08, 2023 at 06:17:22AM +0800, Woody Zhang wrote:
> > Hi, Conor
> >=20
> > On Wed, Jun 07, 2023 at 07:17:28PM +0100, Conor Dooley wrote:
> > >+CC Alex, you should take a look at this patch.
> > >
> > >On Wed, Jun 07, 2023 at 09:35:19PM +0800, Woody Zhang wrote:
> > >> It's possible that early_init_fdt_scan_reserved_mem() allocates memo=
ry
> > >> from memblock for dynamic reserved memory in `/reserved-memory` node.
> > >> Any fixed reservation must be done before that to avoid potential
> > >> conflicts.
> > >>=20
> > >> Reserve the DTB in memblock just after early scanning it.
> > >
> > >The rationale makes sense to me, I am just wondering what compelling
> > >reason there is to move it away from the memblock_reserve()s for the
> > >initd and vmlinux? Moving it above early_init_fdt_scan_reserved_mem()
> > >should be the sufficient minimum & would keep things together.
> >=20
> > IMO, moving it to parse_dtb() is more reasonable as early scanning and
> > reservation are both subject to DTB. It can also lower the risk to
> > mess up the sequence in the future. BTW, it's also invoked in
> > setup_machine_fdt() in arm64.
>=20
> I'm fine with the change either way, so:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Mostly wanted to know whether you'd considered the minimal change.

What ever happened to this patch?

--tXbrPhgYMyqKwY6U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZWSnwQAKCRB4tDGHoIJi
0m/KAQDEuZxT5JfailGBMUXOcjT5I61ojfuXfoRX4qyhLfCZagEA48qNAd6QNeRx
30HhIlbePUXhEb/osu5NNXdRus1JQwY=
=r2nN
-----END PGP SIGNATURE-----

--tXbrPhgYMyqKwY6U--
