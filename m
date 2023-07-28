Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808A57671BC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjG1QTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjG1QTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:19:07 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A659F1BF2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:19:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bed101b70so129084766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690561143; x=1691165943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oiqXtLXb56gWHpFHlkrGXB0htpi3zn1ShhYELBek5ko=;
        b=bynKf6n+TpRfz0DyR2rYNbqu0v4M0dTgmVz8xWQq8X+28lhY2cl5XnPRKgqX9HAqiE
         H79vFTkAB/9Itwu2leZ1xBpWwBB4F2uReu+dWnEz72qQ+dgV9BK2g3sOlh+7HQG5ShkZ
         9P+UQsfvk3Zbb2D6K+z9GjqGwuGQGpMLf/2Vk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690561143; x=1691165943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oiqXtLXb56gWHpFHlkrGXB0htpi3zn1ShhYELBek5ko=;
        b=OuzElrfl70+GCeOfi5AujhdSfCarjsZWEopwmYp5EMS+S5Sxkdk2oubCc/9lfyUddG
         je0RSUfICqhycR+eqvud7Ft1Q0qKpBB6vavBcMPlaNjSAiVPb5wWdLbZbzdAPpmNY7h8
         bjhrlcLfeb/GmEHZKxbRrWd2fmK/x67mD9g+fibNRmyRKiw2s3DUAJTFfqsGMXSAwIWj
         dxBQ/xzSgG2Tv/cBb97sfMU+XMnjztyntVlqHkjhXnLC1GvKBl7EyaHSegwSNX7skddH
         b5auryxmOaC93N5Bk7AdcW2cLGhpjWA5rwotsrwZhoW3w/oMVZslDXiQ0SMw7DOiNrN6
         9crw==
X-Gm-Message-State: ABy/qLaBuWSid5N+T8Pej8yiye02/kuiy2CCqgbIP1nJE8SdoEeh7RKq
        P75Gd1Zw3GxC70KPZRNUVcuhKWiLd58N+b5XWVL7aBDt
X-Google-Smtp-Source: APBJJlHtHnySbls+rIikJ/DoMFTNgt0h2iBwUcrqg0Wgn3rTIkQy1vToeRUv9a55cqtlXJ8lFShMFA==
X-Received: by 2002:a17:906:845c:b0:99b:465c:fb9f with SMTP id e28-20020a170906845c00b0099b465cfb9fmr2787546ejy.8.1690561142849;
        Fri, 28 Jul 2023 09:19:02 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id dc26-20020a170906c7da00b00988e953a586sm2220259ejb.61.2023.07.28.09.19.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 09:19:02 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5222b917e0cso3093600a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:19:02 -0700 (PDT)
X-Received: by 2002:a05:6402:1141:b0:51e:5322:a642 with SMTP id
 g1-20020a056402114100b0051e5322a642mr2296690edw.27.1690561141923; Fri, 28 Jul
 2023 09:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212845.135673-1-david@redhat.com>
In-Reply-To: <20230727212845.135673-1-david@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jul 2023 09:18:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
Message-ID: <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone fallout
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>, Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 at 14:28, David Hildenbrand <david@redhat.com> wrote:
>
> This is my proposal on how to handle the fallout of 474098edac26
> ("mm/gup: replace FOLL_NUMA by gup_can_follow_protnone()") where I
> accidentially missed that follow_page() and smaps implicitly kept the
> FOLL_NUMA flag clear by *not* setting it if FOLL_FORCE is absent, to
> not trigger faults on PROT_NONE-mapped PTEs.

Ugh.

I hate how it uses FOLL_FORCE that is inherently scary.

Why do we have that "gup_can_follow_protnone()" logic AT ALL?

Couldn't we just get rid of that disgusting thing, and just say that
GUP (and follow_page()) always just ignores NUMA hinting, and always
just follows protnone?

We literally used to have this:

        if (!(gup_flags & FOLL_FORCE))
                gup_flags |= FOLL_NUMA;

ie we *always* set FOLL_NUMA for any sane situation. FOLL_FORCE should
be the rare crazy case.

The original reason for not setting FOLL_NUMA all the time is
documented in commit 0b9d705297b2 ("mm: numa: Support NUMA hinting
page faults from gup/gup_fast") from way back in 2012:

         * If FOLL_FORCE and FOLL_NUMA are both set, handle_mm_fault
         * would be called on PROT_NONE ranges. We must never invoke
         * handle_mm_fault on PROT_NONE ranges or the NUMA hinting
         * page faults would unprotect the PROT_NONE ranges if
         * _PAGE_NUMA and _PAGE_PROTNONE are sharing the same pte/pmd
         * bitflag. So to avoid that, don't set FOLL_NUMA if
         * FOLL_FORCE is set.

but I don't think the original reason for this is *true* any more.

Because then two years later in 2014, in commit c46a7c817e66 ("x86:
define _PAGE_NUMA by reusing software bits on the PMD and PTE levels")
Mel made the code able to distinguish between PROT_NONE and NUMA
pages, and he changed the comment above too.

But I get the very very strong feeling that instead of changing the
comment, he should have actually removed the comment and the code.

So I get the strong feeling that all these FOLL_NUMA games should just
go away. You removed the FOLL_NUMA bit, but you replaced it with using
FOLL_FORCE.

So rather than make this all even more opaque and make it even harder
to figure out why we have that code in the first place, I think it
should all just be removed.

The original reason for FOLL_NUMA simply does not exist any more. We
know exactly when a page is marked for NUMA faulting, and we should
simply *ignore* it for GUP and follow_page().

I think we should treat a NUMA-faulting page as just being present
(and not NUMA-fault it).

Am I missing something?

                  Linus
