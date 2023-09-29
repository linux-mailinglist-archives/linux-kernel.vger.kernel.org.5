Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA0D7B3804
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 18:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjI2Qd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 12:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjI2Qd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 12:33:56 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BA21A4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:33:53 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-4195fe5cf73so351121cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 09:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696005232; x=1696610032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffVnXhLfUBC8rvMVI8r2MHwAWbcGbBOCYKaiiqST9BA=;
        b=ybE+ZuwCCrW5iMKM8d1zjsMsl3TTPwFsH1oTPLBVQEan9bkSn48XhXbj4nZx0E3zl6
         se3BklFrIcI+ul91Nvbf1bnk6RA08tIeBS25UDfNN6bWLqque9d+5+/otCI/YX5dvI54
         hnAAnCHJyX+Nt1APU7fBLisLX2lRYZE+mIkdF3oredLmNjLNQUIyDDQvYcc6g+ZL9mKz
         puwbnEh3tTE6tNDWMRbgb3WfJILOTqxwKEKnjswChVmc1dUFxuNFaEmY2YyjE1akeZOv
         mDQvWU+AtG+Vrx7ncOEfPwdBHRxu/I7jyZ5lC6pnu3nmhaM4Vv0YndU0sCS+FLDrDhGV
         Y0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696005232; x=1696610032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffVnXhLfUBC8rvMVI8r2MHwAWbcGbBOCYKaiiqST9BA=;
        b=SKsKLsMZZIybgDMD6zGGhxuwOxe6w8t4N9+N23w72ZaBLr4P+hnbyb08ThlbyYrgwR
         uOYUTuIYUFrBIU1UHvVcuN3LK1lBRIz66y2Co2nvMZhnG98/RuiiBCZsf1UkE6TafqbT
         wtCWdGqjzJXebMwrFS/7lDRXTzs8oaRpavxYwFdRqsF7CVOu1t2uGfWVPLHl+QHz6aNa
         7BC4jFlyc2lBvA+2yXcKWSBX7chEJz8kJxOHKFf6v2DBzU6jQiPiY0CrFrQrrAZ8Q3Lz
         YnlLSoZcTOhNlP3l079KqPgZAXdqVibCM0dUYSs2nMCHDEXFPUT+kcVKXifzydNWwnuw
         tx5A==
X-Gm-Message-State: AOJu0YwibxoQrRGFU0ExYRmaR3TZ1ptDPqd96AtftKNb5ehvxhLEbDUc
        MqJ0A9TZxFvtJ7CJ8THyVjmgSvOVmlvi/EEOoEwz2Q==
X-Google-Smtp-Source: AGHT+IH1gsMBD4JxM9vVJxis/oSJpnNaztJXHjcw2oR757FGXPcnrUNgplqBhrtLff75RwzxjxNb+2HTch5IEEOjn98=
X-Received: by 2002:a05:622a:1715:b0:417:8d3c:42cf with SMTP id
 h21-20020a05622a171500b004178d3c42cfmr1307027qtk.7.1696005231760; Fri, 29 Sep
 2023 09:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230921061641.273654-1-mic@digikod.net> <20230921061641.273654-6-mic@digikod.net>
 <CALmYWFubLv+yd9NWMMwt4FUdYnbghMC=GHeZm4oaSOctqnwbVA@mail.gmail.com>
 <20230926.di9Esee2xahi@digikod.net> <CALmYWFuerqvZ3HoUnc9xXYhR8vBgg9qAyA-ncHai4ksN-c-gGQ@mail.gmail.com>
 <20230928.Haewoh8Aishe@digikod.net> <CALmYWFvT8EBh+DwW0gw8yU36FKQxtsmO2s5sU6DD8_pfA9yxYg@mail.gmail.com>
 <20230929.Zausiachi5Eu@digikod.net>
In-Reply-To: <20230929.Zausiachi5Eu@digikod.net>
From:   Jeff Xu <jeffxu@google.com>
Date:   Fri, 29 Sep 2023 09:33:14 -0700
Message-ID: <CALmYWFtytM7=FcPqsWcGbax3_G6kP-6vQaMay+mqAAvN5R91-g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/7] landlock: Log file-related requests
To:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Ben Scarlato <akhna@google.com>,
        =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
        Jorge Lucangeli Obes <jorgelo@google.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Shervin Oloumi <enlightened@google.com>, audit@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
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

On Fri, Sep 29, 2023 at 9:04=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> On Thu, Sep 28, 2023 at 01:04:01PM -0700, Jeff Xu wrote:
> > On Thu, Sep 28, 2023 at 8:16=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@d=
igikod.net> wrote:
> > >
> > > On Tue, Sep 26, 2023 at 02:19:51PM -0700, Jeff Xu wrote:
> > > > On Tue, Sep 26, 2023 at 6:35=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <m=
ic@digikod.net> wrote:
> > > > >
> > > > > On Mon, Sep 25, 2023 at 06:26:28PM -0700, Jeff Xu wrote:
> > > > > > On Wed, Sep 20, 2023 at 11:17=E2=80=AFPM Micka=C3=ABl Sala=C3=
=BCn <mic@digikod.net> wrote:
> > > > > > >
> > > > > > > Add audit support for mkdir, mknod, symlink, unlink, rmdir, t=
runcate,
> > > > > > > and open requests.
> > > > > > >
> > > > > > > Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> > > > > > > ---
> > > > > > >  security/landlock/audit.c | 114 ++++++++++++++++++++++++++++=
++++++++++
> > > > > > >  security/landlock/audit.h |  32 +++++++++++
> > > > > > >  security/landlock/fs.c    |  62 ++++++++++++++++++---
> > > > > > >  3 files changed, 199 insertions(+), 9 deletions(-)
> > > > > > >
> > > > >
> > > > > > > +static void
> > > > > > > +log_request(const int error, struct landlock_request *const =
request,
> > > > > > > +           const struct landlock_ruleset *const domain,
> > > > > > > +           const access_mask_t access_request,
> > > > > > > +           const layer_mask_t (*const layer_masks)[LANDLOCK_=
NUM_ACCESS_FS])
> > > > > > > +{
> > > > > > > +       struct audit_buffer *ab;
> > > > > > > +
> > > > > > > +       if (WARN_ON_ONCE(!error))
> > > > > > > +               return;
> > > > > > > +       if (WARN_ON_ONCE(!request))
> > > > > > > +               return;
> > > > > > > +       if (WARN_ON_ONCE(!domain || !domain->hierarchy))
> > > > > > > +               return;
> > > > > > > +
> > > > > > > +       /* Uses GFP_ATOMIC to not sleep. */
> > > > > > > +       ab =3D audit_log_start(audit_context(), GFP_ATOMIC | =
__GFP_NOWARN,
> > > > > > > +                            AUDIT_LANDLOCK);
> > > > > > > +       if (!ab)
> > > > > > > +               return;
> > > > > > > +
> > > > > > > +       update_request(request, domain, access_request, layer=
_masks);
> > > > > > > +
> > > > > > > +       log_task(ab);
> > > > > > > +       audit_log_format(ab, " domain=3D%llu op=3D%s errno=3D=
%d missing-fs-accesses=3D",
> > > > > > > +                        request->youngest_domain,
> > > > > > > +                        op_to_string(request->operation), -e=
rror);
> > > > > > > +       log_accesses(ab, request->missing_access);
> > > > > > > +       audit_log_lsm_data(ab, &request->audit);
> > > > > > > +       audit_log_end(ab);
> > > > > > > +}
> > > > > > > +
> > > > > > > +// TODO: Make it generic, not FS-centric.
> > > > > > > +int landlock_log_request(
> > > > > > > +       const int error, struct landlock_request *const reque=
st,
> > > > > > > +       const struct landlock_ruleset *const domain,
> > > > > > > +       const access_mask_t access_request,
> > > > > > > +       const layer_mask_t (*const layer_masks)[LANDLOCK_NUM_=
ACCESS_FS])
> > > > > > > +{
> > > > > > > +       /* No need to log the access request, only the missin=
g accesses. */
> > > > > > > +       log_request(error, request, domain, access_request, l=
ayer_masks);
> > > > > > > +       return error;
> > > > > > > +}
> > > > >
> > > > > > > @@ -636,7 +638,8 @@ static bool is_access_to_paths_allowed(
> > > > > > >  }
> > > > > > >
> > > > > > >  static int current_check_access_path(const struct path *cons=
t path,
> > > > > > > -                                    access_mask_t access_req=
uest)
> > > > > > > +                                    access_mask_t access_req=
uest,
> > > > > > > +                                    struct landlock_request =
*const request)
> > > > > > >  {
> > > > > > >         const struct landlock_ruleset *const dom =3D
> > > > > > >                 landlock_get_current_domain();
> > > > > > > @@ -650,7 +653,10 @@ static int current_check_access_path(con=
st struct path *const path,
> > > > > > >                                        NULL, 0, NULL, NULL))
> > > > > > >                 return 0;
> > > > > > >
> > > > > > > -       return -EACCES;
> > > > > > > +       request->audit.type =3D LSM_AUDIT_DATA_PATH;
> > > > > > > +       request->audit.u.path =3D *path;
> > > > > > > +       return landlock_log_request(-EACCES, request, dom, ac=
cess_request,
> > > > > > > +                                   &layer_masks);
> > > > > >
> > > > > > It might be more readable to let landlock_log_request return vo=
id.
> > > > > > Then the code will look like below.
> > > > > >
> > > > > > landlock_log_request(-EACCES, request, dom, access_request,  &l=
ayer_masks);
> > > > > > return -EACCES;
> > > > > >
> > > > > > The allow/deny logic will be in this function, i.e. reader
> > > > > > doesn't need to check landlock_log_request's implementation to =
find
> > > > > > out it never returns 0.
> > > > >
> > > > > I did that in an early version of this patch, but I finally choos=
e to write
> > > > > 'return lanlock_log_request();` for mainly two reasons:
> > > > > * to help not forget to call this function at any non-zero return=
 values
> > > > >   (which can easily be checked with grep),
> > > >
> > > > "grep -A 2 landlock_log_request" would serve the same purpose thoug=
h.
> > >
> > > Yes, there is always a way to find a pattern, and the best tool might=
 be
> > > Coccinelle, but I think it's harder to miss with such tail calls.
> > >
> > > >
> > > > > * to do tail calls.
> > > > >
> > > > > I guess compiler should be smart enough to do tail calls with a v=
ariable
> > > > > set indirection, but I'd like to check that.
> > > > >
> > > >
> > > > What are tail calls and what is the benefit of this code pattern ?
> > > > i.e. pass the return value into landlock_log_request() and make it =
a
> > > > single point of setting return value for all landlock hooks.
> > >
> > > landlock_log_request() should only be called at the end of LSM hooks.
> > > Tail calls is basically when you call a function at the end of the
> > > caller. This enables replacing "call" with "jmp" and save stack space=
.
> > > landlock_log_request() can fit with this pattern (if not using the
> > > caller's stack, which is not currently the case). See this tail call
> > > optimization example: https://godbolt.org/z/r88ofcW6x
> > >
> > Thanks for giving the context of the tail call.
> > Compile options are controlled by makefile, and can be customized. In
> > the past, I have had different projects setting different O levels for
> > various reasons, including disable optimization completely. Individual
> > Compiler implementation  also matters, gcc vs clang, etc. I think the
> > tail call is probably not essential to the discussion.
> >
> > > I find it less error prone to not duplicate the error code (once for
> > > landlock_log_request and another for the caller's returned value). I
> > > also don't really see the pro of using a variable only to share this
> > > value. In ptrace.c, an "err" variable is used to check if the error i=
s 0
> > > or not, but that is handled differently for most hooks.
> > >
> > > Makeing landlock_log_request() return a value also encourages us (tha=
nks
> > > to compiler warnings) to use this value and keep the error handling
> > > consistent (especially for future code).
> > >
> > One general assumption about logging function is that it is not part
> > of the main business logic, i.e. if the logging statement is
> > removed/commented out, it doesn't have side effects to the main
> > business logic. This is probably why most log functions return void.
>
> I get it. We need to be careful not to add blind spots though. If audit
> is not compiled, the inline function call will just be removed.
> Otherwise, logging or not depends on the audit framework and the runtime
> configuration.
>
> Another thing to keep in mind is that for now, if the log failed somehow
> (e.g. because of not enough memory), it will not impact the decision
> (either accept or deny). However, I guess we may want to be able to
> control this behavior is some cases one day, and in this case the log
> function needs to return an error.
>
> >
> > > Another feature that I'd like to add is to support a "permissive mode=
",
> > > that would enable to quickly see the impact of a sandbox without
> > > applying it for real. This might change some landlock_log_request()
> > > calls, so we'll see what fits best.
> > >
> > It is an excellent feature to have.
> > To implement that, I guess there will be a common function as a switch
> > to allow/deny, and logging the decision, depending on the permissive
> > setting.
>
> Permissive mode will be per domain/sandbox, so it will add complexity to
> the current logging mechanism, but that is worth it.
>
> > From that point, preparing the code towards that goal makes sense.
> >
> > > >
> > > > > To make it easier to read (and to not forget returning the error)=
, the
> > > > > landlock_log_request() calls a void log_request() helper, and ret=
urns
> > > > > the error itself. It is then easy to review and know what's happe=
ning
> > > > > without reading log_request().
> > > > >
> > > > > I'd like the compiler to check itself that every LSM hook returne=
d
> > > > > values are either 0 or comming from landlock_log_request() but I =
think
> > > > > it's not possible right now. Coccinelle might help here though.
> > > > >
> > > > > BTW, in a next version, we might have landlock_log_request() call=
ed even
> > > > > for allowed requests (i.e. returned value of 0).
> > When there is more business logic to landlock_log_request, it is
> > probably better to rename the function. Most devs might assume the log
> > function does nothing but logging.  Having some meaningful name, e.g.
> > check_permissive_and_audit_log,  will help with readability.
>
> As for the permissive mode, this would be per domain.
>
That is really nice to have.

> I'd like to keep the audit.h functions with the same prefix.
> What about landlock_log_result()?
>
I'm fine with keeping landlock_log_request in this version since it is
only temporary, or landlock_log_result() is better.

In the future version, landlock_log_result() still doesn't quite say
it might override the result, so maybe extract the audit logging out
of that at the time.

> >
> > Thanks!
> > -Jeff
