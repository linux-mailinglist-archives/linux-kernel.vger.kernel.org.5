Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4902477FF93
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355189AbjHQVOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355176AbjHQVNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:13:34 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BC7358D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:13:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fe32ec7201so8785e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692306812; x=1692911612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdiC6L+abnI7yMaQpQLGz5ktCkS2ADhtdZrEzDNVLG8=;
        b=Qm/4X2ltNOuNAlJpd409MjBCzYTuAx+2qoDtpxCxzf4qxsBEFhk+xlVSwfp+UDzQVg
         TuOi0yv36C+6OqcwDFx4i7jOZ3QDF7MkwcEHjWg9lgb6qFy8a2K2KArY+pE3Ta15CpBJ
         QkrG/caC24wzjH4CgQqPCSnrwX8G2GBFz0lkslHFWaLXwZzWjvOfa1hbK7YX2HP9izU2
         EznBqyWlCTBjZ0/hqNFeRfw9Oh0KxNknVNLyZ4RgUCveVF14OeDQDk+T/io7eS3nmXcu
         2XU0oKikG1lcqu62bSJtbAzcmJ4QJopQ55+YXAz7OMjcWZB6babYixP87i+K26Id8e6S
         6oHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692306812; x=1692911612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdiC6L+abnI7yMaQpQLGz5ktCkS2ADhtdZrEzDNVLG8=;
        b=MFF/9iBwe6mkb0DdXkt+PbIgzzM97KlYRFnL2i0oNS7lMhZOij3g8Dd9Mxe4Ri0Y4a
         5B1o1qJ5XAX22yjJFzHvYTl+LVIVGVrETyxEfmFDDO8Tg9C9MVkjMO2mqIwVuIhmlxrk
         XfrnumM2VURnufCqKjXp1pNGs1CKHaHL1X0Hhu6KwdeApReB8xuEIvuH7qPf0nlCJL1q
         03ruVcjSR2GjF+cc5iWun+RuN3tbYvCt9IyNII27+TnUaJJ9gnE5ueRoUpf1H1nUl9H5
         taSF5+b34LPZLgqkYdpY9U2sOe/vrLnINvKJ81yrWHycrOMkBaP8aYBHE3A+R4nTvsTP
         ugfg==
X-Gm-Message-State: AOJu0Ywrsb+PQlmYsGgwbN11aZ/2Ri/DGGBX2LZYHTrU0dk02rJfSfjc
        L/KqiWYqS6w2YS8Uzm8m++obXspVRQIX/h2VuDwRTA==
X-Google-Smtp-Source: AGHT+IH9NNddBZly34N9t4E6nIZ7GKWeYNNMS9wh7+N4YqplEB897dU/NG0Yfby50L3o03C0RH9TR06fJz5AOgz4SYM=
X-Received: by 2002:a05:600c:3ca1:b0:3fe:cd3a:ef92 with SMTP id
 bg33-20020a05600c3ca100b003fecd3aef92mr2871wmb.6.1692306811600; Thu, 17 Aug
 2023 14:13:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230812210053.2325091-1-zokeefe@google.com> <PUZP153MB06358FF02518EF3B279F5DD4BE16A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
 <CAAa6QmSrwe2m4MjS9mGO+DeGNGSv=B2uZ72EAxnZk2jsDh39rQ@mail.gmail.com>
 <ZNp7JDaPhT3Se4de@casper.infradead.org> <CAAa6QmSN4NhaDL0DQsRd-F8HTnCCjq1ULRNk88LAA9gVbDXE4g@mail.gmail.com>
 <ZNrh6w9ICu4rMrhV@casper.infradead.org> <CAAa6QmTA8aADSYbpxXU8kne0KqyeY7fCw5_QYSj0T7bCtPKmfA@mail.gmail.com>
 <ZN4QFNZlx8mK9pQm@casper.infradead.org> <CAAa6QmTi99exY+NtNDZFi74cs7AB2xpaZ_kej3pSaZVdAtbrKA@mail.gmail.com>
 <ZN5um2yIXFcxiFjS@casper.infradead.org>
In-Reply-To: <ZN5um2yIXFcxiFjS@casper.infradead.org>
From:   "Zach O'Keefe" <zokeefe@google.com>
Date:   Thu, 17 Aug 2023 14:12:54 -0700
Message-ID: <CAAa6QmSGnXS3t-=i7RdBvqD9XXHhSg1Y9bZU4Dzg903UjZspUw@mail.gmail.com>
Subject: Re: [EXTERNAL] [PATCH] mm/thp: fix "mm: thp: kill __transhuge_page_enabled()"
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Yang Shi <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Thu, Aug 17, 2023 at 12:01=E2=80=AFPM Matthew Wilcox <willy@infradead.or=
g> wrote:
>
> On Thu, Aug 17, 2023 at 11:13:36AM -0700, Zach O'Keefe wrote:
> > > > IIUC then, there is a bug in smaps THPeligible code when
> > > > CONFIG_READ_ONLY_THP_FOR_FS is not set. Not obvious, but apparently
> > > > this config is (according to it's Kconfig desc) khugepaged-only, so=
 it
> > > > should be fine for it to be disabled, yet allow
> > > > do_sync_mmap_readahead() to install a pmd for file-backed memory.
> > > > hugepage_vma_check() will need to be patched to fix this.
> > >
> > > I guess so ...
> >
> > The easiest and most satisfying way to handle this -- and I think we
> > talked about this before -- is relaxing that complicated
> > file_thp_enabled() check when the file's mapping supports large
> > folios. I think that makes sense to me, though I don't know all the
> > details fs-side. Will we need any hook to give fs the chance to update
> > any internal state on collapse?
>
> If the filesystem has per-folio metadata, we need to give the filesystem
> the chance to set that up.  I've vaguaely been wondering about using the
> ->migrate_folio callback for it.  At the moment, I think it just refuses
> to work if the folio isn't order-0.

Ok, no free lunch here then. I'll give myself a reminder to come back
here then and dig a little deeper. Thanks Matthew

> > > > But I have a larger question for you: should we care about
> > > > /sys/kernel/mm/transparent_hugepage/enabled for file-fault? We
> > > > currently don't. Seems weird that we can transparently get a hugepa=
ge
> > > > when THP=3D"never". Also, if THP=3D"always", we might as well skip =
the
> > > > VM_HUGEPAGE check, and try the final pmd install (and save khugepag=
ed
> > > > the trouble of attempting it later).
> > >
> > > I deliberately ignored the humungous complexity of the THP options.
> > > They're overgrown and make my brain hurt. [..]
> >
> > Same
> >
> > > [..] Instead, large folios are
> > > adaptive; they observe the behaviour of the user program and choose b=
ased
> > > on history what to do.  This is far superior to having a sysadmin tel=
l
> > > us what to do!
> >
> > I had written a bunch on this, but I arrived to the conclusion that
> > (a) pmd-mapping here is ~ a free win, and (b) I'm not the best  person
> > to argue for these knobs, given MADV_COLLAPSE ignores them entirely :P
> >
> > ..But (sorry) what about MMF_DISABLE_THP?
>
> Yeah, we ignore that too.  My rationale is -- as you said -- using the
> PMDs is actually free, and it's really none of the app's business how
> the page cache chooses to cache things.

What should be done to be consistent with the collapse side here, for
file/shmem if at all? Answering the question, "can this memory be
backed by THPs" is becoming really complex, and that THPelligble smaps
field is becoming increasingly more difficult to use.
