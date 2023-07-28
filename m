Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E2D766BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbjG1LpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236288AbjG1Lo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:44:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8F3A35B5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:44:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AAFE62085
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 11:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B3C8C433C8;
        Fri, 28 Jul 2023 11:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690544696;
        bh=+MRFReAofAdd0eOtzcmWFUIO07U98UF5O5XdKrxlQsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QVUNyXS74Bln9wI1gXIO5FwaL+zPYl/TYDFy09XSnhyZSw1mLZAoSv6oIq61epQJS
         Or3IXOG3T2d26SHmSLu1uJL5eviNqKRF2j5pMKHwLgUOikStQXQPJeLDWOQTheNzQa
         qbryVw/+7oLlB8pLNuUGldu7PxhcKkixq8LeSwNhc+Mq9PBrAymTYvJjWShzFYHBQZ
         +jxFKNik9yHhHuBZqErCgZbHGfMhZUdydYmkwys/rNUMX8l2LjasFcqrdV1AHgPhwG
         CMxojTV2kTdRpU2giO4FxNKvWd0SDXlY8wPBrz2HOyq3LxoHChkevWeIIYfXpmj7a4
         HDDEeO3ol9z9Q==
Date:   Fri, 28 Jul 2023 12:44:52 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] regulator: da9063: fix null pointer deref with
 partial DT config
Message-ID: <7f63a649-5cac-4457-8988-08f469e6aadf@sirena.org.uk>
References: <20230622151146.1459250-1-martin.fuzzey@flowbird.group>
 <168747606054.325012.10021476177510722363.b4-ty@kernel.org>
 <CANh8QzwYAEeLhgBfaVY4P_2_-YYfpvAgbdK2EpqAqb8LMNBvCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6HIG/ZA1G1rMVaQ3"
Content-Disposition: inline
In-Reply-To: <CANh8QzwYAEeLhgBfaVY4P_2_-YYfpvAgbdK2EpqAqb8LMNBvCg@mail.gmail.com>
X-Cookie: Ontogeny recapitulates phylogeny.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6HIG/ZA1G1rMVaQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 28, 2023 at 09:46:03AM +0200, Fuzzey, Martin wrote:
> On Fri, 23 Jun 2023 at 01:21, Mark Brown <broonie@kernel.org> wrote:

> But the code now in mainline 98e2dd5f7a8be5cb2501a897e96910393a49f0ff
> corresponds to the V1
> This has also propagated to stable now.

> So I'm not quite sure what happened here.

> It's probably not really that important, the V1 works on my compiler
> (gcc 9.4) at least, not sure if other versions will really have
> problems.

Please send an incremental commit that updates for whatever v2 did.

--6HIG/ZA1G1rMVaQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTDqjMACgkQJNaLcl1U
h9BVCwf/e0GZV10I8GlQ+903Gg3VS0BkSS9NSK5ETFWhC178rcXVpt4WShh3Myxi
DkrVRkxi3iv+y3wRJrZ1OokzaYZmk0WeB+2vuMG6F4d3b63Q+S+26FXewGO3GHnX
Nq32rsO+6zagQYytSX56hsEfbLw99oRsDtzmWdQhyz/c63hyVvYqErT34W+5MDqN
toqZaNnSXS5MO+SCmHKajPKpkAYUayW6b1AxEU+M1M7yJrhM4WwrdVFYOaT1uRtM
U5FKKhtKcgirUkU8KXScPbCyXzkcut2ANajgP1qwm06Gkuow/4jwOMqRx15P6nwu
pcQ8IekW+j+cduFEtra91+H7/V5awA==
=0nyy
-----END PGP SIGNATURE-----

--6HIG/ZA1G1rMVaQ3--
