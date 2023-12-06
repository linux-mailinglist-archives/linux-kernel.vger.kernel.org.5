Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FE38063A4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 01:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376348AbjLFAue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 19:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376296AbjLFAud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 19:50:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4DFAC
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 16:50:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DFFC433C7;
        Wed,  6 Dec 2023 00:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701823839;
        bh=6uGR7M2ZAev8TltVwikb3TtSRdu6K6qqXKUO6nna42k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GovoiYytNJvMxezHyGg/MMwsKaxLbxyKHqjxdrJco4KwmwVUQ5/8x3cGnvMXJdM+m
         KxOrYOrh2mgbQbjltp/osE0XYD+SVg7JdMo/OxpkNkrWfGvK+wasCF6ZUpdCkBNQSc
         aoqLwFwLAaIoPo7duMvDQGh8sG76cQ3LWQdKuR3tMqx70OHXHQcF1DwR1JZ6yokAMi
         0EGGFN4wMQZcR187hhwj76MbezMTZrb8Zaw0RquipCdHHXz4EfxyJ8Ti4Vh+sfNPg6
         1p/u+igjfZ/vQiRnDus0h+7pL2b1KAGz0fucTPLc2zJfCuBnm1Os38qN0IAmoVgg6+
         nCdvQUnOPfrCQ==
Date:   Wed, 6 Dec 2023 08:50:33 +0800
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
Subject: Re: [PATCH v2] arm64: dts: imx8mn-var-som-symphony: add vcc supply
 for PCA9534
Message-ID: <20231206005033.GK236001@dragon>
References: <20231107155040.1644169-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231107155040.1644169-1-hugo@hugovil.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 10:50:40AM -0500, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The following warning is shown when probing device:
> 
>     pca953x 1-0020: supply vcc not found, using dummy regulator
> 
> Define a new fixed 3.3v regulator for carrier board peripherals,
> enabled by mosfet switch Q2 after the SOM_3V3 supply rises (no software
> control).
> 
> Add this new regulator as vcc supply to the PCA9534 to silence the warning.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied, thanks!
