Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71DF678A68F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 09:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjH1Hdx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Aug 2023 03:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjH1Hdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 03:33:40 -0400
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA42CC;
        Mon, 28 Aug 2023 00:33:38 -0700 (PDT)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5920efd91c7so33095807b3.2;
        Mon, 28 Aug 2023 00:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693208018; x=1693812818;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twwg7V6K5h5vu0zZiNn8PwZ/O/DRHer4vjbsqZJL+Zo=;
        b=XYDefuh19iXQUOwD+KbKD+qCW+CU4MR95vMFJG2vOlTJCuI9LB1mPHNbAtAeMm3OjX
         iEzvwTtYx0JDihEWQ/nANY+NkiIFfTMKcpHzWFsgH9wfEhPb4Zc27EH5TqypCwa7tzWR
         s/xAnXOJdV1/QXwDlEkKIWpGBf0G2NGojLkEX8WV0zRn96+7PFqp00ZM7gpWjZajw3en
         DFeQPm1t7Ll7pV1Olj0tG0hsdqclDnLhTqhE9Uat+XDYg/+tYqPaul0omqUSWlTX+t0l
         vWhklXdcmV10+QwR+49vN3n5SBt3xfv/BiLDVrxeW+nu813YClbyVbV7otPnUw+Y8rvy
         D0Fw==
X-Gm-Message-State: AOJu0YzeA1XhbFjbZQtoAAnyD75h6Xo4Ic+33BxC4y7Ci6E/qVT8kIlC
        2XsWvJWAyF9eGPXsEQlX3BhApJbN8mwrxw==
X-Google-Smtp-Source: AGHT+IFb78yYb0UnkoeTSqnwwDk99rP53x7u/j4alYyhdq3nYxH1UK8WiucxPx2Le+3TymcoPPX/CA==
X-Received: by 2002:a0d:db4b:0:b0:589:a095:76ca with SMTP id d72-20020a0ddb4b000000b00589a09576camr26716201ywe.44.1693208017900;
        Mon, 28 Aug 2023 00:33:37 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id r189-20020a0dcfc6000000b0058fb9863fe7sm1968175ywd.103.2023.08.28.00.33.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 00:33:37 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d77f97a0e72so2888198276.0;
        Mon, 28 Aug 2023 00:33:36 -0700 (PDT)
X-Received: by 2002:a25:9cc3:0:b0:d09:a51:8e7a with SMTP id
 z3-20020a259cc3000000b00d090a518e7amr23396808ybo.47.1693208016589; Mon, 28
 Aug 2023 00:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <ZOkGCSNr0VN2VIJJ@p100> <CAHk-=wjZwSymfuGvf7TX3UQLU1OMN1FZMnEA-Hja0ruqyhMK4A@mail.gmail.com>
 <CAHk-=whVvD05T0yD5DQj803uETLD6qDq-Vx-SiLPcrL=eO77LQ@mail.gmail.com>
 <CAKwvOdnYauyrzz7-ceH-MP_KZ5ED8oYxjRx_Xei68=tUOSeKyA@mail.gmail.com>
 <CAGG=3QWcZPYqHMcjwuYDz1+OQhzS40hmhdOvSBZBQOkhs8YAQQ@mail.gmail.com>
 <CAGG=3QX8AaTedPy-joWm6yp+TFHBVXm59OcvxkdLGsSuDjem5g@mail.gmail.com>
 <CAHk-=wjQpXpnGAwvv-oBi+cQ0g+D9rTK5STkXSSV4a90FPR+EQ@mail.gmail.com>
 <CAKwvOdm_y6UOnxFrAiDxou2jc8CRUvyhfH9kAdc3PG0=bEvduw@mail.gmail.com> <CAHk-=wgJzMzPFTCzejWs1WM4=74z2VENyOzySnucrXG3i=ajrw@mail.gmail.com>
In-Reply-To: <CAHk-=wgJzMzPFTCzejWs1WM4=74z2VENyOzySnucrXG3i=ajrw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 28 Aug 2023 09:33:25 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXZ4fGjjXguftvrB69rt7dR6ngFA46YB8oGpk2_issJzA@mail.gmail.com>
Message-ID: <CAMuHMdXZ4fGjjXguftvrB69rt7dR6ngFA46YB8oGpk2_issJzA@mail.gmail.com>
Subject: Re: [PATCH] lib/clz_ctz.c: Fix __clzdi2() and __ctzdi2() for 32-bit kernels
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>, Helge Deller <deller@gmx.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Chanho Min <chanho.min@lge.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Sat, Aug 26, 2023 at 3:08 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, 25 Aug 2023 at 17:52, Nick Desaulniers <ndesaulniers@google.com> wrote:
> And quite often we simply use other names - but then we also do *not*
> build with -freestanding, because -freestanding has at least
> traditionally meant that the compiler won't optimize the simple and
> obvious cases (typically things like "memcpy with a constant size").

Several architectures (incl. x86, but excl. amd64) do build the kernel with
-freestanding.

IIRC, the issue was that without that, gcc was "optimizing" calls
to standard functions (implemented as inline optimized assembler
functions) by replacing them with calls to other standard functions
(also implemented as inline optimized assembler functions).  As the
latter became external calls, this defeated the optimized assembler
implementation, and could even cause build failures if no external
implementation was available.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
