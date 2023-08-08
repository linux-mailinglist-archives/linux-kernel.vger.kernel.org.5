Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E37B774B51
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232268AbjHHUpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234838AbjHHUoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:44:46 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418D1A7BD;
        Tue,  8 Aug 2023 13:21:52 -0700 (PDT)
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378HWEod002804;
        Tue, 8 Aug 2023 20:16:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=gRDVjkdFRBWObe7mCxcmxP85LQndQ/efs746pBwFFmg=;
 b=J+Vx8WexH75x7ZtnOOwjrKCHiB4y5mHPNDofTjvzYC0nsC67+kSroI88qLizCm+o8QC4
 CoRJLrTIEJiH2Y57NNLW14+AAZIG9f4bpcvBcBuqncgj2l8i7dy+X9ULxPtXy7zpCcBF
 n9gF/5NTbjG/K1o74kHUFvpaRkHuGs9FK3vezCI47RPkvMPmyxH6GeaY+KMcEvWd8z27
 hY7XbY+qgzMsBR8m/Y+mxyEvUUyG2CtGsZsEjCcaGaOsUn+SB0kHzb7FlMAhAunXugRa
 jZPIUaM2WGpZNoNDZ2jW3ymve+nNb46U8FLQdajeNLKliM4h3LkgTArKt/y2bC4kk/f0 xw== 
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3sbrx91tsj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 20:16:25 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id BC3C180371C;
        Tue,  8 Aug 2023 20:16:24 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 42D7D80AE91;
        Tue,  8 Aug 2023 20:16:22 +0000 (UTC)
Date:   Tue, 8 Aug 2023 15:16:20 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>
Subject: Re: [patch v2 38/38] x86/apic/uv: Remove the private leaf 0xb parser
Message-ID: <ZNKilDJMibNwH1ra@swahl-home.5wahls.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120931.779678736@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728120931.779678736@linutronix.de>
X-Proofpoint-GUID: XscqrLCsoL6SmwSAPEhQm4Dvj60dExIo
X-Proofpoint-ORIG-GUID: XscqrLCsoL6SmwSAPEhQm4Dvj60dExIo
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_18,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 clxscore=1015
 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308080179
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looked closely at this one, was wondering about using TOPO_ROOT_DOMAIN
when the original looked at the leaf of TYPE_CORE.  But I think you
probably have it right, and I checked both a newer and an older
system, and the UV info line that prints "apic_pns" gets the same
value as before.

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

On Fri, Jul 28, 2023 at 02:13:30PM +0200, Thomas Gleixner wrote:
> The package shift has been already evaluated by the early CPU init.
> 
> Put the mindless copy right next to the original leaf 0xb parser.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Steve Wahl <steve.wahl@hpe.com>
> Cc: Mike Travis <mike.travis@hpe.com>
> Cc: Dimitri Sivanich <dimitri.sivanich@hpe.com>
> Cc: Russ Anderson <russ.anderson@hpe.com>
> ---
>  arch/x86/include/asm/topology.h    |    5 +++
>  arch/x86/kernel/apic/x2apic_uv_x.c |   52 ++++++-------------------------------
>  2 files changed, 14 insertions(+), 43 deletions(-)
> 
> --- a/arch/x86/include/asm/topology.h
> +++ b/arch/x86/include/asm/topology.h
> @@ -126,6 +126,11 @@ static inline unsigned int topology_get_
>  	return x86_topo_system.dom_size[dom];
>  }
>  
> +static inline unsigned int topology_get_domain_shift(enum x86_topology_domains dom)
> +{
> +	return dom == TOPO_SMT_DOMAIN ? 0 : x86_topo_system.dom_shifts[dom - 1];
> +}
> +
>  extern const struct cpumask *cpu_coregroup_mask(int cpu);
>  extern const struct cpumask *cpu_clustergroup_mask(int cpu);
>  
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -241,54 +241,20 @@ static void __init uv_tsc_check_sync(voi
>  	is_uv(UV3) ? sname.s3.field :		\
>  	undef)
>  
> -/* [Copied from arch/x86/kernel/cpu/topology.c:detect_extended_topology()] */
> -
> -#define SMT_LEVEL			0	/* Leaf 0xb SMT level */
> -#define INVALID_TYPE			0	/* Leaf 0xb sub-leaf types */
> -#define SMT_TYPE			1
> -#define CORE_TYPE			2
> -#define LEAFB_SUBTYPE(ecx)		(((ecx) >> 8) & 0xff)
> -#define BITS_SHIFT_NEXT_LEVEL(eax)	((eax) & 0x1f)
> -
> -static void set_x2apic_bits(void)
> -{
> -	unsigned int eax, ebx, ecx, edx, sub_index;
> -	unsigned int sid_shift;
> -
> -	cpuid(0, &eax, &ebx, &ecx, &edx);
> -	if (eax < 0xb) {
> -		pr_info("UV: CPU does not have CPUID.11\n");
> -		return;
> -	}
> -
> -	cpuid_count(0xb, SMT_LEVEL, &eax, &ebx, &ecx, &edx);
> -	if (ebx == 0 || (LEAFB_SUBTYPE(ecx) != SMT_TYPE)) {
> -		pr_info("UV: CPUID.11 not implemented\n");
> -		return;
> -	}
> -
> -	sid_shift = BITS_SHIFT_NEXT_LEVEL(eax);
> -	sub_index = 1;
> -	do {
> -		cpuid_count(0xb, sub_index, &eax, &ebx, &ecx, &edx);
> -		if (LEAFB_SUBTYPE(ecx) == CORE_TYPE) {
> -			sid_shift = BITS_SHIFT_NEXT_LEVEL(eax);
> -			break;
> -		}
> -		sub_index++;
> -	} while (LEAFB_SUBTYPE(ecx) != INVALID_TYPE);
> -
> -	uv_cpuid.apicid_shift	= 0;
> -	uv_cpuid.apicid_mask	= (~(-1 << sid_shift));
> -	uv_cpuid.socketid_shift = sid_shift;
> -}
> -
>  static void __init early_get_apic_socketid_shift(void)
>  {
> +	unsigned int sid_shift = topology_get_domain_shift(TOPO_ROOT_DOMAIN);
> +
>  	if (is_uv2_hub() || is_uv3_hub())
>  		uvh_apicid.v = uv_early_read_mmr(UVH_APICID);
>  
> -	set_x2apic_bits();
> +	if (sid_shift) {
> +		uv_cpuid.apicid_shift	= 0;
> +		uv_cpuid.apicid_mask	= (~(-1 << sid_shift));
> +		uv_cpuid.socketid_shift = sid_shift;
> +	} else {
> +		pr_info("UV: CPU does not have valid CPUID.11\n");
> +	}
>  
>  	pr_info("UV: apicid_shift:%d apicid_mask:0x%x\n", uv_cpuid.apicid_shift, uv_cpuid.apicid_mask);
>  	pr_info("UV: socketid_shift:%d pnode_mask:0x%x\n", uv_cpuid.socketid_shift, uv_cpuid.pnode_mask);
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
