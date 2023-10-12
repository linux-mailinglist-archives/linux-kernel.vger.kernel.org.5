Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ECB7C74A5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441986AbjJLRXW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 13:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379618AbjJLRWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:22:36 -0400
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042B1D41
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:22:06 -0700 (PDT)
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-564af0ac494so914836a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 10:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131325; x=1697736125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YY4T3+RDbK7Kvqf4KCrP0pQCmVjvzxG/9nuXoSoSvNk=;
        b=mJCxbZBRGAMGL1ljxk1XYH/MgODqibEgV2QGm4SrTTfk9/gtV1sTrWsKYBSkm7uUO2
         lY7rgCumvT3UBiQrKRuCz7NCu99aYrkVqY03Kw+6GjhogahMfbJ0nLFhN9xUYtDs0u6U
         lgtrija1oHM78T8nT1AHo/0V8nLfzaSFAobxdZNqvtKbQ4h4yDSMQFPCSmmvA5eb7RQf
         MdSA59QbPZJX0iDeBg6Sk61bwIGvhtDoxuifFhEO1uI1LplLEmi2/RRzbgnwu0FTJYVr
         QtSzTO0qk1Xipi8T0hJYWTsh/WzqWjRbHi+03Hftvok+q7KhjvUexKYFfuBOGWOotFJq
         0EFw==
X-Gm-Message-State: AOJu0YxwRMwqKM6ef4NZZ07f7jaHhmUxoq2BWkS6P7Wq61z8Pgswp+id
        pLKSuPjiRuXZ7vNKCvIyZPZ941qkpYNKrefBHxA=
X-Google-Smtp-Source: AGHT+IGucybg/cxPafLX1Z/37g3rqH9XrRN7jWGA/eLtBRmZELOmoBo8KCg8FEWO4Ew3auxOkAAijcnCv/Ts2mdiK3I=
X-Received: by 2002:a05:6a20:3d8b:b0:130:d5a:e40e with SMTP id
 s11-20020a056a203d8b00b001300d5ae40emr24657586pzi.7.1697131325358; Thu, 12
 Oct 2023 10:22:05 -0700 (PDT)
MIME-Version: 1.0
References: <ZR6+MhXtLnv6ow6E@kernel.org> <CAP-5=fWtX3_bmBHbeEskmM4rzX-r1LAhE8_kaYy8WueUpKCdUw@mail.gmail.com>
In-Reply-To: <CAP-5=fWtX3_bmBHbeEskmM4rzX-r1LAhE8_kaYy8WueUpKCdUw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 12 Oct 2023 10:21:54 -0700
Message-ID: <CAM9d7cjYRbdmEuqob8wC4Ca9DSpg+fCv85jWnuOZQ8grDcJnWQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf build: Add missing comment about NO_LIBTRACEEVENT=1
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 8:45 AM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Oct 5, 2023 at 6:46 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > By default perf will fail the build if the development files for
> > libtraceevent are not available.
> >
> > To build perf without libtraceevent support, disabling several features
> > such as 'perf trace', one needs to add NO_LIBTRACEVENT=1 to the make
> > command line.
> >
> > Add the missing comments about that to the tools/perf/Makefile.perf
> > file, just like all the other such command line toggles.
> >
> > Fixes: 378ef0f5d9d7f465 ("perf build: Use libtraceevent from the system")
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Applied to perf-tools-next, thanks!
