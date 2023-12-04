Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00C38040E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjLDVOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbjLDVOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:14:30 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BABFF
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 13:14:36 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50beed2a46eso837e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 13:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701724475; x=1702329275; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC3Kqwq0MMmfCoFQwZgAsJVop+/+8BNQbF/H1UQSrUk=;
        b=J2/rlFDhgONMIXUDqpLdS4TQWKgnZarLU0gr6cz+RN8nkSezO7l1iXgTt6M6IxsokO
         3adCAlWhq3jMoD2XHdSFGZ4cE5S1EECTwjhoLR0ssOd6FKa7uT3+rZ7rW8mmxwPH6fJ1
         TdfIPWLG5SiSrjnjtqNAu9Z+Iq/GkqVuwnuZ2WnJfO8qAIPM/4btBdMHCqqbmRX15iRy
         ET9wM4cVKtBV/U1cbMlcUwuz5vSbPk3ulBFcykWZfIu3kw0DhyQQf5955SQOEUlD1sYu
         /t7+pHNwMq5amjzQAdrS2RxF2sHbtFN80Sulii6vGBoxx5OhDiTiC/71MvfXnYg6k8m3
         koTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701724475; x=1702329275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HC3Kqwq0MMmfCoFQwZgAsJVop+/+8BNQbF/H1UQSrUk=;
        b=eUJ/hwENa347Ap7w2Dw6lTzKbMlQZlC5Js1yR1ycqzGbSsFARpgFLySvUoaTecZwEE
         7sGVceiqyfudb/+5l81OOvlC03Tc3AXz63hKNuE35xnsH3BuFbITtE04Bp0+qiWNoVOV
         0XLkI3yPb9il/z7L6wIRqRMq7RrSiyeAUo2d54GVHKS4SGApOGPNOgrwOorF3uYbijhG
         PuuI/6PsLxgzRbMeQikRwVbxqJsPM9+mx7QJLrg+bKYLH9t3V4ZM2S6eRPh3iFgqQMaJ
         e+VN8sMeTHR483OfnsuFnr2fOoFva0luW7CB8jdJL0GJoLqLIOnLr2EkVYsiMW+U0alN
         RVKQ==
X-Gm-Message-State: AOJu0Yzcxo/VZhTnINSOaYj0br5Ek4sT7SE33s3OKD9zn3Htf2wafm92
        7QNJnwcG+G9ow0tHuoVUK63WKt+MuYDhyl1Srfkgvg==
X-Google-Smtp-Source: AGHT+IHFNQl9WEbRcWJgH4WIhG5b7q61jmODDxGI8iaboRfnh21mH+fe1Ktul9AFsgSTRW5UVuMiGdR5g8dxC5LoCTU=
X-Received: by 2002:a05:6512:12c4:b0:50b:fc76:42c with SMTP id
 p4-20020a05651212c400b0050bfc76042cmr87811lfg.2.1701724474909; Mon, 04 Dec
 2023 13:14:34 -0800 (PST)
MIME-Version: 1.0
References: <20231201235031.475293-1-irogers@google.com> <20231201235031.475293-9-irogers@google.com>
 <CAP-5=fUtoi7ynQ-x_7rrv_vYoTZfS_14COA1MskOFVXJ_jCDew@mail.gmail.com> <ZW420ecpaSjwykny@kernel.org>
In-Reply-To: <ZW420ecpaSjwykny@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 4 Dec 2023 13:14:23 -0800
Message-ID: <CAP-5=fXq2CTwSO8QVRdgz2uR73DrGU9qD3z5gPPD3ZEncsn36w@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] perf tests: Add option to run tests in parallel
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        James Clark <james.clark@arm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2023 at 12:30=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Fri, Dec 01, 2023 at 06:06:12PM -0800, Ian Rogers escreveu:
> > On Fri, Dec 1, 2023 at 3:50=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > By default tests are forked, add an option (-p or --parallel) so that
> > > the forked tests are all started in parallel and then their output
> > > gathered serially. This is opt-in as running in parallel can cause
> > > test flakes.
> > >
> > > Rather than fork within the code, the start_command/finish_command
> > > from libsubcmd are used. This changes how stderr and stdout are
> > > handled.
> > >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> >
> > Actually, I think this patch needs more work. The verbose output is
> > degraded and missing in some cases. Suggestions on how to fix welcome.
>
> I'll think about, but to make progress I think the first 8 patches in
> this series can be considered now?

That would be great. Thanks!

Ian
