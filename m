Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674748064B5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjLFCLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 21:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235442AbjLFCEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 21:04:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2296188
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 18:04:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C59C433CA;
        Wed,  6 Dec 2023 02:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701828269;
        bh=FYvgiOWGESDkZFht1/V+6iNU6aLyW260toT2yX1jdzE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=egn/geSJq2ZXWwvfJXq2eVnRoNZp05IDbs5AMcMSsvEM9arAol7uabH5cv5S9wwke
         QQZL2KuYWSBgWjY4RY4owhhiWV7hp4WaO8rygnXmIH3z4Y1GokiRqQxgsymRlKGEFP
         OiIxjcCPJ2Qeyc14I3FAAm2CtKq/+FQnNObn1UQFC3WMAei5wx0A6sgJ2n5gXt+7SX
         roEe05vUUjXvU2r4acGNCq6cHVkHEAvxkAW4j2qRI/eSx/FEmKrPHe8c7THFOC7zgR
         +h2eJ97A2StbpCjB2WB+MPL3jeWNc3rKNt3/SuPC4tdZGi6Pv4zHBHbJFIxHm4TNqK
         SJBIXsKhzvHGw==
Date:   Wed, 6 Dec 2023 10:04:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Roland Hieber <rhi@pengutronix.de>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH 2/2] ARM: dts: imx7: add MIPI-DSI support
Message-ID: <20231206020421.GG236001@dragon>
References: <20231127-b4-imx7-mipi-dsi-v1-0-7d22eee70c67@pengutronix.de>
 <20231127-b4-imx7-mipi-dsi-v1-2-7d22eee70c67@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-b4-imx7-mipi-dsi-v1-2-7d22eee70c67@pengutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 05:12:29PM +0100, Roland Hieber wrote:
> From: Marco Felsch <m.felsch@pengutronix.de>
> 
> This adds the device tree support for the MIPI-DSI block. The block can
> be used as encoder for the parallel signals coming from the lcdif block.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Roland Hieber <rhi@pengutronix.de>

Applied this one, thanks!
