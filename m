Return-Path: <linux-kernel+bounces-64795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 458508542EE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:38:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8547DB28E57
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 06:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08E8011CAE;
	Wed, 14 Feb 2024 06:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aKC2p1yW"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF21B11729
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 06:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707892643; cv=none; b=eK9s9BaptwrQese/M4UxySBRiPkZ1Xg412DT9W8lyNYdn4XenggxCmv0v/+RT+hmsxlRdvuqomTn2itHPe5rsyy8dfL74MrHzy2GAxrp5Y9WEAEok3imp5sfebPzKIiFnZcTZkpjTjV10yY39Ibzlc2pTl8pIXPSz/iBPh+j5X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707892643; c=relaxed/simple;
	bh=G/2siGEslfhIe2PbP6r2MxvFbe+8RJMIG2S2/Tjz5Sk=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=LXx1TAkJIFG7WTzhvkxVyDedDx3USrmEpg4W/TK5X0ssIcGWMJOhWHBeGb6w2fkEu+PV4iM1MT8u5uVH05yENvUKWc4V6o4rbTQH+E7mjosCc9RMk2PMKLE8yGSknGl+t4Vd1dQRJno4pHlzNa3qF+B2fDj/R9cxWNYjwW0GBig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aKC2p1yW; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6079cf3541bso19270477b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 22:37:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707892641; x=1708497441; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SjusGx6p43Fl1gAtWsqPYtqEBcBHhyA1NbBeHZWXXBk=;
        b=aKC2p1yW+k+f204eXYynN0DphVe+dqAkLQgK3xLaZ6jmJk+jt1IS3vh7gEDIi8QM0K
         tpS4zebZHOjfqUlZglRnc4FuUKJTF37LacDuO7Wf+nXddVip3XOdJWVdfy7HUXRjFyj6
         f7SSiSEMPDkEQMTt80tRSFXkVwGY6dU9HLvH9WIgmbMnTPpCnVgkurEac7gWFR75ZxzG
         GHaSgyvZl79Ucno+D2W7HhpzrIMCf4lFiVmrc5Zubofm6iBJ5bEFSd1woVA+29jKKgqa
         tUEMPNC1d67NHBHb0kEaQ1NlhZnxyTMWTjlL3Y8RINxrpyclw0e3tFD/zguCkxF9l0XT
         ZMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707892641; x=1708497441;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SjusGx6p43Fl1gAtWsqPYtqEBcBHhyA1NbBeHZWXXBk=;
        b=tR/Wtlq94drdt4po0yhSNadoKst/Xo3huyORKOEdhqkNtaDIfa2ElMLYICe92XV7C0
         0llCNpG7064N6+p967UF/uwWOpn+2a64OknC5NqP/lVSZeRMk38GmlwkWKJD5LK9RO64
         TRUudF/etUpO/V2PlD8RdjT2VVLHjSGBGU9MLj7H43TYGfQ0pH3Y1EfbEyrQgsH3PtoM
         gdQzi3+JhpJeaJmKqEjc8LW3vOb4tF5Idxj3+xtTn967QcoWxuYiAKOJOe3cgWTPb/Ow
         Yd/W5+iasZFVo7aFhMYIj+H3pwkFzZLevt4dp2gAkdMJylJS89l2CbuAVekU951N//f5
         vy5g==
X-Forwarded-Encrypted: i=1; AJvYcCUYUobSLGhn8o736E0dOE78reeMNfqRwWQNggdecWjf66RrIB2v62Law4BWwsyHa+g80NVVX1nX2J4Xfbt6dAy4u30TFoGc2NTkzuPs
X-Gm-Message-State: AOJu0YyNZ1GCBScW1ZtcqKkAjO+M/WNQQioX3ct4i9NMIqLNFlJQjiLy
	PFROl0JdRe7S7/tcRSbMMJYkLf7r8K3+474g/Kr4Op98ZquVEnJMjHibryg7aPBUZ6kBdTN2E3O
	ATrQCyw==
X-Google-Smtp-Source: AGHT+IEsG2eb9QduCybkOjAV4YmUuRlwxnqusb42GZd2TCszkl/0jHkS+z91H7/eyjXsZBnlWHjgqJVyyKgH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6d92:85eb:9adc:66dd])
 (user=irogers job=sendgmr) by 2002:a81:a105:0:b0:603:ea10:c37c with SMTP id
 y5-20020a81a105000000b00603ea10c37cmr360558ywg.7.1707892640759; Tue, 13 Feb
 2024 22:37:20 -0800 (PST)
Date: Tue, 13 Feb 2024 22:37:02 -0800
Message-Id: <20240214063708.972376-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v1 0/6] Thread memory improvements and fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The next 6 patches from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
now the initial maps fixes have landed:
https://lore.kernel.org/all/20240210031746.4057262-1-irogers@google.com/

Separate out and reimplement threads to use a hashmap for lower memory
consumption and faster look up. The fixes a regression in memory usage
where reference count checking switched to using non-invasive tree
nodes.  Reduce threads default size by 32 times and improve locking
discipline. Also, fix regressions where tids had become unordered to
make `perf report --tasks` and `perf trace --summary` output easier to
read.

Ian Rogers (6):
  perf report: Sort child tasks by tid
  perf trace: Ignore thread hashing in summary
  perf machine: Move fprintf to for_each loop and a callback
  perf threads: Move threads to its own files
  perf threads: Switch from rbtree to hashmap
  perf threads: Reduce table size from 256 to 8

 tools/perf/builtin-report.c           | 203 ++++++++-------
 tools/perf/builtin-trace.c            |  41 +--
 tools/perf/util/Build                 |   1 +
 tools/perf/util/bpf_lock_contention.c |   8 +-
 tools/perf/util/machine.c             | 344 +++++++-------------------
 tools/perf/util/machine.h             |  30 +--
 tools/perf/util/rb_resort.h           |   5 -
 tools/perf/util/thread.c              |   2 +-
 tools/perf/util/thread.h              |   6 -
 tools/perf/util/threads.c             | 186 ++++++++++++++
 tools/perf/util/threads.h             |  35 +++
 11 files changed, 464 insertions(+), 397 deletions(-)
 create mode 100644 tools/perf/util/threads.c
 create mode 100644 tools/perf/util/threads.h

-- 
2.43.0.687.g38aa6559b0-goog


