Return-Path: <linux-kernel+bounces-149055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 269938A8B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9BFA1F24494
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0409BE55;
	Wed, 17 Apr 2024 18:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PL5j5XyX"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00230849C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378749; cv=none; b=RI0QUbQx8caZIQ8EVZOn0AWDpR/xc2FEjEjHk4Q7zFXDZwCTnMlaiir83FQKEz37D5p0bv3bgVvmDLySgb1ucEB9h+WOGHg63lc/1Pnyq55XIXU1Cs2S+rx9/E2En/yWd0x0yijxxB39VAqo3LziEwsnjCLVWqgrCew4DWLqxmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378749; c=relaxed/simple;
	bh=36hXQuEvO/yn4vEmJGlAB6y3mAmxuqgfg5ZGP25OSKY=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=eQGJ5UBZczwuXKiP9a7wNF3c+SegNZu21inibsORed5TQk25FoV9rH6HfqZNuod9/i+xK/PUnAMvA+avi+z5qeeLufs8lueFcAVPT3v+y7aJo8WkruL2tGGmcWUpQm92xgfV1Q+ukHT5RdLKBgicpGlUnuNuObfb5+A4ViMQ7eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PL5j5XyX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso94406276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713378747; x=1713983547; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=axvyU+8QUv8kTyKybxhFapUIJ4L0+ijLXSh2frDTobY=;
        b=PL5j5XyXFKlPqmL+yZIXmnGBiZesm6YGkMItEwjpm2wTgNQgWnuNrsxhDko2QI6CXE
         9FESNgU9AxsvCvTPEP42UhL599BuI119svdMSS1i2asU3FtFC02Gi7wV/xUgw+nHJRk5
         dr/UwHA1RINtMgGVNtn6pxQh/Tt4OUhmHDteoBPhbC8gzQcWoavW5i9kSq8oxD4u0dW4
         1zjWurK2zOPsU4jtTFIIW6mAE3pT1HU4XMhmPPnPClJETseZxUdhOVjUp0tWlB+wlJem
         0xumU6YO8WgT6t7sIvGsvfOP7Imk+3SDTOHuft57sjjpuzskqBWI9nIB3qqyhdVAO6LF
         eBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713378747; x=1713983547;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axvyU+8QUv8kTyKybxhFapUIJ4L0+ijLXSh2frDTobY=;
        b=Lugs1i06/y+kLWZpBlG+RSFtuf/BEQ0QiNHVaWxJ0pPkOII2MgYgDBmIv6P8mY370D
         UNHS4Bs+0T7EXyIBRFNCe+888YNisKB6qolbV/ixQUTEPbCGlPJbOqfulNJ4L59i5Roe
         LBa//EgVFEWnIfxeZQj0/1MNFnbANs3rUeN4ureBi0T26cVRt4RaTLCHVVkz9kRxqn3p
         g2PhdWZQbkQXoqQyXNlEmO8jwaOYZLkjRtWay8Vgf660Z1Zarap7qpcbP6g23jRWSyY5
         cxr0deGbWbtk1/M3CSHBOfA6Wds8jR1+eVDEaUL6fy6gZ2PwWLC7SKqVx+F+KwLU2YxV
         th6w==
X-Forwarded-Encrypted: i=1; AJvYcCWSR1TEd2963LEkIfRRRYT2cp7MeXIhZRU+zepdoR5z4YyhSv5ac5Rp8GP9ObbNCWQhm9HqY8eop5rdBmD0VqnNK7jhN2p2iDm+5Re2
X-Gm-Message-State: AOJu0YwNB9/GdWntQKFOntg4hf2gSNGyQMfzlvUvxiQAzqBbM6xN4oWs
	Cw3OD0Wt4hb/DfxLLhiIj5Kh8EpUu0srhmeGyzWWQiaxgHgv4/WFYblbABkvQKpQeKhDjZ8qzwl
	gbscisA==
X-Google-Smtp-Source: AGHT+IFBWokfc9EOakTcRvWLn9uzuvhdYjyYgTXbyLc60iS9DX7y4vkAhB/A617M4Bu0xdVWZR0/ykNlQIWu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:21e2:a91b:3cf5:c57b])
 (user=irogers job=sendgmr) by 2002:a05:6902:2b09:b0:de1:2220:862b with SMTP
 id fi9-20020a0569022b0900b00de12220862bmr38875ybb.12.1713378747053; Wed, 17
 Apr 2024 11:32:27 -0700 (PDT)
Date: Wed, 17 Apr 2024 11:32:19 -0700
Message-Id: <20240417183219.1208493-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1] perf test: Avoid hard coded metrics in stat std output test
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hard coded metric names fail on ARM testing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat+std_output.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests/shell/stat+std_output.sh
index cbf2894b2c84..845f83213855 100755
--- a/tools/perf/tests/shell/stat+std_output.sh
+++ b/tools/perf/tests/shell/stat+std_output.sh
@@ -13,7 +13,7 @@ stat_output=$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
 
 event_name=(cpu-clock task-clock context-switches cpu-migrations page-faults stalled-cycles-frontend stalled-cycles-backend cycles instructions branches branch-misses)
 event_metric=("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "frontend cycles idle" "backend cycles idle" "GHz" "insn per cycle" "/sec" "of all branches")
-skip_metric=("stalled cycles per insn" "tma_" "retiring" "frontend_bound" "bad_speculation" "backend_bound")
+skip_metric=($(perf list --raw Default 2> /dev/null))
 
 cleanup() {
   rm -f "${stat_output}"
-- 
2.44.0.683.g7961c838ac-goog


