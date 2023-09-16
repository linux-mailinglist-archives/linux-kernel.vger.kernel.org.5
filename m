Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF387A3161
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 18:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbjIPQTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 12:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239410AbjIPQTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 12:19:10 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95F1CC0;
        Sat, 16 Sep 2023 09:19:05 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2749b003363so1157573a91.2;
        Sat, 16 Sep 2023 09:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694881145; x=1695485945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8L+TF2NB2bKIXmFBrFsqsaXp12HgxVOtYytgv3Hfus=;
        b=TBFmjM19TM6nQu/cgfGiKrQDkI6Nks80mvqoOwu8/aJE7ZC17krc00TQ3nOHmk2eEs
         JovdSYhGf0VCqeJmLW8OyDLtvjSf/DCwxb966106K/6ba6Z6Uj0c2D+jdapIC+5DhMfk
         yruD+HQCBZWdkyIZ4+M7fylsQ+4rOz6b7rLhCUL6JWKcLR7v3tWff0z8WX6UXBMwihYw
         OZDkZemR9fPSU7jRptS8MvfYbBZKE5es/9x1GufITk2k0N9JX10vdZ5gkamloLN9nmU9
         +2xJPNOXVH/+6JTfM0reLWamXFRj28W7xqNOd4lJ5aCA40qU1/jHtRclgwE+2JpPmsRP
         Xq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694881145; x=1695485945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8L+TF2NB2bKIXmFBrFsqsaXp12HgxVOtYytgv3Hfus=;
        b=mMtmo3eD7/DikB12dKlagNeMqCq5G3AuD7ReUBTD49AI2tl8qayVEOjFrDhJGNQFE1
         itBeFnyXQP6j+wKVS0dK2wGReU/0cZ2Op91AG0nAzybkD4t0nTq6dBTSssyXA20TApFw
         hjjGywEvQ1DCNMXjR8rl9xOlXsAOuEgNTGBAFhVnxW0CVIzQlxYjRKl6PgpwEgYGA+g3
         0umfwTWzq/5mZmXEvhrui8VPJcgxhTJ05/1ITuhtEWaLDODzOdO8fd7t4cUpzKyYmamu
         5LUN/W5Yx3Xa5K7NLDLWP7Pz9RrhNF3Yp66XOjbA/UDyjoN4gjv1HYCAiw27RfLNlMrX
         DJTw==
X-Gm-Message-State: AOJu0YyVNJE/uoy1hCAcmdVXdNDOVzXbxKRudSKFVTvDosbzcRVooJyS
        +X3hSRXVKO/vbRFduagmgTZ+KYRiwHJm3H2F6PQ=
X-Google-Smtp-Source: AGHT+IE6gvIqWBAlwxxGiQzAX1gu/T0BW4IYuGOri4BCq3hbNBUJcdmd2cR5j04KoGOSIbaFxEkMbAA5/MG01mn7ung=
X-Received: by 2002:a17:90a:ad92:b0:274:8363:c679 with SMTP id
 s18-20020a17090aad9200b002748363c679mr3795739pjq.19.1694881145079; Sat, 16
 Sep 2023 09:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230825211426.3798691-1-jannh@google.com> <CACT4Y+YT6A_ZgkWTF+rxKO_mvZ3AEt+BJtcVR1sKL6LKWDC+0Q@mail.gmail.com>
 <CAG48ez34DN_xsj7hio8epvoE8hM3F_xFoqwWYM-_LVZb39_e9A@mail.gmail.com>
In-Reply-To: <CAG48ez34DN_xsj7hio8epvoE8hM3F_xFoqwWYM-_LVZb39_e9A@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 16 Sep 2023 18:18:54 +0200
Message-ID: <CA+fCnZeyS=wr-u4FgJmGLXujcat=oQ+jo-NAt1TtSa_tLEstSg@mail.gmail.com>
Subject: Re: [PATCH] slub: Introduce CONFIG_SLUB_RCU_DEBUG
To:     Jann Horn <jannh@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 4:40=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> > Can't we unpoision this rcu_head right before call_rcu() and repoison
> > after receiving the callback?
>
> Yeah, I think that should work. It looks like currently
> kasan_unpoison() is exposed in include/linux/kasan.h but
> kasan_poison() is not, and its inline definition probably means I
> can't just move it out of mm/kasan/kasan.h into include/linux/kasan.h;
> do you have a preference for how I should handle this? Hmm, and it
> also looks like code outside of mm/kasan/ anyway wouldn't know what
> are valid values for the "value" argument to kasan_poison().
> I also have another feature idea that would also benefit from having
> something like kasan_poison() available in include/linux/kasan.h, so I
> would prefer that over adding another special-case function inside
> KASAN for poisoning this piece of slab metadata...

This is a problem only for the Generic mode, right? You already call
kasan_reset_tag on the rcu_head, which should suppress the reporting
for the tag-based modes.

If so, would it be possible to reuse metadata_access_enable/disable?
They are used for accessing slub_debug metadata and seem to fit nicely
with this case as well.

I also second Macro's comment to add a test for the new functionality.

Thanks for working on this!
