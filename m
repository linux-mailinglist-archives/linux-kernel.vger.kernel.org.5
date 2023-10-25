Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE2D7D7284
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjJYRlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbjJYRlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:41:39 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A2018D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:41:35 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507d7b73b74so8571815e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698255693; x=1698860493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cBNaTjBwmD7DDb8oYXr337UXXRS17wg2IqMWRZnMrPs=;
        b=a8ADbzxA97WkVE7jEmgvzOP35ExZG5aEKw5LffNswukF9Em9Lei/Q4mPAgqRrl0SAh
         1a4Nvm88a967sAuXajj4zZnilwgzuIYgpej3CWwi4jJPWJYnT7i4HM/kB8Z7v5sjg4RB
         NQRxHZs/n+dypH+lk97sE2B0KTiY+oAKZELtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698255693; x=1698860493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cBNaTjBwmD7DDb8oYXr337UXXRS17wg2IqMWRZnMrPs=;
        b=d9OAXqjAKjmhbDBom6cXk5OY2m4Ouao0Iei2dR48cX5SJMfNbRmbkC5VCRMFwNfZpx
         393tY4eLvOxCgi2QONt6+gYmHoFuhObu2AotneFqiKT+NViaNTLkKzsFxJBTxcUbJ1+i
         ZctsaozhU8UFRUUb0LUPVmhT5BtT3RuwqBN0noPadJK83eBtls1o4K0rj6eZql/B5csz
         meF7teBfY7Xbz4gfl0kuQgn7AKfGTZzs1m9V4SnP8n1q0eMX1IJwlD0J0fPyGt6ZFxFv
         DKlL69t3zKv1TR+5PeIGjJ8aPFzSyUzV5XczI7RglKWki/I10obeZoTqkm4ywLhqatWC
         0hmg==
X-Gm-Message-State: AOJu0YwiQo3d/PgZILoc4VN+279CMOCGCvtS7JnN5U9FiFnB+0/Jqgox
        MAExz+66Aom4wc/oTiLY28iwg26whENDxYKC/VLc6A==
X-Google-Smtp-Source: AGHT+IHRpF0zSoJqTQU8iGe+r6TTv3OOqpU+2f32IzdhDI6nYMMVOdIn4sAgSK9FS3D+9W/7SnrO4Q==
X-Received: by 2002:ac2:485b:0:b0:507:9a33:f105 with SMTP id 27-20020ac2485b000000b005079a33f105mr11050461lfy.69.1698255693249;
        Wed, 25 Oct 2023 10:41:33 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id d24-20020a170906041800b0099cb1a2cab0sm10329703eja.28.2023.10.25.10.41.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 10:41:32 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-540105dea92so6961474a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 10:41:32 -0700 (PDT)
X-Received: by 2002:a17:906:fd45:b0:9c3:cefa:93c6 with SMTP id
 wi5-20020a170906fd4500b009c3cefa93c6mr7840525ejb.10.1698255692298; Wed, 25
 Oct 2023 10:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20231024161931.78567-1-sebastian.reichel@collabora.com>
 <20231024161931.78567-2-sebastian.reichel@collabora.com> <CAHk-=whYDbZ29fx_xeSxtYSjtF8WJkaLjzyB8RN5_Rk9Sh-YyQ@mail.gmail.com>
 <CAHk-=wjO5ivM6k7iMiThO9JfxH0dhLe=mcC4TQwReU0nBCnWpg@mail.gmail.com> <4c2d36375bd74d94a2e6ef5d2fa0df99@AcuMS.aculab.com>
In-Reply-To: <4c2d36375bd74d94a2e6ef5d2fa0df99@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Oct 2023 07:41:15 -1000
X-Gmail-Original-Message-ID: <CAHk-=whrytmsiaLS=rn==qrYw81y2Qiv6dAZxvGzwgX=dMFxng@mail.gmail.com>
Message-ID: <CAHk-=whrytmsiaLS=rn==qrYw81y2Qiv6dAZxvGzwgX=dMFxng@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] math.h: add DIV_ROUND_UP_NO_OVERFLOW
To:     David Laight <David.Laight@aculab.com>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "kernel@collabora.com" <kernel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2023 at 22:38, David Laight <David.Laight@aculab.com> wrote:
>
> From: Linus Torvalds
> > >  - we can't even use a statement expression and __auto_type, because
> > > these things are used in type definitions etc and need to be constant
> > > expressions
>
> Doesn't min() get around that by using is_constexpr() and
> __builtin_choose_exptr() - the same could be done here.

Nope. I wanted to do it that way - it would have made things much
simpler and avoid the whole _Generic() thing, but try it - you cannot
use statement expressions in a non-function context even with
__builtin_choose_expr().

And no, min/max have never been usable in that context

                 Linus
