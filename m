Return-Path: <linux-kernel+bounces-73456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E3EC85C2CF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:38:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B740D1F233CE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA85076C98;
	Tue, 20 Feb 2024 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c4fF2e3o"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9541277632
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450684; cv=none; b=mbVqKm+HtjAOwRZ1obBaC3IO1ebSYWrEEBHq3sYo8UjiIwKKv+8GRqt8iMjPeOdFSfJSsesSftVPOQglFj6HxpDsCxyTPTVuRZbkALzHv/yUAfWDzL3p06pL4xGO3jdtp7BtjKqkGVPTEE9DBpn00A6pa/W2wNfmBAho6GW2k98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450684; c=relaxed/simple;
	bh=chjHpOYI/dE8bwRfCd075t2HYI1qV4j36wPFpA4IeJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cAoc0YwWpCObZmXGk5z0m+yqlLWU0xN7M0uYaf4ZuZja6aHymuSrD8kyTZJd5B79f50hcoK1ey7HLYb+GY+ZwzYEpbusWbEMLYauNYkR+gAa+sxNjY5r3T4jDKAYJgkn4BGo/5B4KRVszzuis454srsRO5W6DzRbjndmMsbJTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c4fF2e3o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41KEfweJ020497;
	Tue, 20 Feb 2024 17:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=p0D1qsOzFR10TiLIZJjIoMBY5kcbdzXOoGhUqlF4COU=; b=c4
	fF2e3oKqnSwDQM9DHgUKV4p9CzwMAUXXwHmDZEq+576r4/MRXoYzX63Bz95FLYAP
	DdcQzsp9/8EljJ1Fu3rV/TbNm+ZqD+RXAoxXdYwUeu1hhipokzunMklaSf9V277H
	/Pd0xnwWRoYm9L3STBf2eFgl3Xhe8pKyxCg4cb8496wsXIo8gowo7KcIB/bMpYDA
	KPhKDdr6DNbXB5Hoybe8LjX4JTLMDLpkBGUIL1GaU/dZHOfi+AFWAF5GR6NWrjWO
	78OsFChLXT/80O/omjxspg2NHRE5yWL0AUOnjbL15wN6KpKnsiMrU+kwUnzIVM50
	D2iMwusBgsURKmP1cYZA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wct3egxmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 17:37:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41KHbRVK031007
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Feb 2024 17:37:27 GMT
Received: from [10.71.110.192] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 20 Feb
 2024 09:37:24 -0800
Message-ID: <e59f02e4-03c9-42dc-9c04-65d339fa8cc2@quicinc.com>
Date: Tue, 20 Feb 2024 09:37:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] LoongArch: Call early_init_fdt_scan_reserved_mem()
 earlier
To: Huacai Chen <chenhuacai@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
CC: <loongarch@lists.linux.dev>, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren
	<guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang
	<jiaxun.yang@flygoat.com>, <linux-kernel@vger.kernel.org>,
        <loongson-kernel@lists.loongnix.cn>, <kernel@quicinc.com>
References: <20240218151403.2206980-1-chenhuacai@loongson.cn>
Content-Language: en-US
From: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
In-Reply-To: <20240218151403.2206980-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RHSoEzoEOeai5k1Ch4kMzEmb3QD2kcWV
X-Proofpoint-GUID: RHSoEzoEOeai5k1Ch4kMzEmb3QD2kcWV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-20_06,2024-02-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 clxscore=1011 mlxscore=0 mlxlogscore=999
 priorityscore=1501 malwarescore=0 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402200126


On 2/18/2024 7:14 AM, Huacai Chen wrote:
> The unflatten_and_copy_device_tree() function contains a call to
> memblock_alloc(). This means that memblock is allocating memory before
> any of the reserved memory regions are set aside in the arch_mem_init()
> function which calls early_init_fdt_scan_reserved_mem(). Therefore,
> there is a possibility for memblock to allocate from any of the
> reserved memory regions.
>
> Hence, move the call to early_init_fdt_scan_reserved_mem() to be earlier
> in the init sequence, so that the reserved memory regions are set aside
> before any allocations are done using memblock.
>
> Signed-off-by: Oreoluwa Babatunde <quic_obabatun@quicinc.com>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
>  arch/loongarch/kernel/setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
> index edf2bba80130..634ef17fd38b 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -357,6 +357,8 @@ void __init platform_init(void)
>  	acpi_gbl_use_default_register_widths = false;
>  	acpi_boot_table_init();
>  #endif
> +
> +	early_init_fdt_scan_reserved_mem();
>  	unflatten_and_copy_device_tree();
>  
>  #ifdef CONFIG_NUMA
> @@ -390,8 +392,6 @@ static void __init arch_mem_init(char **cmdline_p)
>  
>  	check_kernel_sections_mem();
>  
> -	early_init_fdt_scan_reserved_mem();
> -
>  	/*
>  	 * In order to reduce the possibility of kernel panic when failed to
>  	 * get IO TLB memory under CONFIG_SWIOTLB, it is better to allocate
Hi Huacai,

Thank you! This change looks good to me.

Regards,

Oreoluwa

