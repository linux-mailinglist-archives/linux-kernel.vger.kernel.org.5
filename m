Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C281B7DC0FD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 21:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjJ3UIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 16:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjJ3UIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 16:08:23 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439B1CC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:08:21 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-66d0169cf43so32710496d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 13:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698696500; x=1699301300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdB2S3KUR4VydwWGzBK/FNweWRak7f59CHm7VtpooJk=;
        b=QHlD7XxebRlFNuerZab2nuu9BaKB/Haq/+3hebGZWouG67N67Y3p33iZveUp3BO+oA
         NNdSN6itjCIlW8pL+6zDiq4uS2ondG/sT0btgUkmHket0pSoeIaCB9MikRXiXibJMSa9
         p2OIMU9rlX3UN8CjCXsOy2Np8R5j7qCOVKJ8lPj1jEwx5NtzmlEUV8i4g4rKGdHK3Ibw
         paAIyFBsqWuCVAgDw4E6B7VTKVoqR6A47gb2HW/3RoG1pToUY/PgWuz9NSMRe8c1uR+A
         0busPGfqw//7up5uAwis1KIBaDeQRgG2xA5Vtws1K6Xg5HNsW5j08sKir/hJ53hP77kf
         uwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698696500; x=1699301300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wdB2S3KUR4VydwWGzBK/FNweWRak7f59CHm7VtpooJk=;
        b=mOIcG0V5QjOJcwdPJjMMtiUbbhPoTB9NQWcqxIBP2uK81KecSnNkuE3BMdouaDygGN
         subdoD0qE/WZoHTBSzasAkEluR+5lWRFYqXDSekSDtTuPtXbJI53Efq+CvJRdxnFXYvm
         KgUtXH/sr3zDehEwZaJKdK4Cad/Or8InN0i0cS0vrbGfXgb+/RihJU9J+INmxDf21icQ
         Q6GGAo39Zlpm4xbNOc+HtpYNMKiKsddBRfB2H/z7oXweE2qcwZHJgYMFHYXic6592NGW
         eaAYKc1Hl6k5NnJCi8Yy1Eg+FgMBhrJGEDw9jwkmeC8w2NnO6hZ6R1dyWRlLt+tQZNa0
         KsQw==
X-Gm-Message-State: AOJu0YxULYnnu18Jj9a9KJPHWiQZpANGugEZ8m96/YjXam37NFlms5An
        M1XJwifvOoBGvD4KH2Hk7+LLTjQV2I3uN0e7wuU=
X-Google-Smtp-Source: AGHT+IHApIH0otX5rPuJqUKfLnjhGC0MxsS8+v8rHBCV9cnennUXFhctqMqBHdF/89A1ndp8+gZplcir+G8pPtJx40U=
X-Received: by 2002:a05:6214:c88:b0:671:2c2f:4fe6 with SMTP id
 r8-20020a0562140c8800b006712c2f4fe6mr7118796qvr.46.1698696500317; Mon, 30 Oct
 2023 13:08:20 -0700 (PDT)
MIME-Version: 1.0
References: <20231024134637.3120277-1-surenb@google.com> <20231024134637.3120277-2-surenb@google.com>
 <ZTfUCiFP3hVJ+EXh@smile.fi.intel.com> <20231024194653.c24qbnk6bx3hep6y@moria.home.lan>
 <ZTpl1ELUMEmne21U@smile.fi.intel.com> <20231026184456.q6ocnmpq6jhqi7zi@moria.home.lan>
In-Reply-To: <20231026184456.q6ocnmpq6jhqi7zi@moria.home.lan>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 30 Oct 2023 22:07:43 +0200
Message-ID: <CAHp75Vch5U=F00i0yB82XRU2504pUUEUu1YvBPbiU=FRbJ9FJw@mail.gmail.com>
Subject: Re: [PATCH v2 01/39] lib/string_helpers: Add flags param to string_get_size()
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     Andy Shevchenko <andy@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, keescook@chromium.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 9:45=E2=80=AFPM Kent Overstreet
<kent.overstreet@linux.dev> wrote:
> On Thu, Oct 26, 2023 at 04:12:52PM +0300, Andy Shevchenko wrote:
> > On Tue, Oct 24, 2023 at 03:46:53PM -0400, Kent Overstreet wrote:
> > > On Tue, Oct 24, 2023 at 05:26:18PM +0300, Andy Shevchenko wrote:
> > > > On Tue, Oct 24, 2023 at 06:45:58AM -0700, Suren Baghdasaryan wrote:

...

> Andy: to be blunt, you've been pretty hostile and hysterical ("breaking
> the kernel!" over debug statements? really?)

Where did I say that?

And instead of judging me, look from the reviewer's and maintainer's
point of view. The patch is unreviewable and has not good
maintainability in this form as it does a few things at once.

Also the commit message is poorly written as it has no mention about use ca=
ses.

>  and the bikeshedding is
> getting to be too much - I'm just going to drop this patch from the
> series and we'll post process the output as needed.

I don't think I bikeshed here too much. This is the regular asking the
reviewers and/or maintainers usually do, so is it too hard to split?

--=20
With Best Regards,
Andy Shevchenko
