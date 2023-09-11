Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0AD79B3B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbjIKU5D convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 Sep 2023 16:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjIKIZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:25:21 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E0AE7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:25:16 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id DE13A24E2C1;
        Mon, 11 Sep 2023 16:25:14 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 11 Sep
 2023 16:25:15 +0800
Received: from localhost.localdomain (202.188.176.82) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 11 Sep
 2023 16:25:12 +0800
From:   Joshua Yeong <joshua.yeong@starfivetech.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Joshua Yeong" <joshua.yeong@starfivetech.com>
Subject: [PATCH 0/1] Fallback mechanism for GETMXDS CCC
Date:   Mon, 11 Sep 2023 16:24:55 +0800
Message-ID: <20230911082456.23239-1-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some I3C hardware will report error when incorrect length is received from
device. GETMXDS CCC are availble in 2 formats; without turnaround time (format
1) and with turnaround time (format 2). There is no mechanics to determine which
format is supported by device. In case sending GETMXDS CCC format 2 resulted
failure, try sending GETMXDS CCC format 1 instead.

Joshua Yeong (1):
  i3c: Add fallback method for GETMXDS CCC

 drivers/i3c/master.c    | 33 ++++++++++++++++++++++++++++-----
 include/linux/i3c/ccc.h | 17 +++++++++++++++--
 2 files changed, 43 insertions(+), 7 deletions(-)

--
2.25.1

