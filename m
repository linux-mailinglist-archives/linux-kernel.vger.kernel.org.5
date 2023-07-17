Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8017575701B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 00:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjGQW7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 18:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjGQW73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 18:59:29 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6CE19A5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:58:57 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-7837329a00aso265014739f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 15:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689634737; x=1692226737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z2GaBF+0ln3vb7USZCDTVgQFqlOXmTLeKB1QLPcmbts=;
        b=WWFDMXFkqBoiTMP5bib4Co6iQEK/zv7BpKmKec0j2AnZTDRPwE5JSCEfWiFxcPT48z
         4qy71BkpKQVL4FQze4gl4mDVwgYNNEoAXpQbR6svZ+Q2gVbBtoq0mu2QEIOGZUpHwc/3
         OLdfFZxJnzNqXD26JbOnxvoXUDeuMQGPyC7sGzabB7OaUJ3rLsvHU31IlJWEkqD/PMiT
         oNsafW2YiteodbxN+TVLSmaVhej2gfSidqcZdbeWbfAWCntDJkwml6kwxeosiuzd6gSu
         EwlQOxi654ylvgR0c3F6XteQIENs3+enWOPwMS1n45P3dk95ZCoLIZKlbX+EuQu1Kjks
         Sx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689634737; x=1692226737;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2GaBF+0ln3vb7USZCDTVgQFqlOXmTLeKB1QLPcmbts=;
        b=B5n4W+5jkJ1L3O86rKkEhrzpqbVNSRphMch64IiDJyH8+VTZDJjC8HCxN8qDOKCTEf
         iYm+8e7OBkjUa6C7EnG0JCCNTTPzGaj3tedy/TnnZbA4VoB/gc21OSQSG9V/J4HnzYpG
         kD2HRpkgR5rdBDS0CbCbClahBZMcrnmuAJK/jkc2o3tuWgDHx0VKzWLFQ0HUyGcVYHja
         n+/bWZ1WPxue1DDYXOYQjwx4bCRzjgC4KrY/irFf/MTWnhaUYPI+U2RHbBDO2bF3kAeq
         SbCggNRgWi1/x9yFzjRpnEAIx1dV0qgf/hPqzfzV0pUxgAxCN3H/7qsq48pEBssVJexW
         kImg==
X-Gm-Message-State: ABy/qLYy4oSIru4dF6UEniRaPzxCk9Y7g72MFpBAulQ+s6vlk5XE1x4D
        tMPxztFd5UUsXfYltYyzur5KV54qMmkuxfJna7Y=
X-Google-Smtp-Source: APBJJlFovPQ8Xn3f4t9Z42MDMYAOArrkeTSXZvG7OGL+Bxa+YqybNCnIcl5gcE5H2dzZThSg2Zw4Hpl5vJEimBr5D3Y=
X-Received: by 2002:a6b:f308:0:b0:786:e0d0:78b4 with SMTP id
 m8-20020a6bf308000000b00786e0d078b4mr1037818ioh.9.1689634736753; Mon, 17 Jul
 2023 15:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230714194610.828210-1-hannes@cmpxchg.org> <ZLIVleBYOm4HIGTZ@casper.infradead.org>
 <20230717141250.GA866068@cmpxchg.org> <901409ed-504b-9500-54d8-e42f832e07b0@suse.cz>
 <20230717160227.GA867137@cmpxchg.org> <ZLVnUhXeZ6ptNF2l@casper.infradead.org> <20230717215105.GA909920@cmpxchg.org>
In-Reply-To: <20230717215105.GA909920@cmpxchg.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 17 Jul 2023 15:58:45 -0700
Message-ID: <CAKEwX=N5ruUdkzfvwpXMZWQByCkqP4WJFsJzKVAWkTm8osHeUg@mail.gmail.com>
Subject: Re: [PATCH] mm: kill frontswap
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        konrad.wilk@oracle.com, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 17, 2023 at 2:51=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Mon, Jul 17, 2023 at 05:07:46PM +0100, Matthew Wilcox wrote:
> > On Mon, Jul 17, 2023 at 12:02:27PM -0400, Johannes Weiner wrote:
> > > -   pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%l=
luk %s%s%s%s%s\n",
> > > +   pr_info("Adding %uk swap on %s.  Priority:%d extents:%d across:%l=
luk %s%s%s%s\n",
> > >             p->pages<<(PAGE_SHIFT-10), name->name, p->prio,
> > >             nr_extents, (unsigned long long)span<<(PAGE_SHIFT-10),
> > >             (p->flags & SWP_SOLIDSTATE) ? "SS" : "",
> > >             (p->flags & SWP_DISCARDABLE) ? "D" : "",
> > >             (p->flags & SWP_AREA_DISCARD) ? "s" : "",
> > > -           (p->flags & SWP_PAGE_DISCARD) ? "c" : "",
> > > -           (frontswap_map) ? "FS" : "");
> > > +           (p->flags & SWP_PAGE_DISCARD) ? "c" : "");
> >
> > Is it useful information (to the sysadmin) that zswap is enabled?  If s=
o,
> > we might want to print a "Z" instead of a "FS" here (would need to
> > know whether enabling zswap succeeded ...)
>
> I don't think it is needed in this particular place.
>
> zswap prints to dmesg when it is initialized. And it's easy to runtime
> check in sysfs or in /proc/meminfo if it's enabled - that's where I
> would look first if I checked a system that's showing zswap issues -
> not in the dmesg that may have long wrapped since swapon.
+1
I always use /sys/kernel/debug/* and  /sys/module/zswap/parameters/*
for debugging zswap issues too.
>
> There is also a warning to dmesg if zswap fails to enable for a given
> swapfile. But with the current page allocator implementation this
> can't actually fail.
