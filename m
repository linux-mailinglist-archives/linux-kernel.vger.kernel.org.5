Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4A07A0949
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbjINPbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbjINPbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:31:16 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED779CE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:31:11 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-d8165e3b209so2384304276.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694705471; x=1695310271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N5V35/NnoM0NObnhOBjIuAND7i93+ooCq17R/5R/h7s=;
        b=GYKQ1u2K7awF17oe2JiH44KKTijk0Ha54P+8FYeuNn3Zt/gFnKbj9dKXzFc+YhR4jd
         qQ65CyZnvY1Ypu24hdji3LLuX/fy3eG76k42T7+ekBPaBhfbrOJGyd6Aj6OcHFs195FA
         bEkK2jfQVGGCN/pdJgEkCPV9qT/uwv+Zc7z4eUBVINqq1j4z7TtUVGLnntweByaZGeCy
         cOAJDz4sE9lSJQZw0DXvEwJebeQvzidc47pYcjMLYPQ3fJ7unEeFThX0Oer/gh9D5YdL
         yPbTmiW8QvwJOUMcvXz144Z0/qSlEihi0oG1JTutlrIpPqFMHSTOeZ+ZzD+9UqUqMFM+
         SSLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694705471; x=1695310271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N5V35/NnoM0NObnhOBjIuAND7i93+ooCq17R/5R/h7s=;
        b=JLoE8Vy8YcbXT95MPOX35jsBqFlndMtQb6wqxUjpTajMDoakp7nLhgfUt5/dk2vegE
         tVvn79qM715T91D3scHJoBKZhToNz8iThJXvKXHiN8zg0Uv8Sj6uihEu1//ultdFZcs2
         bcI1ktvoei2IjiyM5hXwpLI7W1pV2zzJXnXantWcE6zf1Oeh+/GV5OCtmSmjXWt0D3hC
         Z4vvw0R0aO/OmOn8l6bcc/HfVuY160es1paFC+sw6P6SonHNaLnuG3SQWsYnH2b0y+/o
         vFXCaTIr41vs19ghP+i/5qHzun3IReo4Bu6/faOfJVjkVIQdrrw48mI7/yiBWs3LccjU
         4xng==
X-Gm-Message-State: AOJu0YyD+xIH1NnImYIFzzATdIaSq1JlBoksbQAv7EV1yZgr8kUeFtRv
        eEOzPH9JsRBRa/+WVcJ6Bdt3/56/N/7x5Lm7TQ0m5w==
X-Google-Smtp-Source: AGHT+IGRNemB3RXw5lnQojxPt4q242KuMa887wtWrMqT27slM3o1JOKUjJCDcbfpyv+vd90Hh7Cf4kuU/C2z32ljems=
X-Received: by 2002:a25:a2c7:0:b0:d71:6835:c250 with SMTP id
 c7-20020a25a2c7000000b00d716835c250mr1434596ybn.30.1694705470859; Thu, 14 Sep
 2023 08:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EESO4uO84SSnBhArH4HvLNhaUQ5nZKNKXqxRCyjniNVjp0Aw@mail.gmail.com>
 <ZC8BgFSFC3cDcAcS@x1n> <27ac2f51-e2bf-7645-7a76-0684248a5902@redhat.com>
 <ZDbVMk0trT5UaqaA@x1n> <3059388f-1604-c326-c66f-c2e0f9bb6cbf@redhat.com>
 <ZDghhTH2KtCeAwcZ@x1n> <6403a950-7367-0b00-8cd5-2f0a32dac953@suse.cz>
 <CAJuCfpFddcMRH8pNOE816ZrQr5qvrccxFjJqNj5JRPWkv+u=uA@mail.gmail.com> <CA+EESO6NkpugZa7zh=mj+A0BEqMuS4TKL0cpTm4EWeHgUUVksg@mail.gmail.com>
In-Reply-To: <CA+EESO6NkpugZa7zh=mj+A0BEqMuS4TKL0cpTm4EWeHgUUVksg@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 14 Sep 2023 08:30:59 -0700
Message-ID: <CAJuCfpHEXDiUBGZ1RCiHRyewTQ_6NNG3+PvLQuhn99eCmPbgTA@mail.gmail.com>
Subject: Re: RFC for new feature to move pages from one vma to another without split
To:     Lokesh Gidra <lokeshgidra@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Brian Geffon <bgeffon@google.com>,
        Kalesh Singh <kaleshsingh@google.com>,
        Nicolas Geoffray <ngeoffray@google.com>,
        Jared Duke <jdduke@google.com>,
        android-mm <android-mm@google.com>,
        Blake Caldwell <blake.caldwell@colorado.edu>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 3:05=E2=80=AFAM Lokesh Gidra <lokeshgidra@google.com=
> wrote:
>
> On Tue, Jun 6, 2023 at 4:18=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
> >
> > On Tue, Jun 6, 2023 at 1:15=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz>=
 wrote:
> > >
> > > On 4/13/23 17:36, Peter Xu wrote:
> > > > On Thu, Apr 13, 2023 at 10:10:44AM +0200, David Hildenbrand wrote:
> > > >> So instead, we consider the whole address space as a virtual, anon=
 file,
> > > >> starting at offset 0. The pgoff of a VMA is then simply the offset=
 in that
> > > >> virtual file (easily computed from the start of the VMA), and VMA =
merging is
> > > >> just the same as for an ordinary file.
> > > >
> > > > Interesting point, thanks!
> > >
> > > FYI, I've advised a master thesis exploring how to update page->index=
 during
> > > mremap() to keep things mergeable:
> > >
> > > https://dspace.cuni.cz/bitstream/handle/20.500.11956/176288/120426800=
.pdf
> > >
> > > I think the last RFC posting was:
> > > https://lore.kernel.org/all/20220516125405.1675-1-matenajakub@gmail.c=
om/
> > >
> > > It was really tricky for the general case. Maybe it would be more fea=
sible
> > > for the limited case Lokesh describes, if we could be sure the pages =
that
> > > are moved aren't mapped anywhere else.
>
> It's great that mremap is being improved for mereabilitly. However,
> IIUC, it would still cause unnecessary splits and merges in the
> private anonymous case. Also, mremap works with mmap_sem exclusively
> held, thereby impacting scalability of concurrent mremap calls.
>
> IMHO, Andrea's userfaultfd REMAP patch is a better alternative as it
> doesn't have these downsides.
>
> >
> > Lokesh asked me to pick up this work and prepare patches for
> > upstreaming. I'll start working on them after I finish with per-vma
> > lock support for swap and userfaultd (targeting later this week).
> > Thanks for all the input folks!
>
> Thanks so much, Suren!

I just posted the patchset at
https://lore.kernel.org/all/20230914152620.2743033-1-surenb@google.com/.
I tried to keep it as true to Andrea's original as possible but still
had to make some sizable changes, which I described in the cover
letter. Feedback would be much appreciated!
