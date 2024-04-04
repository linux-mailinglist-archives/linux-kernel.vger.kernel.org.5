Return-Path: <linux-kernel+bounces-131753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84146898B78
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEA91F21623
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3B512BEBF;
	Thu,  4 Apr 2024 15:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZ01pq1D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9704C12B14A;
	Thu,  4 Apr 2024 15:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245550; cv=none; b=gSwEwmUfNjSGGp37oXNdFrz22xVQk4OUu9VB5fGZRdix7sGeuJKn13sCg3HJvAZTWw3uoZE6UKGG8QR6qW0148TPGuUrfY4aSqO2PyDakqMWH/umX8WIFWcY9iMaLyEM7Pz8Dfu2ENoTrPMvvImQswBqYUjy+UUfGOwn7Q/sLC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245550; c=relaxed/simple;
	bh=38WmI8KudBPQM/Ql3r656lB+f7qXdMLAJz3Qm77YaIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LVjXTkz+EvVfzhbf+aLEz2fjUdT+3eszI1gQ8j923u6tMmH6hcvugcjP+SwHEAI//xzx3MYXf5i9IxMwWMl/+lyIoCuFQb1OlvPkg+vSv+DBsbYgSjp4BQ5eerZcFs29XzxKC9vL9jV7b+o8yZnsk/b2sEJIObbfWkD2WpbDiQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZ01pq1D; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712245549; x=1743781549;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=38WmI8KudBPQM/Ql3r656lB+f7qXdMLAJz3Qm77YaIo=;
  b=BZ01pq1DYbiO28wd35hNdFWyXzYr1Oz+4a4RO9132GR7FFvyMI291e6A
   WaM00R4dB0I7/sfmspH/jOv/ZDhjuCohBW3Qt7vQ45AtnLW5Wp5LM6nQO
   OxiqBfFvzCAedanZ8ia2Co8dZp6FA+WjqDzD3LgJpvpJNZak7f00xv6D2
   cTfyiBv0FIVIrwZQgg9DhhfirXV9TtYcgNj6fra9TQ23hkaYoCJEuekqR
   9YXFxa3WDxtw5zijq8YdjzpgoLAEfEDIUTllIu0ZdsF0GRMb2T1eRYTaH
   6ExYor6V+HvbM99gx/KOPaAwVd0gsPAoeHvpgF/ROUICS7hMuFZv68eSN
   w==;
X-CSE-ConnectionGUID: l0EXKanXTEqIo7uUfi4NwA==
X-CSE-MsgGUID: IfUj1yfuTCmLRmXmA3vpxA==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="11312072"
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="11312072"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 08:45:48 -0700
X-CSE-ConnectionGUID: 4u9Ci6LzQfCQCyn/ATdUdw==
X-CSE-MsgGUID: 4+OyyTrXTb6b+0tX9wohJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,179,1708416000"; 
   d="scan'208";a="23288031"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa005.fm.intel.com with ESMTP; 04 Apr 2024 08:45:44 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Christoph Lameter <cl@linux.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v9 0/9] net: intel: start The Great Code Dedup + Page Pool for iavf
Date: Thu,  4 Apr 2024 17:43:53 +0200
Message-ID: <20240404154402.3581254-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here's a two-shot: introduce {,Intel} Ethernet common library (libeth and
libie) and switch iavf to Page Pool. Details are in the commit messages;
here's a summary:

Not a secret there's a ton of code duplication between two and more Intel
ethernet modules. Before introducing new changes, which would need to be
copied over again, start decoupling the already existing duplicate
functionality into a new module, which will be shared between several
Intel Ethernet drivers. The first name that came to my mind was
"libie" -- "Intel Ethernet common library". Also this sounds like
"lovelie" (-> one word, no "lib I E" pls) and can be expanded as
"lib Internet Explorer" :P
The "generic", pure-software part is placed separately, so that it can be
easily reused in any driver by any vendor without linking to the Intel
pre-200G guts. In a few words, it's something any modern driver does the
same way, but nobody moved it level up (yet).
The series is only the beginning. From now on, adding every new feature
or doing any good driver refactoring will remove much more lines than add
for quite some time. There's a basic roadmap with some deduplications
planned already, not speaking of that touching every line now asks:
"can I share this?". The final destination is very ambitious: have only
one unified driver for at least i40e, ice, iavf, and idpf with a struct
ops for each generation. That's never gonna happen, right? But you still
can at least try.
PP conversion for iavf lands within the same series as these two are tied
closely. libie will support Page Pool model only, so that a driver can't
use much of the lib until it's converted. iavf is only the example, the
rest will eventually be converted soon on a per-driver basis. That is
when it gets really interesting. Stay tech.

Alexander Lobakin (9):
  net: intel: introduce {,Intel} Ethernet common library
  iavf: kill "legacy-rx" for good
  iavf: drop page splitting and recycling
  slab: introduce kvmalloc_array_node() and kvcalloc_node()
  page_pool: constify some read-only function arguments
  page_pool: add DMA-sync-for-CPU inline helper
  libeth: add Rx buffer management
  iavf: pack iavf_ring more efficiently
  iavf: switch to Page Pool

 MAINTAINERS                                   |   4 +-
 drivers/net/ethernet/intel/Kconfig            |   7 +
 drivers/net/ethernet/intel/libeth/Kconfig     |   9 +
 drivers/net/ethernet/intel/libie/Kconfig      |  10 +
 drivers/net/ethernet/intel/Makefile           |   3 +
 drivers/net/ethernet/intel/libeth/Makefile    |   6 +
 drivers/net/ethernet/intel/libie/Makefile     |   6 +
 include/net/page_pool/types.h                 |   4 +-
 .../net/ethernet/intel/i40e/i40e_prototype.h  |   7 -
 drivers/net/ethernet/intel/i40e/i40e_type.h   |  88 ---
 drivers/net/ethernet/intel/iavf/iavf.h        |   2 +-
 .../net/ethernet/intel/iavf/iavf_prototype.h  |   7 -
 drivers/net/ethernet/intel/iavf/iavf_txrx.h   | 146 +----
 drivers/net/ethernet/intel/iavf/iavf_type.h   |  90 ---
 .../net/ethernet/intel/ice/ice_lan_tx_rx.h    | 320 ----------
 include/linux/net/intel/libie/rx.h            |  50 ++
 include/linux/slab.h                          |  17 +-
 include/net/libeth/rx.h                       | 242 ++++++++
 include/net/page_pool/helpers.h               |  34 +-
 drivers/net/ethernet/intel/i40e/i40e_common.c | 253 --------
 drivers/net/ethernet/intel/i40e/i40e_main.c   |   1 +
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  72 +--
 drivers/net/ethernet/intel/iavf/iavf_common.c | 253 --------
 .../net/ethernet/intel/iavf/iavf_ethtool.c    | 140 -----
 drivers/net/ethernet/intel/iavf/iavf_main.c   |  40 +-
 drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 551 +++---------------
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  17 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |   1 +
 drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 111 +---
 drivers/net/ethernet/intel/libeth/rx.c        | 150 +++++
 drivers/net/ethernet/intel/libie/rx.c         | 124 ++++
 net/core/page_pool.c                          |  10 +-
 32 files changed, 819 insertions(+), 1956 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libeth/Kconfig
 create mode 100644 drivers/net/ethernet/intel/libie/Kconfig
 create mode 100644 drivers/net/ethernet/intel/libeth/Makefile
 create mode 100644 drivers/net/ethernet/intel/libie/Makefile
 create mode 100644 include/linux/net/intel/libie/rx.h
 create mode 100644 include/net/libeth/rx.h
 create mode 100644 drivers/net/ethernet/intel/libeth/rx.c
 create mode 100644 drivers/net/ethernet/intel/libie/rx.c

---
libeth has way more generic functionality and code in the idpf XDP
tree[0], take a look if you want to have more complete picture of
what this really is about.

From v8[1]:
* rebase on top of net-next (6.9-rc1+);
* introduce kvmalloc_array_node() and kvcalloc_node();
* make Rx buffer management NUMA-aware;
* resolve kdoc issues (Jakub, me).

From v7[2]:
* drop Page Pool optimization prereqs;
* drop generic stats part: will redo to the new per-queue stats later;
* split libie into "generic" and "fnic" (i40e, ice, iavf) parts;
* use shorter and modern struct names;
* #1: allow to compile-out hotpath IPv6 code when !CONFIG_IPV6;
* #1: generate XDP RSS hash directly in the lookup table;
* #8: fix rare skb nullptr deref bug.

From v6[3]:
* #04: resolve ethtool_puts() Git conflict (Jakub);
* #06: pick RB from Ilias;
* no functional changes.

From v5[4]:
* drop Page Pool DMA shortcut: will pick up Eric's more global DMA sync
  optimization[5] and expand it to cover both IOMMU and direct DMA a bit
  later (Yunsheng);
* drop per-queue Page Pool Ethtool stats: they are now exported via
  generic Netlink interface (Jakub);
* #01: leave a comment why exactly this alignment (Jakub, Yunsheng);
* #08: make use of page_pool_params::netdev when calculating PP params;
* #08: rename ``libie_rx_queue`` -> ``libie_buf_queue``.

From v4[6]:
* make use of Jakub's &page_pool_params split;
* #01: prevent frag fields from spanning into 2 cachelines after
  splitting &page_pool_params into fast and slow;
* #02-03: bring back the DMA sync shortcut, now as a per-page flag
  (me, Yunsheng);
* #04: let libie have its own Kconfig to stop further bloating of poor
  intel/Kconfig;
* #06: merge page split-reuse-recycle drop into one commit (Alex);
* #07: decouple constifying of several Page Pool function arguments
  into a separate commit, constify some more;
* #09: stop abusing internal PP fields in the driver code (Yunsheng);
* #09: calculate DMA sync size (::max_len) correctly: within one page,
  not one buffer (Yunsheng);
* #10: decouple rearranging &iavf_ring into separate commit, optimize
  it even more;
* #11: let the driver get back to the last descriptor to process after
  an skb allocation fail, don't drop it (Alex);
* #11: stop touching unrelated stuff like watchdog timeout etc. (Alex);
* fix "Return:" in the kdoc (now `W=12 C=1` is clean), misc typos.

From v3[7]:
* base on the latest net-next, update bloat-o-meter and perf stats;
* split generic PP optimizations into a separate series;
* drop "optimize hotpath a bunch" commit: a lot of [controversial]
  changes in one place, worth own series (Alex);
* 02: pick Rev-by (Alex);
* 03: move in-place recycling removal here from the dropped patch;
* 05: new, add libie Rx buffer API separatelly from IAVF changes;
* 05-06: use new "hybrid" allocation API from[8] to reduce memory usage
  when a page can fit more than 1 truesize (also asked by David);
* 06: merge with "always use order-0 page" commit to reduce diffs and
  simplify things (Alex);
* 09: fix page_alloc_fail counter.

From v2[9]:
* 0006: fix page_pool.h include in OcteonTX2 files (Jakub, Patchwork);
* no functional changes.

From v1[10]:
* 0006: new (me, Jakub);
* 0008: give the helpers more intuitive names (Jakub, Ilias);
*  -^-: also expand their kdoc a bit for the same reason;
*  -^-: fix kdoc copy-paste issue (Patchwork, Jakub);
* 0011: drop `inline` from C file (Patchwork, Jakub).

[0] https://github.com/alobakin/linux/commits/idpf-libie-new
[1] https://lore.kernel.org/netdev/20240308141833.2966600-1-aleksander.lobakin@intel.com
[2] https://lore.kernel.org/netdev/20231213112835.2262651-1-aleksander.lobakin@intel.com
[3] https://lore.kernel.org/netdev/20231207172010.1441468-1-aleksander.lobakin@intel.com
[4] https://lore.kernel.org/netdev/20231124154732.1623518-1-aleksander.lobakin@intel.com
[5] https://lore.kernel.org/netdev/20221115182841.2640176-1-edumazet@google.com
[6] https://lore.kernel.org/netdev/20230705155551.1317583-1-aleksander.lobakin@intel.com
[7] https://lore.kernel.org/netdev/20230530150035.1943669-1-aleksander.lobakin@intel.com
[8] https://lore.kernel.org/netdev/20230629120226.14854-1-linyunsheng@huawei.com
[9] https://lore.kernel.org/netdev/20230525125746.553874-1-aleksander.lobakin@intel.com
[10] https://lore.kernel.org/netdev/20230516161841.37138-1-aleksander.lobakin@intel.com

-- 
2.44.0


