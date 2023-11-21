Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0103E7F2C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 13:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbjKUMIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 07:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKUMIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 07:08:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B166125
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 04:08:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5549C433C9;
        Tue, 21 Nov 2023 12:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700568522;
        bh=xY/S+drvjUTqo2Fu2FpUAKYEb7XcjqGXCgM5ZYigqpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LxWBqy9UnCrGoq3oBdWsp9PGMjwX7o7lQB4D4cAFspVDDEzdm5Rav9/N168AUm8N0
         hdKRHRpQYw0ljwk0KcHOd0jUhTEvIWFPeiArFDdoPU4IrA7U3QYb1z+/dgj69VQoAc
         mG7s8o2GEMP1PuGAGPoIsNLRW/lXPLSiVCk7M3SObX6IbuZWKRvcbaWXLgaZURsFNN
         WO4/JmldKDx1guTwRg7s/FXMzvtaWylSESJLort26n6tx2isMCmupoje6lspivqtd3
         P1NcXQlLBETlPYSWfEWOUTAxy3dnv3DogJjX3F2c14emfUTjhjJrBzzT+hq4WFL2km
         i5NBtxDZafi1g==
Date:   Tue, 21 Nov 2023 17:38:28 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Kory Maincent <kory.maincent@bootlin.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>
Subject: Re: [PATCH v6 0/6] Fix support of dw-edma HDMA NATIVE IP in remote
 setup
Message-ID: <20231121120828.GC3315@thinkpad>
References: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
 <20231121062629.GA3315@thinkpad>
 <js3qo4i67tdhbbcopvfaav4c7fzhz4tc2nai45rzfmbpq7l3xa@7ac2colelvnz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <js3qo4i67tdhbbcopvfaav4c7fzhz4tc2nai45rzfmbpq7l3xa@7ac2colelvnz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 01:55:22PM +0300, Serge Semin wrote:
> Hi Mani
> 
> On Tue, Nov 21, 2023 at 11:56:29AM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Nov 17, 2023 at 11:03:48AM +0100, Kory Maincent wrote:
> > > This patch series fix the support of dw-edma HDMA NATIVE IP.
> > > I can only test it in remote HDMA IP setup with single dma transfer, but
> > > with these fixes it works properly.
> > > 
> > > Few fixes has also been added for eDMA version. Similarly to HDMA I have
> > > tested only eDMA in remote setup.
> > > 
> > 
> > Just out of curiosity, can you share how you are setting EDMA_MF_HDMA_NATIVE?
> 
> This topic has already been concerned on v1 (in another context
> though):
> https://lore.kernel.org/dmaengine/20230621151948.36125997@kmaincent-XPS-13-7390/
> 
> Here is the repo with the out-of-tree driver Kory said he was using
> together with the kernel's version of the DW eDMA/hDMA driver:
> https://github.com/Brainchip-Inc/akida_dw_edma
> 

Thanks Sergey, I missed it! But looks like we are not focusing on the HDMA
integration in designware-ep.c. Have you/anyone thought about it? Was it
discussed previously that I missed?

HDMA is used in one of the recent Qcom SoCs (SA8775) that Qcom folks are
bringing up and I'd like to have a common solution like we have for eDMA.

- Mani

> -Serge(y)
> 
> > 
> > - Mani
> > 
> > > Changes in v2:
> > > - Update comments and fix typos.
> > > - Removed patches that tackle hypothetical bug and then were not pertinent.
> > > - Add the similar HDMA race condition in remote setup fix to eDMA IP driver.
> > > 
> > > Changes in v3:
> > > - Fix comment style.
> > > - Split a patch in two to differ bug fix and simple harmless typo.
> > > 
> > > Changes in v4:
> > > - Update patch git commit message.
> > > - Link to v3: https://lore.kernel.org/r/20231011-b4-feature_hdma_mainline-v3-0-24ee0c979c6f@bootlin.com
> > > 
> > > Changes in v5:
> > > - No change
> > > - Rebase to mainline 6.7-rc1
> > > - Link to v4: https://lore.kernel.org/r/20231011-b4-feature_hdma_mainline-v4-0-43d417b93138@bootlin.com
> > > 
> > > Changes in v6:
> > > - Fix several commit messages and comments.
> > > - Link to v5: https://lore.kernel.org/r/20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com
> > > 
> > > Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> > > ---
> > > Kory Maincent (6):
> > >       dmaengine: dw-edma: Fix the ch_count hdma callback
> > >       dmaengine: dw-edma: Fix wrong interrupt bit set for HDMA
> > >       dmaengine: dw-edma: HDMA_V0_REMOTEL_STOP_INT_EN typo fix
> > >       dmaengine: dw-edma: Add HDMA remote interrupt configuration
> > >       dmaengine: dw-edma: HDMA: Add sync read before starting the DMA transfer in remote setup
> > >       dmaengine: dw-edma: eDMA: Add sync read before starting the DMA transfer in remote setup
> > > 
> > >  drivers/dma/dw-edma/dw-edma-v0-core.c | 17 +++++++++++++++
> > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 39 +++++++++++++++++++++++------------
> > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  2 +-
> > >  3 files changed, 44 insertions(+), 14 deletions(-)
> > > ---
> > > base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> > > change-id: 20231011-b4-feature_hdma_mainline-b6c57f8e3b5d
> > > 
> > > Best regards,
> > > -- 
> > > Köry Maincent, Bootlin
> > > Embedded Linux and kernel engineering
> > > https://bootlin.com
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
