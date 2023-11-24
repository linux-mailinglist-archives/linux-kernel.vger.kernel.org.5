Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CFA7F7F4A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 19:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbjKXSkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 13:40:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjKXSkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 13:40:05 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0EB2126
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:40:10 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-50797cf5b69so3015720e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700851209; x=1701456009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n6dMaBnN8wPxxEjM8N0CTPmBnvpOexlwMzfQXUjTE8U=;
        b=P4WwO+D7apZBePL1C5YgXrneQu5IVGUSqxZLcXpMu+huujzgzVvDCLmxVJHSPHamga
         G9zvX/p+6n4NB8ZtJwoesfdplhfIPT0roKRnDxxA1dahtXIoYtnq8qlEZ6yvvbam3dKg
         HsMchHogW7CobpjAI7pBLMxQjqjo3s618Nwo8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700851209; x=1701456009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n6dMaBnN8wPxxEjM8N0CTPmBnvpOexlwMzfQXUjTE8U=;
        b=l95FEcWD2bCVWAgQ26iznZM/4m3rmxuNq46Hm73WmcNL9P7iTdTmcukJ/1ksqGvfJn
         VTSRnVdjgyauZs0Uk7+0yGsqLFyErf0SOBNpRX9IVJ3hJSCbeVfYsyqCeTuwOFgCLExv
         LNwWLUljRhBYGCVSBfcCOKxU3VXubIHXQ5wLv2LzYtiplHv0G/myPWgXhbQ9Mw7a3t7l
         BQ4lelqKsaXarxBjc79Qa3wmQgcDGptHEHniBbuH7QE0LxQuXaudlqh6GvgjJogQ95dG
         0lWkDm1BnTr5dbeXnqkXDJjkaiGlLSqNiPGSdLgYRWkLMbOysUCHpUQ7JK75/Vop/DVb
         CzTw==
X-Gm-Message-State: AOJu0Yzc5v2UsTfNfnx41L7MB5KgjY2nPgMrBVkvPr6GegZ8/OC2abEk
        KYJnDI1v3T/zc1M0OmnvYzEpfMFEZSjrQcVT9LYIjw==
X-Google-Smtp-Source: AGHT+IERVVLYBQa9glqzwSiiIyKHehruqqrzIYJdFcxgPh68UcbUI/jyh0JbvZ4zGvvcTewvOkqHow==
X-Received: by 2002:a19:5514:0:b0:50a:aa87:652c with SMTP id n20-20020a195514000000b0050aaa87652cmr2661597lfe.65.1700851208764;
        Fri, 24 Nov 2023 10:40:08 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id w7-20020ac254a7000000b0050ab61a09f3sm571704lfk.104.2023.11.24.10.40.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 10:40:08 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2c50cf61f6dso27393301fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 10:40:08 -0800 (PST)
X-Received: by 2002:a05:651c:1208:b0:2bc:c771:5498 with SMTP id
 i8-20020a05651c120800b002bcc7715498mr3557404lja.18.1700851207707; Fri, 24 Nov
 2023 10:40:07 -0800 (PST)
MIME-Version: 1.0
References: <1205248.1700841140@warthog.procyon.org.uk>
In-Reply-To: <1205248.1700841140@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Nov 2023 10:39:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjz+y82U8ycSBfey_ov1GxdiUkkVpjJA1f0=JogWqUp2w@mail.gmail.com>
Message-ID: <CAHk-=wjz+y82U8ycSBfey_ov1GxdiUkkVpjJA1f0=JogWqUp2w@mail.gmail.com>
Subject: Re: [GIT PULL] afs: Miscellaneous fixes
To:     David Howells <dhowells@redhat.com>
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Fri, 24 Nov 2023 at 07:52, David Howells <dhowells@redhat.com> wrote:
> Btw, I did want to ask about (5): Does a superblock being marked SB_RDONLY
> imply immutability to the application?

Obviously not - any network filesystem can and will change from under
you, even if the local copy is read-only.

So SB_RDONLY can only mean that writes to that instance of the
filesystem will fail.

It's a bit stronger than MNT_READONLY, in that for a *local*
filesystem, SB_RDONLY tends to mean that it's truly immutable (while
MNT_READONLY is obviously per mount) but even then some sub-mount
thing (and I guess the AFS snapshot is a good example of that) might
expose the same filesystem through multiple superblocks.

Exactly like a network filesystem inevitably will.

In any case, any user space that thinks SB_RDONLY is some kind of
immutability signal is clearly buggy. At a minimum, such user space
would have to limit itself to particular filesystem types and say "I
know _this_ filesystem can have only one superblock"). And I'd argue
that while that might work in practice, it's insane.

                Linus
