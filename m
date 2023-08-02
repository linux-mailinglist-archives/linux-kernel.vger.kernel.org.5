Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBBE76D702
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230425AbjHBSnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbjHBSn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:43:26 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0759211D;
        Wed,  2 Aug 2023 11:43:25 -0700 (PDT)
Received: from dslb-094-219-037-101.094.219.pools.vodafone-ip.de ([94.219.37.101] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qRGoa-0003Eh-0f; Wed, 02 Aug 2023 20:43:20 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Arnd Bergmann <arnd@arndb.de>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>, linux-imx@nxp.com,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v7 0/2] ARM: imx25: print silicon revision at startup
Date:   Wed,  2 Aug 2023 20:40:44 +0200
Message-Id: <20230802184046.153394-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resurrect the unused function to print the imx25 silicon revision at
startup.

This patch set is blocking Arnd's work on enabling -Werror=missing-prototypes.

Arnd, could you pick up these patches in your tree as suggested by Stephen?

Thanks,
Martin

changes in v7:
- rebase against today's linux-next
- add Acked-by from Stephen

changes in v6:
- rebase against today's linux-next
- add Acked-by from Arnd

changes in v5:
- rebase against today's linux-next

changes in v4:
- rebase against today's linux-next
- add Fabio's Reviewed-by tags

changes in v3:
- rebase against today's linux-next

changes in v2:
- drop the patch about silicon revision 1.2. It has already been merged
  by Shawn Guo.
- send the changeset to the clk maintainers

Martin Kaiser (2):
  clk: imx25: print silicon revision during init
  clk: imx25: make __mx25_clocks_init return void

 drivers/clk/imx/clk-imx25.c | 5 +++--
 include/soc/imx/revision.h  | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.39.2

