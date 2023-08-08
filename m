Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14058774B87
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjHHUt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjHHUtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:49:16 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612B21855E;
        Tue,  8 Aug 2023 13:30:43 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378Hs1BW004093;
        Tue, 8 Aug 2023 20:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=itSXifGGl6H3TAHgjYKUXESilEk1JSdyNvoZGD28Q2c=;
 b=T2HY2eAOnKpRH/MkEGgZxS+AZAQKK/dh3NTfOtPSziE2IqiZ0OQT2CRBhQjwB6F/D9UL
 T066jjFbPT3e2vP+0lSuMkh54X4Ds5DpphMvxMpwUR7yDtgQx1HGAPOYJUe9CRjCRos8
 ACdKaHBEKVSlKTfDKLDPZgD9G3AR+Fd16p3Kte7hMtenF6uw3EEvWhgrabtBuEiqgKYe
 oJnc5y4qyHS2FwrfD2fAlbPLzd1EF12KHhW7xXPzchR9VYwBametjH88qPUiogkCSRJQ
 lGp4g1OBf0Io5mqFzrWzcpdMf0UiNjdNWwVT+HKoyegcj1/IscwResoDRvVIdTpkmtca qw== 
Received: from p1lg14880.it.hpe.com ([16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3sbtgvh1ku-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 20:16:13 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 9CB4F801729;
        Tue,  8 Aug 2023 20:15:57 +0000 (UTC)
Received: from swahl-home.5wahls.com (unknown [16.231.227.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTPS id 42CEC8081D7;
        Tue,  8 Aug 2023 20:15:55 +0000 (UTC)
Date:   Tue, 8 Aug 2023 15:15:53 -0500
From:   Steve Wahl <steve.wahl@hpe.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
        Steve Wahl <steve.wahl@hpe.com>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>
Subject: Re: [patch v2 36/38] x86/apic: Remove unused phys_pkg_id() callback
Message-ID: <ZNKieb2LuGcG7AO+@swahl-home.5wahls.com>
References: <20230728105650.565799744@linutronix.de>
 <20230728120931.670346058@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728120931.670346058@linutronix.de>
X-Proofpoint-GUID: 2bRpwvJ0UQcWXi96rP6kTiPSV-_1uhLV
X-Proofpoint-ORIG-GUID: 2bRpwvJ0UQcWXi96rP6kTiPSV-_1uhLV
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_18,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080180
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

Reviewed-by: Steve Wahl <steve.wahl@hpe.com>

On Fri, Jul 28, 2023 at 02:13:27PM +0200, Thomas Gleixner wrote:
> Now that the core code does not use this monstrosity anymore, it's time to
> put it to rest.
> 
> The only real purpose was to read the APIC ID on UV and VSMP systems for
> the actual evaluation. That's what the core code does now.
> 
> For doing the actual shift operation there is truly no APIC callback
> required.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/include/asm/apic.h           |    1 -
>  arch/x86/kernel/apic/apic_flat_64.c   |    7 -------
>  arch/x86/kernel/apic/apic_noop.c      |    3 ---
>  arch/x86/kernel/apic/apic_numachip.c  |    7 -------
>  arch/x86/kernel/apic/bigsmp_32.c      |    6 ------
>  arch/x86/kernel/apic/local.h          |    1 -
>  arch/x86/kernel/apic/probe_32.c       |    6 ------
>  arch/x86/kernel/apic/x2apic_cluster.c |    1 -
>  arch/x86/kernel/apic/x2apic_phys.c    |    6 ------
>  arch/x86/kernel/apic/x2apic_uv_x.c    |   11 -----------
>  arch/x86/kernel/vsmp_64.c             |   13 -------------
>  arch/x86/xen/apic.c                   |    6 ------
>  12 files changed, 68 deletions(-)
> 
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -296,7 +296,6 @@ struct apic {
>  	void	(*init_apic_ldr)(void);
>  	void	(*ioapic_phys_id_map)(physid_mask_t *phys_map, physid_mask_t *retmap);
>  	u32	(*cpu_present_to_apicid)(int mps_cpu);
> -	u32	(*phys_pkg_id)(u32 cpuid_apic, int index_msb);
>  
>  	u32	(*get_apic_id)(u32 id);
>  	u32	(*set_apic_id)(u32 apicid);
> --- a/arch/x86/kernel/apic/apic_flat_64.c
> +++ b/arch/x86/kernel/apic/apic_flat_64.c
> @@ -66,11 +66,6 @@ static u32 set_apic_id(u32 id)
>  	return (id & 0xFF) << 24;
>  }
>  
> -static u32 flat_phys_pkg_id(u32 initial_apic_id, int index_msb)
> -{
> -	return initial_apic_id >> index_msb;
> -}
> -
>  static int flat_probe(void)
>  {
>  	return 1;
> @@ -89,7 +84,6 @@ static struct apic apic_flat __ro_after_
>  
>  	.init_apic_ldr			= default_init_apic_ldr,
>  	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
> -	.phys_pkg_id			= flat_phys_pkg_id,
>  
>  	.max_apic_id			= 0xFE,
>  	.get_apic_id			= flat_get_apic_id,
> @@ -159,7 +153,6 @@ static struct apic apic_physflat __ro_af
>  	.disable_esr			= 0,
>  
>  	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
> -	.phys_pkg_id			= flat_phys_pkg_id,
>  
>  	.max_apic_id			= 0xFE,
>  	.get_apic_id			= flat_get_apic_id,
> --- a/arch/x86/kernel/apic/apic_noop.c
> +++ b/arch/x86/kernel/apic/apic_noop.c
> @@ -29,7 +29,6 @@ static void noop_send_IPI_self(int vecto
>  static void noop_apic_icr_write(u32 low, u32 id) { }
>  static int noop_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip) { return -1; }
>  static u64 noop_apic_icr_read(void) { return 0; }
> -static u32 noop_phys_pkg_id(u32 cpuid_apic, int index_msb) { return 0; }
>  static u32 noop_get_apic_id(u32 apicid) { return 0; }
>  static void noop_apic_eoi(void) { }
>  
> @@ -56,8 +55,6 @@ struct apic apic_noop __ro_after_init =
>  	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
>  	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
>  
> -	.phys_pkg_id			= noop_phys_pkg_id,
> -
>  	.max_apic_id			= 0xFE,
>  	.get_apic_id			= noop_get_apic_id,
>  
> --- a/arch/x86/kernel/apic/apic_numachip.c
> +++ b/arch/x86/kernel/apic/apic_numachip.c
> @@ -56,11 +56,6 @@ static u32 numachip2_set_apic_id(u32 id)
>  	return id << 24;
>  }
>  
> -static u32 numachip_phys_pkg_id(u32 initial_apic_id, int index_msb)
> -{
> -	return initial_apic_id >> index_msb;
> -}
> -
>  static void numachip1_apic_icr_write(int apicid, unsigned int val)
>  {
>  	write_lcsr(CSR_G3_EXT_IRQ_GEN, (apicid << 16) | val);
> @@ -228,7 +223,6 @@ static const struct apic apic_numachip1
>  	.disable_esr			= 0,
>  
>  	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
> -	.phys_pkg_id			= numachip_phys_pkg_id,
>  
>  	.max_apic_id			= UINT_MAX,
>  	.get_apic_id			= numachip1_get_apic_id,
> @@ -265,7 +259,6 @@ static const struct apic apic_numachip2
>  	.disable_esr			= 0,
>  
>  	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
> -	.phys_pkg_id			= numachip_phys_pkg_id,
>  
>  	.max_apic_id			= UINT_MAX,
>  	.get_apic_id			= numachip2_get_apic_id,
> --- a/arch/x86/kernel/apic/bigsmp_32.c
> +++ b/arch/x86/kernel/apic/bigsmp_32.c
> @@ -29,11 +29,6 @@ static void bigsmp_ioapic_phys_id_map(ph
>  	physids_promote(0xFFL, retmap);
>  }
>  
> -static u32 bigsmp_phys_pkg_id(u32 cpuid_apic, int index_msb)
> -{
> -	return cpuid_apic >> index_msb;
> -}
> -
>  static void bigsmp_send_IPI_allbutself(int vector)
>  {
>  	default_send_IPI_mask_allbutself_phys(cpu_online_mask, vector);
> @@ -88,7 +83,6 @@ static struct apic apic_bigsmp __ro_afte
>  	.check_apicid_used		= bigsmp_check_apicid_used,
>  	.ioapic_phys_id_map		= bigsmp_ioapic_phys_id_map,
>  	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
> -	.phys_pkg_id			= bigsmp_phys_pkg_id,
>  
>  	.max_apic_id			= 0xFE,
>  	.get_apic_id			= bigsmp_get_apic_id,
> --- a/arch/x86/kernel/apic/local.h
> +++ b/arch/x86/kernel/apic/local.h
> @@ -17,7 +17,6 @@
>  void __x2apic_send_IPI_dest(unsigned int apicid, int vector, unsigned int dest);
>  u32 x2apic_get_apic_id(u32 id);
>  u32 x2apic_set_apic_id(u32 id);
> -u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb);
>  
>  void x2apic_send_IPI_all(int vector);
>  void x2apic_send_IPI_allbutself(int vector);
> --- a/arch/x86/kernel/apic/probe_32.c
> +++ b/arch/x86/kernel/apic/probe_32.c
> @@ -18,11 +18,6 @@
>  
>  #include "local.h"
>  
> -static u32 default_phys_pkg_id(u32 cpuid_apic, int index_msb)
> -{
> -	return cpuid_apic >> index_msb;
> -}
> -
>  static u32 default_get_apic_id(u32 x)
>  {
>  	unsigned int ver = GET_APIC_VERSION(apic_read(APIC_LVR));
> @@ -54,7 +49,6 @@ static struct apic apic_default __ro_aft
>  	.init_apic_ldr			= default_init_apic_ldr,
>  	.ioapic_phys_id_map		= default_ioapic_phys_id_map,
>  	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
> -	.phys_pkg_id			= default_phys_pkg_id,
>  
>  	.max_apic_id			= 0xFE,
>  	.get_apic_id			= default_get_apic_id,
> --- a/arch/x86/kernel/apic/x2apic_cluster.c
> +++ b/arch/x86/kernel/apic/x2apic_cluster.c
> @@ -236,7 +236,6 @@ static struct apic apic_x2apic_cluster _
>  	.init_apic_ldr			= init_x2apic_ldr,
>  	.ioapic_phys_id_map		= NULL,
>  	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
> -	.phys_pkg_id			= x2apic_phys_pkg_id,
>  
>  	.max_apic_id			= UINT_MAX,
>  	.x2apic_set_max_apicid		= true,
> --- a/arch/x86/kernel/apic/x2apic_phys.c
> +++ b/arch/x86/kernel/apic/x2apic_phys.c
> @@ -134,11 +134,6 @@ u32 x2apic_set_apic_id(u32 id)
>  	return id;
>  }
>  
> -u32 x2apic_phys_pkg_id(u32 initial_apicid, int index_msb)
> -{
> -	return initial_apicid >> index_msb;
> -}
> -
>  static struct apic apic_x2apic_phys __ro_after_init = {
>  
>  	.name				= "physical x2apic",
> @@ -151,7 +146,6 @@ static struct apic apic_x2apic_phys __ro
>  	.disable_esr			= 0,
>  
>  	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
> -	.phys_pkg_id			= x2apic_phys_pkg_id,
>  
>  	.max_apic_id			= UINT_MAX,
>  	.x2apic_set_max_apicid		= true,
> --- a/arch/x86/kernel/apic/x2apic_uv_x.c
> +++ b/arch/x86/kernel/apic/x2apic_uv_x.c
> @@ -785,16 +785,6 @@ static u32 set_apic_id(u32 id)
>  	return id;
>  }
>  
> -static unsigned int uv_read_apic_id(void)
> -{
> -	return x2apic_get_apic_id(apic_read(APIC_ID));
> -}
> -
> -static u32 uv_phys_pkg_id(u32 initial_apicid, int index_msb)
> -{
> -	return uv_read_apic_id() >> index_msb;
> -}
> -
>  static int uv_probe(void)
>  {
>  	return apic == &apic_x2apic_uv_x;
> @@ -812,7 +802,6 @@ static struct apic apic_x2apic_uv_x __ro
>  	.disable_esr			= 0,
>  
>  	.cpu_present_to_apicid		= default_cpu_present_to_apicid,
> -	.phys_pkg_id			= uv_phys_pkg_id,
>  
>  	.max_apic_id			= UINT_MAX,
>  	.get_apic_id			= x2apic_get_apic_id,
> --- a/arch/x86/kernel/vsmp_64.c
> +++ b/arch/x86/kernel/vsmp_64.c
> @@ -127,25 +127,12 @@ static void __init vsmp_cap_cpus(void)
>  #endif
>  }
>  
> -static u32 apicid_phys_pkg_id(u32 initial_apic_id, int index_msb)
> -{
> -	return read_apic_id() >> index_msb;
> -}
> -
> -static void vsmp_apic_post_init(void)
> -{
> -	/* need to update phys_pkg_id */
> -	apic->phys_pkg_id = apicid_phys_pkg_id;
> -}
> -
>  void __init vsmp_init(void)
>  {
>  	detect_vsmp_box();
>  	if (!is_vsmp_box())
>  		return;
>  
> -	x86_platform.apic_post_init = vsmp_apic_post_init;
> -
>  	vsmp_cap_cpus();
>  
>  	set_vsmp_ctl();
> --- a/arch/x86/xen/apic.c
> +++ b/arch/x86/xen/apic.c
> @@ -110,11 +110,6 @@ static int xen_madt_oem_check(char *oem_
>  	return xen_pv_domain();
>  }
>  
> -static u32 xen_phys_pkg_id(u32 initial_apic_id, int index_msb)
> -{
> -	return initial_apic_id >> index_msb;
> -}
> -
>  static u32 xen_cpu_present_to_apicid(int cpu)
>  {
>  	if (cpu_present(cpu))
> @@ -133,7 +128,6 @@ static struct apic xen_pv_apic __ro_afte
>  	.disable_esr			= 0,
>  
>  	.cpu_present_to_apicid		= xen_cpu_present_to_apicid,
> -	.phys_pkg_id			= xen_phys_pkg_id, /* detect_ht */
>  
>  	.max_apic_id			= UINT_MAX,
>  	.get_apic_id			= xen_get_apic_id,
> 

-- 
Steve Wahl, Hewlett Packard Enterprise
