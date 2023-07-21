Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBCF75BE2A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbjGUGCn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:02:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjGUGCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:02:09 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF963588;
        Thu, 20 Jul 2023 23:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1689919289; x=1721455289;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yk+GKdkW5U5snvMb+NeGU56kvNagCSdTg8e2+tMyRHg=;
  b=qcHXvIumodws6RG/baFs7kYB+ixmu9BCK0BKgyGJ2vIdL5GaayLBDYjp
   iSzT9ZiGA0hmj8c0HKtWhX75Y1Sw9Y2fsDxbDLCEBj/c2p18FG8sRvzbn
   jmf/qvBKu9ljzOSiRyEr5HlnbCnaNXqgK/aGR82Cq2qaJ4Yv1fuz/Ucg7
   0vS/qSfZNrLWWtcmKMFVJgw8Zjh4J4niYyxtNwz/IFeoCYbhu0YiUs0/F
   ViCWrBx23wYfxqFHL4dIIddV2wkxVJWHdHi9SuwrvSpApcmN3QfYMTaJV
   WceEf3lM2478XmG+vxKtvXFgaogoh2Ft6OBsjdmGSGrmgIRe/YhCjnJLY
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="236881611"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2023 23:01:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 20 Jul 2023 23:01:11 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Thu, 20 Jul 2023 23:01:08 -0700
From:   Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
To:     <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <andrew@lunn.ch>,
        <linux@armlinux.org.uk>, <UNGLinuxDriver@microchip.com>
Subject: [PATCH net-next 0/2] Add support to Fiberstore SFP quirks
Date:   Fri, 21 Jul 2023 11:30:55 +0530
Message-ID: <20230721060057.2998-1-Raju.Lakkaraju@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support to Fiberstore(FS)'s SFP quirks for
 - 2.5G copper SFP (SFP-2.5G-T)
 - DAC10G SFP (SFPP-PC01)

Raju Lakkaraju (2):
  net: sfp: add quirk for FS's 2.5G copper SFP
  net: sfp: add quirk for FS's DAC10G SFP (SFPP-PC01)

 drivers/net/phy/sfp.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

-- 
2.25.1

