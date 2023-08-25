Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507A7788476
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243379AbjHYKNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243787AbjHYKNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:13:30 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACE92110;
        Fri, 25 Aug 2023 03:13:27 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37PA8TwB019766;
        Fri, 25 Aug 2023 10:12:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : date : subject :
 content-type : message-id : references : in-reply-to : to : cc :
 content-transfer-encoding : mime-version; s=pp1;
 bh=xC8vXlREPf8kLHpO+uYwWDK2EqCGCczaeE2Wup3Ma9c=;
 b=gNmbFyiAvQ2Qp0RFFt4XshUpSje7l6N24KU26LdXNPUbj+wP4C6kIlJ4qDhk61bom7Ze
 NkkZZhNhRPhGFXJwHuXoOyHLXPdHjpv+/K9d+e3CY+dIe26jpwKLvE8q0I6JezvpmmIi
 lql/C1ymJZLEPOu1xVR8Jp4mhvb3hanaW+jki/U3qQeAWLdk4VnHziBQv/+QU7bSr0PY
 JELlVxKNY7aFAiBs5Dhj2Zjn8nKnpdFoIe/XVrtemgGov1VTjwTXhA+nLSV06CXQrkO3
 15wfodblKkGG00l6fQerLkAQLJLvWaXaAWwRuZk4pr/7bAx8ANys1y6s7Tol/v3RxLT6 Iw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spt9h05nc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 10:12:18 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37PA95bt021506;
        Fri, 25 Aug 2023 10:12:17 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3spt9h05km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 10:12:17 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37P7p5SC027375;
        Fri, 25 Aug 2023 10:12:15 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn20sxrmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Aug 2023 10:12:15 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37PACCUp23921288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Aug 2023 10:12:12 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 09A452005A;
        Fri, 25 Aug 2023 10:12:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F66620067;
        Fri, 25 Aug 2023 10:12:10 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 25 Aug 2023 10:12:10 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
Date:   Fri, 25 Aug 2023 12:11:20 +0200
Subject: [PATCH v12 5/6] iommu/dma: Allow a single FQ in addition to
 per-CPU FQs
Content-Type: text/plain; charset="utf-8"
Message-Id: <20230825-dma_iommu-v12-5-4134455994a7@linux.ibm.com>
References: <20230825-dma_iommu-v12-0-4134455994a7@linux.ibm.com>
In-Reply-To: <20230825-dma_iommu-v12-0-4134455994a7@linux.ibm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10915;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=xslKDYkoNUO4JfwG/7C4jAD7KqyQywkHGkbM3dxD7R8=;
 b=owGbwMvMwCH2Wz534YHOJ2GMp9WSGFJe1KU5XRYLfv1/47r19pXtRs4ZR/dc1WGVnx8RXbbl5
 MuEh7fWdZSyMIhxMMiKKbIs6nL2W1cwxXRPUH8HzBxWJpAhDFycAjCR5kaGv5KVAoFHliv+aj1x
 7uvRP+sjBPmsg5SbdWuKgy9nSFtNnMbwP1ytTCZZZOWM3bsCorecFdvf0i21cnOcb2vMes3lV13
 9uAE=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s8wbl8COrQ6SoBPtN3BNTKFu7CC0Jx_D
X-Proofpoint-GUID: iXs8CsJensb2wSdtscU1mfn3znGUxEBb
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-25_07,2023-08-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=896
 bulkscore=0 spamscore=0 adultscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308250087
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some virtualized environments, including s390 paged memory guests,
IOTLB flushes are used to update IOMMU shadow tables. Due to this, they
are much more expensive than in typical bare metal environments or
non-paged s390 guests. In addition they may parallelize poorly in
virtualized environments. This changes the trade off for flushing IOVAs
such that minimizing the number of IOTLB flushes trumps any benefit of
cheaper queuing operations or increased paralellism.

In this scenario per-CPU flush queues pose several problems. Firstly
per-CPU memory is often quite limited prohibiting larger queues.
Secondly collecting IOVAs per-CPU but flushing via a global timeout
reduces the number of IOVAs flushed for each timeout especially on s390
where PCI interrupts may not be bound to a specific CPU.

Let's introduce a single flush queue mode that reuses the same queue
logic but only allocates a single global queue. This mode is selected by
dma-iommu if a newly introduced .shadow_on_flush flag is set in struct
dev_iommu. As a first user the s390 IOMMU driver sets this flag during
probe_device. With the unchanged small FQ size and timeouts this setting
is worse than per-CPU queues but a follow up patch will make the FQ size
and timeout variable. Together this allows the common IOVA flushing code
to more closely resemble the global flush behavior used on s390's
previous internal DMA API implementation.

Link: https://lore.kernel.org/all/9a466109-01c5-96b0-bf03-304123f435ee@arm.com/
Acked-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com> #s390
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/iommu/dma-iommu.c  | 168 ++++++++++++++++++++++++++++++++++-----------
 drivers/iommu/s390-iommu.c |   3 +
 include/linux/iommu.h      |   2 +
 3 files changed, 134 insertions(+), 39 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index e57724163835..09660b0af130 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -43,14 +43,26 @@ enum iommu_dma_cookie_type {
 	IOMMU_DMA_MSI_COOKIE,
 };
 
+enum iommu_dma_queue_type {
+	IOMMU_DMA_OPTS_PER_CPU_QUEUE,
+	IOMMU_DMA_OPTS_SINGLE_QUEUE,
+};
+
+struct iommu_dma_options {
+	enum iommu_dma_queue_type qt;
+};
+
 struct iommu_dma_cookie {
 	enum iommu_dma_cookie_type	type;
 	union {
 		/* Full allocator for IOMMU_DMA_IOVA_COOKIE */
 		struct {
 			struct iova_domain	iovad;
-
-			struct iova_fq __percpu *fq;	/* Flush queue */
+			/* Flush queue */
+			union {
+				struct iova_fq	*single_fq;
+				struct iova_fq	__percpu *percpu_fq;
+			};
 			/* Number of TLB flushes that have been started */
 			atomic64_t		fq_flush_start_cnt;
 			/* Number of TLB flushes that have been finished */
@@ -67,6 +79,8 @@ struct iommu_dma_cookie {
 
 	/* Domain for flush queue callback; NULL if flush queue not in use */
 	struct iommu_domain		*fq_domain;
+	/* Options for dma-iommu use */
+	struct iommu_dma_options	options;
 	struct mutex			mutex;
 };
 
@@ -124,7 +138,7 @@ static inline unsigned int fq_ring_add(struct iova_fq *fq)
 	return idx;
 }
 
-static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
+static void fq_ring_free_locked(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
 {
 	u64 counter = atomic64_read(&cookie->fq_flush_finish_cnt);
 	unsigned int idx;
@@ -145,6 +159,15 @@ static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
 	}
 }
 
+static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_fq *fq)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&fq->lock, flags);
+	fq_ring_free_locked(cookie, fq);
+	spin_unlock_irqrestore(&fq->lock, flags);
+}
+
 static void fq_flush_iotlb(struct iommu_dma_cookie *cookie)
 {
 	atomic64_inc(&cookie->fq_flush_start_cnt);
@@ -160,14 +183,11 @@ static void fq_flush_timeout(struct timer_list *t)
 	atomic_set(&cookie->fq_timer_on, 0);
 	fq_flush_iotlb(cookie);
 
-	for_each_possible_cpu(cpu) {
-		unsigned long flags;
-		struct iova_fq *fq;
-
-		fq = per_cpu_ptr(cookie->fq, cpu);
-		spin_lock_irqsave(&fq->lock, flags);
-		fq_ring_free(cookie, fq);
-		spin_unlock_irqrestore(&fq->lock, flags);
+	if (cookie->options.qt == IOMMU_DMA_OPTS_SINGLE_QUEUE) {
+		fq_ring_free(cookie, cookie->single_fq);
+	} else {
+		for_each_possible_cpu(cpu)
+			fq_ring_free(cookie, per_cpu_ptr(cookie->percpu_fq, cpu));
 	}
 }
 
@@ -188,7 +208,11 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
 	 */
 	smp_mb();
 
-	fq = raw_cpu_ptr(cookie->fq);
+	if (cookie->options.qt == IOMMU_DMA_OPTS_SINGLE_QUEUE)
+		fq = cookie->single_fq;
+	else
+		fq = raw_cpu_ptr(cookie->percpu_fq);
+
 	spin_lock_irqsave(&fq->lock, flags);
 
 	/*
@@ -196,11 +220,11 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
 	 * flushed out on another CPU. This makes the fq_full() check below less
 	 * likely to be true.
 	 */
-	fq_ring_free(cookie, fq);
+	fq_ring_free_locked(cookie, fq);
 
 	if (fq_full(fq)) {
 		fq_flush_iotlb(cookie);
-		fq_ring_free(cookie, fq);
+		fq_ring_free_locked(cookie, fq);
 	}
 
 	idx = fq_ring_add(fq);
@@ -219,31 +243,88 @@ static void queue_iova(struct iommu_dma_cookie *cookie,
 			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
 }
 
-static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
+static void iommu_dma_free_fq_single(struct iova_fq *fq)
+{
+	int idx;
+
+	fq_ring_for_each(idx, fq)
+		put_pages_list(&fq->entries[idx].freelist);
+	vfree(fq);
+}
+
+static void iommu_dma_free_fq_percpu(struct iova_fq __percpu *percpu_fq)
 {
 	int cpu, idx;
 
-	if (!cookie->fq)
-		return;
-
-	del_timer_sync(&cookie->fq_timer);
 	/* The IOVAs will be torn down separately, so just free our queued pages */
 	for_each_possible_cpu(cpu) {
-		struct iova_fq *fq = per_cpu_ptr(cookie->fq, cpu);
+		struct iova_fq *fq = per_cpu_ptr(percpu_fq, cpu);
 
 		fq_ring_for_each(idx, fq)
 			put_pages_list(&fq->entries[idx].freelist);
 	}
 
-	free_percpu(cookie->fq);
+	free_percpu(percpu_fq);
+}
+
+static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
+{
+	if (!cookie->fq_domain)
+		return;
+
+	del_timer_sync(&cookie->fq_timer);
+	if (cookie->options.qt == IOMMU_DMA_OPTS_SINGLE_QUEUE)
+		iommu_dma_free_fq_single(cookie->single_fq);
+	else
+		iommu_dma_free_fq_percpu(cookie->percpu_fq);
+}
+
+static void iommu_dma_init_one_fq(struct iova_fq *fq)
+{
+	int i;
+
+	fq->head = 0;
+	fq->tail = 0;
+
+	spin_lock_init(&fq->lock);
+
+	for (i = 0; i < IOVA_FQ_SIZE; i++)
+		INIT_LIST_HEAD(&fq->entries[i].freelist);
+}
+
+static int iommu_dma_init_fq_single(struct iommu_dma_cookie *cookie)
+{
+	struct iova_fq *queue;
+
+	queue = vmalloc(sizeof(*queue));
+	if (!queue)
+		return -ENOMEM;
+	iommu_dma_init_one_fq(queue);
+	cookie->single_fq = queue;
+
+	return 0;
+}
+
+static int iommu_dma_init_fq_percpu(struct iommu_dma_cookie *cookie)
+{
+	struct iova_fq __percpu *queue;
+	int cpu;
+
+	queue = alloc_percpu(struct iova_fq);
+	if (!queue)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu)
+		iommu_dma_init_one_fq(per_cpu_ptr(queue, cpu));
+	cookie->percpu_fq = queue;
+	return 0;
 }
 
 /* sysfs updates are serialised by the mutex of the group owning @domain */
 int iommu_dma_init_fq(struct iommu_domain *domain)
 {
 	struct iommu_dma_cookie *cookie = domain->iova_cookie;
-	struct iova_fq __percpu *queue;
-	int i, cpu;
+	int rc;
 
 	if (cookie->fq_domain)
 		return 0;
@@ -251,26 +332,16 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
 	atomic64_set(&cookie->fq_flush_start_cnt,  0);
 	atomic64_set(&cookie->fq_flush_finish_cnt, 0);
 
-	queue = alloc_percpu(struct iova_fq);
-	if (!queue) {
+	if (cookie->options.qt == IOMMU_DMA_OPTS_SINGLE_QUEUE)
+		rc = iommu_dma_init_fq_single(cookie);
+	else
+		rc = iommu_dma_init_fq_percpu(cookie);
+
+	if (rc) {
 		pr_warn("iova flush queue initialization failed\n");
 		return -ENOMEM;
 	}
 
-	for_each_possible_cpu(cpu) {
-		struct iova_fq *fq = per_cpu_ptr(queue, cpu);
-
-		fq->head = 0;
-		fq->tail = 0;
-
-		spin_lock_init(&fq->lock);
-
-		for (i = 0; i < IOVA_FQ_SIZE; i++)
-			INIT_LIST_HEAD(&fq->entries[i].freelist);
-	}
-
-	cookie->fq = queue;
-
 	timer_setup(&cookie->fq_timer, fq_flush_timeout, 0);
 	atomic_set(&cookie->fq_timer_on, 0);
 	/*
@@ -554,6 +625,23 @@ static bool dev_use_sg_swiotlb(struct device *dev, struct scatterlist *sg,
 	return false;
 }
 
+/**
+ * iommu_dma_init_options - Initialize dma-iommu options
+ * @options: The options to be initialized
+ * @dev: Device the options are set for
+ *
+ * This allows tuning dma-iommu specific to device properties
+ */
+static void iommu_dma_init_options(struct iommu_dma_options *options,
+				   struct device *dev)
+{
+	/* Shadowing IOTLB flushes do better with a single queue */
+	if (dev->iommu->shadow_on_flush)
+		options->qt = IOMMU_DMA_OPTS_SINGLE_QUEUE;
+	else
+		options->qt = IOMMU_DMA_OPTS_PER_CPU_QUEUE;
+}
+
 /**
  * iommu_dma_init_domain - Initialise a DMA mapping domain
  * @domain: IOMMU domain previously prepared by iommu_get_dma_cookie()
@@ -614,6 +702,8 @@ static int iommu_dma_init_domain(struct iommu_domain *domain, dma_addr_t base,
 	if (ret)
 		goto done_unlock;
 
+	iommu_dma_init_options(&cookie->options, dev);
+
 	/* If the FQ fails we can simply fall back to strict mode */
 	if (domain->type == IOMMU_DOMAIN_DMA_FQ &&
 	    (!device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH) || iommu_dma_init_fq(domain)))
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 8310180a102c..14e0c0b72630 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -470,6 +470,9 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 	if (zdev->end_dma > ZPCI_TABLE_SIZE_RT - 1)
 		zdev->end_dma = ZPCI_TABLE_SIZE_RT - 1;
 
+	if (zdev->tlb_refresh)
+		dev->iommu->shadow_on_flush = 1;
+
 	return &zdev->iommu_dev;
 }
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 182cc4c71e62..c3687e066ed7 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -409,6 +409,7 @@ struct iommu_fault_param {
  * @priv:	 IOMMU Driver private data
  * @max_pasids:  number of PASIDs this device can consume
  * @attach_deferred: the dma domain attachment is deferred
+ * @shadow_on_flush: IOTLB flushes are used to sync shadow tables
  *
  * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
  *	struct iommu_group	*iommu_group;
@@ -422,6 +423,7 @@ struct dev_iommu {
 	void				*priv;
 	u32				max_pasids;
 	u32				attach_deferred:1;
+	u32				shadow_on_flush:1;
 };
 
 int iommu_device_register(struct iommu_device *iommu,

-- 
2.39.2

