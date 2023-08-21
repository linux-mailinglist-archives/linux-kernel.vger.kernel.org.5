Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFA3782F85
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236704AbjHURf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236567AbjHURfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:35:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D414113;
        Mon, 21 Aug 2023 10:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAAEE640DC;
        Mon, 21 Aug 2023 17:35:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B868FC433C8;
        Mon, 21 Aug 2023 17:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692639319;
        bh=TIm9VtXxlIIF+26+p4kzCvEt3832dTcm44iy+s5+d+I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L3QL+Fzw7Jg1X5dQhCl4G1tA+OQyxWpBiUrFeC/zy9/f9Kt9GcynUtsZ72l8WvKuG
         aD2QTedNY6zAdXXixkl1NNMc8MVXYqzn0n/TxZAbsSdJxTeDZBxRQ9Y0d0OQmV/okT
         zdbI3x0fA0M5NY1ZB5vSPDak0q5gUTD78nwvej1oxH0EtZAVV4hilPmq7V7B5wMWwt
         xG5whYA+9JOjWdhlX/tFgZbTsFEASR1b2//qPcRWIYi2JeYdC0ucj1DyFTqV0cDCU3
         0Z0Z7aeY//abt3sW7FwZY2IvHi+phN9wBpFN/WaLs0ES3QNPXtBzX6UxpgqbOtpGeM
         AidCRQ2V2Wipw==
Received: (nullmailer pid 2006749 invoked by uid 1000);
        Mon, 21 Aug 2023 17:35:16 -0000
Date:   Mon, 21 Aug 2023 12:35:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     John Watts <contact@jookia.org>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 7/7] dt-bindings: sound: sun4i-i2s: Add channel-slots
 property
Message-ID: <20230821173516.GA2006019-robh@kernel.org>
References: <20230811201406.4096210-1-contact@jookia.org>
 <20230811201406.4096210-8-contact@jookia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811201406.4096210-8-contact@jookia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 06:14:06AM +1000, John Watts wrote:
> The sun4i I2S controller supports mapping arbitrary TDM slots to
> each channel. Allow this to be expressed in the device tree.
> 
> This is currently only implemented in the R329 I2S variant.
> 
> Allow this to be configured using a new channel-dins property.
> 
> Signed-off-by: John Watts <contact@jookia.org>
> ---
>  .../bindings/sound/allwinner,sun4i-a10-i2s.yaml           | 8 ++++++++
>  1 file changed, 8 insertions(+)

Same comments on this one.
