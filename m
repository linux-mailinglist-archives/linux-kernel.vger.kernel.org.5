Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79FF37EF642
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 17:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346084AbjKQQc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 11:32:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKQQcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 11:32:55 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D97A4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:32:52 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9becde9ea7bso661436466b.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700238770; x=1700843570; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sWqn8BVZx48aeIBfXi/N03W7SfnJax/+BdIf2xPvMfQ=;
        b=G96gwUx+fQ2F1ONwnskrTxh6K76DNkda0wzsg1VFDiwoNenj5GCOU6r8dlbLYCUnHX
         uTC/Fbh3A/wSWJqbQuEXrFYgjhB/7H+JYUDZb49lOkqiBAi/6z+xWUh3UoSm7rLJdZWO
         6d4Aftvd4gURnwLgkVSWvmH3qmFSTYrKSeZk8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700238770; x=1700843570;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sWqn8BVZx48aeIBfXi/N03W7SfnJax/+BdIf2xPvMfQ=;
        b=CLP0J0EFShAuL0EnqK+D+ilyQpoWcpt7TjfHB/fZZiiUjL9uBHF4kP8N02ZhnBHm2U
         Ap0p1FeRisf4Z7kFQxkdFvbRFLL/OQbJPu0cEJha2b8Ntgn0bcqBDZWYp/4K7hSJbpDO
         HR2P0aPSRZo39Qo5NBzan/6cJBk8YnvbfawuU0T+dRsPmYV4Ri3JDWtnb0axhboy0P73
         0JXxqdYtqxwGm/T+C43EPg8j173XF64hxDsjD9FqI6+ja69t13Wq1TLpAV0V6XTk6XBk
         jE3qkDyIMtZXajt641nJC8sCVnM19ZuTCKvJvFoJlTZ9b8Ydfwthn+Y/o4YZStPladRH
         FTRw==
X-Gm-Message-State: AOJu0Yx238NYwZyEute9Wm4XBWs+m2EcdH5eY5PqK0CWJi+qeWRHXz60
        lxfSENHv3h4qvg7KQVTht9tu5Ya7MuIHLFNQAnnnpxpI
X-Google-Smtp-Source: AGHT+IEZTVRHaP3YxRBm79ubSy/+uqajaAK+KHqUkld1L3i9lKIj/9s5Rm7qxr2MO6ZbGe6PQ7IfWA==
X-Received: by 2002:a17:906:38da:b0:9ae:50ec:bd81 with SMTP id r26-20020a17090638da00b009ae50ecbd81mr4228073ejd.21.1700238770437;
        Fri, 17 Nov 2023 08:32:50 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id jz2-20020a170906bb0200b009ddf38056f8sm952067ejb.118.2023.11.17.08.32.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 08:32:49 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-547e7de7b6fso4221574a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 08:32:49 -0800 (PST)
X-Received: by 2002:a05:6402:1744:b0:52c:f73:3567 with SMTP id
 v4-20020a056402174400b0052c0f733567mr5355762edx.13.1700238768931; Fri, 17 Nov
 2023 08:32:48 -0800 (PST)
MIME-Version: 1.0
References: <20231116154406.GDZVY4xmFvRQt0wGGE@fat_crate.local>
 <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local> <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
 <232440.1700153046@warthog.procyon.org.uk> <864270.1700230337@warthog.procyon.org.uk>
 <20231117160940.GGZVeQRLgLjJZXBLE1@fat_crate.local>
In-Reply-To: <20231117160940.GGZVeQRLgLjJZXBLE1@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Nov 2023 11:32:31 -0500
X-Gmail-Original-Message-ID: <CAHk-=wj33FoGBQ7HkqjLbyOBQogWpYAG7WUTXatcfBF5duijjQ@mail.gmail.com>
Message-ID: <CAHk-=wj33FoGBQ7HkqjLbyOBQogWpYAG7WUTXatcfBF5duijjQ@mail.gmail.com>
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

On Fri, 17 Nov 2023 at 11:10, Borislav Petkov <bp@alien8.de> wrote:
>
> Which looks like those added memcpy calls add a lot of overhead due to
> the mitigations crap.

No, you missed where I thought that too and asked David to test
without mitigations.

That load really loves "rep movsb" on his machine (and that includes
the gcc-generated odd inlined "one word by hand, and then 'rep movsq'
for the rest").

It's probably because it's a benchmark that doesn't actually touch the
data, and does page-sized copies. It's pretty much the optimal case
for ERMS.

The "do one word by hand, the rest with 'rep movsq'" model that gcc
uses (but only in this particular code generation case) probably ends
up being quite reasonable in general - the one word by hand allows for
unaligned counts, but it also brings in the beginning of the copy into
the cache (which is *often* the part used later - not in this
benchmark, but in general), and then the rest ends up being done as L2
cacheline copies at least when we have those nice page-aligned
patterns.

Of course, this whole thread started because the kernel test robot
then has exactly the opposite reaction - it seems to really *hate*
that inlined code generation by gcc. Whether that is because it's a
very different microarchitecture, or it's because it's just a very
different access pattern than the one that David's random KUnit test
pattern is, I don't know.

That kernel test robot case is on a Cooper Lake Xeon, which is (I
think) is just Skylake server. Random Intel codenames...

So that test robot has ERMS too, but no FSRM, so we do the old
"memcpy_orig()" with the regular memcpy loop.

And on that Xeon, it really does seem to be the right thing to do.

But the profile is so noisy with other changes that it's not like I
can guarantee that that is the main issue here. The reason I zeroed in
on the memcpy thing was really just that (a) it does show up in the
profiles and (b) the commit that introduced that 16% regression
doesn't really seem to do anything else than reorganize things just
enough that gcc seems to do that alternate memcpy implementation.

The test case seems to be (from the profile) just a simple

do_iter_readv_writev ->
  shmem_file_write_iter ->
    generic_perform_write ->
      copy_page_from_iter_atomic ->
        memcpy_from_iter_mc

and that's then where the new code generation matters (ie does it do
that "inline with rep movsq" or "call memcpy_orig").

For David, the rep movsq is great. For the kernel test robot, it's bad.

                  Linus
