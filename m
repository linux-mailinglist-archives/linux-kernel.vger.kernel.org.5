Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3AE7A1C68
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 12:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjIOKhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 06:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbjIOKho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 06:37:44 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F478193
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:37:37 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79565370aa3so74538439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 03:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694774256; x=1695379056; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L1M0/0ecR5D/JjO5eCZw5wQnSPeaMytczG5hNDeARmM=;
        b=d9xvhEOmdD+Y9pI2D1c7OQ9Djy+hdNRtfQWeihZmaJ1Z/b5aJQryJV/1ZaAcIM0Npt
         RDO1j+U4/PcDYLRo6mymptUqJOa3r4mHGNUwR9MMTYkKcFlO/vZCwYkfu1j4M5y89bns
         aCgmBVTC2ydEGxkdYwiyzb8SLYQVmfFUzdtBE0s/GYn6LbdsD+WyvPMXwuKxkXud30NI
         ey11CCaDj+mgeWVv2L7d7RCGAqUwRUwqjvN3VVS7JBITZDQiJDmlfbNG/u7lymu41NRe
         Ir26C1yeM5spj6XhVBnKDG0BmQM1gamOSLEEyarmoRbRd3e2RtBEG38TkFxUs2Qt+hny
         xPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694774256; x=1695379056;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L1M0/0ecR5D/JjO5eCZw5wQnSPeaMytczG5hNDeARmM=;
        b=dwP1/Cd7PT/g2DtyoBxIznfnY2ZpviPloGI8UCxFmZDVe7jUt97CKqZjY3kIu7d0Ta
         tQ3tNNfa6+SGbZrsf/r/Gr6TF8/YpX5L4z7BLmhfH6BHQEGlY6PsHVyOPo8AbjxbBy1T
         wpUdL/6LjyIEt9tZ6DUrNBuHunqhRppwRUvJws5Fs/E9qM1ZkDBDxUgvfvm0jFLXIi7B
         9Km1qx79bAy30+h+FJ4R/yUd5ZMIL6e3WnzMIWiI+jwtGtGDjgCA5g1XG8yhd3Y5xjzu
         PP28UsZPJGsrWW7cNUi802IOp6XqxJTv0l9Vqx50NzKG5qOJtu2+Vlfnb+evqcRhsJFj
         9V/Q==
X-Gm-Message-State: AOJu0YwFCDSLFXH0a2gKKeeJW2f8b4X1YHuRK3rLrikpBaKMx13s66FT
        nyfSroMxArNdxx/rMcr902GLQh0cEcw00exMawwrIQ==
X-Google-Smtp-Source: AGHT+IFgxsuOsWk6AFDfPmDxp226TK7N3eIMtQRvYBazzJzhbW4VMOvdKOYSKlIfmLdOxrT9VEgl58EwtzjzStmLNes=
X-Received: by 2002:a6b:d918:0:b0:795:1a7c:486f with SMTP id
 r24-20020a6bd918000000b007951a7c486fmr1140189ioc.14.1694774256505; Fri, 15
 Sep 2023 03:37:36 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <89c2f64120a7dd6b2255a9a281603359a50cf6f7.1693328501.git.andreyknvl@google.com>
 <CAG_fn=WsYH8iwHCGsoBRL9BRM-uzKJ3+RDgrB5DEGVJKLPagVw@mail.gmail.com> <CA+fCnZftKPJ7zDWmPRjxYXQK91DX2eEw0nDNtYW856399v__Hg@mail.gmail.com>
In-Reply-To: <CA+fCnZftKPJ7zDWmPRjxYXQK91DX2eEw0nDNtYW856399v__Hg@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 15 Sep 2023 12:36:56 +0200
Message-ID: <CAG_fn=USVp-HtC=K=BwaNQVCVVeHDRcGSCpF8dS6f9C1Vd8wjg@mail.gmail.com>
Subject: Re: [PATCH 05/15] stackdepot: use fixed-sized slots for stack records
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
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

> > As a side note, kmsan_internal_chain_origin()
> > (https://elixir.bootlin.com/linux/latest/source/mm/kmsan/core.c#L214)
> > creates small 3-frame records in the stack depot to link two stacks
> > together, which will add unnecessary stackdepot pressure.
> > But this can be fixed by storing both the new stack trace and the link
> > to the old stack trace in the same record.
>
> Do you mean this can be fixed in KMSAN? Or do you mean some kind of an
> extension to the stack depot interface?

Yes, I'll just fix this on the KMSAN side.
