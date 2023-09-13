Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC4379EFF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjIMRLR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIMRLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:11:13 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C127D91
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:11:09 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-273ca7ab3f5so47741a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694625069; x=1695229869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D31NnAlVX5Nwr4SVKiIWrR2mdDlx525lDafc4aXdb/s=;
        b=cCXLtaKNSk2R6I5ywPWb//Z2ajBJLxWam2qb8dkp8uaJVtAIjvTW9Gn1xv9H69GVQl
         FXt1020abyL41t59SqvygGNcoo7nt6pfil6f4yG92IHXSk8/oUg06on2malKhIfAoBta
         T9PUY7XrGq2y6oqn09LcUQz4UvDW6ZNwTn4wts1XYSsaNJZDrShGvtOUJDETBwhpyx8/
         B4j2xtZll8t+IMlEU4KQlITxcxQ0o/Cw/+8XIqrtpZNu8u1dEkJy78TT6xjsSgSve9Io
         l0mtVb8a7ip1bab0ch0i0w44/9/se6rJ7FmcGw4fpLbigY+MS2ruD/Ud1+VeDsZIYNxy
         7Pig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694625069; x=1695229869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D31NnAlVX5Nwr4SVKiIWrR2mdDlx525lDafc4aXdb/s=;
        b=mjHntz9RUnE2vLs1QDQCCtvdGNE+s5JWa0IDUwwR54bs2x4sxBXUfn9wGWJYvNoirm
         4DiffVVK8lXBCqqhGwlITadXUskDgyhyXwojtGe6xR2xLZwiyBuuoKmjz52c3+0a0pRs
         pP2piAO+FEIKwW0b6us/AYqca9E3vamtV9N00M/Qki1+DHF7duB7ZMNZC2k5h8ITnxxJ
         PQIpiCPW4RrCy3cZ6NCkWOTjWXA4kV735ZxKNIv7TfoC5YKWE/zgk2StFSlNpSngjBvM
         CQfRXvyoCD8rnj/Dgn5hjYpdy+z0ehBPSohT270BNr//MSEkfq1Wi5Tnm69ige3L1nZX
         P/gA==
X-Gm-Message-State: AOJu0Yzi5GGxKM1Q586rgKVTi4hM6qUMhCyYl9r+6muGpupFMqMWGCEd
        u++dnJ1elh4PguGQgguDPjNlNtQTfGYShmfOJMM=
X-Google-Smtp-Source: AGHT+IHJBrpc+51Wtf9cEI/jY8K45N8F3VDEx/1h6NR6LwF4lgqOW46uLJMdOZT66ww/3TlWoZ2DAV9oNIPpyGNvScE=
X-Received: by 2002:a17:90b:f17:b0:268:2d92:55d3 with SMTP id
 br23-20020a17090b0f1700b002682d9255d3mr2851674pjb.39.1694625069172; Wed, 13
 Sep 2023 10:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <3948766e-5ebd-5e13-3c0d-f5e30c3ed724@suse.cz>
 <CA+fCnZdRkJTG0Z1t00YGuzH4AFAicGUVyxFc63djewRz0vj=pQ@mail.gmail.com> <3a372d658246c5dd1ab1d95f4b601267b0fb154e.camel@mediatek.com>
In-Reply-To: <3a372d658246c5dd1ab1d95f4b601267b0fb154e.camel@mediatek.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 13 Sep 2023 19:10:57 +0200
Message-ID: <CA+fCnZf7eHV3Mb27x6HnNyS9RoS2AYQTtYxxLrv5QXKhMKEqcg@mail.gmail.com>
Subject: Re: [PATCH 00/15] stackdepot: allow evicting stack traces
To:     =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>
Cc:     "vbabka@suse.cz" <vbabka@suse.cz>,
        "andreyknvl@google.com" <andreyknvl@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "elver@google.com" <elver@google.com>,
        "eugenis@google.com" <eugenis@google.com>,
        "andrey.konovalov@linux.dev" <andrey.konovalov@linux.dev>,
        "glider@google.com" <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 5, 2023 at 4:48=E2=80=AFAM 'Kuan-Ying Lee (=E6=9D=8E=E5=86=A0=
=E7=A9=8E)' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> > > 3. With the number of stackdepot users increasing, each having
> > > their
> > > distinct set of stacks from others, would it make sense to create
> > > separate
> > > "storage instance" for each user instead of putting everything in a
> > > single
> > > shared one?
> >
> > This shouldn't be hard to implement. However, do you see any
> > particular use cases for this?
> >
> > One thing that comes to mind is that the users will then be able to
> > create/destroy stack depot instances when required. But I don't know
> > if any of the users need this: so far they all seem to require stack
> > depot throughout the whole lifetime of the system.
> >
> Maybe we can use evition in page_owner and slub_debug
> (SLAB_STORE_USER).
>
> After we update page_owner->handle, we could evict the previous
> handle?

We can definitely adapt more users to the new API. My comment was
related to the suggestion of splitting stack depot storages for
different users.

But actually I have a response to my question about the split: if each
user has a separate stack depot storage instance, they can set the
maximum stack trace size as they desire, and thus save up on memory.
