Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABB77A8DF1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 22:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjITUlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 16:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjITUls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 16:41:48 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB24BB
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:41:42 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5041335fb9cso499581e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695242501; x=1695847301; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mn4MY7BtYrdUSVLDctKd++v/twQTrdcS02f+zA6JnXU=;
        b=N0TyW2m5FkG67Q8ZN/SkoEjP+AFtKxNSVMtCWC3GEFfCqbDcfRk18IE42xbzvxIcC4
         lvatrxKSqwJ//fhW6I2D6+FwAHYVE7qh/9unzuzFS4WyXiCsQ99FPkdElEdo2iVXYX6R
         bBjSs5R5+0maogRvO+vFdaKWqr2Qa0JjGk4UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695242501; x=1695847301;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mn4MY7BtYrdUSVLDctKd++v/twQTrdcS02f+zA6JnXU=;
        b=ANOTCq56kmWQdJjxlmkCxmHRWSglinJR7feXnZwPNClB4Z0z8+Gzb3hgX4rTBIZD3v
         7TjxNj/viqUO/l081SdGuk90+AAlpq9U3F5PROYHkWwsZO2DqvjJz6yJlVFvXtya2xxR
         m2fUuyRVMS54+4/QwCdT8LlM3Koe4d60YA1uK3AYZw63ImnU1IXV6RZoAIz2HQrBD1L8
         aojhzaCHIbyhboFWosl8VvOPpWBmnqoyIHFwzoecGSCzGAci0wGDv4KZHeOvC8lO+TC7
         9/lsPHsLAG9TNehKrRGVXPD/7ZS+eLpigeWZLHIw0ARdmW8ZfnLd6VDX8JbXVF9AvG9P
         pLyA==
X-Gm-Message-State: AOJu0Ywf0SsIRourABXSRFyJfSdW+F55v5gBXn3ZF1uLuRq9o8ZhfUjv
        TKxNNGayKbm5vpOU/I5XmqyeRp2IUtxPuGlo+NdIa0ED
X-Google-Smtp-Source: AGHT+IGl4MerRkD4oFwzMH730ikey1rqymZ95JT9TtX5vYta3oA9kAHEKOw2jmsM0hUXg0vVjkHCsw==
X-Received: by 2002:a05:6512:3b12:b0:503:3808:389a with SMTP id f18-20020a0565123b1200b005033808389amr4081241lfv.11.1695242501010;
        Wed, 20 Sep 2023 13:41:41 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id t4-20020ac243a4000000b0050096cc3ba1sm2831135lfl.255.2023.09.20.13.41.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 13:41:40 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-502153ae36cso462610e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 13:41:40 -0700 (PDT)
X-Received: by 2002:a19:2d04:0:b0:503:3675:9ba with SMTP id
 k4-20020a192d04000000b00503367509bamr2690524lfj.26.1695242499688; Wed, 20 Sep
 2023 13:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230920060615.GA2739@sol.localdomain> <CAHk-=wja26UmHQCu48n_HN5t5w3fa6ocm5d_VrJe6-RhCU_x9A@mail.gmail.com>
 <20230920193203.GA914@sol.localdomain> <CAHk-=wicaC9BhbgufM_Ym6bkjrRcB7ZXSK00fYEmiAcFmwN3Kg@mail.gmail.com>
 <20230920202126.GC914@sol.localdomain> <CAHk-=wgu4a=ckih8+JgfwYPZcp-uvc1Nh2LTGBSzSVKMYRk+-w@mail.gmail.com>
In-Reply-To: <CAHk-=wgu4a=ckih8+JgfwYPZcp-uvc1Nh2LTGBSzSVKMYRk+-w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Sep 2023 13:41:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+nAmcXV=Xz6fkDpazne+n+iFfGsnS=p9PjVLiEjiSvQ@mail.gmail.com>
Message-ID: <CAHk-=wh+nAmcXV=Xz6fkDpazne+n+iFfGsnS=p9PjVLiEjiSvQ@mail.gmail.com>
Subject: Re: [RFC] Should writes to /dev/urandom immediately affect reads?
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
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

On Wed, 20 Sept 2023 at 13:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It was why I also asked about entropy. Because *if* you argue that the
> user-space write contains entropy, then that would be a reason.

To clarify - the jitter entropy question was related to that same
basic issue: if this was meant to be a way to mitigate the lack of
jitter entropy on some platform you care about, that would again
possibly be a reason to care.

Considering that we apparently haven't cared for the last 7 years, I'm
still a bit surprised, but whatever.

What I *don't* want is just more voodoo discussions about /dev/*random
behavior that doesn't have a technical reason for it.

                Linus
