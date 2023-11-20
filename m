Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097377F1825
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 17:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbjKTQG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 11:06:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjKTQGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 11:06:54 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49694A7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:06:51 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50970c2115eso6540599e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700496409; x=1701101209; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gvvrj1QlPb+xqGFyqA+peRigK3UgbxK38qicOcTMV9s=;
        b=hg0Y5i2LsKXWpvNQwn2yMscnj/sL6JPERwv7yrXne8vIonFPHJF2lfZW3Df+XwOPJX
         unkQUbamZJsmHwt9TN0vFG3BXWIVPwgbFIoOe8ElzF81kqra10r7CZlkLCJDV1eGh0kN
         BEH0vfGSGWn3NOOCMoA94rtyq5d8LLM10011g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700496409; x=1701101209;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gvvrj1QlPb+xqGFyqA+peRigK3UgbxK38qicOcTMV9s=;
        b=DAWoevG6d9E69rAZzWqI46VHoq9dL9kRvDEPsjxQcVxv+UZTNqWz1wqlPJzs+P3vXR
         HgTHY+F6oDm/qHE6jdhKcAYvjwdjQPaHvIjTQXC9n1s91xvn+rKsdHRnm2kVBkKfOa4C
         xDVr8Tv9AXGNN1NoxM7mTGdkbDA/ZMCMdCLgM9vSJWMZ74dMVuPcZ2i2Dj3wPrX8u65f
         iJmC2Ka+psR2JB0ZVplQv3SckZfOVZkJkAurQpYO3+qU6xaM3VmSUsAHTCCPkAD3lONO
         pZz61Xz+y4EhRW9l16j6jLpjP1FpAkkZ01hGxjOpH4dIMPQF2iL+KJCQEHzm5RC9oipm
         QxXg==
X-Gm-Message-State: AOJu0Yxj/Fnf6bL/xoEVZoFLMmK093vc/aAIWyRjtmG87DIicsJR417O
        ypM9fH3yagR4WoD0MEnYvMa7t7Z9v01HeRCFf/LbsA==
X-Google-Smtp-Source: AGHT+IGqdC4Q19am3BzoRs0QC59dQ2F9pUq10FrSwSdTR1dedN5g/7ir9JQEbWPk4h5iK23MT+7uKw==
X-Received: by 2002:ac2:4219:0:b0:509:4655:d8d6 with SMTP id y25-20020ac24219000000b005094655d8d6mr4656727lfh.67.1700496409489;
        Mon, 20 Nov 2023 08:06:49 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7cb90000000b0054879002b6csm2452964edt.84.2023.11.20.08.06.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 08:06:49 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-544455a4b56so6292255a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 08:06:49 -0800 (PST)
X-Received: by 2002:a05:6402:134c:b0:53e:4762:9373 with SMTP id
 y12-20020a056402134c00b0053e47629373mr5522481edw.18.1700496408702; Mon, 20
 Nov 2023 08:06:48 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local> <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
 <232440.1700153046@warthog.procyon.org.uk> <864270.1700230337@warthog.procyon.org.uk>
 <20231117160940.GGZVeQRLgLjJZXBLE1@fat_crate.local> <CAHk-=wj33FoGBQ7HkqjLbyOBQogWpYAG7WUTXatcfBF5duijjQ@mail.gmail.com>
 <CAHk-=whLbJ7vvB1ACVC6t44zjihX8w7GMY2y584+Fm83rsmaKg@mail.gmail.com>
 <20231117191243.GHZVe7K4vN9n5M92gb@fat_crate.local> <CAHk-=wiRQHD5xnB8H9Lwk9fJPDpfVNAwPS4KLnfrcrU3zbMAdQ@mail.gmail.com>
 <2284219.1700487177@warthog.procyon.org.uk>
In-Reply-To: <2284219.1700487177@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Nov 2023 08:06:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wid6dc9WpRdv5Gk1YL+bb9jkaMwc74b0UYA75tntq8xnw@mail.gmail.com>
Message-ID: <CAHk-=wid6dc9WpRdv5Gk1YL+bb9jkaMwc74b0UYA75tntq8xnw@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 at 05:33, David Howells <dhowells@redhat.com> wrote:
>
> So what, if anything, should I change?

I don't think you need to worry about this.

Not that I like ignoring kernel robot report performance regressions,
because they've often been useful to find unexpected issues. But this
one seems to clearly be just a random code choice issue by the
compiler, and be very CPU-specific anyway.

We'll figure out some good way to make memcpy() a bit more reliable
wrt the code it generates, but it's not the iov_iter code that should
worry about it.

               Linus
