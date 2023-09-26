Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8F47AEF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234962AbjIZP0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbjIZP0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:26:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8326116
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 08:26:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9F0C433C9;
        Tue, 26 Sep 2023 15:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695741986;
        bh=ZGYyCc6CIIBivc6/wxCC7ViDDLrwq+QNVGfQBsotRe4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZMQfxvKwL0K76HILlohedzuIU2vpmNA6QrGa4av6KgdjG9MIT4v1GuWtcBzOJowLl
         IIaC1gKDKq/0kNp5KfvKhdskcXFVsYJsF5KBUueXgWkry8slix7aueHWlnuUjpjhSl
         4dhNTqpEol5wPdXJVCtxLHPllP/fDy+SgaJy/w1VfSBm6vuPmScaruV3jRDZedDfzs
         KcwPZr64uZgWaoYO2u64K56XLWqpenx83vac4YXhaRlepzKV41nFAdxzkahhv9ysqj
         ZZDo1Wce9cL56bQQLI2P3bvkcuKtuk73fD46WT/i3+1K3EHqfhzkqKopwepGVzC0U2
         32pVcRIA0V83Q==
Date:   Tue, 26 Sep 2023 17:26:23 +0200
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH v2 2/2] regulator/core: Revert "fix kobject release
 warning and memory leak in regulator_register()"
Message-ID: <ZRL4H5Y+liHwXPlF@finisterre.sirena.org.uk>
References: <b5b19cb458c40c9d02f3d5a7bd1ba7d97ba17279.1695077303.git.mirq-linux@rere.qmqm.pl>
 <d7f469f3f7b1f0e1d52f9a7ede3f3c5703382090.1695077303.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fKmCH6XwVYiEfMBv"
Content-Disposition: inline
In-Reply-To: <d7f469f3f7b1f0e1d52f9a7ede3f3c5703382090.1695077303.git.mirq-linux@rere.qmqm.pl>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fKmCH6XwVYiEfMBv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 19, 2023 at 12:50:27AM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> This reverts commit 5f4b204b6b8153923d5be8002c5f7082985d153f.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--fKmCH6XwVYiEfMBv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUS+B4ACgkQJNaLcl1U
h9Ce7ggAgE+JouppKB6D/JdUxJ3wpKMhLQJiWZ8GeSaiDsIiHR4TtmBrjJTIDJVJ
9+XLuzNy1k6a9Dee1BEz/wqGSKv0x+cvK7aoWn4WEWC7ce1Q+6kML/u+5qcAPkay
5SiGtdI4BrlJlU1xwfHjPbfFxoqT3TRJS90poz41FcMI7nbrNgrfD2atL1xr4tSi
4W3xjoFNySJA8Rv/GsKQmdtzvmcsdy/YBpjvIx9w1YTaTH7CM5fKqlY+KQdUO9zI
24UNT6dEn85xy+5ESCciLvggs+kTsoZ46JBKPL9HWafPqG1U1XptsQKIN0xMXfnX
6Jfw2whNX9l7E1xb/m8KGL3H0s8kBQ==
=pXef
-----END PGP SIGNATURE-----

--fKmCH6XwVYiEfMBv--
