Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B091A78ED3D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 14:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346284AbjHaMgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 08:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbjHaMgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 08:36:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F5DE49
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 05:35:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9A40B82288
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:35:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807E3C433C8;
        Thu, 31 Aug 2023 12:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693485354;
        bh=c8c6hZgdJXVkuqafYsMDSH56QRo8GHKScMeGvOBZOBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZMQ9HHq1y/DcOCHKMBXqebO9stCM5l9qnOcso+I55AJIpkpPlloFhyZhG8wGKdXk1
         4BMGmuh9qIrNLRRggRqTIRnY9mjhCfOzleE7ocwqA5jVacexbmapWEnbWB4ZF7hp7f
         1tD5LGVKYTTB0tELx35fGHDnuj5SVhuIm1maE8ac4KeRSNTl6uzh7DNcOSDPfxpj1h
         cnHbldC9kWCpANf+thTK7d17z006/PLX9MbI9x6qwvgY4Skq8rntWN6zcH35aiLWHf
         TtWMMotAx9qh6X5DaUlHoQvce1vvSmU3wfvJ7owvp6zewsB6+oRA1DkRWlDDPkoc+R
         cp6lMWwLMD7AA==
Date:   Thu, 31 Aug 2023 13:35:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] regulator: Add uapi header
Message-ID: <813261e9-71d8-4fb6-aab0-474915662598@sirena.org.uk>
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="USLdL0WA7M+Hr251"
Content-Disposition: inline
In-Reply-To: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
X-Cookie: "Pok pok pok, P'kok!"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--USLdL0WA7M+Hr251
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 31, 2023 at 02:14:08PM +0200, Naresh Solanki wrote:

> +#define REGULATOR_EVENT_UNDER_VOLTAGE		0x01
> +#define REGULATOR_EVENT_OVER_CURRENT		0x02
> +#define REGULATOR_EVENT_REGULATION_OUT		0x04
> +#define REGULATOR_EVENT_FAIL			0x08
> +#define REGULATOR_EVENT_OVER_TEMP		0x10
> +#define REGULATOR_EVENT_FORCE_DISABLE		0x20
> +#define REGULATOR_EVENT_VOLTAGE_CHANGE		0x40
> +#define REGULATOR_EVENT_DISABLE			0x80
> +#define REGULATOR_EVENT_PRE_VOLTAGE_CHANGE	0x100
> +#define REGULATOR_EVENT_ABORT_VOLTAGE_CHANGE	0x200
> +#define REGULATOR_EVENT_PRE_DISABLE		0x400
> +#define REGULATOR_EVENT_ABORT_DISABLE		0x800
> +#define REGULATOR_EVENT_ENABLE			0x1000

I'm not sure embedded the raw numbers in the UAPI like this for just one
driver is ideal - it might be better to do something string based,
though that would result in us ending up with a file per event which is
a bit noisy.

--USLdL0WA7M+Hr251
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTwiSIACgkQJNaLcl1U
h9B63AgAgiEcXKsVY1ELYCVzWS57lp/pKdjjCMYFrSkqNGTu1lwPcX3+2SGUTUra
MG7D4fPkR5bAU4jcL7lLVTuRBW92Jhe7XTrdvxYEpV4EjdkBMU8yho9s0d+xsFcH
gX5ralz/SW0ltpkXkm+TtRtZt6tEPt6WjMWkMNIIN2iic/N2WFaeXObqlgDHC5Ee
zv1aDFUMqrIH+huHmHcmsAjAm4lwC11MxOtpcPfxttgWLtWEksSb/gjyY5Re9myG
MdvubGo3B8joTNusNI6tCVldpmg18j9qdIAQMeNa1oNYkHOgmyuH3La07W15EGPb
t53qxGxs5FphgFNCDvqDPMtkvAJa5w==
=tS+Y
-----END PGP SIGNATURE-----

--USLdL0WA7M+Hr251--
