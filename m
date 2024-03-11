Return-Path: <linux-kernel+bounces-98482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA76877AAC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2724B20B82
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D019CA47;
	Mon, 11 Mar 2024 05:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eEhbnREV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF029748E;
	Mon, 11 Mar 2024 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710135524; cv=none; b=dkdzyJXLZvLL1EUBYSXuDPXL75joQTYV0fj3vCf9NNSE2xBKyUkAYHXFEQmtximZv6XWYQ7c0d9kAY5r5Fm3FttJjQ3kzSSVTrLkACfH1ReK9AK0wF+OIci9WXr8bCVNY/DIXgw/Bc2zUr6Rj00rgS/BQkpX+1imQEVr6F8vS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710135524; c=relaxed/simple;
	bh=JkYYh47/8McwjllgWCKNB4oAhTTgDeqPKIVJmU8Vpyo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzHBjHrd6ZrgiSAvanbe0W8Q45Du5NNIQ+bKElQITSMJnzCyhrX0Iv0j8X1tn3Jv7Q4cgw7ls6f1cWL3oUSy7/363YqZH63J6XFDx7pBbBs/33iaXr+JgQ+3+CKQY759r8P9jhGiMK2vfzJ7FvALkIcYtRuIJ0X1axat6u8lZKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eEhbnREV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42B5J5MF003578;
	Mon, 11 Mar 2024 05:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:reply-to:references
	:mime-version:content-type:in-reply-to; s=qcppdkim1; bh=ddYhWpZ6
	UFYa7XqP0w1UUiujo7MlM6KsRadAKbQ22Rw=; b=eEhbnREV5Wa3zXvIJZx+lqnS
	anX5OBKzDgYK8YL2a9FZsSpKCT+rvAk7E5B4fgcg50OjuQOWEKY7F7beXLUDB5K7
	3dUgPq6x93l8cN/khCTxxdryGgFyKuy2qOIkr4RDAsa4nAzTTHY4nAbD6ZD1ayCF
	qEtqsVESmgxfylmOleSjdphQc3BEW1l0ogVwllLgYEtmPei+TYlJg4lSA1yaoRnz
	XxbFaWA/ddpvyTm94jLZEgOPt/N0SjetgA4mhW4LyODsq53ZmzQX0pIHkL6Lwr2n
	5DqzbTNLj2M4HeD1PalYjXKTOV1+BvRhIcPdb3x93kIb9o62cOy/lWmDhLqywg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wresbtsmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 05:38:19 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42B5cI2M007024
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 05:38:18 GMT
Received: from quicinc.com (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 10 Mar
 2024 22:38:10 -0700
Date: Mon, 11 Mar 2024 11:08:06 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
To: Elliot Berman <quic_eberman@quicinc.com>
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
Subject: Re: [PATCH v17 12/35] virt: gunyah: Add resource tickets
Message-ID: <20240311053806.GL440762@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-12-1e9da6763d38@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
In-Reply-To: <20240222-gunyah-v17-12-1e9da6763d38@quicinc.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZEy7XYUtlKeA49q6fTfq0MIjfbi1DK-L
X-Proofpoint-GUID: ZEy7XYUtlKeA49q6fTfq0MIjfbi1DK-L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_02,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0
 adultscore=0 clxscore=1011 malwarescore=0 spamscore=0 suspectscore=0
 mlxlogscore=860 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403110041

* Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:35]:

> Gunyah doesn't process the label and that makes it
> possible for userspace to create multiple resources with the same label.

I think that description conflicts with what is implemented in this patch?

int gunyah_vm_add_resource_ticket(struct gunyah_vm *ghvm,
				  struct gunyah_vm_resource_ticket *ticket)
{
	mutex_lock(&ghvm->resources_lock);
	list_for_each_entry(iter, &ghvm->resource_tickets, vm_list) {
		if (iter->resource_type == ticket->resource_type &&
		    iter->label == ticket->label) {
			ret = -EEXIST;
			goto out;
		}
	}


//

> @@ -134,6 +246,25 @@ static int gunyah_vm_start(struct gunyah_vm *ghvm)
>  	}
>  	ghvm->vm_status = GUNYAH_RM_VM_STATUS_READY;
>  
> +	ret = gunyah_rm_get_hyp_resources(ghvm->rm, ghvm->vmid, &resources);
> +	if (ret) {
> +		dev_warn(ghvm->parent,
> +			 "Failed to get hypervisor resources for VM: %d\n",
> +			 ret);
> +		goto err;
> +	}

Where do we free memory pointed by 'resources' ptr?

> +
> +	for (i = 0, n = le32_to_cpu(resources->n_entries); i < n; i++) {
> +		ghrsc = gunyah_rm_alloc_resource(ghvm->rm,
> +						 &resources->entries[i]);
> +		if (!ghrsc) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +
> +		gunyah_vm_add_resource(ghvm, ghrsc);
> +	}

