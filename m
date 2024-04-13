Return-Path: <linux-kernel+bounces-143599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1BD8A3B49
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 08:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456F6284473
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 06:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5EA29410;
	Sat, 13 Apr 2024 06:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="QQOM8PXq"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB94D208BC
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712990569; cv=none; b=QvLF1uL9bGbUn2fWnnuvuWFh1PXiCwVzpiVhG2K4pWbU/bxgUXGD6GYg5xMKtFA+nu/MYTVHwRLW1GbsUJDqnJP6cB3W8wpxQfBLfL1qMzH0wO47+dIXuz9O/TVN/sDrGKTvwqvaEZfU3T1DRJRX4DDpKukjIm2ZKJoletvdqEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712990569; c=relaxed/simple;
	bh=1I+k1C6YL3NgWZs2rJjCaajJuVIulYenNNvjUcgaP4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aZkdAY9nX2Gz/yfKZUs1WI8tfUB+o//cZMJig9G0zW5lPUp4bznCWvvrjdFP4yMsfIRWVHBC5Sw6fm7YLK9+0Ios3e39SUK66aJu1zqQRKBSmQLh5wiKo1wu/6eCU9cGJ3a1BoUpt/s0tQfizBfOpkIu5kKTY/cl6X4/mf2Z1co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=QQOM8PXq; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1712990566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YqqeOyiGrV8oFKHRZ+mFzcuczR3R+aCyjCSPhTMm31s=;
	b=QQOM8PXqIHLaSwjDv6OAKfVEAI6G7796mSoVOHawE34M91pd0UEemuZw7RI9/ehLBwhsH8
	OqdeeMRgknPK9UFIdTwNMz3931PxePT776hH+BlTJ99lwrULI2S88KWjFWqMTfgAnUPshc
	Nw4qlFLUJFkyFzk3elPzvCLR6xKMhtJABRvPtG/q5n0A161z65QCxTfhhwQOhoQLnwH0Gd
	UO4wcRqRDUb9PBQe3uotTiBeeRWkUWo2eJ/ZnZ0WopjeFuKhnu9eDLJSntbUckfHNCUBRb
	YojEx1qicRrRikSbfeERilShZkrtR+rg3ylIqI1BwvY3qc9bFapk1CUT5D2BYA==
From: Anton Bambura <jenneron@postmarketos.org>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] soundwire: qcom: disable stop clock on 1.3.0 and below
Date: Sat, 13 Apr 2024 09:42:24 +0300
Message-ID: <20240413064225.39643-2-jenneron@postmarketos.org>
In-Reply-To: <20240413064225.39643-1-jenneron@postmarketos.org>
References: <20240413064225.39643-1-jenneron@postmarketos.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This patch returns back the behavior of disabling stop clock on soundwire
1.3.0 and below which seems to have been altered by accident which
results in broken audio on sdm845 + wcd9340. For example, on AYN Odin and
Lenovo Yoga C630 devices.

Fixes: 4830bfa2c812 ("soundwire: qcom: set clk stop need reset flag at runtime")
Signed-off-by: Anton Bambura <jenneron@postmarketos.org>
---
 drivers/soundwire/qcom.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index a1e2d6c98186..bc03484a28e8 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -628,6 +628,9 @@ static int qcom_swrm_enumerate(struct sdw_bus *bus)
 			}
 		}
 
+		if (ctrl->version <= SWRM_VERSION_1_3_0)
+			ctrl->clock_stop_not_supported = true;
+
 		if (!found) {
 			qcom_swrm_set_slave_dev_num(bus, NULL, i);
 			sdw_slave_add(bus, &id, NULL);
-- 
2.43.0


