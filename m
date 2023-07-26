Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC01076320F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbjGZJ35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjGZJ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:29:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02CE910F9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 02:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690363689; x=1721899689;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sWI8BN0I0gaWnWPq+rnd1lL/hQZJEhkF2KexTcF60WY=;
  b=wCFD3vMLJ/CWmdnIW4g7dUakPs3vp3brtvZqvmDGLqM1vBAbCsj7iLNS
   sPvr/cn2mb2KWjricEB7i9np+xkAtDrj8XNmcwD3vgJo+3pzB9JQN7LTM
   AJj9ukGb+28h3nB75Ruq1KkL2iH5z6nKy6qjYRsKQv79ImhKijMAcpAyR
   a1apYISC5m9IKU9kQyPnSWe3z76nw4T9/aqFqh+O/tR9efAOzoFTKuMwz
   W0wBTM0lCXDoG7nBKVXljoI5H0/lK9NQlIQ5Kg5LWgCSYQssD69tU58rp
   MpQt+ApoFHYCmyQMzlRQ3PdTK1qCEKPYmrnKhZZ2Uslok7BQ1h/QLiYqa
   w==;
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="asc'?scan'208";a="225284568"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2023 02:28:09 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 26 Jul 2023 02:28:08 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 26 Jul 2023 02:28:07 -0700
Date:   Wed, 26 Jul 2023 10:27:33 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     wang_yang <wang_yang6662023@163.com>
CC:     <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Wang Yang <yangwang@nj.iscas.ac.cn>
Subject: Re: [PATCH] RISC-V: Use GCC __builtin_prefetch() to implement
 prefetch()
Message-ID: <20230726-washing-scoreless-12f0cca83365@wendy>
References: <20230726074732.32981-1-wang_yang6662023@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7z2nzsGN1jDIioBs"
Content-Disposition: inline
In-Reply-To: <20230726074732.32981-1-wang_yang6662023@163.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--7z2nzsGN1jDIioBs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Wed, Jul 26, 2023 at 03:47:32PM +0800, wang_yang wrote:
>  GCC's __builtin_prefetch() was introduced a long time ago, all supported=
 GCC
>  versions have it.So this patch is to use it for implementing the prefetc=
h.
>=20
>  RISC-V Cache Management Operation instructions has been supported by GCC=
 last
>  year.you can refer to
>  https://github.com/gcc-mirror/gcc/commit/3df3ca9014f94fe4af07444fea19b4a=
b29ba8e73

This should be in a Link: tag.

>  It is worth noting that CPU based on RISC-V should support Zicbop extens=
ion.

How do you intend determining whether the CPU supports Zicbop?

>  This has been already done on other architectures (see the commit:
>  https://github.com/torvalds/linux/commit/0453fb3c528c5eb3483441a466b24a4=
cb409eec5).

That's not how to describe commits, please see how that is done
elsewhere in the git history.

>=20
> Signed-off-by: Wang Yang <yangwang@nj.iscas.ac.cn>

WARNING: Possible unwrapped commit description (prefer a maximum 75 chars p=
er line)
#6:=20
 GCC's __builtin_prefetch() was introduced a long time ago, all supported G=
CC

ERROR: Missing Signed-off-by: line by nominal patch author 'wang_yang <wang=
_yang6662023@163.com>'

> ---
>  arch/riscv/include/asm/processor.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/=
processor.h
> index c950a8d9edef..f16d4c85ca5b 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -70,6 +70,17 @@ extern void start_thread(struct pt_regs *regs,
> =20
>  extern unsigned long __get_wchan(struct task_struct *p);
> =20
> +#define ARCH_HAS_PREFETCH
> +static inline void prefetch(const void *ptr)
> +{
> +	__builtin_prefetch(ptr, 0, 3);

As far as I can tell, this does not do anything and will be removed by
the compiler. Please take a look at how other extensions are implemented.

Also, why 3? (Your answer should be in the commit message)

Thanks,
Conor.

> +}
> +
> +#define ARCH_HAS_PREFETCHW
> +static inline void prefetchw(const void *ptr)
> +{
> +	__builtin_prefetch(ptr, 1, 3);
> +}
> =20
>  static inline void wait_for_interrupt(void)
>  {
> --=20
> 2.34.1
>=20

--7z2nzsGN1jDIioBs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMDnBQAKCRB4tDGHoIJi
0im4AP4zuaPEjwNldgorLZ7XQnAcFueQvdQrx0h7e6ZAN6oYzwD/eO+uxgIz3j5r
iG/Dye9EddOEg2EZ5jMAWCkWn+jHFgk=
=kzQ1
-----END PGP SIGNATURE-----

--7z2nzsGN1jDIioBs--
