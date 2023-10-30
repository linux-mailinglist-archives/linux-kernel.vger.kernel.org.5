Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F887DB587
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjJ3Izi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232319AbjJ3Izh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:55:37 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54229D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:55:33 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39U19Ykq018206;
        Mon, 30 Oct 2023 09:55:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=selector1; bh=LkBbLvL
        Wqz8jghg6R6KCsG4K3/XdyCwgF3lhmAR9LKI=; b=6Nl+ofVZKO1k3WVRF3WYHMf
        8G27kt5YaSptLBPcXCEObFi2cd3gBqY5hP1fok4gtmqBkO925gQN2iItW0wpin9l
        xOYjmu0o/w8xVC6pZ3Edugd5vFPgxiR2C87oy8eSwBkN2t4c8efZ7EXEG3xyy/9Z
        d144tCo12M6/BIUpM7qG4VmhPLDm2QMNepwkYiLBC9kKcER6UU2n4QDRs3tiAiWz
        NAfd0hbd9++VZ2AfxHW5c1LYRb+/r1zaazTa6sQTR6wYSHzcMDL220NDP67wFhUX
        aXXG9bfZq0CIL8Tg5P56nluyvJqdYJ/dG2PBA7C1jYqj5v6qQlTagVwXzy+HQMw=
        =
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u0tuf6h21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Oct 2023 09:55:25 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 73E9110005C;
        Mon, 30 Oct 2023 09:55:24 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4272D21862F;
        Mon, 30 Oct 2023 09:55:24 +0100 (CET)
Received: from localhost (10.201.20.20) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 30 Oct
 2023 09:55:23 +0100
From:   Etienne Carriere <etienne.carriere@foss.st.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        <op-tee@lists.trustedfirmware.org>,
        Etienne Carriere <etienne.carriere@foss.st.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] optee: add missing description of RPC argument reference
Date:   Mon, 30 Oct 2023 09:55:15 +0100
Message-ID: <20231030085515.907123-1-etienne.carriere@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.20.20]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_06,2023-10-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds missing inline description comment for RPC optional arguments
reference.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202310192021.fvb6JDOY-lkp@intel.com/
Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
---
 drivers/tee/optee/smc_abi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
index d5b28fd35d66..67bfa25d6302 100644
--- a/drivers/tee/optee/smc_abi.c
+++ b/drivers/tee/optee/smc_abi.c
@@ -806,6 +806,7 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
 /**
  * optee_handle_rpc() - handle RPC from secure world
  * @ctx:	context doing the RPC
+ * @rpc_arg:	pointer to RPC arguments if any, or NULL if none
  * @param:	value of registers for the RPC
  * @call_ctx:	call context. Preserved during one OP-TEE invocation
  *
-- 
2.25.1

