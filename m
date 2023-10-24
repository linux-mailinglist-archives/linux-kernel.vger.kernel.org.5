Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954C07D49D9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 10:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbjJXIU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 04:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbjJXIUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 04:20:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC66D7E
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 01:20:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C42BCC433C9;
        Tue, 24 Oct 2023 08:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698135622;
        bh=fhZWBcd8MPqGRAu4Llwdr124i7u6xR3+iaR9nSkzKhs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aI2aSFOYgTu6Q3sgv1bH7lMa1jc+Bluf942vf2+y1fOfTueZP/7dfRhK5ZARsaoLz
         Wv5kmDLN6cbEUHr8kpr3tvGNBqYBPGHFgv319OAgwVLWcAS6PFkZq6Z+8UQagTANyU
         549N1h6SE9RUNeAPsvhUcKHy936x+KnHF8tdUgRfgMb/QjfTmGjesRHBYYPHRSNk/j
         tSmXa+KP6hebDjw3nKEuqDoz1pHo/E3GjyTLD9jyicPGTkZUqISUyO/r38RZinZwS4
         x0MBf6kH52cHg/WSIjhWQT7PuRXOxJPTE6sDQX5FbJ2jYDCtjqnYczTrLoXdhksm10
         39CtCPiLPlg1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ABB5EC595C3;
        Tue, 24 Oct 2023 08:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net-next] net: microchip: lan743x: improve throughput with
 rx timestamp config
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169813562269.30900.16324458745146490166.git-patchwork-notify@kernel.org>
Date:   Tue, 24 Oct 2023 08:20:22 +0000
References: <20231020185801.25649-1-vishvambarpanth.s@microchip.com>
In-Reply-To: <20231020185801.25649-1-vishvambarpanth.s@microchip.com>
To:     Vishvambar Panth S <vishvambarpanth.s@microchip.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jacob.e.keller@intel.com, kuba@kernel.org,
        bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        richardcochran@gmail.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 21 Oct 2023 00:28:01 +0530 you wrote:
> Currently all RX frames are timestamped which results in a performance
> penalty when timestamping is not needed.  The default is now being
> changed to not timestamp any Rx frames (HWTSTAMP_FILTER_NONE), but
> support has been added to allow changing the desired RX timestamping
> mode (HWTSTAMP_FILTER_ALL -  which was the previous setting and
> HWTSTAMP_FILTER_PTP_V2_EVENT are now supported) using
> SIOCSHWTSTAMP. All settings were tested using the hwstamp_ctl application.
> It is also noted that ptp4l, when started, preconfigures the device to
> timestamp using HWTSTAMP_FILTER_PTP_V2_EVENT, so this driver continues
> to work properly "out of the box".
> 
> [...]

Here is the summary with links:
  - [v3,net-next] net: microchip: lan743x: improve throughput with rx timestamp config
    https://git.kernel.org/netdev/net-next/c/169e0a5e4320

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


