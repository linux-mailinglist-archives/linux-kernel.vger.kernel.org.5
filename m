Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618237B7379
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241261AbjJCVoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjJCVoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:44:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AB8A1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:44:05 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso261557166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 14:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1696369443; x=1696974243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2r9XDedZRlJTxEOPklXIhMdVqYBus7aG5IbrsC5Wym4=;
        b=KQTAC2dwCeln5FCr846fwYl9wicbVqUVvW1coDCRBnupCO4BoWCi/LjDFKtKxvIYu4
         Iu8FvUPPxG0byXCQia0WbeCsEo07nt8Py+a+4ZUGPXhaFc+vrff5pusn8Q5gLMaTup8K
         ShexSv2ySKeEFWJLJjPnUfTWgav3L9mImXccg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696369443; x=1696974243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2r9XDedZRlJTxEOPklXIhMdVqYBus7aG5IbrsC5Wym4=;
        b=ajlvZF3N0G7NPC1L3UYETQbcTq+SdBsMK/h8+8KuN1trMeBTUx9CsP6TAON6Z7toBD
         yZ+ELavK1uaQFwX3gn67TViXZz0OUp8RB9TDICLiNMJgs/yOJSA/4/6uSXHVP2uz47zp
         SHm7WScOIIr2rAj4V/9/fcCPnniCFCddry0AV2OpVUh+YxMKNOROqCWFY0khZRPwTf9i
         9l54DlPoCFs7B1elF4aeawgizFTkdT1FV4U0ztKc1OqhxVcKaa1vqrVn5ipyEU3L5c6i
         euIiwUXJt4nFWGexnEyp/CO6SuXtGKuZiKeKFcdE0PWCC5NQo5NctFej41FJ7rardDgt
         kF9g==
X-Gm-Message-State: AOJu0YwznY6b8HiKLM53X7w+W78+DwmC52sDYJn5RrmzRE1WAAWDsi/J
        /7niRHLJIzT6ciV0S4gUqHzgv+sTn+fZXXEyGiVheMNA
X-Google-Smtp-Source: AGHT+IGfbPSXh3VBl70w3ODL9RsDZ6bKu44KeWpl8lQJHhZtZ09ZtCXBq5Aa9rUwKvwQcy6+yDAmQw==
X-Received: by 2002:a17:906:30cf:b0:9ae:695a:fed0 with SMTP id b15-20020a17090630cf00b009ae695afed0mr344866ejb.11.1696369443289;
        Tue, 03 Oct 2023 14:44:03 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id w26-20020a1709064a1a00b009ae54eba5casm1651567eju.102.2023.10.03.14.44.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 14:44:02 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5363227cc80so2388129a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 14:44:02 -0700 (PDT)
X-Received: by 2002:aa7:dc0f:0:b0:52c:b469:bafd with SMTP id
 b15-20020aa7dc0f000000b0052cb469bafdmr334046edu.41.1696369441779; Tue, 03 Oct
 2023 14:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20231001131620.112484-1-ubizjak@gmail.com> <CAHk-=wg6P8pPg-x4BPUQj-wE0xC7HkGzFk89ftuji8MVo+RRxw@mail.gmail.com>
 <CAFULd4Y+HXuditB51Q0LznqiBsvxJr3BjEYvx4_224XmqrycCw@mail.gmail.com>
 <CAHk-=wh+cfn58XxMLnG6dH+Eb9-2dYfABXJF2FtSZ+vfqVvWzA@mail.gmail.com>
 <CAFULd4atO8uy_5PbjV8vw-yk0tv_=4kh_JwJ+6Xq-2myStCnmw@mail.gmail.com>
 <CAFULd4YsPnCfw-NV_0ck1_za=WPc-FxYKV1bb99UcAwMJ=34YA@mail.gmail.com>
 <ZRrECdIoKCXALl39@gmail.com> <CAFULd4bBzAWoY7MDQN+YV5tpw7vDitFNMuSVt53KGofdZRvTpg@mail.gmail.com>
 <ZRwZOtANkcwtL+5B@gmail.com> <CAHk-=wi2d159z-KgZTAk52GZHB8=B-HZ-fQ_890fN7CL6Yt89g@mail.gmail.com>
 <ZRxu9+ZJqjY/u8ku@gmail.com>
In-Reply-To: <ZRxu9+ZJqjY/u8ku@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Oct 2023 14:43:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg5kiiJ+LUChmw73mmi-=uyQrAO-fBTG6yr2ON_UnAoPg@mail.gmail.com>
Message-ID: <CAHk-=wg5kiiJ+LUChmw73mmi-=uyQrAO-fBTG6yr2ON_UnAoPg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] x86/percpu: Use segment qualifiers
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>, Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
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

On Tue, 3 Oct 2023 at 12:43, Ingo Molnar <mingo@kernel.org> wrote:
>
> So we could do this: we let it live in -tip for a cycle, in a separate
> branch, and observe what happens - it gets picked up by -next on
> a daily basis and most x86 developers test it. It won't be merged by other
> branches in -tip, it won't be pulled by others or relied on. If it
> conflicts with other bits we rebase it cleanly, no questions asked.

Sounds like a plan,

              Linus
