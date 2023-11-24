Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07B27F6F27
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:10:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232903AbjKXJJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:09:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbjKXJJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:09:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72AC9D5A;
        Fri, 24 Nov 2023 01:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700816995; x=1732352995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QYDq6Z5tWNEhZ/J5NePC3bRbFwseCQaqr4/k79zRT+I=;
  b=mFFtnsM5WrosV8S5HFysiMce0CybzIRKWfVqR+R1EaJ8RLYPv57i1vPq
   Tk1iknXmx0PqOPk4ZBYxLQPeU6bjmi/CKKAE1FaKAbsHs7+SOSMtvyGTm
   S35YzVGCtbAn2H+NgR/JY1ZxTtAyBQUBpJRyJJin+n0FXLn5y/MZGEQKW
   3+i3dDLACIDEH1GJyYPaVL6Eh7xKN4beZnP0EXU5tLsH9g5p9LntvNY3V
   iYjpY3h/vbJ9IwxH5CjbWT8qHBLAtVzGVdduvxl+sbEtgjfKMXjzmGq6K
   T9RxboqHsPGo5PGKBUsMz0eOYQyeKE3Ipz1PALXVhkJchmyG/hAM/96co
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="478603449"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="478603449"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:09:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="15911569"
Received: from mvlasov-mobl1.ger.corp.intel.com (HELO localhost) ([10.251.220.89])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 01:09:52 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/6] scsi: lpfc: Use PCI_HEADER_TYPE_MFD instead of literal
Date:   Fri, 24 Nov 2023 11:09:16 +0200
Message-Id: <20231124090919.23687-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com>
References: <20231124090919.23687-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace literal 0x80 with PCI_HEADER_TYPE_MFD.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/scsi/lpfc/lpfc_sli.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 9386e7b44750..4ac6afd3c2fe 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -4875,7 +4875,7 @@ void lpfc_reset_barrier(struct lpfc_hba *phba)
 	lockdep_assert_held(&phba->hbalock);
 
 	pci_read_config_byte(phba->pcidev, PCI_HEADER_TYPE, &hdrtype);
-	if (hdrtype != 0x80 ||
+	if (hdrtype != PCI_HEADER_TYPE_MFD ||
 	    (FC_JEDEC_ID(phba->vpd.rev.biuRev) != HELIOS_JEDEC_ID &&
 	     FC_JEDEC_ID(phba->vpd.rev.biuRev) != THOR_JEDEC_ID))
 		return;
-- 
2.30.2

