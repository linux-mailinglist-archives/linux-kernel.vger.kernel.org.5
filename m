Return-Path: <linux-kernel+bounces-133720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45B189A7B8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 01:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64130283304
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23444374EB;
	Fri,  5 Apr 2024 23:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaL7WjaA"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F0C2E652
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712361539; cv=none; b=RhiwcG/emjQ/COgLzZhukzZMzQOK0D4xHeQAJRlBIfwbSpnGQkoz0KzGZRpBNLn2tis+hJFofNdM3IxoEFcebdtYZ3PnQgZfN36MHysclh4zLa8jmUNfuuJkJ1Do3U0U4Ui6vCD6MQISvBF7CoxaQL9OEbSUsF1uK43bOIe1Mhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712361539; c=relaxed/simple;
	bh=sIgJubxvY2IinbEb8Sv0Pg4aUYv5vWyvo3SJ0UxneMg=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdzZjcQft3cSRSOt5GvfLgzQx37a+JdOYWAktL5V9WmoonOXr0NS13/fN8YnBCBHFdXOcrUeLlDavXk0JY+9NYd5tyjTkZ9nksI3jvqMQ774pPRgbTqalgc3L5yfjB1v7oHH4/KSAyrj16zsC1k30Hj2I4G9iQoe/In/W3udu5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaL7WjaA; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712361537; x=1743897537;
  h=date:from:to:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to;
  bh=sIgJubxvY2IinbEb8Sv0Pg4aUYv5vWyvo3SJ0UxneMg=;
  b=CaL7WjaAqR7LWeraLAZoNfMJTtp++j5XIGb8urcBHmf/T12KtW75zQVA
   XsyDtlIlLyEJrTx719anQ9d+ae5Mw2OfsUIrsi81pqlC9oZhbVb8LtOJF
   y31BVCayr26wJC+H/MHUDLYU1/yjM9zlLKKj4t4yzEpr1N1y26MS7wFIq
   maPZFlVCMrEBqQpXxLz2ZiH0MPw3OxyTajKxHTSzias11miBLNFGFiyRd
   BI2+G6Lu8ZGO4E+4s0tiVG6PI7dVYxzdq5P+foF1Z07pwuZ7K76HJ/21a
   SlP7dfZJ0qTO5Ktm7obhNwoosGBzg5670opnO1AC5HYyz4lB0yKTedBwg
   w==;
X-CSE-ConnectionGUID: hP5ajRzgTpGs8sLaGhOLlA==
X-CSE-MsgGUID: eG8a17AXQD+dHTpXriwPKA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="19070846"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19070846"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 16:58:56 -0700
X-CSE-ConnectionGUID: 1LwHf6XERm2cGdk27/pRQQ==
X-CSE-MsgGUID: BGo60r3IS9q1CPYgLep/qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19379390"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.105])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 16:58:58 -0700
Date: Fri, 5 Apr 2024 16:58:55 -0700
From: Tony Luck <tony.luck@intel.com>
To: David Hildenbrand <david@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <naoya.horiguchi@nec.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Machine check recovery broken in v6.9-rc1
Message-ID: <ZhCQPwgMWo9w3LlO@agluck-desk3>
References: <Zg8kLSl2yAlA3o5D@agluck-desk3>
 <1e943439-6044-4aa4-8c41-747e9e4dca27@redhat.com>
 <SJ1PR11MB6083AB3E55B7DE0D3FBE185EFC032@SJ1PR11MB6083.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <SJ1PR11MB6083AB3E55B7DE0D3FBE185EFC032@SJ1PR11MB6083.namprd11.prod.outlook.com>

On Fri, Apr 05, 2024 at 03:05:17PM +0000, Luck, Tony wrote:
> >> kernel BUG at include/linux/swapops.h:119
> >>=20
> >> 117 static inline unsigned long swp_offset_pfn(swp_entry_t entry)
> >> 118 {
> >> 119         VM_BUG_ON(!is_pfn_swap_entry(entry));
> >> 120         return swp_offset(entry) & SWP_PFN_MASK;
> >> 121 }
> >>=20
> >
> > Do you have the full backtrace?
>=20
> It's very garbled because multiple CPUs seem to be logging to the console=
 together.
>=20
> I've also got some more details.
>=20
> 1) Problems with recovery go back further than v6.8. Still looking to pin=
 down where it started.
>    v6.0 seems good (can run hundreds of injections + consumptions).
> 2) It's connected to a BIOS setting that enables APEI logging. If I disab=
le that, current
>    kernels don't have problems. v6.0 runs OK with this setting on or off.
>=20
> I'm bisecting to find where the APEI issue begins.

So a problem (not necessarily the current upstream problem given the
amount of additional changes that happened) began way back in this
commit from v6.1:

0d206b5d2e0d ("mm/swap: add swp_offset_pfn() to fetch PFN from swap entry")

This commit gives the "kernel BUG at include/linux/swapops.h:88!" while
its predecessor runs without errors).

The test case simply injects an uncorrectable memory error to DRAM, then
reads that location to consume the poison and generate a machine check.

memory_failure() must have been called multiple times (see the "already har=
dware
poisoned" message). Twice is pretty common. Intel eystems can report an
error twice. Once by the memory controller when it sees the ECC bits
don't add up. Second time by the CPU core when trying to consume the
poisoned data. But I can't explain four calls.

I unloaded the acpi_extlog and i10nm_edac modules before running the
test to get a less jumbled console log.


[  159.345790] EINJ: Error INJection is initialized.
[  183.645231] Disabling lock debugging due to kernel taint
[  183.645243] mce: [Hardware Error]: Machine check events logged
[  183.645940] {1}[Hardware Error]: Hardware error from APEI Generic Hardwa=
re Error Source: 0
[  183.645945] {1}[Hardware Error]: event severity: recoverable
[  183.645947] {1}[Hardware Error]:  Error 0, type: recoverable
[  183.645949] {1}[Hardware Error]:  fru_text: Card02, ChnA, DIMM0
[  183.645951] {1}[Hardware Error]:   section_type: memory error
[  183.645953] {1}[Hardware Error]:    error_status: Storage error in DRAM =
memory (0x0000000000000400)
[  183.645955] {1}[Hardware Error]:   physical_address: 0x00000008a398a400
[  183.645958] {1}[Hardware Error]:   node:1 card:0 module:0 rank:0 bank:2 =
device:0 row:1136 column:584
[  183.645959] {1}[Hardware Error]:   error_type: 14, scrub uncorrected err=
or
[  183.645961] {1}[Hardware Error]:   DIMM location: NODE 4 CPU1_DIMM_A1
[  183.645962] {1}[Hardware Error]:  Error 1, type: recoverable
[  183.645963] {1}[Hardware Error]:   section_type: memory error
[  183.645964] {1}[Hardware Error]:    error_status: Storage error in DRAM =
memory (0x0000000000000400)
[  183.645965] {1}[Hardware Error]:   physical_address: 0x00000008a398a400
[  183.645965] {1}[Hardware Error]:   node:1
[  183.645966] {1}[Hardware Error]:   error_type: 3, multi-bit ECC
[  183.650625] mce: Uncorrected hardware memory error in user-access at 8a3=
98a400
[  183.763844] Memory failure: 0x8a398a: recovery action for dirty LRU page=
: Recovered
[  183.778756] Memory failure: 0x8a398a: already hardware poisoned
[  183.784695] Memory failure: 0x8a398a: already hardware poisoned
[  183.790657] mce: [Hardware Error]: Machine check events logged
[  183.790746] Memory failure: 0x8a398a: already hardware poisoned
[  183.802491] ------------[ cut here ]------------
[  183.807126] kernel BUG at include/linux/swapops.h:88!
[  183.812199] invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
[  183.817436] CPU: 139 PID: 4501 Comm: einj_mem_uc Tainted: G   M         =
      6.0.0-rc3+ #443
[  183.825961] Hardware name: Intel Corporation WilsonCity/WilsonCity, BIOS=
 WLYDCRB1.SYS.0021.P06.2104260458 04/26/2021
[  183.836476] RIP: 0010:check_hwpoisoned_entry+0xba/0xc0
[  183.841632] Code: 31 c0 c3 cc cc cc cc 48 83 e7 fd 41 89 c3 41 21 fb eb =
ce 48 83 e7 f7 41 89 c3 41 21 fb 41 f6 c3 02 74 be eb e2 0f 1f 44 00 00 <0f=
> 0b 0f 1f 40 00 0f 1f 44 00 00 4c 89 c0 48 89 d6 4d 8b 40 28 48
[  183.860382] RSP: 0000:ff500c69ca963c90 EFLAGS: 00010246
[  183.865608] RAX: 0000000000000016 RBX: 00007f8fb2a69000 RCX: 00000000008=
a398a
[  183.872741] RDX: 0000000000000000 RSI: 00007f8fb2a69000 RDI: b7fffffeeb8=
cea00
[  183.879874] RBP: ff486f47df6f9ca8 R08: ff500c69ca963e10 R09: 00000000000=
00000
[  183.887004] R10: 000000000000000c R11: 0000000000000000 R12: ff486f47d17=
ca348
[  183.894139] R13: 00007f8fb2a6a000 R14: ff486f48010c8b00 R15: ff500c69ca9=
63e10
[  183.901278] FS:  00007f8fb2874740(0000) GS:ff486f4f9fac0000(0000) knlGS:=
0000000000000000
[  183.909362] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  183.915110] CR2: 00000000016b02f8 CR3: 00000008b81ce003 CR4: 00000000007=
71ee0
[  183.922240] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  183.929373] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  183.936505] PKRU: 55555554
[  183.939218] Call Trace:
[  183.941670]  <TASK>
[  183.943776]  hwpoison_pte_range+0x2ad/0x300
[  183.947963]  __walk_page_range+0x5f7/0xc80
[  183.952072]  ? tick_nohz_tick_stopped+0x12/0x30
[  183.956609]  ? rcu_read_lock_sched_held+0x10/0x80
[  183.961327]  walk_page_range+0xc6/0x180
[  183.965173]  kill_accessing_process+0xca/0x13d
[  183.969628]  memory_failure.cold+0x9a/0xbc
[  183.973737]  kill_me_maybe+0x3b/0x9a
[  183.977324]  task_work_run+0x59/0x90
[  183.980910]  exit_to_user_mode_prepare+0x22c/0x250
[  183.985710]  irqentry_exit_to_user_mode+0x5/0x30
[  183.990340]  noist_exc_machine_check+0x55/0xa0
[  183.994792]  asm_exc_machine_check+0x2f/0x40
[  183.999073] RIP: 0033:0x405bff
[  184.002140] Code: 00 e8 a5 c5 ff ff 55 53 48 83 ec 08 48 63 05 40 5d 00 =
00 48 8d 2c 07 bf 10 80 40 00 e8 ba c4 ff ff b8 00 00 00 00 89 c1 0f a2 <0f=
> be 45 00 48 83 c4 08 5b 5d c3 53 48 83 ec 20 48 c7 44 24 18 00
[  184.020886] RSP: 002b:00007ffcfa807e80 EFLAGS: 00010206
[  184.026111] RAX: 000000000000001b RBX: 00000000756e6547 RCX: 000000006c6=
5746e
[  184.033241] RDX: 0000000049656e69 RSI: 00000000016ae4a0 RDI: 00007f8fb2a=
4ea30
[  184.040376] RBP: 00007f8fb2a69400 R08: 00000000016ae2a0 R09: 00000000000=
00001
[  184.047508] R10: 00007ffcfa807e60 R11: 0000000000000202 R12: 00000000000=
00003
[  184.054639] R13: 0000000000000000 R14: 00007f8fb2a9d000 R15: 00000000004=
0ae00
[  184.061774]  </TASK>
[  184.063973] Modules linked in: einj snd_seq_dummy snd_hrtimer snd_seq sn=
d_seq_device snd_timer snd soundcore nf_conntrack_netbios_ns nf_conntrack_b=
roadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_=
reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntr=
ack nf_defrag_ipv6 nf_defrag_ipv4 rfkill ip_set nf_tables nfnetlink qrtr in=
tel_rapl_msr intel_rapl_common intel_uncore_frequency intel_uncore_frequenc=
y_common nfit libnvdimm x86_pkg_temp_thermal intel_powerclamp coretemp ipmi=
_ssif sunrpc kvm_intel binfmt_misc kvm irqbypass vfat rapl fat intel_cstate=
 intel_uncore pcspkr isst_if_mbox_pci isst_if_mmio isst_if_common i2c_i801 =
i2c_smbus mei_me acpi_ipmi mei intel_pch_thermal intel_vsec ioatdma ipmi_si=
 ipmi_devintf joydev ipmi_msghandler loop zram crct10dif_pclmul ast crc32_p=
clmul crc32c_intel polyval_clmulni drm_vram_helper polyval_generic ixgbe dr=
m_ttm_helper igb mdio ttm ghash_clmulni_intel dca wmi ip6_tables ip_tables =
fuse
[  184.064048] Unloaded tainted modules: i10nm_edac():1 pcc_cpufreq():1 acp=
i_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq=
():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc=
_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq=
():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi=
_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq=
():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc=
_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufre=
q():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 ac=
pi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufre=
q():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acp=
i_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq=
():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc=
_cpufreq():1 acpi_cpufreq():1
[  184.149160]  acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpu=
freq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 =
acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpu=
freq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():=
1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_c=
pufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq()=
:1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_=
cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq(=
):1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_=
cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq(=
):1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_=
cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq(=
):1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_=
cpufreq():1 acpi_cpufreq():1
[  184.236447]  acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufr=
eq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 a=
cpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpuf=
req():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 ac=
pi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufr=
eq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 a=
cpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufr=
eq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 p=
cc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufr=
eq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 p=
cc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufr=
eq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 ac=
pi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufr=
eq():1 pcc_cpufreq():1
[  184.323640]  acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpu=
freq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 =
acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpu=
freq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1=
 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpu=
freq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1=
 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpu=
freq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1=
 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpu=
freq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():=
1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_c=
pufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq()=
:1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_c=
pufreq():1 acpi_cpufreq():1
[  184.410309]  acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpuf=
req():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 a=
cpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpuf=
req():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 =
acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpuf=
req():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 a=
cpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpuf=
req():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 a=
cpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpuf=
req():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 p=
cc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufr=
eq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 a=
cpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpuf=
req():1 acpi_cpufreq():1
[  184.497416]  acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufr=
eq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 p=
cc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufr=
eq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 p=
cc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufre=
q():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 ac=
pi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufr=
eq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 a=
cpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpuf=
req():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 a=
cpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufr=
eq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 a=
cpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpu=
freq():1 pcc_cpufreq():1
[  184.584254]  pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpuf=
req():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1=
 acpi_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cp=
ufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1=
 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpuf=
req():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 =
pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufr=
eq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 p=
cc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufr=
eq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acp=
i_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq=
():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_=
cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq()=
:1 acpi_cpufreq():1
[  184.671099]  pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufr=
eq():1 fjes():1 acpi_cpufreq():1 pcc_cpufreq():1 pcc_cpufreq():1 acpi_cpufr=
eq():1 pcc_cpufreq():1 fjes():1 acpi_cpufreq():1 pcc_cpufreq():1 fjes():1 a=
cpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufr=
eq():1 pcc_cpufreq():1 acpi_cpufreq():1 pcc_cpufreq():1 acpi_cpufreq():1 ac=
pi_cpufreq():1 fjes():1 fjes():1 fjes():1 [last unloaded: i10nm_edac]
[  184.796172] ---[ end trace 0000000000000000 ]---
[  184.806944] RIP: 0010:check_hwpoisoned_entry+0xba/0xc0
[  184.812107] Code: 31 c0 c3 cc cc cc cc 48 83 e7 fd 41 89 c3 41 21 fb eb =
ce 48 83 e7 f7 41 89 c3 41 21 fb 41 f6 c3 02 74 be eb e2 0f 1f 44 00 00 <0f=
> 0b 0f 1f 40 00 0f 1f 44 00 00 4c 89 c0 48 89 d6 4d 8b 40 28 48
[  184.830868] RSP: 0000:ff500c69ca963c90 EFLAGS: 00010246
[  184.836111] RAX: 0000000000000016 RBX: 00007f8fb2a69000 RCX: 00000000008=
a398a
[  184.843261] RDX: 0000000000000000 RSI: 00007f8fb2a69000 RDI: b7fffffeeb8=
cea00
[  184.850410] RBP: ff486f47df6f9ca8 R08: ff500c69ca963e10 R09: 00000000000=
00000
[  184.857560] R10: 000000000000000c R11: 0000000000000000 R12: ff486f47d17=
ca348
[  184.864709] R13: 00007f8fb2a6a000 R14: ff486f48010c8b00 R15: ff500c69ca9=
63e10
[  184.871855] FS:  00007f8fb2874740(0000) GS:ff486f4f9fac0000(0000) knlGS:=
0000000000000000
[  184.879950] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  184.885704] CR2: 00000000016b02f8 CR3: 00000008b81ce003 CR4: 00000000007=
71ee0
[  184.892847] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[  184.899995] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[  184.907135] PKRU: 55555554
[  184.909857] note: einj_mem_uc[4501] exited with preempt_count 1

