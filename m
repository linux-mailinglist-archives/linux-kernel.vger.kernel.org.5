Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0D97AFA40
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjI0Fpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjI0Fo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:44:56 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61F17A95;
        Tue, 26 Sep 2023 19:10:35 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-7a803afa8c5so3543033241.0;
        Tue, 26 Sep 2023 19:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695780635; x=1696385435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WKL4SUlvuVnRixbAxC7CAkvo9/4L7BDjoTHiJWU8xO8=;
        b=GwtzGeDfBFzEsSHV6iGIRcIWldwrN9B4DMEhcjql4Rqizxm51/qVknW0hDWVqYvS/F
         kVaZlJ5I9Cr58DWhrG0aKzB1gsU7IUC5YVU+Pbn9HLI8pDoq+holdDkiouhg86NBFv1J
         Uh9H8C0Tp47Y/51HUAMPIuO0MmwM9Jx4qb4ij9RYuzmh7yzr0k3IJ2CIEMRYRSPrNWMG
         es32ey2uGge7QDtTmDHz2jIRUjX/rJGv5Gca9nh9DOAATG3QmBiJ27y+O+0QqcyGxQSI
         MqizjvatqOdgy5FfwTbZxG3GQVZcbC83b8OzI/7o5gJqKqKRR+eLIU8WliUDt79BpOPH
         86fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695780635; x=1696385435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKL4SUlvuVnRixbAxC7CAkvo9/4L7BDjoTHiJWU8xO8=;
        b=YmBU9OdfFUFFlwdS/ut1JkCocXmIrRus37YZit/IBkYWRIw4t8YMzxvYJH6k/dL15y
         s+yifciIhjedYBu9spaxdtAeVbQlzhhWUtFs8vUjUw+QwjMpJlevViYI18GPsAvxsI4j
         mjpUffKAnRKJS0zf6u1uh6pT+/tqgduyZuDB8tLYrUwaJpbIwK5p4ogQXvokh3al2lrg
         Ha3cJcCCwjz83Fc4y2g0/E9MQfq1LhgmFmwnFLryZ2vztAhcjqXeTPB4Rkj9r2lT3ysS
         SnyjGQcnW4rQgBneOfw4HNCoO3BfDcZhPBA+AVbERSpfl5Vh7StpoTSK3Tq5ML8m22FC
         ttdQ==
X-Gm-Message-State: AOJu0YysS5oFS3kgzF9IKRsyUz5w4vD+I2xjQWluJt1AjJqKEdmynZvD
        OnBUv0iI4ATkHeAnePGSdzE=
X-Google-Smtp-Source: AGHT+IHmdRYR7cdIAn645+suJYO7QlP7I9lThH4myZHlqL/SN4GDcg/vIpMfEu82+zwwo2bYF8JGHA==
X-Received: by 2002:a67:f50a:0:b0:44d:50f8:10 with SMTP id u10-20020a67f50a000000b0044d50f80010mr817363vsn.25.1695780634699;
        Tue, 26 Sep 2023 19:10:34 -0700 (PDT)
Received: from localhost ([2607:fb90:be31:4195:106f:1ded:e602:ed9b])
        by smtp.gmail.com with ESMTPSA id dm6-20020a056130130600b0048b7c4e8277sm1156945uab.15.2023.09.26.19.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 19:10:34 -0700 (PDT)
Date:   Tue, 26 Sep 2023 19:10:33 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Subject: Re: [PATCH v1 2/5] lib/bitmap: Introduce bitmap_scatter() and
 bitmap_gather() helpers
Message-ID: <ZROO9skQbYw1N9YP@yury-ThinkPad>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
 <20230926052007.3917389-3-andriy.shevchenko@linux.intel.com>
 <ZRN2adZZaGeqWNlY@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRN2adZZaGeqWNlY@yury-ThinkPad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +unsigned int bitmap_gather(unsigned long *dst, const unsigned long *src,
> > +			   const unsigned long *mask, unsigned int nbits)
> > +{
> > +	unsigned int bit;
> > +	int n = 0;
> > +
> > +	bitmap_zero(dst, nbits);
> > +
> > +	for_each_set_bit(bit, mask, nbits)
> > +		__assign_bit(n++, dst, test_bit(bit, src));
> > +
> > +	return n;
> > +}
> > +EXPORT_SYMBOL(bitmap_gather);

So, if mask is 0b01, and src is 0b10, the output will be 0b00.
To me it sounds like you've gathered nothing, while the intention
was to gather all source bits to bit #0. This is my understanding
of the word 'gather', and this is how bitmap_remap() works.

bitmap_remap() handles it by wrapping around 0:
        set_bit(find_nth_bit(new, nbits, n % w), dst);

In your case, it may look like:
        n = off = 0;
        while (1) {
                off += n;
                n = 0;
        	for_each_set_bit(bit, mask, nbits) {
                        if (bit + off >= nbits)
                                return;
        		__assign_bit(n++, dst, test_bit(bit + off, src));
                }
        }

(Not tested, except that on piece of paper.)

If you claim you're replacing bitmap_remap(), you should correctly handle
the above case; when src == dst; when mask is empty, and probably more...

Thanks,
Yury
