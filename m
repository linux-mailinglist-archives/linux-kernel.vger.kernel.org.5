Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC417CCB96
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344139AbjJQTCy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Oct 2023 15:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbjJQTCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:02:45 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD441133
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:02:32 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-27cfb84432aso4018883a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 12:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569352; x=1698174152;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mliy1n0MfjZOCRbYlPBz8zCL6vPpciSrV6843uynzdg=;
        b=FGUV9MZfhq6C0MEHAUViNJjUTcpoQC9QWB7ID1MzMV8u2aKspYZ9xBFpctwSwOdLcZ
         Mt9RRq7h2YWyYm3xnx/Mlqa36j+bILDmWrWNYMyhP3Kq+PR3iUup8Q0JwoQPhdwFdnwH
         p9aCNyfaNDvvb0jkYMyd5M+YaBaeVcpXzV2psCQ8BSYw+K3gj+63BuKDOD0blSZQqOHE
         mM9t/sll0kcJcgyw+2/CUAQJAULFwE6+qh+lWwrrlqk0JBN/n6NrR7GtUv78hELc/1Mj
         ZYfLANjnP8z8CyzJPgZsZGcN5MrEe2g4lozz9DM/c+2GGgz2UXh4i15qSPhqv6Qa/kB0
         bXPg==
X-Gm-Message-State: AOJu0YzA4EhM3QXwkVuXYKnooXutcWs16TsoaZ/K1i5/WzkZI8ykpJyi
        pqtM74CKalvLjjJAUpZE+EEsX0FLYu9/4useK0TWjxjE
X-Google-Smtp-Source: AGHT+IGRdAXjs1zd/tGK1E9WFXWhIGao1T9rig+P78Z7iyfvPL81kMTSGRW4e8V3Tp/tqUFdbegDEFo2HvE+eSl9N4Y=
X-Received: by 2002:a17:90a:cb09:b0:27d:1379:6271 with SMTP id
 z9-20020a17090acb0900b0027d13796271mr2845272pjt.46.1697569352071; Tue, 17 Oct
 2023 12:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <ZS7PIHUZfHcrfvi4@kernel.org>
In-Reply-To: <ZS7PIHUZfHcrfvi4@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 17 Oct 2023 12:02:20 -0700
Message-ID: <CAM9d7cjkFQU+dd8m8pq6-u6JruY9tFi_86ZyiQrXGL9js_vuuA@mail.gmail.com>
Subject: Re: [PATCH] perf build: Remove stray '\' before that is warned about
 since grep 3.8
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Oct 17, 2023 at 11:15 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> To address this grep 3.8 warning:
>
>   grep: warning: stray \ before #
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Makefile.perf | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 456872ac410df4c0..25d5ccaec22a44fe 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -361,7 +361,7 @@ python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT
>  ifeq ($(CONFIG_LIBTRACEEVENT),y)
>    PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)

Do we need to change it here too?  Otherwise looks good

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


>  else
> -  PYTHON_EXT_SRCS := $(shell grep -v '^\#\|util/trace-event.c' util/python-ext-sources)
> +  PYTHON_EXT_SRCS := $(shell grep -v '^#\|util/trace-event.c' util/python-ext-sources)
>  endif
>
>  PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBAPI)
> --
> 2.41.0
>
