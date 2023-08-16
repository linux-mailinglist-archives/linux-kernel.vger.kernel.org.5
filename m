Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AEE77D6EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240778AbjHPAKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 20:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240738AbjHPAKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 20:10:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FF81FFF;
        Tue, 15 Aug 2023 17:10:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8D8761FA9;
        Wed, 16 Aug 2023 00:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2585DC433CB;
        Wed, 16 Aug 2023 00:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692144628;
        bh=UzRG+CQVssLOHatEPLJFcKCmsdv2k0OF1x2BnySiUas=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=g2qiu0GtnCoKcz3vi6q+6uTYMOGb7jmqCRIxmrIf6r+rkWxW3HtIVIqqSMP4nxLbv
         npzgnPFD4yE/icBzluk/spMaURxH8N/nt+Q9M3DckmntCKv+Adxggc6sDBQVYU0GmK
         XaDfcEUXgQaqWEZ6oQ+BRE7Q005ckKxqxS6GbP+UyNX9C1hIbfnMd/+EGkGPSJxX4F
         0HDHqg28dSqDHplh9FjUr/ndzqKJLhxziOLXkT9ggdac06RlXyG75IjhTj5AIVl37k
         zWdQsuQqzcmdCVu1w0feIhRqgnj10PqZzaUQCYDbqd5PuPGyR5w0GJVCZVx0uFyGjF
         QR4MN5t+nNllA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 005F9C395C5;
        Wed, 16 Aug 2023 00:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btnxpuart: Improve inband Independent Reset
 handling
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169214462799.26309.4529557002572252958.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Aug 2023 00:10:27 +0000
References: <20230810135509.835889-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20230810135509.835889-1-neeraj.sanjaykale@nxp.com>
To:     Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 10 Aug 2023 19:25:09 +0530 you wrote:
> This improves the inband IR command handling for NXP BT chipsets.
> When the IR vendor command is received, the driver injects a HW
> error event, which causes a reset sequence in hci_error_reset().
> The vendor IR command is sent to the controller while hci dev
> is been closed, and FW is re-downloaded when nxp_setup() is
> called during hci_dev_do_open().
> The HCI_SETUP flag is set in nxp_hw_err() to make sure that
> nxp_setup() is been called during hci_dev_do_open().
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btnxpuart: Improve inband Independent Reset handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/db4d87d4a68e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


