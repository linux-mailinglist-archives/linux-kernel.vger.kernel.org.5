Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934A67A6855
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 17:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbjISPtF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 11:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233178AbjISPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 11:49:02 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493AD9D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:48:56 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-65643a83758so19466656d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695138535; x=1695743335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FUFBX34Vi8T0jyulMhlIaJzOiGzxRBHm/K7XuTUIix8=;
        b=2C5Kk5jBdwO+wUlff1qDFpyRMIcxfsXG0zhn/m974GNZGjX0pAGZ6eSmSFEL0OW4bt
         +8T3IDEao5L9LIn8uOR2xPdvTjkQgjJaPrIXIPdO1SxL/wjgm8xAs0Ooydb03PEG5sF6
         dI43xBKUG72kujk/cfWdrPhLq3azvQM5I6g0zJFNtxJzUVD+QbsR8Zwe7lLQOKUZ7DEd
         KKsqvH6IBzbttJHVieNhDfxhqZHTpzVmEtQ/yKALHmq659qZNdJX8ZA2AU9SfO0lta+1
         fYwoN8+tVm+97N72m2yF+c3z67fWIF6fa+VxKaZmNbzHHdCeNuaM46rHrk0m0I5aQEvZ
         98EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695138535; x=1695743335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUFBX34Vi8T0jyulMhlIaJzOiGzxRBHm/K7XuTUIix8=;
        b=GeuGhDTCdueuY2nzIfGj51lM7AKSllok/zIExmE8sX62Tnl/KeTx5AP4NXkpb1oOeD
         Udjl8mPjjMKe1O/5pIzjkTOeFRzs6H60R5IMwKCjw3sSwMWBRXzhs721BNzAn7Ox9wjk
         6VYvoUBa7OBM1Na4aTBy6lc7LCWmDIq93gsrQSVjckmneKiyvGeGWvz7JuxSw6R8axy5
         LFTWgxJOIZuzY5mGUOBwm1sFMLC5MQRlHmoEJtowd2CuDpavrGkIszIUi1zBvlTvHadU
         aYSdDBEelsY6vNyf2cK3I/RARHjBhnnp+LP+hcPU9UlWGZV+OUCK57d4xlfz8p9v/59r
         Tjzw==
X-Gm-Message-State: AOJu0YzltuiADF8h0SN2rG3ORuyAh6oBW39J41xaKtjMXJuF5/N642sn
        xLrfA5NmD2VkdndNuF4CaStkaSxpxkS4Ib6IrA6szw==
X-Google-Smtp-Source: AGHT+IE3bOOMkBS+atNtSPIXMOTa2Ld22Qs9HTCkKcTaipggWake8IjLOlnyddu6BbylehDROBRn01dZ36CiD5ewpnY=
X-Received: by 2002:a05:6214:5d0e:b0:658:2d42:75e4 with SMTP id
 me14-20020a0562145d0e00b006582d4275e4mr4698272qvb.47.1695138535174; Tue, 19
 Sep 2023 08:48:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
 <7a4f5128-28fd-3c5f-34c2-1c34f4448174@intel.com> <1d7573c0-ebbc-6ed2-f152-1045eb0542f9@os.amperecomputing.com>
 <CAHKB1w+rVyww0UrHhzeGfPA7FM482Z-7ApzXvekVqLHvTDAV3Q@mail.gmail.com>
 <ZQiLX0W2Tcr+wdJT@gmail.com> <CAHk-=wgGzB4u-WZsDpdgjwX1w5=9CLE0gorhaNFD09P1FUGeuQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgGzB4u-WZsDpdgjwX1w5=9CLE0gorhaNFD09P1FUGeuQ@mail.gmail.com>
From:   Matteo Rizzo <matteorizzo@google.com>
Date:   Tue, 19 Sep 2023 17:48:42 +0200
Message-ID: <CAHKB1w+9GgY_e6J+rZ4zDaXrPZab5xteTuDEH0Z2hWe6x-pT5g@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Prevent cross-cache attacks in the SLUB allocator
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>,
        Dave Hansen <dave.hansen@intel.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org, jannh@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 20:05, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> ... and equally importantly, what about DMA?

I'm not exactly sure what you mean by this, I don't think this should
affect the performance of DMA.

> Or what about the fixed-size slabs (aka kmalloc?) What's the point of
> "never re-use the same address for a different slab", when the *same*
> slab will contain different kinds of allocations anyway?

There are a number of patches out there (for example the random_kmalloc
series which recently got merged into v6.6) which attempt to segregate
kmalloc'd objects into different caches to make exploitation harder.
Another thing that we would like to have in the future is to segregate
objects by type (like XNU's kalloc_type
https://security.apple.com/blog/towards-the-next-generation-of-xnu-memory-safety/)
which makes exploiting use-after-free by type confusion much harder or
impossible.

All of these mitigations can be bypassed very easily if the attacker can
mount a cross-cache attack, which is what this series attempts to prevent.
This is not only theoretical, we've seen attackers use this all the time in
kCTF/kernelCTF submissions (for example
https://ruia-ruia.github.io/2022/08/05/CVE-2022-29582-io-uring/).

> I think the whole "make it one single compile-time option" model is
> completely and fundamentally broken.

Wouldn't making this toggleable at boot time or runtime make performance
even worse?

--
Matteo
