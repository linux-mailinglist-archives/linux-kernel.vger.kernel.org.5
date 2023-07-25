Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645CC760947
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjGYFaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjGYFaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:30:24 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFB2E4D;
        Mon, 24 Jul 2023 22:30:23 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 267F41A15D0;
        Tue, 25 Jul 2023 07:30:22 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E01141A15C0;
        Tue, 25 Jul 2023 07:30:21 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DE30B1800319;
        Tue, 25 Jul 2023 13:30:19 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, shengjiu.wang@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/2] clk: imx: add audio clock mux driver
Date:   Tue, 25 Jul 2023 12:56:22 +0800
Message-Id: <1690260984-25744-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Audio Clock Mux (ACM) is a collection of control registers
and multiplexers that are used to route the audio source clocks
to the audio peripherals on i.MX8QXP, i.MX8QM, i.MX8DXL

Shengjiu Wang (2):
  dt-bindings: clock: fsl,imx8-acm: Add audio clock mux support
  clk: imx: imx8: add audio clock mux driver

 .../bindings/clock/fsl,imx8-acm.yaml          | 282 +++++++++++
 drivers/clk/imx/Makefile                      |   3 +-
 drivers/clk/imx/clk-imx8-acm.c                | 476 ++++++++++++++++++
 include/dt-bindings/clock/imx8-clock.h        |  28 ++
 4 files changed, 788 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imx8-acm.yaml
 create mode 100644 drivers/clk/imx/clk-imx8-acm.c

-- 
2.34.1

