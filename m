Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6758879EFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjIMRI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjIMRIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:08:10 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AA8268A
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:07:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68fe2470d81so5086b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694624866; x=1695229666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKjqLRHBaK4WXz9nWdn/oC9Zz8hGXtmarbif3LIzAxY=;
        b=H4TyxugVus6/jeYTGxjr9zSJjCiInY02MMH3fU24729vMAm8M3SCLRKksQAiYjsV6x
         adztrKnqJfJsSe+bmlsKA94fyMJOeB0gV6sN3ODJOO1hemqIjfr3pXBZI8xFKAR7JBlG
         0JQj5isW+NBmLdoh4eqv33uZvyQW3NGSwgIVA7lCxgcW9/+SkRDrbE3AMPjIX8AExmts
         2XPUmNUGhCvNcFDos2/9XD6pJ3ELlKgfWFPXv6yM1U8EphFgrZ7po2swxqSyTIG09kmN
         npRsn82e9jGeTn5wZZ+i5BbHPDov6YH0j+rifAjXtH8OZC2MIvLr0IwJp6bW3rBrP90W
         dQnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694624866; x=1695229666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKjqLRHBaK4WXz9nWdn/oC9Zz8hGXtmarbif3LIzAxY=;
        b=p3QFA6qNOeAEs/qaIW7QWQCZjf3wqK516dkEz+93mLIfz2lgnU2QM5huhnrQWwO6Rb
         VfNodgUeXk1WsBKaHErRI9NBOOry3GdygH7nbfzcmsKFSMWBjMhS5XsapEEujYmJZeGJ
         +9bmkIzUsgI8lBasA7q4eEx0B+qcTd6Fx8TIwUyPNDSrq+qRS/JYhi0RffyR1oaxonJv
         NbfTJ/FCZ+iRQRiQkhFlQr5Cg4cvm6hOgK46ce+r5rOYGN6Lh8sL0CdS5DbItmB0UXwb
         /at0rMTs+LTba7UIKqaPV7BDcT6C1NdpBEBHOcN/pCiW4DTDecM1WSmipqaekT230I/n
         0XPg==
X-Gm-Message-State: AOJu0YzroCD/N2JxeH6ekVK95N7Lpd12fdam4bPTwvrsMDnZkiqXrR1d
        UbygOCqJTQrzwrgg591zYv98Sov39vySccgjMUaKb+vM
X-Google-Smtp-Source: AGHT+IFdb9piWoMgBsUiaBo3/HDgVR8r+f+Uxezg+YmkklYcK3cNWXOXc0/kgupFRcrHDfZqfFxDg/d5LUs9t1ctVVc=
X-Received: by 2002:a05:6a20:9187:b0:149:122b:6330 with SMTP id
 v7-20020a056a20918700b00149122b6330mr3471096pzd.10.1694624866041; Wed, 13 Sep
 2023 10:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <e9ed24afd386d12e01c1169c17531f9ce54c0044.1693328501.git.andreyknvl@google.com>
 <ZO8KzKWszioRKrks@elver.google.com>
In-Reply-To: <ZO8KzKWszioRKrks@elver.google.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 13 Sep 2023 19:07:35 +0200
Message-ID: <CA+fCnZdGuJmGZDUDaX7=NqydApbox4hMrOZL9_znL=9KpLpQhg@mail.gmail.com>
Subject: Re: [PATCH 13/15] stackdepot: add backwards links to hash table buckets
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

On Wed, Aug 30, 2023 at 11:24=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
>
> > diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> > index a84c0debbb9e..641db97d8c7c 100644
> > --- a/lib/stackdepot.c
> > +++ b/lib/stackdepot.c
> > @@ -58,6 +58,7 @@ union handle_parts {
> >
> >  struct stack_record {
> >       struct stack_record *next;      /* Link in hash table or freelist=
 */
> > +     struct stack_record *prev;      /* Link in hash table */
>
> At this point this could be a normal list_head? Then you don't have to
> roll your own doubly-linked list manipulation (and benefit from things
> like CONFIG_LIST_DEBUG).

Yeah, I think this makes sense. Will do in v2. Thanks!
