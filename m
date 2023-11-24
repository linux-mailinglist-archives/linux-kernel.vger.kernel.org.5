Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234107F752F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345384AbjKXNcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjKXNcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:32:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AFE1705
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 05:32:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20953C433CA;
        Fri, 24 Nov 2023 13:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700832768;
        bh=OxPdX1D49J4pS6uUVVoVupQV69O05wbnXnjZfPVmrN8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=pMMXuX3rxCt1aOpK7pkVyWhmOptJlp+1aBC/1VjS8cJDzAmBSol3SYNEw/7Ea18+o
         SIjTYjMkDHBBOcwCST12EApvPlcKY24pbZiEc3QyJp8a9JyrjPXL8s4dtTobMd/Oxf
         akG7oZp/6raKjFLrgKwA1UmCAl3UjkXEyTYpnFUurAGA39cMo2xhCZ9FAJb+JXBpDM
         /yXKmyoAgA+oPcWm1nI0kFDJsFx32naFpvBvhyX4Qn746bRL0uU2m77pHqW4+wRnCa
         jNbCwO+hUvVdkXVTmbbJ5sGyOnWDOqqGZ3WIE/li+i1ChDQstn8kYh+QTs+OnfZltC
         jnP6ewlqCYMPw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank.Li@nxp.com, Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     imx@lists.linux.dev, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231113225713.1892643-1-xiaolei.wang@windriver.com>
References: <20231113225713.1892643-1-xiaolei.wang@windriver.com>
Subject: Re: [PATCH v2 0/2] Fix two exceptions after the introduction of
 edma v3
Message-Id: <170083276674.771401.18274352641814833239.b4-ty@kernel.org>
Date:   Fri, 24 Nov 2023 19:02:46 +0530
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


On Tue, 14 Nov 2023 06:57:11 +0800, Xiaolei Wang wrote:
> In the v2 version, I updated the commit that introduced these two issues.
> 
> Xiaolei Wang (2):
>   dmaengine: fsl-edma: Do not suspend and resume the masked dma channel
>     when the system is sleeping
>   dmaengine: fsl-edma: Add judgment on enabling round robin arbitration
> 
> [...]

Applied, thanks!

[1/2] dmaengine: fsl-edma: Do not suspend and resume the masked dma channel when the system is sleeping
      commit: 2838a897654c4810153cc51646414ffa54fd23b0
[2/2] dmaengine: fsl-edma: Add judgment on enabling round robin arbitration
      commit: 3448397a47c08c291c3fccb7ac5f0f429fd547e0

Best regards,
-- 
~Vinod


