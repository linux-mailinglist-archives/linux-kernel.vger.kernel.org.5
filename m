Return-Path: <linux-kernel+bounces-58482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5821984E705
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 819AD1C214D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8565586133;
	Thu,  8 Feb 2024 17:46:11 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3440B85C7F
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414371; cv=none; b=WKUxVYAraMVU4NZHjDAXdQqFXJcvCBHZhTOjSWByQTvhtGmOvr5oYRfhvbP4nDOjq6rS5L0hy+HUavNKXMctz3iahJ9ZAz8ShlZSbpX+J7AyPtQcJ3DbYIcMz5p8KEFxwV66GsK/KO7xJgy+iNRr7Kl3DBCWLKUKIrv2tQz5r1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414371; c=relaxed/simple;
	bh=TovmD2j51jtTM66hpCFmsorXcQli9Xe6IuYTQkybXjc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PVg2fciNgdgs+v1u5PADaeCW+1eLkWJX4kG7LndOBZLP4g3hInrnvfljTnymoLWDaUH/8s0FqRbPn8SoVDiGx4sh7ZiYnunXqKuo/BYQ0Ee+N2Knex4L6oLVJEPkZAGbr5f0dqoTRWwcA1P9CtmX5EjPm3Q4WPKFC2UiBwgM8kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a389a3b9601so6183266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 09:46:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414367; x=1708019167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8mdU4S5Z5jADGob+hYKZdQF6w6k19+tD96wjo2aggCI=;
        b=K93zVtk5TqIwATKVIZx2obDuK4bk/Dbq1WH0TGil0G4BVpsYE7a6EUMaCUHdCQ2BOY
         tBlfHysKW4ZMphPry7Iulv57J0PbF6C58G/Tfjnmzrq6Skejp1X5QD/6WMTLMhMHyB8Q
         cBTf6fIewkt8dDHEHXFhS18Ss2TyQZ0zg288KCt1y65w32vvGamcvIdDG6cm/S9kaOL5
         DHTlTtXVdDIB3nbNhFFMobTGTfdgo89FLRDn15Ycb2Ry5KQvEANUTfxny/9yFPco9eeP
         UoE0DqD+Nwy8iUFCidPDRq56nSTkM8Oe/byg1Hu3RkFjpHt8dG28gQhnNtAXFuVTisfz
         Fo6w==
X-Forwarded-Encrypted: i=1; AJvYcCXirlOU99A8mkFvhp8AmI0aKWQzE1L0jkam6c3KNgOFFnVo7gyli9pdccM8QaDe5nOPOMj0VZd7Ggogi5p5ZVXxFH091PNUr2G7Q/QE
X-Gm-Message-State: AOJu0YzIaZQVkgm8EBaAY6pBYtd2WrIAIHmWoah0/ncvM3p0FsjXu51s
	9pOmYKoYi60kAektelw37maaJ28m3OsO6CFPs/+XklYVfVQe1ObX
X-Google-Smtp-Source: AGHT+IE/NGUmUZa1HOZoJhtbMvfFj82zgAdXKstcjYYV4edhyWYdVIS+isjB8QkNSHWH4ayteQ4bNg==
X-Received: by 2002:a17:906:513:b0:a35:85b7:560a with SMTP id j19-20020a170906051300b00a3585b7560amr21260eja.46.1707414367231;
        Thu, 08 Feb 2024 09:46:07 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWmKYaA/lT6du156ic13GRUErnXvg5MDe93/akcNihhYG03c7fEkUS2f0KLeffbHrs8qj1W2rNwSfEEjq68sjdpFxjrEkuOFEfXvznYm8GA2n26J6cE46c4Qnc+3GeH8OepnJ2Awe0eq8ZROFKUQuoMOtNzdDdZJSpDOhaBnBEMst6WzYCIX2sUTflrJSweHviUpY8aw65t6gAxqn69VBpzxw==
Received: from localhost (fwdproxy-lla-117.fbsv.net. [2a03:2880:30ff:75::face:b00c])
        by smtp.gmail.com with ESMTPSA id jx21-20020a170906ca5500b00a371a1b40c1sm281935ejb.23.2024.02.08.09.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 09:46:06 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
To: mingo@redhat.com
Cc: jpoimboe@kernel.org,
	x86@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Subject: [PATCH v2 0/3] x86/bugs: Separate config for mitigations (part 2)
Date: Thu,  8 Feb 2024 09:45:52 -0800
Message-Id: <20240208174555.44200-1-leitao@debian.org>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current CONFIG_SPECULATION_MITIGATIONS namespace is only
halfway populated, where some mitigations have entries in Kconfig, and
they could be modified, while others mitigations do not have Kconfig
entries, and can not be controlled at build time.

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
Patch 2: Make spectre v2 userspace mitigation dependent on kernel
         mitigations.
Patch 3: Add a Kconfig entry for each mitigation that doesn't have such

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

Changelog:

v1:
  * https://lore.kernel.org/all/20240118173213.2008115-1-leitao@debian.org/

v2:
  * Patch 2: Changed `mode` type from int to `enum spectre_v2_user_cmd`
    as suggested by Pawan Gupta
  * Patch 3: Change MITIGATION_RETBLEED dependency to match the code.

PS: This patchset is against tip/x86/bugs branch.

Breno Leitao (3):
  x86/bugs: Create a way to disable GDS mitigation
  x86/bugs: spectre_v2_user default mode depends on main default
  x86/bugs: Add a separate config for missing mitigation

 arch/x86/Kconfig           | 117 +++++++++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/bugs.c |  56 +++++++++++-------
 2 files changed, 147 insertions(+), 26 deletions(-)

-- 
2.39.3


