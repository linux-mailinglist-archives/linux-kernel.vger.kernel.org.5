Return-Path: <linux-kernel+bounces-15703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D975082309C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 16:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 973911F2485B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 15:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F24F1B29C;
	Wed,  3 Jan 2024 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPD6KnZh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439CB1B291
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--brho.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbea2ea8363so521474276.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 07:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704295999; x=1704900799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=prIX6rQoerVclTCgugbanH1nWOv94uG287A9f9TVpY8=;
        b=BPD6KnZhxqBTB6YNqdD1QdQYNbMNWJyUgEwGwqtscMto1EbFaqEifnfTB6OUuP5oOa
         Q7lIio/vR4EtQvvhHi2cEZMzx1QrOhpp4p0AuUxk7EtXY4htg3eHmDBSV7Q/O3EbMW+0
         7RSPxPE76zn2ixX/O1A+qJ58xKx8V0pSjCcPx9Qj7BOOL/MlOey4R4hW8UD0HH8lskv0
         /OaoVoLevOYvAc0Z63LRyMvADdyL0aMBFsr9Qehaavh7QfHWoIH4FIUlhMcwiCWtp0A5
         YjatjCY72h4hLTMUdOhHUGMB4Vkyl1SozCrAgBGbJCpW8aLJhEtGU6HZG697zl8j2E/0
         L0Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704295999; x=1704900799;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prIX6rQoerVclTCgugbanH1nWOv94uG287A9f9TVpY8=;
        b=TH2450G6cHF8zmYq1dC4CxaVmGsAvimLSxpgI1LI86lFPC4La1UjQU4nTbwQT01zrm
         UoD16igk2j6G+7UjsltQMRVSx/abgMKZ7z9hWw85rM92sW2wIBWfLU45MdIKpcGBXeBj
         33g8mRD8TW/511zKx5EnjbqNqMeqo8EdmRrDbjzl+eY5h/xTou2dwJKbks8W7Ret2UX8
         MP8XjiUpZKzVeZ/V/V6v40LhUYk7ytBpDZAQXSV6xqwGkKR3kSq6E12Q1rYnHt4eU+mW
         T5jHnboe4I06e3/MMLimTUiNThXRR9ppi2jRbbNgY34HuSRKTpiJTgFibjqnJ7Pnos0i
         AbLQ==
X-Gm-Message-State: AOJu0Yzi+TLsn9ySv+BQNyNQdDpvubKbFlTd3Ea3bh6uBbKXyJEO6b0T
	c4nVGDIaDyOLWeZqL6GiDs5wwSyrqTapwWU=
X-Google-Smtp-Source: AGHT+IG1e7Z4HI/2vQuZZv9yDVtIJ9GWGAAuthkpzlCZCZVmJL1AsEveljPgS/4qqPQRUosPjJHnrknu
X-Received: from gnomeregan.cam.corp.google.com ([2620:15c:93:4:7e71:cfbd:2031:cc52])
 (user=brho job=sendgmr) by 2002:a05:6902:100e:b0:dbe:30cd:8fcb with SMTP id
 w14-20020a056902100e00b00dbe30cd8fcbmr324065ybt.0.1704295999290; Wed, 03 Jan
 2024 07:33:19 -0800 (PST)
Date: Wed,  3 Jan 2024 10:33:00 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240103153307.553838-1-brho@google.com>
Subject: [PATCH bpf-next 0/2] inline asm helpers to access array elements
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

Barret Rhoden (2):
  libbpf: add helpers for mmapping maps
  selftests/bpf: add inline assembly helpers to access array elements

 tools/bpf/bpftool/gen.c                       |  16 +-
 tools/lib/bpf/libbpf.c                        |  23 +++
 tools/lib/bpf/libbpf.h                        |   6 +
 tools/lib/bpf/libbpf.map                      |   4 +
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../bpf/prog_tests/test_array_elem.c          | 112 ++++++++++
 .../selftests/bpf/progs/array_elem_test.c     | 195 ++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  43 ++++
 8 files changed, 387 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_array_elem.c
 create mode 100644 tools/testing/selftests/bpf/progs/array_elem_test.c

-- 
2.43.0.472.g3155946c3a-goog


