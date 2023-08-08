Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6592774710
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjHHTJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233282AbjHHTIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:08:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E67E67C7
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:30:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2052D62497
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04B69C433C8;
        Tue,  8 Aug 2023 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691490626;
        bh=SPAy6eRxInTV27hAHN7hrh7bz66HIoGmfibRbIsJlNc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FN8Qv+wGJ57hL9moCI/O2xbu0fndzE0Ij633wrVw1sF8XAkrm7oPOuhyPHLBmFlUa
         CyWLXKylcYhDReLRicHZOX5u7c7VM1OVpFziFL5SrY3nfCXBzuy90MPhtR4dR7QQIH
         buhwz3JAOi8QViIKQ/Uo3817x5FR2MHZudYhrk24D//c6Bxx3IyhhKg+v26lWf5YTL
         E5RAmfVK/dRdB0qW2xUbTaMWY0WXEf05IV7ZE9sNxLtq+H+DAsMPQx7TKJY3WODbRi
         QywJrqDQRRw9GR1tCzHVdnsTxEoj4E7VPYr6SdWl1BqT7hB0QuzCztIvdgLFgoDW2i
         CNdO8u5/tUs9A==
Date:   Tue, 8 Aug 2023 11:30:22 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Vincent Chen <vincent.chen@sifive.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC PATCH v1] clocksource: entend the max_delta_ns of
 timer-riscv andtimer-clint to ULONG_MAX
Message-ID: <20230808-essay-paprika-886382801149@spud>
References: <20230808045145.3552312-1-vincent.chen@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v7X+xlEC8KdFDfPN"
Content-Disposition: inline
In-Reply-To: <20230808045145.3552312-1-vincent.chen@sifive.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v7X+xlEC8KdFDfPN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Vincent,

On Tue, Aug 08, 2023 at 12:51:45PM +0800, Vincent Chen wrote:
> From: Vincentc Chen <vincent.chen@sifive.com>
>=20
> When registering the riscv-timer or clint-timer as a clock_event device,
> the driver needs to specify the value of max_delta_ticks. This value
> directly influences the max_delta_ns, which signifies the maximum time
> interval for configuring subsequent clock events. Currently, both
> riscv-timer and clint-timer are set with a max_delta_ticks value of
> 0x7fff_ffff. When the timer operates at a high frequency, such as 1GHz,
> this causes the system only can sleep for a short time. For the 1GHz
> case, the sleep cannot exceed two seconds. To address this limitation,
> refer to other timer implementations to extend it to 2^(bit-width of the
> timer) - 1. Because the bit-width of $mtimecmp is 64bit, so this value
> becomes ULONG_MAX (0xffff_ffff_ffff_ffff).

You've marked this as RFC - what is it that you are unsure about that
prevents this from being a regular patch?

Thanks,
Conor.

>=20
> Signed-off-by: Vincentc Chen <vincent.chen@sifive.com>
> ---
>  drivers/clocksource/timer-clint.c | 2 +-
>  drivers/clocksource/timer-riscv.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/time=
r-clint.c
> index 9a55e733ae99..09fd292eb83d 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -131,7 +131,7 @@ static int clint_timer_starting_cpu(unsigned int cpu)
>  	struct clock_event_device *ce =3D per_cpu_ptr(&clint_clock_event, cpu);
> =20
>  	ce->cpumask =3D cpumask_of(cpu);
> -	clockevents_config_and_register(ce, clint_timer_freq, 100, 0x7fffffff);
> +	clockevents_config_and_register(ce, clint_timer_freq, 100, ULONG_MAX);
> =20
>  	enable_percpu_irq(clint_timer_irq,
>  			  irq_get_trigger_type(clint_timer_irq));
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/time=
r-riscv.c
> index da3071b387eb..b25c91d41968 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -94,7 +94,7 @@ static int riscv_timer_starting_cpu(unsigned int cpu)
>  	ce->irq =3D riscv_clock_event_irq;
>  	if (riscv_timer_cannot_wake_cpu)
>  		ce->features |=3D CLOCK_EVT_FEAT_C3STOP;
> -	clockevents_config_and_register(ce, riscv_timebase, 100, 0x7fffffff);
> +	clockevents_config_and_register(ce, riscv_timebase, 100, ULONG_MAX);
> =20
>  	enable_percpu_irq(riscv_clock_event_irq,
>  			  irq_get_trigger_type(riscv_clock_event_irq));
> --=20
> 2.34.1
>=20
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--v7X+xlEC8KdFDfPN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNIZOwAKCRB4tDGHoIJi
0nffAP9yFlzcoMd/80yugZDiFMKJu81C1XRHyWzdM7qZjTPZlgD/cVQNjuhSeQi1
qt5EOYcb1Z26fPlCBy5mcjcsBxSunQc=
=nO0O
-----END PGP SIGNATURE-----

--v7X+xlEC8KdFDfPN--
