Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9587C762AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 07:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjGZFSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 01:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjGZFSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 01:18:07 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FACBF
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:18:06 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26825239890so1608714a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 22:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1690348686; x=1690953486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T+J6Ed15Yk5vxDPaPbZ5dBECpzg/w9CpybrlLvkM2Ms=;
        b=K4qTVXllKmKg5x1npK8Bxvgl45zX3Kf29W5CfRSfwdsM0c2PRCMR3oQhnsF1CqlQcJ
         0LCRIVL5P/ZlZGnYizix9E37tzj31tXxYjL3qrMrZfI/NWpag5onkjaM5gXQ9KCh6Dv6
         e2RAsEq9c5g1D28mrws8W1AqFiYFta5dTFrGrIQ0MMumqL0M4W+k1zux07IN5UYQzNrB
         7xipTikkjpoVfEpwarUW86l0eGK/aa5GgrXCNwoDnz0kNYtz/Xk/ybEgcvxDn62NdkUt
         Of/FxAZunrWlHQfGR9qbwABmv9XStmK8MJcwvNCx91k5ipipGQ0qt6Xs+SyhHKQnSR0A
         srWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690348686; x=1690953486;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T+J6Ed15Yk5vxDPaPbZ5dBECpzg/w9CpybrlLvkM2Ms=;
        b=SOBFOodMJUbXwWnPi5tpBNWHecVRdLUWAWV7q2kFu/0uVMvqh8+YE2Y+8z8Xcowu6I
         vwLmepLEZDG1xILZK0IsyuFh/3nUGnm7ywl5zyps72Ze6o9O4eDsEp9+AZtPbnEzXDw7
         gCYb93S7OWsPo3C2Mib/C1wrt/lkgGKYX4q35sgiiReFEcZMIXrlarTR2AYC7t2lxsvQ
         /jTB5V7F1/r65SGhbWK+mdvx5m83pa7tNkub2xOYWvaq2d9iQUA6p+liTVesalQBB8iM
         xTZl3lNXKrCtDmHhVoec5e2uGL82UTR2cUX9GdLk4JSkZJmf4gyFSomcRJCsloIKKIPv
         /qGg==
X-Gm-Message-State: ABy/qLbCyi0ZyYuljQdw3J/pZIUsoohoYcyc6W75AdkAA2Jjf7pG1jNv
        UCx67hxMeWAHcgltfR0G0u5hEA==
X-Google-Smtp-Source: APBJJlExTj4h2XeTWimCRhV3cbGQuUDPdUpEacmJfUXScpmXWuJe14teMGiR3rtyJcVwe0rvdmruPg==
X-Received: by 2002:a17:90a:cb8a:b0:268:1217:46bc with SMTP id a10-20020a17090acb8a00b00268121746bcmr802138pju.11.1690348686247;
        Tue, 25 Jul 2023 22:18:06 -0700 (PDT)
Received: from sunil-laptop.dc1.ventanamicro.com ([106.51.83.242])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090a4c8500b002676e961260sm2159979pjh.0.2023.07.25.22.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 22:18:05 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiang Chen <chenxiang66@hisilicon.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sunil V L <sunilvl@ventanamicro.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] scsi: hisi_sas: Fix warning detected by sparse
Date:   Wed, 26 Jul 2023 10:47:59 +0530
Message-Id: <20230726051759.30038-1-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LKP reports below warning when building for RISC-V
with randconfig configuration.

drivers/scsi/hisi_sas/hisi_sas_v3_hw.c:4567:35: sparse:
sparse: incorrect type in argument 4 (different base types)
@@     expected restricted __le32 [usertype] *[assigned] ptr
@@     got unsigned int * @@

Type cast to fix this warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307260823.whMNpZ1C-lkp@intel.com/
Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 20e1607c6282..6cd2e485d35b 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -4576,7 +4576,7 @@ static int debugfs_fifo_data_v3_hw_show(struct seq_file *s, void *p)
 	debugfs_read_fifo_data_v3_hw(phy);
 
 	debugfs_show_row_32_v3_hw(s, 0, HISI_SAS_FIFO_DATA_DW_SIZE * 4,
-				  phy->fifo.rd_data);
+				  (__le32 *)phy->fifo.rd_data);
 
 	return 0;
 }
-- 
2.34.1

