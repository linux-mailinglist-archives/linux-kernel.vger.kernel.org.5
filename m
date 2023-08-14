Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D5A77B942
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjHNNAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjHNNA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 09:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DD7B5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 06:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 022A163070
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C2FC433C8;
        Mon, 14 Aug 2023 13:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692018024;
        bh=yvZaPtCDpYus2GIWv4cRALOvUE7UzxXRXwB9m9FkoM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+g2DWm+K428DkmJS3lF2C/3iX8GSfNZt8wymKdPtbecClhURfd974WsSMLULCAB8
         nRoG2TNx8VHVx5dy3bBkjMpo8HHx6zhARPEzt+Vu7EEXLMmXU5cxuSjC6VONKD3N6g
         aADMMRYEZX9K88DPd9wp5PFzZun0LTF6qgU6JPuhjLTFPFU2GodYtcNdisrDUf2Igg
         xkIMmpE6VFyKlIngTsCg7seV2zchGAJT+FVxEPqNKUkF9WIms/GQd+zUGoQ1oJWdax
         njPdGUlwg4LPLtjPN2nC0+8P45AzuRW4jypFXCYwCeHSkhXne2JT7cAJWM4mJYA2o+
         iK5TR43QepvQg==
Date:   Mon, 14 Aug 2023 14:00:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 19/25] ASoC: mediatek: Convert to generic PCM copy ops
Message-ID: <8814d58a-c4bb-47a7-b386-4342588030a3@sirena.org.uk>
References: <20230814115523.15279-1-tiwai@suse.de>
 <20230814115523.15279-20-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e9cXrDQtETRLT4qe"
Content-Disposition: inline
In-Reply-To: <20230814115523.15279-20-tiwai@suse.de>
X-Cookie: FACILITY REJECTED 100044200000
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--e9cXrDQtETRLT4qe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 14, 2023 at 01:55:17PM +0200, Takashi Iwai wrote:
> This patch converts the mediatek BT SCO driver code to use the new
> unified PCM copy callback.  It's a straightforward conversion from
> *_user() to *_iter() variants.  As copy_form/to_iter() updates the
> internal offset at each read/write, we can drop the cur_*_idx counter
> in the loop, too.

Reviewed-by: Mark Brown <broonie@kernel.org>

--e9cXrDQtETRLT4qe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTaJWIACgkQJNaLcl1U
h9B7mAgAgG0rWe6fLk6qrZbUnnFOI2s63/YYtPQihDFdkBkTl4yiXRCjbJPmomWu
s6OqCfqusARAKBBFc7h4A8IKiOXbQHOrhGlPpnwMQA4xLEGLO0kteu7DgAc/s6Q/
n1pOA9VtVX35TcCGm+T0/GYJN/GbXwppYQ6P/rcThPk25F4e/Eft6zPWeCR9xSM9
4eOwBuoUzSvGx+ozZRf1MLJxlYudMssGaEPzozgEIMQaEWs+lJRFNlao9ZAkaePd
GQk+vSJQdiiT6BUGNJdRknetz9p0m2iACLdtcJhdqnRT/Ydt0iCdKLlcyrle3+iY
btQXIJGcL4mJaiJWn0vw2baZThdIPw==
=RxGE
-----END PGP SIGNATURE-----

--e9cXrDQtETRLT4qe--
