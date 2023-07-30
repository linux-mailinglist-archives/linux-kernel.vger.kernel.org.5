Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638DA76853F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 14:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjG3MVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 08:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3MVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 08:21:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C69170C;
        Sun, 30 Jul 2023 05:21:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D99E60BCC;
        Sun, 30 Jul 2023 12:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82226C433C7;
        Sun, 30 Jul 2023 12:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690719678;
        bh=lopjlZnIXP8aTzo16QddGAZjVbaaYA2u2zPsbL/RNO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwoawgSn6h0fcVT+WfBu4h7+zO9eZMjQjE9va24Vs+mcALG/lIRJPtr3RSRq5rnPi
         td49HTWpJ0SkYyf/s+PbaeymPUvfroO9HoPqZggP/5IMqSRZPS5g4b96ypC+v8/xzJ
         CA0i2Vv2hyrLjB/IOFRJ+0KpO+upHMNHiHwE/Avfio8udd3DMg8OlzwhNujQoBidEU
         lhRinSSucENThs2oF+tSK3O0nPBfiQMTAaDl50rN3WTY2zFH0myeMBinn/yesEjyok
         UsBVZJHGimNe5dJLRxbGUuHBQ7ohaIctEwSkcLMv9cwvJ7drFHas0Cgx1m39HswrS0
         82AzCirYY4HTQ==
Date:   Sun, 30 Jul 2023 20:21:05 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: imx8mn-var-som-symphony: update USB OTG
 for new board versions
Message-ID: <20230730122105.GB151430@dragon>
References: <20230719135237.2986984-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719135237.2986984-1-hugo@hugovil.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 09:52:37AM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> USB OTG is currently not working for new versions of the Variscite
> Symphony EVK and imx8mn nano SOM (versions >= 1.4a).
> 
> The PTN5150 circuitry on newer versions of the Symphony EVK board has
> a non-standard configuration in which the PTN5150 IRQ pin is left
> unconnected, and the PTN5150 ID pin is connected to GPIO1_IO11. This
> requires changes to the ptn5150 driver to support this new mode.
> Variscite have indicated their intention to submit those changes
> upstream.
> 
> In the meantime, import device tree changes from linux-5.15 branch of
> varigit repos to at least make the USB OTG port operate correctly in
> host mode.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied, thanks!
