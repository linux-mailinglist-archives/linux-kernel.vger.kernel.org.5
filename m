Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D46792ADF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344174AbjIEQoE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 5 Sep 2023 12:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354529AbjIEMVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:21:17 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EB61A8;
        Tue,  5 Sep 2023 05:21:10 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id C322324E284;
        Tue,  5 Sep 2023 20:21:06 +0800 (CST)
Received: from EXMBX172.cuchost.com (172.16.6.92) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 5 Sep
 2023 20:21:06 +0800
Received: from ubuntu.localdomain (113.72.144.73) by EXMBX172.cuchost.com
 (172.16.6.92) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 5 Sep
 2023 20:21:05 +0800
From:   Hal Feng <hal.feng@starfivetech.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Andreas Schwab <schwab@suse.de>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] Fix an irq issue and add system pm ops for StarFive JH7110 pinctrl drivers
Date:   Tue, 5 Sep 2023 20:21:03 +0800
Message-ID: <20230905122105.117000-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.73]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX172.cuchost.com
 (172.16.6.92)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes some issues arising when CONFIG_PM is enabled
or suspending to disk.

The first patch fixes failure to set irq after CONFIG_PM is enabled.

The second patch adds system pm ops to save and restore context. So it can
ensure that the pins configuration keep consistent with the one before
suspending.

Hal Feng (2):
  pinctrl: starfive: jh7110: Fix failure to set irq after CONFIG_PM is
    enabled
  pinctrl: starfive: jh7110: Add system pm ops to save and restore
    context

 MAINTAINERS                                   |  1 +
 .../starfive/pinctrl-starfive-jh7110-aon.c    |  4 ++
 .../starfive/pinctrl-starfive-jh7110-sys.c    |  4 ++
 .../starfive/pinctrl-starfive-jh7110.c        | 42 ++++++++++++++++++-
 .../starfive/pinctrl-starfive-jh7110.h        |  4 ++
 5 files changed, 53 insertions(+), 2 deletions(-)


base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
-- 
2.38.1

