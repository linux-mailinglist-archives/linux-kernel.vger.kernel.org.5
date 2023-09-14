Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E78707A0EF9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjINUbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjINUbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:31:15 -0400
Received: from smtp.smtpout.orange.fr (smtp-16.smtpout.orange.fr [80.12.242.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88732698
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:31:11 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id gszUqMvFz7mcCgszUqSuhP; Thu, 14 Sep 2023 22:31:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694723469;
        bh=Sb61MGbLqsf+CsIMkkDke3Cvm/shDI295oG39gW+CtY=;
        h=From:To:Cc:Subject:Date;
        b=UwON7NmSvg7mtEanY+4I6YQv7qqLAI1G+Uy0/Q/THiamTR7s3nbj+HcQ0M5V17DqS
         nZ+75/D30Rq03k2eDlNrK90bw2b8OGG7I9a/35Ot4rVad6FwXxNe1dVlquOZmdF/vP
         FaSPjlLYiceEv/qdn/Etd8FnJHWXpSarWzW8X8ov+QDxcu0Ach0bkowQ4juoDGzRi1
         SLZHcYvX+PbIw3QZNIWD2CMaLeMbZWrU3g4cDzDCsVzalCU8Vh1o4LfmjRxcW+qQzI
         aHz+so4vGspS4P7bO9ENAqtd5zMYLgm8MdoZR18KZQSrtmWX6rtc2y6crgaPkDRTKk
         t79GaoGvxY6JQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Sep 2023 22:31:09 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@nxp.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 0/5] clk: imx: imx8: Fix some error handling paths
Date:   Thu, 14 Sep 2023 22:31:01 +0200
Message-Id: <cover.1694722339.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie fix some error handling paths. It is split in different patches to
ease review because the issues are unrelated and the proposed fixes are maybe
wrong (I don't have the hardware to test anything)

Some of v1 patches had been incorrectly hand modified. There was a extra ')' in
patch 3 and 4 that prevented the merge.

This v2 is a cleanly regenarated serie, compile tested at each step. This
time, git format-patch did all the work and the patches have NOT been hand
modified afterwards.


Some log messages have also been slightly tweaked.
R-b tags have been added.

v1: https://lore.kernel.org/all/cover.1693126687.git.christophe.jaillet@wanadoo.fr/

Christophe JAILLET (5):
  clk: imx: imx8: Fix an error handling path in
    clk_imx_acm_attach_pm_domains()
  clk: imx: imx8: Fix an error handling path if
    devm_clk_hw_register_mux_parent_data_table() fails
  clk: imx: imx8: Fix an error handling path in imx8_acm_clk_probe()
  clk: imx: imx8: Add a message in case of
    devm_clk_hw_register_mux_parent_data_table() error
  clk: imx: imx8: Simplify clk_imx_acm_detach_pm_domains()

 drivers/clk/imx/clk-imx8-acm.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

-- 
2.34.1

