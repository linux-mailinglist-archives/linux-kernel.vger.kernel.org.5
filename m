Return-Path: <linux-kernel+bounces-30420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F75831E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A291F21F04
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D18D2D049;
	Thu, 18 Jan 2024 17:32:33 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DA22D03B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599153; cv=none; b=lqvwiQTjbG7g1rQbwIvnhUtvJfm2+ROdhrgfbVHP2ZknI9D9ZAHaPpzWJ3yVmsYGltDJoJcCIulhDksGCZRhk0RMv8QqwFxZ/F92KzOvZdTE0hcHCPeIPUcHsoPWB4iVByx/TJRZmvD0BapiqxwDcgnR0Z8miH27R747LNiZUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599153; c=relaxed/simple;
	bh=8vZW7ae9M/fsdkBQvJd0F3gvCjQeTEfCau3U1Be8stI=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding; b=up5JLWGUe8twno34eZpkNaDze8QGq6rw11ZAuYZ6TQeujkIaNlGUL4FTP/qxK6OVW3XId5MWgB3UpyFJCVlvK4oY9wnrgIaQ3zJUsT6q9g2HOcMt4wL/wU0mo6EsxztDWUEwIQchdVkjRUouP1d+f64dssmtSnNwPWSZx9MOhfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26f73732c5so1450776466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:32:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705599149; x=1706203949;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4wLhGa6Yk3lRyKA7quLUv+d0q8TE5jqEmzi7Wu30oo=;
        b=RfCx56VttaDHNu6q4umRqwXpvKVqTX+j5RPP5I0dm8bFcOznEu5yb5lmxVc1bADMu/
         6S448wGAPmL9UZ1TkAA+uiuu8nbhdohryRhv09GKM33XrPSusiNQuEjcc/YpqD5jo55G
         NwcMcN5wYYsV5vCeQrKJMniaXVWcRwtLTLG5R5Z6oIZhT7EWcjfJktHpk2uvLmMQEguD
         nOPuMhRG3IR/a7iOzkKkY/IBG0f4fzUTpcAoMCBJF/RWvjUcSNmvXwJThfLfyDuhl7+R
         1QmFrYmmvlGcj+1DbvJQfxB7i/T41zvGcPH7s7SR06oKLJRuNAPK8JM+HLgfYPMXLXIF
         nesg==
X-Gm-Message-State: AOJu0YyxAr6rk0wkjX1JrKZd56jQb8yzFtcCC5aH2vDeCLrJ3nflZnsC
	KOqfdMHtpFXQT3GbUozUHdksuLzJbS5AgMTC/fNZ3RlGtMdcWuQH
X-Google-Smtp-Source: AGHT+IGAGOf1exf5CH+Zk9nbOBFWtMemx29YnJftAlOT7tKyQcrXrAbqQiirPxjsseNuMGRyWl3O2g==
X-Received: by 2002:a17:907:ca24:b0:a23:62e7:d4cf with SMTP id uk36-20020a170907ca2400b00a2362e7d4cfmr650083ejc.34.1705599149277;
        Thu, 18 Jan 2024 09:32:29 -0800 (PST)
Received: from localhost (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id n5-20020a170906b30500b00a28ace8fb17sm9288088ejz.206.2024.01.18.09.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 09:32:28 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: mingo@kernel.org
Cc: jpoimboe@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Subject: [PATCH 0/3] x86/bugs: Separate config for mitigations (part 2)
Date: Thu, 18 Jan 2024 09:32:10 -0800
Message-Id: <20240118173213.2008115-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current CONFIG_SPECULATION_MITIGATIONS namespace is only
halfway populated, where some mitigations have entries in Kconfig, and
they could be modified, while others mitigations do not have Kconfig entries,
and can not be controlled at build time.

Fine-grained control over these Kconfig entries can help in a number of ways:

1) Users can choose and pick only mitigations that are important for
 their workloads.

2) Users and developers can choose to disable mitigations that mangle
 the assembly code generation, making it hard to read.

3) Separate Kconfigs for just source code readability,
 so that we see *which* butt-ugly piece of crap code is for what
 reason...

In most cases, if a mitigation is disabled at compilation time, it
can still be enabled at runtime using kernel command line arguments.

This is the second part of the initial patchset[1] that got half landed.
The first patch did some code re-organization. This second part
contains the exact missing patches from the initial patchset, and
basically adds build-time configuration for the other mitigations that
are currently only disabled at boot time.

Here is a detailed view of each patch:

Patch 1: Create a Kconfig to disable GDS mitigation.
Patch 2: Add a Kconfig entry for each mitigation that doesn't have such
Patch 3: Make spectre v2 userspace mitigation dependent on kernel
         mitigations.

With this patch applied, setting CONFIG_SPECULATION_MITIGATIONS=n, a
simple script[2] shows that all the mitigations are disabled:

  spectre_v2_user_stibp   	 SPECTRE_V2_USER_NONE
  spectre_v2_user_ibpb    	 SPECTRE_V2_USER_NONE
  spectre_v2_cmd          	 SPECTRE_V2_CMD_NONE
  ssb_mode                	 SPEC_STORE_BYPASS_NONE
  l1tf_mitigation         	 L1TF_MITIGATION_OFF
  srso_mitigation         	 SRSO_MITIGATION_NONE
  srso_cmd                	 SRSO_CMD_SAFE_RET
  mds_mitigation          	 MDS_MITIGATION_OFF
  taa_mitigation          	 TAA_MITIGATION_OFF
  mmio_mitigation         	 MMIO_MITIGATION_OFF
  srbds_mitigation        	 SRBDS_MITIGATION_OFF
  gds_mitigation          	 GDS_MITIGATION_OFF
  spectre_v1_mitigation   	 SPECTRE_V1_MITIGATION_NONE
  spectre_v2_enabled      	 SPECTRE_V2_NONE
  retbleed_mitigation     	 RETBLEED_MITIGATION_NONE

[1] https://lore.kernel.org/all/ZZ7c9EbJ71zU5TOF@gmail.com/#t
[2] https://github.com/leitao/debug/blob/main/spec/dump_speculation.py

Breno Leitao (3):
  x86/bugs: Create a way to disable GDS mitigation
  x86/bugs: Add a separate config for missing mitigation
  x86/bugs: spectre_v2_user default mode depends on main default

 arch/x86/Kconfig           | 117 +++++++++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/bugs.c |  57 +++++++++++-------
 2 files changed, 147 insertions(+), 27 deletions(-)

-- 
2.34.1


