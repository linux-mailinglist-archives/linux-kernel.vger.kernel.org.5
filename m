Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF6979B20B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:57:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbjIKWGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240751AbjIKOwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:52:53 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A01118
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:52:48 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-79536bc669dso154171639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 07:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694443968; x=1695048768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=90PlK9+vusP71rfnLS7AlLwtgErcjzc4R1LcqrGfUdo=;
        b=AFODHrv1HCW5R4ByGM/+dwcW3rksrChIUOU5BcaxuXhwj5XIsKoiJsU5i1Ff9N+fMv
         t7NcrPYPGE8NzsEIpp5KuPq48tpxuhCu/uJisj0W4vlpjlwOFJwcLTj6fEl3uAk3J2oh
         6U89yyR8W05BtzqjvHXEH5aPaS50Tc7sSeHUfLjeE5FlZfpp4KLF7Ude053JigG9ihwH
         CW/mHfGBiUQk0FJ1mvk65SVV1K9RV8gFLhyg0NhsCM4NeS8N2tLuNP2wgG0eP/qw8eyB
         qLPx50sPuDk44p7m+ceCmRtuWZKM7yf7wqiYtx098oue3xVAF1rmVjkpSjUydlYwqKAK
         +sMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694443968; x=1695048768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=90PlK9+vusP71rfnLS7AlLwtgErcjzc4R1LcqrGfUdo=;
        b=NuhfQB0Tilz0/ZqKW3tFJzsYxhXIcENXXR0DJJrQ0C6OmZDNm+3RNtvq1pRh72fcb2
         Oqb+a8q5Okj36zdsXNpICbpIVTLFo2/bsrvrdIrQbjRe1DjYbjLKuSzHmQcWdClStsyV
         /5oyByhi3Y32XMco3OMZFZRaD2aIUZZQt24i0DC/aJGRYYJVK5U8WtGt6A+b4lerYAdA
         r0kqMBD1xk8cJsg3vR7mYxaKCJ7jSRAQ7HDpU+R8CPpRNMRkWf1/zRuvrznNkozHjZhQ
         qMNXzszjv8C7nlw9vW1ml0qx/pmoctaMM6BRdmynN3Q9o0lrJKoSTRNzuLVHtaQJlHMT
         sLhg==
X-Gm-Message-State: AOJu0Ywi4ElA/QI/PEFEf2LGhj1HFWbrvC36W059JS+2m7i87qv+YmGW
        WL92hKh4AAmZXzGzK94fs9l8zJs5I1d8bSO3LqD2cQ==
X-Google-Smtp-Source: AGHT+IGvTbxUjFNWLezCEgG/vtDzsVCoY9+Ws6OsnQP37i0VgZfEUBdu7CtB1oUinFIFB7S3R+7jceTBpPeixY6igig=
X-Received: by 2002:a05:6602:185:b0:790:aa71:b367 with SMTP id
 m5-20020a056602018500b00790aa71b367mr12539404ioo.4.1694443968284; Mon, 11 Sep
 2023 07:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230907130642.245222-1-glider@google.com> <CANpmjNOO+LUgCWHPg4OXLzm9c7N3SNfLm1MsgME_ms07Ad5L=A@mail.gmail.com>
In-Reply-To: <CANpmjNOO+LUgCWHPg4OXLzm9c7N3SNfLm1MsgME_ms07Ad5L=A@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 11 Sep 2023 16:52:07 +0200
Message-ID: <CAG_fn=X9bHcqnFawrKQv=cEVQ0cj4tQL-Cr+iJpAxUGn3ssMxg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kmsan: simplify kmsan_internal_memmove_metadata()
To:     Marco Elver <elver@google.com>
Cc:     dvyukov@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Sep 11, 2023 at 1:44=E2=80=AFPM Marco Elver <elver@google.com> wrot=
e:
>
> On Thu, 7 Sept 2023 at 15:06, Alexander Potapenko <glider@google.com> wro=
te:
> >
> > kmsan_internal_memmove_metadata() is the function that implements
> > copying metadata every time memcpy()/memmove() is called.
> > Because shadow memory stores 1 byte per each byte of kernel memory,
> > copying the shadow is trivial and can be done by a single memmove()
> > call.
> > Origins, on the other hand, are stored as 4-byte values corresponding
> > to every aligned 4 bytes of kernel memory. Therefore, if either the
> > source or the destination of kmsan_internal_memmove_metadata() is
> > unaligned, the number of origin slots corresponding to the source or
> > destination may differ:
> >
> >   1) memcpy(0xffff888080a00000, 0xffff888080900000, 4)
> >      copies 1 origin slot into 1 origin slot:
> >
> >      src (0xffff888080900000): xxxx
> >      src origins:              o111
> >      dst (0xffff888080a00000): xxxx
> >      dst origins:              o111
> >
> >   2) memcpy(0xffff888080a00001, 0xffff888080900000, 4)
> >      copies 1 origin slot into 2 origin slots:
> >
> >      src (0xffff888080900000): xxxx
> >      src origins:              o111
> >      dst (0xffff888080a00000): .xxx x...
> >      dst origins:              o111 o111
> >
> >   3) memcpy(0xffff888080a00000, 0xffff888080900001, 4)
> >      copies 2 origin slots into 1 origin slot:
> >
> >      src (0xffff888080900000): .xxx x...
> >      src origins:              o111 o222
> >      dst (0xffff888080a00000): xxxx
> >      dst origins:              o111
> >                            (or o222)
> >
> > Previously, kmsan_internal_memmove_metadata() tried to solve this
> > problem by copying min(src_slots, dst_slots) as is and cloning the
> > missing slot on one of the ends, if needed.
> > This was error-prone even in the simple cases where 4 bytes were copied=
,
> > and did not account for situations where the total number of nonzero
> > origin slots could have increased by more than one after copying:
> >
> >   memcpy(0xffff888080a00000, 0xffff888080900002, 8)
> >
> >   src (0xffff888080900002): ..xx .... xx..
> >   src origins:              o111 0000 o222
> >   dst (0xffff888080a00000): xx.. ..xx
> >                             o111 0000
> >                         (or 0000 o222)
> >
> > The new implementation simply copies the shadow byte by byte, and
> > updates the corresponding origin slot, if the shadow byte is nonzero.
> > This approach can handle complex cases with mixed initialized and
> > uninitialized bytes. Similarly to KMSAN inline instrumentation, latter
> > writes to bytes sharing the same origin slots take precedence.
> >
> > Signed-off-by: Alexander Potapenko <glider@google.com>
>
> I think this needs a Fixes tag.
Thanks, will add in v2!

> Also, is this corner case exercised by one of the KMSAN KUnit test cases?
Ditto

> Otherwise,
>
> Acked-by: Marco Elver <elver@google.com>
