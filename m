Return-Path: <linux-kernel+bounces-70095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F0A8592F8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 22:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4027D1F22340
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F1B7FBCB;
	Sat, 17 Feb 2024 21:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="eI7TuNtg"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21FF1D6A4
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708205417; cv=none; b=E7i3OjleJxc9LTzk1bJzqjWgZ5ld19BOFphM8/3f5JbDyXp5LXmNpMJif5LA/uXGXS3Y9x/44zV7Iyfjsd9n/YAK8uE5oPFj9L5RdYFPRJgh46angFo4rBp2nKG6+O9s8D3luKeOxNJn4iUpQ256klYf2aMOmqtfCaRgGZauwY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708205417; c=relaxed/simple;
	bh=oHOAKuTy7J71OhteqliHHPUc4sWlt3H4+04j1XqQTGg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tV/VzShUlU+/BzhYR6dT/DYg6LXG+fqfIqTjLj7BY+RGI8T7y0V7jC8MzyVqjRSVw5yYT3/HRQuf7Zg0RSKtP26wpGNJszoqg3af7Zl2SiMaFvByIKTZKRSo3Utc7EjDvT/fjvlg0DwsMjd3mVQMZkrbkf3PKK0qFA4OF36iSrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=eI7TuNtg; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e2fb9263a6so580007a34.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 13:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1708205415; x=1708810215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O2TjNiYVkyOnt5bo8I4KiLztzjuw78NyYvMLjikMof0=;
        b=eI7TuNtgEx7EeRlZ6+A6ndoN5Rt3ObQbScF+xb2faOkiIkPec17KMIpgOibgKfnb/A
         5OvILmB0I7kRbscJa1/JNPUZshEl4tgyKU7WXDJj21IMEMrPQmFcPsh/G5FDoVaB+FqW
         /YaG2vzeiWUHJu+jOlY+oFAqNVwwIxBbANlJ5QSwRuGZTIbNZLka5NXFsXauISXpU1Kz
         RrHfLCOVG5UyaEhHy4qBybdav1l/nlqPbb4WDZqHIgEl2TfD0AEI+FJhTSFVWC8PJTDE
         HJC//Am+NdlXZJde62EvnbogEOy301ZRn/vIxPn+tCFSLMIgf5uAmjFTZUyXoOhsoSBU
         8Byw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708205415; x=1708810215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O2TjNiYVkyOnt5bo8I4KiLztzjuw78NyYvMLjikMof0=;
        b=rCmXE1qdgcxmXSn1sxdws1ywa1YtrwJxmWVbx1zWTGNrnNIrivv9rbiJ1G7TuPdJyl
         lp3xVxgrnp/VU4R1aqzZ2KpQeqDJFrQlkCwUOPKeDkmd75acIgCZVelO143spFMa6fOX
         WFlz75/OXwk4Uozg62q3mcl4O1ynb5KADmnODS+dfLah9cEps73LX/d+V7jtaQ0Otrr4
         S6CPyQ+qhKR9QK/WlahdLa43IRfX3FV4MU50GwaO3E0p1C0q5vLqUXKm0inePhedgREe
         i33WdqGPzK8W2sNhLM8dkbbtLLZwu4S+bSsVmejBRCxiVEHQW/5SIjOnHlhhxxCIBI1E
         bMBA==
X-Gm-Message-State: AOJu0YxKc4Fv6/C4IX/b3M0xmpkvwmM9DFCA0i+ZzWsk318JI/gMAdFj
	bg3cRM9yazh6mD+tRV2xqzuCyfVC1kB1tm9WZP5GjU1sAq5S5FtYgd3pl9mBeek=
X-Google-Smtp-Source: AGHT+IGW4XDSRQnU5TqrVNGjd8jmkPOXe9/UfYHAlOzGyGXigM5epRQtoQ/vkhh8yDpNAprzFP48aA==
X-Received: by 2002:a05:6830:1b6d:b0:6e4:41bb:b30 with SMTP id d13-20020a0568301b6d00b006e441bb0b30mr2472025ote.19.1708205414732;
        Sat, 17 Feb 2024 13:30:14 -0800 (PST)
Received: from s19.smythies.com (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id bn16-20020a056a00325000b006e0cfe94fc5sm2090721pfb.107.2024.02.17.13.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 13:30:14 -0800 (PST)
From: Doug Smythies <dsmythies@telus.net>
To: srinivas.pandruvada@linux.intel.com,
	rafael@kernel.org,
	lenb@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	vincent.guittot@linaro.org,
	dsmythies@telus.net
Subject: [PATCH] cpufreq: intel_pstate: fix pstate limits enforcement for adjust_perf call back
Date: Sat, 17 Feb 2024 13:30:10 -0800
Message-Id: <20240217213010.2466-1-dsmythies@telus.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a loophole in pstate limit clamping for the intel_cpufreq CPU
frequency scaling driver (intel_pstate in passive mode), schedutil CPU
frequency scaling governor, HWP (HardWare Pstate) control enabled, when
the adjust_perf call back path is used.

Fix it.

Signed-off-by: Doug Smythies <dsmythies@telus.net>
---
 drivers/cpufreq/intel_pstate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ca94e60e705a..79619227ea51 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2987,6 +2987,9 @@ static void intel_cpufreq_adjust_perf(unsigned int cpunum,
 	if (min_pstate < cpu->min_perf_ratio)
 		min_pstate = cpu->min_perf_ratio;
 
+	if (min_pstate > cpu->max_perf_ratio)
+		min_pstate = cpu->max_perf_ratio;
+
 	max_pstate = min(cap_pstate, cpu->max_perf_ratio);
 	if (max_pstate < min_pstate)
 		max_pstate = min_pstate;
-- 
2.25.1


