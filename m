Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B372D76C043
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjHAWOM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjHAWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:14:11 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8871BC3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 15:14:09 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bcaa6d5e2cso1796030a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 15:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690928049; x=1691532849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpNjvdyqURVpJ2zUI1mEAiHbIdULXSwVnHK8BVQhnhU=;
        b=4SMyoopMgqoEw0/F6B5MkJennZdxMY2EtGO2rfkv6UnELFUnWA5Vg6jl+P/m7tKwvd
         2+FP33M7rwHe3mrVYq3RXK/tuUJ4kBPz76+GmvDDDo+Oe+d/qnTHjlMF1MxSKIEwRGMo
         F00Hf+vxcbas/ajrgyfqBaPIlHeytFhZ5INR+Ax31S8hxpYRYFceOs32LgzCRI54TUEW
         opSH1X7BJMeMX6cEQdUH9OqNvAJJ056NV2bdOpbnWGB0UWKih10N/g6Ozg9c0L7+T/8d
         b4VvZRxjwLWgChBZ8uXy4ndGXEgOZOLFqe9ZNKlqHSZkYh3JtvscUZpj4pUPHWLMIVBT
         tUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690928049; x=1691532849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WpNjvdyqURVpJ2zUI1mEAiHbIdULXSwVnHK8BVQhnhU=;
        b=YXAYZxhQb8vYlS6SAEdqp5tlSAeHX3onAYxwdbheVlELb+4SZD5ZICpDrMUvmVZIGJ
         uVoXQ7S+xR70XVMjXIXdXcA1YciwA4AjE0j8Zi14ewamG39RyY4TTY5VtwUuSDxfs47u
         v1afxLbnohoPlRS8bVU0W8HctPpamL3/vx9eRV+uBqKON4ezUOd8FqHYqgIy0tDDB/Oh
         n1HGFPYkskradazq9k8V/xdqivzVNZ98ryk9SJqcDMMDc53mWtkjoT1eufUQ7qvVHVro
         ZtglbHmgnwm2c2kxIqGeWlkWrTcyFJlSkdFI98/GleZaQdMmjoGt6RPxwawWa4/9eBy9
         Y+sQ==
X-Gm-Message-State: ABy/qLZKRaGihcO0/k1mo1m7pOCGYbheNej1Z2atuMAF/X5zcmf2/jgG
        2i4HW5MIbGWeYHAteNpKQ2GHpTcS/RY4Jl4PmWGZfg==
X-Google-Smtp-Source: APBJJlE8GREzg52Zu/8+K0wDx3mHcyDe2LUEP4ybOfNAM7BlHzGg7YgywGt4VVG7BPJEVRJPtQHvkINFBy+onuKKviw=
X-Received: by 2002:a05:6830:44a:b0:6b9:1917:b4af with SMTP id
 d10-20020a056830044a00b006b91917b4afmr14757444otc.33.1690928048966; Tue, 01
 Aug 2023 15:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230731171233.1098105-1-surenb@google.com> <20230731171233.1098105-2-surenb@google.com>
 <CAHk-=wjEbJS3OhUu+2sV8Kft8GnGcsNFOhYhXYQuk5nvvqR-NQ@mail.gmail.com>
 <CAJuCfpFWOknMsBmk1RwsX9_0-eZBoF+cy=P-E7xAmOWyeo4rvA@mail.gmail.com>
 <CAHk-=wiFXOJ_6mnuP5h3ZKNM1+SBNZFZz9p8hyS8NaYUGLioEg@mail.gmail.com>
 <CAJuCfpG4Yk65b=0TLfGRqrO7VpY3ZaYKqbBjEP+45ViC9zySVQ@mail.gmail.com>
 <CAJuCfpF6WcJBSix0PD0cOD_MaeLpfGz1ddS6Ug_M+g0QTfkdzw@mail.gmail.com>
 <ZMl6c+bVxdWW0YnN@x1n> <CAJuCfpG0zACcu3JrU4zWLT4rgOmTThm3N0FaHTsFthCxsBApkQ@mail.gmail.com>
In-Reply-To: <CAJuCfpG0zACcu3JrU4zWLT4rgOmTThm3N0FaHTsFthCxsBApkQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 1 Aug 2023 15:13:56 -0700
Message-ID: <CAJuCfpGN+YE+w08cmMw9py_QrPBWNMVG=JGt=3sAWPZKhmnDTg@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: enable page walking API to lock vmas during the walk
To:     Peter Xu <peterx@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, jannh@google.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, ldufour@linux.ibm.com,
        vbabka@suse.cz, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, hannes@cmpxchg.org, dave@stgolabs.net,
        hughd@google.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 2:46=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Tue, Aug 1, 2023 at 2:34=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote=
:
> >
> > On Tue, Aug 01, 2023 at 01:28:56PM -0700, Suren Baghdasaryan wrote:
> > > I have the new patchset ready but I see 3 places where we walk the
> > > pages after mmap_write_lock() while *I think* we can tolerate
> > > concurrent page faults (don't need to lock the vmas):
> > >
> > > s390_enable_sie()
> > > break_ksm()
> > > clear_refs_write()
> >
> > This one doesn't look right to be listed - tlb flushing is postponed af=
ter
> > pgtable lock released, so I assume the same issue can happen like fork(=
):
> > where we can have race coditions to corrupt data if, e.g., thread A
> > writting with a writable (unflushed) tlb, alongside with thread B CoWin=
g.
>
> Ah, good point.
>
> >
> > It'll indeed be nice to know whether break_ksm() can avoid that lock_vm=
a
> > parameter across quite a few function jumps. I don't yet see an immedia=
te
> > issue with this one..  No idea on s390_enable_sie(), but to make it sim=
ple
> > and safe I'd simply leave it with the write vma lock to match the mmap
> > write lock.
>
> Thanks for taking a look, Peter!
>
> Ok, let me keep all three of them with vma locking in place to be safe
> and will post v2 for further discussion.

v2 posted at https://lore.kernel.org/all/20230801220733.1987762-1-surenb@go=
ogle.com/

> Thanks,
> Suren.
>
> >
> > Thanks,
> >
> > --
> > Peter Xu
> >
