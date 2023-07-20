Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6C175B4A1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjGTQiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231536AbjGTQhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:37:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ED92D56
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 752A561B75
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 16:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D09C433C8;
        Thu, 20 Jul 2023 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689870971;
        bh=lLVbwlvSneF9kalZkrAQVBEp6JOJfRh7MRh7iEhEshI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/5lDXQzBI4Ic2qzdpwkM2BbLqdj1ze4TCC+kXiIW8vHch/98E21Nqj7Olg5J6+bz
         dtTpzxJOhC9EJDFLp62CiMcB3p9VMDZ5zbgDrjDPPHchwAaFLbZ6tfaeCmC6vMTaOD
         AxWge01GKcRrQf7SNyncAi0EPLnSHrgomu0mA6lR2gVy38E4t/eKhMe6JSqcWcO1Wc
         HoD7Je2Npd7vE9FoAST+XuzuAsrfGTlNReAiywFu3KpjZbXekE1M4jdMZP7Q2nxYym
         Guyd6Gu7wOKn4dnzR1JyjUvxgJxd8i7YAeASLxeWge8StByu/9UZh0ybm7B71mx0BD
         1TKze3+Yd0TyA==
Date:   Thu, 20 Jul 2023 17:36:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Traceback with CONFIG_REGMAP_KUNIT=y+CONFIG_DEBUG_ATOMIC_SLEEP=y
Message-ID: <048530b2-8eb5-4c57-b01a-49ac88c3c936@sirena.org.uk>
References: <ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net>
 <336fc14e-f734-49ea-97ce-802f03fa4422@kadam.mountain>
 <198c4edf-045c-8d85-1d5c-018378eeb490@roeck-us.net>
 <055f2564-551d-4b5f-a6e3-d54ae104d5c9@sirena.org.uk>
 <d29552c2-f20c-cf68-76ae-e03a2cc7e0ba@roeck-us.net>
 <12e6144c-0d24-4556-beef-d754273992e4@sirena.org.uk>
 <e3799cbf-daf2-c805-4c70-09679c4b6cf5@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p/7KVl6ZkPAy4BGn"
Content-Disposition: inline
In-Reply-To: <e3799cbf-daf2-c805-4c70-09679c4b6cf5@roeck-us.net>
X-Cookie: Ginger snap.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p/7KVl6ZkPAy4BGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 09:25:42AM -0700, Guenter Roeck wrote:
> On 7/20/23 08:07, Mark Brown wrote:

> > Like I say I don't think it's an either/or - we can do both
> > independently, they both make sense standalone and don't conflict with
> > each other.

> I guess I am missing something. I have not tried it, but wouldn't my patches
> be unnecessary if Dan's patch is applied ?

Dan's patch doesn't cover the maple tree cache so there's still an issue
there, but yes once Dan's patch is applied (assuming it covered all
cases) the tests should run fine modulo any issues caused by trying to
do atomic allocations triggering us to fail allocations on smaller
systems or something.  My inclination is to do things like that in -next
and send your simpler approach to Linus, though it's really not
something I think it's a good idea for anyone to actually try to use.

--p/7KVl6ZkPAy4BGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS5YnUACgkQJNaLcl1U
h9C+rwf1HjE686LAPt/mf+1LT3w/S6I+2OM9jhknkKqZFFR7LUTn3FuKziRoM8GF
l/SMJNpRmsXhJS9ceyAROwXKPbUJvJG/wlRcZ0ARlFzFVtyp5ZsWPIgIkhTBYInn
fGD2UJTcC0/coFdOTPUz7B/8iCQ8n1dTmjcUMatd8iTCbZucMMCPKqJZ59ia29HI
aHN4cGrjnggUSLEPeIgOslEdRkhL4ZouObhb3qvNN0QMTLdsLksPf9LfImoeqiTg
vPrVx370uOgPe+4bgrHCI2jJPrJDRMdhojkYAgsj20QTqpVrTuc6WF6kJUt02QfV
QTmIjQ6YfANzGM0rXUFqpzr/nkVs
=Cj0x
-----END PGP SIGNATURE-----

--p/7KVl6ZkPAy4BGn--
