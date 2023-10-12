Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604717C61BF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 02:30:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376709AbjJLAaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 20:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376605AbjJLAa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 20:30:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DE09E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 17:30:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E336CC433BB;
        Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697070625;
        bh=AzVrrHVklFUccuLIjTp5qmMV/tSS4X6XU+ztCS5Do7c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SCU2LKzfYUSgKighWFhEI8EFMOhzeHhGI7MUtiSvFrPf4FZ3vgu291CZT04n7HRWf
         e+hzAo6lyKGJvCxJ91TrxamOwVzkWfe4TlyUjZUcdwX41jCWhRoQtrkIcyeiilNGkI
         MtDs8jTRiJrOlsT5zD1+9uj/ACeKj38eeqTZMnpR1R98Gmmexc/BALUThqylxgbNcp
         HCL24Ts2N5Jl0V67fwoi+kxHJ3Fx6qC/9GcjhmQLOjq0uBdU6pecbrq/V6YrtWP3WN
         BmipSjiMzzvR7dWVeCQfzqHhbNZw2CQP28oC30oZBCL1lrtjCGKz/JIw4yjzK2yvKr
         xyRNHUp7YRZ1g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE2D4C595C4;
        Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] bna: replace deprecated strncpy with strscpy_pad
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169707062583.15864.12964276250565001495.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 00:30:25 +0000
References: <20231009-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-v2-1-78e0f47985d3@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-ethernet-brocade-bna-bfa_ioc-c-v2-1-78e0f47985d3@google.com>
To:     Justin Stitt <justinstitt@google.com>
Cc:     rmody@marvell.com, skalluru@marvell.com,
        GR-Linux-NIC-Dev@marvell.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Oct 2023 17:45:33 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> bfa_ioc_get_adapter_manufacturer() simply copies a string literal into
> `manufacturer`.
> 
> [...]

Here is the summary with links:
  - [v2] bna: replace deprecated strncpy with strscpy_pad
    https://git.kernel.org/netdev/net-next/c/460c81da66f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


