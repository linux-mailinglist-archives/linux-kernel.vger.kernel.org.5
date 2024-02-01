Return-Path: <linux-kernel+bounces-47530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D453A844F01
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128011C228F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE1E134C2;
	Thu,  1 Feb 2024 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F6B6/4GF"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB58EAE8
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 02:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706753439; cv=none; b=kMRqJzpIWYF1KMS9aEDRO/HSBonAUPehfiiRxlXJENBG2NgWX0n9o1sHGhcG9k74XyaFzQ67g1RpeHaKqPL500Xj2XugKP5Jz/2dSsRHhqrxv4qmHUyXwx4zD6nHbCMVAUik6VrWgE2LW0Yi59vz+dFUBVrGUb0M6vLggOqcKJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706753439; c=relaxed/simple;
	bh=u3rKqFEkSo0zVEgKTB7IgMhmPZnJpZu17BJLf0uuI2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BO+atxRFKD+VZQqiHX8wewc/rRaawBNcTWaY1tn6I7cV7A4o4W7XNDszSKK5jr+zyuJgUgGeDXjPGoPYaqnl/8dQRka87OCG46PtGpqM/alyGhkTIM6geJZCZdotOqYM/pUIKoa1DVTTAiQZt/zW2C48BUyqVrg5bBfeGeSAC20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F6B6/4GF; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706753435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Cdc/ntI2UR/qVfx27ez4OECx9XU0DBaEGKPZs4OtWYw=;
	b=F6B6/4GFme/6lmYnm+jjSXQVrc29/tIPurNzJrCSsQ85+iS66BytMpr51U/vsYfMNzAsXs
	qNvQhrjOA6EbVe7AQno9pSidljO1dg+4E6ieYb3QsS4qY+DEKb9CJld/eVnbTjVcWh89UO
	SssIRtKkvKdF60pnyDy/DMr177CpYY0=
From: Leo Yan <leo.yan@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Namhyung Kim <namhyung@kernel.org>,
	James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	linux-kernel@vger.kernel.org
Cc: Leo Yan <leo.yan@linux.dev>
Subject: [PATCH] MAINTAINERS: Update my email address
Date: Thu,  1 Feb 2024 10:10:08 +0800
Message-ID: <20240201021022.886-1-leo.yan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

I will lose access to my @linaro.org email address next week, update the
MAINTAINERS file and map it in .mailmap with the new email address.

Signed-off-by: Leo Yan <leo.yan@linux.dev>
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 04998f7bda81..dc33af97878f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -344,6 +344,7 @@ Leonid I Ananiev <leonid.i.ananiev@intel.com>
 Leon Romanovsky <leon@kernel.org> <leon@leon.nu>
 Leon Romanovsky <leon@kernel.org> <leonro@mellanox.com>
 Leon Romanovsky <leon@kernel.org> <leonro@nvidia.com>
+Leo Yan <leo.yan@linux.dev> <leo.yan@linaro.org>
 Liam Mark <quic_lmark@quicinc.com> <lmark@codeaurora.org>
 Linas Vepstas <linas@austin.ibm.com>
 Linus Lüssing <linus.luessing@c0d3.blue> <linus.luessing@ascom.ch>
diff --git a/MAINTAINERS b/MAINTAINERS
index c4828ab15f1a..082aaad5c65c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17182,7 +17182,7 @@ R:	John Garry <john.g.garry@oracle.com>
 R:	Will Deacon <will@kernel.org>
 R:	James Clark <james.clark@arm.com>
 R:	Mike Leach <mike.leach@linaro.org>
-R:	Leo Yan <leo.yan@linaro.org>
+R:	Leo Yan <leo.yan@linux.dev>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Supported
 F:	tools/build/feature/test-libopencsd.c
-- 
2.43.0


