Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3198375ECC1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 09:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbjGXHuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 03:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGXHuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 03:50:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCAD51A2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 00:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690185011; x=1721721011;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cFSk2zmVNjF+ma0HjJ0LslmgIPzvLIjCxHLecSYlzvM=;
  b=2HJht70fU5+CtqYxQLJ18Bj5b/fwq3WRfOPnNOm0WEbZnkMIn8+fAy6a
   iF7D1vd/1D5w/KmBQmDDG7KnlkpA0EpL+uDnlrenimkqsasNupSQZDNEZ
   45+YLcZI3yk98pRKDxDM3ShUbfNOda/8nvn2P6kbPAWKduFShsJYqbuB+
   IqCpXS8ArjNk/dsxz0Tk51aS0HHoVOJwjM6F8TcLyFqstslzJbci6FVM1
   z80rcj0/qnRTC28YW6KaZbJQzpGcfm53dFGp3aTwGrvJeJvkXkjWozBSX
   n/NHDmIX8TQBLHrV3DvwP5V0kOFS8KwluW5iP9hXCHJSBainhdzqzMvqo
   w==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="asc'?scan'208";a="237267499"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2023 00:50:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 24 Jul 2023 00:50:02 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 24 Jul 2023 00:50:01 -0700
Date:   Mon, 24 Jul 2023 08:49:27 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Jisheng Zhang <jszhang@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] riscv: allow kmalloc() caches aligned to the
 smallest value
Message-ID: <20230724-next-shifter-3ec32114b34e@wendy>
References: <20230718152214.2907-1-jszhang@kernel.org>
 <20230718152214.2907-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lbLuWTJ0u5bINZ3+"
Content-Disposition: inline
In-Reply-To: <20230718152214.2907-2-jszhang@kernel.org>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--lbLuWTJ0u5bINZ3+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2023 at 11:22:13PM +0800, Jisheng Zhang wrote:
> Currently, riscv defines ARCH_DMA_MINALIGN as L1_CACHE_BYTES, I.E
> 64Bytes, if CONFIG_RISCV_DMA_NONCOHERENT=3Dy. To support unified kernel
> Image, usually we have to enable CONFIG_RISCV_DMA_NONCOHERENT, thus
> it brings some bad effects to coherent platforms:
>=20
> Firstly, it wastes memory, kmalloc-96, kmalloc-32, kmalloc-16 and
> kmalloc-8 slab caches don't exist any more, they are replaced with
> either kmalloc-128 or kmalloc-64.
>=20
> Secondly, larger than necessary kmalloc aligned allocations results
> in unnecessary cache/TLB pressure.
>=20
> This issue also exists on arm64 platforms. From last year, Catalin
> tried to solve this issue by decoupling ARCH_KMALLOC_MINALIGN from
> ARCH_DMA_MINALIGN, limiting kmalloc() minimum alignment to
> dma_get_cache_alignment() and replacing ARCH_KMALLOC_MINALIGN usage
> in various drivers with ARCH_DMA_MINALIGN etc.[1]
>=20
> One fact we can make use of for riscv: if the CPU doesn't support
> ZICBOM or T-HEAD CMO, we know the platform is coherent. Based on
> Catalin's work and above fact, we can easily solve the kmalloc align
> issue for riscv: we can override dma_get_cache_alignment(), then let
> it return ARCH_DMA_MINALIGN at the beginning and return 1 once we know
> the underlying HW neither supports ZICBOM nor supports T-HEAD CMO.
>=20
> So what about if the CPU supports ZICBOM or T-HEAD CMO, but all the
> devices are dma coherent? Well, we use ARCH_DMA_MINALIGN as the
> kmalloc minimum alignment, nothing changed in this case. This case
> can be improved in the future.
>=20
> After this patch, a simple test of booting to a small buildroot rootfs
> on qemu shows:
>=20
> kmalloc-96           5041    5041     96  ...
> kmalloc-64           9606    9606     64  ...
> kmalloc-32           5128    5128     32  ...
> kmalloc-16           7682    7682     16  ...
> kmalloc-8           10246   10246      8  ...
>=20
> So we save about 1268KB memory. The saving will be much larger in normal
> OS env on real HW platforms.
>=20
> Link: https://lore.kernel.org/linux-arm-kernel/20230524171904.3967031-1-c=
atalin.marinas@arm.com/ [1]
>=20
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--lbLuWTJ0u5bINZ3+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL4tBwAKCRB4tDGHoIJi
0jIWAQDK3i9Q+yWDW+zT3HKMI/9vFe2vBFuaDRF2zhYd1DnQmAD/eQucZDuJ1yvE
Dnzs8qBMYSXxWuN7amY5rN5pjrjroAo=
=PbNw
-----END PGP SIGNATURE-----

--lbLuWTJ0u5bINZ3+--
