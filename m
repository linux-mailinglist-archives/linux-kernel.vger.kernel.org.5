Return-Path: <linux-kernel+bounces-25379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 883B382CEED
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 23:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D0581C2104A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 22:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF561168C6;
	Sat, 13 Jan 2024 22:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/dvHRxY"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125736AD9
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 22:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a28a6cef709so844717966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 14:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705185755; x=1705790555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q4/pivrjOQeNyUs9ZPz9Y4YuBuCLlgjLaZZJrk3ARpw=;
        b=K/dvHRxYOJkpnbkpSaJUs3IZTVhQdrJ658WWZl4IoZh4JS5aMXRjEEyZ4StHURHQmq
         RGKetT5PRp8csIqJNFxkrZ6E8iqP1tSIb3BRbqA/WU3jiL9aCLDUFYcxUXfR9zzZS6k2
         LwgJikolMvF/nr/EpH5ZDOa+TvgL6rlOIUeTMYYfgdEaffSNGQrho3LIdiqn7ZswdLod
         mBE8eimFmAmMz9U0H5ctKDzDT8HGVH8xXIgV8yWQw0V2r1ApTrof6KWMZ1HfDQJk60jJ
         tx+UUA6SuNlHsxS8IQekNCSysXAq40VejjJTinS05tFUaWZ6obYCxCUqAhkniHs8hFC1
         vqGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705185755; x=1705790555;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4/pivrjOQeNyUs9ZPz9Y4YuBuCLlgjLaZZJrk3ARpw=;
        b=q5l3A7gcC/JvjP+ZtYiRbr70c8qKSjjvJ+Dy8v7tSvN40Qz1Allj2xOmIW7eoaXv4c
         QYoiSNLZ42clFutrzBYoleynwp+NX0OVfMYHeaIGsmla6HN9J5n8oor6ffAoVB0zTxdZ
         qa8NQ/kW8qO89QypdOliti6C3ppmVs42dH1Kyp905Q9AXN0ZunWPLXLm8WcQsRWAGOX1
         jjtg8K6qjyeC8/sp6kNybpee3JM9pdJr2/LTKjp9Z6GoRMTwVSOwA7ISyqNHMI0tbLHi
         fZogZWRGpIn1kn2vBIO/vbntnGSKStr/VDWIhccQy3p21y6ZfARvKXPJQLkfULyj4HI8
         auTg==
X-Gm-Message-State: AOJu0YyUyJHtBakmarj/sTOEhLN7Bi2p73Xz9RINZ++bJPg/ttPKnqcW
	zSlaXgJlyDDPrOvxtQ4RtTg=
X-Google-Smtp-Source: AGHT+IEy9lDVXBY8PjRD0H70ak+qhwbH9W5SsouBGSQF3UuZjhFvdx+K8TUbZQAKhI6d+VjjPHiuCw==
X-Received: by 2002:a17:906:a08a:b0:a28:f0c6:5532 with SMTP id q10-20020a170906a08a00b00a28f0c65532mr1555462ejy.107.1705185755126;
        Sat, 13 Jan 2024 14:42:35 -0800 (PST)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id vx4-20020a170907a78400b00a2d62a515e8sm529656ejc.212.2024.01.13.14.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jan 2024 14:42:34 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 13 Jan 2024 23:42:32 +0100
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Yin Fengwei <fengwei.yin@intel.com>,
	David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Yang Shi <shy828301@gmail.com>,
	"Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Itaru Kitayama <itaru.kitayama@gmail.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	John Hubbard <jhubbard@nvidia.com>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>, Hugh Dickins <hughd@google.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v9 02/10] mm: Non-pmd-mappable, large folios for
 folio_add_new_anon_rmap()
Message-ID: <ZaMR2EWN-HvlCfUl@krava>
References: <20231207161211.2374093-1-ryan.roberts@arm.com>
 <20231207161211.2374093-3-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207161211.2374093-3-ryan.roberts@arm.com>

On Thu, Dec 07, 2023 at 04:12:03PM +0000, Ryan Roberts wrote:
> In preparation for supporting anonymous multi-size THP, improve
> folio_add_new_anon_rmap() to allow a non-pmd-mappable, large folio to be
> passed to it. In this case, all contained pages are accounted using the
> order-0 folio (or base page) scheme.
> 
> Reviewed-by: Yu Zhao <yuzhao@google.com>
> Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
> Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/rmap.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 2a1e45e6419f..846fc79f3ca9 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1335,32 +1335,44 @@ void page_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>   * This means the inc-and-test can be bypassed.
>   * The folio does not have to be locked.
>   *
> - * If the folio is large, it is accounted as a THP.  As the folio
> + * If the folio is pmd-mappable, it is accounted as a THP.  As the folio
>   * is new, it's assumed to be mapped exclusively by a single process.
>   */
>  void folio_add_new_anon_rmap(struct folio *folio, struct vm_area_struct *vma,
>  		unsigned long address)
>  {
> -	int nr;
> +	int nr = folio_nr_pages(folio);
>  
> -	VM_BUG_ON_VMA(address < vma->vm_start || address >= vma->vm_end, vma);
> +	VM_BUG_ON_VMA(address < vma->vm_start ||
> +			address + (nr << PAGE_SHIFT) > vma->vm_end, vma);

hi,
I'm hitting this bug (console output below) with adding uprobe
on simple program like:

  $ cat up.c 
  int main(void)
  { 
     return 0;
  }

  # bpftrace -e 'uprobe:/home/jolsa/up:_start {}'

  $ ./up

it's on top of current linus tree master:
  052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat

before this patch it seems to work, I can send my .config if needed

thanks,
jirka


---
[  147.562264][  T719] vma ffff888166134e68 start 0000000000401000 end 0000000000402000 mm ffff88817cf2a840
[  147.562264][  T719] prot 25 anon_vma ffff88817b6818e0 vm_ops ffffffff83475ec0
[  147.562264][  T719] pgoff 1 file ffff888168d01240 private_data 0000000000000000
[  147.562264][  T719] flags: 0x75(read|exec|mayread|maywrite|mayexec)
[  147.571660][  T719] ------------[ cut here ]------------
[  147.572319][  T719] kernel BUG at mm/rmap.c:1412!
[  147.572825][  T719] invalid opcode: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC KASAN NOPTI
[  147.573792][  T719] CPU: 3 PID: 719 Comm: up Not tainted 6.7.0+ #273 faf755a6fc44b54f4ff1c207411fbd9df5a3968d
[  147.574831][  T719] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
[  147.575652][  T719] RIP: 0010:folio_add_new_anon_rmap+0x2cc/0x8f0
[  147.576164][  T719] Code: c7 c6 20 d2 38 83 48 89 df e8 c0 4a fb ff 0f 0b 48 89 ef e8 16 ab 08 00 4c 3b 65 00 0f 83 cd fd ff ff 48 89 ef e8 34 44 fb ff  f7 c3 ff 0f 00 00 0f 85 de fe ff ff be 08 00 00 00 48 89 df
[  147.577609][  T719] RSP: 0018:ffff88815759f568 EFLAGS: 00010286
[  147.578140][  T719] RAX: 00000000000000fa RBX: ffffea00053eef40 RCX: 0000000000000000
[  147.578825][  T719] RDX: 0000000000000000 RSI: ffffffff81289b44 RDI: ffffffff872ff1a0
[  147.579513][  T719] RBP: ffff888166134e68 R08: 0000000000000001 R09: ffffed102aeb3e5f
[  147.580198][  T719] R10: ffff88815759f2ff R11: 0000000000000000 R12: 0000000000401020
[  147.580886][  T719] R13: 0000000000000001 R14: ffffea00053eef40 R15: ffffea00053eef40
[  147.581566][  T719] FS:  0000000000000000(0000) GS:ffff88842ce00000(0000) knlGS:0000000000000000
[  147.582263][  T719] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  147.582724][  T719] CR2: 00005634f0ffe880 CR3: 000000010c0f8002 CR4: 0000000000770ef0
[  147.583304][  T719] PKRU: 55555554
[  147.583586][  T719] Call Trace:
[  147.583869][  T719]  <TASK>
[  147.584122][  T719]  ? die+0x32/0x80
[  147.584422][  T719]  ? do_trap+0x12f/0x220
[  147.584800][  T719]  ? folio_add_new_anon_rmap+0x2cc/0x8f0
[  147.585411][  T719]  ? folio_add_new_anon_rmap+0x2cc/0x8f0
[  147.585891][  T719]  ? do_error_trap+0xa7/0x160
[  147.586349][  T719]  ? folio_add_new_anon_rmap+0x2cc/0x8f0
[  147.586879][  T719]  ? handle_invalid_op+0x2c/0x40
[  147.587354][  T719]  ? folio_add_new_anon_rmap+0x2cc/0x8f0
[  147.587892][  T719]  ? exc_invalid_op+0x29/0x40
[  147.588352][  T719]  ? asm_exc_invalid_op+0x16/0x20
[  147.588847][  T719]  ? preempt_count_sub+0x14/0xc0
[  147.589335][  T719]  ? folio_add_new_anon_rmap+0x2cc/0x8f0
[  147.589899][  T719]  ? folio_add_new_anon_rmap+0x2cc/0x8f0
[  147.590437][  T719]  __replace_page+0x364/0xb40
[  147.590918][  T719]  ? __pfx___replace_page+0x10/0x10
[  147.591412][  T719]  ? __pfx_lock_release+0x10/0x10
[  147.591910][  T719]  ? do_raw_spin_trylock+0xcd/0x120
[  147.592555][  T719]  ? __pfx_vma_alloc_folio+0x10/0x10
[  147.593095][  T719]  ? preempt_count_add+0x6e/0xc0
[  147.593612][  T719]  ? preempt_count_sub+0x14/0xc0
[  147.594143][  T719]  uprobe_write_opcode+0x3f6/0x820
[  147.594616][  T719]  ? __pfx_uprobe_write_opcode+0x10/0x10
[  147.595125][  T719]  ? preempt_count_sub+0x14/0xc0
[  147.595551][  T719]  ? up_write+0x125/0x2f0
[  147.596014][  T719]  install_breakpoint.isra.0+0xe5/0x470
[  147.596635][  T719]  uprobe_mmap+0x37b/0x8d0
[  147.598111][  T719]  ? __pfx_uprobe_mmap+0x10/0x10
[  147.598561][  T719]  mmap_region+0xa02/0x1220
[  147.599013][  T719]  ? rcu_is_watching+0x34/0x60
[  147.599602][  T719]  ? lock_acquired+0xbf/0x670
[  147.600024][  T719]  ? __pfx_mmap_region+0x10/0x10
[  147.600458][  T719]  ? security_mmap_addr+0x20/0x60
[  147.600909][  T719]  ? get_unmapped_area+0x169/0x1f0
[  147.601353][  T719]  do_mmap+0x425/0x660
[  147.601739][  T719]  vm_mmap_pgoff+0x15e/0x2b0
[  147.602156][  T719]  ? __pfx_vm_mmap_pgoff+0x10/0x10
[  147.602597][  T719]  ? __pfx_get_random_u64+0x10/0x10
[  147.603059][  T719]  elf_load+0xdc/0x3a0
[  147.603433][  T719]  load_elf_binary+0x6f6/0x22b0
[  147.603889][  T719]  ? __pfx_load_elf_binary+0x10/0x10
[  147.604385][  T719]  ? __pfx_lock_acquired+0x10/0x10
[  147.604952][  T719]  bprm_execve+0x494/0xc80
[  147.605379][  T719]  ? __pfx_bprm_execve+0x10/0x10
[  147.605843][  T719]  do_execveat_common.isra.0+0x24f/0x330
[  147.606358][  T719]  __x64_sys_execve+0x52/0x60
[  147.606797][  T719]  do_syscall_64+0x87/0x1b0
[  147.607148][  T719]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  147.607630][  T719] RIP: 0033:0x7faa9b0bdb4b
[  147.608732][  T719] Code: Unable to access opcode bytes at 0x7faa9b0bdb21.
[  147.609318][  T719] RSP: 002b:00007ffff9921708 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  147.610046][  T719] RAX: ffffffffffffffda RBX: 00005634f1964990 RCX: 00007faa9b0bdb4b
[  147.610727][  T719] RDX: 00005634f1966d20 RSI: 00005634f19612c0 RDI: 00005634f1964990
[  147.611528][  T719] RBP: 00007ffff9921800 R08: 0000000000000001 R09: 0000000000000001
[  147.612192][  T719] R10: 0000000000000008 R11: 0000000000000246 R12: 00000000ffffffff
[  147.612829][  T719] R13: 00005634f1964990 R14: 00005634f19612c0 R15: 00005634f1966d20
[  147.613479][  T719]  </TASK>
[  147.613787][  T719] Modules linked in: intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel kvm_intel rapl iTiTCO_vendor_support i2c_i801 i2c_smbus lpc_ich drm loop drm_panel_orientation_quirks zram
[  147.615630][  T719] ---[ end trace 0000000000000000 ]---
[  147.616253][  T719] RIP: 0010:folio_add_new_anon_rmap+0x2cc/0x8f0
[  147.616714][  T719] Code: c7 c6 20 d2 38 83 48 89 df e8 c0 4a fb ff 0f 0b 48 89 ef e8 16 ab 08 00 4c 3b 65 00 0f 83 cd fd ff ff 48 89 ef e8 34 44 fb ff  f7 c3 ff 0f 00 00 0f 85 de fe ff ff be 08 00 00 00 48 89 df
[  147.618160][  T719] RSP: 0018:ffff88815759f568 EFLAGS: 00010286
[  147.618594][  T719] RAX: 00000000000000fa RBX: ffffea00053eef40 RCX: 0000000000000000
[  147.619318][  T719] RDX: 0000000000000000 RSI: ffffffff81289b44 RDI: ffffffff872ff1a0
[  147.619930][  T719] RBP: ffff888166134e68 R08: 0000000000000001 R09: ffffed102aeb3e5f
[  147.620577][  T719] R10: ffff88815759f2ff R11: 0000000000000000 R12: 0000000000401020
[  147.621236][  T719] R13: 0000000000000001 R14: ffffea00053eef40 R15: ffffea00053eef40
[  147.621894][  T719] FS:  0000000000000000(0000) GS:ffff88842ce00000(0000) knlGS:0000000000000000
[  147.622596][  T719] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  147.623186][  T719] CR2: 00007faa9b0bdb21 CR3: 000000010c0f8002 CR4: 0000000000770ef0
[  147.623960][  T719] PKRU: 55555554
[  147.624331][  T719] note: up[719] exited with preempt_count 1
[  147.624953][  T719] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49
[  147.625898][  T719] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 719, name: up
[  147.626672][  T719] preempt_count: 0, expected: 0
[  147.627945][  T719] RCU nest depth: 1, expected: 0
[  147.628410][  T719] INFO: lockdep is turned off.
[  147.628898][  T719] CPU: 3 PID: 719 Comm: up Tainted: G      D            6.7.0+ #273 faf755a6fc44b54f4ff1c207411fbd9df5a3968d
[  147.629954][  T719] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
[  147.630838][  T719] Call Trace:
[  147.631185][  T719]  <TASK>
[  147.631514][  T719]  dump_stack_lvl+0x15d/0x180
[  147.631973][  T719]  __might_resched+0x270/0x3b0
[  147.636533][  T719]  exit_signals+0x1d/0x460
[  147.636947][  T719]  do_exit+0x27f/0x13b0
[  147.637368][  T719]  ? __pfx__printk+0x10/0x10
[  147.637827][  T719]  ? __pfx_do_exit+0x10/0x10
[  147.638238][  T719]  make_task_dead+0xd9/0x240
[  147.638610][  T719]  rewind_stack_and_make_dead+0x17/0x20
[  147.639064][  T719] RIP: 0033:0x7faa9b0bdb4b
[  147.639445][  T719] Code: Unable to access opcode bytes at 0x7faa9b0bdb21.
[  147.640015][  T719] RSP: 002b:00007ffff9921708 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
[  147.640694][  T719] RAX: ffffffffffffffda RBX: 00005634f1964990 RCX: 00007faa9b0bdb4b
[  147.641407][  T719] RDX: 00005634f1966d20 RSI: 00005634f19612c0 RDI: 00005634f1964990
[  147.642133][  T719] RBP: 00007ffff9921800 R08: 0000000000000001 R09: 0000000000000001
[  147.642911][  T719] R10: 0000000000000008 R11: 0000000000000246 R12: 00000000ffffffff
[  147.643685][  T719] R13: 00005634f1964990 R14: 00005634f19612c0 R15: 00005634f1966d20
[  147.644454][  T719]  </TASK>
[  147.644819][  T719] ------------[ cut here ]------------

