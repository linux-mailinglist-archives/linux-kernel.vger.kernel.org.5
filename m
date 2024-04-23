Return-Path: <linux-kernel+bounces-155039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B7D8AE4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB6F1F23301
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B68913D50A;
	Tue, 23 Apr 2024 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Im36tl6i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B7013D287;
	Tue, 23 Apr 2024 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872450; cv=none; b=okHtbml7pVzlW48GSM/4G4MOHgRAD04g+X3lUqF7zOfAc0eL1Amxzx4avq1j5XA4/aRJm0vuD76+aH5ht5PEGn9H4YQtkP1EgHzZIcdNF2ZMBw7FkHuoOaCyGDgGSWc/jcIRmcCT2JXP/NQPe6BL7ah29DDV1k0Ogya5zT7VXlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872450; c=relaxed/simple;
	bh=hKwut95N+tCwwDS51J+BHVxNHPqZYt4fc8mS6/l5WkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJLhchpwhGsAKJwQTAIZolpWw+g0khdK0AJwkra+qU3JUqK49+yX/IsWONTYptGNd326G+LC5kzTzKU93ir9pqSvZbIYH30B4ChIh5ceQKj6V8uUQCkf8eFMoTQ5BvKK54C34/q+Jz406oGRMrdR0LyVYDTui8JBUzUp4u1TJCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Im36tl6i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549F1C3277B;
	Tue, 23 Apr 2024 11:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872450;
	bh=hKwut95N+tCwwDS51J+BHVxNHPqZYt4fc8mS6/l5WkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Im36tl6izfh2pPqKD7rNovWycGF+r5/iGXy/3XWCSbIDo28CBIf42bobnZHwxbhpM
	 zcWxALeHJHdTYQ1V1S/ATzn66jOmyKXDPKZj3l6LdI4d7uhK4V6PVXY5uBqMAoabLf
	 Hni96H1kEp1rdALQndLl23Mcmc4a2GxWmXhRgbI0Ofhdnl2eyub9/1l/gVzJE+rVo4
	 xTFsaNHK9RvlhowyN/ep/p9Oo6otenMVD6a9MIEOXUpTRXo12T6VD47BEuBeoycLcH
	 sFeltqLIlqODP9Wp3RtdaLc682KZ46RTZtG9kJ9vtZ2HUv7zESynXoF8IEHOwuAAOv
	 oIcGyli17YeHQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 12/16] platform/x86: ISST: Add Granite Rapids-D to HPM CPU list
Date: Tue, 23 Apr 2024 07:01:45 -0400
Message-ID: <20240423110151.1658546-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110151.1658546-1-sashal@kernel.org>
References: <20240423110151.1658546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit d8c2d38c4d1dee8fe8e015b9ebf65bdd8e4da99b ]

Add Granite Rapids-D to hpm_cpu_ids, so that MSR 0x54 can be used.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lore.kernel.org/r/20240415212853.2820470-1-srinivas.pandruvada@linux.intel.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/intel/speed_select_if/isst_if_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
index 08df9494603c5..30951f7131cd9 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_if_common.c
@@ -719,6 +719,7 @@ static struct miscdevice isst_if_char_driver = {
 };
 
 static const struct x86_cpu_id hpm_cpu_ids[] = {
+	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_D,	NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(GRANITERAPIDS_X,	NULL),
 	X86_MATCH_INTEL_FAM6_MODEL(ATOM_CRESTMONT_X,	NULL),
 	{}
-- 
2.43.0


