Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809E97EFB1C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 22:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbjKQV57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 16:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjKQV54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 16:57:56 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75689120
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:57:52 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c509f2c46cso34805251fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700258271; x=1700863071; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+6VZ1GkKB2rFO5TykEwur/IyTwYdR4pBiOjNsHftfp0=;
        b=WkEb63uR4ClwR2/evflEmgCfxz1wSsoKPZt1HBqgx3sR0kKSRCBJjIqb52ynLYo7Ft
         qt/uYtJBgUinGk5G7CSkbX38gLpvgB6b4veXaSAndbsBQhWKF0d8rVx2Ux5Uw3PaixJP
         eJhItcKKHFKZHIbeRioSC8z/LqcM20KtqwUL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700258271; x=1700863071;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+6VZ1GkKB2rFO5TykEwur/IyTwYdR4pBiOjNsHftfp0=;
        b=ZDWuFb19/Lt9G7pjUa8OQPBpgXfwlYB2zJfdtjb9KzTVT2Z9FTvXcI8ZQ4JBLxQ7i2
         sKjGeaCLHoCf1759vl+y2LwTcYbDjbK6OLhQA3cAVmYep6i1PR0TQRq8GjW7vDzQu8D9
         y9/lZh2zEyQSE/R34U0tca69XbCAngwvT7E++ji/TgRtU2eCkuWbM9Kghjc6IA6HKv3R
         e7+MDhwlJvBOluzzJqh6j7c1zxyd4pxOYOJmReUgzqY061XbTtZW+oIaNq40X0y9OSag
         TtQds+YMsKRwsIoo6NUe+IIx5wWOQ19nJTXWtLKpVgibo48y1MCF3ve36g0t+6Yb5lLH
         5SHQ==
X-Gm-Message-State: AOJu0Yy+fgZFjlb11gOiCJitQ0uVrF89e9PMuVEdNvk0hRekO65uaY+z
        p5TfE2Jrt64X7xM0bDd6w5ng1PuIOcn+S5q89MpC5ip5
X-Google-Smtp-Source: AGHT+IFCiYQvKHQ8XD1MT71mr/qckfTYKM5WLyNYf+32Bm9ph20hzSIxapLRdc6UCQYjSJz22/VJjA==
X-Received: by 2002:ac2:4256:0:b0:50a:73a8:ae4f with SMTP id m22-20020ac24256000000b0050a73a8ae4fmr542498lfl.29.1700258270770;
        Fri, 17 Nov 2023 13:57:50 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id q2-20020ac24a62000000b00507c72697d0sm358227lfp.303.2023.11.17.13.57.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 13:57:50 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-507be298d2aso3254643e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 13:57:50 -0800 (PST)
X-Received: by 2002:ac2:4552:0:b0:509:4530:e7fb with SMTP id
 j18-20020ac24552000000b005094530e7fbmr598249lfm.32.1700258270001; Fri, 17 Nov
 2023 13:57:50 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local> <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
 <232440.1700153046@warthog.procyon.org.uk> <864270.1700230337@warthog.procyon.org.uk>
 <20231117160940.GGZVeQRLgLjJZXBLE1@fat_crate.local> <CAHk-=wj33FoGBQ7HkqjLbyOBQogWpYAG7WUTXatcfBF5duijjQ@mail.gmail.com>
 <CAHk-=whLbJ7vvB1ACVC6t44zjihX8w7GMY2y584+Fm83rsmaKg@mail.gmail.com> <20231117191243.GHZVe7K4vN9n5M92gb@fat_crate.local>
In-Reply-To: <20231117191243.GHZVe7K4vN9n5M92gb@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Nov 2023 13:57:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiRQHD5xnB8H9Lwk9fJPDpfVNAwPS4KLnfrcrU3zbMAdQ@mail.gmail.com>
Message-ID: <CAHk-=wiRQHD5xnB8H9Lwk9fJPDpfVNAwPS4KLnfrcrU3zbMAdQ@mail.gmail.com>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
To:     Borislav Petkov <bp@alien8.de>
Cc:     David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 at 11:13, Borislav Petkov <bp@alien8.de> wrote:
>
> I wouldn't want to optimize some weird loads. Especially if you have
> weird loads which perform differently depending on what uarch
> "optimizations" they sport.
>
> I guess optimizing for the majority of machines - modern FSRM ones which
> can do "rep; movsb" just fine - is one way to put it. And the rest is
> best effort.

Yeah, we shouldn't optimize for microbenchmarks in particular.

The kernel robot performance reports have been interesting, because
they do end up often pointing to real issues. But we've had these
kinds of things too, where the benchmark is just odd and clearly
happens to trigger something that is just very machine-specific.

So I don't think we should use either of these benchmarks as a "we
need to optimize for *this*", but it is another example of how much
memcpy() does matter. Even if the end result is then "but different
microarchitectrues react so differently that we can't please
everybody".

            Linus
