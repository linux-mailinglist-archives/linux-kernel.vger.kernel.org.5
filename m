Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB4F791C12
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 19:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347632AbjIDReu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 13:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjIDReu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 13:34:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC92CE0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 10:34:46 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-500c37d479aso2601580e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 10:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693848885; x=1694453685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HBeJW1trCbDc5M4JM8VJRHuXLyN1Y56AYcyYx/jjbLY=;
        b=em13aYKZnWyLKJnN7gcZ432bmkQFb9eWL5Ow+gwRZuoHiQnqwX9iHZ0PnGgYEYWdgV
         T7CslgfXaGuxASxpzdj+BgpeZjwG0APdIW/+YIl11GRXT+61Owq7gTHSZ208uYnEtooa
         GmpngCGNIRUxBvDHVYcinsWgPlNW810F4wikc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693848885; x=1694453685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBeJW1trCbDc5M4JM8VJRHuXLyN1Y56AYcyYx/jjbLY=;
        b=fdQjrKIYy7xz9zoJMlPXvhpzFxxtPkfFyQee73GzE+62/TJTIbjpl/llPHVRGykIi5
         GwbusugJBqN3x/FFxceGsggoI7+bnmlhz+jtPc0F9xKsrLcK7h3oEdj528MfGGZ98HVy
         V6sqcrXERG0QjdqMAHMKWwQm6HYI5GQSAYyO+aAyhw9mwDQvnir6XYvQE0hy135FIKH9
         DXS5zDITGj9NbGv/LmVB61h3uiGMePAIUzA4txEol0rSYzslLIkzQuqqbAYqHCQoM+ob
         y3F0RBlqaeDIUK0NE4ihErZ63V0/+pkJCgU9oVsechYmz7s0qTb6aPCnfOt0Zp5X+1W2
         X54w==
X-Gm-Message-State: AOJu0YxfD/6aNFxIjpRAKUv9eT1Qp7TLY1DgPDPX6eA5nOQNw8VW8Nxc
        TC5OKft7xAQOw/SjNFc5AlaSTCBc3yugmuaI4cam7t3z
X-Google-Smtp-Source: AGHT+IF6lE1dZNwLBAcfPeRY+b8J8Iv5Gxt+DluI6Mh77xhYC+2WA4PbSR3rfeADlsmGyExKPoXkoA==
X-Received: by 2002:a19:670e:0:b0:4fd:c83b:a093 with SMTP id b14-20020a19670e000000b004fdc83ba093mr5917279lfc.1.1693848884810;
        Mon, 04 Sep 2023 10:34:44 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id s12-20020a19ad4c000000b004fbb011c9bcsm1844545lfd.161.2023.09.04.10.34.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 10:34:42 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4ff9b389677so2605439e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 10:34:42 -0700 (PDT)
X-Received: by 2002:a05:6512:1192:b0:4ff:86c7:f17e with SMTP id
 g18-20020a056512119200b004ff86c7f17emr8348631lfr.50.1693848881833; Mon, 04
 Sep 2023 10:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230831105252.1385911-1-zhaoyang.huang@unisoc.com>
 <ZPCEim0AZG5hTSYH@casper.infradead.org> <CAGWkznGAJVZtn49zNHsMAjRSfTRR707QXYY0m8Q+yABTsiig2Q@mail.gmail.com>
 <CAG_fn=VJrO3e9q0M6KA9nopqyDuRO4g7SBak6YptiEvzdE+nkA@mail.gmail.com> <ZPWNTiAxZZh/kzew@dhcp22.suse.cz>
In-Reply-To: <ZPWNTiAxZZh/kzew@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 4 Sep 2023 10:34:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2s26=Hj03cJXBWELmgCY=z5=mhTTDNVVKDAbda8g7Xw@mail.gmail.com>
Message-ID: <CAHk-=wh2s26=Hj03cJXBWELmgCY=z5=mhTTDNVVKDAbda8g7Xw@mail.gmail.com>
Subject: Re: [PATCH] mm: make __GFP_SKIP_ZERO visible to skip zero operation
To:     Michal Hocko <mhocko@suse.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Mateusz Guzik <mjguzik@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
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

On Mon, 4 Sept 2023 at 00:55, Michal Hocko <mhocko@suse.com> wrote:
>
>       Sooner or later this will become an
> unreviewable mess so the value of init_on_alloc will become very
> dubious.

The value of init_on_alloc is *already* very dubious.

Exactly because people will turn it off, because it hurts performance
so much - and in pointless ways.

You do realize that distributions - well, at least Fedora - simply
don't turn INIT_ON_ALLOC_DEFAULT_ON on at all?

So the current state of init_on_alloc is that nobody sane uses it. You
have to think you're special to enable it, because it is *so* bad.

Security people need to realize that the primary point of computing is
NEVER EVER security. Security is entirely pointless without a usable
system.

Unless security people realize that they are always secondary, they
aren't security people, they are just random wankers.

And people who state this truism had better not get shamed for
standing up to stupidity.

             Linus
