Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD607E7570
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345504AbjKJABC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345520AbjKJAAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:00:47 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9427478B;
        Thu,  9 Nov 2023 16:00:31 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-2800c221af2so1336728a91.0;
        Thu, 09 Nov 2023 16:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574431; x=1700179231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vPHuNFbXr+S2SlRfwyzwCgcZDXra7FMzxpczsBE4C70=;
        b=dLSYgAnec/6gwcZcg2fylFEiVFJVb3f4CLu69amQk/OsmAM8+V2oJu+gWwTWbZ9/eh
         heAGc9pr1KEU/YGX6H8BVSiAjxWMQhVLYZLstR1uSNv9JHkhbvfUfVFOZOeWLfoX3c58
         +RueHVXZ+X4BnqlYRkSyiLXKZ53SN5Hgya0tByVgoqajBMWKoRZmG+wEL/ADA5zY4H1B
         HkObPu2WNyd7ayajfpSXljR8Y1v6Y8OqLiCIstpPisjxaX4oQJMh6l+8fm1oQ+nKFvyT
         c2/wbeLSIyauh6aYCbc8sswySJOBaIVVTdzwTx/ynkwMJBhpj6A+WEVHU6OzfXwoaTQb
         MIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574431; x=1700179231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vPHuNFbXr+S2SlRfwyzwCgcZDXra7FMzxpczsBE4C70=;
        b=DIsJSrBc286raVIU/cJdcM6CRcYoT7WsJhLH6TCtHPIVWkPt4mdzZRTjebMELvgpt4
         dzGeUsRhXx3A8XOoh0eiW7RfD5PGNUHY2WNuuOHk3rFLLFm7FCBi8bV9D/WnnKs9hDDu
         g2h4Er04P7NgR9Sjj5O8GOoqCvFq3Adu7D9y5uHHFP+guEsPtKT5dtkfEvHdmtnzo9oU
         sXNEbAXlOOzZvbiMYkDSIkZENaOXvOTvie42oHDk5q2JUCsgeTvXRdPsneC9JpyJeHGt
         yIYmA/I+/7ND0cjsA/Y74OXJysBKqfOkfzjVdXtQKKCjWi+b4ypVowVX75m5wcK/V99r
         mC1A==
X-Gm-Message-State: AOJu0YxEv+9pgM2kZ82yABMW4yTNse1bTguINCni04tqCbDgiMS82WvL
        Wb8qDooj4hrLrEdnTLovDc0=
X-Google-Smtp-Source: AGHT+IEHCy9hCDuslZKjaVVpbYLJc/ESmSsfVCGnOyGHAZwSRi8tOQcyBoJiJiRNBshvVPo7RpnEYw==
X-Received: by 2002:a17:90b:3908:b0:281:12b4:21c2 with SMTP id ob8-20020a17090b390800b0028112b421c2mr3344854pjb.26.1699574431018;
        Thu, 09 Nov 2023 16:00:31 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:00:30 -0800 (PST)
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
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 10/52] perf dwarf-aux: Factor out die_get_typename_from_type()
Date:   Thu,  9 Nov 2023 15:59:29 -0800
Message-ID: <20231110000012.3538610-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The die_get_typename_from_type() is to get the name of the given DIE in
C-style type name.  The difference from the die_get_typename() is that
it does not retrieve the DW_AT_type and use the given DIE directly.
This will be used when users know the type DIE already.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 38 ++++++++++++++++++++++++++-----------
 tools/perf/util/dwarf-aux.h |  3 +++
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 652e6e7368a2..4bdcd3dea28f 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1051,32 +1051,28 @@ Dwarf_Die *die_find_member(Dwarf_Die *st_die, const char *name,
 }
 
 /**
- * die_get_typename - Get the name of given variable DIE
- * @vr_die: a variable DIE
+ * die_get_typename_from_type - Get the name of given type DIE
+ * @type_die: a type DIE
  * @buf: a strbuf for result type name
  *
- * Get the name of @vr_die and stores it to @buf. Return 0 if succeeded.
+ * Get the name of @type_die and stores it to @buf. Return 0 if succeeded.
  * and Return -ENOENT if failed to find type name.
  * Note that the result will stores typedef name if possible, and stores
  * "*(function_type)" if the type is a function pointer.
  */
-int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
+int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf)
 {
-	Dwarf_Die type;
 	int tag, ret;
 	const char *tmp = "";
 
-	if (__die_get_real_type(vr_die, &type) == NULL)
-		return -ENOENT;
-
-	tag = dwarf_tag(&type);
+	tag = dwarf_tag(type_die);
 	if (tag == DW_TAG_array_type || tag == DW_TAG_pointer_type)
 		tmp = "*";
 	else if (tag == DW_TAG_subroutine_type) {
 		/* Function pointer */
 		return strbuf_add(buf, "(function_type)", 15);
 	} else {
-		const char *name = dwarf_diename(&type);
+		const char *name = dwarf_diename(type_die);
 
 		if (tag == DW_TAG_union_type)
 			tmp = "union ";
@@ -1089,7 +1085,7 @@ int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
 		/* Write a base name */
 		return strbuf_addf(buf, "%s%s", tmp, name ?: "");
 	}
-	ret = die_get_typename(&type, buf);
+	ret = die_get_typename(type_die, buf);
 	if (ret < 0) {
 		/* void pointer has no type attribute */
 		if (tag == DW_TAG_pointer_type && ret == -ENOENT)
@@ -1100,6 +1096,26 @@ int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
 	return strbuf_addstr(buf, tmp);
 }
 
+/**
+ * die_get_typename - Get the name of given variable DIE
+ * @vr_die: a variable DIE
+ * @buf: a strbuf for result type name
+ *
+ * Get the name of @vr_die and stores it to @buf. Return 0 if succeeded.
+ * and Return -ENOENT if failed to find type name.
+ * Note that the result will stores typedef name if possible, and stores
+ * "*(function_type)" if the type is a function pointer.
+ */
+int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf)
+{
+	Dwarf_Die type;
+
+	if (__die_get_real_type(vr_die, &type) == NULL)
+		return -ENOENT;
+
+	return die_get_typename_from_type(&type, buf);
+}
+
 /**
  * die_get_varname - Get the name and type of given variable DIE
  * @vr_die: a variable DIE
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index b6f430730bd1..f9763d3b7572 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -116,6 +116,9 @@ Dwarf_Die *die_find_variable_at(Dwarf_Die *sp_die, const char *name,
 Dwarf_Die *die_find_member(Dwarf_Die *st_die, const char *name,
 			   Dwarf_Die *die_mem);
 
+/* Get the name of given type DIE */
+int die_get_typename_from_type(Dwarf_Die *type_die, struct strbuf *buf);
+
 /* Get the name of given variable DIE */
 int die_get_typename(Dwarf_Die *vr_die, struct strbuf *buf);
 
-- 
2.42.0.869.gea05f2083d-goog

