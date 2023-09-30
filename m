Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416707B3D5C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 03:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjI3BIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 21:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjI3BIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 21:08:49 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815E2F3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 18:08:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-533edb5ac54so14252709a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 18:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696036126; x=1696640926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZup8TW2zGO5Dc5hYWwOfReZg/1sYcAfov7pXVHZroU=;
        b=FQS4GMk45toqzJbDaef9/HiAidci7xJHo6c/WRM64Ey8Q0hx3RsTO1viIYganiiNox
         q5iAZG36KS6wCtzKxtoL+zBWhCw2z+p2R0cdxOARnR6EMNWaaRF96aDZ518NmUCr57dS
         b+7k+u83Z4mH/F0BthFQ4zLotfSzZ8EWltKMGXww8AlgO2oQ/20Imj2ladudMyAAqQG3
         +hn3d9vAlCW8r2hXl2Py5zOGmjbpu7TIr/hWAwpGvAipItE+kfQCwjmOj8BUD86Y6atp
         hgYOsXOz+IH1HNgHnxSk5QEI2XhYstgRmWodHhTZxUf9l3dpClPRZ5lCPCBOoTQqcdZd
         Vk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696036126; x=1696640926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZup8TW2zGO5Dc5hYWwOfReZg/1sYcAfov7pXVHZroU=;
        b=HmV19+RcFpyJoxBlGvh2eLDCwM++HQDUzqvSF/MebmHflj3aHOzTSMG5WuHqMVR72i
         X8wj8IbwUeTfDnv9Ttj0Ojz1WqOv9kLTefOvkjFu5v+LA4N2J31W2ceIsF+NktEm61xv
         mAx1kTPuL3JvMYLOXnNo2E9TWvkju2KvIj5KtqPHnU2Nl9i0wPF6nhBncXrWSKtnWxbv
         Iw6tfrS7Z24Tth1aFyIiKv+Pu65ati9nK6IFO/iM/j200TpxuN6OaPy5VRENwJZIEgS/
         ehLky5/3CNunMvDHJ0pEvFe2L/pXm1VqEJmWpCDiYk8gk0+ZWE13JpVPqp9MP2SjmO0W
         eQzg==
X-Gm-Message-State: AOJu0YwgLyctGSHxi4TN0dEPCGIoJQ3H/+jfnZKX+BMftCcMhN4pzPVi
        OIGzeevXF7UrKawJ4SLbl5CrYVZPRgXEkS23W89KBQ==
X-Google-Smtp-Source: AGHT+IF8h2UUty/K7RH6GZtDTwRCYxVzrE9X1TPlLmDUaz4Tz1s/zGJimg+5mXKWp3nVXXh21oSaPyBUEm8UvkF4CaE=
X-Received: by 2002:aa7:d489:0:b0:534:8bdf:a256 with SMTP id
 b9-20020aa7d489000000b005348bdfa256mr5227701edr.31.1696036125906; Fri, 29 Sep
 2023 18:08:45 -0700 (PDT)
MIME-Version: 1.0
References: <202309280610.sLGSPkOG-lkp@intel.com> <CANiq72=J=bO-Q0=gMDyiRgvbF_Vre39iqbEnaEeDho4Vo2ox6A@mail.gmail.com>
 <202309291040.F201590997@keescook>
In-Reply-To: <202309291040.F201590997@keescook>
From:   Justin Stitt <justinstitt@google.com>
Date:   Sat, 30 Sep 2023 10:08:34 +0900
Message-ID: <CAFhGd8oLmKA7L_YDps+aYLVJTPxWNaKKTgCX3Ji=ZLoGMv7a6g@mail.gmail.com>
Subject: Re: drivers/md/dm-cache-metadata.c:1705:9: warning: 'strncpy'
 specified bound 16 equals destination size
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 2:49=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Sep 28, 2023 at 11:36:46AM +0200, Miguel Ojeda wrote:
> > On Thu, Sep 28, 2023 at 12:24=E2=80=AFAM kernel test robot <lkp@intel.c=
om> wrote:
> > >
> > >    In function 'write_hints',
> > >        inlined from 'dm_cache_write_hints' at drivers/md/dm-cache-met=
adata.c:1729:6:
> > > >> drivers/md/dm-cache-metadata.c:1705:9: warning: 'strncpy' specifie=
d bound 16 equals destination size [-Wstringop-truncation]
> > >     1705 |         strncpy(cmd->policy_name, policy_name, sizeof(cmd-=
>policy_name));
> > >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~~~~~~
> >
> > This looks fine given the check above it. In any case, since it
> > appears the code wants to terminate the string, this should use
> > `strscpy*()`, right?
>
> I agree. I can't tell if _pad is needed though. I think struct
> dm_cache_metadata is only used internally? And I see at least the
> initial allocation is zeroed:
>
>         cmd =3D kzalloc(sizeof(*cmd), GFP_KERNEL);
>
> Regardless, for background,
>
> struct has:
>         char policy_name[CACHE_POLICY_NAME_SIZE];
>
> code does:
>         const char *policy_name =3D dm_cache_policy_get_name(policy);
>
>         if (!policy_name[0] ||
>             (strlen(policy_name) > sizeof(cmd->policy_name) - 1))
>                 return -EINVAL;
>
>         strncpy(cmd->policy_name, policy_name, sizeof(cmd->policy_name));
>
>
> Justin, can you add this to your queue (if it's not already there)?

I sent a patch out earlier this week [1].

The line # on the diff v.s the warning is off though. I suspect I may
need a rebase if it doesn't apply clean.

>
> -Kees
>
> --
> Kees Cook

[1]: https://lore.kernel.org/all/20230925-strncpy-drivers-md-dm-cache-metad=
ata-c-v1-1-4b75c7db0cfe@google.com/
