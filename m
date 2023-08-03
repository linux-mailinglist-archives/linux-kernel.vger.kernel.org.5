Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B69A76E660
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjHCLIy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235829AbjHCLId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:08:33 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B458B3AA0;
        Thu,  3 Aug 2023 04:06:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe0c566788so1441820e87.0;
        Thu, 03 Aug 2023 04:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691060784; x=1691665584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zXu7inCZnjemglS3ZAdUiIifz464S2TFKVJqbs2kCYw=;
        b=EEyQkRCWgtSF0AifYVPMWwUzRpHA16eokdlqzUdGBJTt8/Yi+NlcGLtvHRGSchF/7I
         wuvjk4CiC40CSXfzwbUZo8HjZ4XrdAtin2sTINZXIY46N/t7acUNfoLgqFYZAWXguqRV
         jPfc7InfO6KYDfI7Fl1I5ON5KC7iuUhcNThgxSq8HUCbknUFfcOsKfVD2vSKavAqgZDk
         CClINj9py+YdVsJxK5/m90mc9jLYZeHkLKUl8+o2lU0SsYpKlIJ2BmOR2M+VdTuifDs3
         Z9s4OQv6lCHtetdnlvCXkCFiZy9gtNfBa3BV9mI+dmVGB2f0MdZR0rpB8oCK4tmI6Lyj
         oj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691060784; x=1691665584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXu7inCZnjemglS3ZAdUiIifz464S2TFKVJqbs2kCYw=;
        b=B5WAU17JZYvxBd/nJOgUw/77GBY5GgFwE4O35msHF8oZiMnkfHkA6VQqLLQHre1Ku5
         4vGrnQgCgUBfl8mGDpOKfaj2NBW7c1kotWhvyubmkXxtkgzceXUfxTVf9ERH/qG0RdcC
         fD2phrPHliFh5cotTQ5A4jeY+9nboXkzc5aKQVTSMECcBJvqGc5s62auMQqfC+IzJq7k
         NFcYJU/jEVnEN6bvfJ1bVCsK4vxy2tP/Em7OQEHzT8wwcz/LwaQibmV+oVwslx988mlf
         dqPhsUxC7VhXlm6edz+PHjAkuGEw4KrKMTf8fgEk4fyc6dTTfP2aWnyB5vSushY1BkAh
         WrGw==
X-Gm-Message-State: ABy/qLYXAvymia5C1Aor5QkqBFcClOOB8Zo1AXKxT11rEiVqqDR+nci9
        YCIb2NqqSn6z2VFwiq2kvZnYZ69X5EVAwXmW+XY=
X-Google-Smtp-Source: APBJJlHwYIWcZbS9oAz83v/SlSb5rXIAM+6hK9FfjfNczXplugVL2wp86lTFpptbVcBjVD3299vi7HgR/3qaYiBbMFg=
X-Received: by 2002:a19:9102:0:b0:4f9:51ac:41eb with SMTP id
 t2-20020a199102000000b004f951ac41ebmr6178816lfd.16.1691060783927; Thu, 03 Aug
 2023 04:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083352.1585-1-zegao@tencent.com> <20230803083352.1585-4-zegao@tencent.com>
 <20230803085342.GG212435@hirez.programming.kicks-ass.net>
In-Reply-To: <20230803085342.GG212435@hirez.programming.kicks-ass.net>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Thu, 3 Aug 2023 19:06:12 +0800
Message-ID: <CAD8CoPAgqmgu+M6c1oEJBWq0ScmRsExDtKDi0dGabOo1OK0y+g@mail.gmail.com>
Subject: Re: [RFC PATCH v6 3/5] sched, tracing: reorganize fields of switch
 event struct
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 4:54=E2=80=AFPM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, Aug 03, 2023 at 04:33:50AM -0400, Ze Gao wrote:
> > Report prioritiy and prev_state in 'short' to save some buffer
> > space. And also reorder the fields so that we take struct
> > alignment into consideration to make the record compact.
> >
> > Suggested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Signed-off-by: Ze Gao <zegao@tencent.com>
>
> I am really getting fed up with this. This again doesn't list any
> reasons on why this is a sane thing to do.

Lesson learned from Steven's reply,  Will reorganize the changelog.

Thanks for pointing this out.

Regards,
Ze
