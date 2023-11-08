Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7277E5195
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 09:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbjKHIDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 03:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjKHID2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 03:03:28 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41941F0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 00:03:26 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-5441305cbd1so8904813a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 00:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699430604; x=1700035404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u03bBF5XTgqdtGIM3zyfPEZoFwKNJ1YwlMaCH9sfDoo=;
        b=Y7+6LmEr/hkmt+uHFXcj+OlruLkb+Vpg5EfdNp26pWeoFdA4XjVhnx2EzgLsfMak4n
         taWubwaC+awkW88MVQDRRvcGucvfwjSR62ZWcxgCthuKHS9M++5j0wQVUjVZmpFoaMhp
         AW6m7YjG84UZW3sB/205wN3zEGHVetatps9AtGmdopiHiY055fBvSZ98/0WZzK/rgDq8
         lsq4qw4zNGaT5BagB9S4Yo9XbTem+DqYnXxHpaHxZrqVkw/nCDqdaXz1Q4f/KJr9lyha
         WiUwY8xNZ2kvHru6TMDf8rjkYPrOBalHuQVu/fbcR/RMEaoPEV7uY6+4yOHVi6nEqYVf
         olKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699430604; x=1700035404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u03bBF5XTgqdtGIM3zyfPEZoFwKNJ1YwlMaCH9sfDoo=;
        b=XMat0V7iDsFnp2NLCD3XXBWPx1wqi+J4Jh9fw3J9/hox1+oTwJ9haFMa5sys+2nhZ0
         iil4u8BZXVVTlAXkPEzPh/hy0tVIppbKV9RwEaaWknRl2MpOZKoIBVd7PRDZOghGfVFj
         WzIGdJwK5jh0pVJVxoJOZgPkJ6r6FgnLls7Kd3J0Yjqr1um51E1gePzeRiWgKbkU8z9M
         yvLRXHUp7XRdpkD35SbBJ6d+IG/hVmasY1Xf+z4mJIZ84GV94JmhB7LVaxsRhrwaKDHS
         ZOG38w+hMsrjk3Zmt6m4S5NzKDXWU4XJRjmZkeYQ0GH0X4xHfDlvOkne31Dat22eBMiY
         IBfA==
X-Gm-Message-State: AOJu0Yycp+ntHqoLq0i7pNJvRyinEyReiDh7GwWZVLuEAyOt6gIBeQtd
        Dz1prUfSiRbDEZXYLReQSLkaAypxBTFIo38DboKZTA==
X-Google-Smtp-Source: AGHT+IGpoJahX9MYqYyUr8cff+FX+d565D7YmTwSdBq7YDbFEiiO5nn+wOCfTSnrl9lBIftYjQoYo7ZvnPqS5R/9RXM=
X-Received: by 2002:a17:907:741:b0:9bf:77ae:3aa9 with SMTP id
 xc1-20020a170907074100b009bf77ae3aa9mr759862ejb.24.1699430602521; Wed, 08 Nov
 2023 00:03:22 -0800 (PST)
MIME-Version: 1.0
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com> <20231107230822.371443-12-ankur.a.arora@oracle.com>
 <20231108012823.GD11577@google.com> <7155f21f-a7e5-cc36-89e5-c1ce257b9420@suse.cz>
In-Reply-To: <7155f21f-a7e5-cc36-89e5-c1ce257b9420@suse.cz>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 8 Nov 2023 00:02:46 -0800
Message-ID: <CAJD7tkYYqqYT361pbeqTFxoAep2qtTAWSQx4SzFCcEEOZgRT3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 68/86] treewide: mm: remove cond_resched()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jon.grimm@amd.com,
        bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        SeongJae Park <sj@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Hugh Dickins <hughd@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Minchan Kim <minchan@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 7, 2023 at 11:49=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 11/8/23 02:28, Sergey Senozhatsky wrote:
> > On (23/11/07 15:08), Ankur Arora wrote:
> > [..]
> >> +++ b/mm/zsmalloc.c
> >> @@ -2029,7 +2029,6 @@ static unsigned long __zs_compact(struct zs_pool=
 *pool,
> >>                      dst_zspage =3D NULL;
> >>
> >>                      spin_unlock(&pool->lock);
> >> -                    cond_resched();
> >>                      spin_lock(&pool->lock);
> >>              }
> >>      }
> >
> > I'd personally prefer to have a comment explaining why we do that
> > spin_unlock/spin_lock sequence, which may look confusing to people.
>
> Wonder if it would make sense to have a lock operation that does the
> unlock/lock as a self-documenting thing, and maybe could also be optimize=
d
> to first check if there's a actually a need for it (because TIF_NEED_RESC=
HED
> or lock is contended).

+1, I was going to suggest this as well. It can be extended to other
locking types that disable preemption as well like RCU. Something like
spin_lock_relax() or something.

>
> > Maybe would make sense to put a nice comment in all similar cases.
> > For instance:
> >
> >       rcu_read_unlock();
> >  -    cond_resched();
> >       rcu_read_lock();
>
>
