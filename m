Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC3E776798
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 20:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjHISqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 14:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjHISqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 14:46:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904E5E51;
        Wed,  9 Aug 2023 11:46:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 30122611D5;
        Wed,  9 Aug 2023 18:46:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DD8C433C8;
        Wed,  9 Aug 2023 18:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691606792;
        bh=0PVyUV/LZNkQhPq86fn/3LqQlvLNkh8cxs/e9gDxcnQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o4wyRVmqY0rfTGXhYrJnCsqNhhXtYJgID8Xj6a+aJ/G0alIjdVNVA+1bW3SJvSuBL
         i760nXOLnMdTlZFoOW4uoMnQfmBTJZouegrVhbcG7cWa7W6KeEPHWb2HA9UqMYTSgu
         kfPXCTUoRI0mb78ZJ9dEfG7yp9TZdkK3BlsLbAqRyGoQxTlZFhLCcCZUpyWH18du5g
         CKKEXaXmgCwvBAKlgOjyQAjfh+Cs3opfevX2tKulWLiEDf6SuvUcsqFiep+WggNH/s
         Il/phtseAz3k4ASDEeJzySULga3xQhBZnW566Rmd5dPY+uI9EOiZXJ/4Yj8iSEj4n6
         FHHhfyq9ScPWA==
From:   Conor Dooley <conor@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] riscv: dts: starfive - Add crypto and trng node
Date:   Wed,  9 Aug 2023 19:46:24 +0100
Message-Id: <20230809-boogieman-kiwi-4528c4b925d7@spud>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230808141558.296631-1-jiajie.ho@starfivetech.com>
References: <20230808141558.296631-1-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=708; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=EoQ2wQ3bzDClK5rpakCInBeyO1//Echy2oc4sehgcho=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDCmX7/3fvqHJ6c+Z84/mC+w8voOZt6az8/j9ZyLxrkqmy 5p/fJoo0lHKwiDGwSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJTLjB8M/yeMeHuDnrfbKO X0pnjdhnOPPXi5S/D/9aJv6cuiv0bbU6wz8t9jPRd3cGnVRcJ6Z2qul8bQSbofjV3zcVft1Vurq iqIAPAA==
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

On Tue, 08 Aug 2023 22:15:56 +0800, Jia Jie Ho wrote:
> The following patches add hardware cryptographic and trng module nodes
> to JH7110 dts. Patches have been tested on VisionFive2 board.
> 
> v2 - Fixed dtbs_check errors on dma node in patch 1. (Conor)
> 
> Jia Jie Ho (2):
>   riscv: dts: starfive - Add crypto and DMA node for JH7110
>   riscv: dts: starfive - Add hwrng node for JH7110 SoC
> 
> [...]

Applied to riscv-dt-for-next, thanks!

[1/2] riscv: dts: starfive - Add crypto and DMA node for JH7110
      https://git.kernel.org/conor/c/e2c07765e179
[2/2] riscv: dts: starfive - Add hwrng node for JH7110 SoC
      https://git.kernel.org/conor/c/87ddf5b10964

Thanks,
Conor.
