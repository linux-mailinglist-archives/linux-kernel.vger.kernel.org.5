Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8398F81251A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 03:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442971AbjLNCPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 21:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjLNCPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 21:15:13 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A0CE3;
        Wed, 13 Dec 2023 18:15:20 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-28a5d0ebf1fso134941a91.0;
        Wed, 13 Dec 2023 18:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702520119; x=1703124919; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KYkhYurevqXmt9TKAHgTIcFGz3zu27+21cyUYElhhEw=;
        b=YHhJhvtCfCiYewBcC5dko4tCmxEOx8ZjAPhHYNUIp6v5bETwmk5JwkEP/J1isaDLIC
         3hsIZKd4s8JAJpVTtGFzzTmf7Po73vPWFUkQ9FzjT9xOB0gP0oXjyO5xfCk/hcz+ku0+
         T6PQCCPvBXd1uYuVZhEm4vkhlEQSF8vfiGHY2DIhTtmbx7TndJQkZfnHRorbBvCDkovz
         iKo2KydInvZ0kV5t+AEB93V6T4OZgk3BjvsDuGz9EP4LM5MhM2qINoy2S/A2hYZemkRi
         5KVyUss/gGc5PhH9Ei/40z+AlQvfKSsqs3zKhc7sMlCLjqu08s3nz4Q4MeFw9IczkCoE
         oMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702520119; x=1703124919;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYkhYurevqXmt9TKAHgTIcFGz3zu27+21cyUYElhhEw=;
        b=tpekKim8uwsHtE1sz2moRDJDvsgcbuK1gMW7uNRPdrNP5hO4YxLiiO5xYdruU22F/G
         /V7H07k3sINQXvW3OW+h/RfphJgXMZcbSnONMbrxywfM6T3J+xD3IXOxr1Wlkntr0auq
         KeMHmlVXCLkPE+5zTseI9QR7SFhpxjC2iuMl0b3QjZFqpYIWKdx2tunHR2G4xPO+kELV
         xYRYh0yOaWU4Yz35dEzSPYtCn/tpgfLejGai7HHxyA4GC2OIWhtKgj4+vlhqXIxGS3wz
         vy3FBYJwf0c5BdVnnIxwr0juhupHekiy1PBr4YJAXGVEcE6s72/utKxh/+8cw2f77sCq
         h7lQ==
X-Gm-Message-State: AOJu0Yz4Z+CWfvB4CQIlS9WhV6TTBvNSwCXhnalkz/RYYY7j/cH0L7lY
        rjhP6+Yd3zji4xHWDmJ6mTHGcUqWqxA=
X-Google-Smtp-Source: AGHT+IGgQLKEM+SDc4lV7vweA3Cby2sQ8pA8d7Ih53Gnr2B7wADuw9ek0w/VeXS4v9PwC4VK2zkgsw==
X-Received: by 2002:a17:90b:33cb:b0:286:7529:3598 with SMTP id lk11-20020a17090b33cb00b0028675293598mr11322651pjb.13.1702520119225;
        Wed, 13 Dec 2023 18:15:19 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id d8-20020a17090ab30800b0028591079e6fsm13203507pjr.24.2023.12.13.18.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 18:15:18 -0800 (PST)
Date:   Thu, 14 Dec 2023 10:15:13 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH 1/4] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZXplMThBSD53UV0s@rigel>
References: <ZXm3rayrcvfO1t1Z@smile.fi.intel.com>
 <ZXm_WsIpgIyOUNHt@rigel>
 <CAMRc=Mfri8K4ZqcHb_eQY6gi+q_-uBZc2wiMrrb-+a7Tric3FA@mail.gmail.com>
 <ZXnU3tMYCc2Rw8Qv@rigel>
 <ZXnX8jPHxRLW8lhi@smile.fi.intel.com>
 <CAMRc=Mfj_4YvQVP=UWkULBwJniDDjapttU+qSgqfN5ZWNgikKw@mail.gmail.com>
 <ZXnb-ks_noYLWZZ2@smile.fi.intel.com>
 <CAMRc=MfaHKKKNkXW0L1FPjCH4VvG22Vn9q8z9tupZCtCEKZU2g@mail.gmail.com>
 <ZXoO8B0N3S49GnvX@smile.fi.intel.com>
 <ZXpJueTnmtUIecCd@rigel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXpJueTnmtUIecCd@rigel>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 08:18:01AM +0800, Kent Gibson wrote:
> On Wed, Dec 13, 2023 at 10:07:12PM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 13, 2023 at 08:03:44PM +0100, Bartosz Golaszewski wrote:
> >
> > ...
> >
> > > > - it adds complications for no benefit
>
> It provides a placeholder for collective documentation and clarifies
> scope for the reader.

Turns out kernel-doc can't deal with a struct variable declaration - it
needs the struct to be named.

So this doesn't parse:

static struct {
	struct rb_root tree;
	spinlock_t lock;
} supinfo;

but this does:

static struct supinfo {
	struct rb_root tree;
	spinlock_t lock;
} supinfo;

at which point I prefer the separate struct and var declarations as per
the patch.

Opinions?

Cheers,
Kent.

