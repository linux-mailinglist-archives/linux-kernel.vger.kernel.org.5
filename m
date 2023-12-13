Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8B78123DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 01:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442665AbjLMXnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 18:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235369AbjLMXnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 18:43:02 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91DF26A8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:42:57 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-58d06bfadf8so4817779eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 15:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702510977; x=1703115777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irtsiUCUylZGPtSeScUGgZwEzBoaabXmknnY3lf14ec=;
        b=DN2eZGc2DJ6T5yMWP8MhjBhzAWxYidnQoWr873YzmOwwHP92cK7dcyKPjjtuAK4rYg
         xN08bxuFyvJJqTyqC3dTID2x0Xxx2ZeO883Gc5RezwhBqy80xxrN4EA4RfZwbqRhqAch
         ut8sAOBiuhZRznLTv2FZHWF8J1keffL5+bIw1MF0dukCO4O/TaIzlpzUfcnTuzOpcqqF
         6ifGVl1SBfvnCC7nRGBB+P/zJXeZ7UHuxLgc3nTzpXrsvhsC+joJQze94AQ2+EriUblJ
         lArAo+hI9eR1kuBlAN/km5xMm3v3trZEtX3G/skkYogoTdaRd+D5MqR8+62c/SHGOGSs
         WG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702510977; x=1703115777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=irtsiUCUylZGPtSeScUGgZwEzBoaabXmknnY3lf14ec=;
        b=cqdH3oHj5Pl9cVwPuLtrjjDO100g+EWBV1/pR7ndohYAl/Tepm4OUwSZpk1nid+Xwt
         cfGCoOB/imJfcEo6jjWHmxSrODTDbjYYInJla4FklXlY2vxI0TFAXSrZ2mQfLEwoE+Hb
         q8Sr5mjpgs+iJNsdTrTT7dpxyehpjXJFn3Wf8GpyI4OzgDN3HQTchwbKAC9sc1bp7ku5
         bFnF9VFv1SgRwb4lKE4Ah/8vnVRpjdebPqTZzzid4eniJlRULQ6LONXmtzG3ygSAh7Q3
         JyYAPEycRpSswtNxnlKODE1wJZRAb3l3nu6q3NmZPfqzDDkwdw6QTPOnttN8mqJW0fKh
         mZ0Q==
X-Gm-Message-State: AOJu0YzWTPGE69eiF3aYiceV0Znr2dYASOtGw5slGAlfNU3DhiCbD4HX
        YK1RL9NDjFpWY+A8WLXlIBnYYVF20DlOvkFrYLc=
X-Google-Smtp-Source: AGHT+IHyxsSvPMDcrEJ+OhDv3fNcRm1G3ibjxqwdrYC9xsCq7fCgqUthDr/+y8Iq/Bc8aUj0imzWPPXYAnpzZDLH/fk=
X-Received: by 2002:a05:6358:99a0:b0:16b:fe18:27fc with SMTP id
 j32-20020a05635899a000b0016bfe1827fcmr10609380rwb.31.1702510976965; Wed, 13
 Dec 2023 15:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20231212232659.18839-1-npache@redhat.com> <CA+fCnZeE1g7F6UDruw-3v5eTO9u_jcROG4Hbndz8Bnr62Opnyg@mail.gmail.com>
 <CAA1CXcBdNd0rSW+oAm24hpEj5SM48XGc2AWagRcSDNv96axQ9w@mail.gmail.com>
In-Reply-To: <CAA1CXcBdNd0rSW+oAm24hpEj5SM48XGc2AWagRcSDNv96axQ9w@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 14 Dec 2023 00:42:46 +0100
Message-ID: <CA+fCnZd4-Hx3vOXdBawiSNPrQ+OZ+fhuAmK3f4TLfDWVmDX9Fw@mail.gmail.com>
Subject: Re: [PATCH] kunit: kasan_test: disable fortify string checker on kmalloc_oob_memset
To:     Nico Pache <npache@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, akpm@linux-foundation.org,
        vincenzo.frascino@arm.com, dvyukov@google.com, glider@google.com,
        ryabinin.a.a@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 10:42=E2=80=AFPM Nico Pache <npache@redhat.com> wro=
te:
>
> > > diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> > > index 8281eb42464b..5aeba810ba70 100644
> > > --- a/mm/kasan/kasan_test.c
> > > +++ b/mm/kasan/kasan_test.c
> > > @@ -493,14 +493,17 @@ static void kmalloc_oob_memset_2(struct kunit *=
test)
> > >  {
> > >         char *ptr;
> > >         size_t size =3D 128 - KASAN_GRANULE_SIZE;
> > > +       size_t size2 =3D 2;
> >
> > Let's name this variable access_size or memset_size. Here and in the
> > other changed tests.
>
> Hi Andrey,
>
> I agree that is a better variable name, but I chose size2 because
> other kasan tests follow the same pattern.

These other tests use size1 and size2 to refer to different sizes of
krealloc allocations, which seems reasonable.

> Please let me know if you still want me to update it given that info
> and I'll send a V2.

Yes, please update the name.

Thank you!
