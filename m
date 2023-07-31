Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5865F769F69
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjGaRX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjGaRW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:22:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B07E79
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:22:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCBC861230
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 17:22:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A46C433C9;
        Mon, 31 Jul 2023 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690824162;
        bh=PU4Q2NcWuTz0Ljl+qIxxhnCK21j9B4K3d9CMPbiQsVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aDzXyUmcP/mq7uOYynW3Im8djXcQDSj0YS8HEe8JlvvUfl5NeFnqOqZuIt1brVQYI
         t04I4V+VMswZtT62AhtnO4rRb9of+/R3t0WjS5ohy1vubTwuqNWjVPmKtwiohsXGbH
         3i4Cm4ajP7aJ4Cfa7S4m+eUro7cMdEkjwd2VIR6JH+bbAJSWOFmRTrOakWrxon+a/1
         dtxN8Ui+Lw+/Q1Cappdk6m6C/MVW5MMPayXuhsRlQjzgplV27CYG49N81ScjZt4RmG
         SWYVkDpff37dn9ptoVcIs0k1mOXgX3MYaSDbfCsCdFxB+u5uUaHSJqlqzB5NCUERSd
         hxu8jdeS4tTHg==
Date:   Mon, 31 Jul 2023 18:22:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: codecs: rx-macro: Enable RX path clock to match
 POST_PMD
Message-ID: <017933a7-e674-4619-9690-630448ac3c26@sirena.org.uk>
References: <20230731165522.328301-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fZmbvYP7TIeSL9tA"
Content-Disposition: inline
In-Reply-To: <20230731165522.328301-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Single tasking: Just Say No.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fZmbvYP7TIeSL9tA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 31, 2023 at 06:55:22PM +0200, Krzysztof Kozlowski wrote:
> The driver disables RX path clock in SND_SOC_DAPM_POST_PMD of
> rx_macro_enable_interp_clk() and rx_macro_enable_mix_path().  Make the
> code symmetrical by enabling the clock in SND_SOC_DAPM_PRE_PMU.  This
> also matches downstream Qualcomm driver for Qualcomm SM8550 SoC.

Was the clock previously enabled somewhere else?  If not how did this
work?

--fZmbvYP7TIeSL9tA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTH7dwACgkQJNaLcl1U
h9D3tAf/UQUKGASLJzF7ZTnW7l3dewmhquXbbdGbQrWtF8oDpGwTQe4ARJk8UmMV
CRi0495iHIkVn76gjCsOtk6TXb+cd9OYSfTtjODJVQam26xeyAathvf+PnMuHMwB
qVgZkHvgXjz8T23ErcUds5i2xZ8az2+aqrRHaWb4n2Zqkn5awLoroEfeDztE1uJn
NdFNpc3W+wWGK0Z05nRcaes/EGrRhF0Tw/R+XNo+jf7o5N/ZOkMbMydW4Of1OUfK
xuXZKtw25VGuqKOS1rwS2JXwagsINVpG1s7vp/Qx4G8EB5jBzKTiFdIoAVXd+dLK
xMcciUnk7/WPJW6GQNSsDIQcNI1Lsg==
=zpeb
-----END PGP SIGNATURE-----

--fZmbvYP7TIeSL9tA--
