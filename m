Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48D17780B7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236226AbjHJStd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbjHJSt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:49:27 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B4C2D48
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:49:12 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5896bdb0b18so23079647b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691693352; x=1692298152;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAsvNbJV0xewLpRF082FT5wNDwT03/+fiaT2qH1TeCM=;
        b=LTICTcE8hNlmMkRTMYp+FBqxbDFL9VxGqxqFwVsETwRzlpfMVOHp4IwneSAJSBQkLW
         MR9vE7Rjc9bd3DeFHvMQP8MwP5RYD6a5WxQ3dvG5GDrq+CGWGrooh8LRg0e42SkY6AzY
         6VEb/wJdzpqLgkk7j+sSRWYsx/L83/0hyDnfCC3mfVYVYkiWjp5yPKYVIcDaoxKO4sYN
         dglRXksLGO1i0EsXt+LFA2SUAFs0jvlz62kG4mmRiThp2m1ODYM0xMJnyFu+1XmNkv5n
         smJbqbdBAdyl8ANQVK3LF4L8WuTZxBBNYLJN95pwCuwjNk36KloINZCo8EMe0Pt9vGEe
         Fg0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691693352; x=1692298152;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tAsvNbJV0xewLpRF082FT5wNDwT03/+fiaT2qH1TeCM=;
        b=W4vm0CLlG0AjAbO2RmCdk3Qn8QCN9x/c6XYHcOrjxznaaH83J1nuIDONAow5g4uAyQ
         VrPXY4Cj2bL5lPenzwQCOPey436vmg/vOwP/ZSajC6biJ7TJ0gGxkklBpbBmh3tsflXf
         47QPs20SX9yM0dBrm+Pt+U9di3t4seygWOOvWCk2dYIlhdZWmDvokxCnq+ufcei7SCmY
         dK5+4nJRSLr8FE2/xW8I9U4DRScJW9ewU4blPuNQbFpzZ3uXy855Gpnkol61S7wOCXic
         zhGyauqN1E+hY6AGLKuzfIqb/ku/A8zovnu9SY1agCSVqKx2AFCSVbXP2N1ST4WbEFDU
         Dv1A==
X-Gm-Message-State: AOJu0YzetuSJ682F6+5r3BSEHG8AMIZBCA79jIzpx7d72K0hjdpFZsbO
        l2GgRBtH0Tzbnd+ZyoH4pRN/nA+myJDT
X-Google-Smtp-Source: AGHT+IHBdD4d2FEkNC8Rl2S0IuPwZraSrCdQGQrFkVvxGTI5IiXMSHQJ/2/nwp5UpXIZ9kZNRHwcozJrils6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:797f:302e:992f:97f2])
 (user=irogers job=sendgmr) by 2002:a81:7855:0:b0:586:e91a:46c2 with SMTP id
 t82-20020a817855000000b00586e91a46c2mr62264ywc.4.1691693351912; Thu, 10 Aug
 2023 11:49:11 -0700 (PDT)
Date:   Thu, 10 Aug 2023 11:48:53 -0700
In-Reply-To: <20230810184853.2860737-1-irogers@google.com>
Message-Id: <20230810184853.2860737-5-irogers@google.com>
Mime-Version: 1.0
References: <20230810184853.2860737-1-irogers@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Subject: [PATCH v1 4/4] perf trace: Tidy comments
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Fangrui Song <maskray@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andi Kleen <ak@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Carsten Haitzler <carsten.haitzler@arm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        James Clark <james.clark@arm.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, llvm@lists.linux.dev,
        Wang Nan <wangnan0@huawei.com>,
        Wang ShaoBo <bobo.shaobowang@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        He Kuang <hekuang@huawei.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now tools/perf/examples/bpf/augmented_syscalls.c is
tools/perf/util/bpf_skel/augmented_syscalls.bpf.c and not enabled as a
BPF event, tidy the comments to reflect this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/trace/beauty/beauty.h                  | 15 +++++++--------
 .../util/bpf_skel/augmented_raw_syscalls.bpf.c    |  8 --------
 2 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 3d12bf0f6d07..788e8f6bd90e 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -67,15 +67,14 @@ extern struct strarray strarray__socket_level;
 /**
  * augmented_arg: extra payload for syscall pointer arguments
  
- * If perf_sample->raw_size is more than what a syscall sys_enter_FOO puts,
- * then its the arguments contents, so that we can show more than just a
+ * If perf_sample->raw_size is more than what a syscall sys_enter_FOO puts, then
+ * its the arguments contents, so that we can show more than just a
  * pointer. This will be done initially with eBPF, the start of that is at the
- * tools/perf/examples/bpf/augmented_syscalls.c example for the openat, but
- * will eventually be done automagically caching the running kernel tracefs
- * events data into an eBPF C script, that then gets compiled and its .o file
- * cached for subsequent use. For char pointers like the ones for 'open' like
- * syscalls its easy, for the rest we should use DWARF or better, BTF, much
- * more compact.
+ * tools/perf/util/bpf_skel/augmented_syscalls.bpf.c that will eventually be
+ * done automagically caching the running kernel tracefs events data into an
+ * eBPF C script, that then gets compiled and its .o file cached for subsequent
+ * use. For char pointers like the ones for 'open' like syscalls its easy, for
+ * the rest we should use DWARF or better, BTF, much more compact.
  *
  * @size: 8 if all we need is an integer, otherwise all of the augmented arg.
  * @int_arg: will be used for integer like pointer contents, like 'accept's 'upeer_addrlen'
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 70478b9460ee..0586c4118656 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -2,16 +2,8 @@
 /*
  * Augment the raw_syscalls tracepoints with the contents of the pointer arguments.
  *
- * Test it with:
- *
- * perf trace -e tools/perf/examples/bpf/augmented_raw_syscalls.c cat /etc/passwd > /dev/null
- *
  * This exactly matches what is marshalled into the raw_syscall:sys_enter
  * payload expected by the 'perf trace' beautifiers.
- *
- * For now it just uses the existing tracepoint augmentation code in 'perf
- * trace', in the next csets we'll hook up these with the sys_enter/sys_exit
- * code that will combine entry/exit in a strace like way.
  */
 
 #include <linux/bpf.h>
-- 
2.41.0.640.ga95def55d0-goog

