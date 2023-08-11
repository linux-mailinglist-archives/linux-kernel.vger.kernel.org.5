Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E932A77900A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjHKNCF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjHKNCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:02:04 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF316119
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:02:03 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-76d2ec308d4so111577985a.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691758922; x=1692363722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LrpyVfti+jukzlLae0pEPEpt6nczAtbta+h59z5fC/g=;
        b=jZTPrbexm1HyKngwO6UxoNvBfrSOYb2U57mokG1+ztzG7ZOuM1zPdp1a8IuVPgmmOd
         cmElPGrwamSWFeVYXAOhHqMmVmHY3HZ1vt1jcQ7seNMgnE2v3AH5nIPgVUaKc+xCbZYn
         heoRQmpaXmUSR8uANm116KkdpsFYeWoDg6s9n6s0aOOnph1UQbVayqy+33Ee+0aoWJWF
         WbaCH6enZ/OFcRoCv9xWPv413zYfpXhEeHFQvX8Ift6Dr8njeSfxHY4bje1sqmUe2Yir
         abDn2Ms1GcFBAQNyepEJuKgop3+1wHVq9InVxQKk0mFg4jGzDZwtOvdTKkjkTIZ+2Pau
         k/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691758922; x=1692363722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrpyVfti+jukzlLae0pEPEpt6nczAtbta+h59z5fC/g=;
        b=O5z4CAJQRbPytrKV+5yN7BVWgno8UwGOHahpe7n0Om8xLF0GV7vmkhHYtTvMfaJSPl
         h204Oogjbv2NskGV/p3ePUp16U+l4xTvp4mQmGAcvzI146njrjIzHLBxetRycuCYc9Cs
         mu9iXCK2VQyxU0LFvtZo+oRe5vPyCUlxT+CyBG8tGvKeQD4tRdF3E6TEotIuNj/TSxk5
         Qu5OcpBz+8ZtTT1C8YxPNTLjIMd/JGfdQN9gRNDlb3K7UmkbzBg6THJ17ncBw/uMx91C
         piYG0D7QQWCeZSxyFN39Py+2ivzRtZznDDplNvwvRiA6KvS19eB/s2QF9LUkGYj5EtJk
         EC5A==
X-Gm-Message-State: AOJu0YxCm4KhE6x9d7LpG3zpODHFyXa8/WnMs/CBo0J5kffpsHSjpnb0
        98JLtNlim9mjwohfPDvVK1BiruKWovc=
X-Google-Smtp-Source: AGHT+IFSgWfl4jw5YjPMlYenIVI/kd6/X1uPpqN8H+DfxrPNx1poZ3wLVy56X4eWu4uqido+HyjNrA==
X-Received: by 2002:a05:6214:4402:b0:62d:eaa8:27e4 with SMTP id oj2-20020a056214440200b0062deaa827e4mr1430166qvb.36.1691758922235;
        Fri, 11 Aug 2023 06:02:02 -0700 (PDT)
Received: from localhost (2603-7080-3d03-3cb9-d639-a70b-9607-2020.res6.spectrum.com. [2603:7080:3d03:3cb9:d639:a70b:9607:2020])
        by smtp.gmail.com with ESMTPSA id a26-20020a0ca99a000000b0063d2898f210sm1197362qvb.103.2023.08.11.06.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 06:02:01 -0700 (PDT)
Date:   Fri, 11 Aug 2023 06:01:58 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 2/6] bitmap: replace _reg_op(REG_OP_ALLOC) with
 bitmap_set()
Message-ID: <ZNYxRtjrxLFJRzyt@yury-ThinkPad>
References: <20230811005732.107718-1-yury.norov@gmail.com>
 <20230811005732.107718-3-yury.norov@gmail.com>
 <ZNX+bponlicM3AFL@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNX+bponlicM3AFL@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 12:25:02PM +0300, Andy Shevchenko wrote:
> On Thu, Aug 10, 2023 at 05:57:28PM -0700, Yury Norov wrote:
> > _reg_op(REG_OP_ALLOC) duplicates bitmap_set(). Fix it.
> 
> ...
> 
> >  int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
> >  {
> > +	unsigned int nbits = pos + BIT(order);
> 
> Shouldn't this be unsigned long?
> As the prototype of the used later unsigned long find_next_bit().

Linux doesn't support bitmaps longer than 2^32 bits. I really doubt
such huge bitmaps would ever exist, but if that will happen, too many
bitmap functions will have to be revisited.

For the reference, check the code of __reg_op(), which I remove in the
series - all indexes and offsets are int's there.

Thanks,
Yury
 
> >  	if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
> >  		return -EBUSY;
> > -	return __reg_op(bitmap, pos, order, REG_OP_ALLOC);
> > +	bitmap_set(bitmap, pos, nbits);
> > +	return 0;
> >  }
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
