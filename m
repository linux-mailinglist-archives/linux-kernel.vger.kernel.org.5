Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE545757839
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:40:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjGRJkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjGRJkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E28CCF;
        Tue, 18 Jul 2023 02:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7D3C614E7;
        Tue, 18 Jul 2023 09:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 20170C433C7;
        Tue, 18 Jul 2023 09:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689673221;
        bh=x05fxWji0pGy8d80G1xA5AXaI6ePVQmTbAx17r27qCk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=COeDB4+RzjXFjkSkV124rZEEyKBXhQloqdxJppljtAVFtL7skppLesz2tOT775d1L
         IU+/jdLnB0Pf5vmnRsLzm3G9oxNYsYE84SIazt/Ol5wnIhJzK5Y5z3H8QOeGpZ6ydd
         p6V/w6anFK5m2ZNt95lQenyFPhtJDysKIZRgdzGn0MS+shRXuJOCTz4UrjNaueqdz3
         mKzlP31E5DOZKJ8wofAVXOmxgS+zl/y3jZ7me+LXe8Rr7ZyYQqi4hrS7DdX4mdgd2f
         jTCcjQuuXzf5EwEtAmeayqjHTi1NHC6+WtFwKcY3JR89yzpeB0eJTt9HV2SKQ0NlAM
         IQ/DvD6lb6qyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08297C64458;
        Tue, 18 Jul 2023 09:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ptp: Explicitly include correct DT includes
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168967322103.6242.11585020932076868614.git-patchwork-notify@kernel.org>
Date:   Tue, 18 Jul 2023 09:40:21 +0000
References: <20230714174922.4063153-1-robh@kernel.org>
In-Reply-To: <20230714174922.4063153-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     richardcochran@gmail.com, yangbo.lu@nxp.com,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Jul 2023 11:49:22 -0600 you wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> [...]

Here is the summary with links:
  - ptp: Explicitly include correct DT includes
    https://git.kernel.org/netdev/net-next/c/9ffc4de5c695

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


