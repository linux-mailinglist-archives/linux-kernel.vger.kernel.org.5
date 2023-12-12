Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E96F180FB47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378030AbjLLXXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378021AbjLLXXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:23:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12429B0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:23:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B611C433C7;
        Tue, 12 Dec 2023 23:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702423428;
        bh=KwRraPl+S6WmazlLNqOJ7U472XTL+/fDGulYB+j/FLk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BtEAI2K97P4K3o2dTr9wLUIpp5Fd7FshRQzuKgCImTlqG7pISseimEd/dyIWmN3qp
         SnyunpjfhBl978TWs57HDJf0wyhZzAXq8wqNdH077Mn7Xggx602NtRwtwQy/zJg4DY
         eFaW0MNfUc/KBzIzvV4qCGdQeYvtdlDWKLEYQbOvCFtkE8FvTYRWI4JzkmatZ+FFsl
         JUxq1BBpkAz2IY5Mm1txEtBKcnbRe0TxQ3IwK7wCBdBw98vmA2k14p47ymK2nXSegA
         wVMaU8WlhtppPwey/4s66Hh46QeWbd1UMIBFEBEoID0J2h0e7346dii8RGNyhib6WQ
         EX5BxvpaWIdDw==
Date:   Tue, 12 Dec 2023 15:23:47 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        James Li <James.Li1@synopsys.com>,
        Martin McKenny <Martin.McKenny@synopsys.com>,
        "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 net-next] net: stmmac: xgmac3+: add FPE handshaking
 support
Message-ID: <20231212152347.167007f3@kernel.org>
In-Reply-To: <CY5PR12MB63727C24923AE855CFF0D425BF8EA@CY5PR12MB6372.namprd12.prod.outlook.com>
References: <CY5PR12MB63727C24923AE855CFF0D425BF8EA@CY5PR12MB6372.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2023 14:05:02 +0000 Jianheng Zhang wrote:
> Adds the HW specific support for Frame Preemption handshaking on XGMAC3+
> cores.
> 
> Signed-off-by: Jianheng Zhang <Jianheng.Zhang@synopsys.com>

I defer to Vladimir on whether to trust that the follow up with
the ethtool API support will come later (and not require rewrite
of existing code); or we should request that it's part of the same
series.
-- 
pw-bot: needs-ack
