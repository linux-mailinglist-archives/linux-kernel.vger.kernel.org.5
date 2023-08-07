Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36676772834
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjHGOvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjHGOvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:51:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC3E10CB;
        Mon,  7 Aug 2023 07:51:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bcc0adab4so674393666b.2;
        Mon, 07 Aug 2023 07:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691419905; x=1692024705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9cm8cTsTs1NRIm6EldQMncAKGPYPbnoceUIC+MvOm3Y=;
        b=PzuhEtCYHKoDyf4HVfut1KrGorVjsc98I4C9d1tFK3yVp0tsrF1nz+UGpjD3vAeg/V
         Pi1bszrOHYit9YKoXgHaTEyJE8ziLUTOOx9eTnsLbayS9/70OnOdnlkBoIzbeaDVva+z
         yIpNS637mrpMsvs2ooJf+/FYUaw/jXngR9OIOGN9p85JJlLEqYvYkUxXBq5bKAuzKHcY
         9DL9VzSAzHibqJNzizZ9Qlt4Hh/3LLwrLUVKHzy6AsSWVtJgBoP0LnoTdDAHtVdibZMI
         2Yc4A9fyggRJF31xMtyunWH7r2lFN3Moms6wW18pgPd0RcQZgeF9SEy2BPfvwo3yD8w2
         XP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691419905; x=1692024705;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9cm8cTsTs1NRIm6EldQMncAKGPYPbnoceUIC+MvOm3Y=;
        b=dPvVklGXzCDUXOMECW23NZufMjEQ7iv6kjytqi316ctwK6xW/g4U2bV2/QYTWwKG6U
         4u6xohCVgq7t+Z2kXR98aEZc4A5e1kYU/H7UBn1MrJh6CJ+WHSiPVD32VyFIZjxPxQA4
         TWHQEef1656QCE8x+ObvB5Amo64SuZ+DeSBGnBauuYzg+wgcj4AGeraVp0fcHDPzk5VM
         ORYmZHOVelbP+MhvcDoaqK5PHez6ApTB0uVgf8qjmTaAqn6ROnEG60P0wssHqo9a1d4j
         hEIpOaYxUfY3D6laB7Xis4O2NWhqAn6A07GsUnQoy5VcnaEuTdQXJhxvj3vh3oE3ysaR
         7j1Q==
X-Gm-Message-State: AOJu0Yw99RTBieRvJBdbnWDFNm008dKDXAOAy/Ct2dons/A6vbe9bt2F
        vYSRrQbYxBvpwkgw0qCVv+A=
X-Google-Smtp-Source: AGHT+IG6MJ7UuwJYoOrJvawdee4jeFawmhku07p+D7zaOsoWPSSuahRcR6yHonvzPhr+4SuLjyvM8A==
X-Received: by 2002:a17:906:76d7:b0:99c:ced6:842f with SMTP id q23-20020a17090676d700b0099cced6842fmr4081373ejn.10.1691419905351;
        Mon, 07 Aug 2023 07:51:45 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id z25-20020a170906271900b0099b4d86fbccsm5392785ejc.141.2023.08.07.07.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:51:44 -0700 (PDT)
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
Subject: [PATCH 2/2] perf/x86/rapl: Use local64_try_cmpxchg in rapl_event_update
Date:   Mon,  7 Aug 2023 16:51:15 +0200
Message-ID: <20230807145134.3176-2-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807145134.3176-1-ubizjak@gmail.com>
References: <20230807145134.3176-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use local64_try_cmpxchg instead of local64_cmpxchg (*ptr, old, new) == old.
x86 CMPXCHG instruction returns success in ZF flag, so this change saves a
compare after cmpxchg (and related move instruction in front of cmpxchg).

Also, try_cmpxchg implicitly assigns old *ptr value to "old" when cmpxchg
fails. There is no need to re-read the value in the loop.

No functional change intended.

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
 arch/x86/events/rapl.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index e8e26733e17b..7c2376dae79d 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -179,13 +179,11 @@ static u64 rapl_event_update(struct perf_event *event)
 	s64 delta, sdelta;
 	int shift = RAPL_CNTR_WIDTH;
 
-again:
 	prev_raw_count = local64_read(&hwc->prev_count);
-	rdmsrl(event->hw.event_base, new_raw_count);
-
-	if (local64_cmpxchg(&hwc->prev_count, prev_raw_count,
-			    new_raw_count) != prev_raw_count)
-		goto again;
+	do {
+		rdmsrl(event->hw.event_base, new_raw_count);
+	} while (!local64_try_cmpxchg(&hwc->prev_count,
+				      &prev_raw_count, new_raw_count));
 
 	/*
 	 * Now we have the new raw value and have updated the prev
-- 
2.41.0

