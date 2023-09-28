Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 400317B1FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:35:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjI1OfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjI1OfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:35:20 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1D51A3;
        Thu, 28 Sep 2023 07:35:17 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38SEQvj4026394;
        Thu, 28 Sep 2023 14:34:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 mime-version : content-type : content-transfer-encoding : message-id :
 references : in-reply-to : to : cc; s=pp1;
 bh=2I111I2XpXkxCUT37V2rlUQw05m83jbwTSNuVd6sgAI=;
 b=spa6ARS31wCm3iHgvQmN4mZyOfa2lxd9ngL4+pdyLt2Sq077WZPSyk5PtN9aRa18v7SL
 lzUhbMEsVy7Jv/HmawBCzeoJqxVPU3Z6Xt0NYBK9yGoVg4T/szkgaLhmDPKQqxcoGxW0
 dBVb6slLqbzhF4/8/fwtnxxbgPF4Hi+bXOSl6kNvIu+kbMHpi07myHJ30ene+bHxBjK7
 L4sUybbkoAl5CF1SY8gMT9krkEAuTj3J6J0PjnlFuPy2BptWw4TwFc1JDAXyWPPDbQ7d
 spMN9mNKlY4JoSmLSnpBqGWLmnBUHb4+60Mrmgt6/QeYCPH08BU4j4jP0AgKPXeMptUH nA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td9we2u1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 14:34:42 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38SEH3gP023658;
        Thu, 28 Sep 2023 14:32:54 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3td9we2tgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 14:32:54 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38SEV6Ze030404;
        Thu, 28 Sep 2023 14:32:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tad224jx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 14:32:36 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38SEWXFP4457196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Sep 2023 14:32:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 37EFC2005A;
        Thu, 28 Sep 2023 14:32:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BF9F2004B;
        Thu, 28 Sep 2023 14:32:32 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 28 Sep 2023 14:32:32 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Thu, 28 Sep 2023 16:31:35 +0200
Subject: [PATCH v13 1/6] iommu: Allow .iotlb_sync_map to fail and handle
 s390's -ENOMEM return
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230928-dma_iommu-v13-1-9e5fc4dacc36@linux.ibm.com>
References: <20230928-dma_iommu-v13-0-9e5fc4dacc36@linux.ibm.com>
In-Reply-To: <20230928-dma_iommu-v13-0-9e5fc4dacc36@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11193;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=ZuyX0iNPU3mOlrBcND3JmvHzZjf4YChi+thm6mQX10I=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFJF+wKkn2sys3nUJsd8j2jOuHn6d8LtZNkvitvKGkw5f
 Ut+Rf/vKGVhEONgkBVTZFnU5ey3rmCK6Z6g/g6YOaxMIEMYuDgFYCIsVxkZrs+VS39g9HK7r+gb
 uctfChKda7MXm8gU9caE6f/79KDhLlCF17elMcp85T/3GT94INn178GyyAOyt2Vu/9BeGCPY/48
 fAA==
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cIGy2F3pWKwiUIJbZ3aYQpcuAJHvrUVZ
X-Proofpoint-ORIG-GUID: RXUM_eK9TR1tnSI0TLVos8v9-3JoJKQO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_13,2023-09-28_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309280126
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On s390 when using a paging hypervisor, .iotlb_sync_map is used to sync
mappings by letting the hypervisor inspect the synced IOVA range and
updating a shadow table. This however means that .iotlb_sync_map can
fail as the hypervisor may run out of resources while doing the sync.
This can be due to the hypervisor being unable to pin guest pages, due
to a limit on mapped addresses such as vfio_iommu_type1.dma_entry_limit
or lack of other resources. Either way such a failure to sync a mapping
should result in a DMA_MAPPING_ERROR.

Now especially when running with batched IOTLB flushes for unmap it may
be that some IOVAs have already been invalidated but not yet synced via
.iotlb_sync_map. Thus if the hypervisor indicates running out of
resources, first do a global flush allowing the hypervisor to free
resources associated with these mappings as well a retry creating the
new mappings and only if that also fails report this error to callers.

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com> # sun50i
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/amd/iommu.c    |  5 +++--
 drivers/iommu/apple-dart.c   |  5 +++--
 drivers/iommu/intel/iommu.c  |  5 +++--
 drivers/iommu/iommu.c        | 20 ++++++++++++++++----
 drivers/iommu/msm_iommu.c    |  5 +++--
 drivers/iommu/mtk_iommu.c    |  5 +++--
 drivers/iommu/s390-iommu.c   | 29 +++++++++++++++++++++++------
 drivers/iommu/sprd-iommu.c   |  5 +++--
 drivers/iommu/sun50i-iommu.c |  6 ++++--
 include/linux/iommu.h        |  4 ++--
 10 files changed, 63 insertions(+), 26 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 95bd7c25ba6f..74229b1607a1 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2233,14 +2233,15 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	return ret;
 }
 
-static void amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
-				     unsigned long iova, size_t size)
+static int amd_iommu_iotlb_sync_map(struct iommu_domain *dom,
+				    unsigned long iova, size_t size)
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	struct io_pgtable_ops *ops = &domain->iop.iop.ops;
 
 	if (ops->map_pages)
 		domain_flush_np_cache(domain, iova, size);
+	return 0;
 }
 
 static int amd_iommu_map_pages(struct iommu_domain *dom, unsigned long iova,
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index 2082081402d3..22880a42ccaa 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -506,10 +506,11 @@ static void apple_dart_iotlb_sync(struct iommu_domain *domain,
 	apple_dart_domain_flush_tlb(to_dart_domain(domain));
 }
 
-static void apple_dart_iotlb_sync_map(struct iommu_domain *domain,
-				      unsigned long iova, size_t size)
+static int apple_dart_iotlb_sync_map(struct iommu_domain *domain,
+				     unsigned long iova, size_t size)
 {
 	apple_dart_domain_flush_tlb(to_dart_domain(domain));
+	return 0;
 }
 
 static phys_addr_t apple_dart_iova_to_phys(struct iommu_domain *domain,
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5db283c17e0d..477937513502 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -4678,8 +4678,8 @@ static bool risky_device(struct pci_dev *pdev)
 	return false;
 }
 
-static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
-				       unsigned long iova, size_t size)
+static int intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
+				      unsigned long iova, size_t size)
 {
 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
 	unsigned long pages = aligned_nrpages(iova, size);
@@ -4689,6 +4689,7 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
 
 	xa_for_each(&dmar_domain->iommu_array, i, info)
 		__mapping_notify_one(info->iommu, dmar_domain, pfn, pages);
+	return 0;
 }
 
 static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 1ecac2b5c54f..1cc9d139c860 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -2585,8 +2585,17 @@ int iommu_map(struct iommu_domain *domain, unsigned long iova,
 		return -EINVAL;
 
 	ret = __iommu_map(domain, iova, paddr, size, prot, gfp);
-	if (ret == 0 && ops->iotlb_sync_map)
-		ops->iotlb_sync_map(domain, iova, size);
+	if (ret == 0 && ops->iotlb_sync_map) {
+		ret = ops->iotlb_sync_map(domain, iova, size);
+		if (ret)
+			goto out_err;
+	}
+
+	return ret;
+
+out_err:
+	/* undo mappings already done */
+	iommu_unmap(domain, iova, size);
 
 	return ret;
 }
@@ -2714,8 +2723,11 @@ ssize_t iommu_map_sg(struct iommu_domain *domain, unsigned long iova,
 			sg = sg_next(sg);
 	}
 
-	if (ops->iotlb_sync_map)
-		ops->iotlb_sync_map(domain, iova, mapped);
+	if (ops->iotlb_sync_map) {
+		ret = ops->iotlb_sync_map(domain, iova, mapped);
+		if (ret)
+			goto out_err;
+	}
 	return mapped;
 
 out_err:
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index a163cee0b724..f86af9815d6f 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -498,12 +498,13 @@ static int msm_iommu_map(struct iommu_domain *domain, unsigned long iova,
 	return ret;
 }
 
-static void msm_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
-			       size_t size)
+static int msm_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
+			      size_t size)
 {
 	struct msm_priv *priv = to_msm_priv(domain);
 
 	__flush_iotlb_range(iova, size, SZ_4K, false, priv);
+	return 0;
 }
 
 static size_t msm_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 19ef50221c93..2d8e95246781 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -837,12 +837,13 @@ static void mtk_iommu_iotlb_sync(struct iommu_domain *domain,
 	mtk_iommu_tlb_flush_range_sync(gather->start, length, dom->bank);
 }
 
-static void mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
-			       size_t size)
+static int mtk_iommu_sync_map(struct iommu_domain *domain, unsigned long iova,
+			      size_t size)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
 
 	mtk_iommu_tlb_flush_range_sync(iova, size, dom->bank);
+	return 0;
 }
 
 static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 5695ad71d60e..560d0957f9be 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -219,6 +219,12 @@ static void s390_iommu_release_device(struct device *dev)
 		__s390_iommu_detach_device(zdev);
 }
 
+static int zpci_refresh_all(struct zpci_dev *zdev)
+{
+	return zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
+				  zdev->end_dma - zdev->start_dma + 1);
+}
+
 static void s390_iommu_flush_iotlb_all(struct iommu_domain *domain)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
@@ -226,8 +232,7 @@ static void s390_iommu_flush_iotlb_all(struct iommu_domain *domain)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
-		zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
-				   zdev->end_dma - zdev->start_dma + 1);
+		zpci_refresh_all(zdev);
 	}
 	rcu_read_unlock();
 }
@@ -251,20 +256,32 @@ static void s390_iommu_iotlb_sync(struct iommu_domain *domain,
 	rcu_read_unlock();
 }
 
-static void s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
-				      unsigned long iova, size_t size)
+static int s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
+				     unsigned long iova, size_t size)
 {
 	struct s390_domain *s390_domain = to_s390_domain(domain);
 	struct zpci_dev *zdev;
+	int ret = 0;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
 		if (!zdev->tlb_refresh)
 			continue;
-		zpci_refresh_trans((u64)zdev->fh << 32,
-				   iova, size);
+		ret = zpci_refresh_trans((u64)zdev->fh << 32,
+					 iova, size);
+		/*
+		 * let the hypervisor discover invalidated entries
+		 * allowing it to free IOVAs and unpin pages
+		 */
+		if (ret == -ENOMEM) {
+			ret = zpci_refresh_all(zdev);
+			if (ret)
+				break;
+		}
 	}
 	rcu_read_unlock();
+
+	return ret;
 }
 
 static int s390_iommu_validate_trans(struct s390_domain *s390_domain,
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index 9c33ea6903f6..2eb9fb46703b 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -341,8 +341,8 @@ static size_t sprd_iommu_unmap(struct iommu_domain *domain, unsigned long iova,
 	return size;
 }
 
-static void sprd_iommu_sync_map(struct iommu_domain *domain,
-				unsigned long iova, size_t size)
+static int sprd_iommu_sync_map(struct iommu_domain *domain,
+			       unsigned long iova, size_t size)
 {
 	struct sprd_iommu_domain *dom = to_sprd_domain(domain);
 	unsigned int reg;
@@ -354,6 +354,7 @@ static void sprd_iommu_sync_map(struct iommu_domain *domain,
 
 	/* clear IOMMU TLB buffer after page table updated */
 	sprd_iommu_write(dom->sdev, reg, 0xffffffff);
+	return 0;
 }
 
 static void sprd_iommu_sync(struct iommu_domain *domain,
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 3c834854eda1..41484a5a399b 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -401,8 +401,8 @@ static void sun50i_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
 }
 
-static void sun50i_iommu_iotlb_sync_map(struct iommu_domain *domain,
-					unsigned long iova, size_t size)
+static int sun50i_iommu_iotlb_sync_map(struct iommu_domain *domain,
+				       unsigned long iova, size_t size)
 {
 	struct sun50i_iommu_domain *sun50i_domain = to_sun50i_domain(domain);
 	struct sun50i_iommu *iommu = sun50i_domain->iommu;
@@ -411,6 +411,8 @@ static void sun50i_iommu_iotlb_sync_map(struct iommu_domain *domain,
 	spin_lock_irqsave(&iommu->iommu_lock, flags);
 	sun50i_iommu_zap_range(iommu, iova, size);
 	spin_unlock_irqrestore(&iommu->iommu_lock, flags);
+
+	return 0;
 }
 
 static void sun50i_iommu_iotlb_sync(struct iommu_domain *domain,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 64bd20142cbe..1eb638752781 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -350,8 +350,8 @@ struct iommu_domain_ops {
 			      struct iommu_iotlb_gather *iotlb_gather);
 
 	void (*flush_iotlb_all)(struct iommu_domain *domain);
-	void (*iotlb_sync_map)(struct iommu_domain *domain, unsigned long iova,
-			       size_t size);
+	int (*iotlb_sync_map)(struct iommu_domain *domain, unsigned long iova,
+			      size_t size);
 	void (*iotlb_sync)(struct iommu_domain *domain,
 			   struct iommu_iotlb_gather *iotlb_gather);
 

-- 
2.39.2

