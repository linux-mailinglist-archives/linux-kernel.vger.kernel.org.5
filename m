Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4DD753BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 15:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235776AbjGNNqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 09:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235586AbjGNNqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 09:46:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EC63585
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 06:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFA0E61D27
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:46:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D64C433C8;
        Fri, 14 Jul 2023 13:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689342392;
        bh=jlT4MOwW+4v6VFl73qUifFGFB4+CTofOHXfzIaWF/9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kt4460wHZy6jp9LP/QLU8ZGR/X5P937Fr7HjKGNDU1l3sY4pSjmctutPhFTKiAKSd
         2QbjPRwd2v8FZ87+8moRdVgsiRxkoAmRaWKnDZBSqLkyd7+5FgmK0MzLEF7oSmE73s
         ysrrRC5zs+jQ+h+jO6xPWAXH7CRPZuiK62xdVuuG1CJ42G7u2yKWQklGiUbonraRsL
         EFBmq15aFUz4RrvsdaGF7QdWjy/45kKnsoctdwlOCmoR1kFJCKhK2yAnIwKCtwtzyc
         xheQ3nVoTMnutcGhfUmiXNVmxEqQdhS87coryquiKsxfrOMzcW6X18xVknPDWykINg
         Jq/ZivuZqcNWQ==
Date:   Fri, 14 Jul 2023 14:46:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Kevin Lu <luminlong@139.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        kevin-lu@ti.com, shenghao-ding@ti.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] ASoC: tas2505: Add tas2505 driver
Message-ID: <9358b427-faa7-48be-b386-bf1287906873@sirena.org.uk>
References: <20230712044321.48530-1-luminlong@139.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fkB7w4zBomSv3qDK"
Content-Disposition: inline
In-Reply-To: <20230712044321.48530-1-luminlong@139.com>
X-Cookie: Preserve the old, but know the new.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fkB7w4zBomSv3qDK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 12, 2023 at 12:43:21PM +0800, Kevin Lu wrote:

> +	val = (ucontrol->value.integer.value[0] & 0x7f);
> +	val = mc->invert ? mc->max - val : val;
> +	val = (val < 0) ? 0 : val;

Please write normal if statements, it helps with legibility.

> +	.num_reg_defaults = ARRAY_SIZE(tas2505_reg_defaults),
> +	.cache_type = REGCACHE_RBTREE,

Please use REGCACHE_MAPLE for new devices where you'd otherwise have
used RBTREE unless there's a particular reason - it's more modern.

--fkB7w4zBomSv3qDK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSxUbIACgkQJNaLcl1U
h9Bm9Af/Vmv/c7d6mMKNRJ+Kq/VFegwM1YkIGeForVA0+QYnx52ji0YoqOW82WHH
ULAUcg7xy7NcVbJCwUbOEYC5O9ZgxG1pnzYiu1vFJa5Z0i8wF/HkmR577K2qPrjY
44bFdOHrE9dTB4XiRK1Bxe8Q67oylR2z45qnt2nqrCCLdnJgDqwVrSgaDelNBWM4
KUBWI7rNee8Iy+CPGMA77stRPX/mNeeRNAYKmofnu8HZ677SpglczskoSDBMyC8m
MTeuSk5I58N8pWyAufMROBrNuQiN5FL7NPIKQ2K9OO7n7Im3InF7+wxv2PkjKvcI
hb6qU4y1IYxjA/CT50+lkLemlGum1w==
=4jrU
-----END PGP SIGNATURE-----

--fkB7w4zBomSv3qDK--
