Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83EF7D7981
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 02:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjJZAcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 20:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjJZAc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 20:32:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DA1183
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:24 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9c4ae201e0so331691276.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 17:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698280343; x=1698885143; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgEoz0HJkgI3Htj/k2k/xpjtT3B+sjoHWzaw+oBkReo=;
        b=GeZwC0qulzJRua3wr/OzXTDoAZRbp8AIFRhJmxsOG5t1f6f6MskqRPetZ8HvL046tb
         se052U1uMJgjQtkkxUZSeZTEFqT3wEHgsBj2baCmyYek3ClWR13gUFE+sGGsmt9H53jE
         tk3M32gvWGaQ0QcxKT4mX95492QSCyyIeyISBkHyUvfKhnle+TUtVyeWKlYaUZwe6/bp
         yRB+l4wDiA5ZLmIh5zmniUh616bm1PJ+bMqUf4gRYYVWqvocxnxuzWRfUQ4jIs19XahW
         74Qv2uidAg1iq7lCcaqrOrz6NYiNbJN9AIpnzEtKua5J7xv1x7QtXGyWLshWdx2pGRUr
         9h4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698280343; x=1698885143;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FgEoz0HJkgI3Htj/k2k/xpjtT3B+sjoHWzaw+oBkReo=;
        b=e46Y427lsfSYTcRL8hyhevFjXwfWu5sjGuH9OgiEpxEkD8Fm/h8dVkg0LyV7bsPK85
         S6pgUnGHIk33WqdbQERi6ZWN2l+S/DiA6Ta2rXQ+mwDFLTGlbe9xsKQvSQbOQyeOadBd
         ccwM4Z69BVixIOK6S9k1TBKK81IKJUCLLFylIUMzGJGR26AObhS8MorWEmqE69pDpBlm
         vboSBxE8EjrjxTSvqbQpYROm8Au3+hpBfc/nrqGSbtQWbQK6OZLs9/rg7HG/Rs+VQyqY
         mucOQwnsCMjKoHlaedO90+vAwG13xsjUtnXw3kjxS4TFZmOphcud9Ywxtpc9qJmpGg0I
         JKCQ==
X-Gm-Message-State: AOJu0YzTf8Zs+hh12etcaAVTSN0fC9faXLgRVKItuc0gVkf3c/ogr+a5
        P7Jwz1CsNOZ8viimJ9+DINynq5bT75Q4
X-Google-Smtp-Source: AGHT+IGX4t3mc7gYcHTxGkFn0KiWK7fXhEzT6fN1z0upW+CidFVN3Uaf7zPfQNxwIrFqQ1j/qiaecaMU7VYy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:19cd:8b4f:c0f5:e803])
 (user=irogers job=sendgmr) by 2002:a25:800f:0:b0:da0:6216:7990 with SMTP id
 m15-20020a25800f000000b00da062167990mr44686ybk.3.1698280343193; Wed, 25 Oct
 2023 17:32:23 -0700 (PDT)
Date:   Wed, 25 Oct 2023 17:31:44 -0700
In-Reply-To: <20231026003149.3287633-1-irogers@google.com>
Message-Id: <20231026003149.3287633-4-irogers@google.com>
Mime-Version: 1.0
References: <20231026003149.3287633-1-irogers@google.com>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Subject: [PATCH v1 4/9] perf vendor events intel: Add typo fix for ivybridge FP
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a missed space.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json b=
/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
index 87c958213c7a..89c6d47cc077 100644
--- a/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
+++ b/tools/perf/pmu-events/arch/x86/ivybridge/floating-point.json
@@ -73,7 +73,7 @@
         "UMask": "0x20"
     },
     {
-        "BriefDescription": "Number of FP Computational Uops Executed this=
 cycle. The number of FADD, FSUB, FCOM, FMULs, integer MULsand IMULs, FDIVs=
, FPREMs, FSQRTS, integer DIVs, and IDIVs. This event does not distinguish =
an FADD used in the middle of a transcendental flow from a s",
+        "BriefDescription": "Number of FP Computational Uops Executed this=
 cycle. The number of FADD, FSUB, FCOM, FMULs, integer MULs and IMULs, FDIV=
s, FPREMs, FSQRTS, integer DIVs, and IDIVs. This event does not distinguish=
 an FADD used in the middle of a transcendental flow from a s",
         "EventCode": "0x10",
         "EventName": "FP_COMP_OPS_EXE.X87",
         "PublicDescription": "Counts number of X87 uops executed.",
--=20
2.42.0.758.gaed0368e0e-goog

