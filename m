Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2C17C7400
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 19:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379584AbjJLRV0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Oct 2023 13:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347338AbjJLRVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 13:21:22 -0400
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFADBB;
        Thu, 12 Oct 2023 10:21:21 -0700 (PDT)
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1c9e072472bso7127505ad.2;
        Thu, 12 Oct 2023 10:21:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697131281; x=1697736081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEMxWrFoPYtcFRmMG5By36CMEOzbiNcPHSa8TUmJqE8=;
        b=DrxxKj7kYNpDgtquEAeZKiy+DTAiH1sbual6z1lRv4rf/Iqh4tpFCyM0BmpYGV4ePx
         dzLMaI1SPX2ox9W+HfaiHuXCi9B8zNHCKms0aF+KxlbS/G+OQX/ke0v122LZLrSMDy6G
         E2jux2sDM7MTLG+EucWCk5ySxgQkZ9qJmj5MveVp7dg0pgPQbDosueb183FFy5yCHUGg
         vn0qFc2YwG/lzScwCWTROi4BXI8ZGSeqnLpDfPtOsN7wR+bk7vVc9FmazEpJISl33U55
         T5XrO0kcgMF0GUyiZjmIODq3yarWZ8GNpszasTy+5veIUMjZvXJtqwazuWVHmUneOEm6
         o7hg==
X-Gm-Message-State: AOJu0YzRmnM6aneMW3oocRu93117ZJZSQiEs7iopgRu2m7bgRgSadEX9
        TtcvlVLb1oZxDw0uN3pv+jm/Y+/w3Z2m8BDl7KMO0c2I
X-Google-Smtp-Source: AGHT+IFAWfFlLWtnAbpZxdqOP0mgDeUFhVOcMBZ4fC2zjYsg2bfBWcUKqw5FRC35Ix30n0cy1X+AgRGbMUFfIVaE9rQ=
X-Received: by 2002:a17:90b:e11:b0:27c:f1f8:261f with SMTP id
 ge17-20020a17090b0e1100b0027cf1f8261fmr7322289pjb.20.1697131280729; Thu, 12
 Oct 2023 10:21:20 -0700 (PDT)
MIME-Version: 1.0
References: <ZR66Qgbcltt+zG7F@kernel.org> <CAM9d7cgnB0jLTz+PNiJgkJL_LU5Y6oQX9HALJEGqh3v_ngPzxQ@mail.gmail.com>
In-Reply-To: <CAM9d7cgnB0jLTz+PNiJgkJL_LU5Y6oQX9HALJEGqh3v_ngPzxQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 12 Oct 2023 10:21:09 -0700
Message-ID: <CAM9d7ciNkQGOdJUV+h=XFvFUb7pyABO8SnMiyp8iSYTS_a4x+Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf symbols: Add 'intel_idle_ibrs' to the list of
 idle symbols
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

On Thu, Oct 5, 2023 at 10:16 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> Hi Arnaldo,
>
> On Thu, Oct 5, 2023 at 6:29 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> >
> > This is a longstanding to do list entry: we need a way to see that a
> > sample took place while in idle state, as the current way to do it is
> > to infer that by the name of the functions that in such state have
> > more samples, IOW: a hack.
> >
> > Maybe we can do flip a bit in samples that take place inside the
> > enter/exit idle section in do_idle()?
> >
> > But till then, add one more :-\
> >
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > cc: Frédéric Weisbecker <fweisbec@gmail.com>
> > Cc: Ian Rogers <irogers@google.com>
> > Cc: Ingo Molnar <mingo@kernel.org>,
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Applied to perf-tools-next, thanks!
