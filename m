Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2183376BE76
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 22:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjHAU3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 16:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjHAU3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 16:29:12 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E0F127
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:29:10 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d18566dc0c1so6387087276.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690921749; x=1691526549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXeNNNuvrp7+VHxvQXq6s6V+CxnvfhC2OBXKfNUDQhw=;
        b=ik7XI1ruE5Zqj9xue4GM0QDvoBivebS1U2K38G6kd1mdfJjkjlnkAesgMqGeIkbXX5
         1jUBy8/DPyDNRgYE3D+dKOp0f4o62XSX9LXwz4CwLhBx/ZODVwcEZvCSgaemaCBTDfjR
         bP//Uzj0YhAg4mGakETi5/RI6RMha/Bl72+xXEXnNlEWQWSX/AEraeMY+g15ahH5W11M
         mBvLvDbvHwyXvKFeiU9SwH/Kdats8OpEDw8fWwCV4G8Gs3pmWACHOQiZj60QE4H2iHoh
         Ih3M4cXihRmCLHAOmRezIMHF3ic4Nzty6LAS+8e+mDhB1NubTK58OG76UeWdxt3DyWug
         a3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690921749; x=1691526549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXeNNNuvrp7+VHxvQXq6s6V+CxnvfhC2OBXKfNUDQhw=;
        b=iuBxx1pPgZCiwBWiCQ8+fIOsdax6XA2eXUBXxkDGkON0iqLAMsQo4nAqG6GHQqB7QI
         r2OUSKbS9+ibyH0SfQKebZx2w7mfVlqV4JKT8+vambaKAZK44B4NH8rSHRmzCP4st5Tf
         SZIeIAns6IVWk+ktDkHxBRsFf2JwLDuaVUeEHi1xRGFb4BcT+9yiUwpfIRd5I72zBd7H
         TLZATeWsf3BSSx+g7yX+kgGGavdtJ3pCKgPxhdc7VoVMJjfmG7ro4htYZBnHEz9BylH4
         TEX7PzyYxMVXkEc/PAVQcZ9zmnv403pTKZXetL52i/mN6qOY+SCnyQCVzKtbX4tOZng1
         UlvA==
X-Gm-Message-State: ABy/qLZDfLxyXmAzkmed7TuwM5EBrVYRB4IesUBp7QuKX2i8jT8QI/Hr
        6AEu+xHXI3ucbDKRUzG6NMPsF5fBw5WMnDIpwKJMCA==
X-Google-Smtp-Source: APBJJlE8MPQmOaM3BSoGV84Nze8nav3rYtjGP81Mve7WcHRieuJTXEakgSrEFuU3KLqePoU23dmE8sp2J7UpJEsGIbw=
X-Received: by 2002:a25:455:0:b0:cad:347e:2c8f with SMTP id
 82-20020a250455000000b00cad347e2c8fmr14278182ybe.39.1690921749289; Tue, 01
 Aug 2023 13:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230731171233.1098105-1-surenb@google.com> <20230731171233.1098105-2-surenb@google.com>
 <CAHk-=wjEbJS3OhUu+2sV8Kft8GnGcsNFOhYhXYQuk5nvvqR-NQ@mail.gmail.com>
 <CAJuCfpFWOknMsBmk1RwsX9_0-eZBoF+cy=P-E7xAmOWyeo4rvA@mail.gmail.com>
 <CAHk-=wiFXOJ_6mnuP5h3ZKNM1+SBNZFZz9p8hyS8NaYUGLioEg@mail.gmail.com> <CAJuCfpG4Yk65b=0TLfGRqrO7VpY3ZaYKqbBjEP+45ViC9zySVQ@mail.gmail.com>
In-Reply-To: <CAJuCfpG4Yk65b=0TLfGRqrO7VpY3ZaYKqbBjEP+45ViC9zySVQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 1 Aug 2023 13:28:56 -0700
Message-ID: <CAJuCfpF6WcJBSix0PD0cOD_MaeLpfGz1ddS6Ug_M+g0QTfkdzw@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: enable page walking API to lock vmas during the walk
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     akpm@linux-foundation.org, jannh@google.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 1:24=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Mon, Jul 31, 2023 at 12:33=E2=80=AFPM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Mon, 31 Jul 2023 at 12:31, Suren Baghdasaryan <surenb@google.com> wr=
ote:
> > >
> > > I got the idea but a couple of modifications, if I may.
> >
> > Ack, sounds sane to me.
>
> Ok, I'll wait for more feedback today and will post an update tomorrow. T=
hanks!

I have the new patchset ready but I see 3 places where we walk the
pages after mmap_write_lock() while *I think* we can tolerate
concurrent page faults (don't need to lock the vmas):

s390_enable_sie()
break_ksm()
clear_refs_write()

In all these walks we lock PTL when modifying the page table entries,
that's why I think we can skip locking the vma but maybe I'm missing
something? Could someone please check these 3 cases and confirm or
deny my claim?
Thanks,
Suren.

>
> >
> >              Linus
