Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6B17CE5CC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjJRSB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjJRSB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:01:56 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B64B8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:01:51 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507ad511315so5129352e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697652109; x=1698256909; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZItgi/26ljXyDWT88p+j+vFHLDbnwaOnBmv/sklK2Kc=;
        b=Zoj7MEUpsEnvemtSZf1WZ86taRnPp24Lq2J1F9gFKl9kxaGrskh8WKN7YBS5dpi82z
         UTTdCP2SDmLR/7F0JO8n0EmvcT9LKUK3zb9olH5+dgJLHEs+JuTGln7PfMARagFIqjpb
         rIBxB+jm8O+wuuqM+znToOVgzRnKwZ8QWizf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652109; x=1698256909;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZItgi/26ljXyDWT88p+j+vFHLDbnwaOnBmv/sklK2Kc=;
        b=p1r03hufL8GHFTQcs4BXryWfickj/q8ZhXULuWl+2fdLv3RUWDfkiY7YNI7Cr9bL7C
         5fxCAW4+5Y9Iwl1qhMw6YhE0oRWO3SXBPL5HH/LPyq5M0rAg2SAT8iW5g2PlJIoIOTIW
         GfBAJUn53F3eFBJf7dOTvrHQhtcPAndJC4E63AUCQO0IKSjD1Xhz6vu5r5mckEgfeeMt
         kMsLbLNI+NjNYBJUsi/f/Lqfjrpw80J+wg3fJ3h0WPjzPhiqcW+JgXvv2OckaAjoi74R
         XUQFQAR2+aHYwNheAur6Zdyi1IhP30HgzyC/f4fJfXNYH/OraGGDaCd0kC7gTll3brwm
         MhpA==
X-Gm-Message-State: AOJu0YwV4hNBzEiXu1egkkZ3r/cIJd5uWFjLhWqulGCQ2vVUtIzE9lUF
        /nE7FJQ82IZ/nF6ys+2vYRSTMhB8gs4GM2IhJbkXmN8k
X-Google-Smtp-Source: AGHT+IFIWT/oi6A6BYZ+jOmbSEr8O5L43pFsyBimH3zfD+GoJe292TFes74rbFtkeB6t4w5oqmZLlQ==
X-Received: by 2002:ac2:5a4e:0:b0:502:ff3b:766f with SMTP id r14-20020ac25a4e000000b00502ff3b766fmr4156539lfn.6.1697652109307;
        Wed, 18 Oct 2023 11:01:49 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id p10-20020ac24eca000000b0050300e013f3sm785544lfr.254.2023.10.18.11.01.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:01:48 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2c50cd16f3bso74909001fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:01:48 -0700 (PDT)
X-Received: by 2002:ac2:5ecd:0:b0:507:9787:6773 with SMTP id
 d13-20020ac25ecd000000b0050797876773mr4693334lfq.36.1697652108120; Wed, 18
 Oct 2023 11:01:48 -0700 (PDT)
MIME-Version: 1.0
References: <20231010164234.140750-1-ubizjak@gmail.com> <CAHk-=whYWhZN52SJN-Th9x2L2V-vHtAXUgiy_nSJ3+vQU6ak4Q@mail.gmail.com>
 <CAFULd4ZqH3FeG8_mjDvUAU9QiGB36wDu3MzUtadgAgoVuQ9QRg@mail.gmail.com>
 <CAHk-=wiALZxieQQmvv5sW15HYB_YwC3d_ma9sdp7Zb4Fb4uK2w@mail.gmail.com>
 <F48A9D34-3627-4372-B555-B58CBFC3F241@vmware.com> <CAHk-=wjF4gzCZKh-zN-sY0WpX1kCo+s9gYE9sOcSv0QieH1dwQ@mail.gmail.com>
 <CAFULd4bmOa7G2dXd_mu4J=_bsEs+TbxH691tYx9QQBwJPAma9w@mail.gmail.com>
 <CAHk-=wj2Co_g3RQ=JkDZC7PYbRqDPq7mePQ0=eYhhtpEgqJD0w@mail.gmail.com>
 <0617BB2F-D08F-410F-A6EE-4135BB03863C@vmware.com> <CAFULd4Zjd6idrLXuF59cwKxyd1a--DsiJwGQAKai9Tph30dAow@mail.gmail.com>
 <CAHk-=wgSsfo89ESHcngvPCkQSh_YAJG-0g7fupb+Uv0E1d_EcQ@mail.gmail.com>
 <7D77A452-E61E-4B8B-B49C-949E1C8E257C@vmware.com> <CAHk-=wj1dLFkL9Qv2vtk0O8Q6WE-11Jq3KucZoz2Kkw59LAexw@mail.gmail.com>
 <9F926586-20D9-4979-AB7A-71124BBAABD3@vmware.com> <CAHk-=wi7YKPKKZw5SpA9gZcf4paG4pZ2kUM50g-LQmdF0g6vWg@mail.gmail.com>
 <CAFULd4bpHkNzCzKed23mTTBWRyhPnOm91f+F6UE413VK+oFtMQ@mail.gmail.com>
 <CAFULd4Z-q4Ot6iyOLo7DkjE=dY3RHXUV+yx6R0iWk=-tZ6ufhQ@mail.gmail.com>
 <CAHk-=wjSnECwAe+Bi0PD6uods3ZDs8up5OAy-qZKF5OgPLpDiA@mail.gmail.com>
 <CAFULd4bLEU-tBC8dO1wf66UAxQ2d1HxQ=D6wvtHZfdQCKhnpkw@mail.gmail.com>
 <CAFULd4YAFTFqon3ojv7N6h=G_1pAjSH3T6YvX0G=g7Fwh7j1jQ@mail.gmail.com>
 <A2E458DE-8B84-4FB2-BF6D-3EAB2B355078@vmware.com> <CAFULd4b_PdKb=8U5+Zz-XNoYdULtcQJnmf-yCrpCv7RRogSXyQ@mail.gmail.com>
 <CAFULd4Y8_MOMGcatcMuUaC89zX5F-VYr0niiJ9Yd8hQ16neHjw@mail.gmail.com>
 <CAHk-=wiB6LHPmnG7=RWNuQYY9=jCY0EmaJ7thRBEFOfDO09dfw@mail.gmail.com> <CAFULd4YHq7tKQBNk9bNYZkBo9C5XM+6=O7QZG3E-qKBVjSHb6g@mail.gmail.com>
In-Reply-To: <CAFULd4YHq7tKQBNk9bNYZkBo9C5XM+6=O7QZG3E-qKBVjSHb6g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Oct 2023 11:01:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgbLLH7Eh2mDHp-k0+qtE-aXpzut7_Ee9dwZ5YVw8BrA@mail.gmail.com>
Message-ID: <CAHk-=wjgbLLH7Eh2mDHp-k0+qtE-aXpzut7_Ee9dwZ5YVw8BrA@mail.gmail.com>
Subject: Re: [PATCH v2 -tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Nadav Amit <namit@vmware.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 at 10:08, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> Sure. Now the patch looks quite slim, but works as expected, reducing
> the number of current_task accesses from 3841 to 3220.

Thanks, that patch looks lovely to me.

Since you've done all the hard lifting and the testing, I'd suggest
you submit this all to the x86, including my fpu patch. Take my
sign-off, and the commit message might be something along the lines of

    x86: clean up fpu switching in the middle of task switching

    It happens to work, but it's very very wrong, because our 'current'
    macro is magic that is supposedly loading a stable value.

    It just happens to be not quite stable enough and the compilers
    re-load the value enough for this code to work.  But it's wrong.

    It also generates worse code.

    So fix it.

    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

or add any verbiage you feel appropriate.

               Linus
