Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3D978BC64
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 03:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234894AbjH2BjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 21:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbjH2Bif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 21:38:35 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4064184
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:38:32 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6bcade59b24so2942158a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 18:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693273112; x=1693877912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Gk1xvLyQk1UDx0pGc3vIn7255Nmy8esIc+EjehFuOA=;
        b=szzU/RVw0Gdt+fIvNIpFY0UGLOx5BW87LTO7TlI2Zo9H1imnSUS9ReLLnRrzdBbVd3
         YVdyPa3ZwolJ0WRiW7hZD1cqCYJ5dPBAq4nn+CZRFUveeIuiTBx/JTBDsE3pkapdhxvk
         m/PnMwrKT3AXkSeHqWsKKN3apMtN4fdzH4OofRkjXMxnuYISJ3BqvGwyS1fUtZDxcHRm
         SlUcHtGGV3zyuA0DvGgD8hkWyYS4BD2fv7utYASzvfu+0LmwVK0yjlipmRuVT8BSXUat
         kXQuLRGKVma/xTbTxzrv7Ih06hkM+1HT6GAtOCFVPD9IY6I7QI6WPCg9NptZvuuaT7ZJ
         rltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693273112; x=1693877912;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Gk1xvLyQk1UDx0pGc3vIn7255Nmy8esIc+EjehFuOA=;
        b=GzSq0gG73PJ1Zd2VBIQoxCaIfCwH0+XzKbzgbcVipzdKsL93aRTg91CT4guVYxfEiY
         CuyOG2dEdxmajHXjRaVt71rJV0/lIlXiqOqVwmo83P6aLff4laUKZMJyg80JOHsJeDjr
         0JWzx/0lQKzeJ/+pUm7XHiZ/kcht5njDrTV3BV9VNsSKM64fWekFPf8mKMOtN8bIJ+QT
         G8QDaYDSQy1137i+YItxa4tpKuIe7nhmCfLsU1VYYyFukPrxuEHENr1UJ+8HSnk5cKb1
         wPaxtyb6BGbgFSNxG+lVS+1CHyCOm8gq87nbe69Y8mpwMqbU/tg40ibsILmdAdaPxOhO
         uVRg==
X-Gm-Message-State: AOJu0YzbvaD9uxBc8rQuothOIdhTtaJJCK8xqxTICwuDBL1aZVOWTu4u
        8q7pBOFJVqH+gRF6Zso70iq2MT9tAhA=
X-Google-Smtp-Source: AGHT+IG7omVwtEX2aaTO/BYBFJp/Ge70tkpitRNVW6bS+5l0sJY1RJYYJ6yIlXrKqxkPSPZ0VPpfyA==
X-Received: by 2002:a05:6830:11c5:b0:6bc:f999:a544 with SMTP id v5-20020a05683011c500b006bcf999a544mr15987414otq.15.1693273111885;
        Mon, 28 Aug 2023 18:38:31 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id c2-20020a639602000000b0056c52d25771sm7838699pge.69.2023.08.28.18.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 18:38:31 -0700 (PDT)
Date:   Mon, 28 Aug 2023 18:36:18 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v3 3/8] bitmap: fix opencoded bitmap_allocate_region()
Message-ID: <ZO1Lkhh3cjpYf1hm@yury-ThinkPad>
References: <20230815233628.45016-1-yury.norov@gmail.com>
 <20230815233628.45016-4-yury.norov@gmail.com>
 <ZN3sMzYHxQyvrKMJ@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN3sMzYHxQyvrKMJ@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:45:23PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 15, 2023 at 04:36:23PM -0700, Yury Norov wrote:
> > bitmap_find_region() opencodes bitmap_allocate_region(). Fix it.
> 
> ...
> 
> >  	for (pos = 0; (end = pos + BIT(order)) <= bits; pos = end) {
> > -		if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
> > -			continue;
> > -		__reg_op(bitmap, pos, order, REG_OP_ALLOC);
> > -		return pos;
> > +		if (!bitmap_allocate_region(bitmap, pos, order))
> > +			return pos;
> 
> You can also leave more code untouched, by replacing only first conditional
> with
> 
> 		if (bitmap_allocate_region(bitmap, pos, order))
> 			continue;
> 		return pos;

This looks weird, and doesn't help preserving history because the
following patch moves everything from c-file to the header. I'd prefer
to keep this as is.

> 
> >  	}
> >  	return -ENOMEM;
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
