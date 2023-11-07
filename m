Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4A87E4B97
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjKGWSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKGWSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:18:49 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B433F7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:18:47 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-59e88a28b98so1787167b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 14:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699395526; x=1700000326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QctA7Bq+rxWAwGydWIjR1fSKNRz9s8P13IzaEYf+J9E=;
        b=U4ZfE5I0QXe3vh82PGBtQ6CysI5RoaCcadptRzC55yXx9RtX2pH0Hfp3AGtue6MKul
         l/aiObuBuQIjgBEwBL5K6OsjnllybNRRCyS+GSVI66BaBJymBFZqhCVaJtNRCA8mTsDd
         1GtxaOAMFERACgzkt3mxiu0b/A0OD3xpKnt7Dm/liGlis1a4vI8FmWelIJsTjoD1dmst
         WKfs97d/PRH8O284Pf27lTKp7U5RSB+FZwLVIuQ7e3eG9Sswqb/Bj4xwSbbhuiJrF525
         MUK5D66jEUnq0qfCV3sWgrZTJpC42Qu0Dj+EvXB4RgvKXyZrDE5iaTo3JBZU0k7tIwZY
         jAQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699395526; x=1700000326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QctA7Bq+rxWAwGydWIjR1fSKNRz9s8P13IzaEYf+J9E=;
        b=MZmBMUjVZ/ZxOaLv45fXQFXMjINn55KWDYxbyt0GrzkMrKNlJQSCCoUPSkfrrXoqLa
         9RleWRSo9SC27t9Mp0aKOTXOSji1HCJi9UQX0cHFWBd0X3etFir0Rs+TGsYmNnWghJ67
         fhPCnpPqNWNzON3wt2TfCULkO8Sc7HQ706GtpdlpYw6DhaVttXhZofvF/bdJodNztJ0p
         X8xTNdgsz9eWKOKuKMv+f20gVSITehmmnrJkeozTHScEMDWwhhIZpxSFeE2wYFzQqsRn
         Adw9v3BDk/rvl6Z8U3Wich1RXPf2/O1ZthgSCCuoz+Afv3Xmf8T7HtR1sHnk0jIEyjPf
         91Ng==
X-Gm-Message-State: AOJu0Yws/+Bvu6f6CrBD53iYGUEEklOzjhZvDXhLZrCGjAqypAIZB7tU
        Du/GjuC24HsQjnfTyXrwIuI80fqqQfGFqIFyF5+xjQcor1I=
X-Google-Smtp-Source: AGHT+IHxqhdp2l6CSzq5JgZwwhFfA23JVB1iFBQyZytpmw4JO1z6E5AAwYnmRirD6Ryy0xiKGvJOfevQySew15int/s=
X-Received: by 2002:a0d:d4d7:0:b0:5a7:dad3:cd21 with SMTP id
 w206-20020a0dd4d7000000b005a7dad3cd21mr88953ywd.10.1699395526548; Tue, 07 Nov
 2023 14:18:46 -0800 (PST)
MIME-Version: 1.0
References: <20231107142154.613991-1-agruenba@redhat.com> <CAHk-=wie7WsYHkEChV0hpcf7CRRJQw9-E8O8RxrFGKF6mEJ73g@mail.gmail.com>
In-Reply-To: <CAHk-=wie7WsYHkEChV0hpcf7CRRJQw9-E8O8RxrFGKF6mEJ73g@mail.gmail.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 7 Nov 2023 23:18:33 +0100
Message-ID: <CAHpGcM+u=77p_k8dZ6gKu84wnkdvGYA4E6=MXqNw=ZY+ejjiaw@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di., 7. Nov. 2023 um 21:31 Uhr schrieb Linus Torvalds
<torvalds@linux-foundation.org>:
> On Tue, 7 Nov 2023 at 06:22, Andreas Gruenbacher <agruenba@redhat.com> wrote:
> >
> > please consider pulling the following gfs2 fixes.
>
> You are officially on my shit-list for
>
>  (a) claiming it's fixes
>
>  (b) apparently lying about that fact to make it appear that it's ok
> that this wasn't in linux-next and was committed within the last few
> days
>
> about half of the commits in that pull request are very recent,
> weren't in linux-next when the merge window started, and while a
> couple of of them are fixes, most of them are just minor cleanups.
>
> DON'T LIE ABOUT THINGS. It only annoys the hell out of me when I
> notice that somebody was trying to pull wool over my eyes.

I apologize for referring to the entire set of commits as fixes when
it's really fixes and various other things. I've said so in the tag
description, but I realize now that that's not good enough. Lying
about what those commits are wasn't my intention though.

And I apologize for the last -minute changes. There is one commit that
removes a single line of dead code which could easily have waited. The
rest are fixes, but they should have been completed much sooner.
That's entirely my fault.

> I've pulled this and I'll let it be (because I already merged other
> stuff on top), but dammit, just be honest about what happened, don't
> try to claim this is somehow "fixes" and thus ok to not have gone
> through linux-next.
>
> Or, better yet, get your ducks actually lined up before the merge window.
>
>                         Linus

Thanks,
Andreas
