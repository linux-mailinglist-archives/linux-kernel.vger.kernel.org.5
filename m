Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D06876DE97
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 04:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjHCC4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 22:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbjHCC4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 22:56:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA17C1BF9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 19:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691031323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VJUm9eTqX3i3gVsPgXjr/+21LFeP4GATo/gyO9ZPuJE=;
        b=DAvhxkbQwWVwPb7nODGWUmoNoF5qMWomr0ovgnVdiUUTfcGlP4SZaj2TZdXm8AhN/CyEfz
        oD43Sx7lKRSnOf8YKW06+wIR1zKcp/6xDgm2Wqg2l6VrBSq/0RXQn/YvMZ6e+HMkQ7QMaG
        tXRY9Q2ss136pPtF2C8CB2dXXNrk6Vw=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-tSQTXLhKMi64gO20bSZmeA-1; Wed, 02 Aug 2023 22:55:22 -0400
X-MC-Unique: tSQTXLhKMi64gO20bSZmeA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1bb98659f3cso3901165ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 19:55:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691031321; x=1691636121;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJUm9eTqX3i3gVsPgXjr/+21LFeP4GATo/gyO9ZPuJE=;
        b=lzT6DwBiSW0mHT1Sx1Ba0qJaBkhsR/uxzRLnGW0rUEnM4FFRXUq4XhIxSHGF7HSq6Q
         NplDJccCtE9k/AJpvcUNNTAKVoEO0PFlrLdHA6AUKXg65t2ZnWfixe46G0XZvthSCird
         awKAH4lpiKgv6d/ND2ajNeqpti/8EyNyWSYqh1uMW1dgVCZcVvoOJZPEihJzHlpRFa0G
         Cbgnz4WvZqrJVEks9YMrtTYqduywDvMEYSSrrkblqEqMzaIqtkr7SwGySnRG6YyDt3XT
         vmmsV5pcmPjgEPZcS5fTPejVRJeIE+DzvTk+J1Ynm2ST+3HYez2OgC2s860h5SdrgAPX
         QAuw==
X-Gm-Message-State: ABy/qLZdWRfZZ9jdByFiy1Hd3jSFI/tstp1M8Bex6RoMXbE0K/lkhLlg
        Oqfa++lr6jwcq1Zz1GvUUH/OoIIVYKq7yQ1yBHP/eLTHGvBN3Oyipqhiv7IttBq82lOHrdU3NCG
        dOpl43pwj+quKinokeayBDPkD
X-Received: by 2002:a17:903:120a:b0:1bb:9bc8:d230 with SMTP id l10-20020a170903120a00b001bb9bc8d230mr19030193plh.23.1691031321602;
        Wed, 02 Aug 2023 19:55:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGdeA4D1H3ms4ges4ceqcHKGDgrwP4PArjRRh3Xaqq4kOELxj+Zp6YYWMH4q/XYqnCqaT/ZCQ==
X-Received: by 2002:a17:903:120a:b0:1bb:9bc8:d230 with SMTP id l10-20020a170903120a00b001bb9bc8d230mr19030183plh.23.1691031321280;
        Wed, 02 Aug 2023 19:55:21 -0700 (PDT)
Received: from localhost.localdomain.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jd6-20020a170903260600b001b7feed285csm13088202plb.36.2023.08.02.19.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 19:55:20 -0700 (PDT)
From:   Tao Liu <ltao@redhat.com>
To:     gregory.greenman@intel.com, kvalo@kernel.org,
        johannes.berg@intel.com, mukesh.sisodiya@intel.com
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tao Liu <ltao@redhat.com>
Subject: [RFC][PATCH] iwlwifi: Add pci .shutdown() hook for iwlwifi driver
Date:   Thu,  3 Aug 2023 10:32:58 +0800
Message-Id: <20230803023257.9260-1-ltao@redhat.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously no .shutdown() hook is implemented for iwlwifi driver, a
ETIMEDOUT error will occur during the kexec kernel bootup. As a
consequence, wifi is unusable after kexec into the new kernel.

This issue is observed and patch tested on the following wireless cards:

1) Network controller: Intel Corporation Comet Lake PCH-LP CNVi WiFi,
   Subsystem: Intel Corporation Wi-Fi 6 AX201 160MHz
2) Network controller: Intel Corporation Wireless-AC 9260,
   Subsystem: Intel Corporation Device e014

Signed-off-by: Tao Liu <ltao@redhat.com>
---

Hi folks,

This is a RFC patch and I'm not sure about the correctness of the code,
especially about the pci_clear_master() part. What I want is to stop any
ongoing DMA access, in case if the memory overwritting during kexec
kernel bootup. But there is already pci_clear_master(pci_dev) in
drivers/pci/pci-driver.c:pci_device_shutdown(), so I'm not sure if it is
still needed in the driver side. And I only tested the patch against the
above 2 wireless cards and worked OK, not sure if it can work for others.
Please review the patch, thanks in advance!

Thanks,
Tao Liu

---
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 73c1fb3c0c5e..24c4c2dd7cb0 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -1513,6 +1513,18 @@ static void iwl_pci_remove(struct pci_dev *pdev)
 	iwl_trans_pcie_free(trans);
 }
 
+static void iwl_pci_shutdown(struct pci_dev *pdev)
+{
+	struct iwl_trans *trans = pci_get_drvdata(pdev);
+
+	if (!trans)
+		return;
+
+	iwl_drv_stop(trans->drv);
+
+	pci_clear_master(pdev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 
 static int iwl_pci_suspend(struct device *device)
@@ -1583,6 +1595,7 @@ static struct pci_driver iwl_pci_driver = {
 	.id_table = iwl_hw_card_ids,
 	.probe = iwl_pci_probe,
 	.remove = iwl_pci_remove,
+	.shutdown = iwl_pci_shutdown,
 	.driver.pm = IWL_PM_OPS,
 };
 
-- 
2.40.1

