Return-Path: <linux-kernel+bounces-162100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB638B55D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00C421C22EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C243D39B;
	Mon, 29 Apr 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Udh7m1/+"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F9B3987C;
	Mon, 29 Apr 2024 10:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714387914; cv=none; b=G3/akGqOMecsVwgn6pKWDFhicXAO0JmDcUTgc+nawUGddNyzlWShGMi099L2vK2MyztNE28+DdxktR9WN+nuDgh3oEgg9c/ye6hmhSrtg6MUK9ym3gu2uTFib6A+xD3FF10spnZRZzHNa8046Z8yMqo6puWYKqgXn6ZwLQty7BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714387914; c=relaxed/simple;
	bh=UXUMIyD5O5YqL16an7u3P5kjHeFA5m9zT4IsOV+uBFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=j5sJHrzfx9b4/uS6V+ugM7z8dNanWbb1T31Q8U3I99Su5OsCd82jbxR/YSr1w4TEnyyG1Ef7g1V9Gxf8Ev9nqEhxDKwM8Hz5nb8xhEqNO0bnm8qBdu/VgMAHURMCamgYWk/AImCyDY5YjbsCqGatICXtnfLIWpMH0dgn01/hzw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Udh7m1/+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714387913; x=1745923913;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UXUMIyD5O5YqL16an7u3P5kjHeFA5m9zT4IsOV+uBFE=;
  b=Udh7m1/+v9xTSjhXgnZ41FZx/fE6Qduj13DNnUKE+5pL+q2LI1iPds0j
   gSbCm3Ydfa5td53cCi/yTVDFQ/LaDK8VcaxJG3fFDgLUMLLxSTcZmG5hL
   mHWiJOoJe6uDs8ICku+N5VKEPjdqU++/Yea+ap5xflb6IKGbCHzyMQTOk
   eZeTx9/VHuhSK2aLf/IA0DIeWA/hktYGrnwdhqEMBjSWxPyQVDDWzg4aD
   WaxmoIyE0nA4Pb8Z3aXDmONu7oEJ7IQbX/iugfUVzBaYnqPOzve1CR6TG
   9lhz343miwuL9AUTYc0n6z0dH17Xp0g51y3ZNSuPE/ku9zm6unPxcpMak
   w==;
X-CSE-ConnectionGUID: xH1Skh6rSP+4sevtLw0yMw==
X-CSE-MsgGUID: fmoGt/6LQFWxaGpHNZwJDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11057"; a="10202095"
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="10202095"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:51:52 -0700
X-CSE-ConnectionGUID: C0DF8IbhR9627rUe7JL2LA==
X-CSE-MsgGUID: wH2CvjmeSO+RjubYTUV7lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,239,1708416000"; 
   d="scan'208";a="26590744"
Received: from mehlow-prequal01.jf.intel.com ([10.54.102.156])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 03:51:52 -0700
From: Dmitrii Kuvaiskii <dmitrii.kuvaiskii@intel.com>
To: dave.hansen@linux.intel.com,
	jarkko@kernel.org,
	kai.huang@intel.com,
	haitao.huang@linux.intel.com,
	reinette.chatre@intel.com,
	linux-sgx@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mona.vij@intel.com,
	kailun.qin@intel.com
Subject: [PATCH 0/2] x86/sgx: Fix two data races in EAUG/EREMOVE flows
Date: Mon, 29 Apr 2024 03:43:28 -0700
Message-Id: <20240429104330.3636113-1-dmitrii.kuvaiskii@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Deutschland GmbH - Registered Address: Am Campeon 10, 85579 Neubiberg, Germany
Content-Transfer-Encoding: 8bit

SGX runtimes such as Gramine may implement EDMM-based lazy allocation of
enclave pages and may support MADV_DONTNEED semantics [1]. The former
implies #PF-based page allocation, and the latter implies the usage of
SGX_IOC_ENCLAVE_REMOVE_PAGES ioctl.

A trivial program like below (run under Gramine and with EDMM enabled)
stresses these two flows in the SGX driver and hangs:

/* repeatedly touch different enclave pages at random and mix with
 * `madvise(MADV_DONTNEED)` to stress EAUG/EREMOVE flows */
static void* thread_func(void* arg) {
    size_t num_pages = 0xA000 / page_size;
    for (int i = 0; i < 5000; i++) {
        size_t page = get_random_ulong() % num_pages;
        char data = READ_ONCE(((char*)arg)[page * page_size]);

        page = get_random_ulong() % num_pages;
        madvise(arg + page * page_size, page_size, MADV_DONTNEED);
    }
}

addr = mmap(NULL, 0xA000, PROT_READ | PROT_WRITE, MAP_ANONYMOUS, -1, 0);
pthread_t threads[16];
for (int i = 0; i < 16; i++)
    pthread_create(&threads[i], NULL, thread_func, addr);

This program uncovers two data races in the SGX driver. The remaining
patches describe and fix these races.

I performed several stress tests to verify that there are no other data
races (at least with the test program above):

- On Icelake server with 128GB of PRMRR (EPC), without madvise(). This
  stresses the first data race. A Gramine SGX test suite running in the
  background for additional stressing. Result: 1,000 runs without hangs
  (result without the first bug fix: hangs every time).
- On Icelake server with 128GB of PRMRR (EPC), with madvise(). This
  stresses the second data race. A Gramine SGX test suite running in the
  background for additional stressing. Result: 1,000 runs without hangs
  (result with the first bug fix but without the second bug fix: hangs
  approx. once in 50 runs).
- On Icelake server with 4GB of PRMRR (EPC), with madvise(). This
  additionally stresses the enclave page swapping flows. Two Gramine SGX
  test suites running in the background for additional stressing of
  swapping (I observe 100% CPU utilization from ksgxd which confirms that
  swapping happens). Result: 1,000 runs without hangs.

(Sorry for the previous copy of this email, accidentally sent to
stable@vger.kernel.org. Failed to use `--suppress-cc` during a test send.)

Dmitrii Kuvaiskii (2):
  x86/sgx: Resolve EAUG race where losing thread returns SIGBUS
  x86/sgx: Resolve EREMOVE page vs EAUG page data race

 arch/x86/kernel/cpu/sgx/encl.c  | 10 +++++++---
 arch/x86/kernel/cpu/sgx/encl.h  |  3 +++
 arch/x86/kernel/cpu/sgx/ioctl.c |  1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.34.1


