Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B55176D614
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjHBRvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbjHBRun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:50:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3516B30DB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:49:55 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9dc1bff38so734061fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690998593; x=1691603393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dzqHOy3EWB73hskWYI+kku60VmM84hW7xpB+VPVJbzE=;
        b=PJe57APVquKdrZqgF+sCszYEyb2UnScLTCi8wiSntoLt7rSF6RF5RWoRcWAAiHbGNR
         WPUzxZ+ULna9NLm00CJSngiAJrdoA0sq5RN4LIb+NEs/+/M55nVOAocJLJ16cZ+j8YRt
         ijxJMXaiUwbiAa4GkzmhyphTzkmk4a9xJWdgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690998593; x=1691603393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dzqHOy3EWB73hskWYI+kku60VmM84hW7xpB+VPVJbzE=;
        b=bAVw1yAUF4aWXB37RmFS7N6tGhZN9R/AHHWRfvCsjDd0JyNvynJHcbHS9uEM6jqGHi
         lMaIYDMYeFhIdkI77z29L60NgtvNGxA6tsMoYEQNlO3QCdP5fTrspNKt6aRkQxCKWGL7
         x7gADq4rTk+cLHTfBo1PoysNPBoEwqr0FkM/vdA0Mmgx/AEp4hRbSZZjUpO5rI0EVtHL
         4vOiKxHE+RHp1k4+aKxFscbUHy1A6+HQr+9WqjyWSHL4vp1xzDXmXceHtqltQM5WAsM2
         KtwaSjX8XIbl2N8TgkOdqfxyWyyfmu7G7R6+d8EKF0bPP+NjqIh8lOJOOBHbff97lt04
         vmPw==
X-Gm-Message-State: ABy/qLbgFLUs3LIMJRgSVvbql7cb9j+Y6iDFSxAUmyRhC7XmxntS9R3C
        fg7cF6/OipVPboGr//f9obTvL8mxfmJnWYlpCqN80LbP
X-Google-Smtp-Source: APBJJlH0IlraVR+ZgnwGTJve6IgCBeSrVdgGZm5KtTZOEk6NkEeIfMhURLDaI7qtulIcpllDqxnjgg==
X-Received: by 2002:a2e:8042:0:b0:2b7:7ab:3c60 with SMTP id p2-20020a2e8042000000b002b707ab3c60mr5315427ljg.32.1690998593151;
        Wed, 02 Aug 2023 10:49:53 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id g2-20020a1709064e4200b00992025654c1sm9533091ejw.179.2023.08.02.10.49.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 10:49:52 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso2729a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:49:52 -0700 (PDT)
X-Received: by 2002:aa7:c0d2:0:b0:522:d6f4:c0eb with SMTP id
 j18-20020aa7c0d2000000b00522d6f4c0ebmr5009048edp.40.1690998591858; Wed, 02
 Aug 2023 10:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230801220733.1987762-1-surenb@google.com> <20230801220733.1987762-5-surenb@google.com>
In-Reply-To: <20230801220733.1987762-5-surenb@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Aug 2023 10:49:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wix_+xyyAXf+02Pgt3xEpfKncjT8A6n1Oa+9uKH8bXnEA@mail.gmail.com>
Message-ID: <CAHk-=wix_+xyyAXf+02Pgt3xEpfKncjT8A6n1Oa+9uKH8bXnEA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] mm: lock vma explicitly before doing
 vm_flags_reset and vm_flags_reset_once
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Aug 2023 at 15:07, Suren Baghdasaryan <surenb@google.com> wrote:
>
>       To make locking more visible, change these
> functions to assert that the vma write lock is taken and explicitly lock
> the vma beforehand.

So I obviously think this is a good change, but the fact that it
touched driver files makes me go "we're still doing something wrong".

I'm not super-happy with hfi1_file_mmap() doing something like
vma_start_write(), in that I *really* don't think drivers should ever
have to think about issues like this.

And I think it's unnecessary.  This is the mmap op in the
hfi1_file_ops, and I think that any actual mmap() code had _better_
had locked the new vma before asking any driver to set things up (and
the assert would catch it if somebody didn't).

I realize that it doesn't hurt in a technical sense, but I think
having drivers call these VM-internal subtle locking functions does
hurt in a maintenance sense, so we should make sure to not have it.

                   Linus
