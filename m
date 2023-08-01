Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8E676BF7C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 23:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbjHAVqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 17:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjHAVql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 17:46:41 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0681FE8
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 14:46:40 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-ccc462deca6so6285029276.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 14:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690926399; x=1691531199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTaLTuEwmGPK8tN27uBTIdCdSaj9gN4+SfwrhnvaMfY=;
        b=wKkIGL5QEwxPU/tl47JEmFmOAgyw6qmj09012fom2578AWEqp81tCUj9apQdZBhtM3
         DKkRxP/vTZRapL3elEErpnJTE2BYWjFHrNBtrpmWcgLn+86jjjTg1yMRA9dRErCMY0om
         RPOCd+sN77GTewLL9uq7DceIP0PztJ/PC9WSBwb7lRCjhtMpntlwOpDtV9h4+NHYkJzi
         UDY+3Bx2yEb15edjfKNCXAjlzx1RtuBzcHespcqZqRSGNnKSBWNfbxZDFS1tyO3dusSd
         Jc4fqBzfD1oqOeso7ifAeM0e+PoR7x4iP+zAU+ZVx+T3nzRclFxn2j36jlXx4+30EoFM
         6log==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690926399; x=1691531199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTaLTuEwmGPK8tN27uBTIdCdSaj9gN4+SfwrhnvaMfY=;
        b=J9OI9nwlK+j1k8FIjgJats0BLUef0UjuB+qyUC3Fc3Io7RhlVBimzllVgpRJCxrSAv
         1PRwtO0tS3CEFUuHbDcJyV+HiM2aaoSrMaON5G6VfNrB84bShCgpbJiwtKqTCValX5Yk
         XJm2RRa5BtQ1fxLpb+DI+mrt8biZujHZs/1FhxXWcE/ycmT6HeTyShGght6SW9EIhtaM
         ZDPf93NaP74lFSOsaDbbBV1Xe3G317Htg/G/NRjc+jniJFKmROHfDLeXpt2Mz8irovHv
         vZXywTk5tYRj4Fd+m6pgSblRzOZ5qA2Upx1jDBs0SRy2u1UBXVBOX76igkMKGxTQiOzQ
         lr/g==
X-Gm-Message-State: ABy/qLYLe0paF3QGPMWzXRJEju9RXoKBY9bV+DQWaZbyZ9vCaoN3akp0
        qAwbbYcMMkRhhmelcECvNG+s8v3uVaksskJcBfUGrw==
X-Google-Smtp-Source: APBJJlGbul25mQtKTbVH8QL4YR6SlEXQylA/xvu/mfZarFRAKAjRIEsRco7bf0oj8PVUvKUboEMx6Xo9cAK7PZxEhAY=
X-Received: by 2002:a25:cbd2:0:b0:d0d:baae:93 with SMTP id b201-20020a25cbd2000000b00d0dbaae0093mr16326018ybg.39.1690926399468;
 Tue, 01 Aug 2023 14:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230731171233.1098105-1-surenb@google.com> <20230731171233.1098105-2-surenb@google.com>
 <CAHk-=wjEbJS3OhUu+2sV8Kft8GnGcsNFOhYhXYQuk5nvvqR-NQ@mail.gmail.com>
 <CAJuCfpFWOknMsBmk1RwsX9_0-eZBoF+cy=P-E7xAmOWyeo4rvA@mail.gmail.com>
 <CAHk-=wiFXOJ_6mnuP5h3ZKNM1+SBNZFZz9p8hyS8NaYUGLioEg@mail.gmail.com>
 <CAJuCfpG4Yk65b=0TLfGRqrO7VpY3ZaYKqbBjEP+45ViC9zySVQ@mail.gmail.com>
 <CAJuCfpF6WcJBSix0PD0cOD_MaeLpfGz1ddS6Ug_M+g0QTfkdzw@mail.gmail.com> <ZMl6c+bVxdWW0YnN@x1n>
In-Reply-To: <ZMl6c+bVxdWW0YnN@x1n>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 1 Aug 2023 14:46:25 -0700
Message-ID: <CAJuCfpG0zACcu3JrU4zWLT4rgOmTThm3N0FaHTsFthCxsBApkQ@mail.gmail.com>
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 2:34=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Aug 01, 2023 at 01:28:56PM -0700, Suren Baghdasaryan wrote:
> > I have the new patchset ready but I see 3 places where we walk the
> > pages after mmap_write_lock() while *I think* we can tolerate
> > concurrent page faults (don't need to lock the vmas):
> >
> > s390_enable_sie()
> > break_ksm()
> > clear_refs_write()
>
> This one doesn't look right to be listed - tlb flushing is postponed afte=
r
> pgtable lock released, so I assume the same issue can happen like fork():
> where we can have race coditions to corrupt data if, e.g., thread A
> writting with a writable (unflushed) tlb, alongside with thread B CoWing.

Ah, good point.

>
> It'll indeed be nice to know whether break_ksm() can avoid that lock_vma
> parameter across quite a few function jumps. I don't yet see an immediate
> issue with this one..  No idea on s390_enable_sie(), but to make it simpl=
e
> and safe I'd simply leave it with the write vma lock to match the mmap
> write lock.

Thanks for taking a look, Peter!

Ok, let me keep all three of them with vma locking in place to be safe
and will post v2 for further discussion.
Thanks,
Suren.

>
> Thanks,
>
> --
> Peter Xu
>
