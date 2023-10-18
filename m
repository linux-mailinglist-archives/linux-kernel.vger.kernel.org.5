Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 305B07CE61A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 20:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjJRSQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 14:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjJRSQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 14:16:23 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA52B6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:16:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c501bd6ff1so85355721fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697652978; x=1698257778; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rwRonke7ZPJesfb6lkAk8Jef9jxQLTB9Ut1BCrObTy4=;
        b=Q8QC5EFGy3idAI8OotHJpH82GnEvRxnZbrGKVZtJoEt2ET9cgChsMKQSuR7yDzbdOC
         WtsFtdVNwww1TBKTm+YdqUtZrX8Ylqv1sBw3sjlicegQXp4qUM4GrZ6y5/qqHI59iJVM
         B6Ay2jl7KQO8YHyztLCZvghzooYKmI++hXs+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697652978; x=1698257778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rwRonke7ZPJesfb6lkAk8Jef9jxQLTB9Ut1BCrObTy4=;
        b=JXsA+Qsqwd+2bNsWKI0LdcG10C9t7BR5XuLBhRLoGPw3m1OF5sPqCo+zfD2UJW6Ouv
         ZvopyGyziX7Q9BdkUzM25GIF73q5/bjAs2EAz9eHGHnCW1YqTz8K4SECghbOgZDsxONQ
         duEvIT+BA/tkiyoYtXuJCink24i5QXUXLd8fXtRpqL/oTQMckX7DRxW7STqU9q6G9RnO
         rN94TYvHMJFKhTy0r6MP8rMNYNz5Hs/7fidnxWN26qdtxcB79wKwI8ZvROfskQHN7ESq
         9RXNMaqM6PBqOUyZqGnwUMeyKUExVRSuvcFpw03AAwDxrH6HomGPnnAe2mRCCfFmVLjH
         5iXQ==
X-Gm-Message-State: AOJu0YwMZ13SVcYBXbKl8PTTlRUXsu3N77weBLvnvRuSdFBL4tPz6mgO
        anpN9eO/BUnZtuDKj82EjC0l4c54qS8lADHSKKCClEXR
X-Google-Smtp-Source: AGHT+IHhV2I1DTRlV2iu/7aSj9C3/fZoL2MdKbOPSd8t2zbIObxjGPTvqVw65P0MUoZPx20p7CoT8Q==
X-Received: by 2002:a2e:9d0f:0:b0:2c5:27ca:4784 with SMTP id t15-20020a2e9d0f000000b002c527ca4784mr4317986lji.4.1697652977999;
        Wed, 18 Oct 2023 11:16:17 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id q18-20020a2e9692000000b002b6da7e01d3sm802114lji.31.2023.10.18.11.16.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:16:17 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-507a0907896so6510526e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 11:16:17 -0700 (PDT)
X-Received: by 2002:ac2:483a:0:b0:505:7896:18de with SMTP id
 26-20020ac2483a000000b00505789618demr4333579lft.45.1697652977179; Wed, 18 Oct
 2023 11:16:17 -0700 (PDT)
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
 <3F9D776E-AD7E-4814-9E3C-508550AD9287@vmware.com> <CAFULd4Zruoq4b5imt3NfN4D+0RY2-i==KGAwUHR8JD0T8=HJBw@mail.gmail.com>
 <28B9471C-4FB0-4AB0-81DD-4885C3645E95@vmware.com> <CAHk-=whS8-Lk_=mFp=mr-JrbRYtScgz-4s_GLAOQGafa_3zP9g@mail.gmail.com>
 <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
In-Reply-To: <CAFULd4Yy-v40tK94rexSOL99FGMke2Jk42wgcjoEBxV=2hXoCw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Oct 2023 11:15:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
Message-ID: <CAHk-=wjrLoy6xEDXB=piEUagDLMmV5Up7UK75W1D0E0UFVO-iA@mail.gmail.com>
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
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Oct 2023 at 11:08, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> But loads from non-const memory work like the above.

Yes, I'm certainly ok with the move to use plain loads from __seg_gs
for the percpu accesses. If they didn't honor the memory clobber, we
could never use it at all.

I was just saying that the 'const' alias trick isn't useful for
anything else than 'current', because everything else needs to at
least honor our existing barriers.

(And yes, there's the other user of this_cpu_read_stable() -
'top_of_stack', but as mentioned that doesn't really matter).

          Linus
