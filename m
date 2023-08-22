Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03AC78386A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232468AbjHVDSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjHVDSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:18:44 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1607613E;
        Mon, 21 Aug 2023 20:18:42 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37M3HqkuE005065, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37M3HqkuE005065
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 11:17:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 22 Aug 2023 11:18:14 +0800
Received: from RTDOMAIN (172.21.210.160) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 22 Aug
 2023 11:18:14 +0800
From:   Justin Lai <justinlai0215@realtek.com>
To:     <kuba@kernel.org>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <jiri@resnulli.us>, <andrew@lunn.ch>,
        Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next v6 0/2] Add Realtek automotive PCIe driver
Date:   Tue, 22 Aug 2023 11:18:03 +0800
Message-ID: <20230822031805.4752-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.210.160]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes adding realtek automotive ethernet driver and 
adding rtase ethernet driver entry in MAINTAINERS file.

This ethernet device driver for the PCIe interface 
of Realtek Automotive Ethernet Switch,
applicable to RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.

v5 -> v6:
- Some old macro definitions have been removed 
  and replaced with the lastest usage.
- Replace s32 with int to ensure consistency.
- Clearly point out the objects of the service 
  and remove unnecessary struct.

Justin Lai (2):
  net/ethernet/realtek: Add Realtek automotive PCIe driver code
  MAINTAINERS: Add the rtase ethernet driver entry

 MAINTAINERS                                   |    7 +
 drivers/net/ethernet/realtek/Kconfig          |   17 +
 drivers/net/ethernet/realtek/Makefile         |    1 +
 drivers/net/ethernet/realtek/rtase/Makefile   |   10 +
 drivers/net/ethernet/realtek/rtase/rtase.h    |  372 +++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 2432 +++++++++++++++++
 6 files changed, 2839 insertions(+)
 create mode 100644 drivers/net/ethernet/realtek/rtase/Makefile
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase.h
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase_main.c

-- 
2.34.1

