Return-Path: <linux-kernel+bounces-25630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8096682D3CA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C70B281719
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E62D6FC9;
	Mon, 15 Jan 2024 05:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o8zE9RN/"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1756FBD
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 05:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=CjpTtq3KVb59VYtc+80lvr2kpSJEliAR8QqQl1GGknI=; b=o8zE9RN/YqtPYEfZby9tYRKVzi
	ql/q15iJfZWo/wWfUXGNNCesPBYkQfauJEpr/JkztC1DKWgnr8ihkaPg3B9WrS0ugiSKlNy1JaZrY
	MmPyAP6iHKnitcD+YIXCuBm7W/zXeiFIIeg09qfbOW75JttZCdqTQGE2KsUXaOHD1c+UzF7Pa2Efn
	DhsrPROkoDoiabKRgQ1OTSL1v7nb9N1CuePoNiAkhjvi/06y+gcZ8zbVgQ9sqpjZSq1W94czJDvp/
	wWS9bHtw/qh9fuvlRtEmExFi4RrkNhp5TPrFxygBxR07waoM/ZZCuMdcNEDSuQZ2vz2jfcdj5OE8N
	E03p9kyw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rPF9l-007mOz-0Q;
	Mon, 15 Jan 2024 05:05:05 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Pratik Patel <pratikp@codeaurora.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] coresight: etm3x: add a kernel-doc "blank line"
Date: Sun, 14 Jan 2024 21:05:04 -0800
Message-ID: <20240115050504.30980-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change an empty line inside of kernel-doc to a " *" (kernel-doc
blank line) to prevent a kernel-doc warning:

drivers/hwtracing/coresight/coresight-etm3x-core.c:118: warning: bad line: 

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Pratik Patel <pratikp@codeaurora.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/hwtracing/coresight/coresight-etm3x-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -115,7 +115,7 @@ static void etm_clr_pwrup(struct etm_drv
  *
  * Basically the same as @coresight_timeout except for the register access
  * method where we have to account for CP14 configurations.
-
+ *
  * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
  * TIMEOUT_US has elapsed, which ever happens first.
  */

