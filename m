Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 531C976D88C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 22:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjHBUVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 16:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjHBUVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 16:21:45 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC3D10C7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 13:21:45 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso194772276.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 13:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691007704; x=1691612504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ua/z6hJjJwaKpWnVce2LKpeE5PhDq5AwoL0z00SOjR4=;
        b=064itWtp3kWfEW186lgdqtOYBw/O5OZE00SLFKDPchRuS5vHGdVAh7rm94pcPhRxvC
         e7Pl2vnoPsz8euehcSnFMXZndkStl2qAUnXOISSVhtP9jgtOx+WtBuUZMQgSKkNVxixo
         hjxRWZNoKBi1HgWiArxXBB2w7dpI/rQnwSCrrtvkkqfTs/5bX9Y91cdRsRPmRQT8P7vn
         LJnF7oklLQQi2Rjs3irE7YFZTi9LSXhV+n+yWc7LvBuhm0EdywbRD6y0yKPyPiO9DsZk
         Pmi2tBPJlcAWyKWDAtijPct3C28V3IYhrOljME2Oaom/rK27cB1Tq0crG9liRCUd/srK
         o7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691007704; x=1691612504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ua/z6hJjJwaKpWnVce2LKpeE5PhDq5AwoL0z00SOjR4=;
        b=BON1enFol5vjaG9eash5130Bb6kPQcEBMxxyTGErQdXJRHeM0FoWYSr9a0v0fVYcoZ
         OUyBE/L2ByQkppIYkoIHmB2eJ2eTChsyeABxJ7InDPhj7KO9N7AZuvoMo8f7b4ZIdWEt
         ONdSsif/MUpdblZad0RItvOpyumQWqlnp32TMzCjGvSZTpjHuw4WTK8+jpQa2pn/4Enw
         8ixAQ5v2H/soOmfTVNY6gT/fByyet3jpTYiqtkPJ2iGfTsgwScyGNz8MXJ38RFv07mCo
         CC8oIxJt4N3jhIWuw+uw4wLO56OljwQ+NzXG07HCw73kLTJC+Sj9s/SzltcI/CxR+Lru
         a4Jw==
X-Gm-Message-State: ABy/qLZ1dFpzIdAqL/mqSChlEYhQ1oV19dGSQS/VdW9SV5gAjuly4eF4
        cukAPVvi6SwuROv4d9gkDpUMQmRlcBl47W9wP3bXkw==
X-Google-Smtp-Source: APBJJlEewzNilSK9EhWoCm+pHDq+zrz9nrcvOAL6kD//nIyxF94LiWj7YSvP5Zmqsl4NTrqRtDoNukIk3awhpvJrb5s=
X-Received: by 2002:a25:86ca:0:b0:d06:d1ae:dcf2 with SMTP id
 y10-20020a2586ca000000b00d06d1aedcf2mr12816778ybm.13.1691007704032; Wed, 02
 Aug 2023 13:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230801220733.1987762-1-surenb@google.com> <20230801220733.1987762-5-surenb@google.com>
 <CAHk-=wix_+xyyAXf+02Pgt3xEpfKncjT8A6n1Oa+9uKH8bXnEA@mail.gmail.com>
 <CAJuCfpFYq4yyj0=nW0iktoH0dma-eFhw1ni7v9R-fCsYH7eQ3Q@mail.gmail.com> <CAHk-=wjxQpxK_vOpdcCycR2FGrSHLHZk+GVuVHrAv-8X3=XzUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjxQpxK_vOpdcCycR2FGrSHLHZk+GVuVHrAv-8X3=XzUQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 2 Aug 2023 13:21:31 -0700
Message-ID: <CAJuCfpHG+fR5YZ74QmUXQcAKcDWaTNMB4gzddZPKdjBr0=s9dQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] mm: lock vma explicitly before doing
 vm_flags_reset and vm_flags_reset_once
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 11:54=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 2 Aug 2023 at 11:09, Suren Baghdasaryan <surenb@google.com> wrote=
:
> >
> > Ok, IOW the vma would be already locked before mmap() is called...
>
> Yup.
>
> > Just to confirm, you are suggesting to remove vma_start_write() call
> > from hfi1_file_mmap() and let vm_flags_reset() generate an assertion
> > if it's ever called with an unlocked vma, correct?
>
> Correct.

Got it. Will update in the next version. Thanks!

>
>                Linus
>
