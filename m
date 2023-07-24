Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C60675F623
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbjGXMVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjGXMU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:20:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEBB13D;
        Mon, 24 Jul 2023 05:20:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A755561149;
        Mon, 24 Jul 2023 12:20:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA628C433CC;
        Mon, 24 Jul 2023 12:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690201236;
        bh=TZvmwAFuS4u+vLp3XBVWaUA/bTmykDSIMnh6Tz5bu+0=;
        h=From:To:Cc:Subject:Date:From;
        b=r6er/ayWEK7YxoMzdWjRyaig5T7E1A4u6f3j/u5DAVXNGwACIEqB0A6NIGTsE91xt
         oSSIKI/KWVhXMfkFwa7zn61kNTxz5qLAeC44plpJ9/fwvcTthqvyWfVsul8Rf4RM3v
         pT3isXuR7vmhKtehn3GOCKvob0ET5OyNEP0/ky7oCWAALPN6oX4AaaD00siWvllTGG
         IdZgZYBcmFjxfHuyxw4X0ingZiT7l8A7xHYnIv8ejNVHnEuuXp7wyd6gAMK8132NEq
         V/CB9P9KaaJLs2l6PS3YEEvbL6R5fc6I/+j2CMHIAakw+xrO6Aibw3hq3uGMPvygcG
         JeqeniSZu1dRw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ziqi Chen <quic_ziqichen@quicinc.com>,
        Can Guo <quic_cang@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Abel Vesa <abel.vesa@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ufs: qcom: remove unused variable
Date:   Mon, 24 Jul 2023 14:19:58 +0200
Message-Id: <20230724122029.1430482-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A recent change removed the only user of a local variable that needs
to now also be removed:

drivers/ufs/host/ufs-qcom.c: In function 'ufs_qcom_mcq_esi_handler':
drivers/ufs/host/ufs-qcom.c:1652:31: error: unused variable 'host' [-Werror=unused-variable]

Fixes: 8f2b78652d055 ("scsi: ufs: qcom: Get queue ID from MSI index in ESI handler")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/ufs/host/ufs-qcom.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 3ee5ff905f9a6..5728e94b6527b 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -1649,7 +1649,6 @@ static irqreturn_t ufs_qcom_mcq_esi_handler(int irq, void *data)
 	struct msi_desc *desc = data;
 	struct device *dev = msi_desc_to_dev(desc);
 	struct ufs_hba *hba = dev_get_drvdata(dev);
-	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	u32 id = desc->msi_index;
 	struct ufs_hw_queue *hwq = &hba->uhq[id];
 
-- 
2.39.2

