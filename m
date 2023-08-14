Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1E977C382
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjHNWcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjHNWcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:32:10 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA88171F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:32:08 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-40a47e8e38dso50171cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692052327; x=1692657127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0v4FnmqJUNHFxpcdGxWVG1RSHYWgI5Vlaomsgih4R4=;
        b=vKKN7+oMq72bqWVomalazt5YNByN/nNk2Dn7lmw11mJVlFXhkK9asfziYOw830m02L
         2yfuwv88wcDeISRa9AEMzKyVhg3mwV1VTm+JEyghkJV3wdXdlprPw4D67PbSzWSnAG/9
         XMdrXJCoI2UDWEMojTDEomri+NmoePXQ5wZ3Nz+v8pa829xl4lC5KElnB0oaSdyEFUzO
         Tsd6JR3yfsf93URH4IA2U8MbavWtq9YHtA6dgMxgVDPuyDRyPihL1UHgwbqsuH6VnY22
         46TzxTAL+uQ9pGHI/34aLGEjqp8PeVSjxdSDoFmbvL6P6+a/DXnFEC3oPPfPadQWrhtG
         Eeow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692052327; x=1692657127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h0v4FnmqJUNHFxpcdGxWVG1RSHYWgI5Vlaomsgih4R4=;
        b=cGF4QJB8FPPOeCZWOw985E96oy19x+kAbijFGss4wokbLuyEyiTZRaRIG7I862iQHI
         QQEhFRF8xNuJi10KWbqBSMJeN+JNU3Fjjj+5jD0I8PQJIlsCAuqtKHDzaJ5QEgAodTrX
         AzqQTRzSQoGIQ+sVERKGfA7Pyi4o9bdKja6/7CYVnxk1iwnLFhqAjPc+i7m9otQ7XLF+
         79tC2EN3UfHS6Sqw6FttJFWiTQPEnMbuhU/UV5wCLckUQZkByoAvX6P4EigJmnY7A2bt
         o4wUvE5tIUC59uDifnZl5lM8qoFM8RdjKEPNStzprQ0Mwim2X+upVtYB3ALhY4LHahKv
         KZZQ==
X-Gm-Message-State: AOJu0YwLXuuo0EC3HJS7Uwj2WCa+5OUzSIxLxjO82g04zY2Dwr1mVafQ
        LYFZUZmeNogJnxADrf0B4XWjrb/poW8LpTFQdoFXqA==
X-Google-Smtp-Source: AGHT+IFCpOH67poqOkqhXuiGRzJSIHcyEgDSVGrJ9l31Y+IwX24BR/s2XSse/ekN9tMDP2fZKzGzXF3ueh37FSr1uME=
X-Received: by 2002:a05:622a:10d:b0:3f4:f0fd:fe7e with SMTP id
 u13-20020a05622a010d00b003f4f0fdfe7emr691907qtw.3.1692052327482; Mon, 14 Aug
 2023 15:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <1691394685-61240-1-git-send-email-renyu.zj@linux.alibaba.com> <1691394685-61240-4-git-send-email-renyu.zj@linux.alibaba.com>
In-Reply-To: <1691394685-61240-4-git-send-email-renyu.zj@linux.alibaba.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 14 Aug 2023 15:31:55 -0700
Message-ID: <CAP-5=fXFZffdRMFH+aFzFech2pjbfYyQ+fx+E-YnfMBHifD4gw@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] perf jevents: Support more event fields
To:     Jing Zhang <renyu.zj@linux.alibaba.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 7, 2023 at 12:51=E2=80=AFAM Jing Zhang <renyu.zj@linux.alibaba.=
com> wrote:
>
> The usual event descriptions are "event=3Dxxx" or "config=3Dxxx", while t=
he
> event descriptions of CMN are "type=3Dxxx, eventid=3Dxxx" or more complex=
.

I found this difficult to read in relation to the code. Perhaps:

The previous code assumes an event has either an "event=3D" or "config"
field at the beginning. For CMN neither of these may be present, as an
event is typically "type=3Dxx,eventid=3Dxxx".

I think the use of the name "type" here is unfortunate. It conflicts
with the PMU's type as defined in perf_event_attr.

In general I think the jevents.py code needs improving, the
event_fields dictionary is convoluted, we shouldn't be afraid to
change the event json for example to get rid of things like ExtSel, we
should really ensure the formats in the events are valid for the PMU
they are for.

> $cat /sys/bus/event_source/devices/arm_cmn_0/events/hnf_cache_fill
> type=3D0x5,eventid=3D0x3
>
> When adding aliases for events described as "event=3Dxxx" or "config=3Dxx=
x",
> EventCode or ConfigCode can be used in the JSON files to describe the
> events. But "eventid=3Dxxx, type=3Dxxx" cannot be supported at present.
>
> If EventCode and ConfigCode is not added in the alias JSON file, the
> event description will add "event=3D0" by default. So, even if the event
> field is added to supplement "eventid=3Dxxx" and "type=3Dxxx", the final
> parsing result will be "event=3D0, eventid=3Dxxx, type=3Dxxx".
>
> Therefore, when EventCode and ConfigCode are missing in JSON, "event=3D0"=
 is
> no longer added by default. EventIdCode and Type are added to the event
> field, and ConfigCode is moved into the event_field array which can also
> guarantee its original function.

A useful test can be to build with JEVENTS_ARCH=3Dall and confirm the
before and after change generated pmu-events.c is the same.

> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>  tools/perf/pmu-events/jevents.py | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index f57a8f2..9c0f63a 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -275,12 +275,6 @@ class JsonEvent:
>        }
>        return table[unit] if unit in table else f'uncore_{unit.lower()}'
>
> -    eventcode =3D 0
> -    if 'EventCode' in jd:
> -      eventcode =3D int(jd['EventCode'].split(',', 1)[0], 0)
> -    if 'ExtSel' in jd:
> -      eventcode |=3D int(jd['ExtSel']) << 8
> -    configcode =3D int(jd['ConfigCode'], 0) if 'ConfigCode' in jd else N=
one
>      self.name =3D jd['EventName'].lower() if 'EventName' in jd else None
>      self.topic =3D ''
>      self.compat =3D jd.get('Compat')
> @@ -317,7 +311,15 @@ class JsonEvent:
>      if precise and self.desc and '(Precise Event)' not in self.desc:
>        extra_desc +=3D ' (Must be precise)' if precise =3D=3D '2' else ('=
 (Precise '
>                                                                   'event)=
')
> -    event =3D f'config=3D{llx(configcode)}' if configcode is not None el=
se f'event=3D{llx(eventcode)}'
> +    eventcode =3D None
> +    if 'EventCode' in jd:
> +      eventcode =3D int(jd['EventCode'].split(',', 1)[0], 0)
> +    if 'ExtSel' in jd:
> +      if eventcode is None:
> +        eventcode =3D int(jd['ExtSel']) << 8
> +      else:
> +        eventcode |=3D int(jd['ExtSel']) << 8
> +    event =3D f'event=3D{llx(eventcode)}' if eventcode is not None else =
None
>      event_fields =3D [
>          ('AnyThread', 'any=3D'),
>          ('PortMask', 'ch_mask=3D'),
> @@ -327,10 +329,13 @@ class JsonEvent:
>          ('Invert', 'inv=3D'),
>          ('SampleAfterValue', 'period=3D'),
>          ('UMask', 'umask=3D'),
> +        ('ConfigCode', 'config=3D'),

This loses the int and potential base conversion of ConfigCode.
Clearly the code was taking care to maintain this behavior so I
suspect this change has broken something. JEVENTS_ARCH=3Dall should
reveal the answer.

> +        ('Type', 'type=3D'),
> +        ('EventIdCode', 'eventid=3D'),
>      ]
>      for key, value in event_fields:
>        if key in jd and jd[key] !=3D '0':
> -        event +=3D ',' + value + jd[key]
> +        event =3D event + ',' + value + jd[key] if event is not None els=
e value + jd[key]

Perhaps initialize event above to the empty string then:

if key in jd and jd[key] !=3D '0':
  if event:
     event +=3D ','
  event +=3D value + jd[key]

Thanks,
Ian

>      if filter:
>        event +=3D f',{filter}'
>      if msr:
> --
> 1.8.3.1
>
