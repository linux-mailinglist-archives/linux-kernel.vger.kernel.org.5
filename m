Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31FFB7B1B68
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 13:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbjI1LsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 07:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbjI1Lr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:47:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BF2BF;
        Thu, 28 Sep 2023 04:47:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A614C433CA;
        Thu, 28 Sep 2023 11:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695901673;
        bh=6ffAfHbytTsNdmlLHrNIA44Bup6fwjTt6W3tUOSKgaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W0EO8zyEEW16H9lVMy+eOLO1IpcUt8T0MpdJd+U3pcuk7m0R9vkMlKY8X01X8bKHU
         Toy5XwhNroQ8LgAL8j747cDs1DP8jGOp8IUWu8qHRXEMMUAn2jdh/TYsQyRvm5DHJm
         q0f5Ncca2ea7Zn0agtzxM4Va7hJ8l1GmI8lx+HeaR3Z5jdtf4wD2G0QcXBYz9N5BQA
         IIU/AyqVTcxbOIaqJun/7pi6NcBgISORIFMd/KT0g4fGnr6u3XKEx7tCvY0H9vTeI7
         X2SftrXWQQskrkbxKHnAuc7WkD67Ku3d9+ERhO7GUIo1cJbKsTxxHSGf5crM+va5dx
         IoiI6ub7al7yA==
Date:   Thu, 28 Sep 2023 07:47:52 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6.4, 6.5] ASoC: cs35l56: Disable low-power hibernation
 mode
Message-ID: <ZRVn6B6kFnuyjAcM@sashalap>
References: <20230925151443.28956-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230925151443.28956-1-rf@opensource.cirrus.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 04:14:43PM +0100, Richard Fitzgerald wrote:
>commit 18789be8e0d9fbb78b2290dcf93f500726ed19f0 upstream.
>Please apply to 6.4 and 6.5.
>
>Do not allow the CS35L56 to be put into its lowest power
>"hibernation" mode. This only affects I2C because "hibernation"
>is already disabled on SPI and SoundWire.
>
>Recent firmwares need a different wake-up sequence. Until
>that sequence has been specified, the chip "hibernation" mode
>must be disabled otherwise it can intermittently fail to wake.
>
>Backport note: This is the same change as upstream commit, to delete
>one line, but the upstream commit would not apply cleanly on older
>branches because of minor differences to the surrounding code.

Queued up for 6.5. 6.4 is EOL.

-- 
Thanks,
Sasha
