Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9F37FF23F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346031AbjK3Ohx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjK3Oht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:37:49 -0500
Received: from mail-m11876.qiye.163.com (mail-m11876.qiye.163.com [115.236.118.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F0BBD;
        Thu, 30 Nov 2023 06:37:54 -0800 (PST)
Received: from localhost.localdomain (unknown [IPV6:240e:3b7:3271:7f20:45e9:2b16:3419:6e5b])
        by mail-m12773.qiye.163.com (Hmail) with ESMTPA id 034032C064F;
        Thu, 30 Nov 2023 22:28:46 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     zhuwei@sangfor.com.cn, thenzl@redhat.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ding Hui <dinghui@sangfor.com.cn>
Subject: [PATCH 0/2] scsi: ses: Fix out-of-bounds accesses
Date:   Thu, 30 Nov 2023 22:28:33 +0800
Message-Id: <20231130142835.18041-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGkJDVkNPGUIZQk4YHUMZGlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTEpBTB1JS0FPTh5CQUkZSk1BSE9KQkFNHk4ZWVdZFhoPEhUdFF
        lBWU9LSFVKTU9JTklVSktLVUpCWQY+
X-HM-Tid: 0a8c20a1d9f1b249kuuu034032c064f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OCI6Szo*Tzw1QxcYFTg*LzcY
        LREKCSpVSlVKTEtKSE5PTklMTEJOVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUxKQUwdSUtBT04eQkFJGUpNQUhPSkJBTR5OGVlXWQgBWUFKSkhNNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes a few OOB fixes for ses driver

Ding Hui (1):
  scsi: ses: increase default init_alloc_size

Zhu Wei (1):
  scsi: ses: Fix slab-out-of-bounds in ses_get_power_status()

 drivers/scsi/ses.c | 55 +++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 47 insertions(+), 8 deletions(-)

-- 
2.17.1

