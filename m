Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5F575611E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjGQLEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjGQLD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:03:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4318CE48;
        Mon, 17 Jul 2023 04:03:55 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HAxmgZ009203;
        Mon, 17 Jul 2023 11:02:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 mime-version : content-type : content-transfer-encoding : message-id :
 references : in-reply-to : to : cc; s=pp1;
 bh=rodPNwLfHsIuiQQiFeOVrCe92jgLqk9u0QoV1c2yRD8=;
 b=eNfUOHXfJaJXaRoNwaHjlPVS/K2Y8/vkANub8lEhUs/4g4SXxhM/gzCmcsBd7uGdHA5a
 c+Eebgpny4qGFgK8aCPGws0Q/SNAzZ5XBas3dNqrt0CQtS/Rin0NCfollQzj4/u+Aelg
 s+7PtBfqRlX0G3bCyi7P92cmJBA+m1F0yfxmxEa/89wi8N6qfkm96MLwX20mH6fMj6hQ
 F+BAm6cOrY7zRuAI+zAUX1II7sDlr2YraiAEGLfLPD3sVCd63hz2he79B94LW6dKr9XV
 Vr4PJJsmpKS/G6pmVIaroju9zu6XxLc33pBDav7W3u+MnKB9ib/uyGkEG6LOFfmWksuL 9Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw4cfr1ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 11:01:57 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36HB0EDX010721;
        Mon, 17 Jul 2023 11:01:56 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw4cfr1e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 11:01:56 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36H8eKcN029165;
        Mon, 17 Jul 2023 11:01:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv6sma11s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 11:01:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36HB1q1m43450626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 11:01:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7210620040;
        Mon, 17 Jul 2023 11:01:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEDBE2004E;
        Mon, 17 Jul 2023 11:01:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jul 2023 11:01:50 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Mon, 17 Jul 2023 13:00:02 +0200
Subject: [PATCH v11 2/6] s390/pci: prepare is_passed_through() for
 dma-iommu
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-dma_iommu-v11-2-a7a0b83c355c@linux.ibm.com>
References: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
In-Reply-To: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krishna Reddy <vdumpa@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-doc@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1902;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=JnpBPtIA02SvkModRZiVKujLXSYwAXU0tTNoKrRKqJY=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFK2ylcain7WL7vDYWd8e5Icb8PJnIdrJ72pYrnPsmXvi
 ik20rzbO0pZGMQ4GGTFFFkWdTn7rSuYYronqL8DZg4rE8gQBi5OAZjI21CG/77Tf2s9t93BnM/8
 fpXS4zNrbomEb4+RdchIlv+RE7DozW1Ghk+LHHtlBRrPJQm9M/F7xaCg3qCYtfTdB02BFd1Hv1t
 M4gcA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S0-0YKVib5tVkn7NbYXusLYxJcxSKIMA
X-Proofpoint-GUID: fIzrsUpVE5xoolfH4r9boa0N3zGQbhpC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the IOMMU always controlled through the IOMMU driver testing for
zdev->s390_domain is not a valid indication of the device being
passed-through. Instead test if zdev->kzdev is set.

Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_event.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index b9324ca2eb94..4ef5a6a1d618 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -59,9 +59,16 @@ static inline bool ers_result_indicates_abort(pci_ers_result_t ers_res)
 	}
 }
 
-static bool is_passed_through(struct zpci_dev *zdev)
+static bool is_passed_through(struct pci_dev *pdev)
 {
-	return zdev->s390_domain;
+	struct zpci_dev *zdev = to_zpci(pdev);
+	bool ret;
+
+	mutex_lock(&zdev->kzdev_lock);
+	ret = !!zdev->kzdev;
+	mutex_unlock(&zdev->kzdev_lock);
+
+	return ret;
 }
 
 static bool is_driver_supported(struct pci_driver *driver)
@@ -176,7 +183,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	}
 	pdev->error_state = pci_channel_io_frozen;
 
-	if (is_passed_through(to_zpci(pdev))) {
+	if (is_passed_through(pdev)) {
 		pr_info("%s: Cannot be recovered in the host because it is a pass-through device\n",
 			pci_name(pdev));
 		goto out_unlock;
@@ -239,7 +246,7 @@ static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_state_t es)
 	 * we will inject the error event and let the guest recover the device
 	 * itself.
 	 */
-	if (is_passed_through(to_zpci(pdev)))
+	if (is_passed_through(pdev))
 		goto out;
 	driver = to_pci_driver(pdev->dev.driver);
 	if (driver && driver->err_handler && driver->err_handler->error_detected)

-- 
2.39.2

