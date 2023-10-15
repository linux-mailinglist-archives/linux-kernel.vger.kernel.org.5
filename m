Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FB57C97AC
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 04:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbjJOCce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 22:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbjJOCcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 22:32:32 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EFCD8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 19:32:31 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9ac43d3b71so3379590276.0
        for <linux-kernel@vger.kernel.org>; Sat, 14 Oct 2023 19:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697337150; x=1697941950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BARTmOCqxXmHFs7/pH7nQljcGTXtCWRURfFlQb+2N3o=;
        b=eHkMzwe65Mhjo4N90YgpgvNw1rqUOE0awZhswkFdv7kFogb6dFHJoFk9kCFcVB0GeG
         4L5fQfxQsE8in55rYghr+bdIVNCUYwgyNrjrg+fPAUjIdRK9sBGHkiCSbJfFlTOR4hWH
         M/keKb07Kn7/kMrgYXw0pYFONXZLn5PrkrpdQfDSPKr8j9r83Zr0tEzc9mJ8+mQ9Baia
         OTLSNLCRV7xxth3jwXezoYOcq3cilaf8ky2sQKUlSK+wkDFRRhVGzrzEQf0BO70LqsbR
         VcqyEJchURxqC5bTWj5Q8NsbNlYJkpgXbCj47cP2yf1JJ8w6NDPL9BrajZvrHzIj/x8z
         8Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697337150; x=1697941950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BARTmOCqxXmHFs7/pH7nQljcGTXtCWRURfFlQb+2N3o=;
        b=BD5hVhGYsI1BayCTwnINTXw0DDRoHyERx4v24/blNfc0Pw4eRmKeew6zEvyOifXGQ1
         kxLvbAZ/e2YaMknY28M2pjv9WWrKuiEHknNbWJK+iaQC1gFBfveVd0Tzek7iLhgEDShh
         aWeAYNT9uQibcOowAhkdZ6Z1aJ0NlYfsU2A/ad643PjMUsxtVfEq2xAEFjTzJ3ZbhBSR
         Od4XqTc7oSOKUf1cMfmSdkyArFWLeMMZO8dMLbADsnE3Sd1WQFaUxuGCKoWim9AfA6mz
         rS4Cx7BjaYDH+F9q8LodlBWX4gJ2eev42BpaRcnWCBvdhqVRt3vsDaJTXA46I1+wAn+z
         rT5A==
X-Gm-Message-State: AOJu0YwLFvNbyV346JW3uiYOVddfr0BHCbtA63xJao+eZ8TA8calTLOt
        Wb/O4tABpYtfv6yKL6CjSvqEofFvV88qXg==
X-Google-Smtp-Source: AGHT+IFwPvo7WG07rxkS9hryZQaonVFS8hwMNVeLsgecXoIyHICDK4ajblXogTBugxzY/MmC2ByZZg==
X-Received: by 2002:a25:9387:0:b0:d9a:5dcc:dbf7 with SMTP id a7-20020a259387000000b00d9a5dccdbf7mr13290918ybm.47.1697337150126;
        Sat, 14 Oct 2023 19:32:30 -0700 (PDT)
Received: from localhost ([2607:fb90:3e2c:8023:e145:ae9d:cf98:1574])
        by smtp.gmail.com with ESMTPSA id e77-20020a256950000000b00d72176bdc5csm1603244ybc.40.2023.10.14.19.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 19:32:29 -0700 (PDT)
Date:   Sat, 14 Oct 2023 19:32:28 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        James Seo <james@equiv.tech>, Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Marco Elver <elver@google.com>,
        Mark Brown <broonie@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Rae Moar <rmoar@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] lib: unload lib/bitmap.c
Message-ID: <ZStPPLG7F9V+E7JA@yury-ThinkPad>
References: <20231007233510.2097166-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007233510.2097166-1-yury.norov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 04:35:08PM -0700, Yury Norov wrote:
> The file is intended to hold functions to operate on bit arrays, but
> this days, more than 1/3 of bitmap.c is helpers for bitmap-to-string
> converters, plus some wrappers for device.h.
> 
> So move those out of lib/bitmap.c in sake of readability and
> maintainability.
> 
> Functionally, this series is a no-op.
> 
> Yury Norov (2):
>   lib/bitmap: move bitmap allocators for device to linux/device.h
>   lib/bitmap: split-out string-related operations to a separate files

OK, then if no objections, I drop #1 as a controversial, and pull #2
into bitmap-for-next.
