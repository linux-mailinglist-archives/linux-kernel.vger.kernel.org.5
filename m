Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F588135EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjLNQOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:14:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjLNQOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:14:40 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C27E8;
        Thu, 14 Dec 2023 08:14:46 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d37a6926f7so1843055ad.3;
        Thu, 14 Dec 2023 08:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702570486; x=1703175286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ren91EB9Lk+40jzwODpGvvvWMNi0QOKNAMntVYGkGks=;
        b=LYZ9yyGI5/O6134+RaTEfcY3rpurNmo9UWPTn1nf7ke3yaYVSA5m+eEGbcWLXIcHa+
         W8MuCnZMGxYnWZKrStjeL57XUA/LjdWQeaYbil9+ydNe0CqzY4aOuLRo/E9LBn104fUt
         CogVzlvsdmeqZ7cO/nWqYcvmx+kz7Pv92kTU7axozpOcX0AD67DJIK6FVCrGtvJaxM3o
         aiDUnnMgv1487V9S58D+tUv6ifrksWPWUKRSXaqFx2o7jLGkqow4B4A1aVMV/bCTUbR5
         Nv/N/yvJtc9cZeePOYqjr4bjb09tYZBGQfudlez5zLKfXiRiTmYGSY3ifMJv7gkBu0R9
         76wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702570486; x=1703175286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ren91EB9Lk+40jzwODpGvvvWMNi0QOKNAMntVYGkGks=;
        b=Be8+IRQYBSmj12WOJTHw1Ac0yWP84CUs92pT3xALWr7PPHW6aynjw6e605PTeAQvjH
         uLG2172lM3YmVGgcw1DGai4Mc6+OMm7766R53owJubjxCxJMQ8ed3UOUGMnBM0At7w8r
         j/9CLQwn4WjNs5qwyzrZ4ZbXO3omDO31vxHSkxmz17CLAgXMPYQDiR8+9CeKSFtL6exP
         HMpiiYcK57yLeC5FfEy+oa+TkvtdtaYHati8j5yf2JYd+ow3L1X48Ui+bSQEW0GzcsRk
         zzSKbCIZoecRUvp3Y6S95cqYr0+mhrxYNOf6vQWCPusA1SmFtSzcyaHLK2SQvnQLzABX
         8O/A==
X-Gm-Message-State: AOJu0Yzk7z2hnCMcgQt2v80FeuPEcDAEDYCetpqSiDAQaWf+qKZqsl1U
        BZMDIOSvEvpgxKnz2oAauwU=
X-Google-Smtp-Source: AGHT+IEEvjksM+ciHK7Jxy5B51QteYGpk+B4xz9dctLrrUi1I6oQB8FANtdvlyC47FWJUjvxUq2vZg==
X-Received: by 2002:a17:902:e54a:b0:1d0:6ffe:1e8b with SMTP id n10-20020a170902e54a00b001d06ffe1e8bmr6740695plf.110.1702570486156;
        Thu, 14 Dec 2023 08:14:46 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090a734800b0028ae9cb6ce0sm3444773pjs.6.2023.12.14.08.14.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:14:45 -0800 (PST)
Date:   Fri, 15 Dec 2023 00:14:41 +0800
From:   Kent Gibson <warthog618@gmail.com>
To:     Andy Shevchenko <andy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Subject: Re: [PATCH v2 2/5] gpiolib: cdev: relocate debounce_period_us from
 struct gpio_desc
Message-ID: <ZXsp8QjxsUMPlZIR@rigel>
References: <20231214095814.132400-1-warthog618@gmail.com>
 <20231214095814.132400-3-warthog618@gmail.com>
 <ZXsZJ9z7iln8uMf8@smile.fi.intel.com>
 <ZXsajZoQRw7HgHl1@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXsajZoQRw7HgHl1@smile.fi.intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 05:09:01PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 14, 2023 at 05:03:03PM +0200, Andy Shevchenko wrote:
> > On Thu, Dec 14, 2023 at 05:58:11PM +0800, Kent Gibson wrote:
>
> ...
>
> > > +/*
> > > + * Used to populate gpio_v2_line_info with cdev specific fields not contained
> > > + * in the struct gpio_desc.
> > > + * A line is determined to contain supplemental information by
> > > + * line_is_supplemental().
> > > + */
> > > +static struct {
> > > +	/* a rbtree of the struct lines containing the supplemental info */
> > > +	struct rb_root tree;
> > > +	/* covers tree */
> > > +	spinlock_t lock;
> > > +} supinfo;
>
> Hmm... If I read the kernel-doc script it should support anonymous structs
> and unions...
>
> ...
>
> > > +static void supinfo_init(void)
> > > +{
> > > +	supinfo.tree = RB_ROOT;
> > > +	spin_lock_init(&supinfo.lock);
> > > +}
> >
> > Can it be done statically?
> >
> > supinfo = {
> > 	.tree = RB_ROOT,
> > 	.lock = __SPIN_LOCK_UNLOCKED(supinfo.lock),
>
> I even checked the current tree, we have 32 users of this pattern in drivers/.
>

Ah, that is what you meant.  Yeah sure can - the supinfo_init() is
another hangover from when I was trying to create the supinfo per chip,
but now it is a global a static initialiser makes sense.

And I still haven't received the email you quote there.

Cheers,
Kent.

