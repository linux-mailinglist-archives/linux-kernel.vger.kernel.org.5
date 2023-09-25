Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF727AD7F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 14:25:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjIYMZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 08:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjIYMZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:25:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DFEFB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 05:25:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3CFC433C8;
        Mon, 25 Sep 2023 12:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695644718;
        bh=EpScTZPLgSj65vBFSIAyo7Cs1HB/1MAIHpQTaZ0bcLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOPfcOgNDBAeO4O+0jKxnPe1Lx4/OaazqraHxWLEniyocDCR/cxEGGp/1h9gmYzNT
         GGWqEr7I835ssWWvijGb9t+Nh57032xRF3NVRgUAIeDfETZfdQabHr/O9kdQ/fO7Jh
         ONTvPBjZ+1eeh44LgK4ekXn6mRYj0UNb2mnje0p2jUP+k6a75GQDGrKvqqfcyxI4UJ
         9rmHzSSZWcer6u1FC2XHatapgkGmrJXyez5tHe/1DTAnNJHMC3mmqN+twElSSfyQZm
         bd9UyBTC3XNLXG8NI4IbUhwcKPDyDD1U4+I1/wKYcarCOx+7g/DQco05eKdNDKxvmb
         GRzouKT4TE8AQ==
Date:   Mon, 25 Sep 2023 14:25:12 +0200
From:   Mark Brown <broonie@kernel.org>
To:     Chancel Liu <chancel.liu@nxp.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, perex@perex.cz, tiwai@suse.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] ASoC: dt-bindings: fsl_rpmsg: List DAPM endpoints
 ignoring system suspend
Message-ID: <ZRF8KI11IVf6NzpL@finisterre.sirena.org.uk>
References: <20230925110946.3156100-1-chancel.liu@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q/IrCVZv+ZArlVx4"
Content-Disposition: inline
In-Reply-To: <20230925110946.3156100-1-chancel.liu@nxp.com>
X-Cookie: Save energy:  Drive a smaller shell.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q/IrCVZv+ZArlVx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 25, 2023 at 07:09:45PM +0800, Chancel Liu wrote:

> +  fsl,lpa-widgets:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description: |
> +      A list of DAPM endpoints which mark paths between these endpoints should
> +      not be disabled when system enters in suspend state. LPA means low power
> +      audio case. On asymmetric multiprocessor, there are Cortex-A core and
> +      Cortex-M core, Linux is running on Cortex-A core, RTOS or other OS is
> +      running on Cortex-M core. The audio hardware devices can be controlled by
> +      Cortex-M. LPA can be explained as a mechanism that Cortex-A allocates a
> +      large buffer and fill audio data, then Cortex-A can enter into suspend
> +      for the purpose of power saving. Cortex-M continues to play the sound
> +      during suspend phase of Cortex-A. When the data in buffer is consumed,
> +      Cortex-M will trigger the Cortex-A to wakeup to fill data. LPA requires
> +      some audio paths still enabled when Cortex-A enters into suspend.

This is a fairly standard DSP playback case as far as I can see so it
should work with DAPM without needing this obviously use case specific
stuff peering into the Linux implementation.  Generally this is done by
tagging endpoint widgets and DAIs as ignore_suspend, DAPM will then
figure out the rest of the widgets in the path.

--q/IrCVZv+ZArlVx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmURfCcACgkQJNaLcl1U
h9AHzAf+PwWIz4bbMz7QJRzUtT+mOEdX/5lMuK4w3mvqnYoUdqA2qy3yVAdLoegF
WoPAesxiBiwTkmnQcnEsWsIdH7T3tGO6oSpYg1DfWmKbwGi2wnPerTw98/lNyLM7
f23wUYprpUdcE2+9j6/1dMuN7T5hDZoBLXxp/pcVOmL/z40sXOKkpaRhBb1oy5Jq
qeIcheuyv3RCEdBKCoMa70apc3LRU6MTkVJpqBjM6DfDZ6YTOFwUs841MV/lz/uz
fXV0yK4ETHlJ5ThXNPLezNqSEyghVeFKt7ZaIBze4VuoS7YYhgv777AZBJ6rIija
y2y2FOnTDyyU7C14ZyZdfXWkCnp0Aw==
=Zz/j
-----END PGP SIGNATURE-----

--q/IrCVZv+ZArlVx4--
