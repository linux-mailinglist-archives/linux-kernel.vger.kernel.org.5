Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50706763590
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 13:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbjGZLrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 07:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjGZLrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 07:47:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065A211F
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 04:47:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27A1861AAC
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 11:46:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20B9AC433C7;
        Wed, 26 Jul 2023 11:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690371981;
        bh=dAp4BNJNJH/d3AmIaKc5T+to6cpcXyviuNT4hR0/s4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vHWAliZ8vLwDuIZxKVhemJ8i11vBN6e4rLnrlN4kIhpyIPxJo1trGprzP7SgfNTkP
         3vqB/UwlzeIOJ8Re1p63fS3Ipu/gnlixiIRlaj9u1LlCQQJIvgE1oLo6aJvAY4uRY+
         sIwm230ZIKDuAohucG8AvVGEh4NW+HhpNMZNdIZ8ezBci9s17sD9lJBwqRTszY8CKp
         OKNjh34YOHqq6pxqGTcNqAFxfHGRDikyw8cihAyFuU9+ad7fNpDKs/I8mon74D8zM+
         HlVSYY4Z/L0Rxzckh1+tIL4O8zD6EDlLioPswI2BxcPfi9bgxg0TsZkQMSDlzNVAW0
         cuNzxltB5DIRA==
Date:   Wed, 26 Jul 2023 12:46:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Willy Tarreau <w@1wt.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH v1] tools/nolibc/stdio: add setvbuf() to set buffering
 mode
Message-ID: <a211cedb-8592-4dea-af2a-1818279c66b1@sirena.org.uk>
References: <20230726070655.2713530-1-ryan.roberts@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+QvQ8+Vs1lLg1c85"
Content-Disposition: inline
In-Reply-To: <20230726070655.2713530-1-ryan.roberts@arm.com>
X-Cookie: Life is the urge to ecstasy.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+QvQ8+Vs1lLg1c85
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 26, 2023 at 08:06:55AM +0100, Ryan Roberts wrote:
> Add a minimal implementation of setvbuf(), which error checks the mode
> argument (as required by spec) and returns. Since nolibc never buffers
> output, nothing needs to be done.

Reviewed-by: Mark Brown <broonie@kernel.org>

--+QvQ8+Vs1lLg1c85
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTBB4gACgkQJNaLcl1U
h9Cn9wf/eiOyOMcK5bwMhTS8QEEw6mKz5tXnvsmjhR5B8RHqt8JsrxCzyFaWcP5a
2kslRbmMrgzvEKlQAZV3o1ZvUT5TRn0PR5dvWaJ2Y1ljNt0hi6snalBvvIZ/613w
u6j9g+dkIuJGfxVWuQadlJEBTvYrnlkxel1EZwcATnF89TlKCbo2o2aTS+QLbOd1
qv6IVNb7Xg5Jf3hwfXRVeIwjhRn9Xr6QhXfS7Y0xwNnqRo18+Rjms8COYGihhVnE
ZoL4O2TDb7ovmoIT8XgtmNcV3zMpje4l8ewB8LVnSnNcORnrGh7NidQ7uV3wRMR3
r9wdL/xglIaMSGEOBRTKOdLGXK0VeQ==
=0LaI
-----END PGP SIGNATURE-----

--+QvQ8+Vs1lLg1c85--
