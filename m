Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F397EF3BE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 14:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjKQNgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 08:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKQNg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 08:36:29 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3F8D55
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:36:25 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9dbb3e0ff65so278921166b.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:36:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700228184; x=1700832984; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j4nL6lMcchz3OqRF6Jql0QZtDg2jb+Lp1wFMbOZWnTY=;
        b=cKOZQQKRcVQgkEHFYCEHZONRrGc+CxSoq9Pu8fYvVv1WL5W2O7xz0HrL1YYQpIYVwy
         ksUobwXuP3pf6RU+iL1k3nUB2L92ZTKrHEa1FjfFCnKFS77sImjxUM4CksjKIcx8zIV3
         7vAKjak/x4N7kRnaqMA2c01cStM+AfadG7krA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700228184; x=1700832984;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4nL6lMcchz3OqRF6Jql0QZtDg2jb+Lp1wFMbOZWnTY=;
        b=ms0L0kbB1PepZnPJB7aeFXjbj7aS7VpCPNIKRcv1tZUwd5VMV3ps3tv8ullgXI3rIm
         SB2Y0h7oige7ENKSnfQrfoU8fddhNrk7HaFdrg0EedklTYM959HgJSy9ZB0hrFyBicIW
         AmJPDKL56hEDMvh7Xy5+jpgcDgZXWY07ZJkBNifIO8aEEgNsNLPDvOhKeasb04jfMOxo
         /0H5ubAqHfc0zsommrWaFO+B3n7dWz3n8nPaj9PvgA0sbkyaOQaUs7ywwpTeLg6NoR/A
         a2Fxy6OqG4DF0VBibOv6K7GQLRbhdCao/xDVY1tXOopSY7uSmRYs+mRmZfg3tTeNZQtX
         69jg==
X-Gm-Message-State: AOJu0YwB8z9Idhvs+S5Kirh5h4QrZDgyuFBksKCls6XT5H7Hd44nd/52
        A1Ql4vs8yEG14ptogmJFCMsHM226KRcj6cvJIyCCWKow
X-Google-Smtp-Source: AGHT+IHIqnK1G6aREIcbLX23AHTSYheF5+o6IpXv8k3y7eksej1BcqhvCb+4rFUJtqkDU59HwbScpA==
X-Received: by 2002:a17:907:36a:b0:9e4:6ff2:131a with SMTP id rs10-20020a170907036a00b009e46ff2131amr14504689ejb.48.1700228184319;
        Fri, 17 Nov 2023 05:36:24 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id h20-20020a1709062dd400b0099293cdbc98sm802445eji.145.2023.11.17.05.36.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 05:36:22 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-53e08e439c7so2889955a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 05:36:21 -0800 (PST)
X-Received: by 2002:a05:6402:55:b0:543:5927:f969 with SMTP id
 f21-20020a056402005500b005435927f969mr14403549edu.3.1700228181455; Fri, 17
 Nov 2023 05:36:21 -0800 (PST)
MIME-Version: 1.0
References: <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local> <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
 <20231116154406.GDZVY4xmFvRQt0wGGE@fat_crate.local> <CAHk-=wjGQh3ucZFmFR0evbKu2OyEuue-bOjsrnCvxSQdj8x6aw@mail.gmail.com>
 <20231117114421.GCZVdSFZ7DKtBol821@fat_crate.local> <67acdf70c3fd4adf9bc0dddd4b10d4a1@AcuMS.aculab.com>
In-Reply-To: <67acdf70c3fd4adf9bc0dddd4b10d4a1@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Nov 2023 08:36:03 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjjF7tQ4ycPiA4gbYqF-dpTQx+VVHCDqjWR=ogqNUR51g@mail.gmail.com>
Message-ID: <CAHk-=wjjF7tQ4ycPiA4gbYqF-dpTQx+VVHCDqjWR=ogqNUR51g@mail.gmail.com>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
To:     David Laight <David.Laight@aculab.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        "oe-lkp@lists.linux.dev" <oe-lkp@lists.linux.dev>,
        "lkp@intel.com" <lkp@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "ying.huang@intel.com" <ying.huang@intel.com>,
        "feng.tang@intel.com" <feng.tang@intel.com>,
        "fengwei.yin@intel.com" <fengwei.yin@intel.com>,
        linux-toolchains ML <linux-toolchains@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2023 at 08:09, David Laight <David.Laight@aculab.com> wrote:
>
> Zero length copies are different, they always take ~60 clocks.

That zero-length thing is some odd microcode implementation issue, and
I think intel actually made a FZRM cpuid bit available for it ("Fast
Zero-size Rep Movs").

I don't think we care in the kernel, but somebody else did (or maybe
Intel added a flag for "we fixed it" just because they noticed)

I at some point did some profiling, and we do have zero-length memcpy
cases occasionally (at least for user copies, which was what I was
looking at), but they aren't common enough to worry about some small
extra strange overhead.

(In case you care, it was for things like an ioctl doing "copy the
base part of the ioctl data, then copy the rest separately".  Where
"the rest" was then often nothing at all).

> My current guess for the 5000 clocks is that the logic to
> decode 'rep movsb' is loaded into a buffer that is also used
> to decode some other instructions.

Unlikely.

I would guess it's the "power up the AVX2 side". The memory copy uses
those same resources internally.

You could try to see if "first AVX memory access" (or similar) has the
same extra initial cpu cycle issue.

Anyway, the CPU you are testing is new enough to have ERMS - that's
the "we do pretty well on string instructions" flag. It does indeed do
pretty well on string instructions, but has a few oddities in addition
to the zero-sized thing.

The other bad cases tend to be along the line of "it falls flat on its
face when the source and destination address are not mutually aligned,
but they are the same virtual address modulo 4096".

Or something like that. I forget the exact details. The details do
exist, but I forget where (I suspect either Agner Fog or some footnote
in some Intel architecture manual).

So it's very much not as simple as "fixed initial cost and then a
fairly fixed cost per 32B", even if that is *one* pattern.

                Linus
