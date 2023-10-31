Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6DD7DD919
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376473AbjJaXHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376458AbjJaXHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:07:06 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28220C9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:07:04 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53e2dc8fa02so10777395a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698793622; x=1699398422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0wUvOEnKmTi8WEvQZdsskLf9E1FQBX1NqUbV0gaScgU=;
        b=J4BbpNb5yErcBTuBOh1OSxduKVp4iaAk0LcxgKYX7p61S/ZmS6Cn3WXnZaaZa1kTKc
         d8v3uPCIlKAD5aG09mA/B9mGs8ZyJ5W1mR3BpdcpXwcnXsHumQ9qzIKzFEHa7zu6vZ80
         PDeuNpzdJ5kKJI0Z52TuIVxOpW+hDb9Q0mKZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698793622; x=1699398422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wUvOEnKmTi8WEvQZdsskLf9E1FQBX1NqUbV0gaScgU=;
        b=JmZc7rcxiEODNqwkr7ufjvIMRPEoMTKSAnL3tIQPNpRHbOLlrqvzi7Bg5bgaFgfFDU
         GgBEzuGzWXFVXXc+8oH+uoZcKLGTu9YkGId5Avi63EEBIW33Ot5k6Nj+jemOSmgCWHfF
         4slZvLOth9wD7HJwkeVOBYFzk3nWVWS0OpLq0joXtL7nauh1uQzT0WNf5XERbVlA5wF9
         UHYdv9eybu2sdkPCnUsk35DDjUuM6IbIqFJCSqfIUx8al+eyc3KQt2s2S3b0GQEdZp6P
         EijjIVZ6cTpe5MVjw1SD5mN2JWNt4kQv5pALCgrq3ngIq1s3yFpB6aLXEajxcu5RRKQu
         7vQg==
X-Gm-Message-State: AOJu0YwDVihWE4aytqUGgkRqdtc61Ps5kEuARIm5+57U+WPZKPwgstU4
        OuQBwRzJ7qB0KcXKpoDtTZ6rEmzu7BJlsGrGMaVwJnND
X-Google-Smtp-Source: AGHT+IGeviqjJHoT4ZP5Vjupe6CgMeH4UplIhElbvnxqJvU5B64ngF1ETsfZiqQe7a/u8HvD49Od6Q==
X-Received: by 2002:aa7:d54b:0:b0:53d:d9d1:7029 with SMTP id u11-20020aa7d54b000000b0053dd9d17029mr10355627edr.15.1698793622290;
        Tue, 31 Oct 2023 16:07:02 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id c94-20020a509fe7000000b00543b2d6f88asm98514edf.15.2023.10.31.16.07.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Oct 2023 16:07:01 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9d10972e63eso596692066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:07:01 -0700 (PDT)
X-Received: by 2002:a17:906:ef0e:b0:9c7:4d3e:1e50 with SMTP id
 f14-20020a170906ef0e00b009c74d3e1e50mr631104ejs.76.1698793621035; Tue, 31 Oct
 2023 16:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <ZTuf+xNrfqGjHFDK@lothringen> <CAHk-=wjEtLocCnMzPx8ofQ=H538uKXSfn+3iZ5zaU7-+3YdjXA@mail.gmail.com>
 <ZUDUlQq6hEEPBiCR@lothringen> <78b18304-c6a5-4ea1-a603-8c8f1d79cc1a@paulmck-laptop>
In-Reply-To: <78b18304-c6a5-4ea1-a603-8c8f1d79cc1a@paulmck-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 Oct 2023 13:06:44 -1000
X-Gmail-Original-Message-ID: <CAHk-=whNWmVnH_b++g5kjT9jKFNwPcx81hxez=pkrozpXoqVvA@mail.gmail.com>
Message-ID: <CAHk-=whNWmVnH_b++g5kjT9jKFNwPcx81hxez=pkrozpXoqVvA@mail.gmail.com>
Subject: Re: [GIT PULL] RCU changes for v6.7
To:     paulmck@kernel.org
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, rcu@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        Z qiang <qiang.zhang1211@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2023 at 03:57, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Would it help if we make rcu_stall_chain_notifier_register() print a
> suitably obnoxious message saying that future RCU CPU stall warnings
> might be unreliable?

It's not the future stall warnings I worry about.

It's literally things like somebody thinking they are being clever,
registering a rcu stall notifier that prints out extra information in
order to be helpful, and in the process takes a spinlock or something
without thinking about it.

And that spinlock might be the *reason* for the RCU stall in the first place.

So now the RCU stall code prints out NOTHING AT ALL, because now the
stall notifier itself has deadlocked.

This is *exactly* what has happened before with these kinds of
"helpful" exception case notifiers. Because they never trigger in
normal loads, they get basically zero testing - and then when bad
things happen, it turns out that the "helpful" debug code actually
just makes things worse.

Or, if they get testing, they get tested in artificial bad cases (eg
"let's just write a busy loop that hangs for 30 seconds to trigger a
RCU stall"), which doesn't show any of the issues, because they aren't
real bugs with real existing deadlocks.

See what I'm saying? Having notifiers for "sh*t happened" is
fundmanetally questionable to begin with, because they get no testing.

And then calling said notifiers *before* you even have the core
printout for "Look, things are going down hill quickly", now you've
turned a bad situation even worse.

I really think that we should *never* have any kind of notifiers for
kernel bugs. They cause problems. The *one* exception is an actual
honest-to-goodness kernel debugger, and then it should literally
*only* be the debugger that can register a notifier, so that you are
*never* in the situation that a kernel without a debugger will just
hang because of some bogus debug notifier.

              Linus
