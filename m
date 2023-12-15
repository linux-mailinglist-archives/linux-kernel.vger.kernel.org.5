Return-Path: <linux-kernel+bounces-1836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD9E8154A2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B6C51F23772
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DF756390;
	Fri, 15 Dec 2023 23:47:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDA056380
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 23:47:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CBEC433C7;
	Fri, 15 Dec 2023 23:47:22 +0000 (UTC)
Date: Fri, 15 Dec 2023 23:47:20 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] arm64 fixes for 6.7-rc6
Message-ID: <ZXzliF7K4P32ZSYk@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit f5259997f3e8d6edfcc2daf5b2c0b34f074d7bc0:

  arm64: Avoid enabling KPTI unnecessarily (2023-11-30 19:07:33 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 3c0696076aad60a2f04c019761921954579e1b0e:

  arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify (2023-12-12 16:25:26 +0000)

----------------------------------------------------------------
arm64 fixes:

- Arm CMN perf: fix the DTC allocation failure path which can end up
  erroneously clearing live counters

- arm64/mm: fix hugetlb handling of the dirty page state leading to a
  continuous fault loop in user on hardware without dirty bit management
  (DBM). That's caused by the dirty+writeable information not being
  properly preserved across a series of mprotect(PROT_NONE),
  mprotect(PROT_READ|PROT_WRITE)

----------------------------------------------------------------
James Houghton (1):
      arm64: mm: Always make sw-dirty PTEs hw-dirty in pte_modify

Robin Murphy (1):
      perf/arm-cmn: Fail DTC counter allocation correctly

 arch/arm64/include/asm/pgtable.h | 6 ++++++
 drivers/perf/arm-cmn.c           | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

-- 
Catalin

