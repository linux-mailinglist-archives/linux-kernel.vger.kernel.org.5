Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5B078CD4D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbjH2UE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240476AbjH2UET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:04:19 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B0D1BC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:04:13 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99cce6f7de2so631076566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693339452; x=1693944252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E7+fPH/MQHoNa3vChLqeUExHzKt7daOcGn55CTVmoBc=;
        b=iEdN0GNF1nWhyy3IF16S7OnEtMlSoMwG+HXNoqZCldV67/QGjVHuby2oBM4lstXdby
         V5zJ5ndCJOKJphewgeR5XslWA1aNivc0RntpwXM0VIiUrgWpLTCpMKU3D4oLS2jfIYGT
         NZDkzQV9xFIH7XbgJeRVCuMF8JVn/PuRf0PzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693339452; x=1693944252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7+fPH/MQHoNa3vChLqeUExHzKt7daOcGn55CTVmoBc=;
        b=NEHaZG16Z5m+cbaho1DKfeAiRGzHry3a0RlQDRcoE3LgGtaUQfi0ZquCSQiGNW5iYR
         yFCbozbApDJvbTnc0NX1YT9csX00pmjMC9hLzq703Owp6fOyAmlsCGb2BAkdDPhCX6WH
         TuwjXuEKrqASbsc7fpdQPhqAsxHSsAwGjCGtZesw+J7zU6t72VJt7Cjucrx2Hp6R/wIz
         1AWQHGNZNgDBUTm2t0f+Dx7UdoSJhlCkKH90gzOZre1fJ6BL+wfL78cANrGE7RLLdEAk
         eWTgwKq1uxco7qvJbH/d1QXA2JiDxODmSgtUymNCJdtT/21lPyGP2Mt4YQUrBdGJaPOJ
         eWPA==
X-Gm-Message-State: AOJu0YzLL5cLWELcl9NhaRcyylwkJEYx1MY9oKAGWX193u/xp9rB5A20
        q0gFPkMNq8wBgA29kiCn6pvqGehCwSSFhc9YPfxsOo27
X-Google-Smtp-Source: AGHT+IFRBF1fzIkPFlVvvFmbzqawUai2yiHgl0U9Jc3FqInfpk01BTXjkAhwy7X1BOtKKr0TOgCCpw==
X-Received: by 2002:a17:906:10d2:b0:9a1:ab86:5f22 with SMTP id v18-20020a17090610d200b009a1ab865f22mr31359ejv.56.1693339452065;
        Tue, 29 Aug 2023 13:04:12 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id y16-20020a1709064b1000b00992e94bcfabsm6263301eju.167.2023.08.29.13.04.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 13:04:11 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-52a250aa012so6316594a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:04:11 -0700 (PDT)
X-Received: by 2002:a17:906:51d4:b0:9a3:faf:7aa8 with SMTP id
 v20-20020a17090651d400b009a30faf7aa8mr55430ejk.10.1693339451148; Tue, 29 Aug
 2023 13:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230828170732.2526618-1-mjguzik@gmail.com> <CAHk-=wj=YwAsPUHN7Drem=Gj9xT6vvxgZx77ZecZVxOYYXpC0w@mail.gmail.com>
 <CAGudoHHnCKwObL7Y_4hiX7FmREiX6cGfte5EuyGitbXwe_RhkQ@mail.gmail.com>
In-Reply-To: <CAGudoHHnCKwObL7Y_4hiX7FmREiX6cGfte5EuyGitbXwe_RhkQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Aug 2023 13:03:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgemNj9GBepSEJXS5N99rr9wLkL668UC9TsKH45NnJ7Mg@mail.gmail.com>
Message-ID: <CAHk-=wgemNj9GBepSEJXS5N99rr9wLkL668UC9TsKH45NnJ7Mg@mail.gmail.com>
Subject: Re: [PATCH] x86: bring back rep movsq for user access on CPUs without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Aug 2023 at 12:45, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> So I think I know how to fix it, but I'm going to sleep on it.

I think you can just skip the %r8 games, and do that

        leal (%rax,%rcx,8),%rcx

in the exception fixup code, since %rax will have the low bits of the
byte count, and %rcx will have the remaining qword count.

We should also have some test-case for partial reads somewhere, but I
have to admit that when I did the cleanup patches I just wrote some
silly test myself (ie just doing a 'mmap()' and then reading/writing
into the end of that mmap at different offsets.

I didn't save that hacky thing, I'm afraid.

I also tried to figure out if there is any CPU we should care about
that doesn't like 'rep movsq', but I think you are right that there
really isn't. The "good enough" rep things were introduced in the PPro
if I recall correctly, and while you could disable them in the BIOS,
by the time Intel did 64-bit in Northwood (?) it was pretty much
standard.

So yeah, no reason to have the unrolled loop at all, and I think your
patch is fine conceptually, just needs fixing and testing for the
partial success case.

Oh, and you should also remove the clobbers of r8-r11 in the
copy_user_generic() inline asm in <asm/uaccess_64.h> when you've fixed
the exception handling. The only reason for those clobbers were for
that unrolled register use.

So only %rax ends up being a clobber for the rep_movs_alternative
case, as far as I can tell.

            Linus
