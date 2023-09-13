Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2AF79E745
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 13:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238995AbjIMLxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 07:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjIMLxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 07:53:31 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5653D198B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:53:27 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-576918d0a42so2178926eaf.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 04:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694606006; x=1695210806; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2hlBY/jbOkpE01NEcPpisnFwvdTpUatUqVrS5oNJdR4=;
        b=CnUa+AukD9DG6ShGwwWDiINrycr7d+sSuh6ffpO3Hpxj0MWHqlcBhrBgCcSPLSnhHd
         1j0EMsZqmZ9Tb8ggF/czDLC0ZKNwIUlIKval9mNYVdIc/kYJAlkBVugYZ4hyKrUSp2C9
         wuoBLG5fmpvr1sfY+4wosZW/HRp7ApC9JTrR6M+hlU3z6JkezExn9gWUs7knZik5HTQX
         dJGZcOqfcV7mOtAgsN2TSKylI5LW9ucp/rvCVSGUwkTYlnAQwBguXgLf3e3Nyu4qoapp
         g1y5SpU4WzLXHVtVfYH4ACSTR4fz8fmNHrM2U6cHpxUX+mNVPG1F6lkVV/p2E3+hM5c8
         gDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694606006; x=1695210806;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2hlBY/jbOkpE01NEcPpisnFwvdTpUatUqVrS5oNJdR4=;
        b=vBoZ9J6YkyRy5BWcwfnrSmIx6AIPIlesxRnu8Sw3p9r18vkCfEOgHPWPfspw4rxcWx
         3qEnEJU0sM4fJv/vv6pIvZG8AJR3gVIK0ZNLigRqtodfg0D3EewMgagqAHhi1jHjlgHZ
         hFjh8RPwKI9Jy+8AC9daT/VhLzq02Lra5ovlcKZvIexciUwFocFAo9gLJiaLJYbCKEvt
         SE4pFJkcrdT2lUrxaC2r5liaERD344d1qxnin5MKCYkh8T3WvyW2BNhK2CJ7HdwuSY9+
         AasIExILxhOJWYWhuEijV7/8KTTJTl7UP5I9kHlztFoaKzW7sDRSWfDFZ5Duyvy7Sv96
         Ueuw==
X-Gm-Message-State: AOJu0Yw2PKYiEJoa2tXs/mSl29oKC6o8m9asvweQfLdUL/0pchiOZ9Xv
        3TaMM/RQu45sC0+w3GNapEc=
X-Google-Smtp-Source: AGHT+IEkuGdqBilSorPZD15Ofn2tcdMVdBXDzHoqyFH+feetDOa8XcKKbjli9Thpd+By7fpHRrn45A==
X-Received: by 2002:a05:6870:8a2c:b0:1bb:5bc3:7f23 with SMTP id p44-20020a0568708a2c00b001bb5bc37f23mr2534323oaq.46.1694606006297;
        Wed, 13 Sep 2023 04:53:26 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([187.19.173.117])
        by smtp.gmail.com with ESMTPSA id eb20-20020a056870a89400b001cce851c7basm6119955oab.11.2023.09.13.04.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 04:53:25 -0700 (PDT)
From:   arnaldo.melo@gmail.com
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EF4B4403F4; Wed, 13 Sep 2023 08:53:22 -0300 (-03)
Date:   Wed, 13 Sep 2023 08:53:22 -0300
To:     linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 1/1 fyi] tools arch x86: Sync the msr-index.h copy with the
 kernel sources
Message-ID: <ZQGismCqcDddjEIQ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tldr; Just FYI, I'm carrying this on the perf tools tree.

- Arnaldo

Full explanation:

There used to be no copies, with tools/ code using kernel headers
directly. From time to time tools/perf/ broke due to legitimate kernel
hacking. At some point Linus complained about such direct usage. Then we
adopted the current model.

The way these headers are used in perf are not restricted to just
including them to compile something.

There are sometimes used in scripts that convert defines into string
tables, etc, so some change may break one of these scripts, or new MSRs
may use some different #define pattern, etc.

E.g.:

  $ ls -1 tools/perf/trace/beauty/*.sh | head -5
  tools/perf/trace/beauty/arch_errno_names.sh
  tools/perf/trace/beauty/drm_ioctl.sh
  tools/perf/trace/beauty/fadvise.sh
  tools/perf/trace/beauty/fsconfig.sh
  tools/perf/trace/beauty/fsmount.sh
  $
  $ tools/perf/trace/beauty/fadvise.sh
  static const char *fadvise_advices[] = {
  	[0] = "NORMAL",
  	[1] = "RANDOM",
  	[2] = "SEQUENTIAL",
  	[3] = "WILLNEED",
  	[4] = "DONTNEED",
  	[5] = "NOREUSE",
  };
  $

The tools/perf/check-headers.sh script, part of the tools/ build
process, points out changes in the original files.

So its important not to touch the copies in tools/ when doing changes in
the original kernel headers, that will be done later, when
check-headers.sh inform about the change to the perf tools hackers.

---

To pick up the changes from these csets:

  1b5277c0ea0b2473 ("x86/srso: Add SRSO_NO support")
  8974eb588283b7d4 ("x86/speculation: Add Gather Data Sampling mitigation")

That cause no changes to tooling:

  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > before
  $ cp arch/x86/include/asm/msr-index.h tools/arch/x86/include/asm/msr-index.h
  $ tools/perf/trace/beauty/tracepoints/x86_msr.sh > after
  $ diff -u before after
  $

Just silences this perf build warning:

  Warning: Kernel ABI header differences:
    diff -u tools/arch/x86/include/asm/msr-index.h arch/x86/include/asm/msr-index.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Borislav Petkov (AMD) <bp@alien8.de>
Cc: Daniel Sneddon <daniel.sneddon@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/arch/x86/include/asm/msr-index.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/arch/x86/include/asm/msr-index.h b/tools/arch/x86/include/asm/msr-index.h
index a00a53e15ab73883..1d111350197f3169 100644
--- a/tools/arch/x86/include/asm/msr-index.h
+++ b/tools/arch/x86/include/asm/msr-index.h
@@ -57,6 +57,7 @@
 
 #define MSR_IA32_PRED_CMD		0x00000049 /* Prediction Command */
 #define PRED_CMD_IBPB			BIT(0)	   /* Indirect Branch Prediction Barrier */
+#define PRED_CMD_SBPB			BIT(7)	   /* Selective Branch Prediction Barrier */
 
 #define MSR_PPIN_CTL			0x0000004e
 #define MSR_PPIN			0x0000004f
@@ -155,6 +156,15 @@
 						 * Not susceptible to Post-Barrier
 						 * Return Stack Buffer Predictions.
 						 */
+#define ARCH_CAP_GDS_CTRL		BIT(25)	/*
+						 * CPU is vulnerable to Gather
+						 * Data Sampling (GDS) and
+						 * has controls for mitigation.
+						 */
+#define ARCH_CAP_GDS_NO			BIT(26)	/*
+						 * CPU is not vulnerable to Gather
+						 * Data Sampling (GDS).
+						 */
 
 #define ARCH_CAP_XAPIC_DISABLE		BIT(21)	/*
 						 * IA32_XAPIC_DISABLE_STATUS MSR
@@ -178,6 +188,8 @@
 #define RNGDS_MITG_DIS			BIT(0)	/* SRBDS support */
 #define RTM_ALLOW			BIT(1)	/* TSX development mode */
 #define FB_CLEAR_DIS			BIT(3)	/* CPU Fill buffer clear disable */
+#define GDS_MITG_DIS			BIT(4)	/* Disable GDS mitigation */
+#define GDS_MITG_LOCKED			BIT(5)	/* GDS mitigation locked */
 
 #define MSR_IA32_SYSENTER_CS		0x00000174
 #define MSR_IA32_SYSENTER_ESP		0x00000175
-- 
2.37.1

