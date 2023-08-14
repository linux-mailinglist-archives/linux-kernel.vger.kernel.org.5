Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8BB77C149
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjHNUHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjHNUG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:06:57 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B2C910C8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:06:56 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d62bdd1a97dso4805333276.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692043615; x=1692648415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1RQBQR/MAT6mtkRSBLye6IJ4VHPL4IQK3Vm3WdtiNU=;
        b=imu/s4fyVMvlWWpKp8piuwCJw3qnyxyzhsyh+A8zI1BeWVRWddA2DC5GebTsvOHTTm
         /MS3ynNjGPWHtuS5Qk/laq1K6eu13RLOntrXxzz/LKKPwna3qsN8UJak9Faz5ZZbhwAg
         vA7LUKTKIvH7/PkD02qiU8G8uQBLUER0yKZ4lnWDhLTyew8ZDSwSLdaUj9rwqYV7Miq+
         /CnYTwAlI/TF7x5+wRe2fiZQYxl952G0eTLk4yCYV/lIcaPkal+h1M8ATizQQtpJPqU6
         djEW6RzdQxUK6EfCOK4bwC+gz4SSA6AsR14zuD6g7BoFoNzAAQnVXrBgVrdT/gqg0s2X
         PzaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692043615; x=1692648415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1RQBQR/MAT6mtkRSBLye6IJ4VHPL4IQK3Vm3WdtiNU=;
        b=Tlq+WnzVyxn8pxGZDzDbzyBwujn3ObKOTcNMLVg4go7phhRrbOotNyf/7uxjx+9vMV
         8P2Mh/Pcb+6/rLFLQcXSoG/liLdToaFPTYOFLCWhQcGcZyEpmdMvCT+xiacK3T29BiV0
         6vh2n5qvTygFZ3os47uOoUcd8LMgfRjeM5HGait6gE1GT3WM0u3nmC4THZdeOeq1J/eP
         RerWDn9vpnY65zhkyrLlsQ1RxgZJ4SRxp9DqcqBUa2SumdOoRxgnU9dr2H9aShOsgepI
         uONC4CYIpFWwRwZ/Ws+mlaymE2f6W1NSLqVTrOGL7gxEmF9kb/y/49gTY08fqUhAzSM4
         yZZg==
X-Gm-Message-State: AOJu0YzbHWMtuLOyHnEMOUIdJBvoXlKe48ftFk7UtN23TVtsShniJMOy
        CnLYlHdH72BE40nf0Ldpsn04Rwkn1v8QzClDaVIjnw==
X-Google-Smtp-Source: AGHT+IGO4ICTwdePwp+mfoAA0rvSkF+6YukKJ8MuhcGINvMEj4kcA6FIWTcYRe0eyhPM1IlJImGo++yGi+dLw00Oc90=
X-Received: by 2002:a25:84d1:0:b0:d12:1094:2036 with SMTP id
 x17-20020a2584d1000000b00d1210942036mr10534671ybm.43.1692043615117; Mon, 14
 Aug 2023 13:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230804152724.3090321-1-surenb@google.com> <20230804152724.3090321-6-surenb@google.com>
 <CAG48ez0XCXoXbSR6dyX7GUQYJKRFKQsHuye5q-PLU3-gR5of5A@mail.gmail.com>
 <20230814121521.83c2dda21765757d272538b2@linux-foundation.org> <CAG48ez1U5RW6ZJxc9wK4vo8qMJcQ0t+H8z-h4V_E8dkVAomSAQ@mail.gmail.com>
In-Reply-To: <CAG48ez1U5RW6ZJxc9wK4vo8qMJcQ0t+H8z-h4V_E8dkVAomSAQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 14 Aug 2023 13:06:44 -0700
Message-ID: <CAJuCfpGODc=PpJFR2gUgpTAfn1sufvWWxQL5kGaHQ3dBpa1z1g@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] mm: always lock new vma before inserting into vma tree
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
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

On Mon, Aug 14, 2023 at 1:02=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> On Mon, Aug 14, 2023 at 9:15=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> > On Mon, 14 Aug 2023 16:54:01 +0200 Jann Horn <jannh@google.com> wrote:
> >
> > > > @@ -403,6 +403,8 @@ static int vma_link(struct mm_struct *mm, struc=
t vm_area_struct *vma)
> > > >
> > > >   vma_iter_store(&vmi, vma);
> > > >
> > > > + vma_start_write(vma);
> > > > +
> > > >   if (vma->vm_file) {
> > > >  mapping =3D vma->vm_file->f_mapping;
> > > >  i_mmap_lock_write(mapping);
> > >
> > > The "vma_start_write()" has to be ordered before the
> > > "vma_iter_store(&vmi, vma)".
> >
> > Thanks.  This?
> >
> >
> > --- a/mm/mmap.c~mm-always-lock-new-vma-before-inserting-into-vma-tree-f=
ix
> > +++ a/mm/mmap.c
> > @@ -401,10 +401,10 @@ static int vma_link(struct mm_struct *mm
> >         if (vma_iter_prealloc(&vmi, vma))
> >                 return -ENOMEM;
> >
> > -       vma_iter_store(&vmi, vma);
> > -
> >         vma_start_write(vma);
> >
> > +       vma_iter_store(&vmi, vma);
> > +
> >         if (vma->vm_file) {
> >                 mapping =3D vma->vm_file->f_mapping;
> >                 i_mmap_lock_write(mapping);
>
> Yes, thanks, that looks good.

Ack. Thanks!
