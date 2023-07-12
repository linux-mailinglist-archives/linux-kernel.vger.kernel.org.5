Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D691750FE0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 19:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjGLRoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 13:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjGLRof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 13:44:35 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A7E1FD4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:44:34 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-403b622101bso22171cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689183873; x=1691775873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x75I9EAPBB5X8JrQCs3qwbk2FtMM8P9XHyZKY9VrwHo=;
        b=FcSq1Yrb7K+X1AnQD9Ks0JfnkfX+UObbanCcCa69KTVEkoB8PN10JetL52iyDWawf0
         D1ldw6PBJLp6weiTQxfHKLs+lw6sSthbYyhRns0t9bDOL2tTB2ghKBWHXUaSEmnGKEbI
         lJ8zjtL+4XUZjLSqWaUbzBmzp/0Iq2nFCTApElHUhyBUws3aEwtbKLDGJ6PKTdUiFArV
         BGaODOW8xHeTQyvelmRlxM0VW6cZP6LVHXCxNdkBLPVizY3+x+ZanewEbW5MlAjIFmsB
         L7ZsYsGgOfS9dv0wrNKrkYMtxeRVOfgxWX8PUYTQIo0oxy5M6T3N8amxZ5y08GqYHIki
         TBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689183873; x=1691775873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x75I9EAPBB5X8JrQCs3qwbk2FtMM8P9XHyZKY9VrwHo=;
        b=coYaM8b52+P812dWt84fCZqI4rSIEWCeoA0RNvDRh68bG4qJGkS3WCXG+dREvIihZw
         kgFsNktLwbHTlgdwLTRf61AdCmtjLH9kRjFsG5925JcralK/C7iHasiYfSU6tuTq8uzc
         sQwPU1hW+LMSxeqfNOA/hBx7O2gTRaQ/3Z7QutsmMOE4PjD2PjVDsphGY0nGmBmC/kTE
         cbI1wdzA7Y+kP46tgInasKzhqcwwMlP6h/BXql0Gpu0jllhamaWvmLIr51JGbh4eyo9S
         3iphRD9hACxB0K2I5Hx1LYerdIGOTMtOsR93TcO8Yg+mixh4hI/ajk8do/vUmO2fKeJm
         5HTQ==
X-Gm-Message-State: ABy/qLaupmuJIXZdsLOSeAyqr2cZqLlYd6o81MJgD0oFu2nrNnZ7MTZy
        4QzfTW0zcNRelb2AWxRnMBKwCv8IB/V7HU46IeHEmw==
X-Google-Smtp-Source: APBJJlHgqrbTuhReoH8BNugKwG1YnoIT7/6+KCzu+GIQiYo+7RAsTlMzd5UOXpXSdjxn1PHxAN6+BnpzACqcmXh7ceI=
X-Received: by 2002:ac8:5814:0:b0:3ef:404a:b291 with SMTP id
 g20-20020ac85814000000b003ef404ab291mr229808qtg.7.1689183872839; Wed, 12 Jul
 2023 10:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1689024635.git.anupnewsmail@gmail.com> <dd26619520465132d33dd84780859e6bf89133bf.1689024635.git.anupnewsmail@gmail.com>
In-Reply-To: <dd26619520465132d33dd84780859e6bf89133bf.1689024635.git.anupnewsmail@gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Jul 2023 10:44:21 -0700
Message-ID: <CAP-5=fVtE14SyCvkYCQgePm-5upAZYvU7AvkwcYXGLYBffko1A@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] scripts: python: implement get or create frame and
 stack function
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
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 4:15=E2=80=AFPM Anup Sharma <anupnewsmail@gmail.com=
> wrote:
>
> Complete addSample function, it takes the thread name, stack array,
> and time as input parameters and  if the thread name differs from
> the current name, it updates the name. The function utilizes the
> get_or_create_stack and get_or_create_frame methods to construct
> the stack structure. Finally, it adds the stack, time, and
> responsiveness values to the 'data' list within 'samples'.
>
> The get_or_create_stack function is responsible for retrieving
> or creating a stack based on the provided frame and prefix.
> It first generates a key using the frame and prefix values.
> If the stack corresponding to the key is found in the stackMap,
> it is returned. Otherwise, a new stack is created by appending
> the prefix and frame to the stackTable's 'data' array. The key
> and the index of the newly created stack are added to the
> stackMap for future reference.
>
> The get_or_create_frame function is responsible for retrieving or
> creating a frame based on the provided frameString. If the frame
> corresponding to the frameString is found in the frameMap, it is
> returned. Otherwise, a new frame is created by appending relevant
> information to the frameTable's 'data' array and adding the
> frameString to the stringTable.
>
> Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> ---
>  .../scripts/python/firefox-gecko-converter.py | 57 ++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools=
/perf/scripts/python/firefox-gecko-converter.py
> index 6c934de1f608..97fbe562ee2b 100644
> --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> @@ -21,6 +21,8 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
>  from perf_trace_context import *
>  from Core import *
>
> +USER_CATEGORY_INDEX =3D 0
> +KERNEL_CATEGORY_INDEX =3D 1
>  thread_map =3D {}
>  start_time =3D None
>
> @@ -34,7 +36,12 @@ CATEGORIES =3D [
>  PRODUCT =3D os.popen('uname -op').read().strip()
>
>  def trace_end():
> -    thread_array =3D thread_map.values()))
> +    thread_array =3D list(map(lambda thread: thread['finish'](), thread_=
map.values()))

With a class this will be a more intuitive:

thread.finish()

> +
> +# Parse the callchain of the current sample into a stack array.
> +    for thread in thread_array:
> +        key =3D thread['samples']['schema']['time']

I'm not sure what 'schema' is here. Worth a comment.

> +        thread['samples']['data'].sort(key=3Dlambda data : float(data[ke=
y]))

Perhaps there is a more intention revealing name than "data".

>
>      result =3D {
>          'meta': {
> @@ -106,7 +113,55 @@ def process_event(param_dict):
>                 }
>                 stringTable =3D []
>
> +               stackMap =3D dict()
> +               def get_or_create_stack(frame, prefix):

Can you comment what frame and prefix are with examples, otherwise
understanding this function is hard.

> +                       key =3D f"{frame}" if prefix is None else f"{fram=
e},{prefix}"
> +                       stack =3D stackMap.get(key)
> +                       if stack is None:
> +                               stack =3D len(stackTable['data'])
> +                               stackTable['data'].append([prefix, frame]=
)
> +                               stackMap[key] =3D stack
> +                       return stack
> +
> +               frameMap =3D dict()
> +               def get_or_create_frame(frameString):

s/frameMap/frame_map/
s/frameString/frame_string/

These variable names aren't going a long way to helping understand the
code. They mention frame and then the type, which should really be
type information like ": Dict[...]". Can you improve the names as
otherwise we effectively have 3 local variables all called "frame".

> +                       frame =3D frameMap.get(frameString)
> +                       if frame is None:
> +                               frame =3D len(frameTable['data'])
> +                               location =3D len(stringTable)
> +                               stringTable.append(frameString)
> +                               category =3D KERNEL_CATEGORY_INDEX if fra=
meString.find('kallsyms') !=3D -1 \
> +                                               or frameString.find('/vml=
inux') !=3D -1 \
> +                                               or frameString.endswith('=
.ko)') \
> +                                               else USER_CATEGORY_INDEX

Perhaps make this a helper function, symbol_name_to_category_index.

> +                               implementation =3D None
> +                               optimizations =3D None
> +                               line =3D None
> +                               relevantForJS =3D False

Some comments on these variables would be useful, perhaps just use
named arguments below.

> +                               subcategory =3D None
> +                               innerWindowID =3D 0
> +                               column =3D None
> +
> +                               frameTable['data'].append([
> +                                       location,
> +                                       relevantForJS,
> +                                       innerWindowID,
> +                                       implementation,
> +                                       optimizations,
> +                                       line,
> +                                       column,
> +                                       category,
> +                                       subcategory,
> +                               ])
> +                               frameMap[frameString] =3D frame
> +                       return frame
> +
>                 def addSample(threadName, stackArray, time):
> +                       nonlocal name
> +                       if name !=3D threadName:
> +                               name =3D threadName

A comment/example would be useful here.

> +                       stack =3D reduce(lambda prefix, stackFrame: get_o=
r_create_stack
> +                                       (get_or_create_frame(stackFrame),=
 prefix), stackArray, None)

Thanks,
Ian

>                         responsiveness =3D 0
>                         samples['data'].append([stack, time, responsivene=
ss])
>
> --
> 2.34.1
>
