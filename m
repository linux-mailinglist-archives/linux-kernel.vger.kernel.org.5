Return-Path: <linux-kernel+bounces-50720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BAA3847D47
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB18128BB51
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6303812C7EF;
	Fri,  2 Feb 2024 23:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AyrvHKJj"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA9212D779
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706917277; cv=none; b=q8i2BwUoUuwPQdVM4q+GQygAFM+SPdcudjqE/70YYDPd/Dg5nRKaqLSwf91Xmfu/5G2rSkHYfupsIHc/0woUyx8qbUG6ViNVUaU3BW4/cGB6rz4cPgGaXsNdGxhWH+fsNzfKJw0b+UpxeEIIWsQiPFaz03bZdxlaMtBLclZPCLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706917277; c=relaxed/simple;
	bh=R7HDLt+WXCKcw0UAraBcZnWD54QthkXyaQu13uOf35M=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JH+fbjxihsSQWLtf2SaB2TxVc/f1s4Ezf/vcNnocDD+ojPf/md3AXWjAl4ThngaKwdLOyuiNDy7GvS2+P/wGvsCr8bNF4pagm48Dm7vHaJ1SPe/afZrVkiRXwCeQWE7yPrAMZfz5+ee4Pn220g3/srRwHV9pgvWxsJL9yBbtRnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AyrvHKJj; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b9f4a513so4065541276.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 15:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706917274; x=1707522074; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wOc7/ot5clrlqkd/XVVApb41eylij+dgoGLfSlWPOp0=;
        b=AyrvHKJjjXcpTnTw4Q1Oh72rOi5vJrbZ3NSKSgFRcmHrdQ9urAxqzaDeeAWfqmw1CL
         V2OIprdiY9MJ0htwTWHjbjukLdw7GmjOkyqarwZWfqn2/8Nov6Ocp/QbJOAyaHPZqEhv
         hziwunHjYpud1MfPnxCijqL4At/8TCLcXP3ITG/sHjJf5dLMZBDCWVnSsVuJpt8WizXl
         wZDeqrqXusMSV10naS2Ovb/WYhlAqQRr2Xtbkc0txIShOu29QlZQm42MK7Ezu4CBW1H2
         OxpzDQzCpQwQLEealrpbXlNFI9Pleu4GOdpHUI3AnJSzmnPwCCL/ker674WkFBkQGxwz
         OW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706917274; x=1707522074;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOc7/ot5clrlqkd/XVVApb41eylij+dgoGLfSlWPOp0=;
        b=s0CHHmfWSUx/vLlekIpxwyw2nm3WhU1a0InuFyvicCZnvj0QCfxNoJ9Zmz/6HTFEbS
         q8cBTXxMK+uigQp6fohlY7xUVvDETdQ0OBGy9ZZIOmHdrY8fYnMh4jArljW0Xb36mVgA
         BbT/5ck7YKsHhEo8F6FzZrjk2XL/yvvnoQt2I7EbyNjX6m7O6BjNPCLGSNP2seTB7UpF
         s5PPNANemFd2qD3nHld0OM47BKaR9M/XOTJjlhlwWNjJBPlyq5Unx7m8wTBVxh9vm9sh
         XAyMAe9Ki4vnjqN0wkcWw83QmLQJ997BSIp8qXKtqxsNt4AHAaeSVddjWfAReX/wrwK/
         hKYg==
X-Gm-Message-State: AOJu0Yw1veCrCusjYhRQDA8GBA2mm66YBIHSRPXT+KcAEJz5IB9+CZSx
	uJnxMWkqqMV6hLMQOpGCvyhzsA/79kBOxlcpbsFZ8qS+K0vXsdRssycsuSnMyWaLux4UWGOKf/S
	R1hQlDA==
X-Google-Smtp-Source: AGHT+IHFL6+6WJT+TDjsN0v4AycgXqtEdFuE4PFoyenBnNnNjcCA2pFf3NUeukXxzibAja4cMAtIanSVNF3E
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:7732:d863:503:f53d])
 (user=irogers job=sendgmr) by 2002:a05:6902:1b08:b0:dc2:398d:a671 with SMTP
 id eh8-20020a0569021b0800b00dc2398da671mr1024554ybb.10.1706917274174; Fri, 02
 Feb 2024 15:41:14 -0800 (PST)
Date: Fri,  2 Feb 2024 15:40:51 -0800
In-Reply-To: <20240202234057.2085863-1-irogers@google.com>
Message-Id: <20240202234057.2085863-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202234057.2085863-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v3 2/8] libperf cpumap: Ensure empty cpumap is NULL from alloc
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Darren Hart <dvhart@infradead.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, 
	"=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>, Kan Liang <kan.liang@linux.intel.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, Atish Patra <atishp@rivosinc.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, Changbin Du <changbin.du@huawei.com>, 
	Sandipan Das <sandipan.das@amd.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Paran Lee <p4ranlee@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Potential corner cases could cause a cpumap to be allocated with size
0, but an empty cpumap should be represented as NULL. Add a path in
perf_cpu_map__alloc to ensure this.

Suggested-by: James Clark <james.clark@arm.com>
Closes: https://lore.kernel.org/lkml/2cd09e7c-eb88-6726-6169-647dcd0a8101@arm.com/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/perf/cpumap.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index ba49552952c5..cae799ad44e1 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -18,9 +18,13 @@ void perf_cpu_map__set_nr(struct perf_cpu_map *map, int nr_cpus)
 
 struct perf_cpu_map *perf_cpu_map__alloc(int nr_cpus)
 {
-	RC_STRUCT(perf_cpu_map) *cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
+	RC_STRUCT(perf_cpu_map) *cpus;
 	struct perf_cpu_map *result;
 
+	if (nr_cpus == 0)
+		return NULL;
+
+	cpus = malloc(sizeof(*cpus) + sizeof(struct perf_cpu) * nr_cpus);
 	if (ADD_RC_CHK(result, cpus)) {
 		cpus->nr = nr_cpus;
 		refcount_set(&cpus->refcnt, 1);
-- 
2.43.0.594.gd9cf4e227d-goog


