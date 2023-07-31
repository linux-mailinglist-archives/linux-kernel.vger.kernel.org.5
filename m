Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532C5769FF4
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjGaSC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjGaSC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:02:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF5DE4E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:02:55 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe2503e3easo4572961e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690826574; x=1691431374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sbvUvGljtEHmYL7qi+HXkrNPoFOxFR5BvYu2TjHTwr0=;
        b=D9E3ZcdecHW/AeFtZ+rCyYRCgHd0EAWCQWVnJetVe9U1Clq/ZnJaJrwTDKMMR3Fmf5
         UXD34A6gN2F/PSEALsGXpwpUVIwSnPxQeOKMAHBIh62cfyrlXiQ1rLHGKVKtEeobsXeZ
         YDya2STnECp5Gel9dceP0mS/Kmtlorb/H51OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690826574; x=1691431374;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sbvUvGljtEHmYL7qi+HXkrNPoFOxFR5BvYu2TjHTwr0=;
        b=QUdZVF0ePaUypxsdIx5Q/+9k38nIVR5oT9rFgzzkfQTkrXN/ELpRuQyTcMeUSEalnn
         XIfMExwtwhFDQalsZGhaTrf5EdWUcQ+E/lY0d3PcAs5xWW3VEC8WDVoGSOflYLQbS1yp
         jmX8OZIDm1+zgFPLikpRxRr+qwLIZFKmqKl08rJ1BclwYy1FgpDCk5eqFHsxHE1XmzGD
         komkLvqMQ1H5lFdKFBstx9NvZoiHRopCHkZEaVAz5Wu4VC6ccenL1VxRfECc05AhIQSI
         DVuEfm9Z8FVr52+VILz789m2J4pferVI8yjwOuljDmivX68Wl+pvJWm95YoJXaCwXXkH
         Akyg==
X-Gm-Message-State: ABy/qLaN5c6+2FZ2O5c8MLa+q40yZmjN6b4ewGHvPmvJoHgK+H16VLqX
        bAgZdXKsQt5xWgXB3ze9wrFpauGWYuQQJmq6AOcCYw==
X-Google-Smtp-Source: APBJJlF6dbwLQb837FZeJ62/1PZ9C/4JmR/8AqKQJuZaHxJ/Y3D3zSSIOJAXfDLM0g/cyQ8v67doDQ==
X-Received: by 2002:a05:6512:2e9:b0:4fe:819:b0ed with SMTP id m9-20020a05651202e900b004fe0819b0edmr381442lfq.46.1690826574088;
        Mon, 31 Jul 2023 11:02:54 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id y19-20020ac24473000000b004fe0f0eff15sm2173609lfl.191.2023.07.31.11.02.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 11:02:53 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe41f7c7ffso197413e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:02:53 -0700 (PDT)
X-Received: by 2002:ac2:4e07:0:b0:4fe:ec5:2698 with SMTP id
 e7-20020ac24e07000000b004fe0ec52698mr498383lfr.50.1690826573309; Mon, 31 Jul
 2023 11:02:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230731171233.1098105-1-surenb@google.com> <20230731171233.1098105-2-surenb@google.com>
In-Reply-To: <20230731171233.1098105-2-surenb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 11:02:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEbJS3OhUu+2sV8Kft8GnGcsNFOhYhXYQuk5nvvqR-NQ@mail.gmail.com>
Message-ID: <CAHk-=wjEbJS3OhUu+2sV8Kft8GnGcsNFOhYhXYQuk5nvvqR-NQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: enable page walking API to lock vmas during the walk
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, jannh@google.com, willy@infradead.org,
        liam.howlett@oracle.com, david@redhat.com, peterx@redhat.com,
        ldufour@linux.ibm.com, vbabka@suse.cz, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, hannes@cmpxchg.org,
        dave@stgolabs.net, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 at 10:12, Suren Baghdasaryan <surenb@google.com> wrote:
>
> -               walk_page_vma(vma, &subpage_walk_ops, NULL);
> +               walk_page_vma(vma, &subpage_walk_ops, true, NULL);

Rather than add a new argument to the walk_page_*() functions, I
really think you should just add the locking rule to the 'const struct
mm_walk_ops' structure.

The locking rule goes along with the rules for what you are actually
doing, after all. Plus it would actually make it all much more legible
when it's not just some random "true/false" argument, but a an actual

        .write_lock = 1

in the ops definition.

Yes, yes, that might mean that some ops might need duplicating in case
you really have a walk that sometimes takes the lock, and sometimes
doesn't, but that is odd to begin with.

The only such case I found from a quick look was the very strange
queue_pages_range() case. Is it really true that do_mbind() needs the
write-lock, but do_migrate_pages() does not?

And if they really are that different maybe they should have different walk_ops?

Maybe there were other cases that I didn't notice.

>                 error = walk_page_range(current->mm, start, end,
> -                               &prot_none_walk_ops, &new_pgprot);
> +                               &prot_none_walk_ops, true, &new_pgprot);

This looks odd. You're adding vma locking to a place that didn't do it before.

Yes, the mmap semaphore is held for writing, but this particular walk
doesn't need it as far as I can tell.

In fact, this feels like that walker should maybe *verify* that it's
held for writing, but not try to write it again?

Maybe the "lock_vma" flag should be a tri-state:

 - lock for reading (no-op per vma), verify that the mmap sem is held
for reading

 - lock for reading (no-op per vma), but with mmap sem held for
writing (this kind of "check before doing changes" walker)

 - lock for writing (with mmap sem obviously needs to be held for writing)

>         mmap_assert_locked(walk.mm);
> +       if (lock_vma)
> +               vma_start_write(vma);

So I think this should also be tightened up, and something like

        switch (ops->locking) {
        case WRLOCK:
                vma_start_write(vma);
                fallthrough;
        case WRLOCK_VERIFY:
                mmap_assert_write_locked(mm);
                break;
        case RDLOCK:
                mmap_assert_locked(walk.mm);
        }

because we shouldn't have a 'vma_start_write()' without holding the
mmap sem for *writing*, and the above would also allow that
mprotect_fixup() "walk to see if we can merge, verify that it was
already locked" thing.

Hmm?

NOTE! The above names are just completely made up. I dcon't think it
should actually be some "WRLOCK" enum. There are probably much better
names. Take the above as a "maybe something kind of in this direction"
rather than "do it exactly like this".

            Linus
