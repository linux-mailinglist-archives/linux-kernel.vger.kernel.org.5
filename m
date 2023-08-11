Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB5577848F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjHKAiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHKAiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:38:05 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549C7EA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:38:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c0290f0a8so198350766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691714283; x=1692319083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NkgHjHcvv02JLA5d7L4Oy9GtZPKfjzxj4synHJJ/uXE=;
        b=LVF7VL7dUU6IICGIe4anpmy+iHZe7Ke/jnYUt0WxIZ2/r2YuazpaNf19NlyYTFj0RQ
         tOiFCkJ9yEgct3fhTjM8FzPZ/zzA7cMLujYh04ooYuHbjftW6YEOct9yvvjeZ9WzaftX
         CanMhPU3vX0dcvFT2Fu/LUksOpvOI1nuTFQR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691714283; x=1692319083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkgHjHcvv02JLA5d7L4Oy9GtZPKfjzxj4synHJJ/uXE=;
        b=Msyf42cK+tHww+9+wpJw62/BghF9w7yyhWgKYF1w5gJLOeUjjE1y3yUsXII8pzpxng
         OnCpmlCSwwt9D0HfgS2Ku5YdEzJ378K0wrV9c4WVZ3K8c8pUZ16o7cHjpqOKR91Bw7tl
         ZAP9m1v16vyM0dbh5lD+X4bNqsxXrbsFWCrFrS0Mu//gWxqHRnTjAWkIU89MXLuPYdtm
         CYk1eam/7rIpXcI951OQ82Tmx7bGN7hhhNtCGtXJhoHrf8s5dmy5lAHh85+2emAbeAI+
         HcJxUl7TVdHJlad3msda5ZB+r1fL8RTACgE7huPl4qi87cvpLurw7dXu4VuVtaUMy6oy
         5zTA==
X-Gm-Message-State: AOJu0YwcgyEqi9GQa/95vXcFEQgGA0d6a91Si6YBu8IbyWNrV2wD7W4P
        Axg9OMsIN8bYyS2Ck9RPtwo9wHUfsd5bKA27YHL2Po8L
X-Google-Smtp-Source: AGHT+IGnkLhPTFKjgeGfRiohEvgiqsjkYhBuiCZS2EwCp4n7C5M1Aj00wlJQxlAe0JJvCcTMJx3FAg==
X-Received: by 2002:a17:907:2e19:b0:993:e9b8:90f5 with SMTP id ig25-20020a1709072e1900b00993e9b890f5mr369235ejc.8.1691714283563;
        Thu, 10 Aug 2023 17:38:03 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id gu11-20020a170906f28b00b0099bd86f9248sm1563213ejb.63.2023.08.10.17.38.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 17:38:03 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-52364e9daceso1789139a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:38:02 -0700 (PDT)
X-Received: by 2002:aa7:c446:0:b0:523:4c93:1c0f with SMTP id
 n6-20020aa7c446000000b005234c931c0fmr384315edr.21.1691714282708; Thu, 10 Aug
 2023 17:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230809-gds-v1-1-eaac90b0cbcc@google.com> <169165870802.27769.15353947574704602257.tip-bot2@tip-bot2>
 <20230810162524.7c426664@kernel.org> <20230810172858.12291fe6@kernel.org>
In-Reply-To: <20230810172858.12291fe6@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Aug 2023 17:37:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_b+FGTnevQSBAtCWuhCk=0oQ_THvthBW2hzqpOTLFmg@mail.gmail.com>
Message-ID: <CAHk-=wj_b+FGTnevQSBAtCWuhCk=0oQ_THvthBW2hzqpOTLFmg@mail.gmail.com>
Subject: Re: [tip: x86/bugs] x86/srso: Fix build breakage with the LLVM linker
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Daniel Kolesa <daniel@octaforge.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Sven Volkinsfeld <thyrc@gmx.net>,
        Nick Desaulniers <ndesaulniers@google.com>, x86@kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 at 17:29, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Are the commit IDs stable on x86/bugs?

I think normally yes.

> Would it be rude if we pulled that in?

If this is holding stuff up, you have a pretty good excuse. It
shouldn't be the normal workflow, but hey, it's not a normal problem.

As I mentioned elsewhere, I hate the embargoed stuff, and every single
time it happens I expect fallout from the fact that we couldn't use
the usual bots for build and boot testing.

All our processes are geared towards open development, and I think
that's exactly how they *should* be.

But then that means that they fail horribly for the embargoes.

Anyway, go ahead and just pull in the fixes if this holds up your
normal workflow.

And if we end up with duplicates due to rebases (or worse yet, merge
issues due to rebases with other changes), it is what it is. Can't
blame you.

              Linus
