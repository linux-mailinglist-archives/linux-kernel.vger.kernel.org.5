Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C67791C49
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353370AbjIDSCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231436AbjIDSCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:02:34 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9130DD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:02:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E025BCE0EEF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 18:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 555CAC433C7;
        Mon,  4 Sep 2023 18:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693850547;
        bh=AUxJ+uIwizMOJoV1uCMXbpEj6YaqWhamff8D6IHLwX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSTIAgjGs3dXtpAGoceVxatGYn0ElTGlLnYOu6G/OS6SnMi3o9A7IFx4ukdw0BuO6
         wK6vhpiuMMiwxIlxoWxSm1QDBqlsKBZJzv8ji9+vVQ9L3/vWjb+kzni3YlxSMtSCmO
         I/ttMiMayGfRwU+xbL1xxXaCatQhNvVbwfPf77PdimZkMItKciwB4iejlbDiKiWIcK
         nOknW/SZkNsiF6Q+p+VVnKbPtw1cmoZ0PSkhxFomUt+bIsd8hW/WOIrIEEsA823iov
         9HHD31iUEZLwKuTVAQq4cTHR7gp6U8klTg3GNFj7gfbbsr7OxcsoxEojJH1JL+dchf
         DjDmoXiOAp+sw==
Date:   Mon, 4 Sep 2023 19:02:22 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, wangweidong.a@awinic.com
Subject: Re: [PATCH 2/3] ASoC: aw88395: drop undocumented, fake fade-enable
 property
Message-ID: <76c00419-1cad-493e-9127-e5f008868162@sirena.org.uk>
References: <20230904125309.43350-1-krzysztof.kozlowski@linaro.org>
 <20230904125309.43350-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M8rrkN6DA4ETQF4X"
Content-Disposition: inline
In-Reply-To: <20230904125309.43350-2-krzysztof.kozlowski@linaro.org>
X-Cookie: Immanuel doesn't pun, he Kant.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M8rrkN6DA4ETQF4X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 04, 2023 at 02:53:08PM +0200, Krzysztof Kozlowski wrote:
> The Devicetree fade-enable property was never accepted and is not
> allowed by bindings.  It is not used by any upstream user, thus
> considering that it was never documented, should be dropped.

On reflection this one might fit better as a runtime control.

--M8rrkN6DA4ETQF4X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT2G60ACgkQJNaLcl1U
h9AZ6QgAho8CEjwD1biZKHFqfYMDe1n/Q3yNyHRSzoUkoyC4r0UaDHPBSYl+Tkmy
90FBs7wKgjnHGV8HNY49tUXfzEVLZSn1A4sQOUD+10xRj4QJvnyo2LmQI522mu20
drOpy6gurB9aYm5YW31RusnnKgd1PCT4ISdCMQJHATA8F5mdJCPIBHpvwDEwThDb
b6BPTlOrx6FQkUTDfv+R3RGFqnF8yeRrJJrNGbZp4VaiiN0RmiWq1a7MDe++wVO1
ndlxWW8uzxUFPTrApG1h9Qa2xZv2BgiHl3dDw0vj6lN/uULIWUeGbRP9pORiXXPZ
vgSUQ9a02kW8enE9qMltrpZVGlBRwg==
=FB8e
-----END PGP SIGNATURE-----

--M8rrkN6DA4ETQF4X--
