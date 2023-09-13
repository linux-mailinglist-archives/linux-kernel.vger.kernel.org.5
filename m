Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D398279E989
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241016AbjIMNnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241002AbjIMNnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:43:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1812F19BF;
        Wed, 13 Sep 2023 06:43:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38425C433C9;
        Wed, 13 Sep 2023 13:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694612584;
        bh=a6eJFMD7UYNieE8ipLLApaS7mzhbB7aFjI27sQ41vYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJi+xGH0yrj+npciZCHvuvASWqtk4I+kILeKP67P3Q9Di+vGZr3SGaZB12YH6aj0f
         unXLzNF8vC11jYZncTri1Peu5A48lOmWd02PkhinYT56fObW6hnOLKwVO775t3ycVR
         dqsmV/XSDlpYDaxBFngOszwFk5974F05Po7xOgaMMI8GfFMq4cUZ/ORh24wT7SyY9T
         4rrNUMTLayZrnqbMyj3j0F4zjoIEn7o1QuT/KEIZ0zirf2GpnzOllxb+i8DBttOXQt
         RTGKQXTCXoG8Gdeqxnj4RdDFiAzm+NItzHDwbqnkUeeE26oPkOockb77oUwKOl2FTQ
         i86CCqZx/Cxbw==
From:   Conor Dooley <conor@kernel.org>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Maxim Kochetkov <fido_max@inbox.ru>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jose Abreu <joabreu@synopsys.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: (subset) [PATCH v2 0/5] Add I2S support for the StarFive JH7110 SoC
Date:   Wed, 13 Sep 2023 14:42:51 +0100
Message-Id: <20230913-duly-ecosystem-523099962151@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230821144151.207339-1-xingyu.wu@starfivetech.com>
References: <20230821144151.207339-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1006; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=gTDwtdWsXuWMdJzLCtxk+GWpTOa8FGy41bK8MQux3T0=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKmMe6Jmt63vkdN3PNruwzAj8ueZByc8bA+Wdn9RK5tZK M7ylLuxo5SFQYyDQVZMkSXxdl+L1Po/Ljuce97CzGFlAhnCwMUpABNRXsTIsMCPa/OK6Jt/p4Qe UbzmUH11/Z5dzG3aHBWLfqqvTzdR9WJkOPNyR9Dk6/cqJpcFJi/7+mPy4x7VL2sb9x7ecLGLTTO hnwUA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Mon, 21 Aug 2023 22:41:46 +0800, Xingyu Wu wrote:
> This patch series adds I2S support for the StarFive JH7110 RISC-V
> SoC based on Designware I2S controller. There has three I2S channels
> (RX/TX0/TX1) on the JH7110 SoC, one of which is for record(RX) and
> two for playback(TX).
> 
> The first patch adds support for the StarFive JH7110 SoC in the
> Designware I2S bindings.
> The second patch adds the ops to get data from platform bus in the
> I2S driver.
> The third patch adds support for the StarFive JH7110 SoC in
> the Designware I2S driver.
> The fourth patch fixes the name of I2STX1 pinmux.
> The last patch adds device node of I2S RX/TX0/TX1 in JH7110 dts.
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[4/5] riscv: dts: starfive: pinfunc: Fix the pins name of I2STX1
      https://git.kernel.org/conor/c/4e1abae5688a
[5/5] riscv: dts: starfive: Add the nodes and pins of I2Srx/I2Stx0/I2Stx1
      https://git.kernel.org/conor/c/92cfc35838b2

Thanks,
Conor.
