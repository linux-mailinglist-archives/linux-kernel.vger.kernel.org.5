Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759867E883C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 03:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345309AbjKKCaM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Nov 2023 21:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKKCaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 21:30:10 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E673C0E;
        Fri, 10 Nov 2023 18:30:07 -0800 (PST)
Received: from mail-wm1-f43.google.com ([209.85.128.43]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LfCzm-1rlgwg1tn6-00olib;
 Sat, 11 Nov 2023 03:30:06 +0100
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4084095722aso20433765e9.1;
        Fri, 10 Nov 2023 18:30:05 -0800 (PST)
X-Gm-Message-State: AOJu0YwPi7NGY0OOz6mOAjlfGLVPxQQDUFEDOzhwNrtQY04eyy55wxYN
        1oAxLewDn/sJYLzYHp2CVqZHCmw+dCMWfegtvAA=
X-Google-Smtp-Source: AGHT+IFTZVbn/LxCz9/JehXI3dYfDcmbPo3yVbrbvkP3/EdIblCAqeTep3MHXfr9+Hg3c6gD6E3OW1lwT2m1GpNBBp8=
X-Received: by 2002:a5d:6d87:0:b0:32d:9d79:33a3 with SMTP id
 l7-20020a5d6d87000000b0032d9d7933a3mr585788wrs.0.1699663375932; Fri, 10 Nov
 2023 16:42:55 -0800 (PST)
MIME-Version: 1.0
References: <20231110235021.192796-1-linux@jordanrome.com> <CAEf4BzaWtOeTBb_+b7Td3NHaKjZU+OohuBJje_nvw9kd6xPA3g@mail.gmail.com>
In-Reply-To: <CAEf4BzaWtOeTBb_+b7Td3NHaKjZU+OohuBJje_nvw9kd6xPA3g@mail.gmail.com>
From:   Jordan Rome <linux@jordanrome.com>
Date:   Fri, 10 Nov 2023 19:42:44 -0500
X-Gmail-Original-Message-ID: <CA+QiOd4X_=rZ5s=XgxBrmSkoepJLFmN4p+3q-0ST9j1sj_BhPw@mail.gmail.com>
Message-ID: <CA+QiOd4X_=rZ5s=XgxBrmSkoepJLFmN4p+3q-0ST9j1sj_BhPw@mail.gmail.com>
Subject: Re: [PATCH perf] perf: get_perf_callchain return NULL for crosstask
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:0n6amA8NZTNpZhW29M/yzbamQFj5jlSVby+Oy5oQkXivvS86r4a
 iZWVDrR1irBQhcXpV5C79c0JVFfFo+gJ+Bt1VvkU/Ltrc74nByws7Mn7eGz7HEwn4+s6YZe
 pPAFlWICAYQjdkSki8FSvzn+QGVgFNMfDX57mn4Himu7KMHCrN6VFNim2ecvgy1uI0/m41k
 r0ulXGAx+fyS8e/XWrB2g==
UI-OutboundReport: notjunk:1;M01:P0:vTKOcDoAyfw=;fS41sZOwunzghXyQH5vWwHD7qYP
 gA52vyK00kfz96+Mxy+E+7KuxrTLyFG4ak8QZ1BSqEP3SvB6eLW1wUUW1+tUcjF8BNhy0Jciv
 T+4kayvM9/c4cbSVy7VgrToMYA7Gra3ZIzuVZkEXB1Gal+XUS29fkrAM4Xtj1/knSmzjCS39J
 SdySMAieWtzCnTBclEpkVN6fHyhpyGHztPDYrJQ6CN0lCfas+TUGNk2SQNyv05zQON2pCxPhH
 gRdlM9lagmcZGlodwxbqeUxIa/v/M0oNcJVZzPS2UWU5wbMGa3hfLv0kKw0yGNjlv8XwcZOcl
 s98fVfSMEJIXl7hOCQPa8WFBvVXRxejImVPAqQBnaPQDB7DrBujuNCUWHgl/e2tR9xXMMfcpB
 8Em0hQxPrw3FNrRjlXr2oNB02c0gtr2WmuQgp8qJNOow/vYwXw4j+MZ2m/x7hpSaxwuAA8iOn
 sxhkJDBympm8L8QgIWajyJQU7bOofxlTpT7fGrM8zWQZnFys4K0udbb33EE+iOlpq4LGH5Exg
 dPR8Gz0xG0TYjjvssMdFtidUv/nNuC4iAzPJ9dJZpbduRDe5Rf1yhgEDJ4YNz6M97nXNb1RhK
 wcqcaUTTwDRN9Yesa89EkrrfEiv8X+SZweRFdFcxzbOH+hi6rNqsnXd/E90qZoC0aHNMTxLX7
 vSagOODRUYh4QRne3MsnJVYB9yrlv2RK0iQxVVsBgenkN0rTZq/bZ6DArBoSQDmrnB13ZXfoW
 hlreIlF+M/rbGtOd4hfjeMTWB1t3+WsX+m8xnBDahZjAyRz+cPWgVjK4Qo+2k/yezTr2q9tBy
 C6rE7Utllaqpz4nUgA/e4xqgB9QyH9nzwvc48vDH3famjut5dhHJyuFg7le4e7D3K/CIOWgk0
 sOfCo+ESp+YW3ww==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 7:10 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Nov 10, 2023 at 3:51 PM Jordan Rome <linux@jordanrome.com> wrote:
> >
> > Return NULL instead of returning 1 incorrect frame, which
> > currently happens when trying to walk the user stack for
> > any task that isn't current. Returning NULL is a better
> > indicator that this behavior is not supported.
> >
> > This issue was found using bpf_get_task_stack inside a BPF
> > iterator ("iter/task"), which iterates over all tasks. The
> > single address/frame in the buffer when getting user stacks
> > for tasks that aren't current could not be symbolized (testing
> > multiple symbolizers).
> >
> > Signed-off-by: Jordan Rome <linux@jordanrome.com>
> > ---
> >  kernel/events/callchain.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >
> > diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
> > index 1273be84392c..430fa544fa80 100644
> > --- a/kernel/events/callchain.c
> > +++ b/kernel/events/callchain.c
> > @@ -201,6 +201,9 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
> >         }
> >
> >         if (user) {
> > +               if (crosstask)
> > +                       return NULL;
>
> I think you need that goto exit_put here.
>

Why is that? Wouldn't that be the same behavior that already exists?
That being said we can probably move this check above get_callchain_entry
and exit earlier.

> > +
> >                 if (!user_mode(regs)) {
> >                         if  (current->mm)
> >                                 regs = task_pt_regs(current);
> > @@ -209,9 +212,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
> >                 }
> >
> >                 if (regs) {
> > -                       if (crosstask)
> > -                               goto exit_put;
> > -
> >                         if (add_mark)
> >                                 perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
> >
> > @@ -219,7 +219,6 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
> >                 }
> >         }
> >
> > -exit_put:
> >         put_callchain_entry(rctx);
> >
> >         return entry;
> > --
> > 2.39.3
> >
