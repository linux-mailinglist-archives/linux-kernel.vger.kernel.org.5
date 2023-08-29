Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D8E78BE68
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjH2G17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233642AbjH2G1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:27:46 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7DA19A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1693290464; x=1724826464;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GGbqLGqMN9df8eATN/J3U86vb4CO2JuXfpoZHqXvJqY=;
  b=o85SCAItdje2Q5TR8aE1ZpjfSloL9TClfSys/8TRfL+pCZUUhq5EpPps
   PqnrXfbScWImitgNV97aLmL5et9KJ1XYDMY/Mt6qn8iAKj0s6iihDOTwG
   arQaQEsaAmgESTJgoQzhXFCVxmz/FuYvTnWbtSr0WPIftZOWc1q+LfTun
   CxDqjg+sCZaFWMkSAfOImR53g4ODCRXN/PqNPcIHzyaw8DAZDCdWUzOJr
   A8xG95y8+4FFm85bDES2aHHk7pmu6UgNdxR9+nB5L0czUVxyCO87JvhsO
   CWQYloBMbRUyHly6iXCS7RxjNFFfu+Di0RyWDel/s62FVWSUONQXAswFt
   A==;
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="asc'?scan'208";a="232227171"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Aug 2023 23:27:44 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 28 Aug 2023 23:27:37 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 28 Aug 2023 23:27:35 -0700
Date:   Tue, 29 Aug 2023 07:26:54 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Guo Ren <guoren@kernel.org>
CC:     Nam Cao <namcaov@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <bjorn@kernel.org>
Subject: Re: [PATCH] riscv: provide riscv-specific is_trap_insn()
Message-ID: <20230829-unbridle-condense-2fc45a442bb6@wendy>
References: <20230827205641.46836-1-namcaov@gmail.com>
 <CAJF2gTQysBBSbtFcx1uY_ztTnzN5jRWpG2OD4O3aJ0u9Ekwsag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Gejlf3F12x47mKDN"
Content-Disposition: inline
In-Reply-To: <CAJF2gTQysBBSbtFcx1uY_ztTnzN5jRWpG2OD4O3aJ0u9Ekwsag@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Gejlf3F12x47mKDN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 29, 2023 at 01:56:34PM +0800, Guo Ren wrote:
> On Mon, Aug 28, 2023 at 4:56=E2=80=AFAM Nam Cao <namcaov@gmail.com> wrote:
> >
> > uprobes expects is_trap_insn() to return true for any trap instructions,
> > not just the one used for installing uprobe. The current default
> > implementation only returns true for 16-bit c.ebreak if C extension is
> > enabled. This can confuse uprobes if a 32-bit ebreak generates a trap
> > exception from userspace: uprobes asks is_trap_insn() who says there is=
 no
> > trap, so uprobes assume a probe was there before but has been removed, =
and
> > return to the trap instruction. This cause an infinite loop of entering
> > and exiting trap handler.
> >
> > Instead of using the default implementation, implement this function
> > speficially for riscv which checks for both ebreak and c.ebreak.
> >
> > Fixes: 74784081aac8 ("riscv: Add uprobes supported")
> > Signed-off-by: Nam Cao <namcaov@gmail.com>
> > ---
> >  arch/riscv/kernel/probes/uprobes.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/pro=
bes/uprobes.c
> > index 194f166b2cc4..91f4ce101cd1 100644
> > --- a/arch/riscv/kernel/probes/uprobes.c
> > +++ b/arch/riscv/kernel/probes/uprobes.c
> > @@ -3,6 +3,7 @@
> >  #include <linux/highmem.h>
> >  #include <linux/ptrace.h>
> >  #include <linux/uprobes.h>
> > +#include <asm/insn.h>
> >
> >  #include "decode-insn.h"
> >
> > @@ -17,6 +18,15 @@ bool is_swbp_insn(uprobe_opcode_t *insn)
> >  #endif
> >  }
>  >
> > +bool is_trap_insn(uprobe_opcode_t *insn)
> > +{
> > +#ifdef CONFIG_RISCV_ISA_C

> Can we remove the CONFIG_RISCV_ISA_C? As you said, "uprobes expects
> is_trap_insn() to return true for any trap instructions". So userspace
> wouldn't be limited by CONFIG_RISCV_ISA_C.

Isn't the RISCV_ISA_C required because there's a different encoding for
EBREAK vs C_EBREAK? That said, this should be using IS_ENABLED() not
#ifdef, since the definition for riscv_insn_is_c_ebreak() is provided
unconditionally afaict.

>=20
> > +       if (riscv_insn_is_c_ebreak(*insn))
> > +               return true;
> > +#endif
> > +       return riscv_insn_is_ebreak(*insn);
> > +}
> > +
> >  unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
> >  {
> >         return instruction_pointer(regs);
> > --
> > 2.34.1
> >

--Gejlf3F12x47mKDN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZO2PrQAKCRB4tDGHoIJi
0sQOAQDv1oVj7wyYwRi92joynjdOE3DDV2OuEjEbpfrv+eqJjAD+LnNdnWqsf6EW
vXpfa5K8Smd+td9s9Q04/KE8pPsWaAk=
=+9ci
-----END PGP SIGNATURE-----

--Gejlf3F12x47mKDN--
