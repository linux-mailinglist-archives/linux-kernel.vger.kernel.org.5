Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1FA27B028A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 13:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbjI0LPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 07:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjI0LO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 07:14:59 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17071A7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:14:55 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d894b8b9b7cso6417370276.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 04:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695813295; x=1696418095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPJwzNvZylvTQiOIT8nQFH9SZPRi6/HairHaCmuEtNs=;
        b=AMBmhhrE18QeWrtS2JIX7VBdZjVHc5+Sridf2a98pFccWi/5V1BaXrEsmssrwf/XT0
         K/Qi0jWDh6+iNssAfG8NJBA4sXlzhr2zspvx/6NGRCXoLEFcxEKKWkdy9ZHy2YvnRWHL
         wP7HihOF1Oc5Da3az9TAb3sH8EyEskZXtdb+SJT8jNySbilpHpurm4CjZEEr1kLdGp3e
         SKXtrr8q5YLwDwsEfN5YXJ9I0AalBg7CYV/hemPhKrvkZq6vtizoYMPhCD6zI7jKLiVm
         Ndbp/zM9tcKxzUcY78bebx/MMVBDaTK5lHb84y4OA0khTSxrsFs0HXbXbgeA1UmMCjnj
         Mb2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695813295; x=1696418095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPJwzNvZylvTQiOIT8nQFH9SZPRi6/HairHaCmuEtNs=;
        b=CqsCoxvbQGN0TGED695C4ZgMX8Rxx0YmiHAM+sWB+S6i+sZTThi+rjKv+RMZQtnBKT
         v77HwxQggj60ZTYILEK/GVuQOlmP+3qa4qmZHxbw8PQRCKFd52ybdooterRZlHbI4fvw
         oKaXM5xy58UDGhYE8xHLNyqdLfHNJakGDyZnuMJvUua1d5vb2eh1r0mXcY7KQVse1MHk
         YUXbqiWNHHRycBdbcknmprFp00bJIMpA/LuUAcTw0MJGLxN2Yfq7+YIZr1yD4HM8wMf8
         4+E1tKbQJeEfjQznKVofxcUAv1XM1jujspLmG8TrDfgBzNjrhmXRb1X/utc1MiO2ufzX
         8MxQ==
X-Gm-Message-State: AOJu0YyOxteT1ZAy6HfV7z6bp5QYesDDgi6vjnJBwo6IrwQVGzQpO0pC
        PIn9kK5ipC96ndFFKH3JVdpGM7RGFvHKNVH4Bd72iQ==
X-Google-Smtp-Source: AGHT+IEn2A7RS/m3JUkpvx+tmDV6V0R2eCw+Of0nQLfgxCdKPWwgPYxVdAeR/zX+HB0XruKv1fpwYUQ6tD6Zm5e1DDc=
X-Received: by 2002:a25:f810:0:b0:d7b:aaae:2037 with SMTP id
 u16-20020a25f810000000b00d7baaae2037mr4192438ybd.22.1695813294798; Wed, 27
 Sep 2023 04:14:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230814-void-drivers-soc-renesas-rmobile-sysc-v1-1-6648dfd854de@google.com>
 <CAMuHMdWiC4v9fctp18bRrEH-m_-0VjMg9+XpON8vdRYwniTU3g@mail.gmail.com>
 <CAMuHMdWk_jcZ1V7J68bw11YZ+EjEqAWOKHzanVyxo2zktbMteg@mail.gmail.com>
 <CAPDyKFqgsHYz1hfOQ=KniNJj+u7ZSMoxS03Rixj1n2AOUdSVaQ@mail.gmail.com> <CAMuHMdW+ovx_Vbp1FQbvHESYrv3kHx5FvkjSb0V8dq857x5e9w@mail.gmail.com>
In-Reply-To: <CAMuHMdW+ovx_Vbp1FQbvHESYrv3kHx5FvkjSb0V8dq857x5e9w@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Sep 2023 13:14:19 +0200
Message-ID: <CAPDyKFp_PfP4mVWucbMHwrRBvOAkktJDjqaYrMtEKat7raQ68A@mail.gmail.com>
Subject: Re: [PATCH] soc: renesas: rmobile-sysc: fix -Wvoid-pointer-to-enum-cast
 warning
To:     Justin Stitt <justinstitt@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Magnus Damm <magnus.damm@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sept 2023 at 11:28, Geert Uytterhoeven <geert@linux-m68k.org> wr=
ote:
>
> Hi Ulf,
>
> On Tue, Sep 26, 2023 at 1:22=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> > On Mon, 18 Sept 2023 at 11:21, Geert Uytterhoeven <geert@linux-m68k.org=
> wrote:
> > > On Wed, Aug 30, 2023 at 10:24=E2=80=AFAM Geert Uytterhoeven
> > > <geert@linux-m68k.org> wrote:
> > > > On Tue, Aug 15, 2023 at 12:11=E2=80=AFAM Justin Stitt <justinstitt@=
google.com> wrote:
> > > > > When building with clang 18 I see the following warning:
> > > > > |      drivers/soc/renesas/rmobile-sysc.c:193:22: warning: cast t=
o smaller integer
> > > > > |               type 'enum pd_types' from 'const void *' [-Wvoid-=
pointer-to-enum-cast]
> > > > > |        193 |                 add_special_pd(np, (enum pd_types)=
id->data);
> > > > >
> > > > > This is due to the fact that `id->data` is a void* and `enum pd_t=
ypes`
> > > > > has the size of an integer. This cast from pointer-width to int-w=
idth
> > > > > causes truncation and possible data loss. Instead, cast to `uintp=
tr_t`
> > > > > which has the same width as void*.
> > > > >
> > > > > Link: https://github.com/ClangBuiltLinux/linux/issues/1910
> > > > > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > > >
> > > > scripts/checkpatch.pl:
> > > >
> > > >     WARNING: Reported-by: should be immediately followed by Closes:
> > > > with a URL to the report
> > > >
> > > > Hence changing the Link: tag to a Closes: tag.
> > > >
> > > > > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > > > > ---
> > > > > Note: It should be noted that there is likely no data loss occurr=
ing in
> > > > > this case since the enum only has a few fields. The narrowing cas=
t from
> > > > > pointer to int will not lose any data.
> > > >
> > > > Indeed, the theoretical narrowing could only happen on a 64-bit
> > > > platform, while this driver is only used on arm32.
> > > >
> > > > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > i.e. will queue in renesas-devel for v6.7.
> > >
> > > As the Generic PM Domain providers were moved to drivers/pmdomain/
> > > in v6.6-rc2, and now have their own maintainer, I have moved this
> > > commit from renesas-drivers-for-v6.7 to renesas-pmdomain-for-v6.7[1],
> > > with s/soc/pmdomain/ in the oneline-summary.
> > >
> > > Ulf: if you prefer, you can still take this patch directly.
> > > Else I will send a PR after rc3 and/or rc5, like I do with my other
> > > renesas-<foo>-for-<version> branches.
> > > Thanks!
> >
> > Apologize for the delay, been traveling lately. Anyway, I can
> > certainly pick up the patch and carry it for v6.7. Just let me know,
> > if/when you have dropped the patch from your tree.
>
> Thanks, dropped.

Applied for next, thanks!

[...]

Kind regards
Uffe
