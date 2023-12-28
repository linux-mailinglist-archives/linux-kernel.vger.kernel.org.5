Return-Path: <linux-kernel+bounces-12841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC51D81FB18
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 21:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00D401C20309
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 20:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F2B1078A;
	Thu, 28 Dec 2023 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrjO3ByX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F1101EF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dbd715ed145so4722819276.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 12:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703794178; x=1704398978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HCA08uxTqri6ps1NfAaGYxLslyha0kBz21ww+RrkO4c=;
        b=JrjO3ByXft+3EzF8C/Wyc5HbpnK+Gx7yRsziTTWnCGgomRr0fIrW4x6MFAi3E39vYV
         YYNWMcz7HlwRndDMxigZs5yed514WS+1uHRgUghcKn2O8DoFBYAD9HP7bebn9HUUBnP3
         8WsG1TsWNKjgaqCCro9+lPsCAkc7qaOkUQS2jf2FF/urowO31Cuq6Cv6+8WuAUrLygAx
         8ahdN8Qj7lV8ck+wxm8CVtBBMNZ1O3a4dlnip/8MaofmWn9v5wXnZ0YdCHc8sHTiFDsq
         jF7lvBRFOxsWiDKay268rLeCu1j7+l5g7Q7MB7sG8edtOeDU+xb2dXOgaAGMUr/RvNkA
         xO6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703794178; x=1704398978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCA08uxTqri6ps1NfAaGYxLslyha0kBz21ww+RrkO4c=;
        b=L052TXVmrC+oBrqHl0du52C6pp2suXMWckG7hR9CTGMFYR7WOJIWUQlg9FqI89AC/q
         uTLFgOxl810x2WguZcNOkTo4zjegxzbCEljbDISc6WVd4OYf0bN7bywjht9Kt/kmCCCN
         /Z7CSaRWP+x12O18NKqqrPl7cm0uQ1rLIa2ZOgvDc55o8dlfJxWEmX4Ev4ttbsoSALjO
         L7U5kuaOVjwnvcmjrs0MsT/bMeX2pjnNxYJeThj24H4o4HeCfzeIDEsBvU6X8/GO7arr
         sYr5uhggnvAXA0KntYF+nYWh7SaMWCmGJUQqCUdzs3xGdmRCEAbCoDF/8tbuoEU/fvpE
         WvWw==
X-Gm-Message-State: AOJu0YwZRYgMTn/mj8scEwv6iDZ4ilR7u0a70IQ8CeypZUkjl+1brmnZ
	kV8hh7+BRte4ecGu7pEUOz0=
X-Google-Smtp-Source: AGHT+IFNJTQsZgUG3dQqdLtvOysbjBM1LJClQyIVvn/Si1NEIARZjqY4eerGrJi0bDGUvvjQxljIhA==
X-Received: by 2002:a5b:345:0:b0:dbe:4a03:b983 with SMTP id q5-20020a5b0345000000b00dbe4a03b983mr702774ybp.9.1703794178512;
        Thu, 28 Dec 2023 12:09:38 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:967c:a333:ae09:3f60])
        by smtp.gmail.com with ESMTPSA id j3-20020a2597c3000000b00d9caecd5c86sm6209616ybo.62.2023.12.28.12.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Dec 2023 12:09:38 -0800 (PST)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ming Lei <ming.lei@redhat.com>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 0/9] lib/group_cpus: rework grp_spread_init_one() and make it O(1)
Date: Thu, 28 Dec 2023 12:09:27 -0800
Message-Id: <20231228200936.2475595-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andrew, Ming,

Now that we've got a couple more weeks, let's try to merge this series in
the upcoming merge window? In addition to addressing the v3 comments, in
v4 I added a few more patches that simplify the code for more by using
cleanup machinery.

Thanks,
	Yury
--

grp_spread_init_one() implementation is sub-optimal because it
traverses bitmaps from the beginning, instead of picking from the
previous iteration.

Fix it and use find_bit API where appropriate. While here, optimize
cpumasks allocation and drop unneeded cpumask_empty() call.

---
v1: https://lore.kernel.org/all/ZW5MI3rKQueLM0Bz@yury-ThinkPad/T/
v2: https://lore.kernel.org/lkml/ZXKNVRu3AfvjaFhK@fedora/T/
v3: https://lore.kernel.org/all/ZYnD4Bp8R9oIz19s@yury-ThinkPad/T/
v4:
 - drop patch v3 #7 and add a comment in patch #4;
 - patch #2: fix cpus_per_grp decrement order;
 - patch #3: add NAK fro Ming Lei;
 - add patches #7-9 that simplify the code for more.

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

 include/linux/cpumask.h |  14 ++++++
 include/linux/find.h    |   3 ++
 lib/group_cpus.c        | 104 +++++++++++++++++-----------------------
 3 files changed, 62 insertions(+), 59 deletions(-)

-- 
2.40.1


