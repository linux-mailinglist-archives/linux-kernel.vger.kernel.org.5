Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906FD7C6388
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347050AbjJLDzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347085AbjJLDxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:53:46 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADBFE8;
        Wed, 11 Oct 2023 20:52:00 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-584a761b301so415664a12.3;
        Wed, 11 Oct 2023 20:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082719; x=1697687519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpkTPPnVT3dzSfLyQxD7kyX6iWqu+XT6fM/HnJbBp0M=;
        b=iRapRysNegmLAW1kiMHDQ4vuiqCWLikuCH0jTI1/dsgffAgGr3rXkHUV4VlrFdpag+
         JDdTYuM6LINFSSyGxqUNJ5LBfM4kpPOMiIbclYN+T7Jz9NO3pPZNCDOYypR7ZVy/YJ/k
         +DOtJvofpNpUY/lxVowM7blG9+ED2OwkUs18DWbPtS9pO0QTvfCDmT3j2y32nQ3jpN7H
         76522aVSORHXN4IKb3vyuxgTGXo9rA1hYmX1jX9t8q7Hb2X8/uhaawOZlcVj+2OzfxMV
         +x5l7APhZEJHQ3HV6f8MUrgBiJfDEAcRYoL1q+mbcTU+5AN+1c9o6ojnbBhMhs7rcVQz
         8TXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082719; x=1697687519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qpkTPPnVT3dzSfLyQxD7kyX6iWqu+XT6fM/HnJbBp0M=;
        b=ly6KmVDfC9RYV6JtT78xmxnpwuvpQsDXpBU9T86grKWhOvB6UWD4Ku6fDrqIhsbbuE
         qX++g7BmyJ7UXokY7JwYUGR5RbFOX3zoaHu/kjGiY9+jLdkVRwf/pI1izFwLVvP9rHoo
         CHhsjtWD9+h1jpidjl5AZ/1AsNr0yWfShHE18HHwfKtfdohMrBC05Gmk7IccpqkbwCWS
         HdIHxxddIJ507EqNnvIj8zF8BC+iY+OE73ovwAlE8caUalQgAgZqbFyNiu/s8zn+5SOv
         QDLAg2Qh8WQUbfK0an4+r56/4RyaalZZQDr00dASJQ54hqmVa9z6cjhhsANzJhu98Idv
         KYMQ==
X-Gm-Message-State: AOJu0YzirwGlzgFTO5dgdsRlFscz6OV+jM+8ryHU4tMgarqoBxdiDNTq
        z6R2KJV5qHhtQpp7sf6gQFk=
X-Google-Smtp-Source: AGHT+IHRPDCm4a1A17Vsd5OLn71LjwNXJRyjzHslksOAB3XteLeIMZ230y1oM0Ecxkq4Xj7r6Arg2A==
X-Received: by 2002:a05:6a20:6a0c:b0:13a:59b1:c884 with SMTP id p12-20020a056a206a0c00b0013a59b1c884mr25517428pzk.40.1697082719385;
        Wed, 11 Oct 2023 20:51:59 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:59 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 34/48] perf dwarf-aux: Add die_collect_vars()
Date:   Wed, 11 Oct 2023 20:50:57 -0700
Message-ID: <20231012035111.676789-35-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The die_collect_vars() is to find all variable information in the scope
including function parameters.  The struct die_var_type is to save the
type of the variable with the location (reg and offset) as well as where
it's defined in the code (addr).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 60 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h | 17 +++++++++++
 2 files changed, 77 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 093d7e82b333..16e63d8caf83 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1545,6 +1545,66 @@ int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset)
 	return -1;
 }
 
+static int __die_collect_vars_cb(Dwarf_Die *die_mem, void *arg)
+{
+	struct die_var_type **var_types = arg;
+	Dwarf_Die type_die;
+	int tag = dwarf_tag(die_mem);
+	Dwarf_Attribute attr;
+	Dwarf_Addr base, start, end;
+	Dwarf_Op *ops;
+	size_t nops;
+	struct die_var_type *vt;
+
+	if (tag != DW_TAG_variable && tag != DW_TAG_formal_parameter)
+		return DIE_FIND_CB_SIBLING;
+
+	if (dwarf_attr(die_mem, DW_AT_location, &attr) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	/*
+	 * Only collect the first location as it can reconstruct the
+	 * remaining state by following the instructions.
+	 * start = 0 means it covers the whole range.
+	 */
+	if (dwarf_getlocations(&attr, 0, &base, &start, &end, &ops, &nops) <= 0)
+		return DIE_FIND_CB_SIBLING;
+
+	if (die_get_real_type(die_mem, &type_die) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	vt = malloc(sizeof(*vt));
+	if (vt == NULL)
+		return DIE_FIND_CB_END;
+
+	vt->die_off = dwarf_dieoffset(&type_die);
+	vt->addr = start;
+	vt->reg = reg_from_dwarf_op(ops);
+	vt->offset = offset_from_dwarf_op(ops);
+	vt->next = *var_types;
+	*var_types = vt;
+
+	return DIE_FIND_CB_SIBLING;
+}
+
+/**
+ * die_collect_vars - Save all variables and parameters
+ * @sc_die: a scope DIE
+ * @var_types: a pointer to save the resulting list
+ *
+ * Save all variables and parameters in the @sc_die and save them to @var_types.
+ * The @var_types is a singly-linked list containing type and location info.
+ * Actual type can be retrieved using dwarf_offdie() with 'die_off' later.
+ *
+ * Callers should free @var_types.
+ */
+void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types)
+{
+	Dwarf_Die die_mem;
+
+	die_find_child(sc_die, __die_collect_vars_cb, (void *)var_types, &die_mem);
+}
+
 #endif
 
 /*
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index dc7e98678216..d0ef41738abd 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -135,6 +135,15 @@ void die_skip_prologue(Dwarf_Die *sp_die, Dwarf_Die *cu_die,
 /* Get the list of including scopes */
 int die_get_scopes(Dwarf_Die *cu_die, Dwarf_Addr pc, Dwarf_Die **scopes);
 
+/* Variable type information */
+struct die_var_type {
+	struct die_var_type *next;
+	u64 die_off;
+	u64 addr;
+	int reg;
+	int offset;
+};
+
 #ifdef HAVE_DWARF_GETLOCATIONS_SUPPORT
 
 /* Get byte offset range of given variable DIE */
@@ -153,6 +162,9 @@ Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
 /* Get the frame base information from CFA */
 int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset);
 
+/* Save all variables and parameters in this scope */
+void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types);
+
 #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
@@ -187,6 +199,11 @@ static inline int die_get_cfa(Dwarf *dwarf __maybe_unused, u64 pc __maybe_unused
 	return -1;
 }
 
+static inline void die_collect_vars(Dwarf_Die *sc_die __maybe_unused,
+				    struct die_var_type **var_types __maybe_unused)
+{
+}
+
 #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 #endif /* _DWARF_AUX_H */
-- 
2.42.0.655.g421f12c284-goog

