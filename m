Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621647EF0AD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:38:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345908AbjKQKiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjKQKiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:38:20 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E619011D;
        Fri, 17 Nov 2023 02:38:17 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-6b2018a11efso1896750b3a.0;
        Fri, 17 Nov 2023 02:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700217496; x=1700822296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=27pW7hTiWecL2f2LbiVXnCeF3dvp7e3AsOLYkKstg8A=;
        b=PsUToDRTRHfxrwFS1NQzgVIFtlXH9KsdiEeCmpb8NJFF54uIM3WGC/uUVqcHvhoH47
         3yUQdTW9VgAgsAU/gCMANJuK8TR2AuoMNjAzHPEMy12HCaqOkd1+WbSaQRn0/zcabVnz
         UOH9Z46KzgwSK2lMYoWstm0Np6O1VDwxpF471Fr06bNMvdu/4nchU+gfEtiT874N3lOd
         6Rq2Ki4l33lDOL0yjSjKszI+JR+RUHb/tNPhKPlKHMPiGVYHalBYqBUQBfqDqyPMDIAE
         xeCP20RX7TOhPm4ugkMG7Q+IikdiipBCiT1bYS0TfwIF/xfxoTGDLJwmEvPMn40xJ+cZ
         0qeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700217496; x=1700822296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=27pW7hTiWecL2f2LbiVXnCeF3dvp7e3AsOLYkKstg8A=;
        b=R9BU7c0jHcPigqJTZHTdxA9c+QPIgu8lJPCyfkx5NnHXLxmj+BEcElymrfWJj2dpwX
         k1NzZMru1whc9hIIaWfyl7H4y+iB41yQZ86f73K4MJP00CWwtoCwhho6A7iHP4EI45al
         LVgaCaS8AhP31aVraOa5flnKH/IuK1fgEgOGewzOq1VFwDu7e4BMjeX2cgQBpPD6kG+R
         PapAnMzPWK3Mt9LHUIZtd9i05M77ALLJGMMEB/LxGKX8hsm6DIctjDCsPjYvfx/aVPhD
         YgmLXBtH6doH6YN5/aHAAHzbGfOxmSpV1g3YMi2W9g8f8oLlhmm9Ybnt3zF6HwhAD6Kc
         VTLA==
X-Gm-Message-State: AOJu0YyQVuccdDCr82hCB1TfahA3PTepWo+bNW7l3exD0KJdYGLZkggM
        z3199Rmr7RuBqB2u0x+Q9TJjL1Uv8aMb
X-Google-Smtp-Source: AGHT+IFTBmIJu1gybMvQTbWLwZedY741zRxIHs/g0gYPyRdNG/HkvTy0Wif4joQ7l8KQepIajWCEuQ==
X-Received: by 2002:a05:6a00:6c96:b0:6bd:d884:df00 with SMTP id jc22-20020a056a006c9600b006bdd884df00mr20642946pfb.9.1700217496218;
        Fri, 17 Nov 2023 02:38:16 -0800 (PST)
Received: from localhost.localdomain (111-243-26-65.dynamic-ip.hinet.net. [111.243.26.65])
        by smtp.gmail.com with ESMTPSA id r5-20020aa78445000000b006b76cb6523dsm1148062pfn.165.2023.11.17.02.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 02:38:15 -0800 (PST)
From:   Stanley Jhu <chu.stanley@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-scsi@vger.kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        peter.wang@mediatek.com
Cc:     stanley.chu@mediatek.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, chu.stanley@gmail.com,
        Macpaul Lin <macpaul.lin@mediatek.com>
Subject: [PATCH v3] scsi: ufs: mediatek: Change the maintainer for MediaTek UFS hooks
Date:   Fri, 17 Nov 2023 18:38:10 +0800
Message-Id: <20231117103810.527-1-chu.stanley@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Change the maintainer of MediaTek UFS hooks to Peter Wang.
In the meantime, Stanley has been assigned as the reviewer.

The original maintainer, Stanley Chu, who can be reached at
stanley.chu@mediatek.com, has left MediaTek,
so please update the email address accordingly.

Cc: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Peter Wang <peter.wang@mediatek.com>
Reviewed-by: Macpaul Lin <macpaul.lin@mediatek.com>
Signed-off-by: Stanley Jhu <chu.stanley@gmail.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index be1cbc6c2059..4f6fb3357947 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22102,7 +22102,8 @@ S:	Maintained
 F:	drivers/ufs/host/ufs-exynos*
 
 UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER MEDIATEK HOOKS
-M:	Stanley Chu <stanley.chu@mediatek.com>
+M:	Peter Wang <peter.wang@mediatek.com>
+R:	Stanley Jhu <chu.stanley@gmail.com>
 L:	linux-scsi@vger.kernel.org
 L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.34.1

