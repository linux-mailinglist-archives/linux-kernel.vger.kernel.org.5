Return-Path: <linux-kernel+bounces-49246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF3D8467DA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:17:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5722E1F221A2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1421018641;
	Fri,  2 Feb 2024 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dv2Ugu5P"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77401804A
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706854565; cv=none; b=gezea+x/1MZ/IhisqVgy34mzqDQrVcyA8SyVVy3ZFgBsEMZJBvYu44hOkEfwFUI/SSxTMTbDwjCVIDuKLgIug7WxuEGRx1BSnyvQ7FSrWXMn/7BrIMAJQ91ojz5R+l59V9VhR7IIfHMS3l99uv8TjiHD2LVKWsFfInR0ANpd7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706854565; c=relaxed/simple;
	bh=d+RnTUEfwRnwl1k4HqM68WIpaWnlwVSPB0IEcqxt+IA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=erkATe86YXbjRwPMmN8IY2FG8nYF6m9F4kGjCwiKs1NANfoOWHlXXacCYW0wBovKeWAVafmlDxt/rc/sAP+0hjB/VDHJJb2svaln9IGQVHyzQPSSmh5g9WqHhboRGl2Z1L+iDUkU4I9KXtG5MD32cfnCwnd35oVVb1wn3p90ndE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dv2Ugu5P; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6531fa07fso2222204276.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 22:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706854562; x=1707459362; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LraddYkgLopGo/nY223hQ1nvCnHwVQlgNAwJab4EqVs=;
        b=dv2Ugu5P3vz4vmYhJAzQlFCywEkPQq09kHqPTe36/H297QlgXoDHSv6Ik8/P/WDRbq
         ObqMO1EG8FTIe63zt/wQzH5qxtPk9ylSF7q6csc/dC3BBy+UuyaiclIppgaPxKw7yU1J
         EWipglViGhLA9fDL/WoDthXzxuYwHccDA2Efceo7vn4Kz4OtUmsLVhWfVJDEbiPH3v2z
         LIc47iUbjBJShYQPLW7OH+xnNXLdgQ8f3JdTyHg/UvscpTmV7v3JMyuiMUGEdzMrX0Gv
         xHqCG7ywc36/LdnVT1t2xnsp0cNWij+S4Q39MZkYsuy7dy0ql/Kuc5XLjg7nm0+HiJ+C
         NnAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706854562; x=1707459362;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LraddYkgLopGo/nY223hQ1nvCnHwVQlgNAwJab4EqVs=;
        b=lCdsSX1Gj1YRsuTvobJRfxZPFcMWQHznqhEhJPdtbW36b9biZmndZT86mnjefCbRAX
         QkGw3NMGcGSpGffQnsmNB2KSAWy2RYgSEdY2s27LPOwTnMNYlldc6OjlNWHdIJffutWC
         sKy6fD501xrhDXEhUz0dLZAq8Bvp3nqVUU4u2tAdFUC0fhJNtsiR1zlcmTPH/JTjwM0h
         OnOzz7wRbtQsPHROxH5u2QUZb7Qr4ez8WjhuETtNmhNTR1EIsUzLHhI8ilf1PMMuRYEm
         TGLUO4EDuWosc0lX3qMWfJzxYkfdUeTgrDVHyruqEQGDpe6pw4zCFnHv0JXvk95qZMFt
         OnnA==
X-Gm-Message-State: AOJu0Yy5zTQID2fRGkrtBqR2aDXFozQinb5RV6EWzfl5Zwz9gCBrPR6j
	oY1JhLt3m4d5O1P3PFl05zGqOXu8n3KsFb1JTFRS27GRzkqCTqvN8FbE6VrL9ZFbD+IgHkXnhXT
	Qk3Fy7g==
X-Google-Smtp-Source: AGHT+IEpwRfWJZqsnGgCBPUhcZqLgs79HMd1U7p//MJ3tNuynHKXk8vwwsFLfj3+vIZS7GwgLFA0jsDa9+rK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a05:6902:2306:b0:dc2:5130:198f with SMTP
 id do6-20020a056902230600b00dc25130198fmr67402ybb.5.1706854562551; Thu, 01
 Feb 2024 22:16:02 -0800 (PST)
Date: Thu,  1 Feb 2024 22:15:14 -0800
In-Reply-To: <20240202061532.1939474-1-irogers@google.com>
Message-Id: <20240202061532.1939474-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202061532.1939474-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v8 07/25] perf dso: Reorder variables to save space in struct dso
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	"Steinar H. Gunderson" <sesse@google.com>, Liam Howlett <liam.howlett@oracle.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Colin Ian King <colin.i.king@gmail.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Yang Jihong <yangjihong1@huawei.com>, 
	Ming Wang <wangming01@loongson.cn>, James Clark <james.clark@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"

Save 40 bytes and move from 8 to 7 cache lines. Make variable dwfl
dependent on being a powerpc build. Squeeze bits of int/enum types
when appropriate. Remove holes/padding by reordering variables.

Before:
```
struct dso {
        struct mutex               lock;                 /*     0    40 */
        struct list_head           node;                 /*    40    16 */
        struct rb_node             rb_node __attribute__((__aligned__(8))); /*    56    24 */
        /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
        struct rb_root *           root;                 /*    80     8 */
        struct rb_root_cached      symbols;              /*    88    16 */
        struct symbol * *          symbol_names;         /*   104     8 */
        size_t                     symbol_names_len;     /*   112     8 */
        struct rb_root_cached      inlined_nodes;        /*   120    16 */
        /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
        struct rb_root_cached      srclines;             /*   136    16 */
        struct {
                u64                addr;                 /*   152     8 */
                struct symbol *    symbol;               /*   160     8 */
        } last_find_result;                              /*   152    16 */
        void *                     a2l;                  /*   168     8 */
        char *                     symsrc_filename;      /*   176     8 */
        unsigned int               a2l_fails;            /*   184     4 */
        enum dso_space_type        kernel;               /*   188     4 */
        /* --- cacheline 3 boundary (192 bytes) --- */
        _Bool                      is_kmod;              /*   192     1 */

        /* XXX 3 bytes hole, try to pack */

        enum dso_swap_type         needs_swap;           /*   196     4 */
        enum dso_binary_type       symtab_type;          /*   200     4 */
        enum dso_binary_type       binary_type;          /*   204     4 */
        enum dso_load_errno        load_errno;           /*   208     4 */
        u8                         adjust_symbols:1;     /*   212: 0  1 */
        u8                         has_build_id:1;       /*   212: 1  1 */
        u8                         header_build_id:1;    /*   212: 2  1 */
        u8                         has_srcline:1;        /*   212: 3  1 */
        u8                         hit:1;                /*   212: 4  1 */
        u8                         annotate_warned:1;    /*   212: 5  1 */
        u8                         auxtrace_warned:1;    /*   212: 6  1 */
        u8                         short_name_allocated:1; /*   212: 7  1 */
        u8                         long_name_allocated:1; /*   213: 0  1 */
        u8                         is_64_bit:1;          /*   213: 1  1 */

        /* XXX 6 bits hole, try to pack */

        _Bool                      sorted_by_name;       /*   214     1 */
        _Bool                      loaded;               /*   215     1 */
        u8                         rel;                  /*   216     1 */

        /* XXX 7 bytes hole, try to pack */

        struct build_id            bid;                  /*   224    32 */
        /* --- cacheline 4 boundary (256 bytes) --- */
        u64                        text_offset;          /*   256     8 */
        u64                        text_end;             /*   264     8 */
        const char  *              short_name;           /*   272     8 */
        const char  *              long_name;            /*   280     8 */
        u16                        long_name_len;        /*   288     2 */
        u16                        short_name_len;       /*   290     2 */

        /* XXX 4 bytes hole, try to pack */

        void *                     dwfl;                 /*   296     8 */
        struct auxtrace_cache *    auxtrace_cache;       /*   304     8 */
        int                        comp;                 /*   312     4 */

        /* XXX 4 bytes hole, try to pack */

        /* --- cacheline 5 boundary (320 bytes) --- */
        struct {
                struct rb_root     cache;                /*   320     8 */
                int                fd;                   /*   328     4 */
                int                status;               /*   332     4 */
                u32                status_seen;          /*   336     4 */

                /* XXX 4 bytes hole, try to pack */

                u64                file_size;            /*   344     8 */
                struct list_head   open_entry;           /*   352    16 */
                u64                elf_base_addr;        /*   368     8 */
                u64                debug_frame_offset;   /*   376     8 */
                /* --- cacheline 6 boundary (384 bytes) --- */
                u64                eh_frame_hdr_addr;    /*   384     8 */
                u64                eh_frame_hdr_offset;  /*   392     8 */
        } data;                                          /*   320    80 */
        struct {
                u32                id;                   /*   400     4 */
                u32                sub_id;               /*   404     4 */
                struct perf_env *  env;                  /*   408     8 */
        } bpf_prog;                                      /*   400    16 */
        union {
                void *             priv;                 /*   416     8 */
                u64                db_id;                /*   416     8 */
        };                                               /*   416     8 */
        struct nsinfo *            nsinfo;               /*   424     8 */
        struct dso_id              id;                   /*   432    24 */
        /* --- cacheline 7 boundary (448 bytes) was 8 bytes ago --- */
        refcount_t                 refcnt;               /*   456     4 */
        char                       name[];               /*   460     0 */

        /* size: 464, cachelines: 8, members: 49 */
        /* sum members: 440, holes: 4, sum holes: 18 */
        /* sum bitfield members: 10 bits, bit holes: 1, sum bit holes: 6 bits */
        /* padding: 4 */
        /* forced alignments: 1 */
        /* last cacheline: 16 bytes */
} __attribute__((__aligned__(8)));
```

After:
```
struct dso {
        struct mutex               lock;                 /*     0    40 */
        struct list_head           node;                 /*    40    16 */
        struct rb_node             rb_node __attribute__((__aligned__(8))); /*    56    24 */
        /* --- cacheline 1 boundary (64 bytes) was 16 bytes ago --- */
        struct rb_root *           root;                 /*    80     8 */
        struct rb_root_cached      symbols;              /*    88    16 */
        struct symbol * *          symbol_names;         /*   104     8 */
        size_t                     symbol_names_len;     /*   112     8 */
        struct rb_root_cached      inlined_nodes;        /*   120    16 */
        /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
        struct rb_root_cached      srclines;             /*   136    16 */
        struct {
                u64                addr;                 /*   152     8 */
                struct symbol *    symbol;               /*   160     8 */
        } last_find_result;                              /*   152    16 */
        struct build_id            bid;                  /*   168    32 */
        /* --- cacheline 3 boundary (192 bytes) was 8 bytes ago --- */
        u64                        text_offset;          /*   200     8 */
        u64                        text_end;             /*   208     8 */
        const char  *              short_name;           /*   216     8 */
        const char  *              long_name;            /*   224     8 */
        void *                     a2l;                  /*   232     8 */
        char *                     symsrc_filename;      /*   240     8 */
        struct nsinfo *            nsinfo;               /*   248     8 */
        /* --- cacheline 4 boundary (256 bytes) --- */
        struct auxtrace_cache *    auxtrace_cache;       /*   256     8 */
        union {
                void *             priv;                 /*   264     8 */
                u64                db_id;                /*   264     8 */
        };                                               /*   264     8 */
        struct {
                struct perf_env *  env;                  /*   272     8 */
                u32                id;                   /*   280     4 */
                u32                sub_id;               /*   284     4 */
        } bpf_prog;                                      /*   272    16 */
        struct {
                struct rb_root     cache;                /*   288     8 */
                struct list_head   open_entry;           /*   296    16 */
                u64                file_size;            /*   312     8 */
                /* --- cacheline 5 boundary (320 bytes) --- */
                u64                elf_base_addr;        /*   320     8 */
                u64                debug_frame_offset;   /*   328     8 */
                u64                eh_frame_hdr_addr;    /*   336     8 */
                u64                eh_frame_hdr_offset;  /*   344     8 */
                int                fd;                   /*   352     4 */
                int                status;               /*   356     4 */
                u32                status_seen;          /*   360     4 */
        } data;                                          /*   288    80 */

        /* XXX last struct has 4 bytes of padding */

        struct dso_id              id;                   /*   368    24 */
        /* --- cacheline 6 boundary (384 bytes) was 8 bytes ago --- */
        unsigned int               a2l_fails;            /*   392     4 */
        int                        comp;                 /*   396     4 */
        refcount_t                 refcnt;               /*   400     4 */
        enum dso_load_errno        load_errno;           /*   404     4 */
        u16                        long_name_len;        /*   408     2 */
        u16                        short_name_len;       /*   410     2 */
        enum dso_binary_type       symtab_type:8;        /*   412: 0  4 */
        enum dso_binary_type       binary_type:8;        /*   412: 8  4 */
        enum dso_space_type        kernel:2;             /*   412:16  4 */
        enum dso_swap_type         needs_swap:2;         /*   412:18  4 */

        /* Bitfield combined with next fields */

        _Bool                      is_kmod:1;            /*   414: 4  1 */
        u8                         adjust_symbols:1;     /*   414: 5  1 */
        u8                         has_build_id:1;       /*   414: 6  1 */
        u8                         header_build_id:1;    /*   414: 7  1 */
        u8                         has_srcline:1;        /*   415: 0  1 */
        u8                         hit:1;                /*   415: 1  1 */
        u8                         annotate_warned:1;    /*   415: 2  1 */
        u8                         auxtrace_warned:1;    /*   415: 3  1 */
        u8                         short_name_allocated:1; /*   415: 4  1 */
        u8                         long_name_allocated:1; /*   415: 5  1 */
        u8                         is_64_bit:1;          /*   415: 6  1 */

        /* XXX 1 bit hole, try to pack */

        _Bool                      sorted_by_name;       /*   416     1 */
        _Bool                      loaded;               /*   417     1 */
        u8                         rel;                  /*   418     1 */
        char                       name[];               /*   419     0 */

        /* size: 424, cachelines: 7, members: 48 */
        /* sum members: 415 */
        /* sum bitfield members: 31 bits, bit holes: 1, sum bit holes: 1 bits */
        /* padding: 5 */
        /* paddings: 1, sum paddings: 4 */
        /* forced alignments: 1 */
        /* last cacheline: 40 bytes */
} __attribute__((__aligned__(8)));
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.h | 84 +++++++++++++++++++++----------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index ce9f3849a773..33a41bcea335 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -160,66 +160,66 @@ struct dso {
 		u64		addr;
 		struct symbol	*symbol;
 	} last_find_result;
-	void		 *a2l;
-	char		 *symsrc_filename;
-	unsigned int	 a2l_fails;
-	enum dso_space_type	kernel;
-	bool			is_kmod;
-	enum dso_swap_type	needs_swap;
-	enum dso_binary_type	symtab_type;
-	enum dso_binary_type	binary_type;
-	enum dso_load_errno	load_errno;
-	u8		 adjust_symbols:1;
-	u8		 has_build_id:1;
-	u8		 header_build_id:1;
-	u8		 has_srcline:1;
-	u8		 hit:1;
-	u8		 annotate_warned:1;
-	u8		 auxtrace_warned:1;
-	u8		 short_name_allocated:1;
-	u8		 long_name_allocated:1;
-	u8		 is_64_bit:1;
-	bool		 sorted_by_name;
-	bool		 loaded;
-	u8		 rel;
 	struct build_id	 bid;
 	u64		 text_offset;
 	u64		 text_end;
 	const char	 *short_name;
 	const char	 *long_name;
-	u16		 long_name_len;
-	u16		 short_name_len;
+	void		 *a2l;
+	char		 *symsrc_filename;
+#if defined(__powerpc__)
 	void		*dwfl;			/* DWARF debug info */
+#endif
+	struct nsinfo	*nsinfo;
 	struct auxtrace_cache *auxtrace_cache;
-	int		 comp;
-
+	union { /* Tool specific area */
+		void	 *priv;
+		u64	 db_id;
+	};
+	/* bpf prog information */
+	struct {
+		struct perf_env	*env;
+		u32		id;
+		u32		sub_id;
+	} bpf_prog;
 	/* dso data file */
 	struct {
 		struct rb_root	 cache;
-		int		 fd;
-		int		 status;
-		u32		 status_seen;
-		u64		 file_size;
 		struct list_head open_entry;
+		u64		 file_size;
 		u64		 elf_base_addr;
 		u64		 debug_frame_offset;
 		u64		 eh_frame_hdr_addr;
 		u64		 eh_frame_hdr_offset;
+		int		 fd;
+		int		 status;
+		u32		 status_seen;
 	} data;
-	/* bpf prog information */
-	struct {
-		u32		id;
-		u32		sub_id;
-		struct perf_env	*env;
-	} bpf_prog;
-
-	union { /* Tool specific area */
-		void	 *priv;
-		u64	 db_id;
-	};
-	struct nsinfo	*nsinfo;
 	struct dso_id	 id;
+	unsigned int	 a2l_fails;
+	int		 comp;
 	refcount_t	 refcnt;
+	enum dso_load_errno	load_errno;
+	u16		 long_name_len;
+	u16		 short_name_len;
+	enum dso_binary_type	symtab_type:8;
+	enum dso_binary_type	binary_type:8;
+	enum dso_space_type	kernel:2;
+	enum dso_swap_type	needs_swap:2;
+	bool			is_kmod:1;
+	u8		 adjust_symbols:1;
+	u8		 has_build_id:1;
+	u8		 header_build_id:1;
+	u8		 has_srcline:1;
+	u8		 hit:1;
+	u8		 annotate_warned:1;
+	u8		 auxtrace_warned:1;
+	u8		 short_name_allocated:1;
+	u8		 long_name_allocated:1;
+	u8		 is_64_bit:1;
+	bool		 sorted_by_name;
+	bool		 loaded;
+	u8		 rel;
 	char		 name[];
 };
 
-- 
2.43.0.594.gd9cf4e227d-goog


