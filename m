Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FC778CEC4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 23:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbjH2VcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 17:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbjH2VcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 17:32:04 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CAF1BC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:31:59 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b974031aeaso75760271fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693344717; x=1693949517; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rU7dErnvLiuzDuD68u3YsP6+F+SRgavTnqk7toHPtos=;
        b=J2xbvyNbpEJgqLZOHY4b1+Xi6vX2DkqszRWUeJK/gVNCLowIp9rcAyLhy4xcx98R3E
         CNVrLX1ZgPNDEei4bA9+6Mur8riycwXXxXYVGgtUzYBNjqULQEUzea7H6t31f/TYtGtD
         O2h82IrtG4gZAaIsRHXqxuHV0sm5wBduT1vn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693344717; x=1693949517;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rU7dErnvLiuzDuD68u3YsP6+F+SRgavTnqk7toHPtos=;
        b=EcrF7cfYmeGJLTHw9uxIkaoaTT5haaWqMARyMf6luaPUpXjp5a2pkHFjEs8AmB0iOL
         couLOrx0YqVipmLFLi5j8SfSTLKcelsbfZh/msV3oyG+QsTABJT+oityCJFPFnxv6nPN
         iNmH3mUYGu7PevHTUkmojwRj/5e7uFU+mgrWzMixUlgEzk7RPD+0EcVKcDi6JBKMAAj3
         hG/lIUwGvuabSjZCnHL8EBuIdOd/eDXt9VwrC8CJ6luE6jMAYgikQyVy2K6iZL0GMPNm
         pHB6qwsZjreESbTceTcqZCaa1gQAl4SVntkUfTQWNSnzzbUQHv/aFenTaZIOE4s+2SgZ
         yuPg==
X-Gm-Message-State: AOJu0Ywmt5uZLVvXiteZo2S5uKEHBcSPIRRAB4gpFmGoKIb3WMEnOORR
        5Z9iouhrvj4cBR+3EaD1ayFoHA7/j/ctvNZW7xbhKOCi
X-Google-Smtp-Source: AGHT+IGP4GVQrXHcJO/m2N5nKiqBxsXLiODDwYN54xs8LuuHbmsTABBLu51KcNHmAsuur6ps65Kt0A==
X-Received: by 2002:a2e:9a8a:0:b0:2ba:6519:c50f with SMTP id p10-20020a2e9a8a000000b002ba6519c50fmr329270lji.52.1693344716254;
        Tue, 29 Aug 2023 14:31:56 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id q5-20020a1709064c8500b00993928e4d1bsm6328413eju.24.2023.08.29.14.31.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 14:31:55 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-529fb04a234so6456886a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 14:31:55 -0700 (PDT)
X-Received: by 2002:a17:906:9bfa:b0:9a1:d2ef:3e3b with SMTP id
 de58-20020a1709069bfa00b009a1d2ef3e3bmr158630ejc.38.1693344715187; Tue, 29
 Aug 2023 14:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230828184251.bfbc164280503903eacf498c@linux-foundation.org>
In-Reply-To: <20230828184251.bfbc164280503903eacf498c@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Aug 2023 14:31:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjtBk23T4bsA4wxyogvDAP0mWmPPvy=qaMWsySM=WOC9A@mail.gmail.com>
Message-ID: <CAHk-=wjtBk23T4bsA4wxyogvDAP0mWmPPvy=qaMWsySM=WOC9A@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.6-rc1
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-mm@kvack.org, mm-commits@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, 28 Aug 2023 at 18:43, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> csky tree, arch/csky/abiv2/cacheflush.c:
> https://lkml.kernel.org/r/20230815104604.54f65293@canb.auug.org.au

At least this resolution in linux-next was wrong. It would just keep
on doing a cache invalidate on the same one-page address range over
and over again.

I think I did it right, but obviously can't test (and am too lazy to
build-test too).

Of course, it won't actually matter unless you have large folio on
csky, which is probably hard to impossible to trigger in practice, but
I thought I'd mention it if for no other reason than Guo Ren to be
aware and at least test-build and maybe think about it.

             Linus
