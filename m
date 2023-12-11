Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08F580D3A5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344547AbjLKRX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:23:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343918AbjLKRX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:23:57 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FDFABD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:24:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso13767a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 09:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702315442; x=1702920242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fa+2d1g1YuhXldTtmH+vTSWA87IfsVeC6viX1KyDnNc=;
        b=IH6VgV1t7720oExKmHhIOSizTbPv2rYrxJYZDqh3Uk/P20ewkb7oGKJzaq22FLLRFg
         o0T0dWQtTpQdOCYWQZo0o101wcxmTLivoEm/DH9BSDM7i5bjaz4bqeODhmq3XJLRqkgN
         dhtT3rOrpLNlySLwKPsZkq5mIOvP94cql5zAPHU0XIiuMFt802yc095rCDKVtrn5d0rO
         Iu7J8sRpd5o0Fq46cK3N5DU76IVMhdm7YBq5RAoFoXxdUnhHcNR9iuFO89XI5W3s/Efv
         Jw8PJG+vxvpz+Da+yymrfN1OBHBFXuc4VGX4Ys11BoUmVYlZBD/HZCc160+L5hHgiSYv
         uNbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702315442; x=1702920242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa+2d1g1YuhXldTtmH+vTSWA87IfsVeC6viX1KyDnNc=;
        b=okv8CtN8o/MH6F3ktH08g1R0gB8dblmb4MrfW82jS4bNpHVAQtVcq6rE2VSlZFRw4D
         2hOY5XLufYJAM8m930Hkavx0mIexzhzMe+Ecx/EWM3Z6po1+lIjrFaTdVDtOv7Lh85aH
         KLPvxfA8U0F0wMc2MjB5tWBcYXHSINaukZhB8NDPjEb/BXy3mlulGr+kUz44GJU/QQ26
         +0mDvY+tm4FRRLczrDbFeuCI5seUISF1i0puvI8VLdi+0XAZcbmSoTqqDxB2Q3etd+LL
         2mxkAAm/cQw5RFx+bseH7UZoMqARqYKa41pkyahHAPwkc4NrbppmYaFxc+vNBaquMfO2
         fV7g==
X-Gm-Message-State: AOJu0YxV21ZnKuaZej2DbBc4zZ/CQflGOqTwnVs91I1hWbYqtvTz+FLD
        RB10dZjgIdlI0zA0D2enLLE2KijtyPdCQorKjGQVlZcD5+neYw6O4FdrtEc7
X-Google-Smtp-Source: AGHT+IF9+iN+82W54Dm/WqWBY+mutVQMhk2qnAOdPLsLwb824cJcgEvNeaBrjPsYJvv8bdUZEAA5BOW9CrRqjFRm5GM=
X-Received: by 2002:a50:c101:0:b0:54b:bf08:a95f with SMTP id
 l1-20020a50c101000000b0054bbf08a95fmr209926edf.6.1702315441731; Mon, 11 Dec
 2023 09:24:01 -0800 (PST)
MIME-Version: 1.0
References: <3a8c66ec-537d-4e29-bf08-226dd41b08aa@linux.intel.com>
 <877clnz4bh.fsf@vuxu.org> <CAP-5=fVKEU1SesA52_jdR1OFAKF6Q6mrXjS+3+cibO6c=Or=6g@mail.gmail.com>
In-Reply-To: <CAP-5=fVKEU1SesA52_jdR1OFAKF6Q6mrXjS+3+cibO6c=Or=6g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 11 Dec 2023 09:23:49 -0800
Message-ID: <CAP-5=fWdJYu9pf7d5ytvV7FNJTOK5Hr2mYcbDDPWO9zJMbPtdQ@mail.gmail.com>
Subject: Re: 'perf top' broken on intel hybrid systems
To:     Leah Neukirchen <leah@vuxu.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 9, 2023 at 9:26=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Sat, Dec 9, 2023, 12:14=E2=80=AFPM Leah Neukirchen <leah@vuxu.org> wro=
te:
>>
>>
>> > The error is because the perf top always tries to open an event on the
>> > user_requested_cpus, which are all CPUs by default.
>> >
>> > Something as below should fix it. For hybrid, open a PMU event on an
>> > unsupported CPU should be error out.
>> >
>> > diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
>>
>> This fixes "perf top" on my i7-1355U.  It would be great if you could
>> get this patch into upstream and stable branches.
>
>
>
> I'll try to take a look ASAP. As we don't need this for record there is s=
ome existing logic that perf top is clearly missing. We should also have a =
test on perf top.

So for stat and record there is a call to evlist__create_maps:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/builtin-stat.c?h=3Dperf-tools-next#n2730
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/builtin-record.c?h=3Dperf-tools-next#n4210

In evlist__create_maps we do perf_evlist__propagate_maps and that will:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/lib/perf/evlist.c?h=3Dperf-tools-next#n43
```
} else if (evlist->has_user_cpus && evsel->is_pmu_core) {
/*
* User requested CPUs on a core PMU, ensure the requested CPUs
* are valid by intersecting with those of the PMU.
*/
perf_cpu_map__put(evsel->cpus);
evsel->cpus =3D perf_cpu_map__intersect(evlist->user_requested_cpus,
evsel->own_cpus);
```

I think the fix should be looking to do the same map set up in top as
stat and record, presumably there was a refactor and top was
overlooked. I'll try to address this and add a basic sanity test of
doing a few iterations of perf top on stdio, which would have been
sufficient to catch this.

Thanks,
Ian
