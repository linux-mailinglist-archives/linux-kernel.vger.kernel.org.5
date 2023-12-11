Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9701A80CEF7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343875AbjLKPEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343865AbjLKPD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:03:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F7EA9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:04:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C37ADC433C7;
        Mon, 11 Dec 2023 15:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702307046;
        bh=IrH6aa/oGSpb78xUbgGhpZuk8lP0RCbUq/v+VLpNYcY=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=tfNOIv8WYCFmw7THIgtuWaQ7B/p/C11+vUq86HWaXy73S54IfJYPYsA6LJS0F7ve9
         woS3LiETdWq4UC/Uq8A9bF8rDDba4ZqPLy/JmsgrVBGd1VzSIqS/fgaOiVCFGBxeUT
         dqVgQC7HbQQthJ/2ls932SgzVStyHDAyeH4Hn5iqz1EStY3VwQfQHvOtZmy3p4PChP
         BSduI0QyQPWbAbxsGTyy3s63CkpUa6cQDfdDuTGlhr6NtXu7YrbEie4ojfQVECuc0W
         MKWhPpeuLthVHZJJvmv33Dslb0kOe4mghj6hj/8d8qle1Mnhc07MBWUIvYH87b4BUq
         /8icIB8tRzj4w==
From:   Vinod Koul <vkoul@kernel.org>
To:     imx@lists.linux.dev, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20231127214325.2477247-1-Frank.Li@nxp.com>
References: <20231127214325.2477247-1-Frank.Li@nxp.com>
Subject: Re: [PATCH 1/1] dmaengine: fsl-edma: fix DMA channel leak in
 eDMAv4
Message-Id: <170230704442.319897.10351287575492933941.b4-ty@kernel.org>
Date:   Mon, 11 Dec 2023 20:34:04 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 27 Nov 2023 16:43:25 -0500, Frank Li wrote:
> Allocate channel count consistently increases due to a missing source ID
> (srcid) cleanup in the fsl_edma_free_chan_resources() function at imx93
> eDMAv4.
> 
> Reset 'srcid' at fsl_edma_free_chan_resources().
> 
> 
> [...]

Applied, thanks!

[1/1] dmaengine: fsl-edma: fix DMA channel leak in eDMAv4
      commit: 4ee632c82d2dbb9e2dcc816890ef182a151cbd99

Best regards,
-- 
~Vinod


