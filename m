Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1B8793780
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 10:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234922AbjIFIxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 04:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjIFIxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 04:53:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830ADE9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 01:53:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE238C433C8;
        Wed,  6 Sep 2023 08:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693990423;
        bh=5wNOSjCIX53yHAgpQLo0J4zmOqYAVrchHwwqh30SC7Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s1y29nBsWXmlMVHy3xSgWYEygjSdrTYSz9K4QQPTZdIAqPF90X1ZXjE6nnX0xBujU
         r8C7aA3vvbH7pYGfT9ijqp8SgMPdeVrxaT+RVt1yS6COeGb84eA0EsSxRiZ+ynxFyr
         PR1e8xepjVNkTLvrEYN9NqIea5exCdW4roBOhcRdDIRhqpUvILk+oXeSwzXVd0Mzpp
         /7jWcjLIEoaPcZEanwh2kKbbwMrbiWZaLQDg9UOoHpJbaCPSCq7JpZxJpVNY6ZhvpM
         zMGwwd/IX2U4p9BktldU77x7rTxSXXbylXRhXF+qzI3/2JoEI7eWChJ3YhDvSyCD1e
         0fmlAKwFxdd8g==
Date:   Wed, 6 Sep 2023 09:53:36 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jiexun Wang <wangjiexun@tinylab.org>
Cc:     guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, falcon@tinylab.org,
        jszhang@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH] modify CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK in riscv irq.c
 file
Message-ID: <20230906-b33d3ce6a85d5cf0493c031a@fedora>
References: <20230906062414.254602-1-wangjiexun@tinylab.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GuWpPX9xt59am0gl"
Content-Disposition: inline
In-Reply-To: <20230906062414.254602-1-wangjiexun@tinylab.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GuWpPX9xt59am0gl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2023 at 02:24:14PM +0800, Jiexun Wang wrote:

$subject: modify CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK in riscv irq.c file

Please use a subject line that matches others used by the subsystem.
I guess in this case it would be something along the lines of:
RISC-V: Fix use of non existent CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK

> If configuration options SOFTIRQ_ON_OWN_STACK and PREEMPT_RT=20
> are enabled simultaneously under RISC-V architecture,
> it will result in a compilation failure:
>=20
> arch/riscv/kernel/irq.c:64:6: error: redefinition of 'do_softirq_own_stac=
k'
>    64 | void do_softirq_own_stack(void)
>       |      ^~~~~~~~~~~~~~~~~~~~
> In file included from ./arch/riscv/include/generated/asm/softirq_stack.h:=
1,
>                  from arch/riscv/kernel/irq.c:15:
> ./include/asm-generic/softirq_stack.h:8:20: note: previous definition of =
'do_softirq_own_stack' was here
>     8 | static inline void do_softirq_own_stack(void)
>       |                    ^~~~~~~~~~~~~~~~~~~~
>      =20
> After changing CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK to CONFIG_SOFTIRQ_ON_OWN_=
STACK,
> compilation can be successful.
>=20
> Signed-off-by: Jiexun Wang <wangjiexun@tinylab.org>

What commit does this fix? Please add a Fixes tag pointing to it.

Thanks,
Conor.

> ---
>  arch/riscv/kernel/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index a8efa053c4a5..a86f272ae2c3 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -60,7 +60,7 @@ static void init_irq_stacks(void)
>  }
>  #endif /* CONFIG_VMAP_STACK */
> =20
> -#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
> +#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
>  void do_softirq_own_stack(void)
>  {
>  #ifdef CONFIG_IRQ_STACKS
> --=20
> 2.34.1
>=20

--GuWpPX9xt59am0gl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZPg+DAAKCRB4tDGHoIJi
0skmAPoD9GzpHpslzuAmWSRHYROTN2Bqb8oxwJdw+C1CZAfLjQEA+jtxEH9f9xJP
XUP7VsZ6Ewv8Z4/KePbod37z0xBbtgU=
=pGJA
-----END PGP SIGNATURE-----

--GuWpPX9xt59am0gl--
