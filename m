Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82D77331C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjHGWua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjHGWuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFA0101;
        Mon,  7 Aug 2023 15:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E666B622E8;
        Mon,  7 Aug 2023 22:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50B39C433CB;
        Mon,  7 Aug 2023 22:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691448622;
        bh=p7FlQ1wsuFCbLmkzvILOoJTYAZLXhkyWPIPyOat3lFc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VaFdVtmePbkRWMwjfJwr8MFqCVNlE0AZYdrNfRNhggPvrienhrNSNyYmYtUKv7O2w
         5eVhUtoyrYKm5mOLVI/EtrcIVGh7nPfXpbO4AzqjrUygqZiqeE8qkNxad988zWCqW/
         X4nBZC6YKpEaIlnL9nsFfxTQltW9CGQjdmnyvuNNRO6RirbMVydZKDGGCq5k4kG8az
         LS0HLAJsFLygt69XQQGm261HOhMfS0bwTVlO9e1Ophu7hGVwEtmNZDHd+bsImuGInK
         U92rBKOaJ3owA1LpTA2SrCTjsH6KzRKIe64KJXwh95YJGXSlHAAKQplIbl//1C9gwl
         2TlKYqjzpwKfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35433E270C3;
        Mon,  7 Aug 2023 22:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Avoid use-after-free in dbg for
 hci_add_adv_monitor()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169144862221.1999.14693714879405886120.git-patchwork-notify@kernel.org>
Date:   Mon, 07 Aug 2023 22:50:22 +0000
References: <20230804111444.1.I43aa4bd799a3cf9102f9de8c365ccb3d8e53a9d1@changeid>
In-Reply-To: <20230804111444.1.I43aa4bd799a3cf9102f9de8c365ccb3d8e53a9d1@changeid>
To:     Manish Mandlik <mmandlik@google.com>
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com,
        chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org, johan.hedberg@gmail.com,
        mcchou@google.com, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  4 Aug 2023 11:14:45 -0700 you wrote:
> KSAN reports use-after-free in hci_add_adv_monitor().
> 
> While adding an adv monitor,
>     hci_add_adv_monitor() calls ->
>     msft_add_monitor_pattern() calls ->
>     msft_add_monitor_sync() calls ->
>     msft_le_monitor_advertisement_cb() calls in an error case ->
>     hci_free_adv_monitor() which frees the *moniter.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_add_adv_monitor()
    https://git.kernel.org/bluetooth/bluetooth-next/c/34d241ece878

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


