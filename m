Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F087C96AE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 00:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233335AbjJNV6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 17:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjJNV6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 17:58:20 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1DDC9;
        Sat, 14 Oct 2023 14:58:19 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-538e8eca9c1so5568120a12.3;
        Sat, 14 Oct 2023 14:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697320697; x=1697925497; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=k3rqTgJ5wiRPiIuu/wLqZjqyoaaSm39dvqVRU6EIaGo=;
        b=I55+kMc6eieL6GYnGBKwYPFll+mRlCRApgP5/jjhBhoOG7Zg9wUfEFCKITLTtdkC0T
         GyoyE7jJkXxdENSqdphBPwIcuawM8OzlKnQI9C1lTYnbsqwrgqQbJrbkYCDT1rU1lX1/
         NTBE54OP0eoI70JiNjYJW+ajLyRKVDgibb+IbyGNZG4tWqgVmbyhMqNWoTzVEVUzgEiF
         em2E9ymfy8onRQmagCHp+uMLmD2mOfIIkmuSLRH7TUoAcY7dxraNwW/7NEJQJTR+WHv7
         2zU1LHvrK4m+5xs6rbbn+pWrWAzN8QuKA0Z1VWHHpAlo66h5YvPOQS64afN54JXvVji0
         bKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697320697; x=1697925497;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k3rqTgJ5wiRPiIuu/wLqZjqyoaaSm39dvqVRU6EIaGo=;
        b=fm2j4AYEvGYDcnoD4ej7QS8k4UiFM5T4qxc8YhEUTxMRuyjTtjCXNhKpBluetdsbOc
         HXjwnhEMwDEwUAHnfsYxaFpyF/kJD0GkfLfhZ1+l/pooKic6DXfqOv8A6iqVaUmMlGrV
         F+5bU94iNqu/Z63vsIXaEK1/vnzbLDCoNye0L9d1GEAOpJCCwkwUTnq5GeyhZtXArC6B
         0ooY4chpGmkhEFXw5i81X0kW1o+isxXfiE95S64BHIimPfi7KVthQZEp1z4BSAU3y97o
         iSoiz2IA+JQL+etK3UoObtilYQXCQxIrMgUq+tgVIjuR/rOc1IhvnZSi/PLGEK1HKiZ2
         J2VA==
X-Gm-Message-State: AOJu0Yw2zoyopLi0NgFCzNeYtvKIBi87Mp/U15zmmIbhUo/ImWdXjkF2
        OcVrz8gXPJO3IizXVA5liRE=
X-Google-Smtp-Source: AGHT+IFUdDx511EOY3CmDiG8CiCqIVVT01V76bbhfMm3qmD3XI8pW48takEHxunqaD31+hsEQ7c7rg==
X-Received: by 2002:a17:906:4fc7:b0:9be:aebc:d480 with SMTP id i7-20020a1709064fc700b009beaebcd480mr2359055ejw.24.1697320697107;
        Sat, 14 Oct 2023 14:58:17 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090681c800b009be23a040cfsm1402017ejx.40.2023.10.14.14.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 14:58:14 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 14 Oct 2023 23:58:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] perf events fix
Message-ID: <ZSsO8/2KhWgd6kLS@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the latest perf/urgent git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2023-10-14

   # HEAD: e53899771a02f798d436655efbd9d4b46c0f9265 perf/x86/lbr: Filter vsyscall addresses

Fix an LBR sampling bug.

 Thanks,

	Ingo

------------------>
JP Kobryn (1):
      perf/x86/lbr: Filter vsyscall addresses


 arch/x86/events/utils.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/utils.c b/arch/x86/events/utils.c
index 76b1f8bb0fd5..dab4ed199227 100644
--- a/arch/x86/events/utils.c
+++ b/arch/x86/events/utils.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <asm/insn.h>
+#include <linux/mm.h>
 
 #include "perf_event.h"
 
@@ -132,9 +133,9 @@ static int get_branch_type(unsigned long from, unsigned long to, int abort,
 		 * The LBR logs any address in the IP, even if the IP just
 		 * faulted. This means userspace can control the from address.
 		 * Ensure we don't blindly read any address by validating it is
-		 * a known text address.
+		 * a known text address and not a vsyscall address.
 		 */
-		if (kernel_text_address(from)) {
+		if (kernel_text_address(from) && !in_gate_area_no_mm(from)) {
 			addr = (void *)from;
 			/*
 			 * Assume we can get the maximum possible size
