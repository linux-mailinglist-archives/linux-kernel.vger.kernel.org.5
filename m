Return-Path: <linux-kernel+bounces-31683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB9283327E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 03:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C3081C212CA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 02:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BD5ED4;
	Sat, 20 Jan 2024 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1qG/7bV"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0DC19C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 02:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705719058; cv=none; b=CoWA7/fd4N1zA708baH+Y0GGzMATYippM0E71RvFeNsvs2gqqtJ4PW65gmGzPbWWlPcQo/mvoO2mPktac+1V++f3Fvb3UXfqJYSP7QU6crKFa8rifg+eIo/XlBJSWV2el8buNV4fe62tF6AGQzKQZesIfAm1lIilyjwQ3GDi3YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705719058; c=relaxed/simple;
	bh=jlvsxULkeW/blL5fvnferi1cwmPNsRbqS/xeMgFplho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=apnSzwY4i1q573uRkeqkkzukzfdQmeoNl1zlcfR7nYI2hiKwEDVaocUSKC4kyImZhAtvVP3JQwApzeviRojUZyS+bmSHu24bKKR3R+AwkNd2vu8lviukk0gerV8KQR5xfswAm56+AEr+XhWZncQmtpdiby7h+MqIsXN0OPai5B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1qG/7bV; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7beefdfe71eso63883639f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 18:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705719056; x=1706323856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eo2bBQh51C38yHh9hzAq8dXsXTQ+MDQLVYOGyRagE2A=;
        b=D1qG/7bVHu8yOneApVGldFrDBbuSYRlVFN1hCjXnDaC4nH8MmjdyRDbPELAc0TYry2
         58JTOFqhKtAxhr5iLWzA1ZYjW1vhjkXB2lMOuV/jWnUmCsiep4yV/H3JXww1hugniG4U
         vbpjSgrtiMnsCLq7DmODO83yt3lpcqaxFcNw2fhzoI0WN6oQZpDp61ryY9CJpioFnQQz
         aHcJ3Beob6mhPdH7F0vDSCA9CozXl+RJ917pN2xaspL1WjPT6bFDxw//FIj3v8EQxjLK
         CvRc005LgFBefol9F/9wdJtyqA6x40k++7iYDIOzJnEku9cl2LU32wddEN3bg3DLpjgc
         S8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705719056; x=1706323856;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eo2bBQh51C38yHh9hzAq8dXsXTQ+MDQLVYOGyRagE2A=;
        b=i3hzGHgwLyPPPqunilEpEArrgPRRF74+axlGgbGqiXmg/bKycW7EB1IDrI/6mtWNjV
         OqndSrW+hMFb2eh5KHuZmqDk06nzzakKYmkjbXB7+spy6UltNFqMlNq6JM0YbsslKtpH
         Bcixad8SlPAnkV3xuf7kk5HP8pggcpOolfCz454mjO/UdXSLnXpFpGbGR3waZUtyMVKM
         0FNT3J8ulXPjNnxsKfpkWH+s2VTJsoaywAZ+TK5hooLpCgcTU9SP5nzJX+NcyK9y7iqF
         kvmV0okS7OsNPKS+S9UAMZ9CTemtdVoEdPhQDLeojMn8VRgpRdB0G1GrEjMx+2z1TCAh
         HS0w==
X-Gm-Message-State: AOJu0YxHApDzeG3iMo45otrllGrT5SgeXm0sAvAEmZHTC7fGckZQtyf9
	LcTelBxQJ9MdfWCdN7rjX2EeXYlP3TbjFExQRaB4oJHHIpkGLQLJ
X-Google-Smtp-Source: AGHT+IFeD/RvKGQgcHywmhkb2496iT1Odi6qkaUBVHzm6L6nk/mjxrq1RO57JU51Uz2evZSGt5WiHg==
X-Received: by 2002:a05:6e02:e46:b0:361:a7aa:c8fb with SMTP id l6-20020a056e020e4600b00361a7aac8fbmr706257ilk.34.1705719055768;
        Fri, 19 Jan 2024 18:50:55 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:2288:782e:a717:678d])
        by smtp.gmail.com with ESMTPSA id n133-20020a81728b000000b005ffa141d9f4sm695177ywc.18.2024.01.19.18.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 18:50:55 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Breno Leitao <leitao@debian.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Zi Yan <ziy@nvidia.com>
Subject: [PATCH v5 0/9] lib/group_cpus: rework grp_spread_init_one() and make it O(1)
Date: Fri, 19 Jan 2024 18:50:44 -0800
Message-Id: <20240120025053.684838-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

grp_spread_init_one() implementation is sub-optimal because it
traverses bitmaps from the beginning, instead of picking from the
previous iteration.

Fix it and use find_bit API where appropriate. While here, optimize
cpumasks allocation and drop unneeded cpumask_empty() call.

---
v1: https://lore.kernel.org/all/ZW5MI3rKQueLM0Bz@yury-ThinkPad/T/
v2: https://lore.kernel.org/lkml/ZXKNVRu3AfvjaFhK@fedora/T/
v3: https://lore.kernel.org/lkml/20231212042108.682072-7-yury.norov@gmail.com/T/
v4: https://lore.kernel.org/lkml/20231228200936.2475595-1-yury.norov@gmail.com/T/
v5: add CPUMASK_NULL macro and use it to initialize cpumask_var_t
    variables properly.

On cpumask_var_t initialization issue:

The idea of having different types behind the same typedef has been
considered nasty for quite a while. See a comment in include/linux/cpumask.h
for example.

Now that I'm trying to adopt kernel cleanup machinery to cpumasks, it
reveals another disadvantage of this approach - there's no way to assign
a cpumask_var_t variable at declaration time, which is required by
cleanup implementation.

To fix that, in v5 I added a CPUMASK_NULL macro as a workaround. This
CPUMASK_NULL would be also useful for those converting existing codebase
to enable cleanup variables.

On a long term, it's better to drop CPUMASK_OFFSTACK entirely. Moreover,
it's used only on Power and x86 machines if NR_CPUS >= 8K (unless people
enable it explicitly, and nobody bothers doing that in a real life). But
it requires some more discussions with Power and x64 people...

Meanwhile, I'm going to submit a patchset that deprecates cpumask_var_t,
and adds a new set of allocators which would support initialization at
declaration time.

Yury Norov (9):
  cpumask: introduce for_each_cpu_and_from()
  lib/group_cpus: optimize inner loop in grp_spread_init_one()
  lib/group_cpus: relax atomicity requirement in grp_spread_init_one()
  lib/group_cpus: optimize outer loop in grp_spread_init_one()
  lib/group_cpus: don't zero cpumasks in group_cpus_evenly() on
    allocation
  lib/group_cpus: drop unneeded cpumask_empty() call in
    __group_cpus_evenly()
  cpumask: define cleanup function for cpumasks
  lib/group_cpus: rework group_cpus_evenly()
  lib/group_cpus: simplify group_cpus_evenly() for more

 include/linux/cpumask.h |  16 ++++++
 include/linux/find.h    |   3 ++
 lib/group_cpus.c        | 110 ++++++++++++++++------------------------
 3 files changed, 62 insertions(+), 67 deletions(-)

-- 
2.40.1


