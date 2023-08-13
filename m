Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054F877AA1B
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjHMQlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjHMQlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:41:52 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AF493
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 09:41:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso5663421e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 09:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1691944912; x=1692549712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+iDEH45PIbLPRLMGHHsGA82f2vEUhaOKwZb/xF3clyU=;
        b=g68bNM/5q2gs3Up6oouMqZc8NydRrEzzlRLGRP2iB5kI53SInfeN1qUmUHECsUQYT1
         s/tvB99rJSjxQUw+61peXRTHzMvsnAgcit/05/GDjMSgDxP9tf7X/feyRcnzoEAtjtGO
         +XecthA25ht49PATsoNLIOBCuRbKQ3XS7iRHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691944912; x=1692549712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iDEH45PIbLPRLMGHHsGA82f2vEUhaOKwZb/xF3clyU=;
        b=i8nxM8l+eVWFEsPneMhBX39FAwmfSSB1/Daox1lkiWoerhGuClL+iqnXUbXOd5r1Qj
         ueuCLoFwW4mrm9cn6gT0EE3D7RIX4lGZGmBseMiX9nF8siZkXDtp+ifr7307JjyWH+vb
         r+nCgb4PsZ25+f9mgjrzPsPDWC1Zb8JDlQhSu+pExHhdDliDlRQR1oUou1uJGwF1w4JM
         2jNzEIdNStOzA+VGwAMn3aLoROONSHc2xI2Y7rPzeysnzRTkQzqWMjhQBc9jE4OwmIBN
         Kqm3xRn7XnhmjKl69bNMGAuEeOocV9A/aqxOgM/+FTQnALZkfK0R3c6ofRfaKJWtYjvF
         5kGg==
X-Gm-Message-State: AOJu0YwVRYPNNJCqKH/rFyntM5T5/njfWf6n90vXRsNc3BQuMTIjdvX1
        yOVDq6/1wBqOqdL9dPYhUW73MTHlp1DejvLV5ia2lHW9
X-Google-Smtp-Source: AGHT+IEI+k9x6YvlAROhpQ7mSTTpZbE3beCn6mcwKNkNNyjta9XYUIlVBzwhLRiA55geUnMIiy+DqQ==
X-Received: by 2002:a05:6512:238f:b0:4fb:8ee0:b8a5 with SMTP id c15-20020a056512238f00b004fb8ee0b8a5mr5532903lfv.46.1691944911728;
        Sun, 13 Aug 2023 09:41:51 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id v13-20020ac2558d000000b004fdfefdf4acsm1568528lfg.39.2023.08.13.09.41.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 09:41:51 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so5637308e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Aug 2023 09:41:50 -0700 (PDT)
X-Received: by 2002:a05:6512:708:b0:4fa:f79f:85a with SMTP id
 b8-20020a056512070800b004faf79f085amr4345430lfs.69.1691944910386; Sun, 13 Aug
 2023 09:41:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230810123905.1531061-1-zhengyejian1@huawei.com>
 <20230811152525.2511f8f0@gandalf.local.home> <b5dbdbeb-be3a-3434-0909-0697d8cb15bf@huawei.com>
 <20230812211317.6d015e1d@rorschach.local.home>
In-Reply-To: <20230812211317.6d015e1d@rorschach.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 13 Aug 2023 09:41:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBRFisXK0ATFsKCSsCjMNne4aJqRszAY=ex0viUkkrqQ@mail.gmail.com>
Message-ID: <CAHk-=wgBRFisXK0ATFsKCSsCjMNne4aJqRszAY=ex0viUkkrqQ@mail.gmail.com>
Subject: Re: [PATCH] tracing: Fix race when concurrently splice_read trace_pipe
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Zheng Yejian <zhengyejian1@huawei.com>, mhiramat@kernel.org,
        laijs@cn.fujitsu.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
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

On Sat, 12 Aug 2023 at 18:13, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> So the test case cannot be run because the "sendfile" on the
> trace_pipe now fails?

So sendfile() has always required a seekable source, because it -
intentionally - doesn't do the "splice to pipe and then splice from
pipe to destination".

It just does a "splice from source, splice result to destination".

That sounds like "obviously the right thing to do", but it means that
there is now no buffer with any extended lifetime between the two
operations. And that's a big deal.

 Without that buffer (ie pipe) in the middle, if the splice to
destination fails - or is partial - and the system call is interrupted
by a signal, then the source splice data is now gone, gone, gone.

So it only works if the source can then re-create the data - ie if the
source is seekable.

In that case, if the destination cannot accept all the data, the
sendfile can just go back and read again from the last successfully
written position.

And if you are a data stream that can't seek, then that "from last
successfully written position" doesn't work, and any partial writes
will just have dropped the data.

This seekability test *used* to be to test that the source was either
a regular file or a block device.

Now it literally checks "can I seek".

It looks like the trace_pipe fiel is *claiming* to be a regular file -
so sendfile() used to be ok with it - but cannot actually seek - so
sendfile would silently drop data.

Now sendfile says "I'm sorry, Dave, I'm afraid I can't do that" rather
than silently causing data loss.

Now, this is not a user-visible regression in this case, because "cat"
will always fall back on just regular read/write when sendfile fails.

So all that changed for 'trace_pipe' is that a buggy splice now no
longer triggers the bug that it used to (which the patch in question
was also trying to fix).

End result: things in many ways work better this way.

So it really looks like it never really worked before either. There
was *both* the dropped data bug because "trace_pipe" lied about being
a regular file, *and* apparently this trace_pipe race bug that Zheng
Yejian tried to fix.

Of course, some destinations always accept a full write, so maybe we
could relax the "source must be seekable" to be "source must be
seekable, _OR_ destination must be something that never returns
partial writes".

So sendfile to a POSIX-compliant regular file could always work
(ignoring filesystem full situations, and at that point I think we can
say "yeah, we're done, no recovering from that in sendfile()").

So if somebody really *really* want sendfile to work for this case, then you

 (a) do need to fix the race in tracing_splice_read_pipe (which you
should do anyway, since you can obviously always use splice() itself,
not sendfile()).

AND

 (b) figure out when 'splice_write()' will always succeed fully and
convince people that we can do that "extended version" of sendfile().

Hmm?

               Linus
