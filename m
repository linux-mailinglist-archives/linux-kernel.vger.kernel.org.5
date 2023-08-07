Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6422A772833
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjHGOvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHGOvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:51:47 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7E810CA;
        Mon,  7 Aug 2023 07:51:46 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b95d5ee18dso70944291fa.1;
        Mon, 07 Aug 2023 07:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691419904; x=1692024704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BWcN6N6fBgl6H9b9j23x5jmZELL/mtr85e3NmUCW+tE=;
        b=CJQk3v5ecULIpzY/GD5uLeYieY961pwHb7RBn6dcUonOmVjBc7FYxAzSLHO1usELhF
         s7XdhK2rZIsqpOp1f/J96hZf1yEy8p1LKsSaD2xHHg7oVVRVJyeQcJ4DPUkIh4lzExfm
         BmZ+2E+Bq69PxPhaLTEsQwEJtOIHOT2aYCrL39PkSzkazTou27itvYdObzvxRqBbEpGV
         zcX9P7X6L9RWNqQVaS/mm86udnrr3jOdo1RI0Sag36exBZvqvE/PoCKMCY55DkIGUOQ3
         BrwSJ/DAimQBB+ZlE2XG3NYwhZnmzzOAqZBhQqXHZzoSVswfy5l5oq/MZMZP/yvPzbp4
         3Eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691419904; x=1692024704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWcN6N6fBgl6H9b9j23x5jmZELL/mtr85e3NmUCW+tE=;
        b=eVovo6Yfe6DuARKNJFTLXI57i6LQWACyItfHzXe7C2AVbhj1DvSHKG6OEflkh/Rvi9
         n19hIzlqjnAKeyfZ0d73osXD9sVu1o1GF5EfepQ1cJgnGimqN9ahSs3n3Pl7F3Q2JoGi
         qHR1t/NZCgo+DCTDPE3aVoynQ8OKSDPszI75GTf7uHsRDa9NV4KlUBRgGjhYOZHGjKTd
         ZGVUpBb3CWKtm6zozAw6HpGja9DIQjxZEEoB4svtB0EBnEh796dimngb6sawme70P1qg
         T9H6AC8VrKIRrbTDRff9iuVILXtW5ozAadyOww//RRbGJIBw4d43KLSMvTW02irteTKh
         89mg==
X-Gm-Message-State: AOJu0YzJSWe0fPpy2JCmBWSQuJLVhecEEoiGvpHfjAHjVW684H1poKSl
        8n1H2LJwhuak/SPwXcmSYEo=
X-Google-Smtp-Source: AGHT+IHVLB884FPH0sIpgclDHewQ+6SbD5k1rJqafOOLtqSa59/WPw/C6BwuZgr7yCj2TRsyKRFXKg==
X-Received: by 2002:a2e:90d4:0:b0:2b9:cd79:8f94 with SMTP id o20-20020a2e90d4000000b002b9cd798f94mr6669681ljg.39.1691419904201;
        Mon, 07 Aug 2023 07:51:44 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id z25-20020a170906271900b0099b4d86fbccsm5392785ejc.141.2023.08.07.07.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:51:43 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     x86@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: [PATCH 1/2] perf/x86/rapl: Stop doing cpu_relax in the cmpxchg loop
Date:   Mon,  7 Aug 2023 16:51:14 +0200
Message-ID: <20230807145134.3176-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the commit f5fe24ef17b5 ("lockref: stop doing cpu_relax
in the cmpxchg loop"):

"On the x86-64 architecture even a failing cmpxchg grants exclusive
access to the cacheline, making it preferable to retry the failed op
immediately instead of stalling with the pause instruction."

Based on the above observation, remove cpu_relax from the
cmpxchg loop of rapl_event_update.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc. "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/events/rapl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 52e6e7ed4f78..e8e26733e17b 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -184,10 +184,8 @@ static u64 rapl_event_update(struct perf_event *event)
 	rdmsrl(event->hw.event_base, new_raw_count);
 
 	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-			    new_raw_count) != prev_raw_count) {
-		cpu_relax();
+			    new_raw_count) != prev_raw_count)
 		goto again;
-	}
 
 	/*
 	 * Now we have the new raw value and have updated the prev
-- 
2.41.0

