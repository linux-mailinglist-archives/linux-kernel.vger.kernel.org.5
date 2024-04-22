Return-Path: <linux-kernel+bounces-153764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCB18AD2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9261C20E45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F7B153832;
	Mon, 22 Apr 2024 16:58:51 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC25153825
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713805130; cv=none; b=BSRvzsN/+UN9LjGLmT1LLyRKN1kS4GyJQWqPiyT+kMeYTc3x892EzT6963+pIeoij1IOUHaew4Mcw56id/5YsPmbdsKJDr/k2jJPiP5s9Ha+V2XomjF3ccyCajySPjrASQXpNlisQ6UpqoPic2DrzUn7edzCnqfQIw+alMnNK1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713805130; c=relaxed/simple;
	bh=jjj5jPrwF+lxQV91ehefWDPdbAf+KONmwhC5TEerBzw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NXx3gbP9ZPlYX8Qpb76cLXzW0B9QdyMwEJqYudvs/d3uUQk2kfZ9CYBkbXPkqVx7pqfl47k28IvEKoX80eHNfRQ+dqjaoPUkui3R+dCvDH6Z+dZyj/36T3Z/86+eMrX7vYpGESesBRPW3LvIQz/FiDhg5EAUgkdJfh23GQAANTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a5544fd07easo519543466b.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713805127; x=1714409927;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2+Xvj/XO4sTHp5aN1cVE+tNgMsTv2wp93ECmexNu930=;
        b=Idp2jjR7xORgE5rk9hYYcJtCnGPNwl/AM4GoCVlLeFWJCf/VPwYNAPK5IqC4mSSgGL
         /70heihXQ8rvrrj3sY3EIO/QU+4G2HgNAofA2mkzlvt8PYeBmyvb0TXLIshKAwWJ3NoS
         XYusMKiCPTy0hZhMHCi5hCfd5aWIx4QkDsS/2NQtHTWTN9sYIbDaTCmphwKwHK3mdlvh
         +TsdcHfKx0P7aEnF31EiD8MFNkquAn1aF6YJVl1DqoK44903z+jvS/pE6wfcI+s5Tb/7
         UR4t3+7+n2IuoEj0VHfPhNFm7YOt/jfyuGzELtAwOPlI+9giCsFZ9Kaq3PxC/q1BJ7SE
         XZyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBT62wIObc7DKqEQWscAAJ4dLAlGSaqV4Szbntv2821ROE3GQiqItaR/eXmjcq1UzaLmVAI6vyFI73iLuyVaQNJm+xxKNL8Llyh9X9
X-Gm-Message-State: AOJu0YwmEpCDPs226CMtbMP/PWfVyP3X84YA5itkn4vDUSIT/giOEuEm
	ZbhLBg6UfMaqxPLq1oretjqbwlb3V5G8da52aYxYRVSoRliuS2/1
X-Google-Smtp-Source: AGHT+IG2nFpq/AMNwZll7t0i30Yz8afG6C5lBfZJFxzkrUdZXMFJSenxJzp0wWzSPpeR42aMeH/lPg==
X-Received: by 2002:a17:906:f757:b0:a58:72ae:722c with SMTP id jp23-20020a170906f75700b00a5872ae722cmr528052ejb.29.1713805126999;
        Mon, 22 Apr 2024 09:58:46 -0700 (PDT)
Received: from localhost (fwdproxy-lla-003.fbsv.net. [2a03:2880:30ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id be11-20020a1709070a4b00b00a5588a9fe66sm4433425ejc.86.2024.04.22.09.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 09:58:46 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: jpoimboe@kernel.org,
	mingo@redhat.com
Cc: x86@kernel.org,
	tglx@linutronix.de,
	bp@alien8.de,
	linux-kernel@vger.kernel.org,
	pawan.kumar.gupta@linux.intel.com
Subject: [PATCH v3 00/10] x86/bugs: Separate config for mitigations
Date: Mon, 22 Apr 2024 09:58:14 -0700
Message-ID: <20240422165830.2142904-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
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

New mitigations, such as BHI, were properly added, i.e, having an
independent Kconfig, which depends on CONFIG_SPECULATION_MITIGATIONS,
so, you can enable/disable at compilation time.

This patch set aims to have the old mitigations in the same format,
bringing some uniformity to the mitigations.

These are the advantages of having fine-grained control for the
mitigations:

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

v3:
  * Rebased the patch on top of linux-next, since BHI mitigation added
    some hunk to original patch series.
  * Broke down the patches even further, creating one patch for each
    mitigation. This make the review code easier (I hope).
	* Nothing was changed, code-wise. The code is *exactly* the * same
  * Dropped the "spectre_v2_user default mode depends on main default"
    patch, that will be sent later, since there is no dependency to this
    patch series. Hopping to make the review/acceptance easier as well.
v2:
  * Patch 2: Changed `mode` type from int to `enum spectre_v2_user_cmd`
    as suggested by Pawan Gupta
  * Patch 3: Change MITIGATION_RETBLEED dependency to match the code.
  * https://lore.kernel.org/all/20240208174555.44200-1-leitao@debian.org/
v1:
  * https://lore.kernel.org/all/20240118173213.2008115-1-leitao@debian.org/

Breno Leitao (10):
  x86/bugs: Add a separate config for GDS
  x86/bugs: Add a separate config for MDS
  x86/bugs: Add a separate config for TAA
  x86/bugs: Add a separate config for MMIO Stable Data
  x86/bugs: Add a separate config for L1TF
  x86/bugs: Add a separate config for RETBLEED
  x86/bugs: Add a separate config for Spectre v1
  x86/bugs: Add a separate config for SRBDS
  x86/bugs: Add a separate config for Spectre V2
  x86/bugs: Add a separate config for SSB

 arch/x86/Kconfig           | 117 +++++++++++++++++++++++++++++++++++--
 arch/x86/kernel/cpu/bugs.c |  46 +++++++++------
 2 files changed, 140 insertions(+), 23 deletions(-)

-- 
2.43.0


