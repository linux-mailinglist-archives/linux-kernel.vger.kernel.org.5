Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A153E7BF074
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 03:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441806AbjJJBpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 21:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379389AbjJJBpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 21:45:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7618F;
        Mon,  9 Oct 2023 18:44:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F816C433C7;
        Tue, 10 Oct 2023 01:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696902298;
        bh=k0eRqqsMXVD3oC/A3a5V9R91vn65AeWHRVM7YZojLFo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BVuOJwP3hJprYLEK4gr0WlsjZmxuJGEWqIyoxHn/X0iIvrt7awg6Yu1Sr45riaw32
         0RwH8muyLuuTLTzjckTO0nxJawr8Gq4APnMcv4U2TzytAWTWQyVlWLqjrAwwS5i5A4
         NH/3P9+VvYFalHm81eVf0LDZQ5eEhQXgu4LWYojRrvyOC8lEtwu6qGlSroPhlqC6PE
         sZ3LqwPIbQZb8aXPFqX+SwmPFcapo6V+XX0zUnTISoap7kcIONb5hqWZuFkDJPU7K9
         QrGGLcKbML9HLzQ/qfEwZ93DKvQY7wA9+DtQc3tXJUHrAV0AjUmG0tLb5Pe6tBl/NW
         Ytz5NA2HHdlEg==
Date:   Tue, 10 Oct 2023 09:44:44 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v5 7/7] arm64: dts: imx93: update gpio node
Message-ID: <20231010014444.GE819755@dragon>
References: <20231001-vf610-gpio-v5-0-8d873a8f224a@nxp.com>
 <20231001-vf610-gpio-v5-7-8d873a8f224a@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001-vf610-gpio-v5-7-8d873a8f224a@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 04:27:58PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per binding doc, i.MX93 GPIO supports two interrupts and one register
> base, compatible with i.MX8ULP. The current fsl,imx7ulp-gpio compatible
> could work for i.MX93 in gpio-vf610.c driver, it is based on the base
> address are splited into two with offset added in device tree node.
> 
> Now following hardware design, using one register base in device tree node.
> 
> This may break users who use compatible fsl,imx7ulp-gpio to enable
> i.MX93 GPIO.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
