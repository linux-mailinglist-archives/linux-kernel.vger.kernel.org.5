Return-Path: <linux-kernel+bounces-1494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1515C814F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DA86283526
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349BF3012C;
	Fri, 15 Dec 2023 17:57:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3717545BFE;
	Fri, 15 Dec 2023 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECCDFC15;
	Fri, 15 Dec 2023 09:57:57 -0800 (PST)
Received: from e127643.broadband (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B182E3F738;
	Fri, 15 Dec 2023 09:57:10 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-next@vger.kernel.org,
	will@kernel.org,
	u.kleine-koenig@pengutronix.de,
	mark.rutland@arm.com
Cc: James Clark <james.clark@arm.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2 0/1] arm: perf: Fix ARCH=arm build with GCC
Date: Fri, 15 Dec 2023 17:56:47 +0000
Message-Id: <20231215175648.3397170-1-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes since V1:

  * Instead of wrapping everything in #if, just use GENMASK_ULL instead
    which fixes both issues in one commit.

A fix for the broken build with GCC currently in linux-next
(next-20231214)


James Clark (1):
  arm: perf: Fix ARCH=arm build with GCC

 include/linux/perf/arm_pmuv3.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1


