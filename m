Return-Path: <linux-kernel+bounces-21597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A738291A2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFD1287354
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4B215C0;
	Wed, 10 Jan 2024 00:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdzn1Ua/"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016A2391;
	Wed, 10 Jan 2024 00:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d3aa0321b5so32410045ad.2;
        Tue, 09 Jan 2024 16:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704848087; x=1705452887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=bgsQ4MWW5/DZVSlFzeBPrIni0TrETXMOxQj1QIRmig4=;
        b=gdzn1Ua/Jz2KX+E+DxxQrgyq0KXLX7cGyz1bwnMdsDubyRmCkzetSolLIZyIstXki2
         mmx3kOdcymnYvQOYf1YWo2G4QdAjdKeOBmOj526xuF+1k+jAgNk74+XKWCivyqKTIWOt
         MxY/rRjr6/R/UvmxaOGmeNHOdQ/OvFzrS3ovmXPBXhUxxWdVGVX0jxS90OmWTwVqKgIr
         hh6PsSGlTn+FjeYmK5uy0P4Xzd39u/Ww2mDC7fCoYSRvKFBH+RDNEKVcdMp3CYDlwloR
         0RywCopeQxnWshMLLi1BZP7RBIlcDF8lelJdGCJLBRqHEHcRg7Taumod23OP0t/wz9ai
         vJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704848087; x=1705452887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgsQ4MWW5/DZVSlFzeBPrIni0TrETXMOxQj1QIRmig4=;
        b=Pcd1UeaFZMov9CYcn+qqRnOolr5VVS2T/cNazZZuNU2hoZ7d21sgM9BMSn704zmwSQ
         vvmSZrARWQwPg8jN4LtGmBDfvI9JXgxAOpVv3yLZsXTohRTq9oKJrD34ScIlocKqTcLp
         pCV8s42MFF8eFwIGE2TqFb58tzJpIsKLyCyBTIwgoN5QpN9uZuuJaqCzOhtW8S3eTZnF
         zyXI/uo7T2jUQCrPLrdUyb7ofcYhcF48CI2c9NfpGGThSQx/600y7158/Hu+5mvIheNg
         yj0dQn5V/1BwKIZL0bMAMkokJJfegem0K4jeGqorfrndqtc1yZ39UDrQpQq0iMGbTYNJ
         Rn0Q==
X-Gm-Message-State: AOJu0Yzq1fJardb+rsPv3pITU6z8RyQ7DUlMVO0pBrDw5cn0UPagCtHK
	CBJWgfnFk57gLqpUM3EvA+E=
X-Google-Smtp-Source: AGHT+IHDwhpQqplkWK9MBks/DbMEULAEtvcfr0/cTbRNOfAE+YPKlmKrdfUdgOz83YBHAosyauoytw==
X-Received: by 2002:a17:903:228c:b0:1d4:152b:dd8e with SMTP id b12-20020a170903228c00b001d4152bdd8emr243529plh.108.1704848087171;
        Tue, 09 Jan 2024 16:54:47 -0800 (PST)
Received: from bangji.roam.corp.google.com ([2a00:79e1:abc:12d:b923:c723:30c0:8cd9])
        by smtp.gmail.com with ESMTPSA id t13-20020a170902b20d00b001cff026df52sm2396147plr.221.2024.01.09.16.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 16:54:46 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Stephane Eranian <eranian@google.com>,
	Stefano Sanfilippo <ssanfilippo@chromium.org>,
	Steve MacLean <Steve.MacLean@Microsoft.com>,
	Pablo Galindo <pablogsal@gmail.com>
Subject: [PATCH 1/2] perf doc: Update jitdump unwind info specification
Date: Tue,  9 Jan 2024 16:54:44 -0800
Message-ID: <20240110005445.490058-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the jitdump spec says the EH frame header is followed by the
actual EH frame data.  But in fact, it's the opposite way.

I've checked this with the v8 javascript engine which, I believe, is the
actual user of this feature.

  https://github.com/v8/v8/blob/04f51bc70a38fbea743588e41290bea40830a486/src/diagnostics/eh-frame.cc#L157

Also, the unwind_data_size field should have the size of both unwind
table and the header sections.  The jit_add_eh_frame_info() in genelf.c
calculates the table size by subtracting the header size from it.

Cc: Stephane Eranian <eranian@google.com>
Cc: Stefano Sanfilippo <ssanfilippo@chromium.org>
Cc: Steve MacLean <Steve.MacLean@Microsoft.com>
Reported-by: Pablo Galindo <pablogsal@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/jitdump-specification.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/Documentation/jitdump-specification.txt b/tools/perf/Documentation/jitdump-specification.txt
index 79936355d819..5c3fbbbebf14 100644
--- a/tools/perf/Documentation/jitdump-specification.txt
+++ b/tools/perf/Documentation/jitdump-specification.txt
@@ -155,10 +155,10 @@ The record is used to describe the unwinding information for a jitted function.
 
 The record has the following fields following the fixed-size record header in order:
 
-uint64_t unwind_data_size   : the size in bytes of the unwinding data table at the end of the record
-uint64_t eh_frame_hdr_size  : the size in bytes of the DWARF EH Frame Header at the start of the unwinding data table at the end of the record
+uint64_t unwind_data_size   : the size in bytes of the unwinding data (EH Frame table and EH Frame Header) at the end of the record
+uint64_t eh_frame_hdr_size  : the size in bytes of the DWARF EH Frame Header at the end of the record
 uint64_t mapped_size        : the size of the unwinding data mapped in memory
-const char unwinding_data[n]: an array of unwinding data, consisting of the EH Frame Header, followed by the actual EH Frame
+const char unwinding_data[n]: an array of unwinding data, consisting of the actual EH Frame, followed by the EH Frame Header
 
 
 The EH Frame header follows the Linux Standard Base (LSB) specification as described in the document at https://refspecs.linuxfoundation.org/LSB_1.3.0/gLSB/gLSB/ehframehdr.html
-- 
2.43.0.472.g3155946c3a-goog


