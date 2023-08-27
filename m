Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EF5789CB0
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 11:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbjH0JiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 05:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjH0JiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 05:38:07 -0400
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6406F9
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 02:38:04 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id aCDYqs7H09KIfaCDYq3nVP; Sun, 27 Aug 2023 11:38:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1693129082;
        bh=eq0x3iigUAjoi4D0w91pgHaAwqeD7R2OBa1kT6pnQ2g=;
        h=From:To:Cc:Subject:Date;
        b=fPSJLpblS3Yu70HOrJviqaDMJByLb2CaOFA7ikx3WuTq//wD9+qnKhz82HFJn0p3q
         cRH42ggURSGiJFgCPN3cHzub8twAQf0PSwJJV0IdtCArAztC+PcxucbuqHGVxx8XeV
         cgS6ucw9aBDokf0CAqj444HQfdPYsUUYV77qg8OnjZ55cOOX2bCltPzLpfvtFFTC8m
         toq+Dgm/p/ZLl+uESmRH0LHFFkfPzDDgexDJoz3t8tDtfr8hVNuF7xXlSudcOSJz8F
         Qi8/OnpRKJfbjzoV3NSLloOqQUbvOiMrOn4Hoyynn4gtCNkn2x+9sFE6RnpM02mvGL
         0zByFg+24Tumg==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 27 Aug 2023 11:38:02 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        shengjiu.wang@nxp.com
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 0/5] clk: imx: imx8: Fix some error handling paths
Date:   Sun, 27 Aug 2023 11:37:51 +0200
Message-Id: <cover.1693126687.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie fix some error handling paths. It is split in different patches to
ease review because the issues are unrelated and the proposed fixes are maybe
wrong (I don't have the hardware to test anything)

Patch 2 and 3 are more speculative than the 3 oher ones. Review with care.


Finally, I got some problem when generating the serie, and some patches have
been hand-modified afterwards.
They look good to me, but I hope have not screwed up things...

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

