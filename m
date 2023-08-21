Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B85A782304
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 06:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233093AbjHUEz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 00:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbjHUEzZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 00:55:25 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EDDA6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 21:55:22 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b962535808so47185801fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 21:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692593721; x=1693198521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bBPIa0Y0nf44GPXwWTAaO4yGtE4FDjY8r9GXV2YK4UU=;
        b=T0gz4gUTApxGAH1pTeA2eFV29EqZD07oYhbvzgVYvn3oDP7QcSZJhspwirBZOk4Hir
         hoWUa9ReKe6H1h3jx8LcSsEHKnFKqcqEFDIqSNv56QGF65Vgg3GNIwWwE7xKZaCflFHt
         7a43VWcG0d7mcafYGJy54/bfrBGzTxEQN3juk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692593721; x=1693198521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bBPIa0Y0nf44GPXwWTAaO4yGtE4FDjY8r9GXV2YK4UU=;
        b=P6vATdRjTSU1bHOVB5vptBflEM/M3oj561ZEINYaqt+6rWCxgndIwL+fOALae9IjKV
         sqqJYdY/A+vvz6ZeGfpuDXwpPB0FWe+ylVTp6Zi29zzeDUNDlDyVFZcmi9gmMNa3Abke
         Qu0dqSVQ4KNhNHJ9Y2SffefbSvw16hG15YP5WcdZiMVDjuZq5yL3/TpoFNhEuuhnNJsT
         5qLpnfgn7jqaCEV5pkJs6TmbsuHph02mzke/1UaAATZFB/60d7BWD/YnUFNia4CO/TL5
         PhAff7RLx2KzBn4IEJSFSkIy1+ul2ySULyRNLkxzkxdIVIru6QclEzYBcNaN7m7YGIpw
         Bfzg==
X-Gm-Message-State: AOJu0YwKhKuE82GaTORA6cqBq0kVRdppNwmUR7bh/b2jMMP4EA0Z2GQ5
        IdYAviuc8VEX1Fmsim2WMBNJW92mAwAk/FZdt5RPajo3
X-Google-Smtp-Source: AGHT+IF12pgL76qgcV0t/0ciLxBbP6mNpol7PyfcAXZFVXrbz6NeLP1kDT0atKCWPLI4L2HwF7wUlg==
X-Received: by 2002:ac2:4557:0:b0:4fd:fef8:7a81 with SMTP id j23-20020ac24557000000b004fdfef87a81mr3227019lfm.55.1692593720694;
        Sun, 20 Aug 2023 21:55:20 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 28-20020ac2485c000000b004fddbd29457sm1542148lfy.7.2023.08.20.21.55.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 21:55:20 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b962535808so47185281fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 21:55:19 -0700 (PDT)
X-Received: by 2002:a2e:9b49:0:b0:2b9:bf49:901b with SMTP id
 o9-20020a2e9b49000000b002b9bf49901bmr3580293ljj.6.1692593719477; Sun, 20 Aug
 2023 21:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230820104303.2083444-1-mjguzik@gmail.com> <ZOJXgFJybD1ljCHL@casper.infradead.org>
 <20230821011303.hoeqjbmjaxajh255@f> <ZOLg2kmvKb4eGDrt@casper.infradead.org>
In-Reply-To: <ZOLg2kmvKb4eGDrt@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Aug 2023 06:55:02 +0200
X-Gmail-Original-Message-ID: <CAHk-=win-keZbx6GFC4Q6VXUiFLfWxVDqcAUoV2A38rN29H5Xw@mail.gmail.com>
Message-ID: <CAHk-=win-keZbx6GFC4Q6VXUiFLfWxVDqcAUoV2A38rN29H5Xw@mail.gmail.com>
Subject: Re: [PATCH] mm: remove unintentional voluntary preemption in get_mmap_lock_carefully
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 at 05:58, Matthew Wilcox <willy@infradead.org> wrote:
>
> The might_sleep() is clearly safe, but I thought of a different take on
> the problem you've found, which is that we used to check need_resched
> on _every_ page fault, because we used to take the mmap_lock on every
> page fault.  Now we only check it on the minority of page faults which
> can't be handled under the VMA lock.  But we can't just slam a
> might_resched() into the start of the fault handler, because of the
> problem you outlined above.

Bah.

I decided that there is no way the might_sleep() can be the right
thing to do inside get_mmap_lock_carefully(), because the whole point
of that function existing is that we might have a kernel bug causing a
wild pointer access.

And that kernel bug would be about the subsequent oops, not the fact
that we might be sleeping in a bad context.

So I have just removed the existing might_sleep() entirely, because
both the warning it can generate _and_ the voluntary scheduling point
are bad things in that context.

I do think that maybe we should then re-introduce the might_sleep() in
some actually appropriate place in the page fault path, which might be
'handle_mm_fault()'.

But I think that's a separate - if related - issue to the whole "this
was always the wrong point for might_sleep()" issue that Mateusz
noticed.

We are generally much too timid about removing old debug checks that
don't really make sense.

               Linus
