Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB727DC530
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 05:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236000AbjJaENS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 00:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJaENQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 00:13:16 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD45C0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:13:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5401bab7525so8817493a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698725592; x=1699330392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z4CjmHn9gZUNiN39at5TLLAbx3Hn7FVZiQ4wicVe4X4=;
        b=EQFC40xhPyMkdJZYMgsZQfFxZEEfz0LMcT3VP3kBIdqX2bm148i/6EkwYf4LSTJDXb
         8IrXaOVV6gfOlyEiK0OFVPFmH+WnZONCCRJxFEL1VKLH6FiU4ecVMlUJd+unDwS3/P6v
         /i9ueVDLmPMapZYhp5uAMkOEkp4rP4YWzDJVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698725592; x=1699330392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z4CjmHn9gZUNiN39at5TLLAbx3Hn7FVZiQ4wicVe4X4=;
        b=CdHEkJ0+TdOtt904joKCbLfbummTBEpocB4KtH4V7jwf3EoPamO/jsJ9URPOtCN8j3
         yUhsKZ3ANvjkufYzDvCO+jsiVqlM8myuRoIHSmyrdqe+xAzBD9DbK9Hkzn95QBNGr3jt
         bL9CjoQ/lv64/VjFMtM+MidhX1SEb2o0hpmo+HlkPBHaqOAgWsW2QpVCJ+BR3WEbWqpz
         D33JLXUv8b05lvXUaE7UdDpeSay7Fms+FZLalzZFK9dSCQnyMPfAHmD/Qib1SEqy4ik0
         X5n7rJU+m8kDcqx6RfTNqPZAeClP8P6LviZZDrETxKLjzw54quJNNcN1ceOvtKTgZZPx
         DW1g==
X-Gm-Message-State: AOJu0Yw354/5d3IYF6hlcCXGk5zb2zxMm+Zp7YDLjAlcJvDXIV2PTXFW
        OqMqL6fNulm2q8yOfY3NeW5zXm8jrK47dyajZQ8JlI84
X-Google-Smtp-Source: AGHT+IHIaePgQXR4xoiIFukbNFzlDQocUQKt+CAcl8bCznd2qaH7o+X4XVuf20F8OFxEVm5R03B8kw==
X-Received: by 2002:a17:906:3f4f:b0:9d1:92bb:ce58 with SMTP id f15-20020a1709063f4f00b009d192bbce58mr7015017ejj.24.1698725592055;
        Mon, 30 Oct 2023 21:13:12 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id bg20-20020a170906a05400b0099cc3c7ace2sm263627ejb.140.2023.10.30.21.13.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 21:13:10 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-9be3b66f254so770369166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 21:13:10 -0700 (PDT)
X-Received: by 2002:a17:907:97c5:b0:9c7:5a01:ffe5 with SMTP id
 js5-20020a17090797c500b009c75a01ffe5mr8290892ejc.5.1698725589631; Mon, 30 Oct
 2023 21:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <ZTuf+xNrfqGjHFDK@lothringen>
In-Reply-To: <ZTuf+xNrfqGjHFDK@lothringen>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Oct 2023 18:12:51 -1000
X-Gmail-Original-Message-ID: <CAHk-=wjEtLocCnMzPx8ofQ=H538uKXSfn+3iZ5zaU7-+3YdjXA@mail.gmail.com>
Message-ID: <CAHk-=wjEtLocCnMzPx8ofQ=H538uKXSfn+3iZ5zaU7-+3YdjXA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.7
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Z qiang <qiang.zhang1211@gmail.com>
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

On Fri, 27 Oct 2023 at 01:33, Frederic Weisbecker <frederic@kernel.org> wrote:
>
> rcu/stall: Stall detection updates. Introduce RCU CPU Stall notifiers
>         that allows a subsystem to provide informations to help debugging.
>         Also cure some false positive stalls.

I absolutely detest this stall notifier thing.

Putting the stall notifier before the stall message does not "help
debugging". Quite the reverse. It ends up being a lovely way to make
sure that the debug message is never printed, because there's some
entirely untested - and thus buggy - notifier on the chain before the
printout from the actual stall code.

I've pulled this, but I really want to voice my objection against
these kinds of "debugging aids". I have personally spent way too many
hours debugging a dead machine because some "debug aid" ended up being
untested garbage.

If you absolutely think that this is a worthy and useful thing to do,
then at the very least make sure that these "debug aids" will always
come *after* the core output, and can't make things horrendously
worse.

But in general, think twice before adding "maybe somebody else wants
to print debug info". Because unless you have a really really REALLY
good reason for it, it's more likely to hurt than to help.

Right now I see no users of this except for the rcu torture code, and
it certainly doesn't seem hugely important there. And so I'm wondering
what the actual real use-case would be.

                  Linus
