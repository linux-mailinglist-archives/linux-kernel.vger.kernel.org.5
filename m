Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEC0580097C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 12:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378497AbjLALPQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 06:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378475AbjLALPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 06:15:14 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064501A4;
        Fri,  1 Dec 2023 03:15:21 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d011cdf562so3305575ad.2;
        Fri, 01 Dec 2023 03:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701429320; x=1702034120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+Bt8YwxlkrbF6xYlJjMrgbtHMtsoK7PtFo9B4rwju8=;
        b=fWP3wYAsANEEcrUgTBLcR6KEDrr5IF73pzKD1q/2WfI/VwG9uRBfh1N3hqUgZJUd+0
         RPjEAeSXlCFnXobS6MyyfWW4GuLhfoN9bDyKo9HJcw5Oj85HDQ/BtGdWhzE5cTgYQHyV
         R56WUvNvhP8OcMrS47Ds57D6zPg9Y2dXI9awCWPMkvuiwS7Rmz0LKZ3wOWVttk0+FJsT
         Enw8OMwZqIEpcvbrS5cDVL9UarJkq7pY45fv+3ig/6VFjqIFF3Bs3jynRFiFhBdJ6/rx
         WEcezMFLgOWsW8VhMVhwbpIDJoLeOMgO5H/BV1F1fE7FXgJOBeNIniPTLqIfaZU98D/a
         SQTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701429320; x=1702034120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+Bt8YwxlkrbF6xYlJjMrgbtHMtsoK7PtFo9B4rwju8=;
        b=EAe16/QmCOmBVSCf3TPYjksCqHtMfXti7s7A7/Yahl2VlSWXpEXf2OMstYXYQhAH0b
         4CyiGgcPN/K0PYku8c1dOlz2hQcN2GCHjOEywvHsmKysXoSkHsNvWU996hTdyN9WKBtf
         pNaokUj/a9fwtsKpY87F1h6X7oU7kOIFRHyDZ4UMuPb5A/mcEDTLGlF1cBC11GZlryAy
         /i5K1mo6cO8vdN2ZCkg5bpqwEl1WrDE0zc7YjXj35/2t+aUw2tjn/X5gMeRfmfbKm6c7
         fjlxWldK8OY29ngLcCAvjP/SbbPaFP/WHasqc/2oQYfpscL3tji3AxB5Wbeltd75hK5o
         Izeg==
X-Gm-Message-State: AOJu0YzTf4smflGY+DteSIZpO9aWULawJkGs9eGEIu32E8oxqfxx0d++
        wk3bYJv3emH49h6AtOGJjFc=
X-Google-Smtp-Source: AGHT+IFozwwnSipT44F4qd5L0qO6LAXnTSWgBEylrIUtqovHjHEW9s+dqRd3sT20vXl7+/amK8clZg==
X-Received: by 2002:a17:902:be12:b0:1c3:1f0c:fb82 with SMTP id r18-20020a170902be1200b001c31f0cfb82mr24208587pls.41.1701429320309;
        Fri, 01 Dec 2023 03:15:20 -0800 (PST)
Received: from localhost.localdomain ([43.132.98.47])
        by smtp.gmail.com with ESMTPSA id g11-20020a170902934b00b001cf8c062610sm3067292plp.127.2023.12.01.03.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 03:15:20 -0800 (PST)
From:   Like Xu <like.xu.linux@gmail.com>
X-Google-Original-From: Like Xu <likexu@tencent.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf header: Set proper symbol name for vdso when build-id event found
Date:   Fri,  1 Dec 2023 19:15:06 +0800
Message-ID: <20231201111506.37155-1-likexu@tencent.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Like Xu <likexu@tencent.com>

If using perf-record to sample a cpu-cycles:P event on a hypervisor process
when '--kcore' is not enabled, user may find some surprise in perf-report:

# perf report -i perf.data -v:
# Overhead Command   Shared Object            	Symbol
    99.71%  vcpu0    arch/x86/kvm/kvm-intel.ko  0xffffffffa10d1e30 B [k] 0x0000000000034ed0

build id event received for vmlinux: d12116149f511f7dbd0b21c45d38d3d2ec09b87f [20]
build id event received for kvm-intel.ko: a8fc0213abbafd97b10ce58ce84bec8519f9abce [20]
build id event received for [vdso]: 4d56e381df8d2c051f6bc1ef69c0118c59d5c49f [20]

# perf report:
# Overhead  Command  Shared Object     Symbol
# ........  .......  ................  .......................................
#
    99.71%  vcpu0    [kvm_intel]       [k] 0x0000000000034ed0
     0.10%  vcpu0    [kernel.vmlinux]  [k] __lock_acquire.isra.29

Users may be curious as to how 0x34ed0 was generated and wondered if this
RIP came from the guest application but perf-script-D does not point to any
samples of this address.

Based on perf/tool implementation, this is actually an offset pointing to
the vdso object (in this case it is the assembly __vmx_vcpu_run defined
in arch/x86/kvm/vmx/vmenter.S). The pattern is not reproduced on perf-tool
of some distributions, and git-bisect quickly identified the possible root
cause, which leds to this straightforward fix and after this change:

# perf report -i perf.data -v:
# Overhead Command   Shared Object            	Symbol
    99.71%  vcpu0    arch/x86/kvm/kvm-intel.ko  0x34ed0            B [k] __vmx_vcpu_run

# perf report:
# Overhead  Command  Shared Object     Symbol
# ........  .......  ................  .......................................
#
    99.71%  vcpu0    [kvm_intel]       [k] __vmx_vcpu_run

The fix also gets commit 1deec1bd96cc ("perf header: Set proper module name
when build-id event found") lit again.

Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Fixes: b2fe96a350de ("perf tools: Fix module symbol processing")
Signed-off-by: Like Xu <likexu@tencent.com>
---
 tools/perf/util/header.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e86b9439ffee..a33d589511ff 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2305,8 +2305,8 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
 
 			if (!kmod_path__parse_name(&m, filename) && m.kmod)
 				dso__set_module_info(dso, &m, machine);
-
-			dso->kernel = dso_space;
+			else
+				dso->kernel = dso_space;
 			free(m.name);
 		}
 
-- 
2.43.0

