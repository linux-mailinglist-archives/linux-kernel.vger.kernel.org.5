Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D8B7F25BF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjKUG0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjKUG0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:26:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9403DA2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:26:43 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9AF5C433C8;
        Tue, 21 Nov 2023 06:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700548003;
        bh=K/GIre7/aaf5KKOTYdjEhbwA8DjYu7HfQ3ztK+lF4no=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OIRiivFczdXkkYUnne5meFOx5OKOCK9mA6gH6jo86odlLlNQ3iQrtz8MFlqit1HQU
         mIuyN9mlLgwdPpPdmTbM5KqN1MUYrQiiWwr2u1peWwu9hO3Y3v4wCfyM32bdTZBCPP
         1i22hz77qvJoyWphDGAbm/KwubzWCoB9S0r1J4AQr9O9K1UDW0oT82/JLYXUs/FTRY
         4h/bQKPwRTTJR1LGEcqKi747MSQvz2TIh9dquY53RmAAgYEf1k8VzWCe6cXa9SxDun
         ypED2XKR1WyXfnfa7Ux93nGLW3FaeFOEVSXdsz1izuh/nKQojNgYBofmeLr+GJTDMu
         Y28Q1oOjF3B3Q==
Date:   Tue, 21 Nov 2023 11:56:29 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Kory Maincent <kory.maincent@bootlin.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v6 0/6] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Message-ID: <20231121062629.GA3315@thinkpad>
References: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 11:03:48AM +0100, Kory Maincent wrote:
> This patch series fix the support of dw-edma HDMA NATIVE IP.
> I can only test it in remote HDMA IP setup with single dma transfer, but
> with these fixes it works properly.
> 
> Few fixes has also been added for eDMA version. Similarly to HDMA I have
> tested only eDMA in remote setup.
> 

Just out of curiosity, can you share how you are setting EDMA_MF_HDMA_NATIVE?

- Mani

> Changes in v2:
> - Update comments and fix typos.
> - Removed patches that tackle hypothetical bug and then were not pertinent.
> - Add the similar HDMA race condition in remote setup fix to eDMA IP driver.
> 
> Changes in v3:
> - Fix comment style.
> - Split a patch in two to differ bug fix and simple harmless typo.
> 
> Changes in v4:
> - Update patch git commit message.
> - Link to v3: https://lore.kernel.org/r/20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com
> 
> Changes in v5:
> - No change
> - Rebase to mainline 6.7-rc1
> - Link to v4: https://lore.kernel.org/r/20231011-b4-feature_hdma_mainline-v4-0-43d417b93138@bootlin.com
> 
> Changes in v6:
> - Fix several commit messages and comments.
> - Link to v5: https://lore.kernel.org/r/20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
> Kory Maincent (6):
>       dmaengine: dw-edma: Fix the ch_count hdma callback
>       dmaengine: dw-edma: Fix wrong interrupt bit set for HDMA
>       dmaengine: dw-edma: HDMA_V0_REMOTEL_STOP_INT_EN typo fix
>       dmaengine: dw-edma: Add HDMA remote interrupt configuration
>       dmaengine: dw-edma: HDMA: Add sync read before starting the DMA transfer in remote setup
>       dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
> 
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 39 +++++++++++++++++++++++------------
>  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
>  3 files changed, 44 insertions(+), 14 deletions(-)
> ---
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> change-id: 20231011-b4-feature_hdma_mainline-b6c57f8e3b5d
> 
> Best regards,
> -- 
> Köry Maincent, Bootlin
> Embedded Linux and kernel engineering
> https://bootlin.com
> 

-- 
மணிவண்ணன் சதாசிவம்
