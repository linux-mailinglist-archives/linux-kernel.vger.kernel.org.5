Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4624B7FC138
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345417AbjK1Ryq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:54:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbjK1Ryn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:54:43 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65700C1;
        Tue, 28 Nov 2023 09:54:49 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cb4d366248so4904337b3a.0;
        Tue, 28 Nov 2023 09:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701194089; x=1701798889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=UFccXEXz7IM6tMF3bP+Pq5FuCNUT9piA8FwAmlVMJeo=;
        b=jHU0LgaFecYLrQpdNh2/xvNWQI6zZAzH+/C0L/UGDJGTVFkEtSZ4zWaVLlXIbI6P7F
         zFyXKONPFv6Yj0gEOfOGv0KCDEetR7MSzdDuqlKg8Ue7bSE1zMU0nekVrJHSmjhmfAcw
         BfUJHmG27lSGex+MbAisCw/m/Fx0N8HvZeFALAu3XpFqBjii4532IsD6drHZX/dMkA+I
         lxBHVJHaDeUwRkBqMtd1gvNEnIcnff/jjQrvstS3uYZ69UjHD4LiDBXaO2wVJV2sg4ia
         o4pOuW1IKkc9tTRGo3eVFgc2tFGrwM/8Jg8A5ZhuyxuWLY0XRHe81jowq1S1MQtRW5pv
         WXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701194089; x=1701798889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFccXEXz7IM6tMF3bP+Pq5FuCNUT9piA8FwAmlVMJeo=;
        b=Ae70X63FhSoYwKgT/LgtjlTSPsUkmO/+AhWFPIGb7z32W/VB383DSZtv23l7b+FCq5
         /WA9e7x+br1MvwteTAFeExV8AafyykcjYcblZ2fGzjdur9tMSo9Xu9VSysXUYxiZD1Me
         fR8wjSEKkYDqpXbsx0EF1O4fEKEyWyKP/9f1avy+m3pR2eRwdLaR/p0O+DSAnjfvPnQb
         BTYrf0ADOm2yOTwkciKN4b6obiwDWqrnePseBGeoImNdAxO2DrN3OAVKdJmrOiKPDWLX
         9VxbSa482Xp8UXpgIE289FZVtpQJfIt6ZL8SE1sIqqP77rj1RAG9FILk8JGu7lwf0AAF
         cCew==
X-Gm-Message-State: AOJu0YyNH1jjAeVqNbq147551+WXWZAAdYQJGzNZsbqwUDcfB1sw2MCM
        3qffv1g1JCqQKSt6wovRWg8=
X-Google-Smtp-Source: AGHT+IG1fyLz3hjrMvqqjDVaeVSTsB32SJb9KJPNzE7V3BkwlCpjFFK0rpQTAp+z+26bWksoXKJkPA==
X-Received: by 2002:a05:6a00:1d25:b0:6b3:aded:7e9a with SMTP id a37-20020a056a001d2500b006b3aded7e9amr15712535pfx.27.1701194088596;
        Tue, 28 Nov 2023 09:54:48 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:146f:6347:3bb4:8cf4])
        by smtp.gmail.com with ESMTPSA id y2-20020aa78042000000b006cbbc07a1c0sm9224721pfm.156.2023.11.28.09.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 09:54:48 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCHSET 0/8] perf annotate: Make annotation_options global (v1)
Date:   Tue, 28 Nov 2023 09:54:33 -0800
Message-ID: <20231128175441.721579-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It used to have annotation_options for each command separately (for
example, perf report, annotate, and top), but we can make it global as
they never used together (with different settings).  This would save
some memory for each symbol when annotation is enabled.

This code is available at 'perf/annotate-option-v1' branch in

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks,
Namhyung


Namhyung Kim (8):
  perf annotate: Introduce global annotation_options
  perf report: Convert to the global annotation_options
  perf top: Convert to the global annotation_options
  perf annotate: Use global annotation_options
  perf ui/browser/annotate: Use global annotation_options
  perf annotate: Ensure init/exit for global options
  perf annotate: Remove remaining usages of local annotation options
  perf annotate: Get rid of local annotation options

 tools/perf/builtin-annotate.c     |  43 +++++----
 tools/perf/builtin-report.c       |  37 ++++----
 tools/perf/builtin-top.c          |  45 +++++-----
 tools/perf/ui/browsers/annotate.c |  85 ++++++++----------
 tools/perf/ui/browsers/hists.c    |  34 +++----
 tools/perf/ui/browsers/hists.h    |   2 -
 tools/perf/util/annotate.c        | 142 +++++++++++++++---------------
 tools/perf/util/annotate.h        |  38 ++++----
 tools/perf/util/block-info.c      |   6 +-
 tools/perf/util/block-info.h      |   3 +-
 tools/perf/util/hist.h            |  25 ++----
 tools/perf/util/top.h             |   1 -
 12 files changed, 206 insertions(+), 255 deletions(-)


base-commit: 757489991f7c08603395b85037a981c31719c92c
-- 
2.43.0.rc1.413.gea7ed67945-goog

