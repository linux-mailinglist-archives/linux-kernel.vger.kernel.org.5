Return-Path: <linux-kernel+bounces-158522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1414E8B21A0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3C14287712
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6543612CD89;
	Thu, 25 Apr 2024 12:30:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F8912C471
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714048212; cv=none; b=Ce89bEaeoK7ixbR5AxPcseKL2mRRViSNq0TO6jz798fFul0XTTGvB1Rwo/1vnx3uXTPHH7HcmGELxBIfbLSMy1x6MmedNnWUlJfBmnmV6mUVWxPEneTLniz8evouOnfC9P+F+YLIwwIQ7ds1MLDXHT57GId1voSEnOZmclmENcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714048212; c=relaxed/simple;
	bh=z2Psnl1wVaHle3y/n1I1sE5oJsXETVJMcXXbChATn7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dGRyRRoKnCKXK0DVKuQSjrrw/fvzYkrxGGKShYD1wlbw/1tpWb0+ANtp9klGgTSOfm3rB6W8/gYf5hzwIISQrzmbOXCzkOx8mRU2pmLE/yp1Pl3MN3YK14Uj3gx5yqILbIAkQRKikeFtSib/Fq2w4KpLOdSTg6iXZFuifIT9aAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DC141007;
	Thu, 25 Apr 2024 05:30:38 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.40])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D9DBA3F7BD;
	Thu, 25 Apr 2024 05:30:08 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: will@kernel.org,
	mark.rutland@arm.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jialong.yang@shingroup.cn,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: [PATCH 3/3] MAINTAINERS: List Arm interconnect PMUs as supported
Date: Thu, 25 Apr 2024 13:29:54 +0100
Message-Id: <a2484b4fe02e38d86f99f234c94c5497feadfb5b.1713972897.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
In-Reply-To: <cover.1713972897.git.robin.murphy@arm.com>
References: <cover.1713972897.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whatever I may or may not have hoped for, looking after these drivers
seems to have firmly stuck as one of the responsibilities of the job Arm
pays me for, and I would still like to be aware of any other patches, so
make it official.

CC: Ilkka Koskinen <ilkka@os.amperecomputing.com>
CC: Jing Zhang <renyu.zj@linux.alibaba.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aea47e04c3a5..541448195df3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1668,6 +1668,16 @@ F:	drivers/mtd/maps/physmap-versatile.*
 F:	drivers/power/reset/arm-versatile-reboot.c
 F:	drivers/soc/versatile/
 
+ARM INTERCONNECT PMU DRIVERS
+M:	Robin Murphy <robin.murphy@arm.com>
+S:	Supported
+F:	Documentation/admin-guide/perf/arm-cmn.rst
+F:	Documentation/devicetree/bindings/perf/arm,cmn.yaml
+F:	Documentation/devicetree/bindings/perf/arm,ni.yaml
+F:	drivers/perf/arm-cmn.c
+F:	drivers/perf/arm-ni.c
+F:	tools/perf/pmu-events/arch/arm64/arm/cmn/
+
 ARM KOMEDA DRM-KMS DRIVER
 M:	Liviu Dudau <liviu.dudau@arm.com>
 S:	Supported
-- 
2.39.2.101.g768bb238c484.dirty


