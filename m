Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5491F7EE398
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 16:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345395AbjKPPAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 10:00:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345391AbjKPPAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 10:00:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EE8D56
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 07:00:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23A0CC433C7;
        Thu, 16 Nov 2023 15:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700146827;
        bh=6yJFsAiIgRdd7mwN0bgpBt2+ND8YpXifms7Wy+EMAl4=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=BuzTlnhBTSCVNJ2gexMe/7CqYKGP1TYRYYy7izwRPvdtfmxFwKiqFMa3NtB7BbAkn
         05U/3gPilj4S1bViWANu6WbeLRqBlQorzeTN2WD7Tu3hZU1Yms7so5UMbWmNm+iw57
         fVoRBblDeTKYYUqHnm9G1/dUes7nSa8qXIuNhhb9Ytt3Kx8WEEaP5w0Bl/A5xt+29W
         0QIDlOaQfDrL8zj12ujGKCMQP1WgsEb1DPq1doBDosqoe29tTB6j4gXazGxuBNvxkE
         nYOZ6eICUMtOQvfl+NhoE7msov1FloN3iaOHQ5wGWlFX1qWPjXV3iVq145UdF+Liv+
         Ud+d67ymKS1fA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Siddharth Vadapalli <s-vadapalli@ti.com>,
        Roger Quadros <rogerq@kernel.org>, Andrew Davis <afd@ti.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231025143302.1265633-1-afd@ti.com>
References: <20231025143302.1265633-1-afd@ti.com>
Subject: Re: [PATCH] phy: ti: gmii-sel: Fix register offset when parent is
 not a syscon node
Message-Id: <170014682469.545161.9778178408196778168.b4-ty@kernel.org>
Date:   Thu, 16 Nov 2023 20:30:24 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Oct 2023 09:33:02 -0500, Andrew Davis wrote:
> When the node for this phy selector is a child node of a syscon node then the
> property 'reg' is used as an offset into the parent regmap. When the node
> is standalone and gets its own regmap this offset is pre-applied. So we need
> to track which method was used to get the regmap and not apply the offset
> in the standalone case.
> 
> 
> [...]

Applied, thanks!

[1/1] phy: ti: gmii-sel: Fix register offset when parent is not a syscon node
      commit: 0f40d5099cd6d828fd7de6227d3eabe86016724c

Best regards,
-- 
~Vinod


