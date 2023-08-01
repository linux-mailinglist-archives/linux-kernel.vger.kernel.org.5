Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D904576AA1C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjHAHiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjHAHh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:37:58 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282511726
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:37:56 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230801073751epoutp04fdd71742a8c0645aa393b0684bf22f8e~3Mkhwruq52800628006epoutp04H
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 07:37:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230801073751epoutp04fdd71742a8c0645aa393b0684bf22f8e~3Mkhwruq52800628006epoutp04H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690875471;
        bh=ZPfXhvfp9J8paEfU6+R+EFm3zHy9LPevaVQbPRRNkjw=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=aIOJq5QjnixGGLWZ7zdUlB9dRDzeUuUZxHYnAYqiJ5kTFGmbFZul/+TZ7FXaG6EP3
         NjjaDJZ+A2B8TNT0uKMcpjwAQLUV7aQv/I0WrgPhf7d63XHabtwYUdDzukTTGykeFC
         49xGzCegkGu6xcUDgVcWmbFQmYyD+pM7KadiUP9w=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230801073751epcas2p1f1292831fe8ee94c373ea9f8c003d9f6~3MkhXGqar0651006510epcas2p1M;
        Tue,  1 Aug 2023 07:37:51 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.100]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RFRly4JTpz4x9Q2; Tue,  1 Aug
        2023 07:37:50 +0000 (GMT)
X-AuditID: b6c32a43-557fb7000001d7ef-5b-64c8b64ecaf7
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        12.7D.55279.E46B8C46; Tue,  1 Aug 2023 16:37:50 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] scsi: ufs: ufs-pci: Add support for QEMU
Reply-To: jeuk20.kim@samsung.com
Sender: Jeuk Kim <jeuk20.kim@samsung.com>
From:   Jeuk Kim <jeuk20.kim@samsung.com>
To:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "dlunev@chromium.org" <dlunev@chromium.org>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230801073750epcms2p121c08e452aaafdda301c5562f4ccff5b@epcms2p1>
Date:   Tue, 01 Aug 2023 16:37:50 +0900
X-CMS-MailID: 20230801073750epcms2p121c08e452aaafdda301c5562f4ccff5b
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNJsWRmVeSWpSXmKPExsWy7bCmha7fthMpBvPPyFucfLKGzeLlz6ts
        FtM+/GS2eHlI0+L4oa8sFotubGOyuLxrDptF9/UdbBbLj/9jcuD0uHzF22N2w0UWj8V7XjJ5
        TFh0gNHj49NbLB59W1YxenzeJOfRfqCbKYAjKtsmIzUxJbVIITUvOT8lMy/dVsk7ON453tTM
        wFDX0NLCXEkhLzE31VbJxSdA1y0zB+g6JYWyxJxSoFBAYnGxkr6dTVF+aUmqQkZ+cYmtUmpB
        Sk6BeYFecWJucWleul5eaomVoYGBkSlQYUJ2xsyVcgX97BVbOl8wNTB2snUxcnJICJhIXFj4
        mKWLkYtDSGAHo0TXvBVACQ4OXgFBib87hEFqhAUsJZ6fmwhWLySgIDFnWwc7RFxTYvr6iUwg
        5WwC6hKnF5qDjBERWMUk8Wb/FbB6ZoE6id1z/kDt4pWY0f6UBcKWlti+fCsjhK0h8WNZLzOE
        LSpxc/Vbdhj7/bH5UDUiEq33zkLVCEo8+LkbKi4pcerbY1YIezqjxIL/piBHSAgsYJT41Twd
        qkFf4lrHRrDFvAK+EndPfwKLswioSsz5dAjqOBeJuY/mMEIcLS+x/e0cZpDHmIGeXL9LH8SU
        EFCWOHKLBaKCT6Lj8F92mLcaNv7Gyt4x7wkThK0isbj5MCvEGCmJDbtDJzAqzUKE8ywka2ch
        rF3AyLyKUSy1oDg3PTXZqMAQHrPJ+bmbGMGpVMt5B+OV+f/0DjEycTAeYpTgYFYS4ZX+fTxF
        iDclsbIqtSg/vqg0J7X4EKMp0MMTmaVEk/OByTyvJN7QxNLAxMzM0NzI1MBcSZz3XuvcFCGB
        9MSS1OzU1ILUIpg+Jg5OqQYmw4uaS3qPH8tdXaGY6/A4WHSX30/t5jv3nzAqit1++ChqQ3nn
        bbnl17kCFty+JyP1ccZcrp+rv5UtKrwxyW7i6i9t60Ptz9V+PPDGZwqLf1JMOcM+JrfLFx+d
        /nokN3WuYIj/O589i9z/zK5+vvyFlrrE43Lb1+se36l2m6H2nyur841Jp0d6/rR5QQ6FM7gi
        4t4LTnhsnho6fYaHv0nfpRcs0ctO3fPwlzkfLffL+pbPCV798wHbdi0+qfDrz/oz9uv+CL49
        stOh1nrx6nmvD8y4O79n3nK5x5b1bBm5jVb8vTNUyoTdktunX7q8cvJqiQO2/fy+sXkKe8Iv
        CR0WSWU68mur2B12j5/GGms3nFRiKc5INNRiLipOBAAr9nWVLgQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230801073750epcms2p121c08e452aaafdda301c5562f4ccff5b
References: <CGME20230801073750epcms2p121c08e452aaafdda301c5562f4ccff5b@epcms2p1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCI ID to support QEMU ufs.

The new qemu ufs device can be found at
https://lore.kernel.org/qemu-devel/20230727155239.GA979354@fedora

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---
 drivers/ufs/host/ufshcd-pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ufs/host/ufshcd-pci.c b/drivers/ufs/host/ufshcd-pci.c
index cf3987773051..29d322931427 100644
--- a/drivers/ufs/host/ufshcd-pci.c
+++ b/drivers/ufs/host/ufshcd-pci.c
@@ -590,6 +590,7 @@ static const struct dev_pm_ops ufshcd_pci_pm_ops = {
 };
 
 static const struct pci_device_id ufshcd_pci_tbl[] = {
+	{ PCI_VENDOR_ID_REDHAT, 0x0013, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VENDOR_ID_SAMSUNG, 0xC00C, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
 	{ PCI_VDEVICE(INTEL, 0x9DFA), (kernel_ulong_t)&ufs_intel_cnl_hba_vops },
 	{ PCI_VDEVICE(INTEL, 0x4B41), (kernel_ulong_t)&ufs_intel_ehl_hba_vops },
-- 
2.34.1

