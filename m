Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777E37717E1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 03:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjHGBhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 21:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjHGBhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 21:37:35 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0FB10FC
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 18:37:31 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230807013728epoutp01ec8b502c99bd0dd4b73794a2ff997d5c~49hlYX9b21524915249epoutp01Q
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 01:37:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230807013728epoutp01ec8b502c99bd0dd4b73794a2ff997d5c~49hlYX9b21524915249epoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691372248;
        bh=eRp0hDxbLoDkI+EKmlyx1gM8DLMIflAnTWMEe1OnN5Q=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=l033EONLee9a1ouTeBHQTTXg5u09htwLi+RDYh613BRNziBxMNGBqznhpsr44p22b
         7Q2qeRPddsLCTDifpXwhyc3psSk4k448JxFuRWFpgEK0MJ9rt9sxmtuN07JHFA3CUa
         n0LeYM1/5zcq6EWMPmfqd+f5vvtLsFJUaFW/3g+w=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230807013728epcas2p2169ae6ebe391ebec62d5113e5f651204~49hkySrnI2090220902epcas2p2I;
        Mon,  7 Aug 2023 01:37:28 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.70]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4RJzTM1mjLz4x9Py; Mon,  7 Aug
        2023 01:37:27 +0000 (GMT)
X-AuditID: b6c32a4d-853ff70000047356-d9-64d04ad72a4e
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        0C.0E.29526.7DA40D46; Mon,  7 Aug 2023 10:37:27 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] scsi: ufs: ufs-pci: Add support for QEMU
Reply-To: jeuk20.kim@samsung.com
Sender: Jeuk Kim <jeuk20.kim@samsung.com>
From:   Jeuk Kim <jeuk20.kim@samsung.com>
To:     "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        Jeuk Kim <jeuk20.kim@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>
CC:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5@epcms2p1>
Date:   Mon, 07 Aug 2023 10:37:26 +0900
X-CMS-MailID: 20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFJsWRmVeSWpSXmKPExsWy7bCmme51rwspBrcfsFmcfLKGzeLlz6ts
        FtM+/GS2eHlI02LRjW1MFve3XmO0uLxrDptF9/UdbBbLj/9jcuD0uHzF22PxnpdMHhMWHWD0
        +Pj0FotH35ZVjB6fN8l5tB/oZgpgj8q2yUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0
        MFdSyEvMTbVVcvEJ0HXLzAE6TEmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6g
        V5yYW1yal66Xl1piZWhgYGQKVJiQnTGh/RBrwVGuivnv+9kaGF9wdDFyckgImEis2H2csYuR
        i0NIYA+jxMlNf5m6GDk4eAUEJf7uEAapERawkbhw5g4ziC0koCAxZ1sHO0RcU2L6+olg5WwC
        6hKnF5qDjBERmMckMenOR7AaZoE6id1z/rBB7OKVmNH+lAXClpbYvnwrI4StIfFjWS8zhC0q
        cXP1W3YY+/2x+VA1IhKt985C1QhKPPi5GyouKXHq22NWCHs6o8SC/6YgR0gILGCU+NU8HapB
        X+Jax0awxbwCvhKHpi1iBzmaRUBV4sX/aIgSF4k9h/ZB3Swvsf3tHGaQEmagH9fv0gcxJQSU
        JY7cYoGo4JPoOPyXHearho2/sbJ3zHvCBGGrSCxuPswKMUZKYsPu0AmMSrMQwTwLydpZCGsX
        MDKvYpRKLSjOTU9NNiow1M1LLYfHbnJ+7iZGcCLV8t3B+Hr9X71DjEwcjIcYJTiYlUR45z05
        nyLEm5JYWZValB9fVJqTWnyI0RTo54nMUqLJ+cBUnlcSb2hiaWBiZmZobmRqYK4kznuvdW6K
        kEB6YklqdmpqQWoRTB8TB6dUA5Ol43U26cJ9cTa8vf9rDvTNj+1nnHfo6jYDo09Rs6R2vns4
        8cST1dzWLb9+ZbxKMxVe+uLupJMs+cfcKhNdTLacuRd7z/GnqprUtZqw2O3SugErvnc5e3Y2
        /xJrufbewvPhEp+vD6br9Ey/4Osz63aU0FWJY9NZtb61vg7quBMidKBv98I5hkVXnL7UrlW4
        6PYtgZvv0b0/ugZcVqKvN25pebDBqczg/33T86EP7/+dLu9aGTv1w4oPG5h5JljoPzi/58YZ
        9gtsCtumveiyzbtW8+BqX8Fxh3hn9g2PNmuoLLLKWK3569yrF08e3DvezK4nzT2tQj39ll9s
        2NR5uy6cbJe+7fPQRzGFvy6tYJWUEktxRqKhFnNRcSIAowBJcS0EAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5
References: <CGME20230807013726epcms2p1c604cb8e98680aebebb7cc5ab2d580f5@epcms2p1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To ensure that the pci based QEMU ufs device properly works with linux,
register the device id (0x0013) and vendor id (0x1b36) of QEMU ufs device.

QEMU UFS will enable testing of the UFS driver inside a virtual machine
on systems without UFS host controller. It can also be used to preemptively
implement and test new features before the real device is created.

The new qemu ufs device can be found at
https://lore.kernel.org/qemu-devel/20230727155239.GA979354@fedora

Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
---

Since v1:
- Based on Adrian's comment, I modified the commit message to be
  more detailed.

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
