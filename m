Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3723F7F65EA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345767AbjKWSDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjKWSDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:03:20 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D97170D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:03:18 -0800 (PST)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0D849420C3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1700762589;
        bh=R1n8ksDNdCksuRnFAcfne+WFQ6Clq7m+xUS67MT50PI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nSSYG+2v6U3wbTQ+u1/TJ+LyzNOrhqzCYNnD/gaWhsS70wTjQArJbJcDof3Re8EZ5
         bCTPw22nexk33t788lEPvObqTk+a3JDoH2ZmRQRAno7wXrMDtQsmtn38btcOCSwDiC
         HHCtrtMflmQOUz8lV7BSbOmPXosXw8AMXtv6FUobcUrBKyQuoCR5NI0oEdubNamPXF
         ZHEai+xkY2juBW6JCNPUbaonoPIWxj1fXkf77NQRqBQs3xA3tyVMkzo7AJoVKmlDyO
         15wGrJAZMLlkuQdwr+45CcgsDNRZOJDXACJxdOKI33yTh7U2CUSUmxFCi4ulkQbZRu
         aHsjLkFu4J02Q==
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-332e3f4c0b6so489086f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:03:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700762583; x=1701367383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R1n8ksDNdCksuRnFAcfne+WFQ6Clq7m+xUS67MT50PI=;
        b=gUykt2uHR/ww6WVsUwQGKDrlE+UyeJcxJ5ODlPo/HkRapCfrBMJhKmbpyfItjnL04C
         QOWeT4Q9Irq5WxnPdxwzs8dpO0jFYtZhyZjbDFR2Gcg599sHJw+oW8c6jRD1mDU7LBIA
         ICYwTavn05cZM8Nv3+KaGzA0a3d58FMrJUZt6Qz9UJjYiHSP0XxUYmJGiSc5XcXx7M1L
         G6kXrFpz9wgwW536XG6JtmjOBd4CC16X3WFonc4d+nTRUZdCXfYOZDYKAEC2n1F99RX4
         Te0zR+DwapjkMZAau8RYqlteWGYnynepyXHnDVlLMxG100R9pEpYUVN82ocgtAEGFuEY
         ZhyA==
X-Gm-Message-State: AOJu0YxjSBVn0QMxinhcj2i/1CxB4GcGcnMuZIS8FgOYpd6sutztm+9h
        qCyE55Fb63RixTBb/xSGGZmELRUOjScm2GkNllR+FZXbcjceQLsHXVI38cEmEFuNhDxGfXuquvm
        kSuG7H2p7kcwsIX1xgIQpYPQOo7QNOkqqKW+uGuwRhZL1JwXZV+pH
X-Received: by 2002:a5d:688e:0:b0:332:ca0b:5793 with SMTP id h14-20020a5d688e000000b00332ca0b5793mr145434wru.19.1700762583070;
        Thu, 23 Nov 2023 10:03:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2QhZkx9uLWjRxbIxU8Xy3xhC2F+2LVtCCkr4qvSqBJX+aNSZh4TVvrXYen3EtRYmsrgNSSg==
X-Received: by 2002:a5d:688e:0:b0:332:ca0b:5793 with SMTP id h14-20020a5d688e000000b00332ca0b5793mr145406wru.19.1700762582657;
        Thu, 23 Nov 2023 10:03:02 -0800 (PST)
Received: from localhost ([2001:67c:1560:8007::aac:c15c])
        by smtp.gmail.com with ESMTPSA id c9-20020adfef49000000b0032fb7b4f191sm2268350wrp.91.2023.11.23.10.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 10:03:01 -0800 (PST)
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
To:     Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     linux-alpha@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] alpha: stop shipping a.out.h uapi headers
Date:   Thu, 23 Nov 2023 18:02:42 +0000
Message-Id: <20231123180246.750674-3-dimitri.ledkov@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231123180246.750674-1-dimitri.ledkov@canonical.com>
References: <20231123180246.750674-1-dimitri.ledkov@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stop shipping a.out.h uapi headers, unused.

Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
---
 arch/alpha/include/uapi/asm/a.out.h | 92 -----------------------------
 1 file changed, 92 deletions(-)
 delete mode 100644 arch/alpha/include/uapi/asm/a.out.h

diff --git a/arch/alpha/include/uapi/asm/a.out.h b/arch/alpha/include/uapi/asm/a.out.h
deleted file mode 100644
index 7d692df04b..0000000000
--- a/arch/alpha/include/uapi/asm/a.out.h
+++ /dev/null
@@ -1,92 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _UAPI__ALPHA_A_OUT_H__
-#define _UAPI__ALPHA_A_OUT_H__
-
-#include <linux/types.h>
-
-/*
- * OSF/1 ECOFF header structs.  ECOFF files consist of:
- * 	- a file header (struct filehdr),
- *	- an a.out header (struct aouthdr),
- *	- one or more section headers (struct scnhdr). 
- *	  The filhdr's "f_nscns" field contains the
- *	  number of section headers.
- */
-
-struct filehdr
-{
-	/* OSF/1 "file" header */
-	__u16 f_magic, f_nscns;
-	__u32 f_timdat;
-	__u64 f_symptr;
-	__u32 f_nsyms;
-	__u16 f_opthdr, f_flags;
-};
-
-struct aouthdr
-{
-	__u64 info;		/* after that it looks quite normal.. */
-	__u64 tsize;
-	__u64 dsize;
-	__u64 bsize;
-	__u64 entry;
-	__u64 text_start;	/* with a few additions that actually make sense */
-	__u64 data_start;
-	__u64 bss_start;
-	__u32 gprmask, fprmask;	/* bitmask of general & floating point regs used in binary */
-	__u64 gpvalue;
-};
-
-struct scnhdr
-{
-	char	s_name[8];
-	__u64	s_paddr;
-	__u64	s_vaddr;
-	__u64	s_size;
-	__u64	s_scnptr;
-	__u64	s_relptr;
-	__u64	s_lnnoptr;
-	__u16	s_nreloc;
-	__u16	s_nlnno;
-	__u32	s_flags;
-};
-
-struct exec
-{
-	/* OSF/1 "file" header */
-	struct filehdr		fh;
-	struct aouthdr		ah;
-};
-
-/*
- * Define's so that the kernel exec code can access the a.out header
- * fields...
- */
-#define	a_info		ah.info
-#define	a_text		ah.tsize
-#define a_data		ah.dsize
-#define a_bss		ah.bsize
-#define a_entry		ah.entry
-#define a_textstart	ah.text_start
-#define	a_datastart	ah.data_start
-#define	a_bssstart	ah.bss_start
-#define	a_gprmask	ah.gprmask
-#define a_fprmask	ah.fprmask
-#define a_gpvalue	ah.gpvalue
-
-#define N_TXTADDR(x) ((x).a_textstart)
-#define N_DATADDR(x) ((x).a_datastart)
-#define N_BSSADDR(x) ((x).a_bssstart)
-#define N_DRSIZE(x) 0
-#define N_TRSIZE(x) 0
-#define N_SYMSIZE(x) 0
-
-#define AOUTHSZ		sizeof(struct aouthdr)
-#define SCNHSZ		sizeof(struct scnhdr)
-#define SCNROUND	16
-
-#define N_TXTOFF(x) \
-  ((long) N_MAGIC(x) == ZMAGIC ? 0 : \
-   (sizeof(struct exec) + (x).fh.f_nscns*SCNHSZ + SCNROUND - 1) & ~(SCNROUND - 1))
-
-#endif /* _UAPI__ALPHA_A_OUT_H__ */
-- 
2.34.1

