Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98F178B3B8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 16:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjH1Owt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 10:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjH1OwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 10:52:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33210DA;
        Mon, 28 Aug 2023 07:52:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C51A564A45;
        Mon, 28 Aug 2023 14:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE5AC433C8;
        Mon, 28 Aug 2023 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693234332;
        bh=3fBarIx2yqUu9k0U8lZUitsJsoPbg7W5Io0zYtDpFwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qzGLP1A5Si6J2b5Tvh+y76ovgGZycgTe9uJyRn3PJmpmmPvrKTxEfqerkUl6vwzG/
         RdwtPsS05u186+D8r1mWdRrcAYC4A+NJI//hlOmH2R0Gy12WmyKVWZawKFzGAZXRTJ
         V+6RQMrBD45QLUq2Sewpho217GVQeFCVI5CDRQeE8QEKM+MlEjxEeEcCpWP0DGfL5+
         krxNXQWO653kDqm9MwfHLwrdPoP4fg4krbHKNNh18BQV5ZrtAEZi6Y6q/op00SspHK
         tV8F/EBLHIRiircuI576sp/YdS8oiUfq6atRrTynKVk9Q5drhQ06Rb6xgYk3LIiCWU
         IFPfLxSEDVkbw==
Date:   Mon, 28 Aug 2023 15:52:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH] spi: zynqmp-gqspi: fix clock imbalance on probe failure
Message-ID: <ZOy0l6sXyYib59ej@finisterre.sirena.org.uk>
References: <20230622082435.7873-1-johan+linaro@kernel.org>
 <168747016057.308826.7806530657100324752.b4-ty@kernel.org>
 <ZOyPjWooMqAv3IWQ@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bhzWugZckmp1q+EG"
Content-Disposition: inline
In-Reply-To: <ZOyPjWooMqAv3IWQ@hovoldconsulting.com>
X-Cookie: Give him an evasive answer.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bhzWugZckmp1q+EG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 28, 2023 at 02:14:05PM +0200, Johan Hovold wrote:

> I noticed that this one is still sitting in your for-next (and for-6.4)
> branch but that it wasn't included in your 6.6 (or 6.5) pull request.

> Did you intend to send it as a fix during the 6.6 cycle or as it fallen
> between the cracks somehow?

It fell through the cracks - I was originally intending to send it as a
fix for v6.4.

--bhzWugZckmp1q+EG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTstJYACgkQJNaLcl1U
h9DQLgf/VwdyuyPJrhNySfAGOvO2OKqSlkQdclua2SbV3GH9FDHgOLOuZYwDZM91
utuzd/zyqhhRhVhYxa+tLd7vs+Y7i9zk8n70yi7h3rjBE3H1oqmnhIPuI/Y9pMEU
O87QZl0inaRNqTpcHfGsb+CotMf994Y6rDeAW8P4Ue8jd2el+FuLM2F8EQ4bq8ur
BQGxzT1s0FSoyLBGUX/BA6CZZrmYkmU36RwMYEp2faJBAwZLffW0IuoMf16DSjtQ
hhF6ad1Ky6BS6KwqDykWzWPk1ajkXnkY2eRl83vSucSPDIKg1PTMSX1YGkxIGqkL
XX12hjvUH/JrjQtV8dTirz5RsUEMrw==
=K53f
-----END PGP SIGNATURE-----

--bhzWugZckmp1q+EG--
