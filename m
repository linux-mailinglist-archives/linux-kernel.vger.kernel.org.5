Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120307EAA64
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 07:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjKNGA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 01:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNGA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 01:00:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BE7D42
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 22:00:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EE2EC433C9;
        Tue, 14 Nov 2023 06:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699941624;
        bh=j4BPfU4JGML+eRFRsSqArgl/gmW3iNbf6MXiLOGvgDI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Pt6hoMqeTHrb5TKBx4eKgCP2/DBsIKGLD3HDl5DIUV0rJwDkeeLYLfsHj0aeV7j/M
         sZYTUpD9a4g93FaafPshC9Qv64e11oVsoNsOoSMttanFUNeXQomj0GrG3zoR2uQCmf
         DwyPFxPVSp+c5FsOuOtdpG+0RJAQk0CTS/I0UiMOtAvPy9eg3iw/69xle+ay9TpkRr
         jq4Lpo+/uNwmyQefH6ENe2G7CJNBIO1JfgvpL7gkOYOXSRP5fMGs02n+fcFaf8KOoW
         bFAjSqGRFUyM2GCJhTOgsvmuUCMTGARJV+AcuZt5eTosvf6gMD5T39FHA2xELf6iMU
         /9FGk3MTwOSTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EABB5E1F660;
        Tue, 14 Nov 2023 06:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] platform/chrome: sensorhub: Implement quickselect for
 median calculation
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169994162395.30294.11655195968151519457.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Nov 2023 06:00:23 +0000
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

This patch was applied to chrome-platform/linux.git (for-next)
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


