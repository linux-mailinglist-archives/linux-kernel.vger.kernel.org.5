Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F04378D8E6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjH3Sbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242385AbjH3IWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 04:22:07 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE97113
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:22:03 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-76c64da0e46so180876239f.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 01:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693383722; x=1693988522; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5yOmmGKLBMpPD+EhNoomatQprH2d72p73RqEVWw00Q=;
        b=RMqOwHgfQSXGfXB3Rm6PzRUdPz2kgTR6gg+6ZIy/B05KzXqQ4UIEp2vgqRCp+lWZ5M
         88Ok+ROZApdXOl/1eqLmwFdWbdR+25ZbInRaiAnqXAkMnQkEtIVIfTm17JX2NZQHnEZ3
         by+UDvQ1J0J4wKW9QzfPNAl1cZj65P1ZLPoV1hBmD+tkY5xSGFiiCX5xu7QnP03Hrvyy
         +8CtrStlsdxSVAY67DcgyPfrHHiOuai3ePd6yXmubPjBYezikK7XJRwx1ZVU8bqHKrh5
         ND/+vQEV9JdZIX+NZ+yNRTHp2Kn9s3MLRSUEkcuO8+iR4M7F7t+mqQlNX81kXzHQ9Rcf
         qR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693383722; x=1693988522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5yOmmGKLBMpPD+EhNoomatQprH2d72p73RqEVWw00Q=;
        b=WggWK0hlbYKdYW9EGT1VuyIAR5xU2MCN6iDvCWqbmjI4BdswTuGsVsUI9dxLN3Gtud
         VPmw2focNjYeYxYl+9qIIXwElN7tskOhnZlKrKGcYFewuKw5PTAK98QmYkbrpQg/SfLg
         W9bVEco3sg1thDY27sQqeZUdUj5dukl5btXtQYSLyIlvY+D6WXwQdTc29hRfuIjNbLA/
         CzfzBqujkBjm34kAKqwYMnu5tXFGE8pLGcDLP8TKAtFb0UrbEiUsW4oCBA9jH8NhKBuq
         R8+yfbZibOAKuWpXyj8La1BqedEnLpYtPxap4V5NKkCw4obpHZuSd9u3x20iwoSNxEyB
         MJeg==
X-Gm-Message-State: AOJu0YyruP1Bo7ToNNnPh41kcuzzyHcchrM3CdrXplGkdXncaEaRG0aY
        7bk0nE1xCqU0K4u89X9BEwLGOI+BvAESL/J80Xo6gg==
X-Google-Smtp-Source: AGHT+IHiCm0SQ/gWe3DBUynyIGPTC9o0YcVj8A+BcT7YLpA40y+vridUxm+66v5LZOz4mIItf8gK9jyumzabzGNCmlE=
X-Received: by 2002:a6b:7901:0:b0:783:3899:e1d0 with SMTP id
 i1-20020a6b7901000000b007833899e1d0mr1456114iop.6.1693383722341; Wed, 30 Aug
 2023 01:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1693328501.git.andreyknvl@google.com> <89c2f64120a7dd6b2255a9a281603359a50cf6f7.1693328501.git.andreyknvl@google.com>
In-Reply-To: <89c2f64120a7dd6b2255a9a281603359a50cf6f7.1693328501.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 30 Aug 2023 10:21:25 +0200
Message-ID: <CAG_fn=WsYH8iwHCGsoBRL9BRM-uzKJ3+RDgrB5DEGVJKLPagVw@mail.gmail.com>
Subject: Re: [PATCH 05/15] stackdepot: use fixed-sized slots for stack records
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
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
> Instead of storing stack records in stack depot pools one right after
> another, use 32-frame-sized slots.

I am slightly concerned about the KMSAN use case here, which defines
KMSAN_STACK_DEPTH to 64.
I don't have a comprehensive stack depth breakdown, but a quick poking
around syzkaller.appspot.com shows several cases where the stacks are
actually longer than 32 frames.
Can you add a config parameter for the stack depth instead of
mandating 32 frames everywhere?

As a side note, kmsan_internal_chain_origin()
(https://elixir.bootlin.com/linux/latest/source/mm/kmsan/core.c#L214)
creates small 3-frame records in the stack depot to link two stacks
together, which will add unnecessary stackdepot pressure.
But this can be fixed by storing both the new stack trace and the link
to the old stack trace in the same record.
