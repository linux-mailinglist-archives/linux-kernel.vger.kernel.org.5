Return-Path: <linux-kernel+bounces-157366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40528B1094
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4C0FB269B0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E2C16D31E;
	Wed, 24 Apr 2024 17:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ckB/6Efj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C6316C87E;
	Wed, 24 Apr 2024 17:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713978117; cv=none; b=gzmAhahRR7V59SNGp7TwgR+Ct0IIFMgW5/5BDnX3p8o0hXcfMxV1KWilBAI7+gSQKFLiPm6lC2r35Lq2nTuUZUZSYBrAdqr1TqciTHVybHEja1w/LhzSlYAIClj7m43GtRl8YXJM477SXrMzfzC+AZ+sCE5eOjQXyiR+F+mG3nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713978117; c=relaxed/simple;
	bh=8/c+EErr/LoDQQ0UswBCV688f9Qy+hEYoM2s16h4laE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fxeIylQzjprmvUQC4Ww+uncFN9spfdFO1xXtt6AIheXGg+xHGBFury06WqO84eXtomaO80E9Q4e+cQmVUUvwctV2HqhceEzKF312j7I2DTTwFT6qhQ33RVLGjS+7H5t3eIEj0ndXUQ5jnxZ1PfYLlwimSx6m7il6QpVcbFk0G64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ckB/6Efj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OGr3rP025446;
	Wed, 24 Apr 2024 17:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=v9LyJsiCVlAgeeEWeNcgp
	jCdd+MkEQSXTQEg+z9k3H4=; b=ckB/6EfjQU7QYRxLN63Tx+JX+zZrhrWKcyemC
	+z0P8/A3nyWPcmnf2SPzCY82w2DROkvZXqlYwQK3lyIjMJgB8HDAICO1dFUuZpj3
	6g0WdGHdEGoKH3N4AcDhntJs47rkIsdcO+Ofp1iMWA3YpqWxHwqHr/31RfonbR6h
	+Rh87jJR8i+8uaYKFcQcjoRhYwjG13czzU8mvVp8D7X+shaHC3P7qFb6yHGhIQqf
	sAoPi731+YmyHGcGGu7VsFEtfblpNfm6xAnXZ2NxMaSFJp9u5xAEu0D7Z+hipLxF
	hdxCVjlSlDgdzCWYc1BY0DbeJljbyL1LoxblhlKbJOfANHT9Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xpv9e1kxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 17:01:11 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43OH1BZa032159
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 17:01:11 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 10:01:10 -0700
Date: Wed, 24 Apr 2024 10:01:10 -0700
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
Subject: Re: [PATCH v17 15/35] virt: gunyah: Add proxy-scheduled vCPUs
Message-ID: <20240424095405136-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240222-gunyah-v17-0-1e9da6763d38@quicinc.com>
 <20240222-gunyah-v17-15-1e9da6763d38@quicinc.com>
 <20240424093957.GY440762@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240424093957.GY440762@quicinc.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 89qGz_tE3OgnL4axkC5Pm979HLQTQNiv
X-Proofpoint-ORIG-GUID: 89qGz_tE3OgnL4axkC5Pm979HLQTQNiv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_14,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240073

On Wed, Apr 24, 2024 at 03:09:57PM +0530, Srivatsa Vaddagiri wrote:
> * Elliot Berman <quic_eberman@quicinc.com> [2024-02-22 15:16:38]:
> 
> > +/**
> > + * struct gunyah_vm_exit_info - Reason for VM exit as reported by Gunyah
> > + * See Gunyah documentation for values.
> > + * @type: Describes how VM exited
> > + * @padding: padding bytes
> > + * @reason_size: Number of bytes valid for `reason`
> > + * @reason: See Gunyah documentation for interpretation. Note: these values are
> > + *          not interpreted by Linux and need to be converted from little-endian
> > + *          as applicable.
> > + */
> > +struct gunyah_vm_exit_info {
> > +	__u16 type;
> 
> Pls add an enum to describe the various exit types.
> 

When I was first added the exit_info, I thought a bunch on whether to
add the enum. I was thinking that if we add it to the UAPI, kernel need
to parse and validate the values from RM. In the current scheme, I can
leave it to userspace to interpret the value from RM. I could be
convinced to go the other way though. Currently this is less code :) Let
me know your thoughts! 

> > +	__u16 padding;
> > +	__u32 reason_size;
> > +	__u8 reason[GUNYAH_VM_MAX_EXIT_REASON_SIZE];

If we start interpreting the @type, then maybe we should also start
interpreting the @reason, and that will also add debt to the kernel
driver.

Thanks,
Elliot


