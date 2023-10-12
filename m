Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94D97C6384
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377412AbjJLDyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377468AbjJLDxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:53:15 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB82D7F;
        Wed, 11 Oct 2023 20:51:52 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c9b95943beso4894025ad.1;
        Wed, 11 Oct 2023 20:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082711; x=1697687511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdbuy60PoHQjVoDHAgnvJ5vo16j0MWSlUix9kXJv1e0=;
        b=HSwlYPSD6ohCFcYWRM4CoUg3Mdw5nNjSNWYRQwqCOUnqHC2Xo/dsJ2d2xwZC1VCo6X
         Z/jnnNxHP+xqAqLVh7FW7v8JIC3bYK13Hgco7P1XrS+0F07n7vLDnaYHHgEDFaBLtNES
         /PzwvVOiYewhUSB++f1fefXAhQT3R+2dhaUXnx1bmJNmNuD44bgGALRHxj2OYhixHOAA
         O1hFKLq7v1qfgDtmg7Zb0wqJhr7sUalKaUOt687ZuARTdmYIWOe6go3CxT/t8WH+rNDS
         OUSaal4buDL0B6Q3oIyVHTe2h5X606Jb+lq1PRmXE9NiuSr9ynuAXM7WyirwuPSJnRS2
         lOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082711; x=1697687511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bdbuy60PoHQjVoDHAgnvJ5vo16j0MWSlUix9kXJv1e0=;
        b=UDoBb3X9nKPa2kjdbYvb3mAGxSPd4l7Aibaf9EYX6nNGpkEodCoA9ux7i9XogdLyKq
         ZLLbi53hPqKjjsw7E0pJUW0GOO8A/PV+l7xqAer09OSS78caaIIoegCBwGiOyCN9x0Hf
         Ygn2xZa599z6ySRsmpVpNBThqniaSTYeyuHO/YgL09bhUJ6aCTF188JxcaOz9QdMfK9p
         0QTLCJOv+ZPr0DLrFxv2TrKzMVwFl5WRN9oHncD59rA4BrjDEtK9uxHe7iZ+np4Cuyh/
         LmgrbXSbnIS5gpWr9dMVpQXydZOnalsQ22NyBYwVh4EtfFrUXXV0y77foUE57Z7pcjWR
         D2ig==
X-Gm-Message-State: AOJu0YxPVyQS4I9Z5c3XfIVd3zZHLVGkJem7bmK1mOkQE/fja9h6k+nR
        E8CiN+18mAdirOdQmWuuanQ=
X-Google-Smtp-Source: AGHT+IHf87NQ/5wr3XxYc83YP6tXdjB/pWdLpx11l2tqBcD5VauBFA8S86Dk6aZYc9EzTQ0FpHpkSA==
X-Received: by 2002:a17:903:48d:b0:1c9:dff1:6ddd with SMTP id jj13-20020a170903048d00b001c9dff16dddmr588990plb.35.1697082711592;
        Wed, 11 Oct 2023 20:51:51 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:51:51 -0700 (PDT)
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
Subject: [PATCH 28/48] perf dwarf-aux: Add die_find_variable_by_addr()
Date:   Wed, 11 Oct 2023 20:50:51 -0700
Message-ID: <20231012035111.676789-29-namhyung@kernel.org>
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

The die_find_variable_by_addr() is to find a variables in the given DIE
using given (PC-relative) address.  Global variables will have a
location expression with DW_OP_addr which has an address so can simply
compare it with the address.

  <1><143a7>: Abbrev Number: 2 (DW_TAG_variable)
      <143a8>   DW_AT_name        : loops_per_jiffy
      <143ac>   DW_AT_type        : <0x1cca>
      <143b0>   DW_AT_external    : 1
      <143b0>   DW_AT_decl_file   : 193
      <143b1>   DW_AT_decl_line   : 213
      <143b2>   DW_AT_location    : 9 byte block: 3 b0 46 41 82 ff ff ff ff
                                     (DW_OP_addr: ffffffff824146b0)

Note that the type-offset should be calculated from the base address of
the global variable.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 80 +++++++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.h | 14 +++++++
 2 files changed, 94 insertions(+)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 5bb05c84d249..97d9ae56350e 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1266,8 +1266,12 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf)
 struct find_var_data {
 	/* Target instruction address */
 	Dwarf_Addr pc;
+	/* Target memory address (for global data) */
+	Dwarf_Addr addr;
 	/* Target register */
 	unsigned reg;
+	/* Access offset, set for global data */
+	int offset;
 };
 
 /* Max number of registers DW_OP_regN supports */
@@ -1328,6 +1332,82 @@ Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
 	};
 	return die_find_child(sc_die, __die_find_var_reg_cb, &data, die_mem);
 }
+
+/* Only checks direct child DIEs in the given scope */
+static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
+{
+	struct find_var_data *data = arg;
+	int tag = dwarf_tag(die_mem);
+	ptrdiff_t off = 0;
+	Dwarf_Attribute attr;
+	Dwarf_Addr base, start, end;
+	Dwarf_Word size;
+	Dwarf_Die type_die;
+	Dwarf_Op *ops;
+	size_t nops;
+
+	if (tag != DW_TAG_variable)
+		return DIE_FIND_CB_SIBLING;
+
+	if (dwarf_attr(die_mem, DW_AT_location, &attr) == NULL)
+		return DIE_FIND_CB_SIBLING;
+
+	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
+		if (ops->atom != DW_OP_addr)
+			continue;
+
+		if (data->addr < ops->number)
+			continue;
+
+		if (data->addr == ops->number) {
+			/* Update offset relative to the start of the variable */
+			data->offset = 0;
+			return DIE_FIND_CB_END;
+		}
+
+		if (die_get_real_type(die_mem, &type_die) == NULL)
+			continue;
+
+		if (dwarf_aggregate_size(&type_die, &size) < 0)
+			continue;
+
+		if (data->addr >= ops->number + size)
+			continue;
+
+		/* Update offset relative to the start of the variable */
+		data->offset = data->addr - ops->number;
+		return DIE_FIND_CB_END;
+	}
+	return DIE_FIND_CB_SIBLING;
+}
+
+/**
+ * die_find_variable_by_addr - Find variable located at given address
+ * @sc_die: a scope DIE
+ * @pc: the program address to find
+ * @addr: the data address to find
+ * @die_mem: a buffer to save the resulting DIE
+ * @offset: the offset in the resulting type
+ *
+ * Find the variable DIE located at the given address (in PC-relative mode).
+ * This is usually for global variables.
+ */
+Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
+				     Dwarf_Addr addr, Dwarf_Die *die_mem,
+				     int *offset)
+{
+	struct find_var_data data = {
+		.pc = pc,
+		.addr = addr,
+	};
+	Dwarf_Die *result;
+
+	result = die_find_child(sc_die, __die_find_var_addr_cb, &data, die_mem);
+	if (result)
+		*offset = data.offset;
+	return result;
+}
+
 #endif
 
 /*
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 574405c57d3b..742098e3ee7e 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -144,6 +144,11 @@ int die_get_var_range(Dwarf_Die *sp_die, Dwarf_Die *vr_die, struct strbuf *buf);
 Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die, Dwarf_Addr pc, int reg,
 				    Dwarf_Die *die_mem);
 
+/* Find a (global) variable located in the 'addr' */
+Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die, Dwarf_Addr pc,
+				     Dwarf_Addr addr, Dwarf_Die *die_mem,
+				     int *offset);
+
 #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
@@ -161,6 +166,15 @@ static inline Dwarf_Die *die_find_variable_by_reg(Dwarf_Die *sc_die __maybe_unus
 	return NULL;
 }
 
+static inline Dwarf_Die *die_find_variable_by_addr(Dwarf_Die *sc_die __maybe_unused,
+						   Dwarf_Addr pc __maybe_unused,
+						   Dwarf_Addr addr __maybe_unused,
+						   Dwarf_Die *die_mem __maybe_unused,
+						   int *offset __maybe_unused)
+{
+	return NULL;
+}
+
 #endif /* HAVE_DWARF_GETLOCATIONS_SUPPORT */
 
 #endif /* _DWARF_AUX_H */
-- 
2.42.0.655.g421f12c284-goog

