Return-Path: <linux-kernel+bounces-5688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FE1818E0C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 818761C249ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2CD22EF2;
	Tue, 19 Dec 2023 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6nOtiGg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717E7225A5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703006838; x=1734542838;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/Qfuvo5n0slrMN1eV75HqOAH3a5+f/NhfY2gXMSDWj4=;
  b=Z6nOtiGgCwc9GNDHdagWhZSoTg8/59rOkNtVDnVxaOwXJhuOFlogYtaQ
   2239Ei4vlzk67JXh2XmRDEsmXFnobi3Da/TRt1qz/tycrwAXJYqBrskid
   n0CUEptkBXgETET9FeLry8hvqoLbntNOLeLwtyMiYdgWzl3ULZ4VzDGxL
   2KEO4JOiR51ZGxcA7rLanDWZxXCqE95Ykhq87qMOKhr+OBInngwpoeoES
   gT4CAFFtaIOrLRfc24gSDKyx2LUY9Ju/TBWj+V5zLVlscMdbfa0qW5ouU
   bcpugBP+//jDTfG1osAn/qzjKX5PsSDZ042JA2QRWleycRN+ihbGHL684
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2925867"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="2925867"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 09:27:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="17679088"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 19 Dec 2023 09:27:16 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFds9-0005kD-2V;
	Tue, 19 Dec 2023 17:27:13 +0000
Date: Wed, 20 Dec 2023 01:26:53 +0800
From: kernel test robot <lkp@intel.com>
To: Hari Bathini <hbathini@linux.vnet.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: arch/powerpc/platforms/powernv/opal-core.c:96:24: sparse: sparse:
 incorrect type in assignment (different base types)
Message-ID: <202312200144.z1CH6ZPc-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2cf4f94d8e8646803f8fb0facf134b0cd7fb691a
commit: 6f713d18144ce86c9f01cdf64222d6339e26129e powerpc/opalcore: export /sys/firmware/opal/core for analysing opal crashes
date:   4 years, 3 months ago
config: powerpc64-randconfig-r113-20231118 (https://download.01.org/0day-ci/archive/20231220/202312200144.z1CH6ZPc-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231220/202312200144.z1CH6ZPc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312200144.z1CH6ZPc-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/powerpc/platforms/powernv/opal-core.c:96:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] n_namesz @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:96:24: sparse:     expected unsigned int [usertype] n_namesz
   arch/powerpc/platforms/powernv/opal-core.c:96:24: sparse:     got restricted __be32 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:97:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] n_descsz @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:97:24: sparse:     expected unsigned int [usertype] n_descsz
   arch/powerpc/platforms/powernv/opal-core.c:97:24: sparse:     got restricted __be32 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:98:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] n_type @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:98:24: sparse:     expected unsigned int [usertype] n_type
   arch/powerpc/platforms/powernv/opal-core.c:98:24: sparse:     got restricted __be32 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:119:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [usertype] pr_pid @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:119:27: sparse:     expected int [usertype] pr_pid
   arch/powerpc/platforms/powernv/opal-core.c:119:27: sparse:     got restricted __be32 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:120:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected int [usertype] pr_ppid @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:120:27: sparse:     expected int [usertype] pr_ppid
   arch/powerpc/platforms/powernv/opal-core.c:120:27: sparse:     got restricted __be32 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:130:37: sparse: sparse: incorrect type in assignment (different base types) @@     expected short pr_cursig @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:130:37: sparse:     expected short pr_cursig
   arch/powerpc/platforms/powernv/opal-core.c:130:37: sparse:     got restricted __be16 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:143:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:143:21: sparse:     expected unsigned long long [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:143:21: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:144:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:144:21: sparse:     expected unsigned long long [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:144:21: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:147:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:147:21: sparse:     expected unsigned long long [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:147:21: sparse:     got restricted __be64 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:274:17: sparse: sparse: cast to restricted __be64
>> arch/powerpc/platforms/powernv/opal-core.c:274:17: sparse: sparse: cast to restricted __be64
>> arch/powerpc/platforms/powernv/opal-core.c:360:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] e_type @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:360:21: sparse:     expected unsigned short [usertype] e_type
   arch/powerpc/platforms/powernv/opal-core.c:360:21: sparse:     got restricted __be16 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:361:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] e_machine @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:361:24: sparse:     expected unsigned short [usertype] e_machine
   arch/powerpc/platforms/powernv/opal-core.c:361:24: sparse:     got restricted __be16 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:362:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] e_version @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:362:24: sparse:     expected unsigned int [usertype] e_version
   arch/powerpc/platforms/powernv/opal-core.c:362:24: sparse:     got restricted __be32 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:364:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] e_phoff @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:364:22: sparse:     expected unsigned long long [usertype] e_phoff
   arch/powerpc/platforms/powernv/opal-core.c:364:22: sparse:     got restricted __be64 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:368:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] e_ehsize @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:368:23: sparse:     expected unsigned short [usertype] e_ehsize
   arch/powerpc/platforms/powernv/opal-core.c:368:23: sparse:     got restricted __be16 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:369:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] e_phentsize @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:369:26: sparse:     expected unsigned short [usertype] e_phentsize
   arch/powerpc/platforms/powernv/opal-core.c:369:26: sparse:     got restricted __be16 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:377:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] p_type @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:377:25: sparse:     expected unsigned int [usertype] p_type
   arch/powerpc/platforms/powernv/opal-core.c:377:25: sparse:     got restricted __be32 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:381:25: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_offset @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:381:25: sparse:     expected unsigned long long [usertype] p_offset
   arch/powerpc/platforms/powernv/opal-core.c:381:25: sparse:     got restricted __be64 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:382:41: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_memsz @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:382:41: sparse:     expected unsigned long long [usertype] p_memsz
   arch/powerpc/platforms/powernv/opal-core.c:382:41: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:391:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] p_type @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:391:33: sparse:     expected unsigned int [usertype] p_type
   arch/powerpc/platforms/powernv/opal-core.c:391:33: sparse:     got restricted __be32 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:392:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] p_flags @@     got restricted __be32 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:392:33: sparse:     expected unsigned int [usertype] p_flags
   arch/powerpc/platforms/powernv/opal-core.c:392:33: sparse:     got restricted __be32 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:403:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_paddr @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:403:33: sparse:     expected unsigned long long [usertype] p_paddr
   arch/powerpc/platforms/powernv/opal-core.c:403:33: sparse:     got restricted __be64 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:404:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_vaddr @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:404:33: sparse:     expected unsigned long long [usertype] p_vaddr
   arch/powerpc/platforms/powernv/opal-core.c:404:33: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:405:50: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_memsz @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:405:50: sparse:     expected unsigned long long [usertype] p_memsz
   arch/powerpc/platforms/powernv/opal-core.c:405:50: sparse:     got restricted __be64 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:407:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] p_offset @@     got restricted __be64 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:407:33: sparse:     expected unsigned long long [usertype] p_offset
   arch/powerpc/platforms/powernv/opal-core.c:407:33: sparse:     got restricted __be64 [usertype]
>> arch/powerpc/platforms/powernv/opal-core.c:414:22: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] e_phnum @@     got restricted __be16 [usertype] @@
   arch/powerpc/platforms/powernv/opal-core.c:414:22: sparse:     expected unsigned short [usertype] e_phnum
   arch/powerpc/platforms/powernv/opal-core.c:414:22: sparse:     got restricted __be16 [usertype]
   arch/powerpc/platforms/powernv/opal-core.c:479:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-core.c:490:16: sparse: sparse: cast to restricted __be64
   arch/powerpc/platforms/powernv/opal-core.c: note: in included file:
   arch/powerpc/platforms/powernv/opal-fadump.h:134:33: sparse: sparse: restricted __be64 degrades to integer

vim +96 arch/powerpc/platforms/powernv/opal-core.c

    88	
    89	static Elf64_Word *append_elf64_note(Elf64_Word *buf, char *name,
    90					     u32 type, void *data,
    91					     size_t data_len)
    92	{
    93		Elf64_Nhdr *note = (Elf64_Nhdr *)buf;
    94		Elf64_Word namesz = strlen(name) + 1;
    95	
  > 96		note->n_namesz = cpu_to_be32(namesz);
  > 97		note->n_descsz = cpu_to_be32(data_len);
  > 98		note->n_type   = cpu_to_be32(type);
    99		buf += DIV_ROUND_UP(sizeof(*note), sizeof(Elf64_Word));
   100		memcpy(buf, name, namesz);
   101		buf += DIV_ROUND_UP(namesz, sizeof(Elf64_Word));
   102		memcpy(buf, data, data_len);
   103		buf += DIV_ROUND_UP(data_len, sizeof(Elf64_Word));
   104	
   105		return buf;
   106	}
   107	
   108	static void fill_prstatus(struct elf_prstatus *prstatus, int pir,
   109				  struct pt_regs *regs)
   110	{
   111		memset(prstatus, 0, sizeof(struct elf_prstatus));
   112		elf_core_copy_kernel_regs(&(prstatus->pr_reg), regs);
   113	
   114		/*
   115		 * Overload PID with PIR value.
   116		 * As a PIR value could also be '0', add an offset of '100'
   117		 * to every PIR to avoid misinterpretations in GDB.
   118		 */
 > 119		prstatus->pr_pid  = cpu_to_be32(100 + pir);
 > 120		prstatus->pr_ppid = cpu_to_be32(1);
   121	
   122		/*
   123		 * Indicate SIGUSR1 for crash initiated from kernel.
   124		 * SIGTERM otherwise.
   125		 */
   126		if (pir == oc_conf->crashing_cpu) {
   127			short sig;
   128	
   129			sig = kernel_initiated ? SIGUSR1 : SIGTERM;
 > 130			prstatus->pr_cursig = cpu_to_be16(sig);
   131		}
   132	}
   133	
   134	static Elf64_Word *auxv_to_elf64_notes(Elf64_Word *buf,
   135					       u64 opal_boot_entry)
   136	{
   137		Elf64_Off *bufp = (Elf64_Off *)oc_conf->auxv_buf;
   138		int idx = 0;
   139	
   140		memset(bufp, 0, AUXV_DESC_SZ);
   141	
   142		/* Entry point of OPAL */
 > 143		bufp[idx++] = cpu_to_be64(AT_ENTRY);
   144		bufp[idx++] = cpu_to_be64(opal_boot_entry);
   145	
   146		/* end of vector */
   147		bufp[idx++] = cpu_to_be64(AT_NULL);
   148	
   149		buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME, NT_AUXV,
   150					oc_conf->auxv_buf, AUXV_DESC_SZ);
   151		return buf;
   152	}
   153	
   154	/*
   155	 * Read from the ELF header and then the crash dump.
   156	 * Returns number of bytes read on success, -errno on failure.
   157	 */
   158	static ssize_t read_opalcore(struct file *file, struct kobject *kobj,
   159				     struct bin_attribute *bin_attr, char *to,
   160				     loff_t pos, size_t count)
   161	{
   162		struct opalcore *m;
   163		ssize_t tsz, avail;
   164		loff_t tpos = pos;
   165	
   166		if (pos >= oc_conf->opalcore_size)
   167			return 0;
   168	
   169		/* Adjust count if it goes beyond opalcore size */
   170		avail = oc_conf->opalcore_size - pos;
   171		if (count > avail)
   172			count = avail;
   173	
   174		if (count == 0)
   175			return 0;
   176	
   177		/* Read ELF core header and/or PT_NOTE segment */
   178		if (tpos < oc_conf->opalcorebuf_sz) {
   179			tsz = min_t(size_t, oc_conf->opalcorebuf_sz - tpos, count);
   180			memcpy(to, oc_conf->opalcorebuf + tpos, tsz);
   181			to += tsz;
   182			tpos += tsz;
   183			count -= tsz;
   184		}
   185	
   186		list_for_each_entry(m, &opalcore_list, list) {
   187			/* nothing more to read here */
   188			if (count == 0)
   189				break;
   190	
   191			if (tpos < m->offset + m->size) {
   192				void *addr;
   193	
   194				tsz = min_t(size_t, m->offset + m->size - tpos, count);
   195				addr = (void *)(m->paddr + tpos - m->offset);
   196				memcpy(to, __va(addr), tsz);
   197				to += tsz;
   198				tpos += tsz;
   199				count -= tsz;
   200			}
   201		}
   202	
   203		return (tpos - pos);
   204	}
   205	
   206	static struct bin_attribute opal_core_attr = {
   207		.attr = {.name = "core", .mode = 0400},
   208		.read = read_opalcore
   209	};
   210	
   211	/*
   212	 * Read CPU state dump data and convert it into ELF notes.
   213	 *
   214	 * Each register entry is of 16 bytes, A numerical identifier along with
   215	 * a GPR/SPR flag in the first 8 bytes and the register value in the next
   216	 * 8 bytes. For more details refer to F/W documentation.
   217	 */
   218	static Elf64_Word * __init opalcore_append_cpu_notes(Elf64_Word *buf)
   219	{
   220		u32 thread_pir, size_per_thread, regs_offset, regs_cnt, reg_esize;
   221		struct hdat_fadump_thread_hdr *thdr;
   222		struct elf_prstatus prstatus;
   223		Elf64_Word *first_cpu_note;
   224		struct pt_regs regs;
   225		char *bufp;
   226		int i;
   227	
   228		size_per_thread = oc_conf->cpu_state_entry_size;
   229		bufp = __va(oc_conf->cpu_state_destination_vaddr);
   230	
   231		/*
   232		 * Offset for register entries, entry size and registers count is
   233		 * duplicated in every thread header in keeping with HDAT format.
   234		 * Use these values from the first thread header.
   235		 */
   236		thdr = (struct hdat_fadump_thread_hdr *)bufp;
   237		regs_offset = (offsetof(struct hdat_fadump_thread_hdr, offset) +
   238			       be32_to_cpu(thdr->offset));
   239		reg_esize = be32_to_cpu(thdr->esize);
   240		regs_cnt  = be32_to_cpu(thdr->ecnt);
   241	
   242		pr_debug("--------CPU State Data------------\n");
   243		pr_debug("NumCpus     : %u\n", oc_conf->num_cpus);
   244		pr_debug("\tOffset: %u, Entry size: %u, Cnt: %u\n",
   245			 regs_offset, reg_esize, regs_cnt);
   246	
   247		/*
   248		 * Skip past the first CPU note. Fill this note with the
   249		 * crashing CPU's prstatus.
   250		 */
   251		first_cpu_note = buf;
   252		buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME, NT_PRSTATUS,
   253					&prstatus, sizeof(prstatus));
   254	
   255		for (i = 0; i < oc_conf->num_cpus; i++, bufp += size_per_thread) {
   256			thdr = (struct hdat_fadump_thread_hdr *)bufp;
   257			thread_pir = be32_to_cpu(thdr->pir);
   258	
   259			pr_debug("[%04d] PIR: 0x%x, core state: 0x%02x\n",
   260				 i, thread_pir, thdr->core_state);
   261	
   262			/*
   263			 * Register state data of MAX cores is provided by firmware,
   264			 * but some of this cores may not be active. So, while
   265			 * processing register state data, check core state and
   266			 * skip threads that belong to inactive cores.
   267			 */
   268			if (thdr->core_state == HDAT_FADUMP_CORE_INACTIVE)
   269				continue;
   270	
   271			opal_fadump_read_regs((bufp + regs_offset), regs_cnt,
   272					      reg_esize, false, &regs);
   273	
 > 274			pr_debug("PIR 0x%x - R1 : 0x%llx, NIP : 0x%llx\n", thread_pir,
   275				 be64_to_cpu(regs.gpr[1]), be64_to_cpu(regs.nip));
   276			fill_prstatus(&prstatus, thread_pir, &regs);
   277	
   278			if (thread_pir != oc_conf->crashing_cpu) {
   279				buf = append_elf64_note(buf, CRASH_CORE_NOTE_NAME,
   280							NT_PRSTATUS, &prstatus,
   281							sizeof(prstatus));
   282			} else {
   283				/*
   284				 * Add crashing CPU as the first NT_PRSTATUS note for
   285				 * GDB to process the core file appropriately.
   286				 */
   287				append_elf64_note(first_cpu_note, CRASH_CORE_NOTE_NAME,
   288						  NT_PRSTATUS, &prstatus,
   289						  sizeof(prstatus));
   290			}
   291		}
   292	
   293		return buf;
   294	}
   295	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

