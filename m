Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67835790EFE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 00:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347443AbjICWe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 18:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240826AbjICWey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 18:34:54 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DADDA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 15:34:50 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5007c8308c3so1343076e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 15:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693780489; x=1694385289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dIOhRbp78FSnOot0tcIQifKv7xD8tI587HuZagI+zEw=;
        b=LhvuAtqIpB3LdbApLuASiRn+SSHgieWvuNe8wYLIbioMm5YlBC+u+jhk+F0fQwQk7i
         V2sYxlAVl4m+BiDO0yG/Mk/YYo93hHRq4qaFXOCTcfoUuPJYigj26pe1ux5Mz5XZYGKg
         SI3nq2N7gOHpUppmlPbqywWUgYrZxpiFlAE+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693780489; x=1694385289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIOhRbp78FSnOot0tcIQifKv7xD8tI587HuZagI+zEw=;
        b=d2P/uKr002YeIVEB4EuMmOyIqDyVaLtKcxpTeFGjZg2UW0nN0TktMky0Y27uI0ny9I
         5DZdDgE71gLtU5abL7y5S4UB29K7Zz+Zw3qMCRLJLwywnxCbUk9dwmdYV0sKmvEN9ljf
         sN+fXsPlSBlr2pMrOTYb5uLmFcXtD9/OdIARugh0HUxDDzYcBa6MwbXPZ/8enbFOU1nd
         vI5UuL3ayWdRgnflaLJBVVgcmQbCoKm2pi48YhZ19t0jXEGkNbQgSfDtcu/F5BLCD49z
         f/+twO+pCdGkcdyUc3KBMKHc5IgKff3PCh1JIY2Sdz0ZlB5ASlobaZ64bA3wGC/XHjqG
         dYqg==
X-Gm-Message-State: AOJu0YxU8bFOoMIdW+I6lexuoSIAuXD7W69kmPEeOabpsqMZ9ZBAHVcu
        xLVosv2/CMKCi0yO540IACsXkOarXw+92Hrj4Gydrm49
X-Google-Smtp-Source: AGHT+IHPPu585SgI0DbAiXN2uU9tRUNfQmfwDDGIyLfH/qmXqEiq5fCvZ7Hj6PxzwsRSfLDaVZwFfg==
X-Received: by 2002:ac2:4f0a:0:b0:500:ca0f:605e with SMTP id k10-20020ac24f0a000000b00500ca0f605emr5999136lfr.6.1693780488775;
        Sun, 03 Sep 2023 15:34:48 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id p15-20020a05651211ef00b004fdd6b72bfdsm1406039lfs.117.2023.09.03.15.34.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 15:34:48 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2bbbda48904so13627031fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 15:34:47 -0700 (PDT)
X-Received: by 2002:a05:6512:a88:b0:500:b53f:fbc2 with SMTP id
 m8-20020a0565120a8800b00500b53ffbc2mr6365297lfu.26.1693780487492; Sun, 03 Sep
 2023 15:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230830140315.2666490-1-mjguzik@gmail.com> <CAHk-=wgADyL9i8r1=YkRTehKG8T89TzqAFMXDJV1Ag+_4_25Cw@mail.gmail.com>
 <CAGudoHH95OKVgf0jW5pz_Nt2ab0HTnt3H9hbmU=aSHozOS5B0Q@mail.gmail.com>
 <CAHk-=wh+=W2k1V_0Om=_=QpPAN_VgHzdZ4FLXSfcyTSK7xo0Eg@mail.gmail.com>
 <CAHk-=wg6bzTdQHSsswHPYFUbb1DfszyWTZ97hZv7bYxaNHVkHw@mail.gmail.com>
 <20230903204858.lv7i3kqvw6eamhgz@f> <CAHk-=wjYOZf2wPj_=arATJ==DQQAQwh0ki=Za0RcE542rWBGFw@mail.gmail.com>
 <ZPT/LzkPR/jaiaDb@gmail.com>
In-Reply-To: <ZPT/LzkPR/jaiaDb@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 3 Sep 2023 15:34:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
Message-ID: <CAHk-=wh1hi-HnBQRu9_ALQL-fbhyn_go+2c9FajO26khf2dsTw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: bring back rep movsq for user access on CPUs
 without ERMS
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, bp@alien8.de
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

On Sun, 3 Sept 2023 at 14:48, Ingo Molnar <mingo@kernel.org> wrote:
>
> If measurements support it then this looks like a nice optimization.

Well, it seems to work, but when I profile it to see if the end result
looks reasonable, the profile data is swamped by the return
mispredicts from CPU errata workarounds, and to a smaller degree by
the clac/stac overhead of SMAP.

So it does seem to work - at least it boots here and everything looks
normal - and it does seem to generate good code, but the profiles look
kind of sad.

I also note that we do a lot of stupid pointless 'statx' work that is
then entirely thrown away for a regular stat() system call.

Part of it is actual extra work to set the statx fields.

But a lot of it is that even if we didn't do that, the 'statx' code
has made 'struct kstat' much bigger, and made our code footprints much
worse.

Of course, even without the useless statx overhead, 'struct kstat'
itself ends up having a lot of padding because of how 'struct
timespec64' looks. It might actually be good to split it explicitly
into seconds and nanoseconds just for padding.

Because that all blows 'struct kstat' up to 160 bytes here.

And to make it all worse, the statx code has caused all the
filesystems to have their own 'getattr()' code just to fill in that
worthless garbage, when it used to be that you could rely on
'generic_fillattr()'.

I'm looking at ext4_getattr(), for example, and I think *all* of it is
due to statx - that to a close approximation nobody cares about, and
is a specialty system call for a couple of users

And again - the indirect branches have gone from being "a cycle or
two" to being pipeline stalls and mispredicts. So not using just a
plain 'generic_fillattr()' is *expensive*.

Sad. Because the *normal* stat() family of system calls are some of
the most important ones out there. Very much unlike statx().

              Linus
