Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 811F2782D73
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236443AbjHUPpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjHUPpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:45:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75501DB;
        Mon, 21 Aug 2023 08:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A92762053;
        Mon, 21 Aug 2023 15:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC65FC433C8;
        Mon, 21 Aug 2023 15:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692632749;
        bh=DXrBW2VJ76u0qVfmft5avHbG1deyDq+corIBjd53wc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SKVE57PRlBtesE3gZdkizeZ6WGvgRsETyqu6TWNmpAvStHVujOjQzFG4oLBobshxc
         RztHW+B/KH2ieaUPmT5aF/dO1xLAtAVP40P2CMIHbG0BTsAsvi/S8+MCjyhqCOVnfD
         QRzwKXcd1KEMAsEmcX8WVwO1bwWGsv9ssQ8ru4/5Te27MzFSbhYmiX1rG2wmYoSwb+
         Oap0su4emwsccN90z8N3AdZUkGlLQdEILBTJMLgduA7VOzB7z+VejrHGrgmA4tEoGY
         rM/iZcMuPy880GtnTWFf4jCzF+wRhOlf/KMj3LFdSur3yyqiEdB3k4BJ25wUquqHij
         KylNtp/whrn7A==
Received: (nullmailer pid 1720300 invoked by uid 1000);
        Mon, 21 Aug 2023 15:45:45 -0000
Date:   Mon, 21 Aug 2023 10:45:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-sunxi@lists.linux.dev,
        Albert Ou <aou@eecs.berkeley.edu>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/5] ASoC: dt-bindings: sun4i-a10-codec: Add binding
 for Allwinner D1 SoC
Message-ID: <169263274519.1720239.16779866504888120217.robh@kernel.org>
References: <20230805180506.718364-1-bigunclemax@gmail.com>
 <20230805180506.718364-2-bigunclemax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230805180506.718364-2-bigunclemax@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 05 Aug 2023 21:05:01 +0300, Maksim Kiselev wrote:
> The Allwinner D1 SoC has a internal audio codec that similar to previous
> ones, but it contains a three ADC channels instead of two, and also has
> a separate clocks for ADC and DAC modules.
> 
> Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
> ---
>  .../sound/allwinner,sun4i-a10-codec.yaml      | 64 ++++++++++++++++---
>  1 file changed, 56 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

