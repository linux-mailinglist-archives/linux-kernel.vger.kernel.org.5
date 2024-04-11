Return-Path: <linux-kernel+bounces-139732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ABD8A06F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:54:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D7D1F236B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E50013BC10;
	Thu, 11 Apr 2024 03:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QNCFV2pG"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B28113B5B0;
	Thu, 11 Apr 2024 03:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712807678; cv=none; b=mow5WNwxLWvBvVtRoD3JdqdoTmBZK8sYkRi3mcY9MdWRf6LXijA/ug0BTO4koDStU4CJhTNwfOJWx18ow7CEJFYMVmKDm/VnL4nwXDUF405DOSCtF6/abCITmRpSw/Mnmi1ZZa4AItugknECtiksL2vvSz/6Tqbi3Abl/kqJK9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712807678; c=relaxed/simple;
	bh=Jhm3NtfQWCBREl/VAlVuoBtL9LXp++aORHDL+2I9ubU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvABwxS6vuYuZ9cVJP4iqeKBPYfLmJ3T8jiKgWGByPuSkTr0QJzMd+/fJEZElAlPi3iqcx8OzYm860XcHlBmZQHWM9c9eozhTs2AtA5kD+N9KFGPNs01+ooTafKSkRcoV74scV7oWW2HEwqEIsUhDUMHmaAQnwKl/6vjpEz1hSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QNCFV2pG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43B3dtk4024977;
	Thu, 11 Apr 2024 03:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=b6/JXHfI6BN+5sMwcLal/
	NfllbHe43Xj/Fx9bOOPAjo=; b=QNCFV2pGlzVL5atk9A7Mk0h9pNLe1JL75h/6p
	YWo4YW7kbchZTMSZR+Uv+6mLkxBWowtz6kkS2ek01LI37noQe1AfeAaaTQnnAdBh
	1uLeXgN/THwklSd2FfgCZdLvOn03u97Jo6oCpNf/G/Alg9Oj3PYhHT7lglnM0Juw
	yV8aHWy5waZ9nIwtNMiZLpyykBsLjDh8cI7kNW5AQhpo+DAjFktBgmLm19NNqk09
	FFJTUKZR9lIw31+Rit+SFUptOCz54oK4ezQfY+lVS9R5yB5VWqXLtg+LWhu5dlLw
	7nLKYXACRiHK1CobGDXvuTIwFp4mtiGoZCiEurubFeJH6zXeQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xe06xsdh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 03:54:27 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43B3sPkV001158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Apr 2024 03:54:25 GMT
Received: from hu-eberman-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Apr 2024 20:54:24 -0700
Date: Wed, 10 Apr 2024 20:54:24 -0700
From: Elliot Berman <quic_eberman@quicinc.com>
To: Stephen Boyd <swboyd@chromium.org>
CC: Caleb Connolly <caleb.connolly@linaro.org>,
        Stephan Gerhold
	<stephan@gerhold.net>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Volodymyr
 Babchuk <Volodymyr_Babchuk@epam.com>,
        Bjorn Andersson <andersson@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Douglas
 Anderson <dianders@chromium.org>,
        Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH] soc: qcom: cmd-db: map shared memory as WT, not WB
Message-ID: <20240410204337739-0700.eberman@hu-eberman-lv.qualcomm.com>
References: <20240327200917.2576034-1-volodymyr_babchuk@epam.com>
 <e0586d43-284c-4bef-a8be-4ffbc12bf787@linaro.org>
 <87a5mjz8s3.fsf@epam.com>
 <f4ebe819-9718-42c3-9874-037151587d0c@linaro.org>
 <cd549ee8-22dc-4bc4-af09-9c5c925ee03a@linaro.org>
 <ZgU_YDUhBeyS5wuh@gerhold.net>
 <CAE-0n50BGLccCTDfCmOd0Bcbmp7SMwsJd8qTVPWioKvbaD0A0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAE-0n50BGLccCTDfCmOd0Bcbmp7SMwsJd8qTVPWioKvbaD0A0w@mail.gmail.com>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OI9XBLm38_quW6AiCZusgX6v30hDVC5S
X-Proofpoint-ORIG-GUID: OI9XBLm38_quW6AiCZusgX6v30hDVC5S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-10_08,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404110026

On Thu, Mar 28, 2024 at 07:40:49PM -0500, Stephen Boyd wrote:
> Quoting Stephan Gerhold (2024-03-28 02:58:56)
> >
> > FWIW: This old patch series from Stephen Boyd is closely related:
> > https://lore.kernel.org/linux-arm-msm/20190910160903.65694-1-swboyd@chromium.org/
> >
> > > The main use case I have is to map the command-db memory region on
> > > Qualcomm devices with a read-only mapping. It's already a const marked
> > > pointer and the API returns const pointers as well, so this series
> > > makes sure that even stray writes can't modify the memory.
> >
> > Stephen, what was the end result of that patch series? Mapping the
> > cmd-db read-only sounds cleaner than trying to be lucky with the right
> > set of cache flags.
> >
> 
> I dropped it because I got busy with other stuff. Feel free to pick it
> back up. It looks like the part where I left off was where we had to
> make the API fallback to mapping the memory as writeable if read-only
> isn't supported on the architecture.
[...]
> The other weird thing was that we passed both MEMREMAP_RO and
> MEMREMAP_WB to indicate what sort of fallback we want. Perhaps that can
> be encoded in the architecture layer so that you get the closest thing
> to read-only memory (i.e. any sort of write side caching is removed) and
> you don't have to pass a fallback mapping type.

Was there any motivation for having the fallback? I suspect driver
owners that want to use MEMREMAP_RO will know which architectures the
driver is applicable to and also know whether MEMREMAP_RO would work.

> I also wanted to return a const pointer.

The stash looks mostly complete. Do you think it should be part of the
series or submitted separately?

> 
> Here's my stash patch on top of the branch (from 2019!).
> 
> ---8<----
> From: Stephen Boyd <swboyd@chromium.org>
> Date: Tue, 14 May 2019 13:22:01 -0700
> Subject: [PATCH] stash const iounmap
> 
> ---
>  arch/arm64/include/asm/io.h   |  2 +-
>  arch/arm64/mm/ioremap.c       |  9 +++++----
>  arch/x86/mm/ioremap.c         |  2 +-
>  drivers/firmware/google/vpd.c | 22 +++++++++++-----------
>  drivers/soc/qcom/rmtfs_mem.c  |  5 ++---
>  include/asm-generic/io.h      |  2 +-
>  include/linux/io.h            |  2 +-
>  include/linux/mmiotrace.h     |  2 +-
>  kernel/iomem.c                |  2 +-
>  9 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/io.h b/arch/arm64/include/asm/io.h
> index 245bd371e8dc..0fd4f1678300 100644
> --- a/arch/arm64/include/asm/io.h
> +++ b/arch/arm64/include/asm/io.h
> @@ -178,7 +178,7 @@ extern void __memset_io(volatile void __iomem *,
> int, size_t);
>   * I/O memory mapping functions.
>   */
>  extern void __iomem *__ioremap(phys_addr_t phys_addr, size_t size,
> pgprot_t prot);
> -extern void __iounmap(volatile void __iomem *addr);
> +extern void __iounmap(const volatile void __iomem *addr);
>  extern void __iomem *ioremap_cache(phys_addr_t phys_addr, size_t size);
> 
>  #define ioremap(addr, size)		__ioremap((addr), (size),
> __pgprot(PROT_DEVICE_nGnRE))
> diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
> index c4c8cd4c31d4..e39fb2cb6042 100644
> --- a/arch/arm64/mm/ioremap.c
> +++ b/arch/arm64/mm/ioremap.c
> @@ -80,16 +80,17 @@ void __iomem *__ioremap(phys_addr_t phys_addr,
> size_t size, pgprot_t prot)
>  }
>  EXPORT_SYMBOL(__ioremap);
> 
> -void __iounmap(volatile void __iomem *io_addr)
> +void __iounmap(const volatile void __iomem *io_addr)
>  {
> -	unsigned long addr = (unsigned long)io_addr & PAGE_MASK;
> +	const unsigned long addr = (const unsigned long)io_addr & PAGE_MASK;
> +	const void *vaddr = (const void __force *)addr;
> 
>  	/*
>  	 * We could get an address outside vmalloc range in case
>  	 * of ioremap_cache() reusing a RAM mapping.
>  	 */
> -	if (is_vmalloc_addr((void *)addr))
> -		vunmap((void *)addr);
> +	if (is_vmalloc_addr(vaddr))
> +		vunmap(vaddr);
>  }
>  EXPORT_SYMBOL(__iounmap);
> 
> diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
> index 0029604af8a4..e9a2910d0c63 100644
> --- a/arch/x86/mm/ioremap.c
> +++ b/arch/x86/mm/ioremap.c
> @@ -392,7 +392,7 @@ EXPORT_SYMBOL(ioremap_prot);
>   *
>   * Caller must ensure there is only one unmapping for the same pointer.
>   */
> -void iounmap(volatile void __iomem *addr)
> +void iounmap(const volatile void __iomem *addr)
>  {
>  	struct vm_struct *p, *o;
> 
> diff --git a/drivers/firmware/google/vpd.c b/drivers/firmware/google/vpd.c
> index c0c0b4e4e281..7428f189999e 100644
> --- a/drivers/firmware/google/vpd.c
> +++ b/drivers/firmware/google/vpd.c
> @@ -48,7 +48,7 @@ struct vpd_section {
>  	const char *name;
>  	char *raw_name;                /* the string name_raw */
>  	struct kobject *kobj;          /* vpd/name directory */
> -	char *baseaddr;
> +	const char *baseaddr;
>  	struct bin_attribute bin_attr; /* vpd/name_raw bin_attribute */
>  	struct list_head attribs;      /* key/value in vpd_attrib_info list */
>  };
> @@ -187,19 +187,19 @@ static int vpd_section_create_attribs(struct
> vpd_section *sec)
>  	return 0;
>  }
> 
> -static int vpd_section_init(const char *name, struct vpd_section *sec,
> +static int vpd_section_init(struct device *dev, const char *name,
> struct vpd_section *sec,
>  			    phys_addr_t physaddr, size_t size)
>  {
>  	int err;
> 
> -	sec->baseaddr = memremap(physaddr, size, MEMREMAP_WB);
> -	if (!sec->baseaddr)
> -		return -ENOMEM;
> +	sec->baseaddr = devm_memremap(physaddr, size, MEMREMAP_RO | MEMREMAP_WB);
> +	if (IS_ERR(sec->baseaddr))
> +		return PTR_ERR(sec->baseaddr);
> 
>  	sec->name = name;
> 
>  	/* We want to export the raw partition with name ${name}_raw */
> -	sec->raw_name = kasprintf(GFP_KERNEL, "%s_raw", name);
> +	sec->raw_name = devm_kasprintf(GFP_KERNEL, "%s_raw", name);
>  	if (!sec->raw_name) {
>  		err = -ENOMEM;
>  		goto err_memunmap;
> @@ -252,11 +252,12 @@ static int vpd_section_destroy(struct vpd_section *sec)
>  	return 0;
>  }
> 
> -static int vpd_sections_init(phys_addr_t physaddr)
> +static int vpd_sections_init(struct coreboot_device *cdev)
>  {
>  	struct vpd_cbmem __iomem *temp;
>  	struct vpd_cbmem header;
>  	int ret = 0;
> +	phys_addr_t physaddr = cdev->cbmem_ref.cbmem_addr;
> 
>  	temp = memremap(physaddr, sizeof(struct vpd_cbmem), MEMREMAP_WB);
>  	if (!temp)
> @@ -269,7 +270,7 @@ static int vpd_sections_init(phys_addr_t physaddr)
>  		return -ENODEV;
> 
>  	if (header.ro_size) {
> -		ret = vpd_section_init("ro", &ro_vpd,
> +		ret = vpd_section_init(&cdev->dev, "ro", &ro_vpd,
>  				       physaddr + sizeof(struct vpd_cbmem),
>  				       header.ro_size);
>  		if (ret)
> @@ -294,10 +295,9 @@ static int vpd_probe(struct coreboot_device *dev)
>  	int ret;
> 
>  	vpd_kobj = kobject_create_and_add("vpd", firmware_kobj);
> -	if (!vpd_kobj)
> -		return -ENOMEM;
> +	if (!vpd_kobj) return -ENOMEM;
> 
> -	ret = vpd_sections_init(dev->cbmem_ref.cbmem_addr);
> +	ret = vpd_sections_init(dev);
>  	if (ret) {
>  		kobject_put(vpd_kobj);
>  		return ret;
> diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> index 6f5e8be9689c..137e5240d916 100644
> --- a/drivers/soc/qcom/rmtfs_mem.c
> +++ b/drivers/soc/qcom/rmtfs_mem.c
> @@ -212,10 +212,9 @@ static int qcom_rmtfs_mem_probe(struct
> platform_device *pdev)
>  	rmtfs_mem->dev.groups = qcom_rmtfs_mem_groups;
>  	rmtfs_mem->dev.release = qcom_rmtfs_mem_release_device;
> 
> -	rmtfs_mem->base = devm_memremap(&rmtfs_mem->dev, rmtfs_mem->addr,
> -					rmtfs_mem->size, MEMREMAP_WC);
> +	rmtfs_mem->base = devm_memremap_reserved_mem(&pdev->dev,
> +						     MEMREMAP_WC);
>  	if (IS_ERR(rmtfs_mem->base)) {
> -		dev_err(&pdev->dev, "failed to remap rmtfs_mem region\n");
>  		ret = PTR_ERR(rmtfs_mem->base);
>  		goto put_device;
>  	}
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 303871651f8a..d675a574eeb3 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -982,7 +982,7 @@ static inline void __iomem *__ioremap(phys_addr_t
> offset, size_t size,
>  #ifndef iounmap
>  #define iounmap iounmap
> 
> -static inline void iounmap(void __iomem *addr)
> +static inline void iounmap(const void __iomem *addr)
>  {
>  }
>  #endif
> diff --git a/include/linux/io.h b/include/linux/io.h
> index 16c7f4498869..82e6c4d6bdd3 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -163,7 +163,7 @@ enum {
>  };
> 
>  void *memremap(resource_size_t offset, size_t size, unsigned long flags);
> -void memunmap(void *addr);
> +void memunmap(const void *addr);
> 
>  /*
>   * On x86 PAT systems we have memory tracking that keeps track of
> diff --git a/include/linux/mmiotrace.h b/include/linux/mmiotrace.h
> index 88236849894d..04607c468b73 100644
> --- a/include/linux/mmiotrace.h
> +++ b/include/linux/mmiotrace.h
> @@ -47,7 +47,7 @@ extern int kmmio_handler(struct pt_regs *regs,
> unsigned long addr);
>  /* Called from ioremap.c */
>  extern void mmiotrace_ioremap(resource_size_t offset, unsigned long size,
>  							void __iomem *addr);
> -extern void mmiotrace_iounmap(volatile void __iomem *addr);
> +extern void mmiotrace_iounmap(const volatile void __iomem *addr);
> 
>  /* For anyone to insert markers. Remember trailing newline. */
>  extern __printf(1, 2) int mmiotrace_printk(const char *fmt, ...);
> diff --git a/kernel/iomem.c b/kernel/iomem.c
> index 8d3cf74a32cb..22d0fa336360 100644
> --- a/kernel/iomem.c
> +++ b/kernel/iomem.c
> @@ -130,7 +130,7 @@ void *memremap(resource_size_t offset, size_t
> size, unsigned long flags)
>  }
>  EXPORT_SYMBOL(memremap);
> 
> -void memunmap(void *addr)
> +void memunmap(const void *addr)
>  {
>  	if (is_vmalloc_addr(addr))
>  		iounmap((void __iomem *) addr);
> 
> base-commit: 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b
> prerequisite-patch-id: 62119e27c0c0686e02f0cb55c296b878fb7f5e47
> prerequisite-patch-id: bda32cfc1733c245ae3f141d7c27b18e4adcc628
> prerequisite-patch-id: b8f8097161bd15e87d54dcfbfa67b9ca1abc7204
> prerequisite-patch-id: cd374fb6e39941b8613d213b4a75909749409d63
> prerequisite-patch-id: d8dbc8485a0f86353a314ab5c22fc92d8eac1cc0
> prerequisite-patch-id: e539621b0eccf82aabf9891de69c30398abf76a0
> prerequisite-patch-id: 59d60033b80dec940201edd5aefed22726122a37
> prerequisite-patch-id: 0d16b23cec20eaab7f45ee84fd8d2950657dc72e
> -- 
> https://chromeos.dev
> 

