Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1134678EEAD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245669AbjHaNc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244831AbjHaNcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:32:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8D8CEB
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 06:32:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03B6661FE3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 13:32:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88BB3C433C8;
        Thu, 31 Aug 2023 13:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693488741;
        bh=CrvmnVTBwwknCk3gU0yxey1Umkeaxg8haPwa2E4BBq4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFvWpECK2qDpVzbNpvNOr55CwKY5azL0w7pdZSFPPR80R8TgTV2V1HqBBqgeDuJfZ
         xe1mTiGfat/5dkeJe2INL3I/+agX1XYyQTealBWjdntPIFKB8DqAHBh630vLvQJY3S
         KcvRQ0jcvLLj8gRw9ldZKm/JmnuDg8IwqUXTHPOjGSkcQOaxPAEWZqxIURrmXysEEX
         lNBjFJzsBvFRwEVkvkvM2OjU3GCv1haXVhFWHJ4WgVZrQpAtcl0ToqCEu8mN7ETgKI
         oK1/LgSGaHLFPlLjzEeukCDZyTEsINCxDrtLd5P3RUBb1y2F3Wl0tnqAyNHKzlcNzd
         iF7FgB63BymkA==
Date:   Thu, 31 Aug 2023 14:32:17 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9 fixed] regulator/core: regulator_ena_gpio_ctrl: pull
 in ena_gpio state handling
Message-ID: <19d413c5-c683-4443-b834-b8ef39b8ba90@sirena.org.uk>
References: <ZPCJXAjZ8ScAAZnL@qmqm.qmqm.pl>
 <1c102d15cb8f20141f0bfd1e42d5ac8a98947154.1693485621.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B6nb9OqoznIqomKt"
Content-Disposition: inline
In-Reply-To: <1c102d15cb8f20141f0bfd1e42d5ac8a98947154.1693485621.git.mirq-linux@rere.qmqm.pl>
X-Cookie: "Pok pok pok, P'kok!"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--B6nb9OqoznIqomKt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 02:44:28PM +0200, Micha=C5=82 Miros=C5=82aw wrote:
> Deduplicate `ena_gpio_state` handling by pulling it into
> regulator_ena_gpio_ctrl().
>=20
> Signed-off-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
> ---
> This is a fixed version of patch #5 with the extra code change removed.
> I'll resend the series if needed after other patches are reviewed.

Please don't do this, it just makes everything harder to follow.  Send
the whole series when resending.

--B6nb9OqoznIqomKt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTwlmAACgkQJNaLcl1U
h9AWFQf6A2Q8lOocvZs0mPA4vBe/4+GPfrF1TjjbkLtt8Xor/97jN2RkgcvYUIdp
H/YEijFOQ/LCMOvD78cM7cYVvGq92mt0uMaM+vTmMu5b2nC35m5wmVS3rAStp1IW
QWV3xNHdfuNOb0IZVFkJl/1Z6F81lgqUSKaEoh3qpjMubnA2nCOPcGoMHsEb4WwZ
7qoQVAzjJMe6OLQlBTX7UYBtN7abdKaSIFWClFu355PRES2i/qf9qA5GLBluXI/t
Yb8yKxzVmyy2URoKrbDaexoSQYULONoyoHzuxEYdNj+T9fxEmW+B+NlVStxVt8pr
/dcAtslNvDp3JIdEbqALfKVcYkzR0Q==
=Bam4
-----END PGP SIGNATURE-----

--B6nb9OqoznIqomKt--
