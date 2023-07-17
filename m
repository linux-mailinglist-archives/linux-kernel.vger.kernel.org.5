Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD56756137
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjGQLGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjGQLGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:06:48 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E65BE60;
        Mon, 17 Jul 2023 04:06:47 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36HAc6uM014864;
        Mon, 17 Jul 2023 11:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 mime-version : content-type : content-transfer-encoding : message-id :
 references : in-reply-to : to : cc; s=pp1;
 bh=EX/6hVz2CujAtR1r5Y/AslWL4cUFBwOYRD2kfq1Ey1A=;
 b=TFZoQvQ6D/Dz4Te5TzLXPM/F4iwfeirwVRcK98lhKd/EQselSQrY/dEiYk8H7u4xJR5p
 jyAKsuKgdRdJYBZtPM2kN/Ddv8bvxX1OSjYHaxRWK4qUX6GaZ+QUuwr5//Y2HUH3OkZC
 Uax3ju0kNujUWIRmss+y6kS8M8G7u9tBylBjndoY4XZlFTZMH+/sHJqfeB0ZIjY4HnEe
 bZ8iko5w3xYPc+dKcA5zfEv/JR0Icsk/vyybkpxEDfp7+GzxIEsiu5j1vw+7BkSSFujS
 GuiXIdHRn4WMJoWGjhlHHhvfm6kTIoIodliDAaFde2oXI1iguliYQck+OWmwTQK4lf2R DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw2mvav5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 11:06:17 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36HB5vuN004432;
        Mon, 17 Jul 2023 11:06:16 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rw2mvaun6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 11:06:16 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36H7CsvJ001927;
        Mon, 17 Jul 2023 11:01:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3rujqdrvw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Jul 2023 11:01:59 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36HB1t3248759112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 17 Jul 2023 11:01:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A394720040;
        Mon, 17 Jul 2023 11:01:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B4502004B;
        Mon, 17 Jul 2023 11:01:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 17 Jul 2023 11:01:54 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Mon, 17 Jul 2023 13:00:04 +0200
Subject: [PATCH v11 4/6] iommu/s390: Force ISM devices to use
 IOMMU_DOMAIN_DMA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230717-dma_iommu-v11-4-a7a0b83c355c@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2241;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=WAlj34+VdZ4BOi3XhdVz9KJFyWimR6Dba6hbnVhR52M=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFK2yrdzb+B+otbM8X7TXXP+KyoWT9u2/ju4y3rbA/9gw
 +1v9/GpdJSyMIhxMMiKKbIs6nL2W1cwxXRPUH8HzBxWJpAhDFycAjCRN7YMf0U29UYWTPl1v0iw
 crNS08or1Wai32Jy5P+GG53sW3hu4w5Ghj2xy36W+kw/usvOWziN4wuD+L+1H+cm9X46NWlyVtB
 NKQ4A
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9Xc-w6UZKWeAM5AdDbALxCVl53PAo-zr
X-Proofpoint-GUID: meJ_G7MRirR9QpT9QiDGkdjDlf6Zfw5u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-17_09,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307170100
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ISM devices are virtual PCI devices used for cross-LPAR communication.
Unlike real PCI devices ISM devices do not use the hardware IOMMU but
inspects IOMMU translation tables directly on IOTLB flush (s390 RPCIT
instruction).

While ISM devices keep their DMA allocations static and only very rarely
DMA unmap at all, For each IOTLB flush that occurs after unmap the ISM
devices will inspect the area of the IOVA space indicated by the flush.
This means that for the global IOTLB flushes used by the flush queue
mechanism the entire IOVA space would be inspected. In principle this
would be fine, albeit potentially unnecessarily slow, it turns out
however that ISM devices are sensitive to seeing IOVA addresses that are
currently in use in the IOVA range being flushed. Seeing such in-use
IOVA addresses will cause the ISM device to enter an error state and
become unusable.

Fix this by forcing IOMMU_DOMAIN_DMA to be used for ISM devices. This
makes sure IOTLB flushes only cover IOVAs that have been unmapped and
also restricts the range of the IOTLB flush potentially reducing latency
spikes.

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index f6d6c60e5634..020cc538e4c4 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -710,6 +710,15 @@ struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
 	return &zdev->s390_domain->ctrs;
 }
 
+static int s390_iommu_def_domain_type(struct device *dev)
+{
+	struct zpci_dev *zdev = to_zpci_dev(dev);
+
+	if (zdev->pft == PCI_FUNC_TYPE_ISM)
+		return IOMMU_DOMAIN_DMA;
+	return 0;
+}
+
 int zpci_init_iommu(struct zpci_dev *zdev)
 {
 	u64 aperture_size;
@@ -789,6 +798,7 @@ static const struct iommu_ops s390_iommu_ops = {
 	.probe_device = s390_iommu_probe_device,
 	.probe_finalize = s390_iommu_probe_finalize,
 	.release_device = s390_iommu_release_device,
+	.def_domain_type = s390_iommu_def_domain_type,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = SZ_4K,
 	.get_resv_regions = s390_iommu_get_resv_regions,

-- 
2.39.2

