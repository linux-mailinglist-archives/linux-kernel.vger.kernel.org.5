Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD86675B4F3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjGTQsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbjGTQsh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:48:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6147C1715
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:48:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E927E61B7F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 16:48:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC4AC433D9;
        Thu, 20 Jul 2023 16:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689871715;
        bh=O7hvPEsA3AiqsX5BWwDH200Ixzbu48Olxgtg3+mkbCw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaSMYusal0PvVy01tmmI/xV+/0tdXb7MjQn7x4PUKkMxUhlvDKuw9XF2/chMGIYJ3
         nHCiDfJMiLB/Wxd09Vuk7fWc4qZaMtdcr5GRQA6w6lyUbOloZdk14iPEZBICNaavYK
         CJP1evKJMQBl7vdBYK3+znMEUGi2sPCv1C9pu7nN6qgcrqrVt38pzz+hFQ5baDdeq5
         Lf68JKok/MA/vtVp5+NxkSnokOoK37vLx1i3sTOfndrtqYwZvP7yYXtC/2plAdNeXz
         kTMw2B8J4Ks+feed4/VuaVQCj4YsUNm9tvjiExlU3PlO2ySkTTs1Kqx9HSww5JY7X2
         WO7Z/+GskV4ew==
Date:   Thu, 20 Jul 2023 17:48:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Traceback with CONFIG_REGMAP_KUNIT=y+CONFIG_DEBUG_ATOMIC_SLEEP=y
Message-ID: <0e64a83a-fb53-48c4-b790-8e8dfa888ef3@sirena.org.uk>
References: <ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net>
 <336fc14e-f734-49ea-97ce-802f03fa4422@kadam.mountain>
 <198c4edf-045c-8d85-1d5c-018378eeb490@roeck-us.net>
 <055f2564-551d-4b5f-a6e3-d54ae104d5c9@sirena.org.uk>
 <d29552c2-f20c-cf68-76ae-e03a2cc7e0ba@roeck-us.net>
 <12e6144c-0d24-4556-beef-d754273992e4@sirena.org.uk>
 <e3799cbf-daf2-c805-4c70-09679c4b6cf5@roeck-us.net>
 <9595effb-e01c-6c5c-362e-b8e8ad364fd7@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9rqWvBLsjc3bRaXd"
Content-Disposition: inline
In-Reply-To: <9595effb-e01c-6c5c-362e-b8e8ad364fd7@roeck-us.net>
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


--9rqWvBLsjc3bRaXd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 20, 2023 at 09:41:42AM -0700, Guenter Roeck wrote:

> After adding the GFP_KERNEL -> map->alloc_flags changes to the maple tree
> code while skipping the init functions, I no longer see the traceback.
> This is without my patches.

Ah, excellent - yes, that should sort it.  I've already queued your
original patch for CI for 6.5, we could then apply both your new patch
and Dan's for 6.6 to support anyone who for some reason does want to try
dynamic allocation at runtime in atomic context.

--9rqWvBLsjc3bRaXd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmS5ZV4ACgkQJNaLcl1U
h9BjdQf/YGXJWl0RtGYYej01F84n9TZsha2Ht0LzhS7bymXZpU02zAGN7hnzujxi
1yrpv8bdUibK26T7jDDIn3Ch1A+mJqtjfcAyUjoPkX0RiyOk/L+1HGv4IkQRx7Cb
mI3yAQbuhLT8jVTsUbYpb/GFl+uFUPwVFGwvhg4bKcj5d+BHNsuErrp4pGV1WMtk
4CizLMBfrW/9uDvFMqnd4H0W29bOkTbX39ZWVzXKpRRCiBCAUBQ1TOiCmSs/xCwc
zkuz0WP0KbU+T11VwZ9WRjml0lB71AMdM1nywWP3eqhZ4bEGsla8WUlCir+PFQY2
Op1pFXf+FV5kKf7g1eVOSRdd4ZtbQw==
=E46E
-----END PGP SIGNATURE-----

--9rqWvBLsjc3bRaXd--
