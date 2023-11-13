Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 844777E95A4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 04:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233054AbjKMDmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 22:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjKMDmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 22:42:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A6B1729
        for <linux-kernel@vger.kernel.org>; Sun, 12 Nov 2023 19:42:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A2B3C433C7;
        Mon, 13 Nov 2023 03:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699846957;
        bh=O3cH1Fu2ItcqGrkgGUT5x/tZj005EiXhXeidtgeHun4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HR6BsHSGZNoVasTuN9MY7ZHzwJlHPhgbyawvAQD7jJv+2caeTQ25+8cvcvX+pe3TF
         5IrgjkPEXGhoEqnK/+ptHFOjyUUd1sbWtRjennBBL2acAdxykzHEM7ZBUHOt7LiukF
         B9kybCG1XZo2URx1H9kZQfRRWrf5ZpjRvtYW+XADGTe2VphhRnxVIeKjDc33I3l3rT
         bj8jbCJzMEA8szH07kqyXorX5OXinQjn7pXPIy+BJAVN55Tk1mJp/M0mhbeK+eI/GR
         2GhBxOLQ0ZwIL65AQLaqSUR6CiyTb/p2QVoHQT0N8cxHO4If2ephHh3xR1v9KkUfY3
         cnycQM4o0gylA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E28A3E32711;
        Mon, 13 Nov 2023 03:42:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/9] media: cros-ec-cec: Add support for multiple ports
From:   patchwork-bot+chrome-platform@kernel.org
Message-Id: <169984695692.27851.18059442227067632495.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Nov 2023 03:42:36 +0000
References: <20230825024735.1443836-1-rekanorman@chromium.org>
In-Reply-To: <20230825024735.1443836-1-rekanorman@chromium.org>
To:     Reka Norman <rekanorman@chromium.org>
Cc:     hverkuil-cisco@xs4all.nl, dnojiri@chromium.org,
        narmstrong@baylibre.com, sadolfsson@google.com,
        bleung@chromium.org, groeck@chromium.org, mchehab@kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Hans Verkuil <hverkuil-cisco@xs4all.nl>:

On Fri, 25 Aug 2023 12:43:53 +1000 you wrote:
> The Google Dibbi chromebox will have two HDMI ports with CEC enabled via
> its EC. Currently, the cros-ec-cec driver and the host command interface
> to the EC assume there is only one port. E.g. the commands have no
> parameter to indicated which port to operate on.
> 
> This series adds support for multiple ports. The driver is modified to
> manage an array of ports, each with their own CEC adapter and notifier.
> The host command interface is modified to support multiple ports. All
> changes to interface are backwards compatible.
> 
> [...]

Here is the summary with links:
  - [v2,1/9] media: cros-ec-cec: Use cros_ec_cmd to send host commands
    https://git.kernel.org/chrome-platform/c/afca12e35e71
  - [v2,2/9] media: cros-ec-cec: Manage an array of ports
    https://git.kernel.org/chrome-platform/c/4d0e179a4287
  - [v2,3/9] media: cros-ec-cec: Support multiple ports in set/get host commands
    https://git.kernel.org/chrome-platform/c/e90bd1fe7cda
  - [v2,4/9] media: cros-ec-cec: Support multiple ports in write command
    https://git.kernel.org/chrome-platform/c/adbfc747ddfb
  - [v2,5/9] media: cros-ec-cec: Support multiple ports in MKBP cec_events
    https://git.kernel.org/chrome-platform/c/1cabf52639d1
  - [v2,6/9] media: cros-ec-cec: Support receiving messages from multiple ports
    https://git.kernel.org/chrome-platform/c/425d20518c54
  - [v2,7/9] media: cros-ec-cec: Allow specifying multiple HDMI connectors
    https://git.kernel.org/chrome-platform/c/e7885b9c6564
  - [v2,8/9] media: cros-ec-cec: Get number of CEC ports from EC
    https://git.kernel.org/chrome-platform/c/5d227f02ceb9
  - [v2,9/9] media: cros-ec-cec: Add Dibbi to the match table
    https://git.kernel.org/chrome-platform/c/8d3e6030e30f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


