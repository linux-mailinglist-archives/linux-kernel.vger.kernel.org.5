Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FC078EE5D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjHaNQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346333AbjHaNQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:16:57 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3771A4;
        Thu, 31 Aug 2023 06:16:54 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a7aedc57ffso470207b6e.2;
        Thu, 31 Aug 2023 06:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693487814; x=1694092614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvjEwhjKTzM24zTtto0X2hNb/4jBUMlTIyxRYyU31F8=;
        b=pf+6JIqXsDsdySQ2L9edkP89gyXurVjbkHf3KpR5UAhkoGNity/geRDKRWIcdiUmyx
         etzuGbuSXf5gh1JHOzKn6hpZogbUOVZzZkvC2WgL7f1ntWav5qMTBgmC2J6l7BoOHuh7
         xaF86oOz7bSOPsA+o45gqIi50DdS6b+bgA4mqxWLffxtegdTri+CzCstP1K2VPUSj1DV
         eT5M5gM+6b+8JAwQqbBWcTbGyV37YcMqG4RmIe+J2Nlh+U9GT+OIUukKczZ5mXEJ0VY0
         q2RCcVfq7pUgsN1S/mM8qISi3u0hiCk19/3Qwwkhp8dCpHQoX7vbMWUH+kzvGD/4onYT
         9LzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693487814; x=1694092614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvjEwhjKTzM24zTtto0X2hNb/4jBUMlTIyxRYyU31F8=;
        b=Gqr6J1cZkGUfUQRt8cHvutSQ5cK6Aezfr9f2uoCAmSk17DPG4ooKMegQXapd9H8Z1E
         Ffpr269+uUIP0ZelpZOLg3QtMqgOXUYeQWXh+VeVaHtzkha2aj+QUHuSqhCs/bh4OZTz
         wRJjXLdlsYrhIAIjmhcmFpLEVJD/Ols2Mij93KhofxPl1ljSQSihfXaoNxwWBtawWqLw
         pasLfdT/4trLPqTftmUiUFRe2nCFAz1OvE5tov6StflF85+C2otCP9fOodWdSdny+n+Z
         E2ZsLP1iOygf27aZsACgF74IxP9KTqR8WdIz+mYqGnKbUkFdeDrAPLNZ6wv31SHbM25G
         uRiA==
X-Gm-Message-State: AOJu0Yz0wrMun7OyXzbTecS4c6Stnqxu8gEKixK+hC0yGY+nloQsyioC
        WwQXiB2k2BoZpOOYtrgC/4coS2bbxzLoN5tkTjxetrgaSjk=
X-Google-Smtp-Source: AGHT+IE2FhmXyXLAGk+I6c1o0xIfxttEXs+4SdO383eHQBc9YsKQBViTBEroy3HH+mR8crJU8XS0nKNDFuN6ocnrv+8=
X-Received: by 2002:a05:6808:b:b0:3a3:91f8:d3da with SMTP id
 u11-20020a056808000b00b003a391f8d3damr5224234oic.13.1693487814147; Thu, 31
 Aug 2023 06:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693386602.git.pstanner@redhat.com> <46f667e154393a930a97d2218d8e90286d93a062.1693386602.git.pstanner@redhat.com>
 <CAHp75VfkzV-=XuEZwipYzfHNu4EXuwzbu6vfEKh1Uueseo2=wA@mail.gmail.com> <94b893ef37fe0cc0bcc52e8b54c62be3853a7bbb.camel@redhat.com>
In-Reply-To: <94b893ef37fe0cc0bcc52e8b54c62be3853a7bbb.camel@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 31 Aug 2023 16:16:17 +0300
Message-ID: <CAHp75VcNyE9uJu8-v2eVWRdZ3-nm2r-kdxE-naQB4VN6zxPFxg@mail.gmail.com>
Subject: Re: [PATCH 1/5] string.h: add array-wrappers for (v)memdup_user()
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andy@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        David Disseldorp <ddiss@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Siddh Raman Pant <code@siddh.me>,
        Nick Alcock <nick.alcock@oracle.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Zack Rusin <zackr@vmware.com>,
        VMware Graphics Reviewers 
        <linux-graphics-maintainer@vmware.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-hardening@vger.kernel.org,
        David Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 3:22=E2=80=AFPM Philipp Stanner <pstanner@redhat.co=
m> wrote:
> On Wed, 2023-08-30 at 17:11 +0300, Andy Shevchenko wrote:
> > On Wed, Aug 30, 2023 at 4:46=E2=80=AFPM Philipp Stanner <pstanner@redha=
t.com>
> > wrote:

...

> > I'm wondering if this has no side-effects as string.h/string.c IIRC
> > is used also for early stages where some of the APIs are not available.
>
> I forgot to address this point in my previous reply.
>
> Who's going to decide whether this is a problem or not?
>
> My personal guess is that this is unlikely to be a problem because
>
>    A. either (v)memdup_user() is available, in which case
>       (v)memdup_array_user() will always work =E2=80=93
>    B. or (v)memdup_user() is not available, which would cause the code
>       that currently uses (v)memdup_user() for copying arrays to fail
>       anyways.

It also uses something from overflow.h. I don't remember if that
header was ever been used in early stage modules (like
boot/decompressor).

--=20
With Best Regards,
Andy Shevchenko
