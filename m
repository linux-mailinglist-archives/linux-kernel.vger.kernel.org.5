Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA2878FD06
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344770AbjIAMSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjIAMSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:18:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF73EE7F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 05:18:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F3E1CCE2261
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 12:18:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F2DC433C8;
        Fri,  1 Sep 2023 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693570680;
        bh=65SHd3Lk65GobobEgch5K3BKyQdNfkhl/GLrH+SUHnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hSqW2QbQYv9+zEQtkSzlQCjcVqNPRnjJaeuy+RkrFM5Nr/ebjaDTTgskf7OfKguLU
         22oeBasuXAi8Yi3gBAVzj39f4s2uhW58BKn/MLfevCRP3KfssxmvP6xgNe1JyrQNdC
         0EJd/jJwIvoWe9v1SGc5WepfrxtbFY6FeWNszdEbcYc/CHTUgZRvYeCskbJEpy9BoS
         kuIanU6eYIBVcLhh/6hfiWp3p3zb/SdvuqYcFNCbpSMvwXR9QafiE5tOG794Im7I7T
         36SNYBaxjOVHvb9KzGQv+gjPMO+NEE18r0GQMh0LPjF4vbtzKPLvZd+Qfvd+RcGcVF
         O+PNp+IFBB2TA==
Date:   Fri, 1 Sep 2023 13:17:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     zev@bewilderbeest.net, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] regulator: Add uapi header
Message-ID: <a5d9add7-d96e-451d-8481-559562e0c1b0@sirena.org.uk>
References: <20230831121412.2359239-1-Naresh.Solanki@9elements.com>
 <813261e9-71d8-4fb6-aab0-474915662598@sirena.org.uk>
 <CABqG17hrfLMynD0OKurfR2694ak0LN0pnpK82DOPqDAW-rhO0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uwqpRHM+rwlwCh7P"
Content-Disposition: inline
In-Reply-To: <CABqG17hrfLMynD0OKurfR2694ak0LN0pnpK82DOPqDAW-rhO0A@mail.gmail.com>
X-Cookie: Dealer prices may vary.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uwqpRHM+rwlwCh7P
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 01, 2023 at 12:04:13AM +0530, Naresh Solanki wrote:

> If you still insist on string based then can you please elaborate on it.
> Is the events attribute is expected to print string of space separated
> events like
> for REGULATOR_EVENT_ENABLE -> ENABLE
> And even multiple events like: 'UNDER_VOLTAGE REGULATION_OUT'

> Let me know your thoughts.

You'd need to have a file per event, the string would be the filename.

--uwqpRHM+rwlwCh7P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTx1nMACgkQJNaLcl1U
h9Awjgf/WGbrh/3MihFSGnJgUW3eUSFRjwJ1U8Iquzv52pwWu56xNWffcRvMhxBz
ICYn89dhMuptJxjiRUeKb6XCJZJUif4x6turxkQnSOwlAypztkAwuD5HHbPlIPtF
FETex0yS83Y/AK768SkQuTodVqRqgoiLEIVBcaNEtYQ3lUHgl1M4zp5pUVQOqEnm
NsQ8noY9slkzBx0dIBqfKIqIcH1NhHAdySn+gOupDaH0v/ryLnqiIv4Z/JhaBLN/
LlzKG/wP0EBfv/M7wPmnsekGlFfABJSeg4gKqtXHg6ffbUjxpSsq+H4Xe89gXkJs
ljOZPXkkNWmGWDyh5x9RlPu5QRGjhg==
=4kqg
-----END PGP SIGNATURE-----

--uwqpRHM+rwlwCh7P--
