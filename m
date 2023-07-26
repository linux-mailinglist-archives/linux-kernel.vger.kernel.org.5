Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26348763617
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 14:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjGZMRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 08:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjGZMRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 08:17:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0FC1FEF
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 05:17:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2027961A46
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 12:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51418C433C8;
        Wed, 26 Jul 2023 12:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690373851;
        bh=WorFpKy9ikPAh/VITbnnCumYdCQIEKOASIpf7VOhCpI=;
        h=From:To:Cc:Subject:Date:From;
        b=nX3hvYP1ZyUCO+DVn5TL4RpkWpN+wuNQAZGZAtY/44njl1yBr/5qgnvJGAYUW3G0i
         T9HvvF/bt4oLrEVU9Sv0y5Q2FVAWM5zOnqZ+kccemul6L1Qi55IY7R/Tj4uHeyOahu
         QhRNi6NGo4Y/XTZaE/Zg1DwRPjm9Hg7nZ8ml7RS29WbCY+0LCUFQau10oOfbk3n5bH
         65dCEstoHwLfch1tMIOPajRDl3fo8byKDYbzARuZcZLaLjjqtECv/26S/CsJdTVe7i
         ZwseJDShKyf99d5nisLxf45mJM1kB0myPN98OUWrRjZyJFf2rRA8h+8pBqqs9FK4VW
         22NANVIyU+mPg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Joel Stanley <joel@jms.id.au>,
        Walker Chen <walker.chen@starfivetech.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] soc: starfive: remove stale Makefile entry
Date:   Wed, 26 Jul 2023 14:17:14 +0200
Message-Id: <20230726121724.3701240-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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

From: Arnd Bergmann <arnd@arndb.de>

After the only starfive driver was moved out to the genpd subsystem, we get
a build failure:

scripts/Makefile.build:41: drivers/soc/starfive/Makefile: No such file or directory

Fixes: f3fb16291f486 ("soc: starfive: Move the power-domain driver to the genpd dir")
Reported=by: kernel test robot <lkp@intel.com
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 3b0f9fb3b5c84..efdcd42f68cb3 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -29,7 +29,6 @@ obj-y				+= renesas/
 obj-y				+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
 obj-y				+= sifive/
-obj-$(CONFIG_SOC_STARFIVE)	+= starfive/
 obj-y				+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-y				+= ti/
-- 
2.39.2

