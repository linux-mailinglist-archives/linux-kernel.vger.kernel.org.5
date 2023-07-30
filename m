Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022DA768541
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 14:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjG3MYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 08:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjG3MYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 08:24:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E191725;
        Sun, 30 Jul 2023 05:24:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5873C60C0A;
        Sun, 30 Jul 2023 12:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 543AAC433C8;
        Sun, 30 Jul 2023 12:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690719879;
        bh=J8tZGW2X6vJifMO5nVhYyZJQe9qPWPckg8AVei2uBJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ibpqbe+RV0rbAONf1KD8c1swaLbl8J9lwATYd7XrYfan6c7Bs4pj/o5MiHO8wb4W+
         A32f84lNPDgAkzVPMvJ2IweqSiQjFU4vb4IIurmGrGF8FhjrCUBaZYvyr9lAcziq9o
         zfesOWOWcl4USJvSYzI0+KLVZJGOWTVaZydba5F+VgpO8nDNPjT4Ah0gflrakaQ3CL
         CmFX50ZRuEP1cpwExrUWXyyU+3E28KIItuqfYgjDskAoDrsAgcgdaJ4yuSH08zxw0V
         R4KLpq7VvIvRJ0VOhV8n0Tdh2KFF0cW1xaYI3E411Hzrm6mjSzAQmYt2VjXCmtFcdi
         5gy99BkEN0ITw==
Date:   Sun, 30 Jul 2023 20:24:28 +0800
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
Subject: Re: [PATCH v2] arm64: dts: imx8mp: add imx8mp-venice-gw74xx-rpidsi
 overlay for display
Message-ID: <20230730122428.GC151430@dragon>
References: <20230719152920.2173-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719152920.2173-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 08:29:20AM -0700, Tim Harvey wrote:
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
