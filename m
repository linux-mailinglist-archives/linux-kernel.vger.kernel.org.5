Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543FD8117D3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 16:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442244AbjLMPn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 10:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442569AbjLMPnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 10:43:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B738F212B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 07:43:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154A1C433CA;
        Wed, 13 Dec 2023 15:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702482179;
        bh=hkcptZUU72QGqUIGA2u1ZtU7E07KBVFxcMF2xAvR6u4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OwCt09Q1RWJLNWO0MDuEwZGt9IkbFtgsoctzaaeO0noYh6S1gFg2cd/dUnLZ49B3+
         LBfhqfjbjkM+nMXEcHHYLb/GJ1OUYk7eDPruZ7TbrQvOIFFpsyGYnWQL/qLmolr7R0
         Sn8Bb3MyJXaXx3I3ytBdwMN/U6HIuMbORSty8ziKODMDvsJvJjyRku86VuHntHcusR
         KsWfxsQeidwpNCPFPYVNwPD62fd9P+UXa2LqlNJ6EVvNybCOj9qH3TJhXNnerXfkU5
         0Qr8yhPEXnGbVdNGhBobuVWjlRxUmHUcibXK5Fr3NtPlAXUbDwM49L+HcJx6Msf4Jv
         8kuNMLvIJfQ0Q==
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
Date:   Wed, 13 Dec 2023 15:42:44 +0000
Message-Id: <20231213-jester-rendering-dd876ef8e8ac@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
References: <20231130151932.729708-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=615; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=uS9TPJL7JAemNHfJAG96Ozr9DLEia/BDfH/NodMVEi4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmVFz7NKPq9Wf/i82/1PJKM+a+/LLT8uEA9OVkvUemn9 XTnvoClHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhI8CZGhjO6oY7/Q4IjSk3V 6/YcYg9bG7YmLFziUYICj+/dxuUfVjEyTC/9JyH07PTaME+b1znb7sXYLatmPMWka2HdpKF5XNO TDwA=
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

Applied to riscv-cache-for-next, thanks!

[1/8] riscv: errata: Add StarFive JH7100 errata
      https://git.kernel.org/conor/c/64fc984a8a54

Thanks,
Conor.
