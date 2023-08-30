Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECFF778D29B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 05:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241845AbjH3DzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 23:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239032AbjH3DzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 23:55:07 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C7F1BF
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:55:03 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bd0bc8b429so48002421fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693367701; x=1693972501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yBqktMQetI5IOCQP5dlOQl/11nqAkCQ7kAENt/e88W0=;
        b=Bun6os5kag2yRR70qOyZKqkCXaCzYh8bU8W/fW/pr3zPmiqIAlVO2R+YYbJYFGHOtW
         bpLcMqWBY4cisj7tEY2FrZjCN1lDMrfSj7B5nZXk/hIIGH5bLkJoCn1qOgVmokWVs7OT
         ekD00kvfQohkQjpJn3MrqSnXw1s/VHkgtoAVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693367701; x=1693972501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBqktMQetI5IOCQP5dlOQl/11nqAkCQ7kAENt/e88W0=;
        b=XEIphcJgd/AZfOWPIk9PuCXrydaQUT3pKhT1vbWtCAoOHOxCj3DT79hUo/cXkTKAjE
         4bHFNp8zf8UV3W+7dFOs7qy8+O1aSccQ1kA/k2pB5wN7yzZh+A9BgiBN64KFt9EQyKaN
         mmnN6T09cBosN31Fmt0NLmFhCxDwmC9AYZOZQJp5Qv2lOe1QAqETTQlHPSveXq/PrMXU
         DrgoVkmKucET453awd50ghmdVzFd6T1cxL9zT2XMswF+vQrhyhAwccXkliA0V6pFmpp7
         ksNH3xncLju0Qk58VP7lzl9BPsG1coFeLvp8NEGOpP4hTrSL6bR7Ot4BAKInuJ59Nf8H
         bjzQ==
X-Gm-Message-State: AOJu0YydB3RZ1YwQSbZmqtamOH0c9/vupCd3O+LIZdvCtfhYxYXiPhIY
        F67hDoOxkIXIQ/3r4S7Zog9+wkuk9HRVazmqFvIooQ5A
X-Google-Smtp-Source: AGHT+IHixlVhY3QhqU+UEWoOfdQb78bUkMUYKXXLN5zdPTrkN8HF9EHUCUFdd36aE+ZhiubsV2gaSg==
X-Received: by 2002:a2e:880a:0:b0:2bd:bc9:30aa with SMTP id x10-20020a2e880a000000b002bd0bc930aamr832221ljh.23.1693367701507;
        Tue, 29 Aug 2023 20:55:01 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r16-20020a2e94d0000000b002b9a1e9ba68sm2420302ljh.136.2023.08.29.20.55.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 20:55:00 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2bd0bc8b429so48002211fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:55:00 -0700 (PDT)
X-Received: by 2002:a2e:9397:0:b0:2bc:e1a3:fbaa with SMTP id
 g23-20020a2e9397000000b002bce1a3fbaamr845437ljh.22.1693367700488; Tue, 29 Aug
 2023 20:55:00 -0700 (PDT)
MIME-Version: 1.0
References: <ZO4NUZ+k4Q4zPu6X@infradead.org>
In-Reply-To: <ZO4NUZ+k4Q4zPu6X@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Aug 2023 20:54:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wik9Df4Si7aYOqgyhf=io2OaP=7Yur-xpbNe6oHuxSFAg@mail.gmail.com>
Message-ID: <CAHk-=wik9Df4Si7aYOqgyhf=io2OaP=7Yur-xpbNe6oHuxSFAg@mail.gmail.com>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.6
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        Petr Tesarik <petr.tesarik.ext@huawei.com>
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

On Tue, 29 Aug 2023 at 08:23, Christoph Hellwig <hch@infradead.org> wrote:=
>
> Yajun Deng (2):
>       dma-contiguous: support per-numa CMA for all architectures

What?

This commit seems entirely bogus and is actively misleading.

It claims to enable support for per-numa CMA for all architectures.

It does no such thing.

All it does is to change the default value for a config option. It was
perfectly available before, now it is - incorrectly - made 'default y'
in case the config supports NUME at all.

There seems to be no real reason to change the default value of this
config option. The commit message most definitely doesn't argue for
it, since it talks about something entirely different than what the
code changes does.

I have taken this, but I protest these kinds of nonsensical changes.
That commit is actively misleading and confused, and I think the
default value for that config option should just be 'n' on all
architectures.

Why is this option so important that it should be enabled just because
some minimal NUMA support might be enabled?

Please don't add these kinds of hidden "default y" by making them
default on some much more common option instead.

                Linus
