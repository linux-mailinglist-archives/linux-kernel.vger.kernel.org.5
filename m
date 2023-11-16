Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1BB7EE958
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 23:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345532AbjKPWhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 17:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKPWhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 17:37:14 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4B2120
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:37:10 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53dd752685fso2020099a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700174229; x=1700779029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fg0CJY1mi+VcLE2vTZuvqELHi9zo++jHybcNxPzB83U=;
        b=SGbFVB5TpzUKVqoQ25AHLDH1nvWIkYX5/9S2DPjb5b/z5aix+Kk11VYNIdVXSP64gb
         dHZ26OENFtRFmVxJm9SfrSHVAzGosizBDCoO59VoRXPkM/BIjNSyuMNDAJ5K9gSAclWu
         KUIhYKO42KTB3JIsM5lmyb9BElbyyR0QN5SSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700174229; x=1700779029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fg0CJY1mi+VcLE2vTZuvqELHi9zo++jHybcNxPzB83U=;
        b=LlxIj3dnFqBaEbas/5Jw0E92F8O1i6xgAcDxnZd0QhQ3fZM7gvZeCh7TCjItYB851M
         PGQBBrkGRqUIzDK5UVgjfUg+waLSAqzeHc3O04EpllCFKuzRjFemyjIY2ntO1jp5WB46
         4FWjLUeC2SnQtQRD1fuRzSESRiTK4s5sxQK96J+8l1amOUdODGlWfWmb2rbijC6efnsn
         E7KDaaCr665ubXAqzuPQBig7sU5mWHJh+hY4fcCuCQP6+G37ZFGGEM8LTmnU5NYSvr+i
         ZoZWyVhjZO/+RoTGHo+N1GcPhLR+HCVGCpyabdALucmqkb66FRguw4p21ITjh5KjyNAt
         fhrw==
X-Gm-Message-State: AOJu0Yz3RrrBdIT6yfSUABM0NxHkJtr26aqoLNCCa6e8rAVEqrTZ3htz
        6/6zG9twD+YKv20fmQQAe3+q05ejVzFcjNNrfUimcqgf
X-Google-Smtp-Source: AGHT+IEK0W5MwkEqRu8G/8GDWCX9trXpoP/1Xad5zdnVhUW0ZS9dTxODR3z+5rW4Op48JGQ1hzGEuQ==
X-Received: by 2002:a50:cc95:0:b0:540:97b5:3719 with SMTP id q21-20020a50cc95000000b0054097b53719mr13849793edi.25.1700174228877;
        Thu, 16 Nov 2023 14:37:08 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id b8-20020aa7dc08000000b00543597cd190sm115444edu.47.2023.11.16.14.37.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Nov 2023 14:37:07 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-53e3b8f906fso2024984a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 14:37:07 -0800 (PST)
X-Received: by 2002:a05:6402:2050:b0:543:d584:7d8f with SMTP id
 bc16-20020a056402205000b00543d5847d8fmr12994935edb.32.1700174226739; Thu, 16
 Nov 2023 14:37:06 -0800 (PST)
MIME-Version: 1.0
References: <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <4097023.1700084620@warthog.procyon.org.uk> <CAHk-=wgR3Mw2-8k2O3S10T-f4oz8FNfg7aziLU_6pbx0qowxew@mail.gmail.com>
 <42895.1700089191@warthog.procyon.org.uk> <CAHk-=wi7gdgFM4tnLXfE4cj2XiKNARbGY-N2aF5h9CMaN6JUbA@mail.gmail.com>
 <282731.1700168945@warthog.procyon.org.uk>
In-Reply-To: <282731.1700168945@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Nov 2023 17:36:47 -0500
X-Gmail-Original-Message-ID: <CAHk-=wjNv9NK=6rTNuQUkBfngw-jvP81esrV5ZLq0RBR9qaOuA@mail.gmail.com>
Message-ID: <CAHk-=wjNv9NK=6rTNuQUkBfngw-jvP81esrV5ZLq0RBR9qaOuA@mail.gmail.com>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
To:     David Howells <dhowells@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
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

On Thu, 16 Nov 2023 at 16:13, David Howells <dhowells@redhat.com> wrote:
>
>
> Okay, I disabled RETPOLINE, which seems like it should be the important one.
> With inlined memcpy:

Yeah, your machine really seems to hate the out-of-line call version.

It is also not unlikely that the benchmark is the perfect example of
that kind of "bad memory copy benchmark" where the actual results of
the copy are never used or touched. It's one case that sometimes makes
"rep movs" look (somewhat artificially) good, just because the
optimized rep string will do cacheline copies in L2. So if you never
touch the source or the destination of the copy, it never even gets
brought into the L1.

                 Linus
