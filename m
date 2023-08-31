Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E4878F557
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 00:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347664AbjHaWWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 18:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjHaWWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 18:22:16 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDE3E65
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:22:13 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so23254161fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693520531; x=1694125331; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R6PBikJYb7xQXhgePqx77WnTwF8snc03B9lP8paS8tQ=;
        b=QaHAjkyelskzK7Bhd3DooPVVfBxxPEXCeY3mNrWbMgEck1HgVrfU4IdkSf1dw+k5Qz
         3qVeNvnXxAV590zFIHkGHwrbDdva0pppiEoJlGAYl5cs707i7GJFK9I0dOMJw3xNs/S4
         pm916RIWuLLxLmOcq5WCxae02y03wnXDUVPHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693520531; x=1694125331;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6PBikJYb7xQXhgePqx77WnTwF8snc03B9lP8paS8tQ=;
        b=erQ24fuW15p6Df6FEUBwtmi1GhB+mPq46pRhSZB24VjqkjjsXffzmjezMRfevhUSOK
         L7D1v0DtD3M/pDskyCQ/Ny1suHjyrSNJPBWjGwIPw++yoSsww0WF8ZZUqfgUmTiqBPbX
         vyC1MDdg43smsBaICezvhd0sQaB19REDq//oYHG5xUsVneKniHcEjEGYgsLVt9t7Q5Oe
         1uOA2la6zirtD1BYaCj+yAGoHyhgDYVXqkOTCy+W/6+iyjF+fQgu6dIgmltnmU2xlU98
         VAhNFLnd5bHSAql3XpS1JZg9uqduNYfUxVdF+G5eThYyCuwwpEJZJsK04gcnkFnk55rN
         0dIA==
X-Gm-Message-State: AOJu0Yz+jXMf9ewgjl2Y3BQUiuIEjTe1M5XtK5a0+TIOeiBElx91UIv7
        QxgcU/a8KrbKQoqhmwztmkOi+5moDIj8IzWz7pBglEhB
X-Google-Smtp-Source: AGHT+IFG6nJ0MCEnbwqeugvYsxfX9RL/bAV6OE54e68sUy7POIc9pACnypTPjY6mDnNL1GKg1Tq/VQ==
X-Received: by 2002:a2e:9e92:0:b0:2ba:38c4:1621 with SMTP id f18-20020a2e9e92000000b002ba38c41621mr340495ljk.9.1693520531125;
        Thu, 31 Aug 2023 15:22:11 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id d5-20020a2e8905000000b002b6ea79c613sm521508lji.94.2023.08.31.15.22.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 15:22:10 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-500b66f8b27so2554350e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 15:22:10 -0700 (PDT)
X-Received: by 2002:a05:6512:3c85:b0:500:be7e:e84d with SMTP id
 h5-20020a0565123c8500b00500be7ee84dmr450789lfv.61.1693520530153; Thu, 31 Aug
 2023 15:22:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230831150155.GA364946@mit.edu>
In-Reply-To: <20230831150155.GA364946@mit.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Aug 2023 15:21:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgD-QfNUxqbvg5wLBnBCd4aBCR-Z7uuNSDHa+seNm4--Q@mail.gmail.com>
Message-ID: <CAHk-=wgD-QfNUxqbvg5wLBnBCd4aBCR-Z7uuNSDHa+seNm4--Q@mail.gmail.com>
Subject: Re: [GIT PULL] Ext4 updates for 6.6
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 08:02, Theodore Ts'o <tytso@mit.edu> wrote:
>
>   * Miscenallenous syzbot and other bug fixes

.. and this is why we write that word as just "Misc". Because pretty
much everybody gets it wrong after the first four or five letters.

             Linus
