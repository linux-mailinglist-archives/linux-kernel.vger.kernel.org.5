Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB3E808F3D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443446AbjLGRyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjLGRyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:54:31 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA01512E
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 09:54:37 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-4b3203cdc78so215817e0c.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 09:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701971677; x=1702576477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FYoDefF8AqdfjCaLos2fQ25+4YPa8J7nFuTpXaVzvQ=;
        b=nscd7MPm0v7G5mqo0mtyez0Bazh9fU84X4WFn2rMHFJ6op4ZgAPcyXkYOI95TrRJT2
         fQshIVw1M/F5N7IIW2Hg7yEIeRXVcvsGvEToNSpVP5MJweKfcJ0FNX5CP6LdjIuY1mv5
         t5V8dtXI2HIjbIjc/OQi8y5TqbFn79SgEZMsiU33MJHDzQOBs8vdRVbEwYDubG1wxfSV
         L9sAzYJNoWD5551OSXYhHx48Rphjo1MGtIdf6orO4H2zeVGKeCW9nVMRBNGASCPbOF6M
         RteEVPqcoEvq3hKDV2CI8/UGT8HrVcj675DKa+G9+b8NSrru0AvGJ98XsceXWxqryXLs
         MxYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701971677; x=1702576477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FYoDefF8AqdfjCaLos2fQ25+4YPa8J7nFuTpXaVzvQ=;
        b=udqyv+IWEnKBWDHcuY6D3xMyQUDLb/dfGKEVJnqzB1ZlC1H6qe4aFRmYydAjgscRMl
         Qco74DB4OQg4PGTb4vnBjxJ9B2UtX5OseVNmMdpbNSw9feMKv2pptv6zZ9EouGtJ+Fki
         A1LibiXjm88IDcJh/DrBwVN59SgYMjX+N9SBvwlbnnRPt46T2KifI1QnH8SPnyZQONFW
         5BxV8fmPCo+YRnoRs9Z9dHrvltNNRJbLfxWAydIZCZAeXyQB3AuY4ViPIK4xJwqxoyIq
         ZrNSG3lPa/ERcDEnnIhrxp4tkVk3KGnp7JeRZK0V6sf4ahL789Zad2RBytkzE/KdIRi2
         ZuKA==
X-Gm-Message-State: AOJu0YxV8tnUKoKWkZVLAjt+xJtSkIfp8LF5XMZRb+Si5DAeQhAckbTe
        /YOyiNmzaOPDUc2IX9Z8XhmKajd8SweDqyBVSh1qDA==
X-Google-Smtp-Source: AGHT+IG2PXbMAD4WU+rowF872mK8EHDeiriaFhcHKM07Qg9Rkms7o6+1C/BriedURSkoLnX5YJsiB87wVNhGNe0VXBk=
X-Received: by 2002:a1f:4a03:0:b0:4a1:7278:3bf5 with SMTP id
 x3-20020a1f4a03000000b004a172783bf5mr2632426vka.4.1701971676821; Thu, 07 Dec
 2023 09:54:36 -0800 (PST)
MIME-Version: 1.0
References: <20231207163458.5554-1-khuey@kylehuey.com> <20231207163458.5554-2-khuey@kylehuey.com>
 <CANpmjNNi1WoE0gsq5TSv8ys68YcF2o+LtWiDj+=bZ3Y46oP7Jw@mail.gmail.com> <CAP045Ap8z0qUpuYtbf9hpBqfnngNU7wVT0HM0XwQMrYYt9CAkg@mail.gmail.com>
In-Reply-To: <CAP045Ap8z0qUpuYtbf9hpBqfnngNU7wVT0HM0XwQMrYYt9CAkg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 7 Dec 2023 18:53:58 +0100
Message-ID: <CANpmjNOCFz43zhJm1mS5Ai1XTQiZ_-BW2K3z8vJEV4CyfoZtCA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf: Reorder overflow handler ahead of event_limit/sigtrap
To:     Kyle Huey <me@kylehuey.com>
Cc:     Kyle Huey <khuey@kylehuey.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        "Robert O'Callahan" <robert@ocallahan.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org
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

On Thu, 7 Dec 2023 at 18:47, Kyle Huey <me@kylehuey.com> wrote:
>
>
>
> On Thu, Dec 7, 2023, 9:05=E2=80=AFAM Marco Elver <elver@google.com> wrote=
:
>>
>> On Thu, 7 Dec 2023 at 17:35, Kyle Huey <me@kylehuey.com> wrote:
>> >
>> > The perf subsystem already allows an overflow handler to clear pending=
_kill
>> > to suppress a fasync signal (although nobody currently does this). All=
ow an
>> > overflow handler to suppress the other visible side effects of an over=
flow,
>> > namely event_limit accounting and SIGTRAP generation.
>> >
>> > Signed-off-by: Kyle Huey <khuey@kylehuey.com>
>> > ---
>> >  kernel/events/core.c | 10 +++++++---
>> >  1 file changed, 7 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/kernel/events/core.c b/kernel/events/core.c
>> > index b704d83a28b2..19fddfc27a4a 100644
>> > --- a/kernel/events/core.c
>> > +++ b/kernel/events/core.c
>> > @@ -9541,6 +9541,12 @@ static int __perf_event_overflow(struct perf_ev=
ent *event,
>> >          */
>> >
>> >         event->pending_kill =3D POLL_IN;
>> > +
>> > +       READ_ONCE(event->overflow_handler)(event, data, regs);
>> > +
>> > +       if (!event->pending_kill)
>> > +               return ret;
>>
>> It's not at all intuitive that resetting pending_kill to 0 will
>> suppress everything else, too. There is no relationship between the
>> fasync signals and SIGTRAP. pending_kill is for the former and
>> pending_sigtrap is for the latter. One should not affect the other.
>>
>> A nicer solution would be to properly undo the various pending_*
>> states (in the case of pending_sigtrap being set it should be enough
>> to reset pending_sigtrap to 0, and also decrement
>> event->ctx->nr_pending).
>
>
> I don't believe it's possible to correctly undo the event_limit decrement=
 after the fact (if it's e.g. racing with the ioctl that adds to the event =
limit).
>
>> Although I can see why this solution is simpler. Perhaps with enough
>> comments it might be clearer.
>>
>> Preferences?
>
>
> The cleanest way would probably be to add a return value to the overflow =
handler function that controls this. It requires changing a bunch of arch s=
pecific code on arches I don't have access to though.

Hmm.

Maybe wait for perf maintainers to say what is preferrable. (I could
live with just making sure this has no other weird side effects and
more comments.)
