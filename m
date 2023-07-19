Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6DB758BD7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjGSDKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGSDKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:10:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EDB1BDB;
        Tue, 18 Jul 2023 20:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4011D616A6;
        Wed, 19 Jul 2023 03:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621E5C433C8;
        Wed, 19 Jul 2023 03:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689736212;
        bh=7A4KMl5MLUGDWGrGnDfnNmmYFLBEogpuXW0tZ3jaKto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8q5yrYIriEBQSOMX/3fLvdCoEUjLrsm+HnduwGUXBPPd/t1FV69xQ9s+zhsZjIUt
         VkoQWOLdtcK82bEDAR4gLjOFJBO2AT9zJ7aN1I25jx3yw8RVysoq00M6Ez6BO7MyXy
         HWEMV0LYreHu3cszV6+A7mcLkOYejk0MoM1+YvpHS7RadgqbKggBuX0Bv+O/9H8Xn/
         7FPho5GWCg6x6EVY0ZDsrA+miofpmbfJpXH698rP+cPFq4TLooRJpdn3D6C93skxvk
         tLQDhabF9/0e8XZ0bNey9H6Fl4Rw4Y5xJCZeUAOkg2HyoEVD7uZ6VWDrMviGIYgy6s
         3QTveJY6wb8BA==
Date:   Wed, 19 Jul 2023 11:10:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2] arm64: dts: imx8mm: add
 imx8mm-venice-gw73xx-0x-rpidsi overlay for display
Message-ID: <20230719031001.GA151430@dragon>
References: <20230718205500.4108405-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718205500.4108405-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:55:00PM -0700, Tim Harvey wrote:
> Add support for the following Raspberry Pi displays:
>  - DFROBOT DRF0678 7in 800x480 TFT DSI capacitive touch
>  - DFROBOT DRF0550 5in 800x480 TFT DSI capacitive touch
> 
> Both have the following hardware:
>  - FocalTech FT5406 10pt touch controller (with no interrupt)
>  - Powertip PH800480T013-IDF02 compatible panel
>  - Toshiba TC358762 compatible DSI to DBI bridge
>  - ATTINY based regulator used for backlight controller and panel enable
> 
> Support is added via a device-tree overlay. The touch controller is not
> yet supported as polling mode is needed.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
