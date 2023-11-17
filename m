Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566EF7EF278
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345764AbjKQMSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjKQMSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:18:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491B5120
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:18:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6FBC433C8;
        Fri, 17 Nov 2023 12:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700223482;
        bh=HpoiobYK4SHESYSPd2bYVUp4GAKtfq8ebm87To2wZ7s=;
        h=From:To:Cc:Subject:Date:From;
        b=MNEXft1GJ6TUQIkUL85urPe/TCGb3B9a+mrpGwYM0hhI+hnVW2KKV869AYSOJsLFz
         ERT/75Dty3g99oCMgPSaFp7bVOUr6qIwV84VRwQVYMkPFZ/bJAifuXFnYjWVP8yy4P
         EHaI+QNigecekIore5t+YhVacTv+bjvxTlVeJfH5aY57DzdRzBgc4Wk0bTZAt9Qu8v
         ganpBOKmbczHNr0Xfu1ycBRd/z749u4Nl/qXo4eJzO37pYXgvFP6Ht1EngT3M2c2nH
         8st6V0AG8aOUCtKxa4JPe19gVaQU5vZcJl30HAePMpmfpZzqFpXd4sf7X68hYrpTEy
         Obk1tqbgGWjOA==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, andrew@lunn.ch,
        u.kleine-koenig@pengutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 net-next 0/4] net: eth: am65-cpsw: add ethtool MAC stats
Date:   Fri, 17 Nov 2023 14:17:51 +0200
Message-Id: <20231117121755.104547-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Gets 'ethtool -S eth0 --groups eth-mac' command to work.

Also set default TX channels to maximum available and does
cleanup in am65_cpsw_nuss_common_open() error path.

Changelog:
v2:
- add __iomem to *stats, to prevent sparse warning
- clean up RX descriptors and free up SKB in error handling of
  am65_cpsw_nuss_common_open()
- Re-arrange some funcitons to avoid forward declaration

cheers,
-roger

Roger Quadros (4):
  net: ethernet: am65-cpsw: Add standard Ethernet MAC stats to ethtool
  net: ethernet: ti: am65-cpsw: Re-arrange functions to avoid forward
    declaration
  net: ethernet: am65-cpsw: Set default TX channels to maximum
  net: ethernet: ti: am65-cpsw: Fix error handling in
    am65_cpsw_nuss_common_open()

base-commit: 18de1e517ed37ebaf33e771e46faf052e966e163
-- 
2.34.1

