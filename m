Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6027E9FAC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjKMPN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjKMPN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:13:27 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7E8DB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:13:23 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ADFDFgD005655;
        Mon, 13 Nov 2023 09:13:15 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1699888395;
        bh=sS7JwTMQJGlgvK/UwzC2fFAeF6dg4Rt84KCzL7e4bkc=;
        h=From:To:CC:Subject:Date;
        b=VLwQwPJCvhJXznkTwLpLYeS3wUFzVB4FiIOEuGsM3DcTE2EceHgVBRU25urK4PM2W
         SIDJB4qwd5rbUJhemqR4nEoHIMpDj9G/ZJu1EGCMLloYdNQ9u29LYF4tGTB15+Kezb
         570cQ9+fnmg6skVFsdcr3Qe9Na5GU2DG2ws05mZU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ADFDFAP051673
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Nov 2023 09:13:15 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 13
 Nov 2023 09:13:15 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 13 Nov 2023 09:13:15 -0600
Received: from lelv0326.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ADFDFiB074977;
        Mon, 13 Nov 2023 09:13:15 -0600
From:   Andrew Davis <afd@ti.com>
To:     Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2] ARM: multi_v7_defconfig: Enable RPMSG CHAR and CTRL
Date:   Mon, 13 Nov 2023 09:13:14 -0600
Message-ID: <20231113151314.178901-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Changes for v2:
 - Rebase on v6.7-rc1

 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a1d73588aa371..9c015f4f93296 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1088,6 +1088,8 @@ CONFIG_QCOM_Q6V5_MSS=m
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

