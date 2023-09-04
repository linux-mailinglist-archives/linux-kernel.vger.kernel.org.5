Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FD4791D5F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 20:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237239AbjIDSrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 14:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241373AbjIDSrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 14:47:05 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222F5CD4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 11:46:58 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6bd0425ad4fso1451911a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693853217; x=1694458017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y1p+GT6ZMy0ZqRPEzPWHIRn3xw5vD8ZF+TmPxh+UO9g=;
        b=cpDPpYHbph6spsQZCfKN9mJCh1a1KR/vsytXm40vzjN2V5ama/bHDdEBH66H4CTj6l
         Ubmw736vsNMmh3jWfFjAiGN11EerZTBLRGqhH4wt9kr52+IsAPyUnGdUK5iCkKCEopM6
         elg6QfM1JyyaJRqzQSzr1k/zkb/TSnL2d29+cI2kNwFWHpm+O7c1Tjp4HZSTEzU6inoD
         x0FT02cU9E+pMH/jN6QoBwBJB1/cqUE9vR61A5TeGeGBuBMeG7CYREGUBLT4hBmsTkYC
         rjDvM5DwyW0cA8ZOblU46BGFEqHwHY90SbmZdzwDp9gfLL2DNcicBLoDImRGLSlx/iwB
         8uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693853217; x=1694458017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y1p+GT6ZMy0ZqRPEzPWHIRn3xw5vD8ZF+TmPxh+UO9g=;
        b=EDRENQ7x0yZ4hwypaKMXNlJkm+Lp+zVMKyGoa7lFhBouPaSlULt2Vg225zUUYZxvB+
         ciRDpOOkYiyxHzfxCfFndwzuecvY4TplE2Un49nBOLHQZ7ngSd9nEKaaJYRsN5OOQ+p+
         eb6OPoND0YY2bbiIf+WaXfd1pec3i/XvE/l2RRf1Kygvb99BHZ6SwEG3RDRfJmR0LQr9
         P3lVUVHIVRnK3EyY9dWXQSSeDS/MMUNQkhRF67QZewa8oMybOD+KQr+SDWLVTbkp+scI
         /i+i21Q/QbHFJIfpXVhqFQn1IF5YLIpAo1KLJGJzOWcH3Hkx+cdNmDpDqNYCg5v3OtMD
         DlPA==
X-Gm-Message-State: AOJu0YwczRuBAjw0QcFxiN9vCsUJHg1ZVa0XOasY3mgCYHYttGHKFe++
        KcIFpjAVM4v+41UjIQwb5a3+tbwmNu2PiKa/Jrk=
X-Google-Smtp-Source: AGHT+IGmsreaRYS9kzZh5So8rTIujJTmkImAJoOIUvTniPZu2NQsxR7uz0kN40xu6lzDsiDeTeaVoP1JuZaoJQxwRNg=
X-Received: by 2002:a05:6830:12d8:b0:6bc:b80c:bd53 with SMTP id
 a24-20020a05683012d800b006bcb80cbd53mr10953722otq.38.1693853217401; Mon, 04
 Sep 2023 11:46:57 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <306aeddcd3c01f432d308043c382669e5f63b395.1693328501.git.andreyknvl@google.com>
 <ZO8MxUqcL1dnykcl@elver.google.com>
In-Reply-To: <ZO8MxUqcL1dnykcl@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Mon, 4 Sep 2023 20:46:46 +0200
Message-ID: <CA+fCnZe2ZRQe+xt9A7suXrYW8Sb7WGD+oJJVWz6Co-KGYghZLw@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 11:33=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
>
> If someone doesn't use stack_depot_evict(), and the refcount eventually
> overflows, it'll do a WARN (per refcount_warn_saturate()).
>
> I think the interface needs to be different:
>
>         stack_depot_get(): increments refcount (could be inline if just
>         wrapper around refcount_inc())
>
>         stack_depot_put(): what stack_depot_evict() currently does
>
> Then it's clear that if someone uses either stack_depot_get() or _put()
> that these need to be balanced. Not using either will result in the old
> behaviour of never evicting an entry.

So you mean the exported interface needs to be different? And the
users will need to call both stack_depot_save+stack_depot_get for
saving? Hm, this seems odd.

WDYT about adding a new flavor of stack_depot_save called
stack_depot_save_get that would increment the refcount? And renaming
stack_depot_evict to stack_depot_put.

I'm not sure though if the overflow is actually an issue. Hitting that
would require calling stack_depot_save INT_MAX times.
