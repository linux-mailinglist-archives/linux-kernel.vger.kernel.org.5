Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6EC7B559D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237828AbjJBOmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237678AbjJBOl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:41:58 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12010AD;
        Mon,  2 Oct 2023 07:41:54 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-77421a47db6so858659485a.0;
        Mon, 02 Oct 2023 07:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696257713; x=1696862513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pNPJ9c/jvNp3qd70S+Vv9KklzayXCzlCTVKOVVL5zFI=;
        b=a2RsC9qHPMHJJ5MjsOoAWX4JXLDaxd014FKXVW+iPORtMmGSWw7Um0UDm+8s2PI6h3
         WNbDm9SQV8b6ajMe3+AoiP4O2xrSX49dAS8rEgTMMzQaqk6Q0/AF1ltYAFK/80kLU4/y
         RdnPcmYnuKwIiOY/F6Yc8fybazsCiFryarVsKfpHslp6FY/epWmRvlLOScxJ7LLw9Vks
         bwDszsOyNYSFX/JEmtGoYhMPTzH7Ri7B6hOiTyL2Qe+Chjw/L/S/GdZ5BjIuyFx+1UdC
         hK8HJXr8sdglGnQcANbzzqFYTcKuVbrE37avmULbvOgMybA733I5nehTJ95sQlycRiSR
         Xoyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696257713; x=1696862513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pNPJ9c/jvNp3qd70S+Vv9KklzayXCzlCTVKOVVL5zFI=;
        b=P5jWcexb1PNrltqLpO2nQT2LHgAfp1r/pO/YNksz4xseiMFwISxELX2VXtR3iBSVuq
         T1Q80wqOqQ+ki23HlpJ2OFn8yIyTjtPIHRNa6FbanIdfQ0O8vNS8/wwcxgbio0+SpRGM
         1sOQpvgZEfepv/q3SALaFh9Qp0i6ozMTIBSdxdwzaSCXAVoBe/F27Ky/G+vetU3KfbDM
         1jf9Igih/hoMiUzxitbwkPbKnTAU8j1rE/TfP9HydW05VeFYt+PDRQuO0T+B9Jugge5L
         ZOt38qz6OuF0oWiqxrzvlW7OVdR4WEvEG5Prz5NnTtQLtGSU2PwFO1AWEUHny3iqmxd+
         oFdA==
X-Gm-Message-State: AOJu0YwaQQVoLGJe69qijHQqB9KyHeCIqc8aIv8qULmm93j1UBNsCxlF
        VYP0eGoQaJhikL5/T0oyoURi/2tKmpXdVw==
X-Google-Smtp-Source: AGHT+IHT82VovXN/cxP6Jtm5WJyHTY9Fj8tKXdpVWUAwECBEMXtJcNGCjRifXQV83weytsfvHfIqMg==
X-Received: by 2002:a05:620a:15b1:b0:775:7e16:2cdf with SMTP id f17-20020a05620a15b100b007757e162cdfmr10460875qkk.39.1696257713043;
        Mon, 02 Oct 2023 07:41:53 -0700 (PDT)
Received: from US-B32Y0T3.na.ds.lexmark.com (ip98-166-230-239.hr.hr.cox.net. [98.166.230.239])
        by smtp.gmail.com with ESMTPSA id os36-20020a05620a812400b0076ceb5eb309sm9021461qkn.74.2023.10.02.07.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:41:52 -0700 (PDT)
From:   Nicholas Lowell <nicholas.lowell@gmail.com>
X-Google-Original-From: Nicholas Lowell <Nicholas.Lowell@gmail.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Nicholas Lowell <nlowell@lexmark.com>
Subject: [PATCH v2] trace: tracing_event_filter: fast path when no subsystem filters
Date:   Mon,  2 Oct 2023 10:41:48 -0400
Message-Id: <20231002144149.1325-1-Nicholas.Lowell@gmail.com>
X-Mailer: git-send-email 2.39.1.windows.1
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

From: Nicholas Lowell <nlowell@lexmark.com>

If there are no filters in the event subsystem, then there's no
reason to continue and hit the potentially time consuming
tracepoint_synchronize_unregister function.  This should give
a speed up for initial disabling/configuring

Signed-off-by: Nicholas Lowell <nlowell@lexmark.com>
---

Notes:
    v2: switch from needless counting to boolean
        WARN_ON_ONCE if no preds but filter exists

 kernel/trace/trace_events_filter.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 33264e510d16..baa108f88032 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1317,22 +1317,29 @@ void free_event_filter(struct event_filter *filter)
 	__free_filter(filter);
 }
 
-static inline void __remove_filter(struct trace_event_file *file)
+static inline bool __remove_filter(struct trace_event_file *file)
 {
 	filter_disable(file);
+	if (!file->filter)
+		return false;
+
 	remove_filter_string(file->filter);
+	return true;
 }
 
-static void filter_free_subsystem_preds(struct trace_subsystem_dir *dir,
+static bool filter_free_subsystem_preds(struct trace_subsystem_dir *dir,
 					struct trace_array *tr)
 {
 	struct trace_event_file *file;
+	bool do_sync = false;
 
 	list_for_each_entry(file, &tr->events, list) {
 		if (file->system != dir)
 			continue;
-		__remove_filter(file);
+		if (__remove_filter(file))
+			do_sync = true;
 	}
+	return do_sync;
 }
 
 static inline void __free_subsystem_filter(struct trace_event_file *file)
@@ -2411,7 +2418,12 @@ int apply_subsystem_event_filter(struct trace_subsystem_dir *dir,
 	}
 
 	if (!strcmp(strstrip(filter_string), "0")) {
-		filter_free_subsystem_preds(dir, tr);
+		/* If nothing was freed, we do not need to sync */
+		if (!filter_free_subsystem_preds(dir, tr)) {
+			if(!(WARN_ON_ONCE(system->filter)))
+				goto out_unlock;
+		}
+
 		remove_filter_string(system->filter);
 		filter = system->filter;
 		system->filter = NULL;
-- 
2.25.1

