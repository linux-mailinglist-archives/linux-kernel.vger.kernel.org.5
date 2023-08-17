Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D48C77F8B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351825AbjHQOWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351822AbjHQOWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:22:03 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76EE32D76
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:22:02 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76d8598d023so10511985a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692282121; x=1692886921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x2HbRirAdfxX4HP6fJvIL3SaqJoHj7gskE9QoxF41Uk=;
        b=amv9eBm6Bx1mRUOUq3DyrW18WD9fiKG2ReegxgxQVG6i5v97vPeBP2IHf6wXutZHih
         ZvamWNcB6Jy7mirjwFhhVOTcbrIyer+vYx/qUWN4nYzmctnsy3xW4tGAwLDHIhvgR5bT
         1A5Mj0+BJQ2ZfU/NmgcDgYOWE27lfHSaxlNH9kIGrHYUjLd1ZcXC/cCPyYPCxKIqPyhT
         s7QWSLtlqWOMAr50dRbo74/BR34BLb0AwxgzPZseGbAPtibWISEwwTUeqrW82/hz4Rfo
         QooWT241aDNzj8eIRqlb7FkmYreRrBkcz9HlP01vjXCR0ZoUALBLwVTyY/112bmu30MR
         L5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692282121; x=1692886921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2HbRirAdfxX4HP6fJvIL3SaqJoHj7gskE9QoxF41Uk=;
        b=PU1WCDkpEpaOcf0cHUAgFGtSyPwmkRc11eKyZW0+1IbJ38MFqOH6G4XA5yo5ETX4a0
         IC/s8OSJaKl1uCvGlkYyJv1ZECIMXfBMBOeHTjz+HYn0RTGQo5XilyOhSilcM/ZNqZQ7
         Rv5jiqz21aQ9ZbOwxRNZVPI/dtdsdvUy8pfFBrzCyH3VAuTs2Q7JZsQOmvcI6vMlT2YD
         LDcCUKQjbisxVtQUJBEGEiGSbMrU8Wg2XVcbXow9qsup0hdIi+e7VdA+bxEOQfwwUjJ+
         4lF+u0jYytun5QrRlKwJz3zZrUPYNbYdunJnZlNjYkdNIMHRPo5KEGdhF04UhQi3R/FE
         DXAA==
X-Gm-Message-State: AOJu0YxIu9R6rYUn9yNphzz0S42Td0YVc7iqL6gTFI5R6oYDTCLopqyd
        6xpxUJ2+w9ctOV1e+Gz28k6yffypicU=
X-Google-Smtp-Source: AGHT+IHtzj/QgpqMg0R8cVt/4zhUUo7JSaYm4GBM8G4FUY07K+eQRIXkl5AOz2/zvmabD0mXvEaAqw==
X-Received: by 2002:a05:620a:c55:b0:767:1af0:e82f with SMTP id u21-20020a05620a0c5500b007671af0e82fmr5531783qki.76.1692282121423;
        Thu, 17 Aug 2023 07:22:01 -0700 (PDT)
Received: from localhost (72-0-147-214.static.firstlight.net. [72.0.147.214])
        by smtp.gmail.com with ESMTPSA id t27-20020a05620a035b00b007678973eaa1sm5211904qkm.127.2023.08.17.07.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 07:22:01 -0700 (PDT)
Date:   Thu, 17 Aug 2023 07:21:59 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] bitmap: optimize bitmap_remap()
Message-ID: <ZN4tB7jkQrX/TKnh@yury-ThinkPad>
References: <20230815235934.47782-1-yury.norov@gmail.com>
 <ZN3qQPeFtdZQrLE4@smile.fi.intel.com>
 <ZN3qlCd+TcYiZg+s@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN3qlCd+TcYiZg+s@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 12:38:28PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 17, 2023 at 12:37:05PM +0300, Andy Shevchenko wrote:
> > On Tue, Aug 15, 2023 at 04:59:34PM -0700, Yury Norov wrote:
> 
> ...
> 
> > >  		int n = bitmap_pos_to_ord(old, oldbit, nbits);
> > >  
> > > +		bit = (n < 0) ? oldbit :	/* identity map */
> > 
> > Can't you also optimize this case?
> > 
> > Something like
> > 
> >   bitmap_xor(tmp, old, new) // maybe even better approach, dunno
> 
> >   bitmap_empty(tmp) // can be replaced by find first bit
> 
> Or reuse bitmap_weight()...

That way it wouldn't work, but I think something like this would:

         if (dst == src)         /* following doesn't handle inplace remaps */
                 return;

         w = bitmap_weight(new, nbits);
         if (w == 0) {
                 bitmap_copy(dst, src, nbits);
                 return;
         }

         /* Identity part */
         bitmap_andnot(dst, src, old, nbits);
         for_each_and_bit(oldbit, src, old, nbits) {
                 int n = bitmap_weight(old, oldbit);
                 __set_bit(find_nth_bit(new, nbits, n % w), dst);
         }

And it needs bitmap_weight_from() and find_nth_bit_from() to avoid
Schlemiel the Painter's problem.

You're right. This has a room for more optimizations. Thanks for
discussion. Need to give it a run.

Thanks,
Yury
