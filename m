Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6441077C255
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232848AbjHNVVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232849AbjHNVVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:21:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B09FE65
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:21:04 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1bc0d39b52cso29247835ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692048063; x=1692652863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TKt05EEMg3Rcx/T53g2GOp/3O7eMZHA3B2gge5/oHMQ=;
        b=ffVG/c/Uz1fJMDcJvQH20RgsYjzBW4nqH+6Bhn2+OBIjFRZOW3LzEM+kYYpCJE6U21
         EA/uN0fL3W70pRRAFfcCQKGs7xJWbiKlpPw6vpGQAepafXdoJkMJcAJSsoafS1TrJvyj
         8aC7ksH1EnBUZpTBSCNnIUuUhafAYHafnOe5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692048063; x=1692652863;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKt05EEMg3Rcx/T53g2GOp/3O7eMZHA3B2gge5/oHMQ=;
        b=aIGGHdLxZiFT8kP+YhfTXvVBYk7RO6io9mM5jwI60Nag2vCQX9KURTnGkOtaQskWW2
         gDY7TdSL8xjlPMHX7yM8NkMSbiyYOm8pCgsDfAnTGIgxim511pEHEzYRGO1E+1Ixs0xn
         LSHSmkpPN63Lv6lDzrQfr+JBM1Y8gcWQT6NXOLjm9HBttgGeC28WR0OiqNlvOH67CCL2
         63qyTDUUdg2/LUmR+a4EezKUx1ynICIsuk7b7oo4VnC9qwFuovn18SNfVHUTdq8CLirj
         pyb/MnKaZd19hWRWLX3S3IhpryUFkwanWpKoUHvJ3HK3aSMXdpmyE6bz5et7ujdS89sn
         G0bA==
X-Gm-Message-State: AOJu0YyixQK0GE2hGZNEmR5CtdS504UpdCnd51Je/ymBBNFZszoIkKV7
        2jn+1Y8Ata6MGvvNy4LexoGk+Q==
X-Google-Smtp-Source: AGHT+IFnPcI+QTY+11WBw5BA4VlM8K0fy4QjU2D6lstMH08xwMRz6/PBbWJ1Oi4PzuNJRgmUmLMXOA==
X-Received: by 2002:a17:902:b907:b0:1bb:1523:b2d7 with SMTP id bf7-20020a170902b90700b001bb1523b2d7mr9179919plb.14.1692048063563;
        Mon, 14 Aug 2023 14:21:03 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jc3-20020a17090325c300b001b86492d724sm9920974plb.223.2023.08.14.14.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 14:21:03 -0700 (PDT)
Date:   Mon, 14 Aug 2023 14:21:02 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH next v3 0/5] minmax: Relax type checks in min() and max().
Message-ID: <202308141416.89AC5C2@keescook>
References: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01e3e09005e9434b8f558a893a47c053@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 04, 2023 at 10:50:59AM +0000, David Laight wrote:
> [...]
> I also suspect that many of the min_t(u16, ...) are actually wrong.
> For example copy_data() in printk_ringbuffer.c contains:
>         data_size = min_t(u16, buf_size, len);
> Here buf_size is 'unsigned int' and len 'u16', pass a 64k buffer
> (can you prove that doesn't happen?) and no data is returned.

Stars aligning... this exact bug (as you saw in the other thread[1]) got
hit. And in the analysis, I came to the same conclusion: min_t() is a
serious foot-gun, and we should be able to make min() Just Work in the
most common situations.

It seems like the existing type_max/type_min macros could be used to
figure out that the args are safe to appropriately automatically cast,
etc. e.g. type_max(u16) <= type_max(unsigned int) && type_min(u16) >=
type_min(unsigned int) ...

-Kees

[1] https://lore.kernel.org/all/20230811054528.never.165-kees@kernel.org/

-- 
Kees Cook
