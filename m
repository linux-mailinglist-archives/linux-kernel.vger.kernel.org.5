Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5311377B99F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjHNNTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjHNNTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:19:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F26171D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:19:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAA0263982
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:19:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9092DC433C8;
        Mon, 14 Aug 2023 13:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692019150;
        bh=FxU0j3fcm7taMz716mWc73u/I77Mp9w2Eue2bF2MZwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TXmAl8Pr0Qjh7Rfj3+klvYyVb+jAw8Zty6rpP4eh21L1BT0WEtXbwtxF3mz5caOWM
         1858fMQMi6JZYWmuBQAdwkwVhD0O3GIUE501RY181xPO2AbHAEh0YMX49IBz3ORaek
         I5sYesWRhoGkJ7LQGbSxe5d70sMChE3Waz7yJ2auOdL8JJagXDCTqW1dTDxqO4QA1o
         8yBGSo+NV6LnYFswHsaGNHkExKyOVFeUWnOgVjlF/Fk3lQMG87Pw19j4dddAE+7kAv
         +YfCB9VLp2vCMiLPN1RJDyPv98kenhYwEl27BVXiXWUXn5F2U6C1o41TmXNkpaHzHt
         hADSzHk7d9k+Q==
Date:   Mon, 14 Aug 2023 14:19:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Subject: Re: [PATCH 22/25] ASoC: dmaengine: Use iov_iter for process
 callback, too
Message-ID: <e9c5a4ff-ece3-465c-afd3-402a4b0efd8e@sirena.org.uk>
References: <20230814115523.15279-1-tiwai@suse.de>
 <20230814115523.15279-23-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bH9Qky/QE42jqk3k"
Content-Disposition: inline
In-Reply-To: <20230814115523.15279-23-tiwai@suse.de>
X-Cookie: FACILITY REJECTED 100044200000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bH9Qky/QE42jqk3k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 14, 2023 at 01:55:20PM +0200, Takashi Iwai wrote:
> Along with the conversion to PCM copy ops, use the iov_iter for the
> pointer to be passed to the dmaengine process callback, too.  It
> avoids the direct reference of iter_iov_addr(), and it can potentially
> help for the drivers to access memory properly (although both atmel
> and stm drivers don't use the given buffer address at all for now).

Reviewed-by: Mark Brown <broonie@kernel.org>

--bH9Qky/QE42jqk3k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTaKcgACgkQJNaLcl1U
h9Culgf/V8v9Xak3hh4h6lzC2b+3YbnR6yRTR3KPeC7k2xRigb9ertyFbT18N7Cv
MCUVmwaMCXk+pvClLw7md8c9z+O6juWo9KoRgee1upGPNYuWlqeQzPKIn+ZwD4/g
Ox64hRGSPv9utfVMiitN4D8ytpekJrNKwJ4qVUNnDC7vfvRWIL4tSzf7BoKamZSB
GzDTY0UnB6Nj7CkOHdgPgenAJuTgjyh/RlbDoxIjYi1ni72x5DV23W34uyz/dmAL
esR6RRCYt7H0lr9JiVjKOMwevoYqFZEFwSyCGf7RQ8IDqeyqPOWueee+LAbAmEP4
WWdBU7YengNxPSwpC87FIZl5w2Co9g==
=KpzI
-----END PGP SIGNATURE-----

--bH9Qky/QE42jqk3k--
