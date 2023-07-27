Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8364F764B29
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232560AbjG0IOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjG0IMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:12:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06D4658A;
        Thu, 27 Jul 2023 01:08:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 15D9E61D96;
        Thu, 27 Jul 2023 08:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154E2C433C9;
        Thu, 27 Jul 2023 08:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690445234;
        bh=kEMX5vYmAK+1z5HfoJdExkrb1Pppilb2DBlJXxEWNAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N/uBNuy2WeU8HhMnrHUKVPbQolOoxTBdaarY5kQnlUYV1vDjrcCdkWiXeFb4JbIIh
         RrFBo2yI4ChpO7AW/5Vy4vLPG2Mo/JGcgwryfIKV1F7vKl0p2x0s6+qHNOdCrApIjm
         Ru6Z/Bj4Pbpkj0F85ts5pzR6lt4kgad4Qhm8fFtJrZ5kX3dQ0q1HrKas/FNBeIfjI8
         D2b8IOwh9np2ryPHAX7rDyT6+WTUQlrvXAjkygs9V/QsnkQZkBFyfOl1s767jvcIQx
         ismyg+MeD3MOPrCyM+YmhibPZMbdoAM7OHzeMlRjZRKRmQ4ei1p1dJmCoaswN9re4i
         BhY8jg0uJnJAQ==
Date:   Thu, 27 Jul 2023 09:07:09 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Carsten =?iso-8859-1?Q?Spie=DF?= <mail@carsten-spiess.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: add renesas,isl28022
Message-ID: <20230727-prong-crimp-0c758681172c@spud>
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-3-mail@carsten-spiess.de>
 <f8fdc8d7-6ac5-5e20-10ef-7417d79c1b91@roeck-us.net>
 <20230727093528.594ce3a7.mail@carsten-spiess.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OPtzLY3pv5H2w5QG"
Content-Disposition: inline
In-Reply-To: <20230727093528.594ce3a7.mail@carsten-spiess.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OPtzLY3pv5H2w5QG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 27, 2023 at 09:35:28AM +0200, Carsten Spie=DF wrote:

> On 7/26/23 18:14, Krzysztof Kozlowski wrote:
> >> +  shunt-gain: =20
> > 1. Missing vendor prefix (does not look like generic property)
> > 2. -microvolt
> > And then enum is for 40, 80, 160 and 320.
> replaced with
>   renesas,shunt-range-milli-volts:
>     description: |
>       maximal shunt voltage range of 40mV, 80mV, 160mV or 320mV
>     $ref: /schemas/types.yaml#/definitions/uint32-array
>     default: 320
>     enum: [40, 80, 160, 320]

The point of using -microvolt is that it is a standard suffix:
https://github.com/devicetree-org/dt-schema/blob/c1e73ebea9fc07f7d7848f3043=
01f755f1278a67/dtschema/schemas/property-units.yaml#L101

--OPtzLY3pv5H2w5QG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMIlrQAKCRB4tDGHoIJi
0ldLAQDY89Fp4G5KjdiAN0mlbIPAAe8VYldm167TUVgvOTUW9QEAmtxt6mqt+AaN
DKSnofC/QUzAU666DQGiCG7Uknrv+wA=
=Oiex
-----END PGP SIGNATURE-----

--OPtzLY3pv5H2w5QG--
