Return-Path: <linux-kernel+bounces-57814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D835E84DDB1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AD991F27EE6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED316DD0D;
	Thu,  8 Feb 2024 10:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fGePYv3t"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEDC6A8BB;
	Thu,  8 Feb 2024 10:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386465; cv=none; b=uK5AQbxPuavSsD/OhNhpMjMoaddAIPCAgyg80bAqhguB81zVpXl+1SLKiKi1VjYAktHKYh3r6DxXTW5llgqcFCeOKjudKZ4EP8UcyL4aDBfEUfsR/Q3NizWAaWBjNWpaVAr06C2pD8kPkScsyrH9NKjEM91MK79aLvDp8ymkmtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386465; c=relaxed/simple;
	bh=QdAtsmJAqD21B3GWv8/xJXnL6FFTkI21JTQdzVgWRPA=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=W7aSDGSkBYCAaYjzQ6igrTaGbkzaBUOTj09C9Z+8sk3ggj+zaJk1z2tsRJMF+M9OyTDO4KFH7fkOVMazkVA4WAmn6xzDWT1n2uq+daHba3RWgdHyUIakAQGbT8+Rb9/j0W8GIpHkH4PpHEhJkI33BQ2KUnotp3yLsudDmFKTiyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=fGePYv3t; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TVstx73VXz9svQ;
	Thu,  8 Feb 2024 11:00:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1707386458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Barut0WbxR8ZK4VaiV9eTXhumtMeDqIqqbIXK0ewMac=;
	b=fGePYv3ttH/RDbDWXPu1vUWKmRBKZee+sonviJghwd/dIEfo1MRnefu3DlYcG5VpO7Mx6Q
	FUIE+Il+xQVUMGYNSpDRiwaJP+V15RcuUEFe6Bm06Qn9FHrBR1d90PNEcLIo0og/9AVWzt
	iSdVV3I7L2e6fTT2VUjfYZBQkfE6+yslsspmJUbHVoSbWWUhcdSKdJ2FXsL6/H0ijkqSXb
	gGii79eWD/rrj1LWGrIPXbT3PJBS3SHxVwjWoVUmTW9B2+uyr/9iMErMF40PdOX6DV8N2C
	TMP+ZY+54z4sU101e4JOV2fTcNPLhx1yAhIJFlDJCSbI5xPLHpSJcaWJmj67RQ==
Message-ID: <8eefeeb7-f8e8-49f4-b83c-e67a9e728f41@mailbox.org>
Date: Thu, 8 Feb 2024 11:00:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: Perry Yuan <Perry.Yuan@amd.com>, Huang Rui <ray.huang@amd.com>,
 "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 "Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
From: Tor Vic <torvic9@mailbox.org>
Subject: [PATCH v2] cpufreq: amd-pstate: Fix min_perf assignment in
 amd_pstate_adjust_perf()
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e587f8e7f120ffd8bfa
X-MBO-RS-META: nq6zerw71rdaaxdbo5g7f95humxm8hnk

In the function amd_pstate_adjust_perf(), the 'min_perf' variable is set
to 'highest_perf' instead of 'lowest_perf'.

Cc: stable@vger.kernel.org # 6.1+
Fixes: 1d215f0319c2 ("cpufreq: amd-pstate: Add fast switch function for 
AMD P-State")
Reported-by: Oleksandr Natalenko <oleksandr@natalenko.name>
Reviewed-by: Perry Yuan <Perry.Yuan@amd.com>
Signed-off-by: Tor Vic <torvic9@mailbox.org>
---
v1->v2: Add Perry's 'Reviewed-by' and 'Cc: stable' tag
---
  drivers/cpufreq/amd-pstate.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 08e112444c27..aa5e57e27d2b 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -577,7 +577,7 @@ static void amd_pstate_adjust_perf(unsigned int cpu,
      if (target_perf < capacity)
          des_perf = DIV_ROUND_UP(cap_perf * target_perf, capacity);

-    min_perf = READ_ONCE(cpudata->highest_perf);
+    min_perf = READ_ONCE(cpudata->lowest_perf);
      if (_min_perf < capacity)
          min_perf = DIV_ROUND_UP(cap_perf * _min_perf, capacity);

-- 
2.43.0

