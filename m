Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625957BD82F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 12:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346078AbjJIKKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 06:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346067AbjJIKKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 06:10:35 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DCCAB
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 03:10:31 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-7741c5bac51so248429385a.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696846230; x=1697451030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKAlUAosFjrafJFjKgxhfBSe7ZC79o6SyWOfRs4IFUY=;
        b=FsXlUi6xXf4Nqmp4w6GIxsb14u+p1d1Bc50hwMPaLypETRr6O5r4Pwvgg2tMhFBf6H
         Eb+M9rD7Wuz6VNua0vT009coOFxAiC3gby4mTKdjiTStP006RwuEjrauAPoUQRzoQ6au
         YSaoE+JBT0sSC66WWReMe7dZ+OW7sP50omR8TbeP5QjOKXVG6gM0rmJEYP09rjqyWeNk
         ANWcmNp5DymrnPLoIiotNifFFtgHUFhFrrAk7LVGbLoccFeTn+Y9Wlx6mxz4yPGEMsEK
         aaAh9QsEuwiV4gWQaz+XMwcQ4dn2rtPL+/l83HQ0u1H18dk1EG+Oi8C+vsVfUbQjgupE
         ZxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696846230; x=1697451030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKAlUAosFjrafJFjKgxhfBSe7ZC79o6SyWOfRs4IFUY=;
        b=Y27Aj1+EnI3CY0rqr5bCjMf6v+4lVuiZo6kyIj2T3CFHRjwS4TUTbmj1CWOkf0cICA
         JzFEgywLMwBribq0rf1D4KqAvVE0Lcpsy6SOQopNfLZMRXGOuqN9pcPzZACoF29LUynk
         xwjM6tIKR941P0NbHJiV2To+c8Wx3hnRKWxLrKJJL6aj712IxoJdSNInvKTei2jHrCMW
         ahNnpdofU2BDeldeAc2bpF0drnMyq9k7HGrYICl4ZENhMuCcnlkHEUxwAnpCTCMuSxI/
         rX8OZnKmDBYKGGXx1ZpmmUQ+d3Dzwre73J2utYOYwQMzrazQHEONt4Zh+ikLbp+SWk9z
         Fx0Q==
X-Gm-Message-State: AOJu0Yxm2tQHZ6BI2CTjc2dcPLfBoMxBU/6S0/3/x7D4H6ccrSWaJ5Vi
        G24+b//1YR7sNhwDIQvYk8FN9KvGY/9y++nzwDhTJg==
X-Google-Smtp-Source: AGHT+IHzCKfbb+v+9IMIyj2N0ism/FX43FExAaYXjJyBBHMoi2uYhQ+vjSvgkSAqiwGlDlVqe38vGbp02bC590c3wg0=
X-Received: by 2002:a05:6214:301b:b0:65b:1594:264e with SMTP id
 ke27-20020a056214301b00b0065b1594264emr15604865qvb.51.1696846230114; Mon, 09
 Oct 2023 03:10:30 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1694625260.git.andreyknvl@google.com> <2a161c99c47a45f8e9f7a21a732c60f0cd674a66.1694625260.git.andreyknvl@google.com>
In-Reply-To: <2a161c99c47a45f8e9f7a21a732c60f0cd674a66.1694625260.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 9 Oct 2023 12:09:54 +0200
Message-ID: <CAG_fn=XnH_z70wPtX=jRtKsb+Kxu5hosnZbnNC=mw6juSm7idA@mail.gmail.com>
Subject: Re: [PATCH v2 14/19] lib/stackdepot, kasan: add flags to
 __stack_depot_save and rename
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
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

On Wed, Sep 13, 2023 at 7:17=E2=80=AFPM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Change the bool can_alloc argument of __stack_depot_save to a
> u32 argument that accepts a set of flags.
>
> The following patch will add another flag to stack_depot_save_flags
> besides the existing STACK_DEPOT_FLAG_CAN_ALLOC.
>
> Also rename the function to stack_depot_save_flags, as __stack_depot_save
> is a cryptic name,
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
(assuming you'll address Marco's comment)

...

>  void kasan_record_aux_stack_noalloc(void *addr)
>  {
> -       return __kasan_record_aux_stack(addr, false);
> +       return __kasan_record_aux_stack(addr, 0);

Maybe make the intent to not allocate more explicit by declaring some
STACK_DEPOT_FLAG_CAN_NOT_ALLOC =3D 0?
(Leaving this up to you)
