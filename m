Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C81D7AB8C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjIVSDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjIVSDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:03:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A897999
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:03:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c5dfadb492so14245ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695405814; x=1696010614; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWRcfEirLBnqu+2f/i0ziGPl2c2yxMbMUA4Eo0VdaLY=;
        b=LUjvefqqMRXOWFfzpqFYkegn36sjowDrzDtRyXzfIaSsZRIopft4Scr+B4YvEnIX5Q
         h8jJMr7CgS9KtqATB45uKHjqBXF84yAUM1bT07ClpJ8pEPuzSClwlRcbIuXFnNenGnpA
         Vc2XJg5jCzvYIPkCygpuvO2K6H3pmz319nUbYuHQhLCQdoYLATNkFhRNFZ/ZdmV0gmk+
         1GfwH/pInRggjWrSYvb7kAbzBD2KLtr3BjpWH9g0I7MLNkeFH/chmyT9epd9roJdoU7Z
         I6CjMVIbwXwqlGqWL2lI1tfwve0haBVxL3YhpnL1kD9RoM+dAcfEVYn04t5NO3CunMvw
         mGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405814; x=1696010614;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YWRcfEirLBnqu+2f/i0ziGPl2c2yxMbMUA4Eo0VdaLY=;
        b=bwZ+6WY2s+QOgh1LFfX1lquoz0YDizwIhn5F0+JOOcfGm30KqCwXYjQq7v+wrB7qsA
         Pva392tFolV2wN6voOqTK/t83hAtsX5DvGm+bQKkAuifEg17ZJy8woE4LkeUxEvFEDi3
         wK/NtBqnZxj3P+0eftkVZPdaazD6gWZPs97Ggi1y6mwvGM2HGHkcQkfXq0zSe0jPNPJK
         KoG+2Z2MyOD5b9JngsvROgo2QXzHOVaKJm0MAGobh3dWyoOBymEV4UkFp5yWLhGCXaOM
         +jF97jw7QfkKWZW+ZCv0ZfY89b370PJWoIw1L0M8zzYuWl1bBaaS4mxv7qCHmew+qOD0
         f1mw==
X-Gm-Message-State: AOJu0YwXlVuz6ixeVzKOofz74Zph68MJb/rNjPvd5SXaVma1Z7/8FvMY
        LQUXRy+8AAMKln9a8ragjnZcugw5qcqsGGiQnhDWFA==
X-Google-Smtp-Source: AGHT+IGA4lV407J2PNGlN1Ck3nndl90O79nsg9m6IlHFRJrs++uTkePr3y78Cx6b+cPt4B3AL2UbI9K5VvDmHx7i/kc=
X-Received: by 2002:a17:902:da8e:b0:1c3:39f8:3e72 with SMTP id
 j14-20020a170902da8e00b001c339f83e72mr25102plx.22.1695405813820; Fri, 22 Sep
 2023 11:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez12VN1JAOtTNMY+Y2YnsU45yL5giS-Qn=ejtiHpgJAbdQ@mail.gmail.com>
 <20230816161758.avedpxvqpwngzmut@revolver> <CAG48ez3mcH-ms0piv7iMcB_ap+WDgkE_ex6VHSZw_Aw30-Ox8g@mail.gmail.com>
 <20230816191851.wo2xhthmfq7uzoc3@revolver> <20230922161919.6ct5c7tj35r4ex7m@revolver>
 <20230922175232.gneuhwhzs4moql5u@revolver>
In-Reply-To: <20230922175232.gneuhwhzs4moql5u@revolver>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 22 Sep 2023 20:02:57 +0200
Message-ID: <CAG48ez3iDwFPR=Ed1BfrNuyUJPMK_=StjxhUsCkL6po1s7bONg@mail.gmail.com>
Subject: Re: maple tree change made it possible for VMA iteration to see same
 VMA twice due to late vma_merge() failure
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 7:52=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> ...
> >
> > Looking at this, I think it's best to make a label and undo the
> > vma_prev() with a vma_next() - at least for now.
> >
> > I'm also reading this for the error path on dup_anon_vma() failure, and
> > it appears to also have an issue which I'd like to point out here befor=
e
> > I send the fix for the first issue.
> >
> > -----------
> >                 vma_start_write(next);
> >                 remove =3D next;                          /* case 1 */
> >                 vma_end =3D next->vm_end;
> >                 err =3D dup_anon_vma(prev, next);
> >                 if (curr) {                             /* case 6 */
> >                         vma_start_write(curr);
> >                         remove =3D curr;
> >                         remove2 =3D next;
> >                         if (!next->anon_vma)
> >                                 err =3D dup_anon_vma(prev, curr);
> > -----------
> >
> > Since dup_anon_vma() can fail, I think here in case 6 we could overwrit=
e
> > the failure.
> >
> > That is, we will fail to clone the anon vma and mask the failure if we
> > are running case 6 with an anon in next.  Once the first dup_anon_vma()
> > returns error, the next call to clone curr vma may return 0 if there is
> > no anon vma (this, I think _must_ be the case). Then we are in a
> > situation where we will be removing next and expanding prev over curr
> > and next, but have not dup'ed the anon vma from next.
> >
>
> I think I am incorrect in the error being overwritten because we won't
> call dup_anon_vma(prev, curr) if the source of the previous call (next)
> has an anon vma.

Hm, yeah. It looks pretty dodgy and I guess it could use a comment,
but as you said, it seems to actually not be a problem...

We could do "err |=3D dup_anon_vma(...)" there for clarity instead, as
long as the only thing we care about is whether we have a nonzero
error...
