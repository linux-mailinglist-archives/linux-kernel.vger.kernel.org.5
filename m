Return-Path: <linux-kernel+bounces-18307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947E4825B30
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 20:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA90E285C32
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 19:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D6535F16;
	Fri,  5 Jan 2024 19:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="farBdVQi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AB335EF7;
	Fri,  5 Jan 2024 19:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34351C433C7;
	Fri,  5 Jan 2024 19:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1704483795;
	bh=MdXjGizu6OM6cf5fY1g8ytFP0y5aZO9iXKxYNAAMmfI=;
	h=Date:From:To:Cc:Subject:From;
	b=farBdVQiHkFQZInv977PSDycPgR6GkXu+GoBTooYZu/fNnzIzYNjv41m9yWWEKZsy
	 ft+3hhrgCi7Hv35XROtqSP7iNXFFQMga47gNi+Bmalu1M8g+7zgYrNf5M1O7tIO0e+
	 e0i8hQEVDXuRyyOAMLopDWzsBf7Ygt9J6tjSHK4k=
Date: Fri, 5 Jan 2024 11:43:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.8
Message-Id: <20240105114314.820c25628928c57f639058fe@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus, please merge this batch of hotfixes, thanks.


The following changes since commit 1803d0c5ee1a3bbee23db2336e21add067824f02:

  mailmap: add an old address for Naoya Horiguchi (2023-12-20 13:46:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-01-05-11-35

for you to fetch changes up to 7fba9420b726561966e1671004df60a08b39beb3:

  mm: shrinker: use kvzalloc_node() from expand_one_shrinker_info() (2024-01-05 09:58:32 -0800)

----------------------------------------------------------------
12 hotfixes.  2 are cc:stable and the remainder either address post-6.7
issues or aren't considered necessary for earlier kernel versions.

----------------------------------------------------------------
Baolin Wang (1):
      mm: memcg: fix split queue list crash when large folio migration

Jiajun Xie (1):
      mm: fix unmap_mapping_range high bits shift bug

Jingbo Xu (2):
      mm: fix arithmetic for bdi min_ratio
      mm: fix arithmetic for max_prop_frac when setting max_ratio

Mathieu Othacehe (1):
      mailmap: add entries for Mathieu Othacehe

Mike Kravetz (1):
      MAINTAINERS: remove hugetlb maintainer Mike Kravetz

Naoya Horiguchi (1):
      MAINTAINERS: hand over hwpoison maintainership to Miaohe Lin

Rik van Riel (1):
      mm: align larger anonymous mappings on THP boundaries

Suren Baghdasaryan (1):
      arch/mm/fault: fix major fault accounting when retrying under per-VMA lock

Tetsuo Handa (1):
      mm: shrinker: use kvzalloc_node() from expand_one_shrinker_info()

Yu Zhao (1):
      mm/mglru: skip special VMAs in lru_gen_look_around()

Zack Rusin (1):
      MAINTAINERS: change vmware.com addresses to broadcom.com

 .mailmap                |  3 ++-
 CREDITS                 |  4 ++++
 MAINTAINERS             | 14 ++++++--------
 arch/arm64/mm/fault.c   |  2 ++
 arch/powerpc/mm/fault.c |  2 ++
 arch/riscv/mm/fault.c   |  2 ++
 arch/s390/mm/fault.c    |  3 +++
 arch/x86/mm/fault.c     |  2 ++
 mm/huge_memory.c        |  2 +-
 mm/memcontrol.c         | 11 +++++++++++
 mm/memory.c             |  4 ++--
 mm/mmap.c               |  3 +++
 mm/page-writeback.c     |  4 ++--
 mm/shrinker.c           |  2 +-
 mm/vmscan.c             | 13 +++++++++----
 15 files changed, 52 insertions(+), 19 deletions(-)


