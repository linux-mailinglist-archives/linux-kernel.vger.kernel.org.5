Return-Path: <linux-kernel+bounces-133158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E297899FC1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AE4CB23A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91F16F822;
	Fri,  5 Apr 2024 14:30:47 +0000 (UTC)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1978C16F280;
	Fri,  5 Apr 2024 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327446; cv=none; b=ElazAqEycV8QjvJXf6LHQ8EH6ErlOb2es67Osmx7cA278HZxyUEVwPYbQIJKHfXxilxbOlVEd6De0s5ll9M4OX7gm0or9FjGj36h5dzpVgAf3MXPEYfX6xQkw4w6Y6tEFNh+SeTYxmmDbuVuXnxHUr7HDtVWHd9QS7MlAIgNt34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327446; c=relaxed/simple;
	bh=/HpxcC2P7pDjkG9fbL+8qyNpDwFallJn6TXrKQbssl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r04iv8MdorcCG5LRYJRn/OTn6sy9xySlBp/OG8RE/Lu5XU7G8pMidwZCOJNx0Fba6w/QD+PQrqNAUKAvrNaOQs78RPhdxk9X87FM8KxAUDNw1pZL2QJRxTV/xBkdhSA55VZXbG11eZi8Uj5Q6lvFgvB+jxauQaBIEWG9q+ZNCGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3688effa61bso8354865ab.3;
        Fri, 05 Apr 2024 07:30:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327444; x=1712932244;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JyksYXTvaJcNxcCTpYAv8//t2n0EXQT4+q5rxe3bHUQ=;
        b=Q4a5YllDCQgGjDXx4pOMz/ufSRyC0Ee2wlVFWNEfKepteOqquGvYvl7Wet3HMj5npH
         FUamy1XrqNTEqRMFBymTefbuUJKPz+U1rHVZq7XvCAxGPR4AN22Jq0K0e9u/yMGDghrG
         hzNyTF6wtAaVcv2+bnll3gY14f8mzIjE51DkozWa2xjj3ig+Ad5O81a2idQIIJcaWMTv
         TCCRBKct3+kaTdc1MM7ZdnjxYsXYnvf237tncDodZ9drw5FB52QJRq2mcH+enqiCQ5aS
         eDtlsYTv9uuElYGt32inDL8NVYI2ZrphMeVBGooELk/PQ32xsljgs29zXpcnqQy1Ayvi
         NlFw==
X-Forwarded-Encrypted: i=1; AJvYcCWPH3/coh2uMJyqD8sEK+sTGl3Lqwg2PqTkAxt0cbto5Km0o8bthEQZBlqf0Ta4ijWpC6UOrz9Z6yObTEtqEALYvtn3T5WyIih1lcVj
X-Gm-Message-State: AOJu0Yxwt2SEFbqQ9oFhA5KeOTZn+BIl8MsQkHG5Kku1Ai52PA/cnlc5
	BME8evgAIMu33zTgwQCsVSv1eOpwkVXpkeBvhHNbsiLn3sqa87rlzftCScwi1bo=
X-Google-Smtp-Source: AGHT+IF1IxyVeBbfk/3ZBFWa25p/tGHzQCdZvBJJ9lA4/ntj3oEi5MwAfQ3gtOcqotxbLIbkEKhxvQ==
X-Received: by 2002:a05:6e02:20e7:b0:36a:686:b3bf with SMTP id q7-20020a056e0220e700b0036a0686b3bfmr1818656ilv.17.1712327443703;
        Fri, 05 Apr 2024 07:30:43 -0700 (PDT)
Received: from localhost (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id ck17-20020a0566383f1100b0047f14932f9dsm605780jab.54.2024.04.05.07.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 07:30:43 -0700 (PDT)
From: David Vernet <void@manifault.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/2] bpf: Allow invoking kfuncs from BPF_PROG_TYPE_SYSCALL progs
Date: Fri,  5 Apr 2024 09:30:39 -0500
Message-ID: <20240405143041.632519-1-void@manifault.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, a set of core BPF kfuncs (e.g. bpf_task_*, bpf_cgroup_*,
bpf_cpumask_*, etc) cannot be invoked from BPF_PROG_TYPE_SYSCALL
programs. The whitelist approach taken for enabling kfuncs makes sense:
it not safe to call these kfuncs from every program type. For example,
it may not be safe to call bpf_task_acquire() in an fentry to
free_task().

BPF_PROG_TYPE_SYSCALL, on the other hand, is a perfectly safe program
type from which to invoke these kfuncs, as it's a very controlled
environment, and we should never be able to run into any of the typical
problems such as recursive invoations, acquiring references on freeing
kptrs, etc. Being able to invoke these kfuncs would be useful, as
BPF_PROG_TYPE_SYSCALL can be invoked with BPF_PROG_RUN, and would
therefore enable user space programs to synchronously call into BPF to
manipulate these kptrs.

---

v1: https://lore.kernel.org/all/20240404010308.334604-1-void@manifault.com/
v1 -> v2:

- Create new verifier_kfunc_prog_types testcase meant to specifically
  validate calling core kfuncs from various program types. Remove the
  macros and testcases that had been added to the task, cgrp, and
  cpumask kfunc testcases (Andrii and Yonghong)

David Vernet (2):
  bpf: Allow invoking kfuncs from BPF_PROG_TYPE_SYSCALL progs
  selftests/bpf: Verify calling core kfuncs from BPF_PROG_TYPE_SYCALL

 kernel/bpf/cpumask.c                          |   1 +
 kernel/bpf/helpers.c                          |   1 +
 .../prog_tests/verifier_kfunc_prog_types.c    |  11 ++
 .../selftests/bpf/progs/cgrp_kfunc_common.h   |   2 +-
 .../selftests/bpf/progs/task_kfunc_common.h   |   2 +-
 .../bpf/progs/verifier_kfunc_prog_types.c     | 119 ++++++++++++++++++
 6 files changed, 134 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/verifier_kfunc_prog_types.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_prog_types.c

-- 
2.44.0


