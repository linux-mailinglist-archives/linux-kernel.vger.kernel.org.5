Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB5B81186A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442381AbjLMPyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442359AbjLMPyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:54:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2751AD5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:54:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB99C433C9;
        Wed, 13 Dec 2023 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702482845;
        bh=2y1sC29LZVf5pOO/mDDd70nkQpS3j6F+u18Jw81+VcA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fa+vjghEYQ0QZb4ZiejM15rw46zji/7Gzsvf2LAZB3W933pTv/Tg+V9MeSa+WaEXx
         wzA9dbitQYvjCM68noceSUh3BUyRIKPFX8MXHilP66g45R2+UHY1mxzCIVnPZhmsGz
         nssRld9YUiq0kRlKfJ5SWsfeF1tQzGPefMR38OeG0MYtjPJVehcGC80j39arrmZCFZ
         pk+xRIWaRhh3gfH4mDdhBxSbiCp31MxmRyPw190pYPsC39MTC8VMVpKtfILskV8CZ3
         8SjjT3UH3jgN/7THPi5rAgp9uF8ct/4jlvvRoA+TOtoywK6RkfyZR98WuNdbaDqqsT
         bT+JrUroiOb2w==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: (subset) [PATCH v2 0/8] Add JH7100 errata and update device tree
Date:   Wed, 13 Dec 2023 15:53:56 +0000
Message-Id: <20231213-animating-ambiguous-b8267c78e335@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
References: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1318; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=bDevohe/TkJ99xD3EWfy4Mbir3mmI5PygrNqH48gvbE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmVlydV/7r2TMbr1Dymn6LXFj5242m78l/nkvrWdXFmP X6LFyYUd5SyMIhxMMiKKbIk3u5rkVr/x2WHc89bmDmsTCBDGLg4BWAih+cyMnx/p+8+ZVKr1+Q+ 0XUbvvEemfFVuMno46acPSHaJ49tfHqE4b9nseD609fOXraw55JYuat/dXJWtuj/bDu+DUV7fx/ 458gOAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Thu, 30 Nov 2023 16:19:24 +0100, Emil Renner Berthing wrote:
> Now that the driver for the SiFive cache controller supports manual
> flushing as non-standard cache operations[1] we can add an errata option
> for the StarFive JH7100 SoC and update the device tree with the cache
> controller, dedicated DMA pool and add MMC nodes for the SD-card and
> wifi.
> 
> This series needs the following commit in [1] to work properly:
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[2/8] riscv: dts: starfive: Group tuples in interrupt properties
      https://git.kernel.org/conor/c/dd3c1b365fe9
[3/8] riscv: dts: starfive: Mark the JH7100 as having non-coherent DMAs
      https://git.kernel.org/conor/c/ba0074972ee9
[4/8] riscv: dts: starfive: Add JH7100 cache controller
      https://git.kernel.org/conor/c/d4b95c445cab
[5/8] riscv: dts: starfive: Add pool for coherent DMA memory on JH7100 boards
      https://git.kernel.org/conor/c/0a99b562e815
[6/8] riscv: dts: starfive: Add JH7100 MMC nodes
      https://git.kernel.org/conor/c/a29bb6564e12
[7/8] riscv: dts: starfive: Enable SD-card on JH7100 boards
      https://git.kernel.org/conor/c/c548409cfe03
[8/8] riscv: dts: starfive: Enable SDIO wifi on JH7100 boards
      https://git.kernel.org/conor/c/56b10953da7e

Thanks,
Conor.
