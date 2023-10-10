Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222347C0397
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343677AbjJJSkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 14:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbjJJSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 14:40:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31501A4;
        Tue, 10 Oct 2023 11:40:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9BF9C433CB;
        Tue, 10 Oct 2023 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696963230;
        bh=CHTihTsh83P6ppRFVWKOznhUqoWSsjQRr/tE+7WoRi0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hKNjpySKSrSvc/2F1eL5eVBFeO1dkGH6aU/rfEH6SeGt9I8BrheR8Z4PwIf9jre7M
         wVp1ZGkWG5GLza0JI2LF9L3oydlBuoWHJ6lv44JffC/ixA9Z3XcV7+LU7AxfTCYBrG
         R7LifHd2c56GRei4YIDvPS6QaxpHN0006SGnxtzUdEMzlCFmEhbCTlVNtb9QRgDbuX
         lD6juUXTCJTITTfaOh4O+Y5Lk8DJE38cwN0djzpuW1Af3qe7NGsCbqf+jbtOOE46LS
         ewUH1DxOvGZrVl5JCKZr7r0empuHG2d5rs65C7p6jLwhsYpK+K2BEyAAL4trkihFGt
         kNRFdYXVLbH+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE868C595CE;
        Tue, 10 Oct 2023 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [v2] Bluetooth: avoid memcmp() out of bounds warning
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169696323071.22645.17463757124543443632.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Oct 2023 18:40:30 +0000
References: <20231009203137.3125516-1-arnd@kernel.org>
In-Reply-To: <20231009203137.3125516-1-arnd@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        jlee@suse.com, arnd@arndb.de, keescook@chromium.org,
        luiz.von.dentz@intel.com, stable@vger.kernel.org,
        iulia.tanasescu@nxp.com, pav@iki.fi, kuba@kernel.org,
        claudia.rosu@nxp.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Oct 2023 22:31:31 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> bacmp() is a wrapper around memcpy(), which contain compile-time
> checks for buffer overflow. Since the hci_conn_request_evt() also calls
> bt_dev_dbg() with an implicit NULL pointer check, the compiler is now
> aware of a case where 'hdev' is NULL and treats this as meaning that
> zero bytes are available:
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: avoid memcmp() out of bounds warning
    https://git.kernel.org/bluetooth/bluetooth-next/c/b8ba8e65e84b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


