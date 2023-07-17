Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D7F7568C2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjGQQNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjGQQMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:12:43 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704B3FC;
        Mon, 17 Jul 2023 09:12:41 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b8b2b60731so25096855ad.2;
        Mon, 17 Jul 2023 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689610361; x=1692202361;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KqQaPv4Fn3MjQuoSouIRvNL/VfuKWqsAXCUL+WpnOZ0=;
        b=Ji7e2PjDkY0KhMv59NQvxUS4U3A78b5Zmb55N6a/DLaQp8lg+uwHECUlX4u0u77pvI
         +M3yBW4FOhvuJUrjG9BT99Jh1CGh6U+4OtmovQc7U/rKde4XzMJrXmRZAhxaYN0bqV6S
         gTTgqJKzm/RBfIDX4v8ZKkf9wFANeZBer02oCmQeiRJasoXzceh+1WtITodPlhYbaoTV
         OhOKaKLQGTgmTwZyuQcBVYy4l8XXmB5VbRcG8eIlWih0e3oxnuPXUUaVoDUmPBEosZc7
         pWpjl5LpHiUKam7RJAYX/t2m/n8bhjZ5cuD8q/dNjKXx/dw8U+FHfVfz+Vj7A/bhVHOg
         HkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689610361; x=1692202361;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KqQaPv4Fn3MjQuoSouIRvNL/VfuKWqsAXCUL+WpnOZ0=;
        b=Nsdw6i7VkpsNgzK0mc9rfnbwRXye62kwruHwmZ/LifLAAI5mm/IJaCvSV/Bz35AHQO
         5snKtB9hmKD4FyAjKm1gE01ASI9H/YM/eS+QyWEdhbKGMh4v4wyovfWdZpMQLfL70ttC
         0dIJgbpsrdvhN9IjPdPWgfO9KzGwZl8bRcD3YOEQ+5ldR34hZXXb8cy9hemM2LFSacEu
         KaxIstUTvzRGcTASrcdzzHtssb3SFB5tz/j/fpyIkYQ62FlJG8m6qfSW8HUqe4JtUYvT
         zXVIrxTXuRQHH8U9rHM/xYxzOzlKDRPFsrRygwIBxIeLi83y7W2CloXen/y6N5br/N9j
         leeA==
X-Gm-Message-State: ABy/qLZ1CaVSTcSf+wQfsK4l3yPns9cwoR9hP7OIBddflEQDss3M9+P7
        sobzFc0RykH/s4b3Om8VuaM=
X-Google-Smtp-Source: APBJJlHIyLiJ/pdiJefQEOZh93bm5gCbvEtcPKDImLJ8JlpoIkMKJc6nnPGAcqGVgThGf8hevXRr1g==
X-Received: by 2002:a17:902:e743:b0:1b8:b4d5:4c3d with SMTP id p3-20020a170902e74300b001b8b4d54c3dmr13943395plf.51.1689610360457;
        Mon, 17 Jul 2023 09:12:40 -0700 (PDT)
Received: from yoga ([2400:1f00:13:50e2:5893:783e:fde0:1bce])
        by smtp.gmail.com with ESMTPSA id 5-20020a170902c24500b001b86f1b5797sm53058plg.302.2023.07.17.09.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 09:12:40 -0700 (PDT)
From:   Anup Sharma <anupnewsmail@gmail.com>
X-Google-Original-From: Anup Sharma <AnupSharma>
Date:   Mon, 17 Jul 2023 21:42:32 +0530
To:     Ian Rogers <irogers@google.com>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] scripts: python: implement get or create frame
 and stack function
Message-ID: <ZLVocFUFMgquEJDY@yoga>
References: <cover.1689024635.git.anupnewsmail@gmail.com>
 <dd26619520465132d33dd84780859e6bf89133bf.1689024635.git.anupnewsmail@gmail.com>
 <CAP-5=fVtE14SyCvkYCQgePm-5upAZYvU7AvkwcYXGLYBffko1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVtE14SyCvkYCQgePm-5upAZYvU7AvkwcYXGLYBffko1A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 10:44:21AM -0700, Ian Rogers wrote:
> On Mon, Jul 10, 2023 at 4:15 PM Anup Sharma <anupnewsmail@gmail.com> wrote:
> >
> > Complete addSample function, it takes the thread name, stack array,
> > and time as input parameters and  if the thread name differs from
> > the current name, it updates the name. The function utilizes the
> > get_or_create_stack and get_or_create_frame methods to construct
> > the stack structure. Finally, it adds the stack, time, and
> > responsiveness values to the 'data' list within 'samples'.
> >
> > The get_or_create_stack function is responsible for retrieving
> > or creating a stack based on the provided frame and prefix.
> > It first generates a key using the frame and prefix values.
> > If the stack corresponding to the key is found in the stackMap,
> > it is returned. Otherwise, a new stack is created by appending
> > the prefix and frame to the stackTable's 'data' array. The key
> > and the index of the newly created stack are added to the
> > stackMap for future reference.
> >
> > The get_or_create_frame function is responsible for retrieving or
> > creating a frame based on the provided frameString. If the frame
> > corresponding to the frameString is found in the frameMap, it is
> > returned. Otherwise, a new frame is created by appending relevant
> > information to the frameTable's 'data' array and adding the
> > frameString to the stringTable.
> >
> > Signed-off-by: Anup Sharma <anupnewsmail@gmail.com>
> > ---
> >  .../scripts/python/firefox-gecko-converter.py | 57 ++++++++++++++++++-
> >  1 file changed, 56 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/scripts/python/firefox-gecko-converter.py b/tools/perf/scripts/python/firefox-gecko-converter.py
> > index 6c934de1f608..97fbe562ee2b 100644
> > --- a/tools/perf/scripts/python/firefox-gecko-converter.py
> > +++ b/tools/perf/scripts/python/firefox-gecko-converter.py
> > @@ -21,6 +21,8 @@ sys.path.append(os.environ['PERF_EXEC_PATH'] + \
> >  from perf_trace_context import *
> >  from Core import *
> >
> > +USER_CATEGORY_INDEX = 0
> > +KERNEL_CATEGORY_INDEX = 1
> >  thread_map = {}
> >  start_time = None
> >
> > @@ -34,7 +36,12 @@ CATEGORIES = [
> >  PRODUCT = os.popen('uname -op').read().strip()
> >
> >  def trace_end():
> > -    thread_array = thread_map.values()))
> > +    thread_array = list(map(lambda thread: thread['finish'](), thread_map.values()))
> 
> With a class this will be a more intuitive:
> 
> thread.finish()

I have made the changes. Thanks for the suggestion.

> > +
> > +# Parse the callchain of the current sample into a stack array.
> > +    for thread in thread_array:
> > +        key = thread['samples']['schema']['time']
> 
> I'm not sure what 'schema' is here. Worth a comment.

Thanks, I am planning to add hyper-link as a the comment. Like this:
# https://github.com/firefox-devtools/profiler/blob/53970305b51b9b472e26d7457fee1d66cd4e2737/src/types/gecko-profile.js#L216
However it is going to exceed 100 characters limit. If I wrap it
around, it will look ugly. Any suggestions?

> 
> > +        thread['samples']['data'].sort(key=lambda data : float(data[key]))
> 
> Perhaps there is a more intention revealing name than "data".

Noted. I will change it.

> >
> >      result = {
> >          'meta': {
> > @@ -106,7 +113,55 @@ def process_event(param_dict):
> >                 }
> >                 stringTable = []
> >
> > +               stackMap = dict()
> > +               def get_or_create_stack(frame, prefix):
> 
> Can you comment what frame and prefix are with examples, otherwise
> understanding this function is hard.

I am using more descriptive names now. I have also added a comment like
this to the function:
"""Gets a matching stack, or saves the new stack. Returns a Stack ID."""
Will be reflected in v4.

> > +                       key = f"{frame}" if prefix is None else f"{frame},{prefix}"
> > +                       stack = stackMap.get(key)
> > +                       if stack is None:
> > +                               stack = len(stackTable['data'])
> > +                               stackTable['data'].append([prefix, frame])
> > +                               stackMap[key] = stack
> > +                       return stack
> > +
> > +               frameMap = dict()
> > +               def get_or_create_frame(frameString):
> 
> s/frameMap/frame_map/
> s/frameString/frame_string/
> 
> These variable names aren't going a long way to helping understand the
> code. They mention frame and then the type, which should really be
> type information like ": Dict[...]". Can you improve the names as
> otherwise we effectively have 3 local variables all called "frame".

I have made the changes. Thanks for the suggestion.

> > +                       frame = frameMap.get(frameString)
> > +                       if frame is None:
> > +                               frame = len(frameTable['data'])
> > +                               location = len(stringTable)
> > +                               stringTable.append(frameString)
> > +                               category = KERNEL_CATEGORY_INDEX if frameString.find('kallsyms') != -1 \
> > +                                               or frameString.find('/vmlinux') != -1 \
> > +                                               or frameString.endswith('.ko)') \
> > +                                               else USER_CATEGORY_INDEX
> 
> Perhaps make this a helper function, symbol_name_to_category_index.

I am trying to find if I can use cpu_mode instead of this as suggested by
Namhyung. If not, I will add a helper function in the later version.

> > +                               implementation = None
> > +                               optimizations = None
> > +                               line = None
> > +                               relevantForJS = False
> 
> Some comments on these variables would be useful, perhaps just use
> named arguments below.

Okay, this variable comes from Gecko format, now adding link might
make it understandable.

> > +                               subcategory = None
> > +                               innerWindowID = 0
> > +                               column = None
> > +
> > +                               frameTable['data'].append([
> > +                                       location,
> > +                                       relevantForJS,
> > +                                       innerWindowID,
> > +                                       implementation,
> > +                                       optimizations,
> > +                                       line,
> > +                                       column,
> > +                                       category,
> > +                                       subcategory,
> > +                               ])
> > +                               frameMap[frameString] = frame
> > +                       return frame
> > +
> >                 def addSample(threadName, stackArray, time):
> > +                       nonlocal name
> > +                       if name != threadName:
> > +                               name = threadName
> 
> A comment/example would be useful here.

Noted.

> 
> > +                       stack = reduce(lambda prefix, stackFrame: get_or_create_stack
> > +                                       (get_or_create_frame(stackFrame), prefix), stackArray, None)
> 
> Thanks,
> Ian
> 
> >                         responsiveness = 0
> >                         samples['data'].append([stack, time, responsiveness])
> >
> > --
> > 2.34.1
> >
