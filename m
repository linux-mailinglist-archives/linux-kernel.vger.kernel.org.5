Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A035C789FAD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjH0NyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 09:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbjH0Nxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 09:53:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C24DCE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 06:53:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8ECB61DDF
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 13:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13B4C433C8;
        Sun, 27 Aug 2023 13:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693144426;
        bh=b1kK7Dz94GVdmWTD3uMOP5lr20LHYQ/HNK30s5G1xWQ=;
        h=From:To:Cc:Subject:Date:From;
        b=J7iqqsoca1RQhX0MDlxFMt+CDy/1lz+AquUHzDkG8IjDA7/IUiQ+dLIRLojeSJLQn
         ol+t6JDZCxG/qv2FmBSgvEFb63SnAfBzz0wkbBB8/xQbWAJOdM8AmlIAvkhaJY0DiB
         wectLoOwvHfQv7+WW7JdtXe2359iT/u7akjCo5OuyokykABNFRZ7sTL5VvE7rkKbPx
         W3G8onw2trcD1gIKfUlIRoEJBmnDSY9RmCdjjbhz/EwMX29Jc9G9hOOpFaczq8EwRC
         3Cf1UGifzwWeurywMHocRK7zWD8i0mQJRGAhg0NzYLUgcTE2RPyHTr/zLiPdu4l4SF
         TJn9NFL2l6+7Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: stmmac: dwmac-starfive: some improvements
Date:   Sun, 27 Aug 2023 21:41:48 +0800
Message-Id: <20230827134150.2918-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is to improve the dwmac-starfive driver by correcting
error handling and removing unnecessary clk_get_rate().

Jisheng Zhang (2):
  net: stmmac: dwmac-starfive: improve error handling during probe
  net: stmmac: dwmac-starfive: remove unnecessary clk_get_rate()

 .../ethernet/stmicro/stmmac/dwmac-starfive.c  | 38 +++++++++++--------
 1 file changed, 22 insertions(+), 16 deletions(-)

-- 
2.40.1

