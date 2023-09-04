Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 513AF791EC8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 23:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239170AbjIDVB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 17:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239179AbjIDVBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 17:01:54 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6861B4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 14:01:48 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso28152621fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 14:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693861306; x=1694466106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jLDc5tGkjxblSphe8qteiEtoP2uqvtOnMoYp8kwIrOQ=;
        b=g2gvutit+aVBFX65iTgxgFBJHEgWejacgIjNdML2IDLYeLW4dHLikBZt7MkqIHd0xt
         Z0AgQ93TnWF51Pu6tn4cbb2Riqyhy6o7Es5cWMuKXFPWMhQtFyphzTSyyeiG6adqkFbL
         hWDixJ0hZj+SP/xl2PkWGuDTe2RZCXfxvnXmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693861306; x=1694466106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jLDc5tGkjxblSphe8qteiEtoP2uqvtOnMoYp8kwIrOQ=;
        b=CQNwBuxHrUmdSBe3tg5Q5NkOoeKf4zjXs3z/Rvfz3VEHDG42HBpLJ37VqlOyngM7RS
         8UgZAcsgn6ALs8AukQIEQdwskQfN6wMHjc5Lk3BAdTCez1qf8uqAkCRVD9w6Fp1iomjY
         F4nLhhlO0pFDrvdYVOAiu7D1cR5o2qzv6f19mxC7YZpjngTqoSFDwMvKVWeiwTsB1XoW
         UFrifcaYQYiIiDYSbYMw7OsfqeVzrVPKLXSgkYnkt9if9AXkHFsdKdDQzP2PreeabYP6
         Vp6QqSrpQlqfBpA5+RubNoPDjbiMxRjXDkksWU5Ho8WP3xlfMt8a9AbFtMQJRmlr/1GO
         gGog==
X-Gm-Message-State: AOJu0YxexSd4D8jtR1reqUKHLaj/Z3c626ODfA/YCL/jdyJ0csGCIhr2
        kZpIX4yt5FSL/73HVsV7g71OJcgCFRtasAXEtW8dxwBP
X-Google-Smtp-Source: AGHT+IFqz9i5JDVxNGoaJTThTKP1Vtur17axx9ZUCowNj29PNDoOHprWAJ75Ar7jXdwePf6k/tb1xA==
X-Received: by 2002:a2e:6e10:0:b0:2bb:b528:87b1 with SMTP id j16-20020a2e6e10000000b002bbb52887b1mr6699117ljc.50.1693861306620;
        Mon, 04 Sep 2023 14:01:46 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id c16-20020a2e9d90000000b002bccfd37659sm2399952ljj.99.2023.09.04.14.01.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 14:01:45 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4ff8f2630e3so3054862e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 14:01:45 -0700 (PDT)
X-Received: by 2002:a05:6512:2303:b0:4ff:89fc:9b5b with SMTP id
 o3-20020a056512230300b004ff89fc9b5bmr7978174lfu.9.1693861305132; Mon, 04 Sep
 2023 14:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230904141139.GC13143@google.com>
In-Reply-To: <20230904141139.GC13143@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Sep 2023 14:01:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrLwir-97uT+bX7Y-D3qs3qfkz0BKVj=SrXT6vNeBPvw@mail.gmail.com>
Message-ID: <CAHk-=wjrLwir-97uT+bX7Y-D3qs3qfkz0BKVj=SrXT6vNeBPvw@mail.gmail.com>
Subject: Re: [GIT PULL] Backlight for v6.6
To:     Lee Jones <lee@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>
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

On Mon, 4 Sept 2023 at 07:11, Lee Jones <lee@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.6

-ENOSUCHTAG.

Forgot to push?

                  Linus
