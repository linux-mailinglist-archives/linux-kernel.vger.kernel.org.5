Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0091B78E151
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241094AbjH3VTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjH3VTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:19:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049191A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:19:04 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so118481a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693430274; x=1694035074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8q5kz2+oj6sM056HV8Gy2jzYSBVkADNdoW0hpv8NAaY=;
        b=CKReUWUUpyYiP34c7j3bJLOTvA3E2Ptk2nylzSFgMhg3jQulGBhII2//waxXF8J8AY
         nE8TqotLh7nUGXe19FPda1IUunKCXUfR9X6/4kwYfWj2adWSOKKBHjWTZTHfJ7q3C/rU
         ryZhodDyVZUN9pPpPy1GeNQFqD29jYwbrnE2A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693430274; x=1694035074;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8q5kz2+oj6sM056HV8Gy2jzYSBVkADNdoW0hpv8NAaY=;
        b=WC2Im9Tyt/iZUuyWvNO7xs7RDiAB3xe5hHF7y++oCDuSocpImfCbRf9DjrPi+RbNnL
         L9gaKph0omlZCF/PuPk7vwZiGAJAZPMKgBYXd9ibv12xPb4jM/SoqkiVj0L96p7qlkcG
         n/xz6cvrvUPU/AZEqfC9Z3IE5n5noKVx8ng/Nh6AAfz/lATH4XyeAgdR0RYwHLFXwDrI
         8dF0ajECeDWvfrAfBJjcNSIinkaCZz3jm/L9u75v2vwsC7wD8YOr72o4Ty+ofQCBQK7F
         bVgpcfLKqRgKbRnLNGCjkqpXz1JLBMaMhO+4qc/dmE+17aubxClaluMZTE15SIaN1xGO
         CFkA==
X-Gm-Message-State: AOJu0Yzq6njn7uwPVRyT4M94bS/3eV7O0L2N8BB7hqEnptSNL30HyhIJ
        GpK8gkaKxYkp9FdssMr/9u3XAzZ4nLPj2IybRs5x1NTa
X-Google-Smtp-Source: AGHT+IFjIlt/0K02Gzj2TfZ/pp6VrP9kW8Jb3h8z+OWsiGDQrKsp596tqcmPTopKrWxw0ziL5ziz1A==
X-Received: by 2002:a05:6402:202a:b0:522:1956:a291 with SMTP id ay10-20020a056402202a00b005221956a291mr2876245edb.8.1693430274030;
        Wed, 30 Aug 2023 14:17:54 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id x2-20020aa7dac2000000b005272523b162sm30156eds.69.2023.08.30.14.17.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 14:17:53 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-9a5be3166a2so8503866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 14:17:53 -0700 (PDT)
X-Received: by 2002:a17:906:20ce:b0:9a1:fc1e:19ab with SMTP id
 c14-20020a17090620ce00b009a1fc1e19abmr2233639ejc.53.1693430273147; Wed, 30
 Aug 2023 14:17:53 -0700 (PDT)
MIME-Version: 1.0
References: <87msy8hicb.wl-tiwai@suse.de>
In-Reply-To: <87msy8hicb.wl-tiwai@suse.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 30 Aug 2023 14:17:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wje+VkXjjfVTmK-uJdG_M5=ar14QxAwK+XDiq07k_pzBg@mail.gmail.com>
Message-ID: <CAHk-=wje+VkXjjfVTmK-uJdG_M5=ar14QxAwK+XDiq07k_pzBg@mail.gmail.com>
Subject: Re: [GIT PULL] sound updates for 6.6-rc1
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, 30 Aug 2023 at 04:37, Takashi Iwai <tiwai@suse.de> wrote:
>
> - Unified PCM copy ops with iov_iter

So I know I suggested this, but I think some of it is seriously buggy.

In particular, look at dmaengine_copy().

It was *really* completely and unacceptbly broken at one point, when it did that

        void *ptr = (void __force *)iter_iov_addr(buf);

which is complete garbage in so many ways. That was removed by commit
9bebd65443c1 ("ASoC: dmaengine: Use iov_iter for process callback,
too"), and the end result looks superficially much better.

But the key word there is "superficially". The end result is still
completely broken as far as I can see.

Why? Because the code does

        if (is_playback)
                if (copy_from_iter(dma_ptr, bytes, buf) != bytes)
                        return -EFAULT;

        if (process) {
                int ret = process(substream, channel, hwoff, buf, bytes);
                if (ret < 0)
        ...

and notice how the "is_playback" has already *used* the iter in 'buf',
and has advanced the iterator.

So that operation is completely nonsensical.

Now, the commit message says "(although both atmel and stm drivers
don't use the given buffer address at all for now)", which may be the
only thing that saves the code from being broken.

Or rather, it's completely broken, but it is not broken in actual
*noticeable* ways.

Please just remove that useless iter argument. You simply cannot do
what that code tries to do.

There are alternatives, which involve either "dup_iter()" or
"iov_iter_save_state() / iov_iter_restore()". So using an iter twice
can be made to work, but not the way you do it.

Can I also please ask you to not use a name like "buf" for an
iterator. It's not a buffer. You must not think of it as a buffer.
Thinking of it as a buffer is what made the above nonsensical code
happen.

It's literally an _iterator_. There's a buffer somewhere behind it,
but that thing itself does *not* act as a buffer. It acts as a
descriptor of where in the buyffer you are, which is exactly why you
can't then re-use it twice as if it was some "buffer".

So please - when you change a buffer interface to use an iterator,
change the variable name. Don't make mistakes like the above.

                 Linus
