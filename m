Return-Path: <linux-kernel+bounces-99519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B99AB87898F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696B92818D0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DEA433CC;
	Mon, 11 Mar 2024 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="YokwowUm"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018851DDFA;
	Mon, 11 Mar 2024 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189598; cv=none; b=Y+Nymw6y99Cz+O2GUj0apEHdX/hAVAkjPYseGrIUP4e4t3QhhgweeprQtB/fs+G4vZKCx464gf7TYYIgRUJLBH/i5NxGbjTDm1H3pZil3cG8cHVWH7Wb2iDkncdexbWaUIDAZ7Q0RRtspMqEGwK2K66mcUoUK0mPqb8NTdLgb9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189598; c=relaxed/simple;
	bh=GLRH/ff873bHDZ3G/dS9FCmtnVNAdEXsgR2369HqHu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7bka5ew7eATEo1AXzAdl4idZOSjPjRoXuD7KdZ5BxQJEwM7wzc0N+oA4ggWZDGrLzsOF4ALIFw7TEw1uhRZA9AGChhbnR6wZ+Lw71koJ5E1WqK4NW2ACfLOdZMgAIQLjyDyqc6pOu+sBTR3wts3Vq0iqSo6kHpnXfKo5Ah9DBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=YokwowUm; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42BKZXCq023964;
	Mon, 11 Mar 2024 20:39:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=bG9zvg+KT7rDf9tdsNZ9Pa4BjTW2/RgQhqLVC2YoX5o=;
 b=YokwowUmIu0MFrRelHcvOUvw7m4+JyxXX5gblyRsenvtI6spiguzX2Q5apWeEb7qQrIA
 9t5ytlj0bcUIKHPH0UDNH1n+VxDGzdafeR4gVPGd6voBz9C3VbXNG3sniueYDaiKX376
 GE4XbyckKqDTGDbhCL6YfZqrqgRenR3ngsZf2nbxj5bl2AHEW1WxYKYBF2dLNnVcN0l5
 gbUL6Yr5T/9f9PBotIWSsTvlMpTpXHStfKF7KEQHxOeaogm2InewH8crQCkCZh/eaTRO
 46VxHFHBtJPflWYA3tOSnlv3uGt9wjLxLjUMJzmjCUsdnH4n1zb0ATa6Vx7UNJ/EERAf VA== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3wsy5mcvdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 20:39:14 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 78C1B8005C8;
	Mon, 11 Mar 2024 20:39:03 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 981658033F2;
	Mon, 11 Mar 2024 20:39:01 +0000 (UTC)
Date: Mon, 11 Mar 2024 15:38:59 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        Dimitri Sivanich <sivanich@hpe.com>
Subject: Re: [PATCH] Allocate DMAR fault interrupts locally
Message-ID: <Ze9r47riIq9ovBCY@hpe.com>
References: <ZeDj/LK56borSxO4@hpe.com>
 <87plwe7w3m.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plwe7w3m.ffs@tglx>
X-Proofpoint-ORIG-GUID: ot8_frxBggv2_ZPl4NxLJUxCiusslAmV
X-Proofpoint-GUID: ot8_frxBggv2_ZPl4NxLJUxCiusslAmV
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_11,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 mlxlogscore=798 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403110158

Thomas!

On Thu, Feb 29, 2024 at 11:18:37PM +0100, Thomas Gleixner wrote:
> Dimitri!
> 
> On Thu, Feb 29 2024 at 14:07, Dimitri Sivanich wrote:
> 
> > +}
> > +
> > +static int __init assign_dmar_vectors(void)
> > +{
> > +	struct work_struct irq_remap_work;
> > +	int nid;
> > +
> > +	INIT_WORK(&irq_remap_work, irq_remap_enable_fault_handling_thr);
> > +	cpus_read_lock();
> > +	for_each_online_node(nid) {
> > +		/* Boot cpu dmar vectors are assigned before the rest */
> > +		if (nid == cpu_to_node(get_boot_cpu_id()))
> > +			continue;
> > +		schedule_work_on(cpumask_first(cpumask_of_node(nid)),
> > +				 &irq_remap_work);
> > +		flush_work(&irq_remap_work);
> > +	}
> > +	cpus_read_unlock();
> > +	return 0;
> > +}
> > +
> > +arch_initcall(assign_dmar_vectors);
> 
> Stray newline before arch_initcall(), but that's not the problem.
> 
> The real problems are:
> 
>  1) This approach only works when _ALL_ APs have been brought up during
>     boot. With 'maxcpus=N' on the command line this will fail to enable
>     fault handling when the APs which have not been brought up initially
>     are onlined later on.
> 
>     This might be working in practice because intel_iommu_init() will
>     enable the interrupts later on via init_dmars() unconditionally, but
>     that's far from correct because IRQ_REMAP does not depend on
>     INTEL_IOMMU.
> 
>  2) It leaves a gap where the reporting is not working between bringing
>     up the APs during boot and this initcall. Mostly theoretical, but
>     that does not make it more correct either.
> 
> What you really want is a cpu hotplug state in the CPUHP_BP_PREPARE_DYN
> space which enables the interrupt for the node _before_ the first AP of
> the node is brought up. That will solve the problem nicely w/o any of
> the above issues.
>

Initially this sounds like a good approach.  As things currently stand, however,
there are (at least) several problems with attempting to allocate interrupts on
cpus that are not running yet via the existing dmar_set_interrupt path.

- The code relies on node_to_cpumask_map (cpumask_of_node()), which has been
  allocated, but not populated at the CPUHP_BP_PREPARE_DYN stage.

- The irq_matrix cpumaps do not indicate being online or initialized yet, except
  for the boot cpu instance, of course.

So things still revert to boot cpu allocation, until we exhaust the vectors.

Of course, running the dmar_set_interrupt code from a CPUHP_AP_ONLINE_DYN state
does work (although I believe there is a concurrency issue that could show up
with the current dmar_set_interrupt path).

So the code seems to have been designed based on the assumption that it will be
run on an already active (though not necessarily fully onlined?) cpu.  To make
this work, any code based on that assumption would need to be fixed.  Otherwise,
a different approach is needed.


