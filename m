Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A39B7E9657
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 05:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbjKMEub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 23:50:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKMEu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 23:50:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495B8171B
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 20:50:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7510C433C9;
        Mon, 13 Nov 2023 04:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699851025;
        bh=bUf+/gTdXd1ZzU15zgL5XesRLAJnbVGMdqnzNEOPshw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AQ+5mPjuMhg0ZLwgpbb6fT22wkl/31mASTn1eZ05WuT/rgSvjijpRaVwSpsr+vnqI
         GjVGpXdpHfR1ng6SOReSjIcBJZ/2fZ4kMSh59OvllUSY+xzQ6VlZ32EG7WvfE7H2Zp
         Y0F2plGZe6Xej05tSdIFqN3IYG4eL9xRkRN4+9lr3+iYPf1+d9z8clr4Cq28aQC9kD
         NBj235zX2RRbhEf8xZY9SeMvoKBY+6xyYgjihxeQb5U72x6P31dxBrYICwWTsqMdRo
         ZcNonSgVD9scMcudl0W48unm/FNCJYsEFgiM0jDuIc4xBR708FHmGviH68aSZQ/JaV
         P+3A+ZUzWRXFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98FFFC04DD9;
        Mon, 13 Nov 2023 04:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] platform/chrome: sensorhub: Implement quickselect for
 median calculation
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169985102562.12923.10861962849443008728.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Nov 2023 04:50:25 +0000
References: <20231110165314.1559285-1-visitorckw@gmail.com>
In-Reply-To: <20231110165314.1559285-1-visitorckw@gmail.com>
To:     Kuan-Wei Chiu <visitorckw@gmail.com>
Cc:     bleung@chromium.org, tzungbi@kernel.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Sat, 11 Nov 2023 00:53:14 +0800 you wrote:
> The cros_ec_sensor_ring_median function currently uses an inefficient
> sorting algorithm (> O(n)) to find the median of an array. This patch
> replaces the sorting approach with the quickselect algorithm, which
> achieves an average time complexity of O(n).
> 
> The algorithm employs the median-of-three rule to select the pivot,
> mitigating worst-case scenarios and reducing the expected number of
> necessary comparisons. This strategy enhances the algorithm's
> efficiency and ensures a more balanced partitioning.
> 
> [...]

Here is the summary with links:
  - [v2] platform/chrome: sensorhub: Implement quickselect for median calculation
    https://git.kernel.org/chrome-platform/c/d131f1f3b459

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


