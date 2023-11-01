Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515997DE70C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346375AbjKAUUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjKAUUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:20:24 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDCBC1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:20:21 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d9c7bba32beso173913276.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 13:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1698870021; x=1699474821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOihp0zXHeWm/nSnAGD46PQYVKeGVpfsma9ThAS7/fM=;
        b=owzGiz5X2hbiAono6gLF86oV0nRuOqqpEO15BvvhPGUWBubT5n5oPmdKfwNkWMN8vC
         GIZudJU6i9qrzyohD1kQOu6bhMSlaSS4b2LU3bFq9BrmGhbjhpqemscXGfl9FV5W8ghF
         IZjBJiNgrFKP/dbOOlb6UdV6zGcp5HdEArOdLYAN3joCOJy3db2S+fFpO8ndl52hDSvN
         gLJtwa5xn7P2festAVTVrGtbwYxMK8HnKGaCZ0T1ezSqnJ1ET3oo+QKGckXanhmd74uZ
         xBbg+ys62ea6/LLpAYGFi3B5GppDDxbCQZJMdNh0eSJfzHhoq/nNV9wFXZA9125apZVF
         RKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698870021; x=1699474821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOihp0zXHeWm/nSnAGD46PQYVKeGVpfsma9ThAS7/fM=;
        b=B16Gilsst5bXXulCdINxWAFsYEz32lWSisHRkJcrHP0skEKSr0EWsrylTDr/tmze1A
         QEK8f6/KAfPJ8TsCfisodiNhhVhci+7tVNs3pvsiKybUh+nWwPjFvKou6ubVhjofw7Bj
         sEAXc6ILtDN6O+bBjJhHuekQvay8H44yBk1fhiLRyamkhVRXRi0c75oYUe9NiPUfhr+Z
         9MvHdK3jRO+zMcknopKQoVlkL1Rn+FL780M8ulUYOKPvJLupUHZ52S8KHxwav/MWwn0F
         yhLcwipk6FzjqO9yrDe/R41g9vWxWwgxRq7FOui4/H5uzcP8m9BIH2gpyZkQOOvKggQf
         x7tA==
X-Gm-Message-State: AOJu0Yy9FRJ3DMmehgYMP+X09iPWCEL3Fnqft+PdWIb/XHfPhNyhfA7n
        j+aPL+BxWX7ac2KXbG27wTFqnQ==
X-Google-Smtp-Source: AGHT+IGfcei5zZrxTrafEEem8XgcvmWSIU+nZw6wSP5Juc/xfuc6SOZjFpQ4zHtoqxszA8ZSbbQlqA==
X-Received: by 2002:a25:2684:0:b0:da0:3924:3c9b with SMTP id m126-20020a252684000000b00da039243c9bmr18010960ybm.23.1698870020683;
        Wed, 01 Nov 2023 13:20:20 -0700 (PDT)
Received: from dell-precision-5540 ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id x16-20020ae9e910000000b00770f3e5618esm1744928qkf.101.2023.11.01.13.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 13:20:19 -0700 (PDT)
Date:   Wed, 1 Nov 2023 16:20:08 -0400
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ben Whitten <ben.whitten@gmail.com>
Subject: Re: [PATCH] regmap: prevent noinc writes from clobbering cache
Message-ID: <ZUKy-ETSbM7yNvNK@dell-precision-5540>
References: <20231101142926.2722603-2-ben.wolsieffer@hefring.com>
 <b0e8c9f5-7aff-4adc-b5bc-d61c6107c07f@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0e8c9f5-7aff-4adc-b5bc-d61c6107c07f@sirena.org.uk>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Nov 01, 2023 at 05:05:39PM +0000, Mark Brown wrote:
> On Wed, Nov 01, 2023 at 10:29:27AM -0400, Ben Wolsieffer wrote:
> > Currently, noinc writes are cached as if they were standard incrementing
> > writes, overwriting unrelated register values in the cache. Instead, we
> > want to cache the last value written to the register, as is done in the
> > accelerated noinc handler (regmap_noinc_readwrite).
> 
> Could you please add a kunit test for this?

I started to look into this, but it is not currently possible to test
noinc behavior with regmap_[raw_]ram. The same bulk write operation is
used by both incrementing and non-incrementing writes, and the difference
in behavior is due to how the hardware handles the bulk write to a
particular register.

To test this behavior, regmap_raw_ram (raw because it supports bulk
writes) would have to be told that certain of its registers should
implement noinc semantics.

Is this something I should implement?

Thanks, Ben
