Return-Path: <linux-kernel+bounces-157715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 430AA8B14FD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A8D1F234FF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9C015697C;
	Wed, 24 Apr 2024 21:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVBkV7CL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830BA13B5A6;
	Wed, 24 Apr 2024 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713992548; cv=none; b=JqFTQuP0sYFTJr4O659LsIDu90kE20S0/W+v4/xC6lupjm7TA6mNoquZVfj5VPV1bt1q8gNCVZpKYTJTLWwXqZFyq2PeEN6rVdApHd4H8a/1dsfV0Kr8jzxhrT+oJeAeJJ0fBAfaTpEasY44buiYyBLVi3KvsExdelxccvMmYro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713992548; c=relaxed/simple;
	bh=duRefqYdkr7ZabzNDP6pQLWEXT6nQnCVmhZIfFwdaCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8+S74H6im4rVPXOVUWxUXyx039WT7VzFPy9oPKqXPUvQAHK/KExHyBtEiXTOI1U+8wWdKUkRfCMhQXeqcSXT9OV9TYpL6u/CfXucjddnqcQJ7w53joTOVTq2w7gpDCnbVwL2t2Z3w4oifF4V8v3qMIAkg6WpY8nnWtvD8PR67g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVBkV7CL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F1DC113CD;
	Wed, 24 Apr 2024 21:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713992548;
	bh=duRefqYdkr7ZabzNDP6pQLWEXT6nQnCVmhZIfFwdaCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kVBkV7CLQZFxa6NTE7tHVgs/ThkR2bEBT8zgQdx/9q79ujwszX8DFByoU5WnzcM1t
	 XB5EHK70Of8Uvz8boggvdQfqfpMfTUWZk+98IOvQEysCTFQuKDHPxWTLDkwK02fhc4
	 9qNUEmAO2PJ9BSXQ4zsDkkhbIfqKvUEt0e3BgCCTOC21XxvaYvv9nq4o8AMVMUn4sc
	 8bHpTdCDLige26I3fuVHoAMMX6EDeORgfN7Uiy5WugEbNZLFGYXN7mQHwkAc65r4eu
	 dfJYKOI2bzjDlRfGJfNQr98TMXykLr55OlE4+xxManWqrfpapK5k3FupBwPZO0EyVv
	 IuasSMlYLZinw==
Date: Wed, 24 Apr 2024 18:02:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf test: Add a new test for perf annotate
Message-ID: <ZilzYDlzj7c1mQq4@x1>
References: <20240424001231.849972-1-namhyung@kernel.org>
 <CAP-5=fWNWiuiLOKyNHYcuT9xmJkciUBodjCX1E_TRrTMMsM4uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWNWiuiLOKyNHYcuT9xmJkciUBodjCX1E_TRrTMMsM4uw@mail.gmail.com>

On Wed, Apr 24, 2024 at 11:09:48AM -0700, Ian Rogers wrote:
> On Tue, Apr 23, 2024 at 5:12 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Add a basic perf annotate test
> >
> >   $ ./perf test annotate -vv
> >    76: perf annotate basic tests:
> >   --- start ---
> >   test child forked, pid 846989
> >    fbcd0-fbd55 l noploop
> >   perf does have symbol 'noploop'
> >   Basic perf annotate test
> >            : 0     0xfbcd0 <noploop>:
> >       0.00 :   fbcd0:       pushq   %rbp
> >       0.00 :   fbcd1:       movq    %rsp, %rbp
> >       0.00 :   fbcd4:       pushq   %r12
> >       0.00 :   fbcd6:       pushq   %rbx
> >       0.00 :   fbcd7:       movl    $1, %ebx
> >       0.00 :   fbcdc:       subq    $0x10, %rsp
> >       0.00 :   fbce0:       movq    %fs:0x28, %rax
> >       0.00 :   fbce9:       movq    %rax, -0x18(%rbp)
> >       0.00 :   fbced:       xorl    %eax, %eax
> >       0.00 :   fbcef:       testl   %edi, %edi
> >       0.00 :   fbcf1:       jle     0xfbd04
> >       0.00 :   fbcf3:       movq    (%rsi), %rdi
> >       0.00 :   fbcf6:       movl    $0xa, %edx
> >       0.00 :   fbcfb:       xorl    %esi, %esi
> >       0.00 :   fbcfd:       callq   0x41920
> >       0.00 :   fbd02:       movl    %eax, %ebx
> >       0.00 :   fbd04:       leaq    -0x7b(%rip), %r12   # fbc90 <sighandler>
> >       0.00 :   fbd0b:       movl    $2, %edi
> >       0.00 :   fbd10:       movq    %r12, %rsi
> >       0.00 :   fbd13:       callq   0x40a00
> >       0.00 :   fbd18:       movl    $0xe, %edi
> >       0.00 :   fbd1d:       movq    %r12, %rsi
> >       0.00 :   fbd20:       callq   0x40a00
> >       0.00 :   fbd25:       movl    %ebx, %edi
> >       0.00 :   fbd27:       callq   0x407c0
> >       0.10 :   fbd2c:       movl    0x89785e(%rip), %eax        # 993590 <done>
> >       0.00 :   fbd32:       testl   %eax, %eax
> >      99.90 :   fbd34:       je      0xfbd2c
> >       0.00 :   fbd36:       movq    -0x18(%rbp), %rax
> >       0.00 :   fbd3a:       subq    %fs:0x28, %rax
> >       0.00 :   fbd43:       jne     0xfbd50
> >       0.00 :   fbd45:       addq    $0x10, %rsp
> >       0.00 :   fbd49:       xorl    %eax, %eax
> >       0.00 :   fbd4b:       popq    %rbx
> >       0.00 :   fbd4c:       popq    %r12
> >       0.00 :   fbd4e:       popq    %rbp
> >       0.00 :   fbd4f:       retq
> >       0.00 :   fbd50:       callq   0x407e0
> >       0.00 :   fbcd0:       pushq   %rbp
> >       0.00 :   fbcd1:       movq    %rsp, %rbp
> >       0.00 :   fbcd4:       pushq   %r12
> >       0.00 :   fbcd0:  push   %rbp
> >       0.00 :   fbcd1:  mov    %rsp,%rbp
> >       0.00 :   fbcd4:  push   %r12
> >   Basic annotate test [Success]
> >   ---- end(0) ----
> >    76: perf annotate basic tests                                       : Ok
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> 
> Looks good, thanks for this!
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks! Applied, with the following changes to improve the error
reporting, please holler if you disagree:

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 7820d13eebaef535..1db1e8113d9943a6 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -36,7 +36,7 @@ test_basic() {
   echo "Basic perf annotate test"
   if ! perf record -o "${perfdata}" ${testprog} 2> /dev/null
   then
-    echo "Basic annotate [Failed record]"
+    echo "Basic annotate [Failed: perf record]"
     err=1
     return
   fi
@@ -44,7 +44,7 @@ test_basic() {
   # check if it has the target symbol
   if ! perf annotate -i "${perfdata}" 2> /dev/null | grep "${testsym}"
   then
-    echo "Basic annotate [Failed missing symbol]"
+    echo "Basic annotate [Failed: missing target symbol]"
     err=1
     return
   fi
@@ -52,7 +52,7 @@ test_basic() {
   # check if it has the disassembly lines
   if ! perf annotate -i "${perfdata}" 2> /dev/null | grep "${disasm_regex}"
   then
-    echo "Basic annotate [Failed missing disasm output]"
+    echo "Basic annotate [Failed: missing disasm output from default disassembler]"
     err=1
     return
   fi
@@ -61,7 +61,7 @@ test_basic() {
   if ! perf annotate -i "${perfdata}" "${testsym}" 2> /dev/null | \
 	  grep -m 3 "${disasm_regex}"
   then
-    echo "Basic annotate [Failed missing disasm output]"
+    echo "Basic annotate [Failed: missing disasm output when specifying the target symbol]"
     err=1
     return
   fi
@@ -70,7 +70,7 @@ test_basic() {
   if ! perf annotate -i "${perfdata}" --objdump=objdump 2> /dev/null | \
 	  grep -m 3 "${disasm_regex}"
   then
-    echo "Basic annotate [Failed missing disasm output from objdump]"
+    echo "Basic annotate [Failed: missing disasm output from non default disassembler (using --objdump)]"
     err=1
     return
   fi

