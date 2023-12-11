Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9418E80DE1E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 23:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345042AbjLKWYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:24:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLKWYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:24:46 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556F3AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:24:52 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40c2db0ca48so6745e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 14:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702333491; x=1702938291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuQhIspD6JR77pVxf75RvkVh4XrOwhOgI88fQHyFirk=;
        b=LH5EeGXfZ7RLz9iWo8xeyim+HtNCofdi73PH3S4IeeNSxU6G/goNu0/gtcNk6qFrCk
         73R5DaGDra5ziw0Juf9YQi6jH9QGgiitfre9wUPwMlKoi1E4Re1HRXtcVqCTSyIdw2n0
         M5EMZWc/o9kLkJgGGiuY1Ad9xvf32ArQ6Knv/zWTfSIR74XQ+MVls4o9jQ2cROOL0OmC
         3TjIxeD0BtK95RTGRwa0k7+nYHy3PW/0BZ5jVu+kwDpdVFKLe/QjFN8ICj8UIdZrvJoo
         Fl6q+IPYR8nridsBq9kZODh1cCe7rp9h2Y5IrtvEVmvawUsDt+Rux9EAZDOp1yrq7c4D
         Oisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702333491; x=1702938291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PuQhIspD6JR77pVxf75RvkVh4XrOwhOgI88fQHyFirk=;
        b=L6TZg97TySWYhcGC0Av+h0JZzmlTYeQ1Vzt2dJIg19Njv/aIWTKlGxDketX8N0SlDz
         jzcucMJU043WPHvF0uewGYsCwoxMQh2bg8sXeuUCVTstXUhCITzJOaodreQSNm92QWDW
         44ikB0p43PO0fFrVwLcCDicN8gqZ5wQq208s6ZegeFM2AmlNff46tLrm0aVsYGx6w4bJ
         vLJ0IV4SWz2SQDRaBBg6r9P46k+bsPChl0iUoeQrikxKVC27mwSD5CtP3rQCmIJHIpmM
         8uWSZYVK3e5+xhEi2ic5OQzBRwhGvUCXGHetLfAPdbkf2+J3g30W4MvjORuTkVCp3klI
         O8sA==
X-Gm-Message-State: AOJu0YxOJsqlPZiEuJzVd5aB1dB92NZdUY76I0DmYOj20LohTRpkUnn0
        lfDcwndstG1t4lkwRHsfKKt3JDFSdOjc1spfTZC76A==
X-Google-Smtp-Source: AGHT+IFj+gQqjsQ9tZwqQ54imOTiWUHQxRdBbgfw67rUBLpxq2CY7ZuT/sJpYMBLtvRJ0bbqhxLMjQeCf8fVYSPRJtk=
X-Received: by 2002:a05:600c:4f4b:b0:40c:4ed3:8d1f with SMTP id
 m11-20020a05600c4f4b00b0040c4ed38d1fmr29228wmq.7.1702333490714; Mon, 11 Dec
 2023 14:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20231204221932.1465004-1-rmoar@google.com> <20231204221932.1465004-4-rmoar@google.com>
 <CABVgOSmbbAyckSvKREmUDBrZJtErQpxaNjXH0vaH1oZjkVt3JA@mail.gmail.com>
In-Reply-To: <CABVgOSmbbAyckSvKREmUDBrZJtErQpxaNjXH0vaH1oZjkVt3JA@mail.gmail.com>
From:   Rae Moar <rmoar@google.com>
Date:   Mon, 11 Dec 2023 17:24:38 -0500
Message-ID: <CA+GJov7yKzWPfKGWaJwaHR4kJkotXdOXJ3yeewUhL4gTe2jVhw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] kunit: add is_init test attribute
To:     David Gow <davidgow@google.com>
Cc:     shuah@kernel.org, dlatypov@google.com, brendan.higgins@linux.dev,
        sadiyakazi@google.com, keescook@chromium.org, arnd@arndb.de,
        linux-kselftest@vger.kernel.org, linux-arch@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 9, 2023 at 2:57=E2=80=AFAM David Gow <davidgow@google.com> wrot=
e:
>
> On Tue, 5 Dec 2023 at 06:19, Rae Moar <rmoar@google.com> wrote:
> >
> > Add is_init test attribute of type bool. Add to_string, get, and filter
> > methods to lib/kunit/attributes.c.
> >
> > Mark each of the tests in the init section with the is_init=3Dtrue attr=
ibute.
> >
> > Add is_init to the attributes documentation.
> >
> > Signed-off-by: Rae Moar <rmoar@google.com>
> > ---
>
> Would it be possible to not have this in kunit_attributes? I know it's
> required for the run-after-boot stuff later, but I'd love this to be
> (a) just generated at runtime, or (b) stored only at a suite or
> suite-set level. It seems like a bit of a waste to store this
> per-test-case, and to have it potentially accessible or overwritable
> by users.
>
> Otherwise, this looks good (and I appreciate the automatic setting of
> this when merging the suite sets.
>
> Maybe if we always kept the init suites in a separate set, we could
> just use pointer comparisons to generate this; otherwise let's make
> this a suite-level-only attribute (inherited by tests).
>
>
> -- David

Hello!

I did consider making is_init a field within a suite object instead
and then pointing to that in the kunit_attributes framework during
filtering, printing, etc... I will change that out in the next
version.

Thanks!
-Rae
