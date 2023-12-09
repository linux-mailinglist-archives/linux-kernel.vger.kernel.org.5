Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2639F80B484
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 14:09:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjLINJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 08:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLINJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 08:09:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E9BAC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 05:09:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783C1C433C8;
        Sat,  9 Dec 2023 13:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702127389;
        bh=BXmvRrbuQ7Zo9bps7+7CLsTiu05XaN6dU9PEwdxs+ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S6jE7XNTUdBp/jI1nNZw36YjJLxRXIwjeEtof8D9IiRzLKGfNItYmAr+VT2iAQ38c
         38YNmmUUIYntBWbwZ9cGSSxaGQim7h9NbXYE8xNDouYR8+TMgLcesHT+cipBw2tgX/
         4lThPROQalN7MagIZParOBO4e1O2Pg4g6V0ixyjV2R33hTQ+sgi2mNYzJWJbwJzmJw
         rUnZe+RUTAfAHW4aOwHkof8lj7+6t1uk4lf7Y6WTHOwc+fOGo2/av3fMhf6zCZfn9v
         KMPF5McGv4f6VX8d9RocfRsJKSW7FslB0ZP2s+OE7BGvUVe1zwkJUq28+7u8No8Z/8
         zs4EO1JDtaj9w==
Date:   Sat, 9 Dec 2023 13:09:45 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>,
        Deepak Gupta <debug@rivosinc.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Florian Weimer <fweimer@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v7 24/39] arm64/signal: Set up and restore the GCS
 context for signal handlers
Message-ID: <ZXRnGbYI+uq7m9sA@finisterre.sirena.org.uk>
References: <20231122-arm64-gcs-v7-0-201c483bd775@kernel.org>
 <20231122-arm64-gcs-v7-24-201c483bd775@kernel.org>
 <8734wcgj79.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="37w+xraunaVzWRvI"
Content-Disposition: inline
In-Reply-To: <8734wcgj79.fsf@linaro.org>
X-Cookie: You might have mail.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--37w+xraunaVzWRvI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 09, 2023 at 12:15:22AM -0300, Thiago Jung Bauermann wrote:
> Mark Brown <broonie@kernel.org> writes:

> > +	/* The cap must have the low bits set to a token value */
> > +	if (GCS_CAP_TOKEN(val) != 0)
> > +		return false;

> I found the comment above a little confusing, since the if condition
> actually checks that low bits aren't set at all. Perhaps reword to
> something like "The token value of a signal cap must be 0"?

Right, that's bitrot from the previous token format.

> I'm still not proficient enough in GCS to know how exactly this could be
> abused (e.g., somehow writing the desired return location right above
> one of these inactive caps and arranging for GCSPR to point to the cap
> before returning from a signal) but to be safe or paranoid, perhaps zero
> the location of the cap before returning?

Right, ideally we'd be doing a compare and exchange here to substitute
in a zero.

--37w+xraunaVzWRvI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmV0ZxYACgkQJNaLcl1U
h9AoDgf/VkzebhdvDSlUlS84JXdoOeqvCdQEoqmGKLcuFu0afYS5oNsgjYoWfoXD
aoXaZBnOjvf3Wmp5hO2MtDSGOlnNYMS9btFUd+2docNaeKRynVrPd2hEwST4I/yq
ZeT2mGf5o2wyv6qxW6RsXkgz4UUscznq2pitjl0x4ca+pOIeX+qxPQjayUJhPGtL
Us1MullRxipMfAZE5H9eGQ5UrEO940lmaqa3GOexHuqAmzs/znZexqoZYXOStiBS
DTmANL89uVAgAarTtMNsXKkO8mOZ8D9pNtu+zPEO0JNSrVzQgDD363lTYbIjKz5P
QroAHMW7izjjkY7CBtP6RwOmok0Uvw==
=u7l1
-----END PGP SIGNATURE-----

--37w+xraunaVzWRvI--
