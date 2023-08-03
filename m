Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFB876F163
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 20:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbjHCSES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 14:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjHCSDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 14:03:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E95724488
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 11:02:16 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so2167999e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 11:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691085730; x=1691690530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2DvzNefb/LLJHkcM92Xy5CmVgSgsFXUiX9UPGxAI7fs=;
        b=Uta/vxu7GzeSQlwClVarcyoF4J7XyUCowS43lGWsIxyqeV6V4Tho4kVuvS7dp5INRn
         YXO53c96u5FM5uDd+YGS30In1ohMPANTJQ7BbRd5ESAMmD1FYqwS3Z8WnMipSDWtKNzb
         wxUOuEMU88GLLOPPDA5hnl4TX5jB6MqyCDZYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691085730; x=1691690530;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2DvzNefb/LLJHkcM92Xy5CmVgSgsFXUiX9UPGxAI7fs=;
        b=UGOnH7H5+klE9QP19r56IF++Ty5AVx0eh+YzpKaUtUB/rMrV+2Y3gs7Xv117MgixvT
         +3bHgheMbDIPwweRFZExCS5MnNpKyhxgBcgamxVyaI2MYzS0AXW/hyUNQxWvXjvB+8Ix
         5X751tRC4mQGr6ZTDWjd/RNEt2NyVMnXZm2c/BtqrX4u/qf1/Pm7oZZK/7VCPvXjIj7m
         ZiTEtddSJJ3iA7BB1cSxLWrFIG6KLdat4Fas4aD3YPwHlDc7MmCszswnv8z9wxgk445T
         FslG21HjVW6xo3SLtcr+zPrvM6Fyq5hSJmcZXcbXBiewSS8eG8PuB9JwtR5dp6JMrGmq
         gIwg==
X-Gm-Message-State: ABy/qLZ8KVQXfiDc0zF9D/57FO2s9nVNJ/PssYDcZKZzJ+X9ZwbrWHYV
        0oF54yJSfdQBNHRIqyiFjrjgeSMrW6su78c0vbyokiTG
X-Google-Smtp-Source: APBJJlEvReSlSIeXyOWWIjt9i8P6RBkWxn7JSfRTvKjcyJQhNWOtxfVrTTyyxmHVgx5TroSuPlCIWQ==
X-Received: by 2002:a05:6512:60c:b0:4f9:5933:8eea with SMTP id b12-20020a056512060c00b004f959338eeamr7518851lfe.3.1691085730157;
        Thu, 03 Aug 2023 11:02:10 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id w25-20020ac24439000000b004f85885cff1sm49336lfl.134.2023.08.03.11.02.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Aug 2023 11:02:08 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so2167908e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 11:02:08 -0700 (PDT)
X-Received: by 2002:a19:384d:0:b0:4fe:d0f:b4f7 with SMTP id
 d13-20020a19384d000000b004fe0d0fb4f7mr7004017lfj.65.1691085727752; Thu, 03
 Aug 2023 11:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230803172652.2849981-1-surenb@google.com> <20230803172652.2849981-6-surenb@google.com>
In-Reply-To: <20230803172652.2849981-6-surenb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Aug 2023 11:01:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiCrWAoEesBuoGoqqufvesicbGp3cX0LyKgEvsFaZNpDA@mail.gmail.com>
Message-ID: <CAHk-=wiCrWAoEesBuoGoqqufvesicbGp3cX0LyKgEvsFaZNpDA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mm: always lock new vma before inserting into vma tree
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

On Thu, 3 Aug 2023 at 10:27, Suren Baghdasaryan <surenb@google.com> wrote:
>
> While it's not strictly necessary to lock a newly created vma before
> adding it into the vma tree (as long as no further changes are performed
> to it), it seems like a good policy to lock it and prevent accidental
> changes after it becomes visible to the page faults. Lock the vma before
> adding it into the vma tree.

So my main reaction here is that I started to wonder about the vma allocation.

Why doesn't vma_init() do something like

        mmap_assert_write_locked(mm);
        vma->vm_lock_seq = mm->mm_lock_seq;

and instead we seem to expect vma_lock_alloc() to do this (and do it
very badly indeed).

Strange.

Anyway, this observation was just a reaction to that "not strictly
necessary to lock a newly created vma" part of the commentary. I feel
like we could/should just make sure that all newly created vma's are
always simply created write-locked.

                Linus
