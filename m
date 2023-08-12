Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9051D779F47
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237075AbjHLKt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237086AbjHLKtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:49:25 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D332127;
        Sat, 12 Aug 2023 03:48:53 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37CAJoGG001758;
        Sat, 12 Aug 2023 10:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=pHcgMyXfl6z8JjUNXCvs1+SGwqPjT94l6NtAGbR9eaE=;
 b=BdEJ/OmOJw4JeWAodh6XZKTTDFiZsYKM9XmimVKW+bpTydONWm5IYyzV60CYTDNR1Fnu
 AlXZP/RJjA6vdN1Np/XTHlglT+bqc79v5tdcnd7XCqwZJOO7aYdUweiMRwoJqD5Y9xM1
 Kcnbaar06ccl4jn7EgQNx6mSWFcIi6ihI0YlhIrY+oJA7vjQ/ocG/Xvwdj6p6B5X6dVp
 Hlbat4nfHtGnS2/EZ5FH20F+qrZqpFy5SVcHy6IYGAo2iROaueFN0S06RJpExCxCX8rW
 0JJ86dasfWwhA67QdcbHVcR9GLVUXUSxjkuLfeKXIsKBEncCnd7qdTLAdR6DTkBZ4lJP Hw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3se87wgcd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 10:48:08 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37CAbSYn012907;
        Sat, 12 Aug 2023 10:48:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3se87wgccf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 10:48:07 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37C9VSYE017612;
        Sat, 12 Aug 2023 10:48:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3se2ydj4fs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Aug 2023 10:48:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37CAm40W14811696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Aug 2023 10:48:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0AABE20043;
        Sat, 12 Aug 2023 10:48:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56AEC20040;
        Sat, 12 Aug 2023 10:47:54 +0000 (GMT)
Received: from [9.43.125.184] (unknown [9.43.125.184])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 12 Aug 2023 10:47:54 +0000 (GMT)
Message-ID: <188cfb39-7d10-967b-3150-22dac6e95baa@linux.ibm.com>
Date:   Sat, 12 Aug 2023 16:17:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v27 2/8] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230811170642.6696-1-eric.devolder@oracle.com>
 <20230811170642.6696-3-eric.devolder@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20230811170642.6696-3-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0TnRMt3wwTfxhoKGQyXDfW-VCdQl6Vhh
X-Proofpoint-ORIG-GUID: VXUlIvEhGxI7VATrM6Bx-5BTvNl9poBU
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-12_09,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 clxscore=1011
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308120098
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

On 11/08/23 22:36, Eric DeVolder wrote:
> To support crash hotplug, a mechanism is needed to update the crash
> elfcorehdr upon CPU or memory changes (eg. hot un/plug or off/
> onlining). The crash elfcorehdr describes the CPUs and memory to
> be written into the vmcore.
>
> To track CPU changes, callbacks are registered with the cpuhp
> mechanism via cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN). The
> crash hotplug elfcorehdr update has no explicit ordering requirement
> (relative to other cpuhp states), so meets the criteria for
> utilizing CPUHP_BP_PREPARE_DYN. CPUHP_BP_PREPARE_DYN is a dynamic
> state and avoids the need to introduce a new state for crash
> hotplug. Also, CPUHP_BP_PREPARE_DYN is the last state in the PREPARE
> group, just prior to the STARTING group, which is very close to the
> CPU starting up in a plug/online situation, or stopping in a unplug/
> offline situation. This minimizes the window of time during an
> actual plug/online or unplug/offline situation in which the
> elfcorehdr would be inaccurate. Note that for a CPU being unplugged
> or offlined, the CPU will still be present in the list of CPUs
> generated by crash_prepare_elf64_headers(). However, there is no
> need to explicitly omit the CPU, see justification in
> 'crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()'.
>
> To track memory changes, a notifier is registered to capture the
> memblock MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>
> The CPU callbacks and memory notifiers invoke crash_handle_hotplug_event()
> which performs needed tasks and then dispatches the event to the
> architecture specific arch_crash_handle_hotplug_event() to update the
> elfcorehdr with the current state of CPUs and memory. During the
> process, the kexec_lock is held.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>   include/linux/crash_core.h |   9 +++
>   include/linux/kexec.h      |  11 +++
>   kernel/Kconfig.kexec       |  31 ++++++++
>   kernel/crash_core.c        | 142 +++++++++++++++++++++++++++++++++++++
>   kernel/kexec_core.c        |   6 ++
>   5 files changed, 199 insertions(+)
>
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e..e14345cc7a22 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -84,4 +84,13 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>   		unsigned long long *crash_size, unsigned long long *crash_base);
>   
> +#define KEXEC_CRASH_HP_NONE			0
> +#define KEXEC_CRASH_HP_ADD_CPU			1
> +#define KEXEC_CRASH_HP_REMOVE_CPU		2
> +#define KEXEC_CRASH_HP_ADD_MEMORY		3
> +#define KEXEC_CRASH_HP_REMOVE_MEMORY		4
> +#define KEXEC_CRASH_HP_INVALID_CPU		-1U
> +
> +struct kimage;
> +
>   #endif /* LINUX_CRASH_CORE_H */
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 811a90e09698..b9903dd48e24 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
>   #include <linux/compat.h>
>   #include <linux/ioport.h>
>   #include <linux/module.h>
> +#include <linux/highmem.h>
>   #include <asm/kexec.h>
>   
>   /* Verify architecture specific macros are defined */
> @@ -360,6 +361,12 @@ struct kimage {
>   	struct purgatory_info purgatory_info;
>   #endif
>   
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	int hp_action;
> +	int elfcorehdr_index;
> +	bool elfcorehdr_updated;
> +#endif
> +
>   #ifdef CONFIG_IMA_KEXEC
>   	/* Virtual address of IMA measurement buffer for kexec syscall */
>   	void *ima_buffer;
> @@ -490,6 +497,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>   static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
>   #endif
>   
> +#ifndef arch_crash_handle_hotplug_event
> +static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
> +#endif
> +

Isn't the above function should be declare under CONFIG_CRASH_HOTPLUG?

Thanks,
Sourabh

>   #else /* !CONFIG_KEXEC_CORE */
>   struct pt_regs;
>   struct task_struct;
> diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
> index ff72e45cfaef..d0a9a5392035 100644
> --- a/kernel/Kconfig.kexec
> +++ b/kernel/Kconfig.kexec
> @@ -113,4 +113,35 @@ config CRASH_DUMP
>   	  For s390, this option also enables zfcpdump.
>   	  See also <file:Documentation/s390/zfcpdump.rst>
>   
> +config CRASH_HOTPLUG
> +	bool "Update the crash elfcorehdr on system configuration changes"
> +	default y
> +	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> +	depends on ARCH_SUPPORTS_CRASH_HOTPLUG
> +	help
> +	  Enable direct update to the crash elfcorehdr (which contains
> +	  the list of CPUs and memory regions to be dumped upon a crash)
> +	  in response to hot plug/unplug or online/offline of CPUs or
> +	  memory. This is a much more advanced approach than userspace
> +	  attempting that.
> +
> +	  If unsure, say Y.
> +
> +config CRASH_MAX_MEMORY_RANGES
> +	int "Specify the maximum number of memory regions for the elfcorehdr"
> +	default 8192
> +	depends on CRASH_HOTPLUG
> +	help
> +	  For the kexec_file_load() syscall path, specify the maximum number of
> +	  memory regions that the elfcorehdr buffer/segment can accommodate.
> +	  These regions are obtained via walk_system_ram_res(); eg. the
> +	  'System RAM' entries in /proc/iomem.
> +	  This value is combined with NR_CPUS_DEFAULT and multiplied by
> +	  sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
> +	  segment size.
> +	  The value 8192, for example, covers a (sparsely populated) 1TiB system
> +	  consisting of 128MiB memblocks, while resulting in an elfcorehdr
> +	  memory buffer/segment size under 1MiB. This represents a sane choice
> +	  to accommodate both baremetal and virtual machine configurations.
> +
>   endmenu
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index b7c30b748a16..53d211c690a1 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -11,6 +11,8 @@
>   #include <linux/vmalloc.h>
>   #include <linux/sizes.h>
>   #include <linux/kexec.h>
> +#include <linux/memory.h>
> +#include <linux/cpuhotplug.h>
>   
>   #include <asm/page.h>
>   #include <asm/sections.h>
> @@ -18,6 +20,7 @@
>   #include <crypto/sha1.h>
>   
>   #include "kallsyms_internal.h"
> +#include "kexec_internal.h"
>   
>   /* vmcoreinfo stuff */
>   unsigned char *vmcoreinfo_data;
> @@ -697,3 +700,142 @@ static int __init crash_save_vmcoreinfo_init(void)
>   }
>   
>   subsys_initcall(crash_save_vmcoreinfo_init);
> +
> +#ifdef CONFIG_CRASH_HOTPLUG
> +#undef pr_fmt
> +#define pr_fmt(fmt) "crash hp: " fmt
> +/*
> + * To accurately reflect hot un/plug changes of cpu and memory resources
> + * (including onling and offlining of those resources), the elfcorehdr
> + * (which is passed to the crash kernel via the elfcorehdr= parameter)
> + * must be updated with the new list of CPUs and memories.
> + *
> + * In order to make changes to elfcorehdr, two conditions are needed:
> + * First, the segment containing the elfcorehdr must be large enough
> + * to permit a growing number of resources; the elfcorehdr memory size
> + * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
> + * Second, purgatory must explicitly exclude the elfcorehdr from the
> + * list of segments it checks (since the elfcorehdr changes and thus
> + * would require an update to purgatory itself to update the digest).
> + */
> +static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
> +{
> +	struct kimage *image;
> +
> +	/* Obtain lock while changing crash information */
> +	if (!kexec_trylock()) {
> +		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
> +		return;
> +	}
> +
> +	/* Check kdump is not loaded */
> +	if (!kexec_crash_image)
> +		goto out;
> +
> +	image = kexec_crash_image;
> +
> +	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
> +		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
> +		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
> +	else
> +		pr_debug("hp_action %u\n", hp_action);
> +
> +	/*
> +	 * The elfcorehdr_index is set to -1 when the struct kimage
> +	 * is allocated. Find the segment containing the elfcorehdr,
> +	 * if not already found.
> +	 */
> +	if (image->elfcorehdr_index < 0) {
> +		unsigned long mem;
> +		unsigned char *ptr;
> +		unsigned int n;
> +
> +		for (n = 0; n < image->nr_segments; n++) {
> +			mem = image->segment[n].mem;
> +			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
> +			if (ptr) {
> +				/* The segment containing elfcorehdr */
> +				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
> +					image->elfcorehdr_index = (int)n;
> +				kunmap_local(ptr);
> +			}
> +		}
> +	}
> +
> +	if (image->elfcorehdr_index < 0) {
> +		pr_err("unable to locate elfcorehdr segment");
> +		goto out;
> +	}
> +
> +	/* Needed in order for the segments to be updated */
> +	arch_kexec_unprotect_crashkres();
> +
> +	/* Differentiate between normal load and hotplug update */
> +	image->hp_action = hp_action;
> +
> +	/* Now invoke arch-specific update handler */
> +	arch_crash_handle_hotplug_event(image);
> +
> +	/* No longer handling a hotplug event */
> +	image->hp_action = KEXEC_CRASH_HP_NONE;
> +	image->elfcorehdr_updated = true;
> +
> +	/* Change back to read-only */
> +	arch_kexec_protect_crashkres();
> +
> +	/* Errors in the callback is not a reason to rollback state */
> +out:
> +	/* Release lock now that update complete */
> +	kexec_unlock();
> +}
> +
> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
> +{
> +	switch (val) {
> +	case MEM_ONLINE:
> +		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
> +			KEXEC_CRASH_HP_INVALID_CPU);
> +		break;
> +
> +	case MEM_OFFLINE:
> +		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
> +			KEXEC_CRASH_HP_INVALID_CPU);
> +		break;
> +	}
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block crash_memhp_nb = {
> +	.notifier_call = crash_memhp_notifier,
> +	.priority = 0
> +};
> +
> +static int crash_cpuhp_online(unsigned int cpu)
> +{
> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
> +	return 0;
> +}
> +
> +static int crash_cpuhp_offline(unsigned int cpu)
> +{
> +	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
> +	return 0;
> +}
> +
> +static int __init crash_hotplug_init(void)
> +{
> +	int result = 0;
> +
> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
> +		register_memory_notifier(&crash_memhp_nb);
> +
> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
> +		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
> +			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
> +	}
> +
> +	return result;
> +}
> +
> +subsys_initcall(crash_hotplug_init);
> +#endif
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index e2f2574d8b74..5d323255862a 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -277,6 +277,12 @@ struct kimage *do_kimage_alloc_init(void)
>   	/* Initialize the list of unusable pages */
>   	INIT_LIST_HEAD(&image->unusable_pages);
>   
> +#ifdef CONFIG_CRASH_HOTPLUG
> +	image->hp_action = KEXEC_CRASH_HP_NONE;
> +	image->elfcorehdr_index = -1;
> +	image->elfcorehdr_updated = false;
> +#endif
> +
>   	return image;
>   }
>   

