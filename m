Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B32750F27
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjGLRB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjGLRBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:01:22 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A269C136
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:01:21 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-403b622101bso8071cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689181281; x=1691773281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=do8WCqThbZfqwQjMvP5MGRLXecaFpfNRAFM5GCHsjdo=;
        b=G+kohK0xIgMPHQ3+5ncibyhuTwK6hxATxDANqz12TOSvN0edR3aq0H2AK/C1mm64/j
         eE6nAjp0TMl4AyeJbNffIsUnLB5yNlQHXm/8EqH2TcxRLRyFIKzqYYGQ3zKcS0lH6MuY
         PoznUsARm2aJGffc2UtKRQIzEnZNvV7lIJzRXxxu2tY8ROsOdshaYBaqfdgTr8MVSGL4
         doslZ0IKqW9j2ni0skHG80apYw5V4tZPBEtLptV3C0/p4n8n5M18nhf4KDTQzQGCrla6
         k4SY6UGSuJga2MV0TI5AXEpEqJJzFYYaIJkASzfJX+gcTq8rKW+FSXLA+K1wWX0Y13SP
         HPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689181281; x=1691773281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=do8WCqThbZfqwQjMvP5MGRLXecaFpfNRAFM5GCHsjdo=;
        b=YAMgIICHhvd8O01QMN1Qd52QUUt5Za1XHVwT0b31R7ibuF6rH9196LvbsZ4CVq5TvW
         OVllSFszBu4KbvHiAil5Xdyuycnwn/Gu0qE6PxmfreLgHlQnlJlyP9qq5xdprSn0yH/t
         0HmbhHvHCIpDlnzSxpQQTlGs/Bg3fLsrjGg+0IlbMmydAwfQ+zE2YbjDG2jdPXQXT69F
         gYk1Mw5dsgEP9VznBHuaPPb9KnKozK9CJlg4WlnBXCrbyCjDdzggFZP5mVoG1i7xeVw8
         G+EKC7ZgjrNcG2x5Lc4jl6EDlfojOwmfr8fbCq5pp6jAm6RjqJJrnYeKBWy0l1zKYSIl
         dT5g==
X-Gm-Message-State: ABy/qLb8Q5nbq9S1g66Zdxcmbp+A2MmuYS/SjkvdlqMzWeHf7BZeaZzA
        1uz5KtlieEyn53dCiNKX2WqJilwOozCaMdZKzDjt5w==
X-Google-Smtp-Source: APBJJlHjptCdg/MHrJtHqTVPJJ5f0n/BrCuENF8jJ6KVPMtOWPHMp+Tj+JC+fFU89bd66LbJ+CNT4N5ukOw36jw+tpU=
X-Received: by 2002:ac8:59ce:0:b0:3f8:8c06:c53b with SMTP id
 f14-20020ac859ce000000b003f88c06c53bmr360570qtf.0.1689181280722; Wed, 12 Jul
 2023 10:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689024635.git.anupnewsmail@gmail.com> <ba55bf712cc27494635ca0bb23a21b42529c9327.1689024635.git.anupnewsmail@gmail.com>
In-Reply-To: <ba55bf712cc27494635ca0bb23a21b42529c9327.1689024635.git.anupnewsmail@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 10:01:09 -0700
Message-ID: <CAP-5=fUqKZkuODXTez+Dk+RqTmh+NaeRBun65onG-yByUJOnVA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] scripts: python: Extact necessary information from
 process event
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 4:10=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com=
> wrote:
>
> The script takes in a sample event dictionary(param_dict) and retrieves
> relevant data such as time stamp, PID, TID, thread name. Also start time
> is defined.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  .../perf/scripts/python/firefox-gecko-converter.py  | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools=
/perf/scripts/python/firefox-gecko-converter.py
> index 5b342641925c..765f1775cee5 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -21,8 +21,19 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
>  from perf_trace_context import *
>  from Core import *
>

It'd be nice to have a comment here, perhaps:
# The time stamp from the first of the time ordered events.

> +start_time =3D None
> +
>  def trace_end():
>         pass
>
>  def process_event(param_dict):
> -       pass
> +       global start_time
> +       # Extract relevant information from the event parameters. The eve=
nt parameters
> +       # are in a dictionary:
> +       time_stamp =3D (param_dict['sample']['time'] // 1000) / 1000
> +       pid =3D param_dict['sample']['pid']
> +       tid =3D param_dict['sample']['tid']
> +       thread_name =3D param_dict['comm']
> +
> +       # Assume that start time is the time of the first event.
> +       start_time =3D time_stamp if not start_time else start_time

I appreciate that this is one line, but it takes some getting your
head around that start_time is being assigned to itself in the common
case. I think this would be more readable as:

if not start_time:
  start_time =3D time_stamp

Thanks,
Ian

> --
> 2.34.1
>
