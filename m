Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E6C7F18C9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjKTQjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjKTQjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:39:43 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DE7BA;
        Mon, 20 Nov 2023 08:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
        :From:subject:date:message-id:reply-to;
        bh=jeI1cAbbkaEeeFL+CLrlTP90a1nSpQP3zxZs4Tk4e1o=; b=Wt1dnfWPDal9TfyBoqDRSgjG2b
        7ifSDLmGK1cxdoNoGSmJJylU6cQo/xbdvGGL+cOCR3ygMrgZcrG+7eFKh7znW75gW3ZhZOyNWprRQ
        H0d9YmqBgs62MKp5IHIilqHRQvKn3dIsMbR5nR1qVMnRqKGo3WJ7LMTtqCNmRiMayhxU=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52556 helo=pettiford.lan)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1r57J9-00005F-EI; Mon, 20 Nov 2023 11:39:35 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        hugo@hugovil.com, lech.perczak@camlingroup.com,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date:   Mon, 20 Nov 2023 11:39:30 -0500
Message-Id: <20231120163931.2872431-1-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v2 0/1] serial: sc16is7xx: improve regmap debugfs with one regmap per port
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Hello,
this patch series improves regmap debugfs by using one regmap per port.

I have tested the changes on a custom board with two SC16IS752 DUART using a
Variscite IMX8MN NANO SOM.

Thank you.

Link: [v1] https://lore.kernel.org/all/20231030211447.974779-1-hugo@hugovil.com/

Changes for V2:
- Remove now useless line variable in struct sc16is7xx_one

Hugo Villeneuve (1):
  serial: sc16is7xx: improve regmap debugfs by using one regmap per port

 drivers/tty/serial/sc16is7xx.c | 145 ++++++++++++++++++---------------
 1 file changed, 81 insertions(+), 64 deletions(-)


base-commit: 98b1cc82c4affc16f5598d4fa14b1858671b2263
-- 
2.39.2

