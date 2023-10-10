Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366777BF86C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 12:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjJJKU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 06:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbjJJKU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 06:20:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7CE94;
        Tue, 10 Oct 2023 03:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 352B2C433C7;
        Tue, 10 Oct 2023 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696933225;
        bh=UIzJx9EmdbrSr5WpmaFcMaGe/RDVjYRXUMS2tzKKXmY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HSwSQWITufInYmmSKAke1aptuLT9IKtBaJqTbLmntC7oDswHXF4OgQPyYJtnSNrEK
         1q4Ky4z6l6QGO3MR+NeyfrPd4r2OieTlf/lQv+urTUPeTCuX4Zo/AXYTCCTpSd06gQ
         10Wzdgs+NoDQn8aX5NSB8w+qrWLcs1UGPRTgO0e0j3UxDCOUC+7LaSmhz9RYypKmgT
         TZYYmZUHjHgjIcST6dpkk8ibmKx7XerZUmbxkCvmsH3xHAi5puey68vCnWXBl8+I5e
         Cznm8AfPzV7VCPaJFpOHGX3TmnzPWw0wWiiO6sZwo52WDGs6HoNkyxSK1blpg3jmlg
         shKpR/hB6VMEQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D1FCE0009E;
        Tue, 10 Oct 2023 10:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: Fix dependency of SMC on ISM
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <169693322510.26630.14172040587036609321.git-patchwork-notify@kernel.org>
Date:   Tue, 10 Oct 2023 10:20:25 +0000
References: <20231006125847.1517840-1-gbayer@linux.ibm.com>
In-Reply-To: <20231006125847.1517840-1-gbayer@linux.ibm.com>
To:     Gerd Bayer <gbayer@linux.ibm.com>
Cc:     rdunlap@infradead.org, wenjia@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        netdev@vger.kernel.org, raspl@linux.ibm.com, sfr@canb.auug.org.au,
        alibuda@linux.alibaba.com, wintera@linux.ibm.com,
        guwen@linux.alibaba.com, tonylu@linux.alibaba.com,
        jaka@linux.ibm.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Oct 2023 14:58:47 +0200 you wrote:
> When the SMC protocol is built into the kernel proper while ISM is
> configured to be built as module, linking the kernel fails due to
> unresolved dependencies out of net/smc/smc_ism.o to
> ism_get_smcd_ops, ism_register_client, and ism_unregister_client
> as reported via the linux-next test automation (see link).
> This however is a bug introduced a while ago.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: Fix dependency of SMC on ISM
    https://git.kernel.org/netdev/net/c/a72178cfe855

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


