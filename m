Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2AF479B7FE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239278AbjIKWWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239172AbjIKONi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:13:38 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E9CCF0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:13:33 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38BEDMXC003637;
        Mon, 11 Sep 2023 09:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1694441602;
        bh=XhRUEvZp37/e5qvkzX2o5M3wgs9dRbhvm0THzczBAAo=;
        h=From:To:CC:Subject:Date;
        b=XGJppvXKxZ/8wM6M/zFCV/2q8RFTiXw7AO+tUYlMFyiWLltavYEwIJDa0zEEf/Grb
         0ErtWAv9MLNghJoV++JUteUEpvQn/7Ilqy/XW7RU2Dx3fkgkNIZsAxH+jbQ/rVop3t
         J8ncm1/Z5WgnukcgeUT7A0z8efJMEHbZ3kI+ReLY=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38BEDMab003381
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Sep 2023 09:13:22 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Sep 2023 09:13:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Sep 2023 09:13:22 -0500
Received: from fllv0039.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38BEDLvN127591;
        Mon, 11 Sep 2023 09:13:21 -0500
From:   Andrew Davis <afd@ti.com>
To:     Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH] ARM: multi_v7_defconfig: Enable RPMSG CHAR and CTRL
Date:   Mon, 11 Sep 2023 09:13:20 -0500
Message-ID: <20230911141320.60707-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These allow user-space programs to create RPMSG endpoints and have
those endpoints show up as device files. They are enabled in the
ARM64 defconfig and are useful for the same reasons here.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 2b9b6378ca664..877714b51064c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1086,6 +1086,8 @@ CONFIG_QCOM_Q6V5_MSS=m
 CONFIG_QCOM_SYSMON=m
 CONFIG_QCOM_WCNSS_PIL=m
 CONFIG_ST_REMOTEPROC=m
+CONFIG_RPMSG_CHAR=m
+CONFIG_RPMSG_CTRL=m
 CONFIG_RPMSG_QCOM_SMD=y
 CONFIG_RPMSG_VIRTIO=m
 CONFIG_ASPEED_LPC_CTRL=m
-- 
2.39.2

