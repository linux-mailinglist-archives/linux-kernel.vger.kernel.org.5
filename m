Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3777D3C1B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233669AbjJWQRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233606AbjJWQR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:17:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F05710D5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:17:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-27ddc1b1652so2735237a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698077844; x=1698682644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C2cbWsLkEimzOV8VOGRLrBW3hA2WqDn8Mgiw4dAIqPI=;
        b=nnURYKR3LEugERipzgFvhB6T4d7ae8SGMPrTHzrW9lparMv1TgXOFV5L0Cvvbi9dZU
         EezMsy81+smhILWtm0i6BIGae4AQg6/y7VB50wacmfkHykeTPDRZT9AtJWhJDlh4f19Q
         rGiW8wxFBQXhCOPjY2DMzDEU+/q4z20q8cNvpmnNLVzvE03lZWeFsjMkS63MMtUAfw6C
         jYFnhWmKilmnvg5Xpk6dWKxS7VHPBTHmHk6jw0I0eYRbdV0Lb6dyNMAzQo+TncZHSrgT
         MyfrK+KCcgO5553m4kd7CUZJhRUxa/jisluJTAow2tPQskCluqeD7bFLGN0170CKz+kG
         rpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698077844; x=1698682644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C2cbWsLkEimzOV8VOGRLrBW3hA2WqDn8Mgiw4dAIqPI=;
        b=b+enJg+ome4OqhSbutgOYvvgHZIp6gdpYhx+pFMjDUr9wB/ZizcoGNXfplYJQ3SeN2
         TZUuH/Zm1c0RAunCxDVj61QusdpDHo7OcOcun2Ub8SmYU2v0NiifqAYQRMPDcQ2YP+Y0
         N+fzg4rkxXVSNhYB3jBOi3/2IG3qpozm2LieqxdXZN1U9yliznzc1ubXWB09Vdhf6r7v
         vUekzgIdBp5yXZVYLbzKsf5F0+6940TdLNmFFRoWUlGWC2xYXDGdIJuz9vAxJsKV5viT
         6YCADENZsm/elH0vJwdxh7i93GEjWQkm5V58XC1U3girhSeYFkYWiNKMm0rBTHsPjv0e
         t+5A==
X-Gm-Message-State: AOJu0YxSq+I7804M/nub3Iq5ljcjOdgp+TTFkjOcxr2utvUhh9rZWoH0
        eMhhZNswl7kFU4rA8OVK24GfmN72vxVyKP49g2k=
X-Google-Smtp-Source: AGHT+IHmkmexFrpXT+y685LcLGsklhAo1rSt/kwMGisuvPhgKGqZBvXX7tnRoPriqrQzB8y1oac43NgDlIwm4SZr/d8=
X-Received: by 2002:a17:90b:1098:b0:27d:54b9:c3d4 with SMTP id
 gj24-20020a17090b109800b0027d54b9c3d4mr9572424pjb.1.1698077843855; Mon, 23
 Oct 2023 09:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <2a161c99c47a45f8e9f7a21a732c60f0cd674a66.1694625260.git.andreyknvl@google.com>
 <CAG_fn=XnH_z70wPtX=jRtKsb+Kxu5hosnZbnNC=mw6juSm7idA@mail.gmail.com>
In-Reply-To: <CAG_fn=XnH_z70wPtX=jRtKsb+Kxu5hosnZbnNC=mw6juSm7idA@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 23 Oct 2023 18:17:12 +0200
Message-ID: <CA+fCnZdzpHEPnFa1A5TtFu_si3RbQrBEFXHhALEtnVR4nhfzEw@mail.gmail.com>
Subject: Re: [PATCH v2 14/19] lib/stackdepot, kasan: add flags to
 __stack_depot_save and rename
To:     Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Mon, Oct 9, 2023 at 12:10=E2=80=AFPM Alexander Potapenko <glider@google.=
com> wrote:
>
> On Wed, Sep 13, 2023 at 7:17=E2=80=AFPM <andrey.konovalov@linux.dev> wrot=
e:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
> >
> > Change the bool can_alloc argument of __stack_depot_save to a
> > u32 argument that accepts a set of flags.
> >
> > The following patch will add another flag to stack_depot_save_flags
> > besides the existing STACK_DEPOT_FLAG_CAN_ALLOC.
> >
> > Also rename the function to stack_depot_save_flags, as __stack_depot_sa=
ve
> > is a cryptic name,
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>
> (assuming you'll address Marco's comment)
>
> ...
>
> >  void kasan_record_aux_stack_noalloc(void *addr)
> >  {
> > -       return __kasan_record_aux_stack(addr, false);
> > +       return __kasan_record_aux_stack(addr, 0);
>
> Maybe make the intent to not allocate more explicit by declaring some
> STACK_DEPOT_FLAG_CAN_NOT_ALLOC =3D 0?
> (Leaving this up to you)

The next patch adds another flag, so STACK_DEPOT_FLAG_CAN_NOT_ALLOC is
probably not the best name. I could add something like
STACK_DEPOT_FLAG_NONE, but I think this might create an impression
that there's some kind of NONE flag that affects the behavior of
stack_depot_save_flags in a special way.

I think we can just keep the value as 0, as it seems what the kernel
does in similar cases. E.g. for slab_flags_t, the kernel passes 0 to
kmem_cache_create when there are no special flags required.

Thanks!
