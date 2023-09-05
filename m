Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780E87931F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 00:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244842AbjIEW1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 18:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241297AbjIEW11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:27:27 -0400
X-Greylist: delayed 572 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 Sep 2023 15:27:24 PDT
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827EDFA;
        Tue,  5 Sep 2023 15:27:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438B2C433C7;
        Tue,  5 Sep 2023 22:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693952272;
        bh=DcG21snNFyOVFmUjVeQMmqfuI7YGTtdIqztcMnQ8FLc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KzRcV+pAxZ8NCPUBKQajPqDs6tidKIroLfgQ3jH8uloPSj9pGyJz3p9Nkj7grMbDs
         X2ajTC9PETXAbJvZ1USCuaFdjv4Tp59qdD7+fhKAjXVNYqtTxAHpcOpVjDsnni/3fM
         PdIPnl6pvSXw8PhRGJPNv37EI9kb01qSI1tBhUSuTcxIzcE8V/rw2xKcs4/uRiM7a+
         QTh2mPKSV+2JEMJZcoA/CzM4on7HgKitmbLyPfnAkCxTt1D/FEFfbHepACbUONscja
         bac+64crGPPY/h6E4sfihvWGOrYquepL57jtdnu5iLA2jHWL66RiCo5PkjJTNE5FK3
         lb689mfN2BkuA==
Date:   Tue, 5 Sep 2023 15:17:51 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Remi Pommarel <repk@triplefau.lt>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: remove unneeded stmmac_poll_controller
Message-ID: <20230905151751.1b2148ad@kernel.org>
In-Reply-To: <20230831120004.6919-1-repk@triplefau.lt>
References: <20230831120004.6919-1-repk@triplefau.lt>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 14:00:04 +0200 Remi Pommarel wrote:
> Using netconsole netpoll_poll_dev could be called from interrupt
> context, thus using disable_irq() would cause the following kernel
> warning with CONFIG_DEBUG_ATOMIC_SLEEP enabled:

Could you rebase this on top of netdev/net? It does not apply:

Failed to apply patch:
Applying: net: stmmac: remove unneeded stmmac_poll_controller
Using index info to reconstruct a base tree...
M	drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
CONFLICT (content): Merge conflict in drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
Recorded preimage for 'drivers/net/ethernet/stmicro/stmmac/stmmac_main.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Patch failed at 0001 net: stmmac: remove unneeded stmmac_poll_controller
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
