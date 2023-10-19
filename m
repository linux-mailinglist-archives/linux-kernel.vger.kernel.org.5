Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6077CFFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232952AbjJSQht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjJSQhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:37:47 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548B1126
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:37:44 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-53e16f076b3so2157624a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697733462; x=1698338262; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KVg72uPUJlCNP5ZghklHQ33G/OMrolR4hmAv20/o7n0=;
        b=NdAuZKrrXymKctFN1ivCrJa0AVUdvVikwwSoA24LZqajnOpokfMjpkfcSLfDKTLPMd
         4RMuv0r7da8unFutLJTc2aQ827eaqf/9FXsMLM9aoVgXWiLQynA3HPqv+ozy2Bl/sg7X
         7wLnNMVkFNBORgN284Tykgde7I+QZK/658pgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697733462; x=1698338262;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KVg72uPUJlCNP5ZghklHQ33G/OMrolR4hmAv20/o7n0=;
        b=rprbrGL1FIxq/9njaEXU1YHKwsYu85IkFpwgYEDsnmmmLatY5tWXCppRq7JbPQBtVx
         vM7ndSC9BTom4NKtlI9r5ogEC/CXldXynOgZGNd1dC9jgxIU7rcSbi+Buj6t5A09dhCB
         HyV9vpqYfnOiJ5tVmMCbZJGPpFy/VaBzmPKadxIW6YWlZppBz3prM+u2lVOxOUDOZia8
         fFOoOvy5/CVRW1WW4BO4NUe4r3CZToPPANje/jLT9pOoRKIROoXso9Pb+EY9abLOdq3E
         kBRMjr85XrIZTmvV65Ahedhpfhz/gAts9NrlGPwVNkc4evHonjE5u4YXIvNOXnVpk6kn
         pNWA==
X-Gm-Message-State: AOJu0Yy8lKacPrWrr4kabGAeB+GiAbpOP1AhhSAr/nQVIQJoG8qAjMDK
        RZBVYhC/KhF+dphxku0/AhdD9rKpm5RyqspL2cEbuZzw
X-Google-Smtp-Source: AGHT+IHRzmR+jaUBdMzsSDoseCMFLUcbjip7jZUy5pN8tUv79gKUlDySMMS3jbNmFaet8LMazxhNrg==
X-Received: by 2002:a17:907:d1b:b0:9a1:aaae:8207 with SMTP id gn27-20020a1709070d1b00b009a1aaae8207mr2520582ejc.20.1697733462579;
        Thu, 19 Oct 2023 09:37:42 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id m16-20020a1709066d1000b0099bc80d5575sm3722033ejr.200.2023.10.19.09.37.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 09:37:41 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9adb9fa7200so218913066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:37:41 -0700 (PDT)
X-Received: by 2002:a17:907:97d6:b0:9a9:405b:26d1 with SMTP id
 js22-20020a17090797d600b009a9405b26d1mr2298936ejc.5.1697733461464; Thu, 19
 Oct 2023 09:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20231019-kampfsport-metapher-e5211d7be247@brauner>
In-Reply-To: <20231019-kampfsport-metapher-e5211d7be247@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Oct 2023 09:37:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBXdLJ=QDpYmDEH-Tn71dXasGJSX4Jz4qMo8V4-7vYkg@mail.gmail.com>
Message-ID: <CAHk-=whBXdLJ=QDpYmDEH-Tn71dXasGJSX4Jz4qMo8V4-7vYkg@mail.gmail.com>
Subject: Re: [GIT PULL] vfs fixes
To:     Christian Brauner <brauner@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, 19 Oct 2023 at 03:09, Christian Brauner <brauner@kernel.org> wrote:
>
> An openat() call from io_uring triggering an audit call can apparently
> cause the refcount of struct filename to be incremented from multiple
> threads concurrently during async execution, triggering a refcount
> underflow and hitting a BUG_ON(). That bug has been lurking around since
> at least v5.16 apparently.

Ouch. That filename ref by audit was always supposed to be
thread-local in a "for this system call" kind of sense.

But yes, looks like the io_uring stuff ended up making it no longer
thread-local.

That said, using atomics for reference counting is our default
behavior and should be normal, so the patch isn't wrong, it's just
annoying since getname/putname is very much in the critical path of
filename handling.

That said, the extra atomics are hopefully not really noticeable.

Some people might want to use the non-refcounted version (ie we have
getname/putname used by ksmbd too, for example), if they really care.

It already exists, as __getname/__putname.

But the normal open/stat/etc system call paths are obviously now going
to hit those extra atomics. Not lovely, but I guess it's the best we
can do.

> Switch to an atomic counter to fix that. The underflow check is
> downgraded from a BUG_ON() to a WARN_ON_ONCE() but we could easily
> remove that check altogether tbh and not waste an additional atomic. So
> if you feel that extra check isn't needed you could just remove in case
> you're pulling.

Well, the atomic *read* is cheap - the expensive part is the
atomic_dec_and_test() (and the atomic_inc in the audit code.

I'm not sure why you made it check just for zero in the WARN_ON_ONCE,
rather than <= 0 as it used to, but that check is racy regardless, so
it doesn't matter. It would miss two concurrent decrements coming in
with a count of 1.

We don't have the ternary test of atomic decrement results (positive,
zero or negative), so it is what it is.

                 Linus
