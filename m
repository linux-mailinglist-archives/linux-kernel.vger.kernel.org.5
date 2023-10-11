Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53C87C55C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbjJKNop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjJKNoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:44:44 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0191192;
        Wed, 11 Oct 2023 06:44:43 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7be88e9ccso23932697b3.2;
        Wed, 11 Oct 2023 06:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697031882; x=1697636682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hR/FbMS8TMles3U5xEMi68o+zZcZ1wpyRRSEoX4U4XU=;
        b=XKFYkejvrOtG7rt5ukew2//XuWxuC4OfSqT3ZFqINM5DQQfDoelJi9dKWNZ/bvJMX8
         Hh3ScoaDOhwvNCONZmOxucUbzHhshLJPmXiez3n4dCf8o/CAwrU2xdEdOR4CZtdIXz52
         Yk+5mHv8GvEkdoN/YPKotWEZVdcqfAsPddE2xmGHjVoCWFIp3w4JiV5Sqhby2HM+YTK5
         poeNqPZHi9C5aO/gvefoOXhcGe2EnOzM7hhGasTiDC5IYqvVe58cZuFqdiLEg3m6842w
         YX/N4PfUjYyZ8JriyyHXSTgLEDUxM8TouRrU8rWS672f1fPlis6x+dmQvqIi1LpOALsa
         sn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697031882; x=1697636682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hR/FbMS8TMles3U5xEMi68o+zZcZ1wpyRRSEoX4U4XU=;
        b=s/Uboj+sDB07ORhRxM/MurynfO42nSjue2jh6ONY4SqDne1CxaR5CdBMtKH4ml2lub
         eWYA+TjjrWzhKulh7iqmTCk/Gq8OP+NxN0GUe+ACULEbIXYYTP9UJi8UkNgUSDt9jSGs
         QsapGH3SGESiRrR2NXzkBqiP4O8qSrekbmJf0n66xTF0A+AghO0S+Xcyk4iV99JsFNMP
         ecgZx0VZHggBer4oBfTjScYR28ZtMoa2FPe0neE7TZlIru2EEXFEDWTBLOfWteZTGkH1
         GNx7LEqIIkv47WcESAZ/ZzWUop+UE7FUB+vYyor9Z2ZOUxpShVJnhXGzxkZX4Qa0FixQ
         o0LQ==
X-Gm-Message-State: AOJu0Yz4xfMS/PMb7xa0tCuj1HPop+sWHB18sDnXQCsPpqhrlcvnUzSn
        he/DY1xMBYQCRSmNsylQR5oFpopHZCD3Mg==
X-Google-Smtp-Source: AGHT+IH7Y2JZVOEsKcdTyH4EMbqHt+3BIfDI3b/FKFkbG8c9w9KnQDOVJhLaeJEH1z7NrQDXe3vzLA==
X-Received: by 2002:a81:5cd5:0:b0:595:2094:f87 with SMTP id q204-20020a815cd5000000b0059520940f87mr22432005ywb.47.1697031882067;
        Wed, 11 Oct 2023 06:44:42 -0700 (PDT)
Received: from firmament.. ([89.187.171.244])
        by smtp.gmail.com with ESMTPSA id x189-20020a0dd5c6000000b005a7dd6b7eefsm574691ywd.66.2023.10.11.06.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 06:44:41 -0700 (PDT)
From:   Matthew House <mattlloydhouse@gmail.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     Alejandro Colomar <alx@kernel.org>, linux-man@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@meta.com,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH] execve.2: execve also returns E2BIG if a string is too long
Date:   Wed, 11 Oct 2023 09:44:29 -0400
Message-ID: <20231011134437.750422-1-mattlloydhouse@gmail.com>
In-Reply-To: <60b4d916663ea31ae05a958b6dea8aa5bf740d0a.camel@surriel.com>
References: <20231010234153.021826b1@imladris.surriel.com> <ZSZ7yXwYAg-xPC7P@debian> <60b4d916663ea31ae05a958b6dea8aa5bf740d0a.camel@surriel.com>
MIME-Version: 1.0
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

On Wed, Oct 11, 2023 at 9:21 AM Rik van Riel <riel@surriel.com> wrote:
> On Wed, 2023-10-11 at 12:41 +0200, Alejandro Colomar wrote:
> > Hi Rik,
> >
> > On Tue, Oct 10, 2023 at 11:41:53PM -0400, Rik van Riel wrote:
> > > Document that if a command line or environment string is too long
> > > (> MAX_ARG_STRLEN), execve will also return E2BIG.
> >
> > That's already implied by the current text:
> >
> >        E2BIG  The total number of bytes in the environment (envp) and
> > argument
> >               list (argv) is too large.
> >
> > That means that
> >
> > size_t  bytes;
> >
> > bytes =3D 0;
> > for (char *e =3D envp; e !=3D NULL; e++)
> >         bytes +=3D strlen(e) + 1;  // I have doubts about the +1
> > for (char *a =3D argv; a !=3D NULL; a++)
> >         bytes +=3D strlen(a) + 1;  // Same doubts
> >
> > if (bytes > MAX_ARG_STRLEN)  // Maybe >=3D ?
> >         return -E2BIG;
>
> The code in fs/exec.c enforces MAX_ARG_STRLEN against
> each individual string, not against the total.
>
> If any string, either argument or environment, is larger
> than 32 * PAGE_SIZE, the kernel will return -E2BIG.
>
> do_execveat_common() has this code, which uses copy_strings
> to copy both the strings from the environment, and from
> the command line arguments:
>
>         retval =3D copy_strings(bprm->envc, envp, bprm);
>         if (retval < 0)
>                 goto out_free;
>
>         retval =3D copy_strings(bprm->argc, argv, bprm);
>         if (retval < 0)
>                 goto out_free;
>
> Inside copy_strings() we have this code:
>
>
>         while (argc-- > 0) {
> ...
>                 len =3D strnlen_user(str, MAX_ARG_STRLEN);
>                 if (!len)
>                         goto out;
>
>                 ret =3D -E2BIG;
>                 if (!valid_arg_len(bprm, len))
>                         goto out;
>
> The valid_arg_len() function does not need explanation:
>
> static bool valid_arg_len(struct linux_binprm *bprm, long len)
> {
>         return len <=3D MAX_ARG_STRLEN;
> }
>
>
> The current man page wording is very clear about the total
> length being enforced, but IMHO not as clear about the limit
> that gets enforced on each individual string.
>
> The total length limit of environment & commandline arguments
> is enforced by bprm_stack_limits(), and is checked against
> either 1/4 of the maximum stack size, or 3/4 of _STK_LIM, whichever
> is smaller. The MAX_ARG_STRLEN value does not come into play when
> enforcing the total.

To expand on this, there are basically two separate byte limits in
fs/exec.c, one for each individual argv/envp string, and another for all
strings and all pointers to them as a whole. To put the whole thing in
pseudocode, the checks work effectively like this, assuming I haven't made
any errors:

int argc, envc;
unsigned long bytes, limit;

/* assume that argv has already been adjusted to add an empty argv[0] */
argc =3D 0, envc =3D 0, bytes =3D 0;
for (char **a =3D argv; *a !=3D NULL; a++, argc++) {
    if (strlen(*a) >=3D MAX_ARG_STRLEN)
        return -E2BIG;
    bytes +=3D strlen(*a) + 1;
}
for (char **e =3D envp; *e !=3D NULL; e++, envc++) {
    if (strlen(*e) >=3D MAX_ARG_STRLEN)
        return -E2BIG;
    bytes +=3D strlen(*e) + 1;
}

if (argc > MAX_ARG_STRINGS || envc > MAX_ARG_STRINGS)
    return -E2BIG;
bytes +=3D (argc + envc) * sizeof(void *);

limit =3D max(min(_STK_LIM / 4 * 3, rlim_stack.rlim_cur / 4), ARG_MAX);
if (bytes > limit)
    return -E2BIG;

Thank you,
Matthew House
