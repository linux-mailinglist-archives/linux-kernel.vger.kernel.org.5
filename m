Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAE387F60DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 14:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345630AbjKWNwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 08:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345594AbjKWNwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 08:52:31 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3522AB9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 05:52:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700747558; x=1732283558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aznKgEjxL0gDCvdqXB2iOl1LmY4FPyCsLGk1PVbiKws=;
  b=iuOe1W5K7eGBBmeh+tzI9X8Gm+YIzreWauc4WaCQ00+nIAidqewWPEH3
   Nkov4VTb/yKeHAkkdgZ0umqpLSSCcOod9BzDo7H9E66XStfRXcxfDwkz4
   horKor8V9BFLlfYA2fffB6sP1ytRl1FnhIXRaYCxt2MWDDK4CzMgUE7zu
   0MWlPkjM+u9tKCNaZVJyTzswImbm7hyZVcuDbMsWnakeDOGI5ESDulZm5
   wpAgQNu6IaIgwA518RnowR0ow+hXfjwYDeMkVfZsYrfYqLDeLM8lwAOQ+
   czCUVpronmptVhz9v3H1o+32thjosg2B2ZuozPduawxLFCSwJl/zCOabx
   g==;
X-CSE-ConnectionGUID: h2V/iXBSSfiFReBxuDFLQA==
X-CSE-MsgGUID: QZh0mXVNQLGVqC67cNRwjw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="asc'?scan'208";a="12193466"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Nov 2023 06:52:37 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Nov 2023 06:52:17 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 23 Nov 2023 06:52:15 -0700
Date:   Thu, 23 Nov 2023 13:51:47 +0000
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>
Subject: Re: [PATCH] riscv: declare overflow_stack as exported from traps.c
Message-ID: <20231123-blooper-very-cefbf92c0f05@wendy>
References: <20231123134214.81481-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="AAkSMNNL38JK6UIZ"
Content-Disposition: inline
In-Reply-To: <20231123134214.81481-1-ben.dooks@codethink.co.uk>
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

--AAkSMNNL38JK6UIZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 01:42:14PM +0000, Ben Dooks wrote:
> The percpu area overflow_stacks is exported from arch/riscv/kernel/traps.c
> for use in the entry code, but is not declared anywhere. Add the relevant
> declaration to arch/riscv/include/asm/stacktrace.h to silence the followi=
ng
> sparse warning:
>=20
> arch/riscv/kernel/traps.c:395:1: warning: symbol '__pcpu_scope_overflow_s=
tack' was not declared. Should it be static?
>=20
> We don't add the stackinfo_get_overflow() call as for some of the other
> architectures as this doesn't seem to be used yet, so just silence the
> warning.
>=20
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
I suppose this should also be
Fixes: be97d0db5f44 ("riscv: VMAP_STACK overflow detection thread-safe")

Cheers,
Conor.

> ---
>  arch/riscv/include/asm/stacktrace.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm=
/stacktrace.h
> index f7e8ef2418b9..b1495a7e06ce 100644
> --- a/arch/riscv/include/asm/stacktrace.h
> +++ b/arch/riscv/include/asm/stacktrace.h
> @@ -21,4 +21,9 @@ static inline bool on_thread_stack(void)
>  	return !(((unsigned long)(current->stack) ^ current_stack_pointer) & ~(=
THREAD_SIZE - 1));
>  }
> =20
> +
> +#ifdef CONFIG_VMAP_STACK
> +DECLARE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)], overfl=
ow_stack);
> +#endif /* CONFIG_VMAP_STACK */
> +
>  #endif /* _ASM_RISCV_STACKTRACE_H */
> --=20
> 2.37.2.352.g3c44437643
>=20

--AAkSMNNL38JK6UIZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZV9Y8wAKCRB4tDGHoIJi
0h0SAQDcTTkoh0A97aUVYnh6fGQAyoM9vAAQlKvpypv3AJuD+gEAoEsaf1PuO36l
tNylF+mvaA8289yMcGPGOgABUq/p1As=
=qrsB
-----END PGP SIGNATURE-----

--AAkSMNNL38JK6UIZ--
