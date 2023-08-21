Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4903B782339
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 07:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjHUFiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 01:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjHUFiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 01:38:54 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0888FA3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 22:38:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe1b00fce2so4217294e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 22:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1692596331; x=1693201131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uGZPyjgt3BgZZGLfyFPtYNDWKcSWUwfliXHm1wb3l4U=;
        b=ehJwUZzca2pV6VEkA+rwqHDmpWr5R2LeUOhR8f3VQgTuUHlrmjaxZVuj9DtTak+NYl
         y6A5JEMsOJAKoPWZTJcbjaCIV5uFWH5iqUHlVkLP/gz/pEYR6dEo2OwTwvXmEwyF91j/
         AX/eXf7Mv8VZoQrmKu8PcyMuWUm09VuaL5Ux8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692596331; x=1693201131;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uGZPyjgt3BgZZGLfyFPtYNDWKcSWUwfliXHm1wb3l4U=;
        b=G4TFnPhE7LApwU53tUhUrEB70xuGUepdbF+LtvYW46EiKuL+gIeQXt88SqCXYv674+
         SM339XQ6rnjbu7Xa1fxgzoG4rN2dJTAxMPnBHKGyGSSInigYOdLhwi6HriTWnxBlNaJT
         RUDIzGyxlOdwV6VjV9CJY5a7BQNEsfFc0rUsnNT82ySHq/gM2mIGHnXX++3URWZCbEu8
         ijwXds+aHpciv0goLFNPMfiWLyqsSFJ4rRq2+sXIQm9VuTsHlmbHwqLLCztfl3w/te3n
         kKY2hKcRUII74tnw2gf2x+4tIscE0UZzAMwGlhan04Y5E2yt9g2HF9ZJD4eNMi3bS7Xg
         xDyw==
X-Gm-Message-State: AOJu0YwdipI8Y4Jy2575qTWHQxWvRBYviya9L/KwOIEVoK3z/fAAjPhx
        WWEu9EKhvhWT6RX17sRMCRMnmNVIdc/NwWqFKXcYG+MB
X-Google-Smtp-Source: AGHT+IEHX52Ov1Ll8aA7MN4IZJdrrUG+JmPOlpJuHWHgiynRxOaXXgDdl3Qb0CY5cZmJOVvcvLgKWg==
X-Received: by 2002:a05:6512:33c3:b0:4ff:9746:c24 with SMTP id d3-20020a05651233c300b004ff97460c24mr4368274lfg.68.1692596331064;
        Sun, 20 Aug 2023 22:38:51 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id c4-20020aa7df04000000b00523b1335618sm5404693edy.97.2023.08.20.22.38.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 22:38:50 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99cdb0fd093so393201066b.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 22:38:49 -0700 (PDT)
X-Received: by 2002:a17:907:2721:b0:957:2e48:5657 with SMTP id
 d1-20020a170907272100b009572e485657mr3737665ejl.68.1692596329546; Sun, 20 Aug
 2023 22:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230820104303.2083444-1-mjguzik@gmail.com> <ZOJXgFJybD1ljCHL@casper.infradead.org>
 <20230821011303.hoeqjbmjaxajh255@f> <ZOLg2kmvKb4eGDrt@casper.infradead.org> <CAHk-=win-keZbx6GFC4Q6VXUiFLfWxVDqcAUoV2A38rN29H5Xw@mail.gmail.com>
In-Reply-To: <CAHk-=win-keZbx6GFC4Q6VXUiFLfWxVDqcAUoV2A38rN29H5Xw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Aug 2023 07:38:32 +0200
X-Gmail-Original-Message-ID: <CAHk-=wg25LEzeaDnGyj5KfGmujDuV+_96hCOhVx2ScOtLW40gQ@mail.gmail.com>
Message-ID: <CAHk-=wg25LEzeaDnGyj5KfGmujDuV+_96hCOhVx2ScOtLW40gQ@mail.gmail.com>
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

On Mon, 21 Aug 2023 at 06:55, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I do think that maybe we should then re-introduce the might_sleep() in
> some actually appropriate place in the page fault path, which might be
> 'handle_mm_fault()'.

Just to clarify: if we do it in handle_mm_fault(), we should obviously
do it only for kernel faults - just to avoid the unnecessary
preemption with lock held for the normal user space case.

That said, I don't love the handle_mm_fault() option, I just think it
would be lovely if we had that test in a generic place. Sadly, we
don't seem to have any such thing other than handle_mm_fault().

The reason we shouldn't do this for user space faults are fine is
because not only are they obviously always sleepable, but they also
reschedule on return to user space. So neither the debugging nor the
preemption makes sense there.

That's also why the per-vma locking paths don't need this - we only do
per-vma locking for user space faults.

So it really is only "kernel faults" it makes sense for, and they are
rare enough that I think the preemption point issue might be moot. But
it might still be better to just do this all as a special kernel fault
case in the exception handler - even if it's then
architecture-specific (like it always was before commit c2508ec5a58d).

              Linus
