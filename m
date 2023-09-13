Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2F679EFF0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjIMRIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjIMRIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:08:38 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857402D4A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:08:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-268bc714ce0so921134a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694624890; x=1695229690; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHCrlCbtcAKHLlsdLR6+YB7uDJrcT7OxjXdj9zb8nHQ=;
        b=lpiOfxYlda3URPXteD887n+W2+9v/CmgoM+ImXIxlV+3vSXAXwrTaEPscrp9tnv+rF
         Lm3MJ97lPcJE//T79335J/tmBJt4hLcFokYQpWFQAS18aDYSgFcPurmPj43z1SLj4DAG
         MQ62RTDFrtalK2GF4yaovgN54C4h4AALMT7dstt5BOhXGd8HSydU2SYjRvDX6iZ3uGi2
         xTFNgBtmdyUKgIzh+Hwzb8qIgrPQsAqfFqv6cgSomPaIK1TWRDp3zw9/PJHEFyArUnzR
         DG0LwMP8JOuXAOESvgSj5Og2dctK8oQksNJo0p06zLEJtHsktEIgE+KkYDhQxH3A79Qr
         UX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624890; x=1695229690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHCrlCbtcAKHLlsdLR6+YB7uDJrcT7OxjXdj9zb8nHQ=;
        b=vkH/KZDNPCTnjUaguKKEIk6I20LstEV6nWD5WdeF8lUL8Ct/uT4wYYrAco8DOECoXP
         scc+sp4C5w6VgyXAlJEc3tsGmfitSXi1qFHV+X86E4E3nss8nt1oV9aXbbEopFCCStWz
         LcWqBoYi/IL4cI1b+oJGj5MOWdRk/6xUf+Y0lZUf0FDwMD7fFUNf2OGgIZ49YhM25aYW
         U6Md6t+FFeO4Vy/NGu1mzchnSj82ebmDqtMoRQ0dIffyL4jpomimaQJJGTEawNpU/9fD
         KKwkz3uASzPvCFRGFxTROuXsHdbsuizq6D8zB4yT6omB+R2JYlqpP1GUiWhGAlqrjrm3
         +T5g==
X-Gm-Message-State: AOJu0Yw2+y6QvQwrtTAY3Qzv7Dnr3tC5kMIw1b9Ty3znM2m7DIvi1SwR
        QyOd8T90cCeYmDPOMwgmRGQ9wNv3ZJZiwNaHBGY=
X-Google-Smtp-Source: AGHT+IFJbEx3Sw/jqeQivyJ6WW/GkF6KlPKOGWxdvNvnvus37FBNyXPC32wcXFn6Dg4S4diF/bGGJIUyM+hp9t5C5Qc=
X-Received: by 2002:a17:90b:38c1:b0:26b:455b:8d61 with SMTP id
 nn1-20020a17090b38c100b0026b455b8d61mr8465654pjb.22.1694624889940; Wed, 13
 Sep 2023 10:08:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <306aeddcd3c01f432d308043c382669e5f63b395.1693328501.git.andreyknvl@google.com>
 <ZO8MxUqcL1dnykcl@elver.google.com> <CA+fCnZe2ZRQe+xt9A7suXrYW8Sb7WGD+oJJVWz6Co-KGYghZLw@mail.gmail.com>
 <CANpmjNPYNTTfBAay4J96hm=3tb4kUBH2OwpaCfJxL7rP=aibJA@mail.gmail.com>
In-Reply-To: <CANpmjNPYNTTfBAay4J96hm=3tb4kUBH2OwpaCfJxL7rP=aibJA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 13 Sep 2023 19:07:58 +0200
Message-ID: <CA+fCnZcmFsXNQobD2WGd-CXWA5_3mxTm3C4O79AWz5A8nxHOFg@mail.gmail.com>
Subject: Re: [PATCH 12/15] stackdepot: add refcount for records
To:     Marco Elver <elver@google.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 4, 2023 at 8:56=E2=80=AFPM Marco Elver <elver@google.com> wrote=
:
>
> > WDYT about adding a new flavor of stack_depot_save called
> > stack_depot_save_get that would increment the refcount? And renaming
> > stack_depot_evict to stack_depot_put.
>
> If there are no other uses of stack_depot_get(), which seems likely,
> just stack_depot_save_get() seems ok.

Ok, I will implement a similar approach in v2: add another flag to
__stack_depot_save to avoid multiplying API functions.

Thanks!
