Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76967F4740
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344218AbjKVM5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344246AbjKVM5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:57:07 -0500
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C31DC112;
        Wed, 22 Nov 2023 04:56:56 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BBCED540A2;
        Wed, 22 Nov 2023 12:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
        t=1700657814; h=from:subject:date:message-id:to:mime-version:
         content-transfer-encoding:in-reply-to:references;
        bh=1JJrVlQT4dSyAepCsKEppt0JhDAnONuiLebT73/zFmQ=;
        b=MyaO1ciELUoOTnkA8k5bOa8bMRT2ead7XfG4T1E1/saUsTaq9YZZ5POKgj8j/2kH+2yK5b
        Yt4F4OdXM0mtM/vpM9Ah9rXVH8A79i4xkMSEeeJ5ltnobxOh/IopZ4eEqDEEVVvjGcT29u
        McfldYm/gBr2SkJKqT33OyapEP2vdX49Yu1jzgO9lprJ8n8cH5S3QjRISFts71ah/aLaem
        ynCHhwbAj0wVR7makmAnhlviUDes0UwIiVKX/7ox9cDrUEc5wi/tEHuMC1kmkcWk6EYlbn
        XbBquQ5X5cVbxtaLtzW1sxqMWhHDJJ7zj8djrGFb755RagPQrgoldenLRpj2WQ==
From:   Viacheslav Bocharov <adeep@lexina.in>
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 3/5] firmware: meson_sm: move common definitions to header file
Date:   Wed, 22 Nov 2023 15:56:41 +0300
Message-Id: <20231122125643.1717160-4-adeep@lexina.in>
In-Reply-To: <20231122125643.1717160-1-adeep@lexina.in>
References: <20231122125643.1717160-1-adeep@lexina.in>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1284; h=from:subject; bh=qgIgUERrKdBRmt/t8R9MoRn4sT6vtjugdlg8U0yx7ss=; b=owGbwMvMwCHmnhFhrJcZuJTxtFoSQ2rst6N93hV/DR5LPs8LXCH2/fyz36Iv3ldfLpt+SnmDqfNG XbbUjlIWBjEOBlkxRZawjqCp+zxWX5y4wOgAzBxWJpAhDFycAjARETOGv3Jn1KbnZSwoTRbMmhoS8a O3ZVJ970a71oRvJ0K3vctTXcvIcLTzWXu8t1fTt7VmW0tLsiZ9U/OptTUWN+dalL03ukWKDwA=
X-Developer-Key: i=adeep@lexina.in; a=openpgp; fpr=E2FA1A767ACB0716E02E3E7AEE36B110025A8DFA
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move SM_CHIPID_* constants from firmware meson sm driver to
header file.

Signed-off-by: Viacheslav Bocharov <adeep@lexina.in>
---
 drivers/firmware/meson/meson_sm.c       | 4 ----
 include/linux/firmware/meson/meson_sm.h | 4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 402851ed4ac0..96e50811336f 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -240,10 +240,6 @@ struct meson_sm_firmware *meson_sm_get(struct device_node *sm_node)
 }
 EXPORT_SYMBOL_GPL(meson_sm_get);
 
-#define SM_CHIP_ID_LENGTH	119
-#define SM_CHIP_ID_OFFSET	4
-#define SM_CHIP_ID_SIZE		12
-
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
diff --git a/include/linux/firmware/meson/meson_sm.h b/include/linux/firmware/meson/meson_sm.h
index 8eaf8922ab02..f62acd2bf52a 100644
--- a/include/linux/firmware/meson/meson_sm.h
+++ b/include/linux/firmware/meson/meson_sm.h
@@ -7,6 +7,10 @@
 #ifndef _MESON_SM_FW_H_
 #define _MESON_SM_FW_H_
 
+#define SM_CHIP_ID_LENGTH	119
+#define SM_CHIP_ID_OFFSET	4
+#define SM_CHIP_ID_SIZE		12
+
 enum {
 	SM_EFUSE_READ,
 	SM_EFUSE_WRITE,
-- 
2.34.1

