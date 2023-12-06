Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0AB806E3A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:40:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377692AbjLFLkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377788AbjLFLk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:40:27 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F6AD44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:40:31 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9fa2714e828so86860866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701862830; x=1702467630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/26r/6GOwa32rBsBcHaWMe5TGP6HNoxFIVtT+JWT49g=;
        b=Q4UoIlLX2tFqOMzkHvJavYOm11BYCKQDwWuBsxU1buh6WieEJuadTG/F+Ov7eFULa3
         aE3y4pv/0vXi7CcnbquoC5XDyQX/KsB2fV4jYzAq0VsMEmyVBhylcpzSVVxisUOC7ren
         kMRAgS2khTHyzytlpCsvzsqZ0smiLLdeJop8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701862830; x=1702467630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/26r/6GOwa32rBsBcHaWMe5TGP6HNoxFIVtT+JWT49g=;
        b=v6Je18W/CKqksQnQqfTdMF18uRn/KSwf7FsVko3U5pztcxi0sxonCjSeb6TMaLYdR/
         npaRwa8m7+peYQFv9mbrjxBy75YbZHHDfs+CsyyJZllXFP/Ls2FbA8tFtp86epf/liR5
         bB6/CyN0tw3CvXNK5TX+lsd0bTGjGqraxfATzxzVV1s/SK8YZAZlFT3EaLsbIKa0GPBu
         5RqYWxBJGZhgaQ57tEaJa/rqA8uGRRg703aka+EcYYbxWyMSJbVn+QynTmhBMj1EjNMG
         bZNnlVVW6nn4R99EKIyaGawfwhSzEyToR5lktkOmrGyk/h4kAx51tPh/i52bcx2tu0oQ
         3iwg==
X-Gm-Message-State: AOJu0YzOov2n4LCY+BDP8jO8jiPZJvYBO3CCL10Ej5jih17q6fMOV8rW
        dq+aOw4eUn1pUnK7iQ09JKk4tWzhXDaEmmegdN/QcAvg
X-Google-Smtp-Source: AGHT+IE927fCj2O6IGUZdZ8gJMPKz8ytzreTmT2c9Qcxn5eLyMWpljlSBjvPExMibykROq9Y17R5BA==
X-Received: by 2002:a17:906:c40e:b0:a02:38a2:4d79 with SMTP id u14-20020a170906c40e00b00a0238a24d79mr477523ejz.41.1701862830033;
        Wed, 06 Dec 2023 03:40:30 -0800 (PST)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id w27-20020a1709060a1b00b00a1d232b39b3sm1485807ejf.145.2023.12.06.03.40.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 03:40:28 -0800 (PST)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a1d450d5c11so85373166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:40:28 -0800 (PST)
X-Received: by 2002:a17:906:2c4a:b0:a19:a19b:55cd with SMTP id
 f10-20020a1709062c4a00b00a19a19b55cdmr445444ejh.93.1701862828153; Wed, 06 Dec
 2023 03:40:28 -0800 (PST)
MIME-Version: 1.0
References: <000000000000784b1c060b0074a2@google.com> <20231205113107.1324-1-hdanton@sina.com>
 <317e077b-71a7-4112-a7d0-5c49efce4f39@I-love.SAKURA.ne.jp>
 <ZXBCB2Gv1O-1-T6f@alley> <20231206112215.1381-1-hdanton@sina.com>
In-Reply-To: <20231206112215.1381-1-hdanton@sina.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 6 Dec 2023 20:40:10 +0900
X-Gmail-Original-Message-ID: <CAHk-=wiHJAb6NJU7rqy6NZsh0SoJfFdpQG_Gc0iFcuLcFAZ++g@mail.gmail.com>
Message-ID: <CAHk-=wiHJAb6NJU7rqy6NZsh0SoJfFdpQG_Gc0iFcuLcFAZ++g@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] possible deadlock in stack_depot_put
To:     Hillf Danton <hdanton@sina.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        syzbot <syzbot+186b55175d8360728234@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        syzkaller-bugs@googlegroups.com
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

On Wed, 6 Dec 2023 at 20:22, Hillf Danton <hdanton@sina.com> wrote:
>
> Given the same pattern in both up() and __mutex_unlock_slowpath() where
> acquire raw spinlock to wake waiter up, it is safe to unlock mutex in
> irq context.

What? No. That spinlock is exactly why it is NOT OK to unlock a mutex
in irq context.

If somebody else is trying to get or release the mutex at the same
time an interrupt happens, you now have an immediate deadlock.

No spinlocks - raw or not - are irq safe.

The only way you make them irq-safe is by disabling interrupts
entirely across the locked region, which the mutex code very much does
not do, and does not want to do.

So no. Mutexes are not usable from interrupts.

So repeat after me: MUTEXES CANNOT BE USED IN ANY FORM IN INTERRUPT
CONTEXT. End of story.

Other locks do work. completions are designed to be done from
interrupts. And our legacy semaphores were irq-safe (for wakeups) from
day one, which is then why the spinlock in the legacy semaphore is
done with interrupts disabled, and why you can do "down_trylock()" and
"up[()" in interrupt context.

But mutexes wanted to consciously avoid that, partly *exactly* because
they didn't want to have the more expensive irq-safe spinlocks
(particularly with the debugging versions)

            Linus
