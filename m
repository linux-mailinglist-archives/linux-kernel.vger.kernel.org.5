Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4183765B45
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjG0SQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjG0SQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:16:47 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9359730C0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:16:43 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b9e9765f2cso7821595ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1690481803; x=1691086603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o00id9m2n9F2JxQUYUpGzNJ9QgKEFf3N9Px7sXVdTR0=;
        b=EffzG1vIl3ASGGvDRHFKHvGIUQrQybW6zVP63RMpRqlZB7dYIG7bbnAaTMpNHY14si
         7Mk/a/fd+eDvflLEMmxBw2ETIzwwSEBLtfurDlo4Ve5dQU7OK6GVtYWmqiSPFOwKVSnb
         sfv3VzKvaVtzSNtX7DhVOBe6BWapLI/94HOS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690481803; x=1691086603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o00id9m2n9F2JxQUYUpGzNJ9QgKEFf3N9Px7sXVdTR0=;
        b=QXs9D2LtvIu0qBKs56RW6ncu4w8n50y1lUa6YFjLVBFdb+2KRmffJ9p94x3H4RnlcF
         Y5v2qWqChnmgr99OnZ4rdKeGwYM9/qzNu7wQV90Uw0ugl8+0GgSi5XRlW54VOTsu9iMz
         TBcYp30waJKrbXDwgbw8mSi0UH8TE+p7bmQK4YOaWnbTW9+KcDrKoxpu5o7rNaqONQQd
         c4sutqJ7B9pjfksCP3k4jOowwtgmKADE5YHfgLE7qd8GdDicIK9lOhNGkD9WdcDDjZtg
         yScUcnF7tDStzF2kYzMLZGrlc0MpP7BPuF/HEuKxxEASxE6R0dNLMAQg/1PbaR+1ox71
         JsPg==
X-Gm-Message-State: ABy/qLZ6JSp5l2s4nQ2DQyhR7Tmm+STo6I10amhqaKyJmGoxqytDNyEn
        fxrzlQd97T8FQM//tLRPk5NImw==
X-Google-Smtp-Source: APBJJlHJ4j8cWXZ1lYYOF6yJUHcaLLzFlkEdmLP3emB4hza9OKGIZtS08iGc76V6KXoIwdelwwon0Q==
X-Received: by 2002:a17:902:ce88:b0:1b9:ea60:cd8a with SMTP id f8-20020a170902ce8800b001b9ea60cd8amr101108plg.50.1690481803039;
        Thu, 27 Jul 2023 11:16:43 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id v5-20020a170902b7c500b001bbb8d5166bsm1950665plz.123.2023.07.27.11.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 11:16:42 -0700 (PDT)
Date:   Thu, 27 Jul 2023 11:16:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v3 2/4] iio: core: Add opaque_struct_size() helper and
 use it
Message-ID: <202307271114.2B9B07C@keescook>
References: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
 <20230724110204.46285-3-andriy.shevchenko@linux.intel.com>
 <ZL5cXHAM/y1eg42D@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZL5cXHAM/y1eg42D@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 02:11:24PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 24, 2023 at 02:02:02PM +0300, Andy Shevchenko wrote:
> > Introduce opaque_struct_size() helper, which may be moved
> > to overflow.h in the future, and use it in the IIO core.
> > 
> > Potential users could be (among possible others):
> > 
> > 	__spi_alloc_controller() in drivers/spi/spi.c
> > 	alloc_netdev_mqs in net/core/dev.c

Can you include the specific replacement you're thinking for these? It's
almost clear to me, but I'm trying to understand the benefit over what's
already there.

> 
> ...
> 
> > +#define opaque_struct_size(p, a, s)	size_add(ALIGN(sizeof(*(p)), (a)), (s))
> 
> This actually might need something like __safe_aling() which takes care about
> possible overflow.
> 
> Whatever, I want to hear Kees on this.

i.e. if "a" were huge? What would sanity-checking of "a" look like in
this case? I'm not really sure how to handle a pathological alignment
request, but I'd agree it'd be nice to handle it. :)

-Kees

-- 
Kees Cook
