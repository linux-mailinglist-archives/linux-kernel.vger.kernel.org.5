Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE4F7709A9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjHDUYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjHDUYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:24:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0E94C2D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:24:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42B5F61CB6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:24:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F6CC433C8;
        Fri,  4 Aug 2023 20:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691180645;
        bh=MN8Ir5pH3svELvRVWkYhOhFDhYH6jPowbfYlT+skAZU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z+rNfBjRljT7BMNl9BeMpg8gSzG3afyNJqmBduhCOJwxMpuy34xi6jV8JJMzBm9LU
         R0ipkW8j6NebYUUIKABm+F/z6K0oen0SxgruY7Ggn1D/WcCxxk8qoywCH8ohaFAdJ+
         UfW/osKhfAAvFuX29JvqaaPXfDXbyDbc+hMdXiQ/SbEsKHnFNNtHtJrbtR5aGShTxK
         0GjSFGj3zrZGbh2tyQWFITLE+BziTFWKWpmTYNPeSmX275VbB7yOaCueqqXmFEv5F9
         Tp8tbkuX7WkILnMpu3iDdkIY5f1A8RLOPIH9wbhU5FBT5O3/yFRFWlH4ukVsMx/uIi
         NjJLtQ7lN6RSg==
Date:   Fri, 4 Aug 2023 13:24:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Richard Cochran <richardcochran@gmail.com>
Cc:     Johannes Zink <j.zink@pengutronix.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Kurt Kanzenbach <kurt@linutronix.de>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v3 0/2] net: stmmac: correct MAC propagation delay
Message-ID: <20230804132403.4d9209de@kernel.org>
In-Reply-To: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
References: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Aug 2023 17:44:28 +0200 Johannes Zink wrote:
> ---

Richard? Sure would be nice to have an official ack from you on this
one so I don't have to revert it again ;)
