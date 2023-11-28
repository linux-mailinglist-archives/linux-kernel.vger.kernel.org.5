Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D50D7FB08F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjK1C5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 21:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjK1C5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 21:57:47 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022EE10D7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:57:50 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c115026985so4897057b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 18:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701140269; x=1701745069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xq2UZc/qF6ygYEmucjhvtRnAU79JEXbt2OXuiPsGdb0=;
        b=QEl6nyK2U5F48jH5ohVroLhs6wlnOR8H3THKB2gYQiAndN/UK0dpp9BNOjR1hRPSl9
         OWJNJRoO5H0HspvwoPMedC9WFF6PiYiIcGFvvSsvsYORYScBDWvmPxsyS8EZ9qiPqdGF
         fZr4Wxl1QXXfKsSFQtzc2clJx1NznYe5UZBeBg8UjruvwjAp88jJovT8tkwQMY87rI4U
         Zx8Xgn0o83HlVsXaaeKahG/9G313HHYO78pyXmm1fq2bJHKjpCwaIcwdjtOxTQIT0fw7
         9Vh1q4jIZFZMGT/5E1OeCxmb2v2NTGmZsZsbitOd858QqHRriDEu6lixNinfw8nQzStN
         5+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701140269; x=1701745069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xq2UZc/qF6ygYEmucjhvtRnAU79JEXbt2OXuiPsGdb0=;
        b=KakWO9t6mupxY9nEEqlIgeh52oDFq6ETAzQWZszJZYh9/NDS9pSdZjlYkpRBsfusno
         xnRobLXjarCywtMh+CbRBoMwJaBvbTJhuJ0FNmDMRrc5uyACadC+a0ooJIVQzR9/a2/4
         18SzE9rUNXUFs6u70O8TCwYVNPFaddFR6L8xHIe5vginCoC7YPVQ/gcoaQ4I2VzDRiTV
         xbQfNcciezJVYr2F69wIIQT36yW9Q+wIyBtkigMR9jjLtKzK8dTq77kNRb2mcTqOtCDE
         91qGC9ckua5kCMdApHqI6n8v/l5jSB3lOMn3vFvV7gA7/XNs0rIRZcAndKL0uxDHji0t
         SCxw==
X-Gm-Message-State: AOJu0Yz8oI/t8ncqbRtz5jU06YPTCzZW2Wc9c82XxyTP8m649JZzJ7gH
        MgT5ZpZv65gXjNGqiwegpsU=
X-Google-Smtp-Source: AGHT+IHKfl6zCTzYaX64gPJ7IlYAWWrLTK7UXpqyPWkn0nLz5fGBBtge77cAR99etqzZixsoLdk/6A==
X-Received: by 2002:a05:6a20:54a1:b0:187:5302:4b21 with SMTP id i33-20020a056a2054a100b0018753024b21mr17952683pzk.46.1701140269419;
        Mon, 27 Nov 2023 18:57:49 -0800 (PST)
Received: from smi-System-Product-Name.tw.smi.ad (125-227-10-151.hinet-ip.hinet.net. [125.227.10.151])
        by smtp.gmail.com with ESMTPSA id n17-20020a056a0007d100b006cb65cfde6dsm7930782pfu.200.2023.11.27.18.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 18:57:49 -0800 (PST)
From:   "Jim.Lin" <jim.chihjung.lin@gmail.com>
X-Google-Original-From: "Jim.Lin" <jim.lin@siliconmotion.com>
To:     kbusch@kernel.org
Cc:     axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        jim.lin@siliconmotion.com, cj.chen@siliconmotion.com,
        david.yeh@siliconmotion.com, hardaway.tseng@sk.com
Subject: [PATCH] nvme-pci: disable write zeroes for SK Hynix BC901
Date:   Tue, 28 Nov 2023 10:57:37 +0800
Message-Id: <20231128025737.53026-1-jim.lin@siliconmotion.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SK Hynix BC901 drive write zero will cause Chromebook takes more than 20 mins to switch to developer mode
"disable write zeroes" can fix this issue and Sk Hynix has been verified.

Signed-off-by: Jim.Lin <jim.lin@siliconmotion.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 507bc149046d..f27202680741 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3394,6 +3394,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1c5c, 0x1D59),   /* SK Hynix BC901 */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
-- 
2.25.1

