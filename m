Return-Path: <linux-kernel+bounces-15890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B845A82350F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 19:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35B1B28674A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 18:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE521CA87;
	Wed,  3 Jan 2024 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dW2HxG/x"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7936E1CA89
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 18:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brho.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5e9074bb7c5so142214577b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 10:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704308045; x=1704912845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FJN4MS0ig8KJTW6JTQgcLpiilQPej5rcL1B+jlYVGD0=;
        b=dW2HxG/xXAFDFP5gFgKWGeKLL4wzZyxje6foWlfrlol4BYv8U/uGhcHdcEm5bsxrIS
         EpioM4FHgFb/FbNvZp+Ft3soBsonFh6JTFBfwRgOBgBI//Q/67c4QH+qxfHawcih5QwA
         TLJogi/CzXsge77hWbzO49J9skP9brQBZZKkkDMrqjw+SUYVJPmoqEB5jN4xSvy2rzo4
         Mn3csH70FfSaTmkyyoZRCBn8Hk6UM4cH9MuEfPKMxkO5bXSXbZiYT9v5HU1JV1sc1VyJ
         jsL/qyWdQvqXukQpwlyImBcI+f8o+PMg7vMK9SLdC1XiZoxILYSHp1vLEcFHshMAfOGA
         JyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704308045; x=1704912845;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJN4MS0ig8KJTW6JTQgcLpiilQPej5rcL1B+jlYVGD0=;
        b=fWu+RfQDG9xaV8afv4wf90MdlX2VBuAi53ie/k1ZwLWyNqYQx58RvszSogh42VXjEP
         e0/s5BXtsO9sqnnAXhYcNCba8CGBiFhJho56qycF6Geh6yja17V3VfbA5630RyjwH43t
         npYEiDNkzEKON9NuXDYg2l53t9Gg2Djdo7J/JxMj1FHWwrtb/wI9zlvhlv+ZMiLm+xb2
         WV3I8WGquJCP55500K+6bfaoyNr0iz6nqj2974pCeOA0GRC+ADDtphU2mUQ2pP/QW+Vu
         29i/h7SG69ttRec8Z/YS5GCcLpe2qIEVAWyQRcKlyGPVX/cbl2nZup5ov37KIC0aRXVW
         Cp8w==
X-Gm-Message-State: AOJu0Yw04dNpA0x/ITOb1E8t4C4yTOHh0B5l6lekoMdglnVv1aipUzs1
	vPD4bvCuEAInDTTiJGjVDh5ihH5+BAIhP5c=
X-Google-Smtp-Source: AGHT+IESUciFVAW5XfzHlaRZ+F6yADVLeUwKAEMRPVlpvBpoJTjsg6s70TZ20hXvGKcCLnb9NuxAgWb3
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:93:4:7e71:cfbd:2031:cc52])
 (user=brho job=sendgmr) by 2002:a05:6902:2402:b0:dbe:4cdc:abfa with SMTP id
 dr2-20020a056902240200b00dbe4cdcabfamr416007ybb.13.1704308045361; Wed, 03 Jan
 2024 10:54:05 -0800 (PST)
Date: Wed,  3 Jan 2024 13:53:57 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240103185403.610641-1-brho@google.com>
Subject: [PATCH v2 bpf-next 0/2] inline asm helpers to access array elements
From: Barret Rhoden <brho@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Cc: mattbobrowski@google.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry for the delay on this.  Discussed in [1].  It's a helper for
proving to the verifier that your access in the array is valid.  Happy
to change names or whatever.  =)

Also added a libbpf helper function for mmapping an mmappable map.

We've been using both in our ghost-BPF schedulers[2].

[1] https://lore.kernel.org/bpf/b4cb3423-b18d-8fad-7355-d8aa66ccfe4c@google.com/T/
[2] https://github.com/google/ghost-userspace/blob/main/third_party/bpf/common.bpf.h#L218

v1: https://lore.kernel.org/bpf/20240103153307.553838-1-brho@google.com/
- use libbpf's internal bpf_map_mmap_sz()
- remove debugging cruft

Barret Rhoden (2):
  libbpf: add helpers for mmapping maps
  selftests/bpf: add inline assembly helpers to access array elements

 tools/bpf/bpftool/gen.c                       |  16 +-
 tools/lib/bpf/libbpf.c                        |  18 ++
 tools/lib/bpf/libbpf.h                        |   6 +
 tools/lib/bpf/libbpf.map                      |   4 +
 .../bpf/prog_tests/test_array_elem.c          | 112 ++++++++++
 .../selftests/bpf/progs/array_elem_test.c     | 195 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  43 ++++
 7 files changed, 381 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_array_elem.c
 create mode 100644 tools/testing/selftests/bpf/progs/array_elem_test.c

-- 
2.43.0.472.g3155946c3a-goog


