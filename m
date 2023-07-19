Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6201D758BDF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 05:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjGSDLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 23:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjGSDLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 23:11:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4261FD6;
        Tue, 18 Jul 2023 20:10:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28800616EE;
        Wed, 19 Jul 2023 03:10:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33717C433C8;
        Wed, 19 Jul 2023 03:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689736253;
        bh=FEfzSCDeJZta8jI8m2GhNmu23jM39yIz897hne20suA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=go+kCwY76vmaoLbykXPBk28lQWNnjSeV9uzkoxfVJCi02bOCuV44I71Z3dpdBNYRO
         YeAgVTXfuWzGG3L5vJ1irtEhjUUqh2s1oWRZgeIKZxXTIDVxlZMUDh0HvIZrRS6FwF
         cK7NDp3N2tlpcSqQ5WMFkr1sk49HEkTByQuFa7rAscJPYP7CwDi7wtsOEFbJSGPZ9G
         j+ArAPemB4uGo450etpLU/hKBp/D6nomkO+eLuLxcOwdEsFRogAKvbYg+qWH2FPeep
         MzQeZIH6etLjkW1k6G6Ee4GezTtP3k3KIi8qCd94ikbutAvMoKmB+F9AQIGEJAxAFU
         wOrOk9g9nvTIw==
Date:   Wed, 19 Jul 2023 11:10:42 +0800
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
 imx8mm-venice-gw72xx-0x-rpidsi overlay for display
Message-ID: <20230719031042.GB151430@dragon>
References: <20230718205538.4108487-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718205538.4108487-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 18, 2023 at 01:55:38PM -0700, Tim Harvey wrote:
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
