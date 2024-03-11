Return-Path: <linux-kernel+bounces-99294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A37F187861F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31EF11F22787
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D124D108;
	Mon, 11 Mar 2024 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DzbyFf+3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00751482CF;
	Mon, 11 Mar 2024 17:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710177210; cv=none; b=RWZUTuWZK4/s3OvmmwFPIU1cVqdJvpQViq/buVtytu33ATdrz/GTthhtS2FsRJ4GDPVWaDBfkQ+jztnhL2g3lOWZwlKw5bw+aj5E8wfpHJngufPr5kIlg3PiwB3Fl2GIjN8L0Rp9h3RxRMerRLznTSn1/IlmpRvjACwR8EUJmg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710177210; c=relaxed/simple;
	bh=Lio1nhe7fciU4dYP74sWWd9SRcRxtgnQi2v2J158Cns=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzYRuvHC5+K+4hB29WbnYNt9AB/BZzcwToIqE4k/2beKrGccJWVBZE31lZarO9Vke0IHkrZvnFaBYTeheGVLVL+xVt550PsfyTM1vWEwvUCOYpYPYR2MWlEoA8csOxvrT7xQsWpB+AOnqRfuzape+VmRnzWIozY6tqyJqPBsz2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DzbyFf+3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B843Tq021082;
	Mon, 11 Mar 2024 17:13:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=7DHzIRWgki5+Z2bMSQr1Z
	/xOHasR45VMniFM9OQZ32g=; b=DzbyFf+3sade/LZ+DwPXYUP3Wy+6HbL5wzLsa
	W7SWXeCh0pGkls1m1g5FcoSbg6hJV/4T5D5vzgvdEz8eURmk2K5SmlA+ljbeJQ68
	lJ6IdxSktqhOngmZTjIJbt9FafBMcHMenJY88ETrlwuxS7NhfQSFn4cz0KvPgMkU
	2EjBrNiQinZpTk9jAimyNNbbbcHG/dCZeOfaYGFwaw2/5BQub8Hr4ZSNAFMzGqri
	3aVbK9OwofFhoQ1qg4TEbOtdIaiSW7CJpq3EKtDIY5xT+c2+JfLkiRKq0DK4TPe/
	BYlPR91IHrbZquAJhetDkvZsg2kFrOoT1u6zfL0edqWOFfIrA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wsx48shaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 17:13:05 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42BHD4Xt021914
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 17:13:04 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Mar 2024 10:13:03 -0700
Date: Mon, 11 Mar 2024 10:13:03 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
CC: Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>,
        Murali Nalajal <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Carl van Schaik
	<quic_cvanscha@quicinc.com>,
        Philip Derrin <quic_pderrin@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Jonathan Corbet
	<corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Fuad
 Tabba" <tabba@google.com>,
        Sean Christopherson <seanjc@google.com>,
        "Andrew
 Morton" <akpm@linux-foundation.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>
Subject: Re: Re: [PATCH v17 12/35] virt: gunyah: Add resource tickets
Message-ID: <20240311100247856-0700.eberman@hu-eberman-lv.qualcomm.com>
Mail-Followup-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, 
	Alex Elder <elder@linaro.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Murali Nalajal <quic_mnalajal@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>, 
	Carl van Schaik <quic_cvanscha@quicinc.com>, Philip Derrin <quic_pderrin@quicinc.com>, 
	Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>, Jonathan Corbet <corbet@lwn.net>, 
	Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Fuad Tabba <tabba@google.com>, Sean Christopherson <seanjc@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mm@kvack.org
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-12-1e9da6763d38@quicinc.com>
 <20240311053806.GL440762@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240311053806.GL440762@quicinc.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 11wI3OtaIF1Dwa5d3RYzieDVyHwG5GVf
X-Proofpoint-ORIG-GUID: 11wI3OtaIF1Dwa5d3RYzieDVyHwG5GVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxlogscore=999
 spamscore=0 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110131

On Mon, Mar 11, 2024 at 11:08:06AM +0530, Srivatsa Vaddagiri wrote:
> * Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:35]:
> 
> > Gunyah doesn't process the label and that makes it
> > possible for userspace to create multiple resources with the same label.
> 
> I think that description conflicts with what is implemented in this patch?
> 
> int gunyah_vm_add_resource_ticket(struct gunyah_vm *ghvm,
> 				  struct gunyah_vm_resource_ticket *ticket)
> {
> 	mutex_lock(&ghvm->resources_lock);
> 	list_for_each_entry(iter, &ghvm->resource_tickets, vm_list) {
> 		if (iter->resource_type == ticket->resource_type &&
> 		    iter->label == ticket->label) {
> 			ret = -EEXIST;
> 			goto out;
> 		}
> 	}
> 
> 
> //
> 

It's a justification for the next sentence in the commit text:

    Resource ticket owners need to be prepared for populate to be called
    multiple times if userspace created multiple resources with the same
    label.


VM manager can make sure that only one entity is going to receive the
resources (the check above you highlighted), but I can't make sure that
it's only going to exactly one resource. We don't currently have a
scenario where we need/want multiple resources with the same label, we
might have that in the future and I didn't want to add that restriction
in common code.

> > @@ -134,6 +246,25 @@ static int gunyah_vm_start(struct gunyah_vm *ghvm)
> >  	}
> >  	ghvm->vm_status = GUNYAH_RM_VM_STATUS_READY;
> >  
> > +	ret = gunyah_rm_get_hyp_resources(ghvm->rm, ghvm->vmid, &resources);
> > +	if (ret) {
> > +		dev_warn(ghvm->parent,
> > +			 "Failed to get hypervisor resources for VM: %d\n",
> > +			 ret);
> > +		goto err;
> > +	}
> 
> Where do we free memory pointed by 'resources' ptr?
> 

Ah, I meant to add the __free(kfree) annotation. I've added it.

> > +
> > +	for (i = 0, n = le32_to_cpu(resources->n_entries); i < n; i++) {
> > +		ghrsc = gunyah_rm_alloc_resource(ghvm->rm,
> > +						 &resources->entries[i]);
> > +		if (!ghrsc) {
> > +			ret = -ENOMEM;
> > +			goto err;
> > +		}
> > +
> > +		gunyah_vm_add_resource(ghvm, ghrsc);
> > +	}

