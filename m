Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31790785A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 16:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbjHWOWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 10:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjHWOWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 10:22:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F55EE47;
        Wed, 23 Aug 2023 07:22:18 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NE8rt8005615;
        Wed, 23 Aug 2023 14:21:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=+TsSWkSYRTaX0WS+tPSk/pBn9LXXJ36HN+j2+umC9iQ=;
 b=afQff/mlbo8kr9ze6PD0tqQVLXw0JyrJMYjc2vTLMs+oEY6t+EtIrSllFCuMF9CC9TNh
 RuyT5tUVSWoryEF9AprJxqDD5H0+iWsdm8S3Fh97OWVy539cN54uYFA3VnRwkH7rSSdA
 wBFUK1YvlrYNhn4ry3HG1r6ImXFxKUGyeRsBFFdUA9+0PVSKkjcADVuVzoE6m7Dlpp0a
 VOcQfSitn5xPqbIlzFp74skmgMJ7tvjx6AaxMAn3zmE3J4rq4ZZsKbs+ntcA84Rcp/fA
 bH1fFigp/sBczhjL1QvhXYXu0q4eRxVJXlARdWZ8zQIbc909HdQBUoz5OU4tzGyi68Re Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snk7v1171-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 14:21:24 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37NEAG6F013425;
        Wed, 23 Aug 2023 14:21:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3snk7v1162-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 14:21:23 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37NCCYkX027348;
        Wed, 23 Aug 2023 14:21:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sn20seyb9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Aug 2023 14:21:20 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37NELHdP21955090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Aug 2023 14:21:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A475D20043;
        Wed, 23 Aug 2023 14:21:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D7BF420040;
        Wed, 23 Aug 2023 14:21:14 +0000 (GMT)
Received: from [9.171.92.225] (unknown [9.171.92.225])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 23 Aug 2023 14:21:14 +0000 (GMT)
Message-ID: <b46210ce00b46ce42b8487e5670cc56b4458031f.camel@linux.ibm.com>
Subject: Re: [PATCH v11 5/6] iommu/dma: Allow a single FQ in addition to
 per-CPU FQs
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
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
        Jonathan Corbet <corbet@lwn.net>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
        linux-doc@vger.kernel.org
Date:   Wed, 23 Aug 2023 16:21:14 +0200
In-Reply-To: <9a466109-01c5-96b0-bf03-304123f435ee@arm.com>
References: <20230717-dma_iommu-v11-0-a7a0b83c355c@linux.ibm.com>
         <20230717-dma_iommu-v11-5-a7a0b83c355c@linux.ibm.com>
         <9a466109-01c5-96b0-bf03-304123f435ee@arm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ey2FPN0jRMPc4eTPWYB6VrcIiIPiosv2
X-Proofpoint-ORIG-GUID: TFGD4evL0UP8ULVcdKt-aUOtpHarBMQh
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-23_09,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=787
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308230128
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-08-18 at 19:16 +0100, Robin Murphy wrote:
> On 2023-07-17 12:00, Niklas Schnelle wrote:
> > In some virtualized environments, including s390 paged memory guests,
> > IOTLB flushes are used to update IOMMU shadow tables. Due to this, they
> > are much more expensive than in typical bare metal environments or
> > non-paged s390 guests. In addition they may parallelize poorly in
> > virtualized environments. This changes the trade off for flushing IOVAs
> > such that minimizing the number of IOTLB flushes trumps any benefit of
> > cheaper queuing operations or increased paralellism.
> >=20
> > In this scenario per-CPU flush queues pose several problems. Firstly
> > per-CPU memory is often quite limited prohibiting larger queues.
> > Secondly collecting IOVAs per-CPU but flushing via a global timeout
> > reduces the number of IOVAs flushed for each timeout especially on s390
> > where PCI interrupts may not be bound to a specific CPU.
> >=20
> > Let's introduce a single flush queue mode that reuses the same queue
> > logic but only allocates a single global queue. This mode is selected by
> > dma-iommu if a newly introduced .shadow_on_flush flag is set in struct
> > dev_iommu. As a first user the s390 IOMMU driver sets this flag during
> > probe_device. With the unchanged small FQ size and timeouts this setting
> > is worse than per-CPU queues but a follow up patch will make the FQ size
> > and timeout variable. Together this allows the common IOVA flushing code
> > to more closely resemble the global flush behavior used on s390's
> > previous internal DMA API implementation.
> >=20
> > Link: https://lore.kernel.org/linux-iommu/3e402947-61f9-b7e8-1414-fde00=
6257b6f@arm.com/
> > Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com> #s390
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> >   drivers/iommu/dma-iommu.c  | 178 +++++++++++++++++++++++++++++++++---=
---------
> >   drivers/iommu/iommu.c      |  20 +----
>=20
> The hunks in iommu.c appear to be an inadvertent reversion of patch #1?
>=20
> A few bonus nits below which you can take or leave, but otherwise, with=20
> the rebase-mishap fixed:
>=20
> Acked-by: Robin Murphy <robin.murphy@arm.com>
>=20
> >   drivers/iommu/s390-iommu.c |   3 +
> >   include/linux/iommu.h      |   2 +
> >   4 files changed, 142 insertions(+), 61 deletions(-)
> >=20
> > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > index e57724163835..4ada8b9749c9 100644
> > --- a/drivers/iommu/dma-iommu.c
> > +++ b/drivers/iommu/dma-iommu.c
> > @@ -43,14 +43,23 @@ enum iommu_dma_cookie_type {
> >   	IOMMU_DMA_MSI_COOKIE,
> >   };
> >=20=20=20
> > +struct dma_iommu_options {
> > +#define IOMMU_DMA_OPTS_PER_CPU_QUEUE	0L
>=20
> Nit: if the intent is to add more flags then that will no longer make=20
> sense, and if not then we may as well just have a bool ;)
>=20
> > +#define IOMMU_DMA_OPTS_SINGLE_QUEUE	BIT(0)

My thinking was that the above two options are mutually exclusive with
per-CPU encoded as BIT(0) unset and single queue as set. Then other
options could still use the other bits. It's true though that the below
use of IOMMU_DMA_OPTS_PER_CPU_QUEUE is a nop so maybe just drop that?
Or we could use an enum even if I don't forsee more than these 2 queue
types.

> > +	u64	flags;
> > +};
> > +
> >  =C2=A0
---8<---
> >=20=20=20
> > +static void fq_ring_free(struct iommu_dma_cookie *cookie, struct iova_=
fq *fq)
> > +{
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&fq->lock, flags);
> > +	fq_ring_free_locked(cookie, fq);
> > +	spin_unlock_irqrestore(&fq->lock, flags);
> > +}
> > +
> >   static void fq_flush_iotlb(struct iommu_dma_cookie *cookie)
> >   {
> >   	atomic64_inc(&cookie->fq_flush_start_cnt);
> > @@ -152,23 +172,29 @@ static void fq_flush_iotlb(struct iommu_dma_cooki=
e *cookie)
> >   	atomic64_inc(&cookie->fq_flush_finish_cnt);
> >   }
> >=20=20=20
> > +static void fq_flush_percpu(struct iommu_dma_cookie *cookie)
> > +{
> > +	int cpu;
> > +
> > +	for_each_possible_cpu(cpu) {
> > +		struct iova_fq *fq;
> > +
> > +		fq =3D per_cpu_ptr(cookie->percpu_fq, cpu);
> > +		fq_ring_free(cookie, fq);
> > +	}
> > +}
> > +
> >   static void fq_flush_timeout(struct timer_list *t)
> >   {
> >   	struct iommu_dma_cookie *cookie =3D from_timer(cookie, t, fq_timer);
> > -	int cpu;
> >=20=20=20
> >   	atomic_set(&cookie->fq_timer_on, 0);
> >   	fq_flush_iotlb(cookie);
> >=20=20=20
> > -	for_each_possible_cpu(cpu) {
> > -		unsigned long flags;
> > -		struct iova_fq *fq;
> > -
> > -		fq =3D per_cpu_ptr(cookie->fq, cpu);
> > -		spin_lock_irqsave(&fq->lock, flags);
> > -		fq_ring_free(cookie, fq);
> > -		spin_unlock_irqrestore(&fq->lock, flags);
> > -	}
> > +	if (cookie->options.flags & IOMMU_DMA_OPTS_SINGLE_QUEUE)
> > +		fq_ring_free(cookie, cookie->single_fq);
> > +	else
> > +		fq_flush_percpu(cookie);
>=20
> Nit: honestly I'd just inline that as:
>=20
> 	else for_each_possible_cpu(cpu)
> 		fq_ring_free(cookie, per_cpu_ptr(cookie->percpu_fq, cpu));
>=20
> (possibly with extra braces if you don't feel brave enough to join the=20
> elite "else for" club...)

I might but it looks like checkpatch.pl isn't a fan:
...
ERROR: trailing statements should be on next line
#119: FILE: drivers/iommu/dma-iommu.c:185:
+       else for_each_possible_cpu(cpu)

So braces it is.

>=20
> >   }
> >=20=20=20
> >   static void queue_iova(struct iommu_dma_cookie *cookie,
> > @@ -188,7 +214,11 @@ static void queue_iova(struct iommu_dma_cookie *co=
okie,
> >   	 */
> >   	smp_mb();
> >=20=20=20
> > -	fq =3D raw_cpu_ptr(cookie->fq);
> > +	if (cookie->options.flags & IOMMU_DMA_OPTS_SINGLE_QUEUE)
> > +		fq =3D cookie->single_fq;
> > +	else
> > +		fq =3D raw_cpu_ptr(cookie->percpu_fq);
> > +
> >   	spin_lock_irqsave(&fq->lock, flags);
> >=20=20=20
> >   	/*
> > @@ -196,11 +226,11 @@ static void queue_iova(struct iommu_dma_cookie *c=
ookie,
> >   	 * flushed out on another CPU. This makes the fq_full() check below =
less
> >   	 * likely to be true.
> >   	 */
> > -	fq_ring_free(cookie, fq);
> > +	fq_ring_free_locked(cookie, fq);
> >=20=20=20
> >   	if (fq_full(fq)) {
> >   		fq_flush_iotlb(cookie);
> > -		fq_ring_free(cookie, fq);
> > +		fq_ring_free_locked(cookie, fq);
> >   	}
> >=20=20=20
> >   	idx =3D fq_ring_add(fq);
> > @@ -219,31 +249,90 @@ static void queue_iova(struct iommu_dma_cookie *c=
ookie,
> >   			  jiffies + msecs_to_jiffies(IOVA_FQ_TIMEOUT));
> >   }
> >=20=20=20
> > -static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
> > +static void iommu_dma_free_fq_single(struct iova_fq *fq)
> > +{
> > +	int idx;
> > +
> > +	if (!fq)
> > +		return;
>=20
> Nit: That should never be true if cookie->fq_domain was set

True and the _percpu variant doesn't check it either so will drop.

>=20
> > +	fq_ring_for_each(idx, fq)
> > +		put_pages_list(&fq->entries[idx].freelist);
> > +	vfree(fq);
> > +}
> > +
> > +static void iommu_dma_free_fq_percpu(struct iova_fq __percpu *percpu_f=
q)
> >   {
> >   	int cpu, idx;
> >=20=20=20
> > -	if (!cookie->fq)
> > -		return;
> > -
> > -	del_timer_sync(&cookie->fq_timer);
> >   	/* The IOVAs will be torn down separately, so just free our queued p=
ages */
> >   	for_each_possible_cpu(cpu) {
> > -		struct iova_fq *fq =3D per_cpu_ptr(cookie->fq, cpu);
> > +		struct iova_fq *fq =3D per_cpu_ptr(percpu_fq, cpu);
> >=20=20=20
> >   		fq_ring_for_each(idx, fq)
> >   			put_pages_list(&fq->entries[idx].freelist);
> >   	}
> >=20=20=20
> > -	free_percpu(cookie->fq);
> > +	free_percpu(percpu_fq);
> > +}
> > +
> > +static void iommu_dma_free_fq(struct iommu_dma_cookie *cookie)
> > +{
> > +	if (!cookie->fq_domain)
> > +		return;
> > +
> > +	del_timer_sync(&cookie->fq_timer);
> > +	if (cookie->options.flags & IOMMU_DMA_OPTS_SINGLE_QUEUE)
> > +		iommu_dma_free_fq_single(cookie->single_fq);
> > +	else
> > +		iommu_dma_free_fq_percpu(cookie->percpu_fq);
> > +}
> > +
> > +static void iommu_dma_init_one_fq(struct iova_fq *fq)
> > +{
> > +	int i;
> > +
> > +	fq->head =3D 0;
> > +	fq->tail =3D 0;
> > +
> > +	spin_lock_init(&fq->lock);
> > +
> > +	for (i =3D 0; i < IOVA_FQ_SIZE; i++)
> > +		INIT_LIST_HEAD(&fq->entries[i].freelist);
> > +}
> > +
> > +static int iommu_dma_init_fq_single(struct iommu_dma_cookie *cookie)
> > +{
> > +	struct iova_fq *queue;
> > +
> > +	queue =3D vzalloc(sizeof(*queue));
>=20
> Nit: vmalloc() - no need to zero the whole thing when the percpu path=20
> doesn't.

Done

>=20
> > +	if (!queue)
> > +		return -ENOMEM;
> > +	iommu_dma_init_one_fq(queue);
> > +	cookie->single_fq =3D queue;
> > +
> > +	return 0;
> > +}
> > +
> > +static int iommu_dma_init_fq_percpu(struct iommu_dma_cookie *cookie)
> > +{
> > +	struct iova_fq __percpu *queue;
> > +	int cpu;
> > +
> > +	queue =3D alloc_percpu(struct iova_fq);
> > +	if (!queue)
> > +		return -ENOMEM;
> > +
> > +	for_each_possible_cpu(cpu)
> > +		iommu_dma_init_one_fq(per_cpu_ptr(queue, cpu));
> > +	cookie->percpu_fq =3D queue;
> > +	return 0;
> >   }
> >=20=20=20
> >   /* sysfs updates are serialised by the mutex of the group owning @dom=
ain */
> >   int iommu_dma_init_fq(struct iommu_domain *domain)
> >   {
> >   	struct iommu_dma_cookie *cookie =3D domain->iova_cookie;
> > -	struct iova_fq __percpu *queue;
> > -	int i, cpu;
> > +	int rc;
> >=20=20=20
> >   	if (cookie->fq_domain)
> >   		return 0;
> > @@ -251,26 +340,16 @@ int iommu_dma_init_fq(struct iommu_domain *domain)
> >   	atomic64_set(&cookie->fq_flush_start_cnt,  0);
> >   	atomic64_set(&cookie->fq_flush_finish_cnt, 0);
> >=20=20=20
> > -	queue =3D alloc_percpu(struct iova_fq);
> > -	if (!queue) {
> > +	if (cookie->options.flags & IOMMU_DMA_OPTS_SINGLE_QUEUE)
> > +		rc =3D iommu_dma_init_fq_single(cookie);
> > +	else
> > +		rc =3D iommu_dma_init_fq_percpu(cookie);
> > +
> > +	if (rc) {
> >   		pr_warn("iova flush queue initialization failed\n");
> >   		return -ENOMEM;
> >   	}
> >=20=20=20
> > -	for_each_possible_cpu(cpu) {
> > -		struct iova_fq *fq =3D per_cpu_ptr(queue, cpu);
> > -
> > -		fq->head =3D 0;
> > -		fq->tail =3D 0;
> > -
> > -		spin_lock_init(&fq->lock);
> > -
> > -		for (i =3D 0; i < IOVA_FQ_SIZE; i++)
> > -			INIT_LIST_HEAD(&fq->entries[i].freelist);
> > -	}
> > -
> > -	cookie->fq =3D queue;
> > -
> >   	timer_setup(&cookie->fq_timer, fq_flush_timeout, 0);
> >   	atomic_set(&cookie->fq_timer_on, 0);
> >   	/*
> > @@ -297,6 +376,7 @@ static struct iommu_dma_cookie *cookie_alloc(enum i=
ommu_dma_cookie_type type)
> >   	if (cookie) {
> >   		INIT_LIST_HEAD(&cookie->msi_page_list);
> >   		cookie->type =3D type;
> > +		cookie->options.flags =3D IOMMU_DMA_OPTS_PER_CPU_QUEUE;
>=20
> You see, this confused me into thinking it does something and I had to=20
> go back and check ;)

I have no real preference we can drop it, make it an enum, a bool or
keep it. I felt like this explicit assignment documented per-CPU as the
default so see my variant below but yes it does nothing since the
cookie was already kzalloced.
>=20
> >   	}
> >   	return cookie;
> >   }
> > @@ -614,10 +694,18 @@ static int iommu_dma_init_domain(struct iommu_dom=
ain *domain, dma_addr_t base,
> >   	if (ret)
> >   		goto done_unlock;
> >=20=20=20
> > -	/* If the FQ fails we can simply fall back to strict mode */
> > -	if (domain->type =3D=3D IOMMU_DOMAIN_DMA_FQ &&
> > -	    (!device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH) || iommu_dm=
a_init_fq(domain)))
> > -		domain->type =3D IOMMU_DOMAIN_DMA;
> > +	if (domain->type =3D=3D IOMMU_DOMAIN_DMA_FQ) {
> > +		/* Expensive shadowing IOTLB flushes require some tuning */
> > +		if (dev->iommu->shadow_on_flush)
> > +			cookie->options.flags |=3D IOMMU_DMA_OPTS_SINGLE_QUEUE;
>=20
> It would probably be better to set this regardless of the domain type,=20
> in case the FQ is only brought up later via sysfs.
>=20
> > +
> > +		/* If the FQ fails we can simply fall back to strict mode */
> > +		if (!device_iommu_capable(dev, IOMMU_CAP_DEFERRED_FLUSH) ||
> > +		    iommu_dma_init_fq(domain)) {
> > +			domain->type =3D IOMMU_DOMAIN_DMA;
> > +			cookie->options.flags &=3D ~IOMMU_DMA_OPTS_SINGLE_QUEUE;
>=20
> ...and either way there should be no need to clear it again - if it was=20
> true once it will always be true.
>=20
> Cheers,
> Robin.
>=20

I'm now experimenting with an iommu_dma_init_options() helper that gets
called from the main path of iommu_dma_init() here is how it looks like
at the end:

static void iommu_dma_init_options(struct iommu_dma_options *options, struc=
t device *dev)
{
	/* Expensive shadowing IOTLB flushes do better with a single large queue */
	if (dev->iommu->shadow_on_flush) {
		options->flags =3D IOMMU_DMA_OPTS_SINGLE_QUEUE;
		options->fq_timeout =3D IOVA_SINGLE_FQ_TIMEOUT;
		options->fq_size =3D IOVA_SINGLE_FQ_SIZE;
	} else {
		options->flags =3D IOMMU_DMA_OPTS_PER_CPU_QUEUE;
		options->fq_size =3D IOVA_DEFAULT_FQ_SIZE;
		options->fq_timeout =3D IOVA_DEFAULT_FQ_TIMEOUT;
	}
}

Also I noticed that my options struct used the prefix "dma_iommu_"
while everything else is "iommu_dma_" so that got fixed too.

> > +		}
> > +	}
> >=20=20=20
> >   	ret =3D iova_reserve_iommu_regions(dev, domain);
> >=20=20=20
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index fd9f79731d6a..caaf563d38ae 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -2413,17 +2413,8 @@ int iommu_map(struct iommu_domain *domain, unsig=
ned long iova,
> >   		return -EINVAL;
> >=20=20=20
> >   	ret =3D __iommu_map(domain, iova, paddr, size, prot, gfp);
> > -	if (ret =3D=3D 0 && ops->iotlb_sync_map) {
> > -		ret =3D ops->iotlb_sync_map(domain, iova, size);
> > -		if (ret)
> > -			goto out_err;
> > -	}
> > -
> > -	return ret;
> > -
> > -out_err:
> > -	/* undo mappings already done */
> > -	iommu_unmap(domain, iova, size);
> > +	if (ret =3D=3D 0 && ops->iotlb_sync_map)
> > +		ops->iotlb_sync_map(domain, iova, size);
> >=20=20=20
> >   	return ret;
> >   }
> > @@ -2564,11 +2555,8 @@ ssize_t iommu_map_sg(struct iommu_domain *domain=
, unsigned long iova,
> >   			sg =3D sg_next(sg);
> >   	}
> >=20=20=20
> > -	if (ops->iotlb_sync_map) {
> > -		ret =3D ops->iotlb_sync_map(domain, iova, mapped);
> > -		if (ret)
> > -			goto out_err;
> > -	}
> > +	if (ops->iotlb_sync_map)
> > +		ops->iotlb_sync_map(domain, iova, mapped);
> >   	return mapped;

Good find that is indeed a rebase mishap ;-(

> >=20=20=20
> >   out_err:
> > diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> > index 020cc538e4c4..63c56a440c9d 100644
> > --- a/drivers/iommu/s390-iommu.c
> > +++ b/drivers/iommu/s390-iommu.c
> > @@ -468,6 +468,9 @@ static struct iommu_device *s390_iommu_probe_device=
(struct device *dev)
> >   	if (zdev->end_dma > ZPCI_TABLE_SIZE_RT - 1)
> >   		zdev->end_dma =3D ZPCI_TABLE_SIZE_RT - 1;
> >=20=20=20
> > +	if (zdev->tlb_refresh)
> > +		dev->iommu->shadow_on_flush =3D 1;
> > +
> >   	return &zdev->iommu_dev;
> >   }
> >=20=20=20
> > diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> > index 182cc4c71e62..c3687e066ed7 100644
> > --- a/include/linux/iommu.h
> > +++ b/include/linux/iommu.h
> > @@ -409,6 +409,7 @@ struct iommu_fault_param {
> >    * @priv:	 IOMMU Driver private data
> >    * @max_pasids:  number of PASIDs this device can consume
> >    * @attach_deferred: the dma domain attachment is deferred
> > + * @shadow_on_flush: IOTLB flushes are used to sync shadow tables
> >    *
> >    * TODO: migrate other per device data pointers under iommu_dev_data,=
 e.g.
> >    *	struct iommu_group	*iommu_group;
> > @@ -422,6 +423,7 @@ struct dev_iommu {
> >   	void				*priv;
> >   	u32				max_pasids;
> >   	u32				attach_deferred:1;
> > +	u32				shadow_on_flush:1;
> >   };
> >=20=20=20
> >   int iommu_device_register(struct iommu_device *iommu,
> >=20

