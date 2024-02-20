Return-Path: <linux-kernel+bounces-73540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 958E185C3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:46:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DC071F23B89
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876FD146907;
	Tue, 20 Feb 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QOiwOMRf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A43A13341C;
	Tue, 20 Feb 2024 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708454650; cv=none; b=MVWDC4VeKJiRi3JAELHfOVoi/KxFgbT+SMhIOyXkuNiZfwzLFxu27NTVwXpxcUsMp8EmcFALNJwff7du6zP6ZhC7m0ia9VpN8SIrDZGa5bj6Cb8/dwoU83NZZtT6GXfJeF/bWJ1qw90kHXDmJYhA7ziP+Towj0DMIi3XclXPNts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708454650; c=relaxed/simple;
	bh=KhenvHNDgexAuiROx++q4AZqe1P5A2xE8ckk6gox8Zc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h4p5mGqYS+eNEmaT356bN7o8pCyr663z72tBPjdjC+LSrvsURvHaR6QPhkAvWVisjEBi6ErTaYcB0W+XTzoPIc2zWwHVwFiajDj0sXZg8E3HFaDeoQR1+vDqFoRxDv8EeMOYhq8CA+9TQasVpjsCyHBx2zYtDX5l/IwOoDTXlO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QOiwOMRf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KA9es3007125;
	Tue, 20 Feb 2024 18:44:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-transfer-encoding:in-reply-to; s=
	qcppdkim1; bh=faaG5k5O74o2UdBj2s6Qd4mp/M4ncNrT49/eJot18Dw=; b=QO
	iwOMRf4B2Lud5/4fnQj5ftWHsEnOR1JRPfM1HnO/VcQBhc+8tfdyWT2P5I7CVjo0
	X951oBqb+8lCkaTDzncH+482TJdEPyIG8+w+Q75zSduwSNPIbNrD3thNfPngRbsB
	YXT3c2Z2pafzUSlGiTPt2e1mQUPnWT44uq4VidjTbCwuHDwNigJQZMqXMUIkP1fE
	d0ofzCxryjLyAimieJZbe8kaxtaR1g3Si8yNOF20rMH/OjP5v9cA60IUbGFfsBlA
	b6rc4Vaw7mRe89/BTl+ZYzX+6z8nfVphq4rwnAeOAin0U3bbx3R5OeJWZEvldv2p
	Dy0U8zA3SIBW1olrzOeA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wct2sh3j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 18:44:00 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KIi0xt023466
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 18:44:00 GMT
Received: from hu-eberman-lv.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 20 Feb 2024 10:43:59 -0800
Date: Tue, 20 Feb 2024 10:43:59 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: Dibakar Singh <quic_dibasing@quicinc.com>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski@linaro.org>, <luzmaximilian@gmail.com>,
        <bartosz.golaszewski@linaro.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_guptap@quicinc.com>, <quic_pkondeti@quicinc.com>,
        <quic_pheragu@quicinc.com>
Subject: Re: Re: [PATCH] firmware: qcom_scm: Introduce batching of hyp assign
 calls
Message-ID: <20240220103225991-0800.eberman@hu-eberman-lv.qualcomm.com>
Mail-Followup-To: Dibakar Singh <quic_dibasing@quicinc.com>, 
	andersson@kernel.org, konrad.dybcio@linaro.org, krzysztof.kozlowski@linaro.org, 
	luzmaximilian@gmail.com, bartosz.golaszewski@linaro.org, quic_gurus@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, quic_guptap@quicinc.com, 
	quic_pkondeti@quicinc.com, quic_pheragu@quicinc.com
References: <20240209112536.2262967-1-quic_dibasing@quicinc.com>
 <7fhl7uvhl26whumcl3f5hxflczws67lg3yq4gb5fyrig2ziux6@chft6orl6xne>
 <82ad6010-c70f-4d7f-af83-d9be208dc4b0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82ad6010-c70f-4d7f-af83-d9be208dc4b0@quicinc.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: l5fLXiYO34o_UJU-DS95WnxMLlWEabcg
X-Proofpoint-ORIG-GUID: l5fLXiYO34o_UJU-DS95WnxMLlWEabcg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200135

On Tue, Feb 20, 2024 at 11:24:33AM +0530, Dibakar Singh wrote:
> 
> 
> On 09-Feb-24 11:36 PM, Elliot Berman wrote:
> > On Fri, Feb 09, 2024 at 04:55:36PM +0530, Dibakar Singh wrote:
> > > Expose an API qcom_scm_assign_table to allow client drivers to batch
> > > multiple memory regions in a single hyp assign call.
> > > 
> > > In the existing situation, if our goal is to process an sg_table and
> > > transfer its ownership from the current VM to a different VM, we have a
> > > couple of strategies. The first strategy involves processing the entire
> > > sg_table at once and then transferring the ownership. However, this
> > > method may have an adverse impact on the system because during an SMC
> > > call, the NS interrupts are disabled, and this delay could be
> > > significant when dealing with large sg_tables. To address this issue, we
> > > can adopt a second strategy, which involves processing each sg_list in
> > > the sg_table individually and reassigning memory ownership. Although
> > > this method is slower and potentially impacts performance, it will not
> > > keep the NS interrupts disabled for an extended period.
> > > 
> > > A more efficient strategy is to process the sg_table in batches. This
> > > approach addresses both scenarios by involving memory processing in
> > > batches, thus avoiding prolonged NS interrupt disablement for longer
> > > duration when dealing with large sg_tables. Moreover, since we process
> > > in batches, this method is faster compared to processing each item
> > > individually. The observations on testing both the approaches for
> > > performance is as follows:
> > > 
> > > Allocation Size/            256MB            512MB            1024MB
> > > Algorithm Used           ===========      ===========      ============
> > > 
> > > Processing each sg_list   73708(us)        149289(us)       266964(us)
> > > in sg_table one by one
> > > 
> > > Processing sg_table in    46925(us)         92691(us)       176893(us)
> > > batches
> > > 
> > > This implementation serves as a wrapper around the helper function
> > > __qcom_scm_assign_mem, which takes an sg_list and processes it in
> > > batches. We’ve set the limit to a minimum of 32 sg_list in a batch or a
> > > total batch size of 512 pages. The selection of these numbers is
> > > heuristic, based on the test runs conducted. Opting for a smaller number
> > > would compromise performance, while a larger number would result in
> > > non-secure interrupts being disabled for an extended duration.
> > > 
> > > Co-developed-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> > > Signed-off-by: Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>
> > > Signed-off-by: Dibakar Singh <quic_dibasing@quicinc.com>
> > > ---
> > >   drivers/firmware/qcom/qcom_scm.c       | 211 +++++++++++++++++++++++++
> > >   include/linux/firmware/qcom/qcom_scm.h |   7 +
> > >   2 files changed, 218 insertions(+)
> > > 
> > > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> > > index 520de9b5633a..038b96503d65 100644
> > > --- a/drivers/firmware/qcom/qcom_scm.c
> > > +++ b/drivers/firmware/qcom/qcom_scm.c
> > > @@ -21,6 +21,8 @@
> > >   #include <linux/platform_device.h>
> > >   #include <linux/reset-controller.h>
> > >   #include <linux/types.h>
> > > +#include <linux/scatterlist.h>
> > > +#include <linux/slab.h>
> > >   #include "qcom_scm.h"
> > > @@ -1048,6 +1050,215 @@ int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz,
> > >   }
> > >   EXPORT_SYMBOL_GPL(qcom_scm_assign_mem);
> > > +/**
> > > + * qcom_scm_assign_mem_batch() - Make a secure call to reassign memory
> > > + *				   ownership of several memory regions
> > > + * @mem_regions:    A buffer describing the set of memory regions that need to
> > > + *		    be reassigned
> > > + * @nr_mem_regions: The number of memory regions that need to be reassigned
> > > + * @srcvms:	    A buffer populated with he vmid(s) for the current set of
> > > + *		    owners
> > > + * @src_sz:	    The size of the srcvms buffer (in bytes)
> > > + * @destvms:	    A buffer populated with the new owners and corresponding
> > > + *		    permission flags.
> > > + * @dest_sz:	    The size of the destvms buffer (in bytes)
> > > + *
> > > + * Return negative errno on failure, 0 on success.
> > > + */
> > > +static int qcom_scm_assign_mem_batch(struct qcom_scm_mem_map_info *mem_regions,
> > > +				     size_t nr_mem_regions, u32 *srcvms,
> > > +				     size_t src_sz,
> > > +				     struct qcom_scm_current_perm_info *destvms,
> > > +				     size_t dest_sz)
> > > +{
> > > +	dma_addr_t mem_dma_addr;
> > > +	size_t mem_regions_sz;
> > > +	int ret = 0, i;
> > > +
> > > +	for (i = 0; i < nr_mem_regions; i++) {
> > > +		mem_regions[i].mem_addr = cpu_to_le64(mem_regions[i].mem_addr);
> > > +		mem_regions[i].mem_size = cpu_to_le64(mem_regions[i].mem_size);
> > > +	}
> > > +
> > > +	mem_regions_sz = nr_mem_regions * sizeof(*mem_regions);
> > > +	mem_dma_addr = dma_map_single(__scm->dev, mem_regions, mem_regions_sz,
> > > +				      DMA_TO_DEVICE);
> > > +	if (dma_mapping_error(__scm->dev, mem_dma_addr)) {
> > > +		dev_err(__scm->dev, "mem_dma_addr mapping failed\n");
> > > +		return -ENOMEM;
> > > +	}
> > > +
> > > +	ret = __qcom_scm_assign_mem(__scm->dev, virt_to_phys(mem_regions),
> > > +				    mem_regions_sz, virt_to_phys(srcvms), src_sz,
> > > +				    virt_to_phys(destvms), dest_sz);
> > > +
> > > +	dma_unmap_single(__scm->dev, mem_dma_addr, mem_regions_sz, DMA_TO_DEVICE);
> > > +	return ret;
> > > +}
> > > +
> > > +/**
> > > + * qcom_scm_prepare_mem_batch() - Prepare batches of memory regions
> > > + * @sg_table:       A scatter list whose memory needs to be reassigned
> > > + * @srcvms:	    A buffer populated with he vmid(s) for the current set of
> > > + *		    owners
> > > + * @nr_src:	    The number of the src_vms buffer
> > > + * @destvms:	    A buffer populated with he vmid(s) for the new owners
> > > + * @destvms_perms:  A buffer populated with the permission flags of new owners
> > > + * @nr_dest:	    The number of the destvms
> > > + * @last_sgl:	    Denotes to the last scatter list element. Used in case of rollback
> > > + * @roll_back:	    Identifies whether we are executing rollback in case of failure
> > > + *
> > > + * Return negative errno on failure, 0 on success.
> > > + */
> > > +static int qcom_scm_prepare_mem_batch(struct sg_table *table,
> > > +				      u32 *srcvms, int nr_src,
> > > +				      int *destvms, int *destvms_perms,
> > > +				      int nr_dest,
> > > +				      struct scatterlist *last_sgl, bool roll_back)
> > > +{
> > > +	struct qcom_scm_current_perm_info *destvms_cp;
> > > +	struct qcom_scm_mem_map_info *mem_regions_buf;
> > > +	struct scatterlist *curr_sgl = table->sgl;
> > > +	dma_addr_t source_dma_addr, dest_dma_addr;
> > > +	size_t batch_iterator;
> > > +	size_t batch_start = 0;
> > > +	size_t destvms_cp_sz;
> > > +	size_t srcvms_cp_sz;
> > > +	size_t batch_size;
> > > +	u32 *srcvms_cp;
> > > +	int ret = 0;
> > > +	int i;
> > > +
> > > +	if (!table || !table->sgl || !srcvms || !nr_src ||
> > > +	    !destvms || !destvms_perms || !nr_dest || !table->nents)
> > > +		return -EINVAL;
> > > +
> > > +	srcvms_cp_sz = sizeof(*srcvms_cp) * nr_src;
> > > +	srcvms_cp = kmemdup(srcvms, srcvms_cp_sz, GFP_KERNEL);
> > > +	if (!srcvms_cp)
> > > +		return -ENOMEM;
> > > +
> > > +	for (i = 0; i < nr_src; i++)
> > > +		srcvms_cp[i] = cpu_to_le32(srcvms_cp[i]);
> > > +
> > > +	source_dma_addr = dma_map_single(__scm->dev, srcvms_cp,
> > > +					 srcvms_cp_sz, DMA_TO_DEVICE);
> > 
> > Please use the new tzmem allocator:
> > 
> > https://lore.kernel.org/all/20240205182810.58382-1-brgl@bgdev.pl/
> 
> Noted, I will use this allocator in V2 patch.
> 
> > 
> > > +
> > > +	if (dma_mapping_error(__scm->dev, source_dma_addr)) {
> > > +		ret = -ENOMEM;
> > > +		goto out_free_source;
> > > +	}
> > > +
> > > +	destvms_cp_sz = sizeof(*destvms_cp) * nr_dest;
> > > +	destvms_cp = kzalloc(destvms_cp_sz, GFP_KERNEL);
> > > +
> > > +	if (!destvms_cp) {
> > > +		ret = -ENOMEM;
> > > +		goto out_unmap_source;
> > > +	}
> > > +
> > > +	for (i = 0; i < nr_dest; i++) {
> > > +		destvms_cp[i].vmid = cpu_to_le32(destvms[i]);
> > > +		destvms_cp[i].perm = cpu_to_le32(destvms_perms[i]);
> > > +		destvms_cp[i].ctx = 0;
> > > +		destvms_cp[i].ctx_size = 0;
> > > +	}
> > > +
> > > +	dest_dma_addr = dma_map_single(__scm->dev, destvms_cp,
> > > +				       destvms_cp_sz, DMA_TO_DEVICE);
> > > +	if (dma_mapping_error(__scm->dev, dest_dma_addr)) {
> > > +		ret = -ENOMEM;
> > > +		goto out_free_dest;
> > > +	}
> > > +
> > > +	mem_regions_buf = kcalloc(QCOM_SCM_MAX_BATCH_SECTION, sizeof(*mem_regions_buf),
> > > +				  GFP_KERNEL);
> > > +	if (!mem_regions_buf)
> > > +		return -ENOMEM;
> > > +
> > > +	while (batch_start < table->nents) {
> > > +		batch_size = 0;
> > > +		batch_iterator = 0;
> > > +
> > > +		do {
> > > +			mem_regions_buf[batch_iterator].mem_addr = page_to_phys(sg_page(curr_sgl));
> > > +			mem_regions_buf[batch_iterator].mem_size = curr_sgl->length;
> > > +			batch_size += curr_sgl->length;
> > > +			batch_iterator++;
> > > +			if (roll_back && curr_sgl == last_sgl)
> > > +				break;

Is roll_back bool necessary? last_sgl is NULL in case of not
rolling back and I think is good sentinel value when not rolling back.

If last_sgl is NULL, then all sgl entries are assigned. If last_sgl is
not NULL, then all the sgl entries are assigned until last_sgl is
encountered (inclusive).

> > > +			curr_sgl = sg_next(curr_sgl);
> > > +		} while (curr_sgl && batch_iterator < QCOM_SCM_MAX_BATCH_SECTION &&
> > > +				curr_sgl->length + batch_size < QCOM_SCM_MAX_BATCH_SIZE);
> > > +
> > > +		batch_start += batch_iterator;
> > > +
> > > +		ret = qcom_scm_assign_mem_batch(mem_regions_buf, batch_iterator,
> > > +						srcvms_cp, srcvms_cp_sz, destvms_cp, destvms_cp_sz);
> > > +
> > > +		if (ret) {
> > > +			dev_info(__scm->dev, "Failed to assign memory protection, ret = %d\n", ret);
> > > +			last_sgl = curr_sgl;
> > > +			ret = -EADDRNOTAVAIL;
> > 
> > Probably should not be changing the ret value.
> 
> We are adjusting the return value here because we have already printed the
> failed return value earlier. Our goal is to ensure that clients invoking
> this API consistently receive the same failed values, without needing to
> worry about the precise details of the failure.
> 

Clients will need special handling for ENOMEM, ENODEV, or EPROBEDEFER.
Clients can ignore the details of the error if they don't care, but
don't mask the error.

> > 
> > What happens to the memory that has been assigned so far? How do we
> > reclaim that?
> 
> We’ve already added rollback functionality in qcom_scm_assign_table that
> allows batches to be rolled back to the HLOS if there’s a failure.
> 
> > 
> > > +			break;
> > > +		}
> > > +		if (roll_back && curr_sgl == last_sgl)
> > > +			break;
> > > +	}
> > > +	kfree(mem_regions_buf);
> > > +
> > > +	dma_unmap_single(__scm->dev, dest_dma_addr,
> > > +			 destvms_cp_sz, DMA_TO_DEVICE);
> > > +
> > > +out_free_dest:
> > > +	kfree(destvms_cp);
> > > +out_unmap_source:
> > > +	dma_unmap_single(__scm->dev, source_dma_addr,
> > > +			 srcvms_cp_sz, DMA_TO_DEVICE);
> > > +out_free_source:
> > > +	kfree(srcvms_cp);
> > > +	return ret;
> > > +}
> > > +
> > > +/**
> > > + * qcom_scm_assign_table() - Make a call to prepare batches of memory regions
> > > + *			     and reassign memory ownership of several memory regions at once
> > > + * @sg_table:       A scatter list whose memory needs to be reassigned
> > > + * @srcvms:	    A buffer populated with he vmid(s) for the current set of
> > > + *		    owners
> > > + * @nr_src:	    The number of the src_vms buffer
> > > + * @destvms:	    A buffer populated with he vmid(s) for the new owners
> > > + * @destvms_perms:  A buffer populated with the permission flags of new owners
> > > + * @nr_dest:	    The number of the destvms
> > > + *
> > > + * Return negative errno on failure, 0 on success.
> > > + */
> > > +int qcom_scm_assign_table(struct sg_table *table,
> > > +			  u32 *srcvms, int nr_src,
> > > +			  int *destvms, int *destvms_perms,
> > > +			  int nr_dest)
> > > +{
> > > +	struct scatterlist *last_sgl = NULL;
> > > +	int rb_ret = 0;
> > > +	u32 new_dests;
> > > +	int new_perms;
> > > +	int ret = 0;
> > > +
> > > +	ret = qcom_scm_prepare_mem_batch(table, srcvms, nr_src,
> > > +					 destvms, destvms_perms, nr_dest, last_sgl, false);
> > > +
> > > +	if (!ret)
> > > +		goto out;
> > > +	new_dests = QCOM_SCM_VMID_HLOS;
> > 
> > We have the original srcvms. Will it always be HLOS? If so, then do we
> > need to pass srcvms at all?
> 
> No, srcvms can be VMs other than HLOS. However, this API does not expect
> clients to provide srcvms permissions. As a result, when such permissions
> are absent, we proceed by assigning the previously processed batches to
> HLOS.
> 

This is a wrong assumption though, right? You are allowing srcvms to be
something other than HLOS but assuming HLOS VMID is the only one in the
error path.

> > 
> > > +	new_perms = QCOM_SCM_PERM_EXEC | QCOM_SCM_PERM_WRITE | QCOM_SCM_PERM_READ;
> > > +	rb_ret = qcom_scm_prepare_mem_batch(table, destvms, nr_dest, &new_dests,
> > > +					    &new_perms, nr_src, last_sgl, true);
> > > +	WARN_ON_ONCE(rb_ret);
> > > +out:
> > > +	return ret;
> > > +}
> > > +EXPORT_SYMBOL_GPL(qcom_scm_assign_table);
> > 
> > Who uses this function?
> 
> https://lore.kernel.org/all/cover.1700544802.git.quic_vjitta@quicinc.com/
> 
> This patch responsible for extending qcom secure heap support which will be
> the user of this API. In the current implementation, we use
> qcom_scm_assign_mem and iterate over each sg_list in the sg_table
> individually to secure the memory. Going forward, we will replace this
> approach with our API.
> 
> > 
> > > +
> > >   /**
> > >    * qcom_scm_ocmem_lock_available() - is OCMEM lock/unlock interface available
> > >    */
> > > diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
> > > index ccaf28846054..abd675c7ef49 100644
> > > --- a/include/linux/firmware/qcom/qcom_scm.h
> > > +++ b/include/linux/firmware/qcom/qcom_scm.h
> > > @@ -8,6 +8,7 @@
> > >   #include <linux/err.h>
> > >   #include <linux/types.h>
> > >   #include <linux/cpumask.h>
> > > +#include <linux/scatterlist.h>
> > >   #include <dt-bindings/firmware/qcom,scm.h>
> > > @@ -15,6 +16,8 @@
> > >   #define QCOM_SCM_CPU_PWR_DOWN_L2_ON	0x0
> > >   #define QCOM_SCM_CPU_PWR_DOWN_L2_OFF	0x1
> > >   #define QCOM_SCM_HDCP_MAX_REQ_CNT	5
> > > +#define QCOM_SCM_MAX_BATCH_SECTION	32
> > > +#define QCOM_SCM_MAX_BATCH_SIZE		SZ_2M

Move the macros to qcom_scm.c

> > >   struct qcom_scm_hdcp_req {
> > >   	u32 addr;
> > > @@ -93,6 +96,10 @@ int qcom_scm_mem_protect_video_var(u32 cp_start, u32 cp_size,
> > >   int qcom_scm_assign_mem(phys_addr_t mem_addr, size_t mem_sz, u64 *src,
> > >   			const struct qcom_scm_vmperm *newvm,
> > >   			unsigned int dest_cnt);
> > > +int qcom_scm_assign_table(struct sg_table *table,
> > > +			  u32 *srcvms, int nr_src,
> > > +			  int *destvms, int *destvms_perms,
> > > +			  int nr_dest);
> > >   bool qcom_scm_ocmem_lock_available(void);
> > >   int qcom_scm_ocmem_lock(enum qcom_scm_ocmem_client id, u32 offset, u32 size,
> > > -- 
> > > 2.34.1
> > > 
> 

