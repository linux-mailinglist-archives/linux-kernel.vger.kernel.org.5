Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F96750F36
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbjGLREO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjGLREL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:04:11 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0950C1BD6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:04:10 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4036bd4fff1so13681cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689181449; x=1691773449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AqtCYATG8ChMapzp5kNLa9Py9zbnEsVcqTU7Ga9LoGc=;
        b=OqdAti8OKkViVwVuE8lSLXuosWAZC4YxyaEzBVjKFo6TVWyxahb0+Hswoyt1XV482L
         w8pxK2aWUUBMLj4T7NywMW3+OpubE1uliG+eQFEjzQaG7QRN5ky835S29FcwAb1EmI1R
         6/afyR0w9CQSJqZyqvndjhAf0bKkxSE2SvMpHkGqk5kCCfDdtwo38tUKxCMyWj/kitw7
         UA8WIl+e7xIjlqIOZho234gBXDEtuVYh4CKKHOMINX5G0LotYdDP5yqvVXXSrFXaqsyA
         fvbCwzAqPGDVL4GrHTSHm8+Wf+sMcvW27MR5zixM2vThLjHJBDhAsxgpRPlKtxyd90pX
         QcIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689181449; x=1691773449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AqtCYATG8ChMapzp5kNLa9Py9zbnEsVcqTU7Ga9LoGc=;
        b=Z5VRijXePY3yq9o3fkxk9eTHrJJTFIpIBx3FaLGATq+cjj3OyUc2O/1JWfQcycWYrv
         7U1/ivbBjfwKp3Ovfg7+tiC4CmHYIGFuV8kFD9f/XDB/YtIeZAOQxo4A2ay7FBx6+dS6
         CFI7vOTnRQ2qj5r2hPgwfVvqe2X22eDGgHRkyDQnfTxhT3dUUtp4U/fQ2R0F7pPUW6GE
         3fzFTIXM9F2fDchmCp0GSt+eZFtW64h/QHkgkPzyShNP2+9yqbyzkWGQxJtQDz638n0v
         qk3RInfNr32WOvEBcK8Vd0yPMHzXTX4gaZsmRgICntCljzpwOsAPyBPG25JINA2ho0L3
         0xcQ==
X-Gm-Message-State: ABy/qLarK+wvUhnDyLi7db8FuJmsb7daARdlOSezy7w2zivVpEQI3rmI
        0w987lG8YfT2jX/rKce/zMYSX0t2dp7jGkW4gf+HUkiHFtd0kuZx8Io=
X-Google-Smtp-Source: APBJJlFi8FpP+M9rLTGg/d93Gu+4o83eJViGV5QjH1U0xG4l7m9dxCrVG8t2hJhKXb2BrrEQEjKHZx9hSpIhKmCwRik=
X-Received: by 2002:a05:622a:1805:b0:3ef:3361:75d5 with SMTP id
 t5-20020a05622a180500b003ef336175d5mr281741qtc.11.1689181449011; Wed, 12 Jul
 2023 10:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689024635.git.anupnewsmail@gmail.com> <ba55bf712cc27494635ca0bb23a21b42529c9327.1689024635.git.anupnewsmail@gmail.com>
 <CAP-5=fUqKZkuODXTez+Dk+RqTmh+NaeRBun65onG-yByUJOnVA@mail.gmail.com>
In-Reply-To: <CAP-5=fUqKZkuODXTez+Dk+RqTmh+NaeRBun65onG-yByUJOnVA@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 10:03:57 -0700
Message-ID: <CAP-5=fW0DT+JkU07K8brv2O_T6=hTM3SQMoji0o2rnsF6w+Y_Q@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:01=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Mon, Jul 10, 2023 at 4:10=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.c=
om> wrote:
> >
> > The script takes in a sample event dictionary(param_dict) and retrieves
> > relevant data such as time stamp, PID, TID, thread name. Also start tim=
e
> > is defined.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > ---
> >  .../perf/scripts/python/firefox-gecko-converter.py  | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/too=
ls/perf/scripts/python/firefox-gecko-converter.py
> > index 5b342641925c..765f1775cee5 100644
> > --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > @@ -21,8 +21,19 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> >  from perf_trace_context import *
> >  from Core import *
> >
>
> It'd be nice to have a comment here, perhaps:
> # The time stamp from the first of the time ordered events.
>
> > +start_time =3D None
> > +
> >  def trace_end():
> >         pass
> >
> >  def process_event(param_dict):
> > -       pass
> > +       global start_time
> > +       # Extract relevant information from the event parameters. The e=
vent parameters
> > +       # are in a dictionary:
> > +       time_stamp =3D (param_dict['sample']['time'] // 1000) / 1000
> > +       pid =3D param_dict['sample']['pid']
> > +       tid =3D param_dict['sample']['tid']
> > +       thread_name =3D param_dict['comm']
> > +
> > +       # Assume that start time is the time of the first event.
> > +       start_time =3D time_stamp if not start_time else start_time
>
> I appreciate that this is one line, but it takes some getting your
> head around that start_time is being assigned to itself in the common
> case. I think this would be more readable as:
>
> if not start_time:
>   start_time =3D time_stamp

I believe the events are guaranteed time ordered in perf script. The
ordered_event logic handles this, but I likely haven't got a full
grasp on all the corners of it. You can always assert the behavior
(comments with guarantees :-) ):

assert start_time <=3D time_stamp, "Events aren't time ordered"

Thanks,
Ian

> Thanks,
> Ian
>
> > --
> > 2.34.1
> >
