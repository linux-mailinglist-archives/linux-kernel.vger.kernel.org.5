Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0C0E790DCB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 21:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347459AbjICTnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 15:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347405AbjICTnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 15:43:05 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDB0DE
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 12:43:01 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-26f3975ddd4so573805a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 12:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693770181; x=1694374981; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ffpdWUDuUU8t1ryovFUN8LkKxzjq69DuqglQ3PmuD8=;
        b=mJfHedL1QmS56RxRuLQ/aG9EAHSg2dJVntWBfjuPOoxREZOXnqIXgHL+vYeK+o7Onk
         P7lSIjBmxouoSu4kUUDCWAjgk8QUw1q6sLcbUJThZm7j+wjeNcHd6cVAnXWxMnD09p64
         Jgc9D1iNy34JXgU16GEuP9Vpu9Td6w4hAYh76cGowgvbccJ1B4vTp4KA0JSIVibDfebh
         +SrXPeyehp9+a1gclzqHjbqvkzeutSir8NM71/MB12zp0E0qwDrZJ+aWhaLkc2tc95HH
         1LkPdiPRl0fhZvmfusUsbibDOoqYl18t777q9pKnFBukzCaihFWkOyOx6bgjyD8YbT9W
         8q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693770181; x=1694374981;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4ffpdWUDuUU8t1ryovFUN8LkKxzjq69DuqglQ3PmuD8=;
        b=DPYDEBFPzpcE4z/Rt9nlSxwhdAmo+aFjvuvDYJYLAIH5QgQJEQQ+Al4zcCeCwC7AIt
         bA8lSUJIlci3mVR4e0Nx79kGtZ6GM+DOSq/3Iz88HkVfB8+034HgZKXuFE50TnoSeeBM
         peLVFLwq51XTOU66II0lbhBaTN0OvG8/wGaNexbs7r/7WMMSPYXKrMz/oPkVq5xSqLtK
         v+OVsDI+u+opCqX0CIFp9+YjShF+Y+XbMI5lqc8RgCsPh++h7dIgN0o++dzCLjBxvbBa
         cMUe0SlCJne0mJq1s685FSx/mVJE8YlxXpvn/iCb6q4yrOMPSUPq8qJO6DPOt2S+KmWZ
         WjAw==
X-Gm-Message-State: AOJu0Yx5S0fEWz0U1nmxHhUL+4aW2Z/qTXhQPqQfkNhoQCgS1x9RbWS4
        ek1BeamiBnUMbzlcdN+YB8Mvm6yGlEr3PClcwuA=
X-Google-Smtp-Source: AGHT+IGXewbb/ITFSk2Puk8s63iULshNgzFvB6glZXwW3/cZbENKsNljjUMVecRB84dvPr7Gq29TOsEq6S1ykAV9e2I=
X-Received: by 2002:a17:90a:fa86:b0:262:f99b:a530 with SMTP id
 cu6-20020a17090afa8600b00262f99ba530mr7494900pjb.34.1693770180885; Sun, 03
 Sep 2023 12:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230903140617.567850-1-bergh.jonathan@gmail.com> <2023090301-emission-scarce-8272@gregkh>
In-Reply-To: <2023090301-emission-scarce-8272@gregkh>
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
Date:   Sun, 3 Sep 2023 21:42:49 +0200
Message-ID: <CA+MPq=WaoLPdEOgKNLjSTwW=T4tL4vSDpWPU1cUxCU_A7a4aEg@mail.gmail.com>
Subject: Re: [PATCH] staging: vme_user: Add missing '*' in multiline comments
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
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

Yes ... that would be better.

On Sun, Sep 3, 2023 at 4:43=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Sun, Sep 03, 2023 at 04:06:17PM +0200, Jonathan Bergh wrote:
> > This patch resolves a warning reported by checkpatch where multiline
> > block comments should use '*' on intermediate lines in order to adhere
> > to the Linux kernel coding-style guidelines.
> >
> > Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
> > ---
> >  drivers/staging/vme_user/vme_fake.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_=
user/vme_fake.c
> > index 7c53a8a7b79b..90aaf650524d 100644
> > --- a/drivers/staging/vme_user/vme_fake.c
> > +++ b/drivers/staging/vme_user/vme_fake.c
> > @@ -1010,8 +1010,8 @@ static void fake_free_consistent(struct device *p=
arent, size_t size,
> >  {
> >       kfree(vaddr);
> >  /*
> > -     dma_free_coherent(parent, size, vaddr, dma);
> > -*/
> > + *   dma_free_coherent(parent, size, vaddr, dma);
> > + */
>
> As this code isn't being used, why not just delete it instead?
>
> thanks,
>
> greg k-h
