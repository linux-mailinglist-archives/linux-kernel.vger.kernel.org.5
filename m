Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A21E76E81F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjHCM0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjHCM0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:26:08 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6652708;
        Thu,  3 Aug 2023 05:26:07 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso1557575e87.1;
        Thu, 03 Aug 2023 05:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691065565; x=1691670365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7xgCKkYT+hLlKi0uXpqCkm09uupDae69VUERiZM6d4=;
        b=TH0RxDwAIpUxTQEDVcB2OkyeulItBA1uFs9sRsr4ISCZ5eWCD395RD3Qrq5H0MqYiO
         BeeX7+NRxfO0wzDzm67Dk6uQmHTOdlglTNSTk+Q3NC0dEHZssBtDtTOJQcM85qAdL8yv
         +6ry35fra7fh8kK1eH3uIMJJapdYBtHjHN3NFVHuo9pXHMnelGn210/7XZq7V15gVw93
         9EWkdvAqRWerbVz41FRaiD+ZashL1WEBg2kcm3tYOli8h0qKPum/xgEYya09/m8nqApA
         bo4hZz3fIcjyGPHWCnbRVkWD2y0mlruNg3+OL4ydwzogP/fsZPOhxP6uPBPTzqO7nJBZ
         aB6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691065565; x=1691670365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7xgCKkYT+hLlKi0uXpqCkm09uupDae69VUERiZM6d4=;
        b=ko3Kr1iub6cFdMBD5zsVVttQJtXXKjQ4Kf8H8IXEmENq/+HcqXHLUey3Dehi5GW+7Z
         tbwhDMguvMdAKYYzoLc1yThKzLhN28WMstapj8uEVKIhpRGfgF4GhmNeIt9IQF2PlJTE
         pfPiXFeaj1ikGRMg1p6/SEy6aGd4ngrrI5T1ACtiJtb1ipYISbjnyTGImTfotwtBNIX7
         XcNmq9CTE+EMhDWnNOUNTZkE3MZkZcMxLoIn4Xx8IxeSsbKWMXnRG8R114roBCv+HM1X
         jQ15PZfF8gu6n5wGqq9V67a4J9g3t7Zl1szsUWaRrqfJSrgZ/stsXLANR8yo4i75596Y
         1rXA==
X-Gm-Message-State: ABy/qLaMEXBiET4rcmydxpdR/fjOKxiEV8Xjub1EZZSIV2V9i2sKoKGc
        7dakP+XMvAPv5BXenAuTTUxlrD6UpkI00sJsy/0=
X-Google-Smtp-Source: APBJJlEY2Id1slntd7GA6KTqIW+bJgWceOMRsDfOCtOnpp/QxiaKY66snxxJwMfldPZAi427INh96Ba4lnUIQOgJ9Ug=
X-Received: by 2002:ac2:4301:0:b0:4f8:7781:9875 with SMTP id
 l1-20020ac24301000000b004f877819875mr6513277lfh.60.1691065565092; Thu, 03 Aug
 2023 05:26:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083352.1585-1-zegao@tencent.com> <20230803083352.1585-2-zegao@tencent.com>
 <20230803050900.5007d2f5@gandalf.local.home> <CAD8CoPDNEyf9LN8HfOTUR7c5npPPivJe8yncTWr756ZzPyZkNQ@mail.gmail.com>
In-Reply-To: <CAD8CoPDNEyf9LN8HfOTUR7c5npPPivJe8yncTWr756ZzPyZkNQ@mail.gmail.com>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Thu, 3 Aug 2023 20:25:53 +0800
Message-ID: <CAD8CoPBuXY7s6GXH1na-AB595U4u_t0JJB3uUchGr-0KijVS4Q@mail.gmail.com>
Subject: Re: [RFC PATCH v6 1/5] perf sched: sync state char array with the kernel
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

THIS IS THE NEW CHANGELOG FOR THIS PATCH:

    perf sched: sync state char array with the kernel

    Since commit e936e8e459e14 ("perf tools: Adapt the
    TASK_STATE_TO_CHAR_STR to new value in kernel space."),
    the state char array that is used to interpret the
    states of tasks being switched out have not synced
    once with kernel definitions. Whereas the task report
    logic is evolving over this time and the definition
    of this state char array has been changed multiple
    times. And this leads to inconsistency.

    As of this writing, perf timehist --state still reports
    the wrong states because TASK_STATE_TO_CHAR_STR is too
    outdated to use.

    So sync TASK_STATE_TO_CHAR_STR to match the latest kernel
    definitions to fix it.

    Signed-off-by: Ze Gao <zegao@tencent.com>

Regards,
Ze

On Thu, Aug 3, 2023 at 6:29=E2=80=AFPM Ze Gao <zegao2021@gmail.com> wrote:
>
> On Thu, Aug 3, 2023 at 5:09=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
> >
> > On Thu,  3 Aug 2023 04:33:48 -0400
> > Ze Gao <zegao2021@gmail.com> wrote:
> >
> > Hi Ze,
> >
> > > Update state char array and then remove unused and stale
> > > macros, which are kernel internal representations and not
> > > encouraged to use anymore.
> > >
> >
> > A couple of things.
> >
> > First, the change logs of every commit need to specify the "why". The
> > subject can say "what", but the change log really needs to explain why =
this
> > patch is important. For example, this patch is really two changes (and =
thus
> > should actually be two patches). (I'll also comment on the other patche=
s)
>
> Thanks for the feedback! Will elaborate the changes in each changelog.
>
> > 1. The update of the state char array. You should explain why it's bein=
g
> > updated. If it was wrong, it needs to state the commit that changed to =
make
> > that happen.
> >
> > 2. For the removing the stale macros, the change log can simply state t=
hat
> > the macros are unused in the code and are being removed.
> >
> > Finally, I know you're eager to get this patch set in, but please hold =
off
> > sending a new version immediately after a comment or two. Some maintain=
ers
> > prefer submitters to wait a week or so, otherwise you will tend to "spa=
m"
> > their inboxes. There's more than one maintainer Cc'd on this series, an=
d you
> > need to be courteous not to send too many emails in a short period of t=
ime.
>
> Noted!  Actually I'm in no rush and just to make sure people see the
> latest patches so they do not have to waste time on the old series.
>
> Will hold off to resolve all the comments in this thread.
>
> And thanks for pointing this out.
>
> Regards,
> Ze
