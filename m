Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251D775128C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbjGLVU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjGLVUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9EE1FD2;
        Wed, 12 Jul 2023 14:20:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89C7761948;
        Wed, 12 Jul 2023 21:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA043C433C9;
        Wed, 12 Jul 2023 21:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689196824;
        bh=XzpCV7L+ggi2pYIN4/kiBvQmtWkPa45z6Dp7ndAAo+k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=G4jiPgBvxdyFZPGbgupHO3CJPAduRRUe09GOZGO7Fh/T6AoOvp6uF3ZYViA/iTS/9
         g8on4Y9rkrwubaNg7bWV2oYZRI1D1w5LHmK1F7mH9EKAG+fuMS5HbRn7rGHb2MehDv
         wAMcbMgcMblApF1B4nOVxcJ7hLPYESL8os7Ub1XdwtYHKFBXRHB/FeY/1gI6NzHf5n
         coRm/n/ucNVEIwGu4Rtdm5LD2/P4R87y0w/UAdiHLLJ/iE+/LS91u219tneE1pUsZf
         RRZUsSUZ18cjbk/nAjUX/x7LI32QLUmmCCiLOxP7QoHoeXAqrArcnB2eQn8Lo/XW8q
         WJ+aXHrsmI33Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE88AC04E32;
        Wed, 12 Jul 2023 21:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in
 HCIUARTGETPROTO
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168919682384.17000.13075790266021679958.git-patchwork-notify@kernel.org>
Date:   Wed, 12 Jul 2023 21:20:23 +0000
References: <20230710151723.15617-1-jlee@suse.com>
In-Reply-To: <20230710151723.15617-1-jlee@suse.com>
To:     Lee@ci.codeaurora.org, Chun-Yi <joeyli.kernel@gmail.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        yhao016@ucr.edu, jlee@suse.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 10 Jul 2023 23:17:23 +0800 you wrote:
> This patch adds code to check HCI_UART_PROTO_READY flag before
> accessing hci_uart->proto. It fixs the race condition in
> hci_uart_tty_ioctl() between HCIUARTSETPROTO and HCIUARTGETPROTO.
> This issue bug found by Yu Hao and Weiteng Chen:
> 
> BUG: general protection fault in hci_uart_tty_ioctl [1]
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_ldisc: check HCI_UART_PROTO_READY flag in HCIUARTGETPROTO
    https://git.kernel.org/bluetooth/bluetooth-next/c/ff1b86784849

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


