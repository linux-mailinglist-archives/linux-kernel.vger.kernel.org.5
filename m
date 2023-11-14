Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F8B7EAC30
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjKNI4F convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Nov 2023 03:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231975AbjKNI4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:56:03 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3492A4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:55:59 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 8F92824DB83;
        Tue, 14 Nov 2023 16:55:58 +0800 (CST)
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Nov
 2023 16:55:58 +0800
Received: from localhost.localdomain (161.142.156.149) by EXMBX066.cuchost.com
 (172.16.6.66) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Nov
 2023 16:55:54 +0800
From:   Joshua Yeong <joshua.yeong@starfivetech.com>
To:     <alexandre.belloni@bootlin.com>, <miquel.raynal@bootlin.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Joshua Yeong" <joshua.yeong@starfivetech.com>
Subject: [PATCH v3 0/1] Fallback mechanism for GETMXDS CCC
Date:   Tue, 14 Nov 2023 16:55:24 +0800
Message-ID: <20231114085525.6271-1-joshua.yeong@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [161.142.156.149]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX066.cuchost.com
 (172.16.6.66)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some I3C hardware does not support turnaround time in GETMXDS. Cadence IPs will
perform validation against length of CCC returned. Similar hardware error were
not seen in other IPs DW/SVC.

Joshua Yeong (1):
  i3c: Add fallback method for GETMXDS CCC

 drivers/i3c/master.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--
2.25.1

