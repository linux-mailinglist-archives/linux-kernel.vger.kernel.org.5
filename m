Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1CB78DAE3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjH3SiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242274AbjH3Hru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 03:47:50 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6222B11B
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:47:47 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-79289fefdbeso148942839f.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 00:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693381667; x=1693986467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTiXECgoGfzw84lh/WoSfah+6f5iJwFeqm4gOKFlKhM=;
        b=6Vl+m5w++DeS+oi01PYWHB7Gj0CamQIEVz0ZY8j7h2UAR230gkn7oV/oKfgiIEhGhN
         OHoTZr3SAdGq9+yfcCr9JbRlkM+llYZQqNa0rfmmK+1uqh/4DzqcuE9/m0yfgDmZVnuR
         CtGtTfJdJk80gt3Vvfc3Y7KgUZ+D2Ic19lGxyaLkY2V1VrV0xu5JTvrwvz85KvwqkZn7
         fav20f90FcPN0NOlyhQQOkLYMLiy5MFlzEW763XpMrNVM+qP3a/xLS3jonusEKWFbDNR
         iAH9U8OcPkhlAiRpHzcz/8MlsAKj8m1Y7b4qG5ztsccjto/fLxAkiMj3tDs/BgELVNC9
         65AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693381667; x=1693986467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTiXECgoGfzw84lh/WoSfah+6f5iJwFeqm4gOKFlKhM=;
        b=d0XEOl65AUtYVGJHk/2uKAKEmCZdPHywD9rSCEenc+QrFZGmGx2UYJwDetrSTjEOVP
         Is6k8Izk4EWpnQN3P0bEIv6IoIRVSbg8aFOZHi2xuJ4T9753P34ajlnbsKDdyQMOaMWf
         EWb2xAJjaGks5w0kqXyMsozZpEZAh6Y2ROXYRaMcheCG3tFJqEp2/aAnkP3pYp1ofwK/
         PcETmQvt87axDbN/e2VI6STyPWAyFnqfV5a6i5AwleuQrFDcx7bPCrMMPTSupTYuTHeJ
         VwElHRl3Aq7xNHp2WRAQf/Ow55sJRLWfuETObHDmCcBXQwnsUu/1zj0Ew0oizt58IDiC
         Rsgg==
X-Gm-Message-State: AOJu0YwMMX90Otu/Z2qe5FYLhJ6j1ocmfryjo1ZazIjlmZPzJH2wwuCh
        +cgJaH/h6FoLo8yoxSvJXCvTNO6epFuNdx5KW95vqw==
X-Google-Smtp-Source: AGHT+IHTGRJeFyoBC6STTnoqGegSbamGHtCsgI8esvXu6k6CixN5PGmnIIHGvFINvGwww8J6Jvpkc5Ap5MlBA/RIZ0w=
X-Received: by 2002:a05:6602:214f:b0:787:4f3c:730d with SMTP id
 y15-20020a056602214f00b007874f3c730dmr1662268ioy.18.1693381666723; Wed, 30
 Aug 2023 00:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <757ff72866010146fafda3049cb3749611cd7dd3.1693328501.git.andreyknvl@google.com>
In-Reply-To: <757ff72866010146fafda3049cb3749611cd7dd3.1693328501.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 30 Aug 2023 09:47:10 +0200
Message-ID: <CAG_fn=XJ-fZTJPqrjcu2PVNzBvg8309M+jT4h_iGraYNN4APmA@mail.gmail.com>
Subject: Re: [PATCH 04/15] stackdepot: add depot_fetch_stack helper
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, Aug 29, 2023 at 7:11=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Add a helper depot_fetch_stack function that fetches the pointer to
> a stack record.
>
> With this change, all static depot_* functions now operate on stack pools
> and the exported stack_depot_* functions operate on the hash table.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

(one nit below)


> +static struct stack_record *depot_fetch_stack(depot_stack_handle_t handl=
e)
> +{
> +       union handle_parts parts =3D { .handle =3D handle };
> +       /*
> +        * READ_ONCE pairs with potential concurrent write in
> +        * depot_alloc_stack.
Nit: please change to "depot_alloc_stack()" for consistency with the
rest of the comments.
