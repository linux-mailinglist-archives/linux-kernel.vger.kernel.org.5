Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFE575B549
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGTRNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjGTRNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:13:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4751715;
        Thu, 20 Jul 2023 10:13:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45E2161B8F;
        Thu, 20 Jul 2023 17:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0799C433C8;
        Thu, 20 Jul 2023 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689873189;
        bh=YAD5j5uWVee1yIDJ++UcTVLGboz0Oz2sQv9+weUQ+gA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hqe/4Wf5GM3AXz2lHYuShpvW5wAN11zVlctn67kdVOZqfvSNk+RQvZA/C0PMb0Dsv
         3GUpMCHaGaJgDpfXBZPPoXjb2KqPTwpR6k+czcvoWkuDb9q43BcgwAWS05sjUIjLbr
         3x2jFtlUAMKyPYvHIiETgObsWBvoWcMF1HI8WO2TL6YC/QSNY4aG+1iW59KcGe9Ht3
         TB9LA3hXnEhZAdRr6Yao0UToLFPWs7nY8oomeXCPL2aA45Ov5TB5RbE0Usikl8rIWN
         /ejT5Rj0kGTyXhhhcSZEfrmcXNd+LooKUI3ngL5+yFCJVZ6XjTRK4bp28Q/Xfb0KDO
         9Tf/75Gz0dYwg==
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Add JH7110 AON PMU support
Date:   Thu, 20 Jul 2023 18:12:17 +0100
Message-Id: <20230720-magnifier-goldfish-7d5a84e99c4d@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230519060202.15296-1-changhuang.liang@starfivetech.com>
References: <20230519060202.15296-1-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=943; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=ANuhIpiKMyYCW2Cf4joIjuKAf5hgTppu/jZEMHKz0Jo=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCk7s9692/g3r+Bp1h3FidL73YsuO/JPVvyY7nr+odLR5 he15pJJHaUsDGIcDLJiiiyJt/tapNb/cdnh3PMWZg4rE8gQBi5OAZhIsigjw8cHy/8s14y94LrV SEP+m4b3zsICb3UL02f62juzq3pUbBgZ+muZnz0wvfI3zXT26uuvRDM+KM7cuZX1csFmkzOnr1y y5QMA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Thu, 18 May 2023 23:01:58 -0700, Changhuang Liang wrote:
> This patchset adds aon power domain driver for the StarFive JH7110 SoC.
> It is used to turn on/off dphy rx/tx power switch. It also can use syscon
> operation. The series has been tested on the VisionFive 2 board.
> 
> This patchset should be applied after the patchset [1]:
> [1] https://lore.kernel.org/all/20230512022036.97987-1-xingyu.wu@starfivetech.com/
> 
> [...]

Applied to riscv-soc-for-next, thanks!

[1/4] dt-bindings: power: Add power-domain header for JH7110
      https://git.kernel.org/conor/c/2b8f8c6e797c
[2/4] soc: starfive: Replace SOC_STARFIVE with ARCH_STARFIVE
      https://git.kernel.org/conor/c/36393facfabf
[3/4] soc: starfive: Extract JH7110 pmu private operations
      https://git.kernel.org/conor/c/bd0c0d3dae34
[4/4] soc: starfive: Add JH7110 AON PMU support
      https://git.kernel.org/conor/c/30fb4784483b

I expect I'll get an email tomorrow from SFR pointing out some conflicts
with the new genpd stuff. I think the plan is for Arnd to sort those
things out prior to the next merge window.

Thanks,
Conor.
