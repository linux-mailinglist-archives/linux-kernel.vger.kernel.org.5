Return-Path: <linux-kernel+bounces-30246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E76831C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 149041F217ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B4C241F6;
	Thu, 18 Jan 2024 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hb+bApsU"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163AF1E87D;
	Thu, 18 Jan 2024 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591050; cv=none; b=Hi5X0BvpgUxWLZFP3RJAXNUJOwlaMWpt2o8q6oFUiApXZ3KWKeIEYjwJe/g1RqYkEAKeUCuh4ALa+6NTdZywgCTdQMm/AeTl8xVkCLgfRWEF4bUeCH5oK3wYucGQV5xbtsBDrz/ot3RfYeIJsBByGoZx2Kmd2o0fry4Kn3HH1S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591050; c=relaxed/simple;
	bh=+kFrRhjHpv40nvSzG/vyhe0ms38QkgFWWNV2IL9QDBA=;
	h=DKIM-Signature:X-IronPort-AV:X-IronPort-AV:Received:X-ExtLoop1:
	 X-IronPort-AV:X-IronPort-AV:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IzWuvo6+PQhTlEdpgqRzBdFGY7orbO/GjY9Y8TQ2cEtyQ7aA6zziSMwsOYBl68q0ZCZdRY8eo586wEVLNDnIT7rnoNiSuxRdzKMIRs+XxgAl8VZxpjv4K9r1Tz5v7yLLTxN8aHeIdHVQZDW1qeG16khPG6jY4dgwoVdXNKIqX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hb+bApsU; arc=none smtp.client-ip=134.134.136.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705591049; x=1737127049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+kFrRhjHpv40nvSzG/vyhe0ms38QkgFWWNV2IL9QDBA=;
  b=hb+bApsU7OftD90cqpsJZF2UNQTy53rMGGPzd0Rjx0c2C7c4GRxaufOY
   nVFJw0lhJSP3U0p99r9muSDFSBFnF0RA8hKKCxH6Paqo4mddcgqpprnBq
   wawDuAjSA5etnDj7we/fj/obtzKM7/doVd07E/jY61IckV1Vdn8vvJ21l
   JZs/PxBEpfk4jayI8rbUdiWicGagZLUS3SW8s3/awF2h9Op0YRhuxkqLu
   H62NiGZIGjONrTjgKL0jU0toz2vtJJqi1d5XWaq351m5GVUtTU9KvUW+g
   hpXsjlx2HBaqY2DDpyLx8medeWvZtAGQBvnCyJnvALawYISuj2Yq/NTtk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="466852643"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="466852643"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 07:17:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="784826988"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="784826988"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 18 Jan 2024 07:17:20 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQU8r-000356-1C;
	Thu, 18 Jan 2024 15:17:17 +0000
Date: Thu, 18 Jan 2024 23:16:17 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Graf <graf@amazon.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kexec@lists.infradead.org,
	linux-doc@vger.kernel.org, x86@kernel.org,
	Eric Biederman <ebiederm@xmission.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	arnd@arndb.de, pbonzini@redhat.com, madvenka@linux.microsoft.com,
	Anthony Yznaga <anthony.yznaga@oracle.com>,
	Usama Arif <usama.arif@bytedance.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 13/17] tracing: Recover trace buffers from kexec
 handover
Message-ID: <202401182318.vEGddOt1-lkp@intel.com>
References: <20240117144704.602-14-graf@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117144704.602-14-graf@amazon.com>

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[cannot apply to tip/x86/core arm64/for-next/core akpm-mm/mm-everything v6.7 next-20240118]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Graf/mm-memblock-Add-support-for-scratch-memory/20240117-225136
base:   linus/master
patch link:    https://lore.kernel.org/r/20240117144704.602-14-graf%40amazon.com
patch subject: [PATCH v3 13/17] tracing: Recover trace buffers from kexec handover
config: i386-randconfig-061-20240118 (https://download.01.org/0day-ci/archive/20240118/202401182318.vEGddOt1-lkp@intel.com/config)
compiler: ClangBuiltLinux clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240118/202401182318.vEGddOt1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401182318.vEGddOt1-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   kernel/trace/ring_buffer.c:1105:32: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted __poll_t @@     got int @@
   kernel/trace/ring_buffer.c:1105:32: sparse:     expected restricted __poll_t
   kernel/trace/ring_buffer.c:1105:32: sparse:     got int
   kernel/trace/ring_buffer.c:4955:9: sparse: sparse: context imbalance in 'ring_buffer_peek' - different lock contexts for basic block
   kernel/trace/ring_buffer.c:5041:9: sparse: sparse: context imbalance in 'ring_buffer_consume' - different lock contexts for basic block
   kernel/trace/ring_buffer.c:5421:17: sparse: sparse: context imbalance in 'ring_buffer_empty' - different lock contexts for basic block
   kernel/trace/ring_buffer.c:5451:9: sparse: sparse: context imbalance in 'ring_buffer_empty_cpu' - different lock contexts for basic block
>> kernel/trace/ring_buffer.c:5937:82: sparse: sparse: non size-preserving integer to pointer cast
   kernel/trace/ring_buffer.c:5939:84: sparse: sparse: non size-preserving integer to pointer cast

vim +5937 kernel/trace/ring_buffer.c

  5896	
  5897	static int rb_kho_replace_buffers(struct ring_buffer_per_cpu *cpu_buffer,
  5898					     struct rb_kho_cpu *kho)
  5899	{
  5900		bool first_loop = true;
  5901		struct list_head *tmp;
  5902		int err = 0;
  5903		int i = 0;
  5904	
  5905		if (!IS_ENABLED(CONFIG_FTRACE_KHO))
  5906			return -EINVAL;
  5907	
  5908		if (kho->nr_mems != cpu_buffer->nr_pages * 2)
  5909			return -EINVAL;
  5910	
  5911		for (tmp = rb_list_head(cpu_buffer->pages);
  5912		     tmp != rb_list_head(cpu_buffer->pages) || first_loop;
  5913		     tmp = rb_list_head(tmp->next), first_loop = false) {
  5914			struct buffer_page *bpage = (struct buffer_page *)tmp;
  5915			const struct kho_mem *mem_bpage = &kho->mem[i++];
  5916			const struct kho_mem *mem_page = &kho->mem[i++];
  5917			const uint64_t rb_page_head = 1;
  5918			struct buffer_page *old_bpage;
  5919			void *old_page;
  5920	
  5921			old_bpage = __va(mem_bpage->addr);
  5922			if (!bpage)
  5923				goto out;
  5924	
  5925			if ((ulong)old_bpage->list.next & rb_page_head) {
  5926				struct list_head *new_lhead;
  5927				struct buffer_page *new_head;
  5928	
  5929				new_lhead = rb_list_head(bpage->list.next);
  5930				new_head = (struct buffer_page *)new_lhead;
  5931	
  5932				/* Assume the buffer is completely full */
  5933				cpu_buffer->tail_page = bpage;
  5934				cpu_buffer->commit_page = bpage;
  5935				/* Set the head pointers to what they were before */
  5936				cpu_buffer->head_page->list.prev->next = (struct list_head *)
> 5937					((ulong)cpu_buffer->head_page->list.prev->next & ~rb_page_head);
  5938				cpu_buffer->head_page = new_head;
  5939				bpage->list.next = (struct list_head *)((ulong)new_lhead | rb_page_head);
  5940			}
  5941	
  5942			if (rb_page_entries(old_bpage) || rb_page_write(old_bpage)) {
  5943				/*
  5944				 * We want to recycle the pre-kho page, it contains
  5945				 * trace data. To do so, we unreserve it and swap the
  5946				 * current data page with the pre-kho one
  5947				 */
  5948				old_page = kho_claim_mem(mem_page);
  5949	
  5950				/* Recycle the old page, it contains data */
  5951				free_page((ulong)bpage->page);
  5952				bpage->page = old_page;
  5953	
  5954				bpage->write = old_bpage->write;
  5955				bpage->entries = old_bpage->entries;
  5956				bpage->real_end = old_bpage->real_end;
  5957	
  5958				local_inc(&cpu_buffer->pages_touched);
  5959			} else {
  5960				kho_return_mem(mem_page);
  5961			}
  5962	
  5963			kho_return_mem(mem_bpage);
  5964		}
  5965	
  5966	out:
  5967		return err;
  5968	}
  5969	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

