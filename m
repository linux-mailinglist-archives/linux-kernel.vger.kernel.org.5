Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303F57C939E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 11:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbjJNJDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 05:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjJNJDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 05:03:07 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3195BF;
        Sat, 14 Oct 2023 02:03:05 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so5084892a12.0;
        Sat, 14 Oct 2023 02:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697274184; x=1697878984; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vrjdvhuyLi76cWCs4pY1W4T+njgP3cS2nbxIhYnFvBk=;
        b=I3lYgWxUiRC7SmOnjyEJXdAZfLge044Dz/25M7uxyKe0Q1jonmWIyXR5+veMug/aN7
         lLDU/QPWxrGbbHAZx+P2l6vi7tQZR8pZ6mQK+DEHyJ87WdBSJg+NkvCPkYompZBMoZUV
         7mNi+tNv5KeM1/1+oA3Dj8SkQR/2jLb4Dw39441YgK5MvuBiyrVBRt8s5Riftj1goBjN
         PAkFv9KjcYq+p1pTXk1+3lVJKeErYiTMbaoAypXbSzZs/gII0IwTrFlyd0XvoCoNTSPC
         Znqjy7zj1Ebo2rtfql5SXIu483/0BmydWwNpkHZVKe13ndQbCPj+MuScwX7JlPb1gegM
         rjqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697274184; x=1697878984;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vrjdvhuyLi76cWCs4pY1W4T+njgP3cS2nbxIhYnFvBk=;
        b=A5SkcAYOsIKUH5BcSp7kQ05iEsyBCjRqyGZpgZ7CvWtXijjiuk5+BlwdGrnDQ5oEUs
         /7paIkFJsRXJoFGJIYyXSNecX844WEyUlak0eNA41+j2DFeNkXbBDUjqs6HIUk3rzjLJ
         icPxIWWtSsJWRuaqgOlqAO7DmRyFy/Hu4XUlTtNK1HsERiGuhDdUvbWhaCQaVvyI4GJq
         g7j2oSrwPhAp6kQMzT4hEsx1i/bIP87d/poqF9FlKxC36DkmR7bTsnbmjcvJvjPvptFj
         yULR2UANkHroA/2woXCTIVO7X/bqajNRRR90+f2vWmDqJ6xPNazxeofC2/rH72m57N86
         cvsQ==
X-Gm-Message-State: AOJu0YyOp/wZBpN5hwzVJpMjF8MbokXe3JfUDHdRwAL8uYnlrZxfk5Im
        YuXdCpeDucew95+3brf74ck=
X-Google-Smtp-Source: AGHT+IFjOj1/IzQBMj0vcP13kI+ox/4uaCVTPj6ssHEWe+hQtRJFoEQe2IM5SiqE17oNcM5Fwg/Pyw==
X-Received: by 2002:a05:6402:5192:b0:53e:2b80:2f74 with SMTP id q18-20020a056402519200b0053e2b802f74mr5436034edd.0.1697274184087;
        Sat, 14 Oct 2023 02:03:04 -0700 (PDT)
Received: from gmail.com (1F2EF7B2.nat.pool.telekom.hu. [31.46.247.178])
        by smtp.gmail.com with ESMTPSA id a90-20020a509ee3000000b0053e589016a7sm1423959edf.16.2023.10.14.02.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 02:03:03 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 14 Oct 2023 11:03:00 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Sandipan Das <sandipan.das@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] perf/x86/amd/uncore: fix error codes in amd_uncore_init()
Message-ID: <ZSpZRM4ZEnNy98Rz@gmail.com>
References: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
 <ZSjyJuqk3z0RyKP2@gmail.com>
 <0c973a20-e10c-4989-b7d9-86cb0f522718@kadam.mountain>
 <ZSkInflBriOL9V3M@gmail.com>
 <CAFULd4b7F=MNMduRn99FFcAc7Of7RsL+vyXVzsiBZZ9hz0+HnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4b7F=MNMduRn99FFcAc7Of7RsL+vyXVzsiBZZ9hz0+HnA@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Uros Bizjak <ubizjak@gmail.com> wrote:

> On Fri, Oct 13, 2023 at 11:06 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > * Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > > On Fri, Oct 13, 2023 at 09:30:46AM +0200, Ingo Molnar wrote:
> > >
> > > > Ugh, why on Earth didn't GCC warn about this? The bad pattern is pretty
> > > > simple & obvious once pointed out ... compilers should have no trouble
> > > > realizing that 'ret' is returned uninitialized in some of these control
> > > > paths. Yet not a peep from the compiler ...
> > >
> > > We disabled that warning years ago (5?) because GCC had too many false
> > > positives.
> >
> > GCC had some pretty bogus notions about 'possible' uninitialized use that
> > encouraged some bad code patterns, but in this case there's readily
> > provable uninitialized use, that a compiler should warn about.
> >
> > Is it possible to disable just the unreliable, probabilistic part of GCC's
> > uninitialized variables warnings?
> 
> -Wno-maybe-uninitialized?

No combination of the relevant compiler options appears to be able to get 
GCC to notice this bug.

On top of tip:master, the patch below produces no compiler warnings with 
GCC 12.3.0:

  $ git revert 7543365739a4
  $ rm -f arch/x86/events/amd/uncore.o
  $ make V=1 W=1e arch/x86/events/amd/uncore.o

The "W=1e" incantation activates, with the patch below applied, among many 
other GCC options, the following options:

  -Wall
  -Wuninitialized
  -Wmaybe-uninitialized
  -Werror 

Which should have found this bug, right?

[ The V=1 helps double checking the compiler options. ]

Thanks,

	Ingo

 scripts/Makefile.extrawarn | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 2fe6f2828d37..9d245fcff419 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -108,6 +108,8 @@ KBUILD_CFLAGS += $(call cc-option, -Wformat-overflow)
 KBUILD_CFLAGS += $(call cc-option, -Wformat-truncation)
 KBUILD_CFLAGS += $(call cc-option, -Wstringop-overflow)
 KBUILD_CFLAGS += $(call cc-option, -Wstringop-truncation)
+KBUILD_CFLAGS += $(call cc-option, -Wuninitialized)
+KBUILD_CFLAGS += $(call cc-option, -Wmaybe-uninitialized)
 
 KBUILD_CPPFLAGS += -Wundef
 KBUILD_CPPFLAGS += -DKBUILD_EXTRA_WARN1
@@ -176,7 +178,7 @@ KBUILD_CFLAGS += -Wno-shift-negative-value
 ifdef CONFIG_CC_IS_CLANG
 KBUILD_CFLAGS += -Wno-initializer-overrides
 else
-KBUILD_CFLAGS += -Wno-maybe-uninitialized
+#KBUILD_CFLAGS += -Wno-maybe-uninitialized
 endif
 
 endif
