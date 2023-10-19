Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDB17CFE05
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 17:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346271AbjJSPgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 11:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346331AbjJSPgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 11:36:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D326B182;
        Thu, 19 Oct 2023 08:36:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B50DC433C8;
        Thu, 19 Oct 2023 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697729773;
        bh=9q3HhsAdxkMSqIHsAAZ7hVVBLyVJc25//snPL/y8h1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gRV3zdlwfs/mSoLE/68IWJStNeBbha5bB3aHj7BDeh+Ay/bFLM8c3MKR6Wg7n2Nbn
         OeuM0LYwdLUxnpJqt79qMg3Ae8fx/eJQ9ABhX9FNDzj2vNYEsI97lVErXWwY15mdxC
         NVM3xGKlZK1LcFaf2H97Sip96mxeItJ4usf3noCPSIojeYNUWPCvKCa0Wq3jPCmhKP
         QAtzGYPzRmQ+qqtfFIpEVGJo+Di0H6hjL4Iz3+3Px8gBWBabNcYri5rQ0ccWK2XIjd
         jEM1S7KvZB9Wpp+RefZt/J9rSY9jWYvPk70ORf4SuNvrS44leRt9W3QaidXSEuEvdg
         oF8/D4WYVH8iw==
Date:   Thu, 19 Oct 2023 16:36:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: linux-next: manual merge of the kselftest tree with the
 mm-hotfixes tree
Message-ID: <038eb23d-f74f-43c6-91e8-762e6bbc7282@sirena.org.uk>
References: <20231019163310.6c24d6ac@canb.auug.org.au>
 <1ee483d6-3311-42b1-a3e0-3b6073913a21@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DTFmdvUpl3i2yoH6"
Content-Disposition: inline
In-Reply-To: <1ee483d6-3311-42b1-a3e0-3b6073913a21@linuxfoundation.org>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DTFmdvUpl3i2yoH6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 19, 2023 at 08:49:24AM -0600, Shuah Khan wrote:
> On 10/18/23 23:33, Stephen Rothwell wrote:

> > I fixed it up (I used this files form the latter commit) and can carry the
> > fix as necessary. This is now fixed as far as linux-next is concerned,
> > but any non trivial conflicts should be mentioned to your upstream
> > maintainer when your tree is submitted for merging.  You may also want
> > to consider cooperating with the maintainer of the conflicting tree to
> > minimise any particularly complex conflicts.

That'll drop the fix that Tiezhu did which is a good one.

> I can rebase linux-kselftest next to pick up the following once it goes
> into Linus's tree.

I've got the rebase/rework locally (I did it as a new commit which isn't
ideal but it's such a complete conflict that it felt like the best
option).  Assuming nothing blows up in my local CI I should send it out
later today.

--DTFmdvUpl3i2yoH6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUxTOcACgkQJNaLcl1U
h9Bv1gf9Hc4eaSUYZmGh/lRCxEFa56zuauD0fPTqXWL4iz6cl7ptwPxQsrMpxHWV
dCzIXI9UesyWf7YSmHZ5VNDmX2f60ZHOwR4qJhddg6oraq9KZYr1MP1CrQ6bl87K
mlUz4/zzFTVEHK4zNGQBeKHUkhjAtuzbmB+VfEtlApKD/6v+RidTDcQZ/OPC17/P
tkivM1YNh4xXHzmZuA5n1vu/ICI1t0sKs76E1gL8FIf8yHlYXrzS/lstED6rmdGY
PwxYsDlbjscwJUGYieeM+yPFKtPVZtg9gO9d6KRU9IKH8m51Xw/lXvC1fEAhqTfr
odo+u0ickOuSriXPTgBd/uiuFFkYqg==
=mN4r
-----END PGP SIGNATURE-----

--DTFmdvUpl3i2yoH6--
