Return-Path: <linux-kernel+bounces-49190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4266C8466FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F8C0B21D6F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1EBF4F0;
	Fri,  2 Feb 2024 04:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="R7cTLFr9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF063EAEA
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 04:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706848286; cv=none; b=TCX3DqFP+I2TgFwoL8jhY8G2w2JakacCMbMuFJKGk6HyZe2yXP7PtPQbHr8IeN3DkzQMJ3qqNEODtDWTsnSM7BW5k+8X9/2ULpZBPeU5TK7Kc4e8Bi8TI38p0KGcAoQ6scfWrg1mC6aAOoZmLlIah+QB/yIpEL3xnxn6B4R+f0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706848286; c=relaxed/simple;
	bh=a4ZT8Enf9oORWssJ1Oet3WSbt7cX2HHKa3Hg+JyTcLw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b9K4rfzEE2BtInIqmNecVv9rdWUHeYfwobCTnn7N+43LmsEyujPz8F+GeidP3ZDq09uaxXfxcoOsJgOQba8H/T8GE6NdMvx3M3aizMUO3wBWtAV4RXcGg6YuzAS8Ks6tVr02GI+XpW91Pu/1UcXtVO5VXAKRuBWulzTm6HIS1Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=R7cTLFr9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4124SFLW030429;
	Fri, 2 Feb 2024 04:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=E5Ngqz/WRMMBBG6e8j2A7
	UyxUwTajWJF3P086kGxK0s=; b=R7cTLFr9GbUWJpMaqT+M6lyfmG0QDt4CHtRCp
	QtVxkzB4XD6oDGoqHAJAKokox4v7ARG8tzmQgFMttLpVTR79Ku+vpSerewbWniFf
	SCIWau1Pf69tgyTEXnDxGNp5bDKrpPK9Ki8vtyDdp9VB0JMSknRu6aODje0J2f1X
	R8j6T7M2IyzA94mf4/suTiNWM8ABfp0CyGTTF+NAaRB8rg5LIuuWJBpBVnkFTQao
	FbBNYpebs3qxvifqmwJY/qnJ5O8bojdk+SmRLZjfOUG/KkN/pMXoEf646ugu7JAS
	ck6WWtk+YyLPSn6PrEpq4IMlG4ipyMm0UgpemtzJdvYBhnlDg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pu009rb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 04:31:12 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4124VBgQ001830
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 04:31:11 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 1 Feb 2024 20:31:11 -0800
Date: Thu, 1 Feb 2024 20:31:10 -0800
From: Elliot Berman <quic_eberman@quicinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt
	<palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang
	<jszhang@kernel.org>,
        Evan Green <evan@rivosinc.com>,
        =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] riscv: Disable misaligned access probe when
 CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
Message-ID: <gtwet3x2fokbne5642vleyp5u7pqjl2lbtbngjjfavmgvvytzg@z2gx6xoa3hvl>
Mail-Followup-To: Charlie Jenkins <charlie@rivosinc.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Jisheng Zhang <jszhang@kernel.org>, 
	Evan Green <evan@rivosinc.com>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240201-disable_misaligned_probe_config-v2-0-77c368bed7b2@rivosinc.com>
 <20240201-disable_misaligned_probe_config-v2-2-77c368bed7b2@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240201-disable_misaligned_probe_config-v2-2-77c368bed7b2@rivosinc.com>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: v2zNNbLEzggt0GdOtik2j8HK7sQEwjcC
X-Proofpoint-ORIG-GUID: v2zNNbLEzggt0GdOtik2j8HK7sQEwjcC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 mlxlogscore=631 suspectscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 clxscore=1011 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020030

Hi Charlie,

On Thu, Feb 01, 2024 at 03:30:46PM -0800, Charlie Jenkins wrote:
> When CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is selected, the cpus can be
> set to have fast misaligned access without needing to probe.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
>  arch/riscv/Kconfig                               |   1 +
>  arch/riscv/include/asm/cpufeature.h              |   7 +
>  arch/riscv/include/asm/misaligned_access_speed.h |  29 +++
>  arch/riscv/kernel/Makefile                       |   3 +
>  arch/riscv/kernel/cpufeature.c                   | 255 ----------------------
>  arch/riscv/kernel/misaligned_access_speed.c      | 265 +++++++++++++++++++++++
>  arch/riscv/kernel/sys_hwprobe.c                  |   4 +
>  7 files changed, 309 insertions(+), 255 deletions(-)
> 
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f71910718053..8be7f17da9ab 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -62,6 +62,9 @@ obj-y	+= tests/
>  obj-$(CONFIG_MMU) += vdso.o vdso/
>  
>  obj-$(CONFIG_RISCV_MISALIGNED)	+= traps_misaligned.o
> +ifneq ($(RISCV_EFFICIENT_UNALIGNED_ACCESS), y)

Should this be CONFIG_RISCV_EFFICIENT_UNALIGNED_ACCESS ?

> +obj-y	+= misaligned_access_speed.o
> +endif
>  obj-$(CONFIG_FPU)		+= fpu.o
>  obj-$(CONFIG_RISCV_ISA_V)	+= vector.o
>  obj-$(CONFIG_RISCV_ISA_V)	+= kernel_mode_vector.o

