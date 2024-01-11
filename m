Return-Path: <linux-kernel+bounces-23563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDDE82AE77
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02671F25DA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 12:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3ABB16408;
	Thu, 11 Jan 2024 12:09:42 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963FE15EAE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4T9k2R5t99z1Q7yL;
	Thu, 11 Jan 2024 20:07:59 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id 117CD1800B7;
	Thu, 11 Jan 2024 20:09:33 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Thu, 11 Jan 2024 20:09:32 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <dave.hansen@linux.intel.com>,
	<luto@kernel.org>, <tglx@linutronix.de>, <peterz@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <x86@kernel.org>, <mawupeng1@huawei.com>,
	<bp@suse.de>, <mingo@redhat.com>
Subject: [PATCH v3 0/3] Cleanup for PAT
Date: Thu, 11 Jan 2024 20:09:26 +0800
Message-ID: <20240111120929.2694440-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200001.china.huawei.com (7.185.36.224)

From: Ma Wupeng <mawupeng1@huawei.com>

Patch #1 move follow_phys to memtype.c since only pat use this.
Patch #2 cleanup parameter in follow_phys.
Patch #3 drop the unnecessary WARN_ON_ONCE if follow_phys fails.

Changelog since v2:
- rebase to latest linux

Changelog since v1:
- split patch #1 into two patches based on Boris's advise

Ma Wupeng (3):
  x86/mm/pat: Move follow_phys to pat-related file
  x86/mm/pat: Cleanup unused parameter in follow_phys
  x86/mm/pat: Remove WARN_ON_ONCE if follow_phys fails

 arch/x86/mm/pat/memtype.c | 34 ++++++++++++++++++++++++++++------
 include/linux/mm.h        |  2 --
 mm/memory.c               | 28 ----------------------------
 3 files changed, 28 insertions(+), 36 deletions(-)

-- 
2.25.1


