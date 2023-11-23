Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BEA7F66A2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjKWSsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:48:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjKWSsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:48:12 -0500
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E1419D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:48:18 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-4ac211e5bbbso1246835e0c.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700765298; x=1701370098; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1r9JxSmLJtBWwQD5WMXoyMpcIa8PCU8/HG8nOTjmTc=;
        b=JDW6BuyjNYMldZAJl+8zbnStBDU7IVrrh+45xGV2YB8Mc8WgGAjrBhtx7c/bvH3uE0
         GXdkJmrfckerymqAxpp19rkehnTX9HBBlSaJgzCq5Hb5hxVxO/vASuRkegpqdQa4T6Qn
         yh/49mHNEmITi621N0Caog8SDRsa6DPJrvs6CTPb9qHycLE66IXxNXHqxXFjIPHQ/PPy
         6DHA9m6olsQQhuPyMvilBksq/Rj+fxqcMCd0R+lOupVDw3q+FjqSc/tBCkMqz8jyijCm
         fP6cCDrTP7O9I5tFuvAB3c5HypD/TuTsKt5m3rQC39VN3O848mOvCagPxCfERHLBN/hi
         9Bxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700765298; x=1701370098;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1r9JxSmLJtBWwQD5WMXoyMpcIa8PCU8/HG8nOTjmTc=;
        b=NbPZCkPMXPoghvHMMQQehuWWtIyw0XtkOu4xbFDsC7kKlEkjHaTgbyvSDENGE0csxB
         pnayOUOdF3LN+qJzd0zYzPfNzN4oJk2CGxUAA4U1lLQXmTJINayEcbk/sthQgDpnik0Q
         Y5T74DdFi+U6KQXIuaY9YsRq7ffC5Znhdn14SGqIGTN4mV4Md9Rnaw6cFF1RRhK8gDAE
         ks5qjCVxpMDDZeFEtPL+QepWlfnOW9rVm+9jsKpeUNg8dPsjHi3nDeIO+fHcQdDt/FgT
         mXd9df1T22CyvCHEVvzLjcGYttbD+crKgc/cdKW5jthRNePzeUkTw1J8NI6DxQz73X9z
         3ZKg==
X-Gm-Message-State: AOJu0YxnW8j3yy8zQmBphfKclyEm5OkTNgLul6kjb7NX7mDZDn89CDha
        3DV9vsZfNp6j6F5kruI0VGS4u0LM2Tnzb5QH/xe7bg==
X-Google-Smtp-Source: AGHT+IEXcraqL3GVfTO/0XxaqVLIGaNyi+kyI+POrn7TO6voCkRYby9hJNNOOq9vbEl4fkNE3NgjkuN2qveL5kdHaeg=
X-Received: by 2002:a05:6102:38c7:b0:457:c953:bc39 with SMTP id
 k7-20020a05610238c700b00457c953bc39mr3960679vst.1.1700765297816; Thu, 23 Nov
 2023 10:48:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1699297309.git.andreyknvl@google.com> <9752c5fc4763e7533a44a7c9368f056c47b52f34.1699297309.git.andreyknvl@google.com>
 <ZV44eczk0L_ihkwi@elver.google.com> <CA+fCnZft0Nkc2RrKofi-0a0Yq9gX0Fw5Z+ubBfQy+dVYbWuPuQ@mail.gmail.com>
In-Reply-To: <CA+fCnZft0Nkc2RrKofi-0a0Yq9gX0Fw5Z+ubBfQy+dVYbWuPuQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 23 Nov 2023 19:47:40 +0100
Message-ID: <CANpmjNMpPK56mc5wiSoL+AX1pgzG0Kz=SuqGPDme=FFCdhnf9w@mail.gmail.com>
Subject: Re: [PATCH RFC 14/20] mempool: introduce mempool_use_prealloc_only
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Nov 2023 at 19:06, Andrey Konovalov <andreyknvl@gmail.com> wrote=
:
>
> On Wed, Nov 22, 2023 at 6:21=E2=80=AFPM Marco Elver <elver@google.com> wr=
ote:
> >
> > On Mon, Nov 06, 2023 at 09:10PM +0100, andrey.konovalov@linux.dev wrote=
:
> > > From: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > Introduce a new mempool_use_prealloc_only API that tells the mempool =
to
> > > only use the elements preallocated during the mempool's creation and =
to
> > > not attempt allocating new ones.
> > >
> > > This API is required to test the KASAN poisoning/unpoisoning functina=
lity
> > > in KASAN tests, but it might be also useful on its own.
> > >
> > > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > > ---
> > >  include/linux/mempool.h |  2 ++
> > >  mm/mempool.c            | 27 ++++++++++++++++++++++++---
> > >  2 files changed, 26 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/include/linux/mempool.h b/include/linux/mempool.h
> > > index 4aae6c06c5f2..822adf1e7567 100644
> > > --- a/include/linux/mempool.h
> > > +++ b/include/linux/mempool.h
> > > @@ -18,6 +18,7 @@ typedef struct mempool_s {
> > >       int min_nr;             /* nr of elements at *elements */
> > >       int curr_nr;            /* Current nr of elements at *elements =
*/
> > >       void **elements;
> > > +     bool use_prealloc_only; /* Use only preallocated elements */
> >
> > This increases the struct size from 56 to 64 bytes (64 bit arch).
> > mempool_t is embedded in lots of other larger structs, and this may
> > result in some unwanted bloat.
> >
> > Is there a way to achieve the same thing without adding a new bool to
> > the mempool struct?
>
> We could split out the part of mempool_alloc that uses preallocated
> elements without what waiting part and expose it in another API
> function named something like mempool_alloc_preallocated. Would that
> be better?

Yes, that might be better. As long as other users of mempool (esp if
KASAN is disabled) are unaffected then it should be fine.
